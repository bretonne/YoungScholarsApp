package com.aVictorio.youngScholars.utils
{
	public class GameUtils
	{
		public static function getNumbers(cnt:int):Array
		{
			var numbers:Array = new Array();
			for (var i:int=0; i<cnt; i++)
				numbers.push(i);
			return numbers;
		}	
	}
}