package com.generatorsystems.puremvc.multicore.cores.logger.view
{
	import com.gb.puremvc.view.AbstractMediator;
	import com.generatorsystems.puremvc.multicore.cores.logger.LoggerModule;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	public class LoggerMediator extends AbstractMediator
	{
		
		public static const NAME:String = "LoggerMediator";
		
		public function LoggerMediator(mediatorName:String=null, viewComponent:Object=null)
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
			
			return __interests;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				default :
					super.handleNotification(notification);
					break;
			}
		}
		
		protected function get loggerModule():LoggerModule
		{
			return viewComponent as LoggerModule;
		}
	}
}