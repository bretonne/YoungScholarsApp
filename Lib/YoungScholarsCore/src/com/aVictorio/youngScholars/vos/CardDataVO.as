package com.aVictorio.youngScholars.vos
{
	[Bindable]
	public class CardDataVO
	{
		public static const StringType:String = "StringType";
		public static const NumberType:String = "NumberType";
		
		public var gameType:String; //game type, Number, 
		public var content:String;
		public var number:int; //for number types only
		public var contentType:String = StringType;
		public var matchingContent:String;
		
		public var gameSetIndex:int;
	}
}