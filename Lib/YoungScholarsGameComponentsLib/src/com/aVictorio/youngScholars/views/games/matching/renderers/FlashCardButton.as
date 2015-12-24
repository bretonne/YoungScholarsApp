package com.aVictorio.youngScholars.views.games.matching.renderers
{
	import com.aVictorio.youngScholars.managers.StylingFactory;
	import com.aVictorio.youngScholars.model.ApplicationModel;
	import com.aVictorio.youngScholars.model.GameModel;
	import com.aVictorio.youngScholars.model.MatchingCardFactory;
	import com.aVictorio.youngScholars.vos.CardDataVO;
	import com.renaun.qnx.ui.text.Label;
	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.listClasses.ICellRenderer;
	import qnx.ui.skins.SkinStates;
	import qnx.ui.skins.buttons.RoundedButtonSkinWhite;
	
	public class FlashCardButton extends LabelButton implements ICellRenderer
	{
		protected var _data:Object;
		protected var _cardVO:CardDataVO;
		protected var _index:int;
		
		public function FlashCardButton()
		{
			super();
			toggle = true;
			selected = false;
			
		}
		
		[Bindable]
		public function get cardVO():CardDataVO
		{
			return _cardVO;
		}
		
		public function set cardVO(value:CardDataVO):void
		{
			_cardVO = value;
			if (_cardVO)
			{
				label = _cardVO.content;
				if (_cardVO.gameSetIndex == GameModel.MemoryGames)
					setSkin(MemoryCardSkinRenderer);
				else
					setSkin(RoundedButtonSkinWhite);
			}
			else
			{
				label = "";
			}
			invalidate();
		}
		
		override protected function draw():void
		{
			var textFormat:TextFormat;
			if (_cardVO)
			{
				if (_cardVO.contentType == CardDataVO.NumberType || 
					_cardVO.gameType == MatchingCardFactory.LETTER || 
					_cardVO.gameType == MatchingCardFactory.CAPITALSMALLLETTERS ||
					_cardVO.gameType == MatchingCardFactory.LETTERSOUND && _cardVO.content.length<=3
				)
				{
					textFormat = StylingFactory.getTextFormat(26, "0xff0000", true);
				}
				else if (_cardVO.gameType == MatchingCardFactory.LANGUAGE || 
					_cardVO.gameType == MatchingCardFactory.CALENDAR || 
					_cardVO.gameType == MatchingCardFactory.NUMBERWORD
				)
				{
					if (_cardVO.content.length >8)
						textFormat = StylingFactory.getTextFormat(14, "0xff0000", true);
					else	
						textFormat = StylingFactory.getTextFormat(16, "0xff0000", true);
				}
				else
				{
					textFormat = StylingFactory.getTextFormat(18, "0xff0000", true);
				}
				setTextFormatForState(textFormat, SkinStates.UP);
				setTextFormatForState(textFormat, SkinStates.DOWN);
				setTextFormatForState(textFormat, SkinStates.SELECTED);
				
				if (_cardVO.gameSetIndex == GameModel.MemoryGames)
				{
					if (selected)
						label = _cardVO.content;
					else
						label = "";
				}
				else
				{
					label = _cardVO.content;
				}
			}
			else
			{
				label="";
			}
			
			super.draw();
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			
			if (value)
			{
				cardVO = value as CardDataVO;
			}	
			else
			{
				cardVO = null;
			}
			selected = false; //reset button selection mode
			invalidate();
			
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function get row():int
		{
			return 0;
		}
		
		public function set row(value:int):void
		{
		}
		
		public function get column():int
		{
			return 0;
		}
		
		public function set column(value:int):void
		{
		}
		
		public function get state():String
		{
			return null;
		}
		
		public function set state(state:String):void
		{
		}
		
		public function get section():int
		{
			return 0;
		}
		
		public function set section(section:int):void
		{
		}
		
		public function get isHeader():Boolean
		{
			return false;
		}

	}
}