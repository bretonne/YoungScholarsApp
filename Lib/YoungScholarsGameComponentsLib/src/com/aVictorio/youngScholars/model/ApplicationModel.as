package com.aVictorio.youngScholars.model
{
	public class ApplicationModel
	{
		public static const TitleBarHeight:int = 45;
		public static const LangListWidth:int = 150;
		
		public static const GameTitleWidth:int = 250;
		public static const GameTitleHeight:int = 35;
		public static const NavigationButtonSize:int = 100;
		
		public static const cardBoardColumnwidth:int=90;
		public static const cardBoardRowheight:int = 90;
		public static const cardBoardCellpadding:int = 10;
		public static const cardBoardrows:int = 4;
		
		public static function get boardWidth():int
		{
			return cardBoardrows * (cardBoardColumnwidth + cardBoardCellpadding);
		}
		
		public static function get boardHeight():int
		{
			return cardBoardrows * (cardBoardRowheight + cardBoardCellpadding);
		}
	}
}