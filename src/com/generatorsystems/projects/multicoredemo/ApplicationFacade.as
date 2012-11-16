package com.generatorsystems.projects.multicoredemo
{
	import com.generatorsystems.projects.multicoredemo.controller.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
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
		
		public function ApplicationFacade(key:String)
		{
			super(key);
		}
		
		/**
		 * ApplicationFacade Factory Method
		 */
		public static function getInstance( key:String ) : ApplicationFacade 
		{
			if ( instanceMap[ key ] == null ) instanceMap[ key ]  = new ApplicationFacade( key );
			return instanceMap[ key ] as ApplicationFacade;
		}
		
		/**
		 * Register Commands with the Controller 
		 */
		override protected function initializeController( ) : void 
		{
			super.initializeController();            
			registerCommand( STARTUP, StartupCommand );
		}
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( app:BaseMulticoreProject ):void
		{
			sendNotification( STARTUP, app );
		}
	}
}