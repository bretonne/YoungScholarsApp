package com.aVictorio.youngScholars.model
{
	import com.aVictorio.youngScholars.managers.AppLocaleManager;
	import com.aVictorio.youngScholars.vos.CardDataVO;
	import com.aVictorio.youngScholars.vos.GameDescriptor;
	
	import mx.collections.ArrayCollection;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import qnx.ui.data.DataProvider;

	[Bindable]
	public class GameModel
	{
		public static const MatchingGames:int = 0;
		public static const MemoryGames:int = 1;
		public static const MathQuizs:int = 2;
		public static const Languages:int = 3;
		
		private static var _instance:GameModel;
		
		private var mathModel:MathQuizsFactory = MathQuizsFactory.instance;
		
		private var matchingModel:MatchingCardFactory = MatchingCardFactory.instance;
		
		private var resourceManager:IResourceManager = ResourceManager.getInstance();
		
		private var goodworkPhrases:Array;
		private var goodworkPhraseIndex:int = -1;
		
		protected var _currentGameSetIndex:int=-1;
		
		public var currentGameSet:Array;
		
		protected var _currentGameIndex:int=-1;
		
		public var currentGame:GameDescriptor;
		
		public var currentLocale:String="en_US";
		
		public static function get instance():GameModel
		{
			if (_instance == null)
				_instance = new GameModel;
			return _instance;
		}
		
		public function GameModel()
		{
			loadResources();
		}
		
		public function loadResources():void
		{
			goodworkPhrases = AppLocaleManager.loadLocaleData("resource", "goodworkFeedbacks");

			matchingModel.loadResources();
			mathModel.loadResources();
		}
		
		public function get currentGameSetIndex():int
		{
			return _currentGameSetIndex;
		}
		
		public function set currentGameSetIndex(value:int):void
		{
			_currentGameSetIndex = value;
			
			currentGameSet = getGameSet(_currentGameSetIndex);
			_currentGameIndex = 0;
			currentGame = getGame(0);
		}
		
		public function get currentGameIndex():int
		{
			return _currentGameIndex;
		}
		
		public function set currentGameIndex(value:int):void
		{
			_currentGameIndex = value;
			if (_currentGameIndex<0 || _currentGameIndex>=currentGameSet.length)
				_currentGameIndex = 0;
			currentGame = getGame(_currentGameIndex);
		}
		
		private function getGameSet(gameSetIndex:int):Array
		{
			var gameSet:Array;
			switch (gameSetIndex)
			{
				case MatchingGames:
					gameSet = matchingModel.MatchingGameSet;
					break;
				case MemoryGames:
					gameSet = matchingModel.MemoryGameSet;
					break;
				case MathQuizs:
					gameSet = mathModel.mathGameSet;
					break;
				case Languages:
					gameSet = matchingModel.LanguageGameSet;
					break;
				default:
					gameSet = matchingModel.MatchingGameSet;
			}
			return gameSet;
		}
		
		public function getGame(index:int):GameDescriptor
		{
			return currentGameSet[index] as GameDescriptor;
		}
		
		public function getNextGameType(currentType:String):GameDescriptor
		{
			var currentIndex: int = getGameIndex(currentType, currentGameSet);
			var nextIndex:int;
			if (currentIndex >= currentGameSet.length -1)
				nextIndex = 0; //go to the head
			else
				nextIndex = currentIndex +1;
			
			return currentGameSet[nextIndex] as GameDescriptor;
		}
		
		public function getGameIndex(type:String, gameSet:Array):int
		{
			if (type==null || type.length ==0)
				return -1;
			
			var index:int=0;
			for each (var game :GameDescriptor in gameSet)
			{
				if (game.gameType == type)
					return index;
				index++;
			}
			return index;
		}
		
		public function get GoodWorkPhrase():String
		{
			goodworkPhraseIndex++;
			
			if (goodworkPhraseIndex>= goodworkPhrases.length)
				goodworkPhraseIndex = 0;
			
			return goodworkPhrases[goodworkPhraseIndex];
		}
	}
}