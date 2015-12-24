package com.aVictorio.youngScholars.views.homeView.gameSelection
{
	import com.aVictorio.youngScholars.managers.ILocalable;
	import com.aVictorio.youngScholars.model.MainMenuModel;
	import com.dpLightFramework.framework.control.GenericEvent;
	import com.renaun.mxml.QContainer;
	
	import flash.events.MouseEvent;
	
	public class GameSelectionArea extends QContainer implements ILocalable
	{
		public static const MenuButtonWidth:int = 120; //96
 		public static const MenuButtonHeight:int = 130;
		
		public static const VERTICALBAR:String = "VERTICALBAR";
		public static const HORIZONTALBAR:String = "HORIZONTALBAR";
		public static const TILELIST:String = "TILELIST";
		
		protected var menuModel:MainMenuModel = MainMenuModel.getInstnce();

		protected var btnGame1:LabelIconButton;
		protected var btnGame2:LabelIconButton;
		protected var btnGame3:LabelIconButton;
		protected var btnGame4:LabelIconButton;
		
		protected var _layout:String;
		protected var _textColor:String;
		
		public function GameSelectionArea(layout:String, textColor:String="0x222222")
		{
			super();
			
			_layout = layout;
			_textColor = textColor;
			//menuModel.LoadLocaleResources();
			addMenuButtons();
		}
		
		[Bindable]
		public function get Layout():String
		{
			return _layout;
		}
		
		public function set Layout(value:String):void
		{
			_layout = value;
			invalidate();
		}
		
		public function onLocaleChanged():void
		{
			menuModel.LoadLocaleResources();
			btnGame1.setTitle(menuModel.menuArray[0].title);
			btnGame2.setTitle(menuModel.menuArray[1].title);
			btnGame3.setTitle(menuModel.menuArray[2].title);
			btnGame4.setTitle(menuModel.menuArray[3].title);
			invalidate();
		}
		
		public function setSelected(index:int):void
		{
			switch (index)
			{
				case 0:
					btnGame1.setSelectedState(true);
					btnGame2.setSelectedState(false);
					btnGame3.setSelectedState(false);
					btnGame4.setSelectedState(false);
					break;
				case 1:
					btnGame1.setSelectedState(false);
					btnGame2.setSelectedState(true);
					btnGame3.setSelectedState(false);
					btnGame4.setSelectedState(false);
					break;
				case 2:
					btnGame1.setSelectedState(false);
					btnGame2.setSelectedState(false);
					btnGame3.setSelectedState(true);
					btnGame4.setSelectedState(false);
					break;
				case 3:
				default:
					btnGame1.setSelectedState(false);
					btnGame2.setSelectedState(false);
					btnGame3.setSelectedState(false);
					btnGame4.setSelectedState(true);
					break;
			}
		}
		
		/*override protected function onAdded():void
		{
			onLocaleChanged();
		}
		*/
		
		private function addMenuButtons():void
		{
			var menuItem:Object;
			
			menuItem = menuModel.menuArray[0];
			btnGame1 = new LabelIconButton(menuItem.image, menuItem.title, _textColor);
			
			menuItem = menuModel.menuArray[1];
			btnGame2 = new LabelIconButton(menuItem.image, menuItem.title, _textColor);
			
			menuItem = menuModel.menuArray[2];
			btnGame3 = new LabelIconButton(menuItem.image, menuItem.title, _textColor);
			
			menuItem = menuModel.menuArray[3];
			btnGame4 = new LabelIconButton(menuItem.image, menuItem.title, _textColor);
			
			btnGame1.index = 0;
			btnGame2.index = 1;
			btnGame3.index = 2;
			btnGame4.index = 3;
			
			btnGame1.setSize(MenuButtonWidth, MenuButtonHeight);
			btnGame2.setSize(MenuButtonWidth, MenuButtonHeight);
			btnGame3.setSize(MenuButtonWidth, MenuButtonHeight);
			btnGame4.setSize(MenuButtonWidth, MenuButtonHeight);
			
			btnGame1.addEventListener(MouseEvent.CLICK, handleMenuButtonClicked, false, 0, true);
			btnGame2.addEventListener(MouseEvent.CLICK, handleMenuButtonClicked, false, 0, true);
			btnGame3.addEventListener(MouseEvent.CLICK, handleMenuButtonClicked, false, 0, true);
			btnGame4.addEventListener(MouseEvent.CLICK, handleMenuButtonClicked, false, 0, true);
			
			addChild(btnGame1);
			addChild(btnGame2);
			addChild(btnGame3);
			addChild(btnGame4);
		}
		
		protected function handleMenuButtonClicked(event:MouseEvent):void
		{
			var index:int = LabelIconButton(event.currentTarget).index;
			dispatchEvent(new GenericEvent("gameSelected", index, true, true));
		}

		
		override protected function draw():void
		{
			if (btnGame1 && btnGame2 && btnGame3 && btnGame4)
			{
				if (_layout == TILELIST)
				{
					var padddingX:int= (this.width - 2*MenuButtonWidth)/3;
					var paddingY:int =  (this.height - 2*MenuButtonHeight)/3;
					
					var col1x:int = padddingX;
					var row1y:int = paddingY;
					var col2x:int = col1x  + MenuButtonWidth + padddingX;
					var row2y:int = row1y + MenuButtonHeight + paddingY; 
					
					btnGame1.setPosition(col1x, row1y);
					btnGame2.setPosition(col2x, row1y);
					btnGame3.setPosition(col1x, row2y);
					btnGame4.setPosition(col2x, row2y);
				}
				else if (_layout == VERTICALBAR)
				{
					var paddingX:int = 0;
					var paddingY:int =  (this.height - 4*MenuButtonHeight)/4;
					
					var btnx:int = paddingX;
					var btny:int = paddingY;
					btnGame1.setPosition(btnx, btny);
					
					btny += paddingY + MenuButtonHeight;
					btnGame2.setPosition(btnx, btny);
					
					btny += paddingY + MenuButtonHeight;
					btnGame3.setPosition(btnx, btny);
					
					btny += paddingY + MenuButtonHeight;
					btnGame4.setPosition(btnx, btny);
				}
				else
				{//horizontal
					var paddingX:int = (this.width - 4*MenuButtonWidth)/4;
					var paddingY:int =  0;
					
					var btnx:int = 0;
					var btny:int = paddingY;
					btnGame1.setPosition(btnx, btny);
					
					btnx += paddingX + MenuButtonWidth;
					btnGame2.setPosition(btnx, btny);
					
					btnx += paddingX + MenuButtonWidth;
					btnGame3.setPosition(btnx, btny);
					
					btnx += paddingX + MenuButtonWidth;
					btnGame4.setPosition(btnx, btny);
					
				}
			}
			super.draw();

		}

	}
}