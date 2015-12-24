package com.aVictorio.youngScholars.views.games.matching.renderers
{
	import com.aVictorio.youngScholars.managers.IconManager;
	
	import flash.display.DisplayObject;
	
	import qnx.ui.skins.SkinAssets;
	import qnx.ui.skins.SkinStates;
	import qnx.ui.skins.UISkin;
	
	public class MemoryCardSkinRenderer extends UISkin
	{
		protected var upSkin:DisplayObject;
		
		protected var downSkin:DisplayObject;
		
		public function MemoryCardSkinRenderer()
		{
			super();
		}
		
		// ------------------- initializeStates override ---------------------
		
		override protected function initializeStates():void
		{
			// Up State
			upSkin = new IconManager.CardBackImage();
			setSkinState(SkinStates.UP, upSkin);
			
			// Down State
			downSkin = new SkinAssets.ButtonUpWhite(); // new IconManager.CardBlankImage();
			setSkinState(SkinStates.DOWN, downSkin);
			
			setSkinState(SkinStates.SELECTED, downSkin);
			
			showSkin(upSkin);
		}
	}
}