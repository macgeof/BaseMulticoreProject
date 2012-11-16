package com.generatorsystems.base.cores.tools.messages
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class BaseCoreMessage extends Message
	{
		public function BaseCoreMessage(__type:String, __header:Object=null, __body:Object=null, __priority:int=5)
		{
			super(__type, __header, __body, __priority);
		}
	}
}