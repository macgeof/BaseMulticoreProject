package com.generatorsystems.base.cores.tools.messages
{
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	
	public class BaseCoreMessage extends Message
	{
		public function BaseCoreMessage(type:String, header:Object=null, body:Object=null, priority:int=5)
		{
			super(type, header, body, priority);
		}
	}
}