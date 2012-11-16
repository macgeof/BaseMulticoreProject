package com.generatorsystems.base.cores.model
{
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;
	
	public class BaseCoreProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "BaseCoreProxy";
		
		public function BaseCoreProxy(__proxyName:String=null, __data:Object=null)
		{
			super(__proxyName, __data);
		}
	}
}