/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger
{
	import com.generatorsystems.puremvc.multicore.cores.logger.LoggerFacade;

	import com.gb.puremvc.GBPipeAwareFlexCore;

	public class LoggerModule extends GBPipeAwareFlexCore
	{
		public static const NAME:String 			= 'LoggerModule';
		public static const LOG_BUTTON_UI:String 	= 'LogButtonUI';
		public static const LOG_WINDOW_UI:String 	= 'LogWindowUI';
		
		public function LoggerModule()
		{
			super(LoggerFacade.getInstance( NAME ));
			LoggerFacade(facade).startup( this );
		}
1
	}
}