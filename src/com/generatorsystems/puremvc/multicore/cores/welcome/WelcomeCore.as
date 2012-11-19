/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.welcome
{
	import com.gb.puremvc.GBPipeAwareFlexCore;
	import com.generatorsystems.puremvc.multicore.cores.welcome.WelcomeFacade;

	public class WelcomeCore extends GBPipeAwareFlexCore
	{
		public static const NAME:String 			= 'WelcomeCore';
		public static const WELCOME_BUTTON_UI:String 	= 'WelcomeButtonUI';
		public static const WELCOME_WINDOW_UI:String 	= 'WelcomeWindowUI';
		
		public function WelcomeCore()
		{
			super(WelcomeFacade.getInstance( NAME ));
			WelcomeFacade(facade).startup( this );
		}
1
	}
}