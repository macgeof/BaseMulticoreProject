package com.generatorsystems.projects.multicoredemo.model
{
	import com.generatorsystems.base.cores.model.BaseCoreProxy;
	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	
	public class ShellDataProxy extends BaseCoreProxy implements IProxy
	{
		public static const NAME:String = 'ShellDataProxy';
		
		public function ShellDataProxy(__proxyName:String=null, __data:Object=null)
		{
			super(__proxyName, __data);
		}
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
	}
}