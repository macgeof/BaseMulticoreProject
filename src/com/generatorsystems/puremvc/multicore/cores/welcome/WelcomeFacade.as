/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.welcome
{
	import com.gb.puremvc.interfaces.ICoreFacade;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.patterns.GBCoreFacade;
	import com.generatorsystems.puremvc.multicore.cores.welcome.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.welcome.model.WelcomeProxy;
	import com.generatorsystems.puremvc.multicore.cores.welcome.view.WelcomeJunctionMediator;
	import com.generatorsystems.puremvc.multicore.cores.welcome.view.WelcomeMediator;

	/**
	 * Application Facade for Logger Module.
	 */ 
	public class WelcomeFacade extends GBCoreFacade implements ICoreFacade
	{
        public static const STARTUP:String 				= 'startup';
                
        public function WelcomeFacade( __key:String )
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
			 
			 //remove all mediators
			 removeMediator(WelcomeJunctionMediator.NAME);
			 removeMediator(WelcomeMediator.NAME);
			 
			 //remove all proxies
			 removeProxy(WelcomeProxy.NAME);
		 }
	}
}