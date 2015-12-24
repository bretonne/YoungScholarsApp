package com.aVictorio.youngScholars.managers
{
	import flash.text.TextFormat;

	public class StylingFactory
	{
		public static function getTextFormat(size:int, color:String = "0xffffff", bold:Boolean=false, italic:Boolean=false):TextFormat
		{
			var format:TextFormat = new TextFormat();
			format.font = "Helvetica";
			format.size = size;
			format.color = color;
			format.bold  = bold;
			format.italic = italic;
		
			return format;
		}
	}
}