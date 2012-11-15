package com.generatorsystems.base.cores.model
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class BaseCoreProxy extends Proxy implements IProxy
	{
		public function BaseCoreProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
	}
}