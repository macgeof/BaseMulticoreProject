/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger
{
	import com.generatorsystems.base.cores.BaseCoreFacade;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.CreateLogButtonCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.CreateLogWindowCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.LogMessageCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.StartupCommand;

	/**
	 * Application Facade for Logger Module.
	 */ 
	public class LoggerFacade extends BaseCoreFacade
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
        public function startup( __app:LoggerModule ):void
        {
            sendNotification( STARTUP, __app );
        }
	}
}