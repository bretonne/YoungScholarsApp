package com.aVictorio.youngScholars.views.homeView.gameSelection
{
	import com.aVictorio.youngScholars.managers.StylingFactory;
	import com.renaun.qnx.ui.text.Label;
	
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import qnx.ui.buttons.IconButton;
	import qnx.ui.core.UIComponent;
	
	public class LabelIconButton extends UIComponent
	{
		public var index:int;
		protected var _iconSource:Class;
		protected var _title:String;
		protected var _textColor:String ="0x222222";
		
		protected var iconButton:IconButton;
		protected var label:Label;
		
		public function LabelIconButton(iconSource:Class, title:String, textColor:String)
		{
			super();
			_iconSource = iconSource;
			_title = title;

			if (_iconSource)
				iconButton = new IconButton();
			if (_title)
				label = new Label();
			
			_textColor = textColor;
		}
		
		public function setTitle(title:String):void
		{
			_title = title;
			label.text = title;
		}
		
		public function setSelectedState(selected:Boolean):void
		{
			iconButton.selected = selected;
		}
		
		override protected function onAdded():void
		{
			if (iconButton)
			{
				iconButton.setIcon(new _iconSource());
				iconButton.setPosition(0, 0);
				iconButton.setSize(96, 96);
				
				iconButton.cacheAsBitmap = true;
				addChild(iconButton);
			}
			
			if (label)
			{
				label.text = _title;
				label.format = StylingFactory.getTextFormat(16, _textColor, true);
				
				label.setSize(96, 30);
				label.setPosition(0, 100);
				label.wordWrap = true;
				addChild(label);
				//label.autoSize = TextFieldAutoSize.CENTER;
				
				addChild(label);
			}
		}
	}
}