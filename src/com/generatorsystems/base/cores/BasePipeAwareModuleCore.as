package com.generatorsystems.base.cores
{
	import com.generatorsystems.base.cores.tools.PipeAwareModule;
	
	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	
	public class BasePipeAwareModuleCore extends PipeAwareModule
	{
		public static const NAME:String 			= 'BasePipeAwareModuleCore';
		
		public function BasePipeAwareModuleCore(__facade:IFacade)
		{
			super(__facade);
		}
	}
}