package com.generatorsystems.projects.multicoredemo.model
{
	import com.generatorsystems.base.cores.model.BaseCoreProxy;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	public class ApplicationDataProxy extends BaseCoreProxy implements IProxy
	{
		public static const NAME:String = 'ApplicationDataProxy';
		
		public function ApplicationDataProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
	}
}