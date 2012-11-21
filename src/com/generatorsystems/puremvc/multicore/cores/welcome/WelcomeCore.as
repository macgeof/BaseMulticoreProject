/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.welcome
{
	import com.gb.puremvc.GBPipeAwareCore;
	import com.generatorsystems.projects.multicoredemo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.cores.welcome.controller.StartupCommand;
	import com.generatorsystems.puremvc.multicore.cores.welcome.model.WelcomeProxy;
	import com.generatorsystems.puremvc.multicore.cores.welcome.view.WelcomeMediator;

	public class WelcomeCore extends GBPipeAwareCore
	{
		public static const NAME:String 			= 'WelcomeCore';
		
		public function WelcomeCore()
		{
			facade = WelcomeFacade.getInstance(Cores.WELCOME);
			super(facade);
		}
		
		
		override public function get coreMediator():Class
		{
			return WelcomeMediator;
		}
		
		override public function get coreProxy():Class
		{
			return WelcomeProxy;
		}
		
		override public function startup():void
		{			
			WelcomeFacade(facade).startup(this, StartupCommand);
		}
		
		override public function destroy():void
		{
			facade.destroy();
			
		}
1
	}
}