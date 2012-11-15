package com.generatorsystems.base.cores
{
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	public class BaseCoreFacade extends Facade implements IFacade
	{
		public function BaseCoreFacade(key:String)
		{
			super(key);
		}
	}
}