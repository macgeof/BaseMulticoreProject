package com.generatorsystems.projects.multicoredemo
{
	import com.gb.puremvc.controller.ApplicationStartupCommand;
	import com.gb.puremvc.interfaces.IShell;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.patterns.GBFacade;
	import com.generatorsystems.projects.multicoredemo.controller.StartupCommand;
	import com.generatorsystems.projects.multicoredemo.view.ShellMediator;
	
	public class ShellFacade extends GBFacade implements IShell
	{
		public static const NAME:String = "ApplicationFacade";
		
		public static const STARTUP:String 					= 'startup';
		public static const CONNECT_SHELL_TO_LOGGER:String  = 'connectShellToLogger';
		public static const CONNECT_MODULE_TO_LOGGER:String = 'connectModuleToLogger';
		public static const CONNECT_MODULE_TO_SHELL:String  = 'connectModuleToShell';
		public static const REQUEST_LOG_BUTTON:String 		= 'requestLogButton';
		public static const REQUEST_LOG_WINDOW:String 		= 'requestLogWindow';
		public static const REQUEST_FEED_WINDOW:String 		= 'requestFeedWindow';
		public static const SHOW_LOG_BUTTON:String 			= 'showLogButton';
		public static const SHOW_LOG_WINDOW:String 			= 'showLogWindow';
		public static const SHOW_FEED_WINDOW:String 		= 'showFeedWindow';
		public static const REMOVE_FEED_WINDOW:String 		= 'removeFeedWindow';
		
		public function ShellFacade(__key:String)
		{
			super(__key);
		}
		
		/**
		 * ApplicationFacade Factory Method
		 */
		public static function getInstance( __key:String ) : ShellFacade 
		{
			if ( instanceMap[ __key ] == null ) instanceMap[ __key ]  = new ShellFacade( __key );
			return instanceMap[ __key ] as ShellFacade;
		}
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController( ) : void 
		{
			super.initializeController();            
			registerCommand( STARTUP, StartupCommand );
		}
		
		public function get applicationMediator():Class
		{
			return ShellMediator;
		}
		
		/**
		 * Starts up application.
		 * 
		 * @param	Object		reference to document class
		 * @param 	Class		custom startup command. Optional, defaults to core framework command
		 */
		override public function startup(application:Object, startupCommand:Class = null):void
		{
			// Default to standard GBPureMVC startup command if a custom command isn't specified.
			if (!startupCommand)
				startupCommand = ApplicationStartupCommand;
			
			registerCommand(GBNotifications.STARTUP, startupCommand);
			sendNotification(GBNotifications.STARTUP, application);
		}
	}
}