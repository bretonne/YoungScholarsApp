package com.aVictorio.youngScholars.model
{
	import com.aVictorio.youngScholars.managers.AppLocaleManager;
	import com.aVictorio.youngScholars.utils.GameUtils;
	import com.aVictorio.youngScholars.vos.CardDataVO;
	import com.aVictorio.youngScholars.vos.GameDescriptor;
	
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import qnx.ui.data.DataProvider;

	public class MatchingCardFactory
	{
		private static var _instance:MatchingCardFactory;
		
		public static const LETTER:String = "LETTER";
		public static const CAPITALSMALLLETTERS:String = "CAPITALSMALLLETTERS";
		public static const LETTERSOUND:String = "LETTERSOUND";
		public static const NUMBER20:String = "NUMBER20";
		public static const NUMBER50:String = "NUMBER50";
		public static const NUMBER100:String = "NUMBER100";
		public static const NUMBERWORD:String = "NUMBERWORD";
		public static const WORDS:String = "WORDS";
		public static const COLORWORDS:String = "COLORWORDS";
		public static const SHAPEWORDS:String = "SHAPEWORDS";
		public static const LANGUAGE:String = "LANGUAGE";
		public static const CALENDAR:String = "Calendar";

		public var MatchingGameSet:Array = [
			new GameDescriptor(LETTER, ""),
			new GameDescriptor(CAPITALSMALLLETTERS, ""), 
			new GameDescriptor(LETTERSOUND, ""),
			new GameDescriptor(WORDS, ""), 
			new GameDescriptor(NUMBER20, ""), 
			new GameDescriptor(NUMBER50, ""),
			new GameDescriptor(NUMBER100, ""),
			new GameDescriptor(NUMBERWORD, "")
			//			new GameDescriptor(COLORWORDS, "")
		];
		
		public var MemoryGameSet:Array = [
			new GameDescriptor(LETTER, ""),
			new GameDescriptor(WORDS, ""), 
			new GameDescriptor(NUMBER20, ""), 
			new GameDescriptor(NUMBER50, ""),
			new GameDescriptor(NUMBER100, "")];
		
		public var LanguageGameSet:Array = [
			new GameDescriptor(NUMBERWORD, ""),
			new GameDescriptor(COLORWORDS, ""),
			new GameDescriptor(WORDS, ""),
			new GameDescriptor(LANGUAGE,""),
			new GameDescriptor(CALENDAR, "")
		];
		
		private var resourceManager:IResourceManager = ResourceManager.getInstance();
		
		private var letterArray:Array; 
		private var smallLettersArray:Array; 
		private var letterSoundArray:Array;
		private var wordsArray:Array;
		private var numberArray:Array; //1-20
		private var colorArray:Array;
		private var languageWordArray:Array;
		private var calendarArray:Array;
		
		private var SLWordsArray:Array;
		private var SLNumberArray:Array;
		private var SLColorArray:Array;
		private var SLLanguageWordArray:Array;
		private var SLCalendarArray:Array;
		
		protected var _locale_SL:String = null;

		public var cards:DataProvider;

		public static function get instance():MatchingCardFactory
		{
			if (_instance == null)
				_instance = new MatchingCardFactory();
			return _instance;
		}

		public function MatchingCardFactory()
		{
		}
		
		public function loadResources():void
		{
			letterArray = AppLocaleManager.loadLocaleData("resource", "letterArray");
			smallLettersArray = AppLocaleManager.loadLocaleData("resource", "smallLettersArray");
			wordsArray = AppLocaleManager.loadLocaleData("resource", "wordsArray");
			letterSoundArray = AppLocaleManager.loadLocaleData("resource", "letterSoundArray");
			numberArray = AppLocaleManager.loadLocaleData("resource", "numberArray");
			colorArray = AppLocaleManager.loadLocaleData("resource", "colorArray");
			languageWordArray = AppLocaleManager.loadLocaleData("resource", "languageWordArray");
			calendarArray = AppLocaleManager.loadLocaleData("resource", "CalendarArray");
			
			var game:GameDescriptor;
			var index:int = 0;
			for each (game in MatchingGameSet)
			{
				game.label = resourceManager.getString("resource", game.gameType+"Title");
				game.gameIndex = index;
				index++;
			}
			index=0;
			for each (game in MemoryGameSet)
			{
				game.label = resourceManager.getString("resource", game.gameType+"Title");
				game.gameIndex = index;
				index++;
			}
			
			index=0;
			for each (game in LanguageGameSet)
			{
				game.label = resourceManager.getString("resource", game.gameType+"Title");
				game.gameIndex = index;
				index++;
			}
		}

		[Bindable]
		public function get locale_SL():String
		{
			return _locale_SL;
		}
		
		public function set locale_SL(value:String):void
		{
			_locale_SL = value;
			loadSLResources();
		}
		
		public function loadSLResources():void
		{
			SLWordsArray = AppLocaleManager.loadLocaleData("resource", "wordsArray", null, locale_SL);
			SLNumberArray = AppLocaleManager.loadLocaleData("resource", "numberArray", null, locale_SL);
			SLColorArray = AppLocaleManager.loadLocaleData("resource", "colorArray", null, locale_SL);
			SLLanguageWordArray = AppLocaleManager.loadLocaleData("resource", "languageWordArray", null, locale_SL);
			SLCalendarArray = AppLocaleManager.loadLocaleData("resource", "CalendarArray", null, locale_SL);
		}
		
		private function getDataArray(type:String, gameSetIndex:int):Array
		{
			if (gameSetIndex == GameModel.MatchingGames || gameSetIndex == GameModel.MemoryGames)
			{
				switch (type)
				{
					case LETTER:
					case CAPITALSMALLLETTERS:
					case LETTERSOUND:
						return letterArray;
					case NUMBER20:
						return GameUtils.getNumbers(20);
					case NUMBER50:
						return GameUtils.getNumbers(50);
					case NUMBER100:
						return GameUtils.getNumbers(100);
					case WORDS:
						return wordsArray;
					case NUMBERWORD:
						return GameUtils.getNumbers(20);
					default:
						return letterArray;
				}
			}
			else
			{
				switch (type)
				{
					case WORDS:
						return wordsArray;
					case NUMBERWORD:
						return GameUtils.getNumbers(20);
					case COLORWORDS:
						return colorArray;
					case LANGUAGE:
						return languageWordArray;
					case CALENDAR:
						return calendarArray;
					default:
						return wordsArray;
				}
			}
			return null;
		}
		
		private function getMatchingArray(type:String, dataArray:Array, gameSetIndex:int):Array
		{
			if (gameSetIndex == GameModel.MatchingGames || gameSetIndex == GameModel.MemoryGames)
			{
				switch (type)
				{
					case CAPITALSMALLLETTERS:
						return smallLettersArray;
					case LETTERSOUND:
						return letterSoundArray;
					case NUMBERWORD:
						return numberArray;
					case LETTER:
					case NUMBER20:
					case NUMBER50:
					case NUMBER100:
					case WORDS:
					default:	
						return dataArray;
				}
			}
			else
			{
				switch (type)
				{
					case WORDS:
						return SLWordsArray;
					case NUMBERWORD:
						return SLNumberArray;
					case COLORWORDS:
						return SLColorArray;
					case LANGUAGE:
						return SLLanguageWordArray;	
					case CALENDAR:
						return SLCalendarArray;
					default:
						return SLWordsArray;
				}
			}
			return null;
		}
		
		public static function cardExists(card:String, cardSet:DataProvider):Boolean
		{
			for each (var c:CardDataVO in cardSet.data)
			{
				if (c.content == card)
					return true;
			}
			return false;
		}
		
		public function shuffleCard(type:String, cnt:int, currentGameSetIndex:int):void
		{
			var dataArray:Array = getDataArray(type, currentGameSetIndex);
			var matchingArray:Array = getMatchingArray(type, dataArray, currentGameSetIndex);
			
			cards = getCardSet(dataArray, matchingArray, type, cnt, currentGameSetIndex);
		}
		
		private function getCardSet(dataArray:Array, matchingArray:Array, type:String, cnt:int, gameSetIndex:int):DataProvider
		{
			var wholeSet:DataProvider = new DataProvider();
			var matchingSet:Array = new Array();
			var card:String;
			var pick:int;
			var total:int = dataArray.length;
			
			while (wholeSet.length<cnt/2)
			{
				var random:Number = Math.random();
				pick=random*total;
				
				var card:String = dataArray[pick];
				
				if (!cardExists(card, wholeSet))
				{
					var cardvo:CardDataVO = new CardDataVO();
					cardvo.content = card;
					cardvo.matchingContent = matchingArray[pick];
					cardvo.gameType = type;
					cardvo.gameSetIndex = gameSetIndex;
					if (type.indexOf("NUMBER")>=0)
						cardvo.contentType = CardDataVO.NumberType;
					else
						cardvo.contentType = CardDataVO.StringType;
					
					wholeSet.addItem(cardvo);
					
					var matchingcardvo:CardDataVO = new CardDataVO();
					matchingcardvo.content = matchingArray[pick];
					matchingcardvo.matchingContent = card;
					matchingcardvo.gameType = type;
					matchingcardvo.gameSetIndex = gameSetIndex;
					if (type == NUMBER20 || type == NUMBER50 || type == NUMBER100)
					{
						matchingcardvo.number = parseInt(matchingcardvo.content);
						matchingcardvo.contentType = CardDataVO.NumberType;
					}
					else
						matchingcardvo.contentType = CardDataVO.StringType;
					
					matchingSet.push(matchingcardvo);
				}
			}
			
			for each (var matchingvo:CardDataVO in matchingSet)
			{
				var pos:int = wholeSet.length * Math.random();
				if (pos == wholeSet.length)
					pos--;
				wholeSet.addItemAt(matchingvo, pos);
			}
			return wholeSet;
		}		
		
	}
}