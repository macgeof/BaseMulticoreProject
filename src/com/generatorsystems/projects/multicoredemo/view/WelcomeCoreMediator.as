package com.generatorsystems.projects.multicoredemo.view
{
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.view.GBFlexMediator;
	import com.generatorsystems.projects.multicoredemo.ShellFacade;
	import com.generatorsystems.puremvc.multicore.cores.welcome.WelcomeCore;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class WelcomeCoreMediator extends GBFlexMediator
	{
		public static const NAME:String = "WelcomeCoreMediator";
		
		protected var _welcomeCore:WelcomeCore;
		
		public function WelcomeCoreMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();
			__interests.push(
				GBNotifications.DESTROY,
				ShellFacade.CREATE_WELCOME,
				ShellFacade.CONNECT_MODULE_TO_LOGGER
			);
			
			return __interests;
		}
		
		override public function handleNotification(note:INotification):void
		{
			super.handleNotification(note);
			
			switch (note.getName())
			{
				case GBNotifications.DESTROY :
					
					break;
				
				case ShellFacade.CREATE_WELCOME :
					var __welcome:WelcomeCore = new WelcomeCore();
					__welcome.startup();
					viewComponent = __welcome;
					sendNotification(ShellFacade.CONNECT_MODULE_TO_SHELL, viewComponent);
					sendNotification(ShellFacade.CONNECT_MODULE_TO_LOGGER, viewComponent);
					break;
				
				case ShellFacade.CONNECT_MODULE_TO_LOGGER :
					
					break;
			}
		}
		
		protected function get welcomeCore():WelcomeCore
		{
			return viewComponent as WelcomeCore;
		}
	}
}