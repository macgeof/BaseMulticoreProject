/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger
{
	import com.gb.puremvc.interfaces.ICoreFacade;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.patterns.GBCoreFacade;
	import com.generatorsystems.projects.multicoredemo.model.enums.Cores;
	import com.generatorsystems.projects.multicoredemo.view.LoggingJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.CreateLogButtonCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.CreateLogWindowCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.LogMessageCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.model.LoggerProxy;
	import com.generatorsystems.puremvc.multicore.cores.logger.view.LoggerJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.logger.view.LoggerMediator;

	/**
	 * Application Facade for Logger Module.
	 */ 
	public class LoggerFacade extends GBCoreFacade implements ICoreFacade
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
        public static function getInstance( __key:String ) : LoggerFacade 
        {
            if ( instanceMap[ __key ] == null ) instanceMap[ __key ]  = new LoggerFacade( __key );
            return instanceMap[ __key ] as LoggerFacade;
        }
        
        /**
         * Register Commands with the Controller 
         */
        override protected function initializeController( ) : void 
        {
            super.initializeController();            
            registerCommand( STARTUP, StartupCommand );
            registerCommand( LOG_MSG, LogMessageCommand );
            registerCommand( CREATE_LOG_WINDOW, CreateLogWindowCommand );
            registerCommand( CREATE_LOG_BUTTON, CreateLogButtonCommand );
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
		 
		 override public function destroy():void
		 {
			 super.destroy();
			 
			 //remove all non-super commands commands
			 removeCommand(LOG_MSG);
			 removeCommand(CREATE_LOG_BUTTON);
			 removeCommand(CREATE_LOG_WINDOW);
			 
			 //remove all mediators
			 removeMediator(LoggerJunctionMediator.NAME);
			 removeMediator(LoggerMediator.NAME);
			 
			 //remove all proxies
			 removeProxy(LoggerProxy.NAME);
		 }
	}
}