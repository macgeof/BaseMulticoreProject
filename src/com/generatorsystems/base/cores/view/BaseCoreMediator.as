package com.generatorsystems.base.cores.view
{
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	public class BaseCoreMediator extends Mediator implements IMediator
	{
		public function BaseCoreMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			super(mediatorName, viewComponent);
		}
	}
}