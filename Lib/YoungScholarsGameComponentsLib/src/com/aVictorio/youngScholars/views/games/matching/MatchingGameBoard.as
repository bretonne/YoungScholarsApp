package com.aVictorio.youngScholars.views.games.matching
{
	import caurina.transitions.Tweener;
	
	import com.aVictorio.youngScholars.managers.ILocalable;
	import com.aVictorio.youngScholars.model.GameModel;
	import com.aVictorio.youngScholars.model.MatchingCardFactory;
	import com.aVictorio.youngScholars.views.games.matching.phone.MatchingGameBoardView_phone;
	import com.aVictorio.youngScholars.views.games.matching.renderers.FlashCardButton;
	import com.aVictorio.youngScholars.vos.CardDataVO;
	import com.aVictorio.youngScholars.vos.GameDescriptor;
	import com.renaun.mxml.QContainer;
	import com.renaun.qnx.ui.text.Label;
	import com.renaun.view.QView;
	
	import flash.errors.MemoryError;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	
	import mx.states.Transition;
	
	import qnx.ui.data.DataProvider;
	import qnx.ui.events.ListEvent;
	import qnx.ui.listClasses.TileList;
	
	public class MatchingGameBoard extends QContainer implements ILocalable
	{
		public static const NumberOfCards:int = 16;
		public static const TimerDelay:int = 500;
		public static const SecsMemoryCardShow:int = 1500;
		
		protected var _cards:DataProvider;
		
		protected var _gameSetIndex:int=-1;
		
		protected var cardModel:MatchingCardFactory = MatchingCardFactory.instance;
		
		protected var openedMemoryCardsQueue:Array;
		
		protected var memoryGameTimer:Timer;
		
		[Bindable]
		public var info:String;

		[Bindable]
		protected var gameOverLabel:Label;
		
		[Bindable]
		public var cardBoard:TileList;

		
		protected var lastSelected:FlashCardButton; 
		protected var cardsRemaining:int;
		
		protected var _dataChanged:Boolean = false;
		
		protected var _currentGame:GameDescriptor;
		
		public function MatchingGameBoard(s:Number=100, su:String="percent")
		{
			super(s, su);
		}
		
		[Bindable]
		public function get cards():DataProvider
		{
			return _cards;
		}
		
		public function set cards(value:DataProvider):void
		{
			_cards = value;
			invalidate();
		}
		
		
		[Bindable]
		public function get currentGame():GameDescriptor
		{
			return _currentGame;
		}
		
		public function set currentGame(value:GameDescriptor):void
		{
			_currentGame = value;
			_dataChanged = true;
			invalidate();
		}


		[Bindable]
		public function get gameSetIndex():int
		{
			return _gameSetIndex;
		}
		
		public function set gameSetIndex(value:int):void
		{
			_gameSetIndex = value;
			_dataChanged = true;
			invalidate();
		}
		
		protected function completeHandler(event:Event):void
		{
			//this.addEventListener("cardClicked", cardBoard_clickHandler, false, 0, true);
			this.addEventListener("gameOver", onGameOver, false, 0, true);
		}
		
		private function loadCards():DataProvider
		{
			if (gameOverLabel)
			{
				gameOverLabel.alpha = 0;
				gameOverLabel.visible = false;
				gameOverLabel.setPosition(this.width/2 - 100, this.height-80);
			}

			lastSelected = null;
			cardsRemaining = NumberOfCards;

			cardModel.shuffleCard(currentGame.gameType, NumberOfCards, GameModel.instance.currentGameSetIndex);
			return cardModel.cards;			
		}
		
		public function replayGame():void
		{
			cards = loadCards();
		}
		
		public function playGame(game:GameDescriptor):void
		{
			currentGame = game;
			cards = loadCards();
		}
		
		protected function cardBoard_clickHandler(event:ListEvent):void
		{
			var card:FlashCardButton = event.cell as FlashCardButton;

			if (gameSetIndex == GameModel.MatchingGames || gameSetIndex == GameModel.Languages)
			{
				if (lastSelected==null)
					lastSelected = card;
				else if (lastSelected != card && CardDataVO(lastSelected.data).matchingContent == CardDataVO(card.data).content)
				{
					Tweener.addTween(lastSelected, {x:-150, y:100, alpha:1, time:1, transition:"linear", delay:0, onComplete:handleCardMoveCompleted, onCompleteParams:[lastSelected]});
					Tweener.addTween(card, {x:-150, y:100, alpha:1, time:1, transition:"easeOutCubic", delay:0, onComplete:handleCardMoveCompleted, onCompleteParams:[card]});
					lastSelected = null;
					
					cardsRemaining -= 2;
				}
				else
				{
					lastSelected.selected = false;
					
					Tweener.addTween(card, {rotation:360, time:0.5, transition:"linear"});
					lastSelected = card;
				}
			}
			else if (gameSetIndex == GameModel.MemoryGames)
			{
				if (openedMemoryCardsQueue == null)
					openedMemoryCardsQueue = new Array();

				if (memoryGameTimer == null)
				{
					memoryGameTimer = new Timer(TimerDelay, 0);
					memoryGameTimer.addEventListener(TimerEvent.TIMER, onMemoryGameTimer, false, 0, true);
					memoryGameTimer.start();
				}

				if (lastSelected && lastSelected != card && CardDataVO(lastSelected.data).matchingContent == CardDataVO(card.data).content)
				{
					Tweener.addTween(lastSelected, {x:-150, y:100, alpha:1, time:1, transition:"linear", delay:0, onComplete:handleCardMoveCompleted, onCompleteParams:[lastSelected]});
					Tweener.addTween(card, {x:-150, y:100, alpha:1, time:1, transition:"easeOutCubic", delay:0, onComplete:handleCardMoveCompleted, onCompleteParams:[card]});
					lastSelected = null;
					
					cardsRemaining -= 2;
				}
				else
				{
					lastSelected = card;
					var object:Object = new Object();
					object.card = card;
					object.time = new Date();
					openedMemoryCardsQueue.push(object);
				}
			}
			if (cardsRemaining == 0)
			{//game over
				if (memoryGameTimer && memoryGameTimer.running)
				{
					memoryGameTimer.stop();
					memoryGameTimer.removeEventListener(TimerEvent.TIMER, onMemoryGameTimer, false);
					memoryGameTimer = null;
				}
				dispatchEvent(new Event("gameOver", true, true));
			}
		}
		
		protected function onMemoryGameTimer(event:TimerEvent):void
		{
			if (openedMemoryCardsQueue.length == 0)
				return;

			memoryGameTimer.stop();
			var cnt:int = Math.min(5, openedMemoryCardsQueue.length);
			var workingBuffer:Array = openedMemoryCardsQueue.slice(0, cnt);
			openedMemoryCardsQueue.splice(0, cnt);

			var card:FlashCardButton; 
			var openedTime:Date;
			var now:Date = new Date();

			for each (var obj:Object in workingBuffer)
			{
				card = obj.card as FlashCardButton;  
				openedTime = obj.time as Date;
				
				if ((now.time - openedTime.time)/SecsMemoryCardShow >=1)
				{
					card.selected = false; // setSelected(false); //turn the card
				}
				else
				{//put the card back to queue
					openedMemoryCardsQueue.push(obj);
				}
			}
			
			memoryGameTimer.start();
		}

		
		protected function onGameOver(event:Event):void
		{
			gameOverLabel.visible = true;
			gameOverLabel.text = GameModel.instance.GoodWorkPhrase;
			Tweener.addTween(gameOverLabel, {x:100, y:150, alpha:1, time:1.5, transition:"linear"});
			//Tweener.addTween(gameOverLabel, {rotation:360, time:1, transition:"linear", delay:2});
			
			cardBoard.selectedIndices = new Array();
		}
		
		protected function handleCardMoveCompleted(data:Object):void
		{
			//make sure to take the selected state off
			var renderer:FlashCardButton= data as FlashCardButton;
			renderer.selected = false;
		}
		
		public function onLocaleChanged():void
		{
			GameModel.instance.loadResources();
			replayGame();			
		}

	}
}