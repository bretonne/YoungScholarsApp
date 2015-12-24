package com.aVictorio.youngScholars.vos
{
	[Bindable]
	public class GameDescriptor
	{
		public var gameIndex:int;
		public var gameType:String;
		public var label:String;
		
		public function GameDescriptor(type_:String, title_:String)
		{
			this.gameType = type_;
			this.label = title_;
		}
	}
}