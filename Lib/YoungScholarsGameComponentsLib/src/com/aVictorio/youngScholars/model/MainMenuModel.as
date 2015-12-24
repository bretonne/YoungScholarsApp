package com.aVictorio.youngScholars.model
{
	import com.aVictorio.youngScholars.managers.IconManager;
	
	import mx.resources.ResourceManager;

	[Bindable]
	public class MainMenuModel
	{
		private static var _instance:MainMenuModel;
		
		public static function getInstnce():MainMenuModel
		{
			if (_instance == null)
				_instance = new MainMenuModel();
			return _instance;
		}
		
		public function MainMenuModel()
		{
			LoadLocaleResources();
		}
		
		public var menuArray:Array = [
			{title:'', image:IconManager.abcBoardIcon},
			{title:'', image:IconManager.MemoryGameIcon},
			{title:'', image:IconManager.mathBoardIcon},
			{title:'', image:IconManager.chatIcon},
		];		
		
		public const supportedLanguages:Array = [
			{id:'en_US', label:'English'},
			{id:'zh_CN', label:'中文简体'},
			{id:'fr_FR', label:'Français'},
			{id:'es_ES', label:'espanol'},
			{id:'zh_TW', label:'中文繁体'}
		];
		
		public function LoadLocaleResources():Array
		{
			var index:int = 0;
			for each (var menuItem:Object in menuArray)
			{
				switch (index)
				{
					case GameModel.MatchingGames:
						menuItem.title = ResourceManager.getInstance().getString('resource', 'matchingGames'); 
						break;
					case GameModel.MemoryGames:
						menuItem.title = ResourceManager.getInstance().getString('resource','memoryGame');
						break;
					case GameModel.MathQuizs:
						menuItem.title = ResourceManager.getInstance().getString('resource', 'mathQuizs');
						break;
					case GameModel.Languages:
						menuItem.title = ResourceManager.getInstance().getString('resource','languages');
						break;
					default:
						break;
				}
				index++;
			}
			return menuArray;
		}

	}
}