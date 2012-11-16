package com.generatorsystems.projects.multicoredemo
{
	import com.generatorsystems.base.cores.BaseCoreFacade;
	import com.generatorsystems.projects.multicoredemo.controller.StartupCommand;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	
	import spark.components.Application;
	
	public class ShellFacade extends BaseCoreFacade implements IFacade
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
		
		/**
		 * Application startup
		 * 
		 * @param app a reference to the application component 
		 */  
		public function startup( __app:Application ):void
		{
			sendNotification( STARTUP, __app );
		}
	}
}