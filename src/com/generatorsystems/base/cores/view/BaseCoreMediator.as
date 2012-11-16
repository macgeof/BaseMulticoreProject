package com.generatorsystems.base.cores.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class BaseCoreMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BaseCoreMediator";
		
		public function BaseCoreMediator(__mediatorName:String=null, __viewComponent:Object=null)
		{			
			super(__mediatorName, __viewComponent);
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
			return super.listNotificationInterests().concat([
				
				])
		}
		
		override public function handleNotification(__notification:INotification):void
		{
			super.handleNotification(__notification);
			
			switch (__notification.getName())
			{
				default : 
					break;
			}
		}
	}
}