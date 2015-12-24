package com.aVictorio.youngScholars.views.components
{
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import mx.utils.ColorUtil;
	
	import qnx.ui.core.UIComponent;

	public class GradientBackground extends UIComponent
	{
		protected var _color:uint;
		
		[Bindable]
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			draw();
		}
		
		public function GradientBackground()
		{
			super();
		}
		
		
		
		override protected function draw():void
		{
			graphics.clear();
			
			var gradientBoxMatrix:Matrix = new Matrix();
			gradientBoxMatrix.createGradientBox(100, 40, 0, 0, 0);
			
			var colors:Array = [ColorUtil.adjustBrightness2(color, 50), color];
			var alphas:Array = [1, 1];
			var ratios:Array = [50, 125];
			graphics.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios); //, gradientBoxMatrix
			graphics.drawRoundRect(0, 0, width, height, 10);
			graphics.endFill();
			
			super.draw();
		}
	}
}