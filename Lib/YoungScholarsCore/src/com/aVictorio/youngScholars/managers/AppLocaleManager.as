package com.aVictorio.youngScholars.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.resources.ResourceManager;
	
	import qnx.locale.LocaleManager;
	import qnx.locale.LocaleResourceBundle;

	public class AppLocaleManager extends EventDispatcher
	{
		private static var _instance:AppLocaleManager;
		
		public static function isSupported(locale:String):Boolean
		{
			switch(locale)
			{
				case 'en_US':
				case 'es_ES':
				case 'fr_FR':
				case 'zh_CN':
				case 'zh_TW':
					return true;
				default:
					break;
			}
			return false;
		}
		
		public static function loadLocaleData(bundleName:String, resourceKey:String, params:Array=null, locale:String=null):Array
		{
			var resource:String = ResourceManager.getInstance().getString(
				bundleName, resourceKey, params, locale);
			
			if (resource)
				return resource.split(",");
			else
				return null;
		}
	}
}