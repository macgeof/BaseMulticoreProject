/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.welcome
{
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.patterns.GBCoreFacade;
	import com.generatorsystems.puremvc.multicore.cores.welcome.controller.CreateWelcomeButtonCommand;
	import com.generatorsystems.puremvc.multicore.cores.welcome.controller.CreateWelcomeWindowCommand;
	import com.generatorsystems.puremvc.multicore.cores.welcome.controller.StartupCommand;

	/**
	 * Application Facade for Logger Module.
	 */ 
	public class WelcomeFacade extends GBCoreFacade
	{
        public static const STARTUP:String 				= 'startup';
        public static const LOG_MSG:String 				= 'logMessage';
        public static const CREATE_LOG_BUTTON:String	= 'createLogButton';
        public static const CREATE_LOG_WINDOW:String	= 'createLogWindow';
        public static const EXPORT_LOG_BUTTON:String	= 'exportLogButton';
        public static const EXPORT_LOG_WINDOW:String	= 'exportLogWindow';
                
        public function LoggerFacade( __key:String )
        {
            super(__key);    
        }

        /**
         * ApplicationFacade Factory Method
         */
        public static function getInstance( __key:String ) : WelcomeFacade 
        {
            if ( instanceMap[ __key ] == null ) instanceMap[ __key ]  = new WelcomeFacade( __key );
            return instanceMap[ __key ] as WelcomeFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();            
            registerCommand( STARTUP, StartupCommand );
            registerCommand( CREATE_LOG_WINDOW, CreateWelcomeWindowCommand );
            registerCommand( CREATE_LOG_BUTTON, CreateWelcomeButtonCommand );
        }
        
        /**
         * Application startup
         * 
         * @param app a reference to the application component 
         */ 
		 override public function startup(core:Object, startupCommand:Class=null):void
		 {
			 // Default to standard GBPureMVC startup command if a custom command isn't specified.
			 if (!startupCommand)
				 startupCommand = StartupCommand;
			 
			 registerCommand(GBNotifications.STARTUP, startupCommand);
			 sendNotification(GBNotifications.STARTUP, core);
		 }
	}
}