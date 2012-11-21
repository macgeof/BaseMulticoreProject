/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger
{
	import com.gb.puremvc.GBPipeAwareCore;
	import com.generatorsystems.projects.multicoredemo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.cores.logger.LoggerFacade;
	import com.generatorsystems.puremvc.multicore.cores.logger.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.logger.model.LoggerProxy;
	import com.generatorsystems.puremvc.multicore.cores.logger.view.LoggerMediator;
	
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class LoggerModule extends GBPipeAwareCore
	{
		public static const NAME:String 			= 'LoggerModule';
		public static const LOG_BUTTON_UI:String 	= 'LogButtonUI';
		public static const LOG_WINDOW_UI:String 	= 'LogWindowUI';
		
		public function LoggerModule()
		{
			facade = LoggerFacade.getInstance(Cores.LOGGER);
			super(facade);
		}
		
		
		override public function get coreMediator():Class
		{
			return LoggerMediator;
		}
		
		override public function get coreProxy():Class
		{
			return LoggerProxy;
		}
		
		override public function startup():void
		{			
			LoggerFacade(facade).startup(this, StartupCommand);
		}
		
		override public function destroy():void
		{
			facade.destroy();
			
		}
1
	}
}