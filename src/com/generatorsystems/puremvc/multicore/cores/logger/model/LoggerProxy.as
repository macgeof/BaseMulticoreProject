/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger.model
{
	import com.generatorsystems.base.cores.model.BaseCoreProxy;
	import com.generatorsystems.base.cores.tools.messages.LogMessage;
	
	import mx.collections.ArrayCollection;

	/**
	 * The Logger Proxy.
	 * <P>
	 * Maintains the list of <code>LogMessages</code>. 
	 * This class could be extended to write log 
	 * messages to a remote service as well.</P>
	 * 
	 * <P>
	 * An <code>ArrayCollection</code> is used to 
	 * hold the messages because it will be used
	 * as a data provider for UI controls, which
	 * will automatically be refreshed when the
	 * contents of the ArrayCollection changes.</P>
	 */
	public class LoggerProxy extends BaseCoreProxy
	{
        public static const NAME:String = 'LoggerProxy';

		public function LoggerProxy()
        {
            super( NAME, new ArrayCollection() );
        }
        
        public function addLogEntry(__message:LogMessage):void
        {
        	messages.addItem(__message);
        }
		
		public function get messages():ArrayCollection
		{
			return data as ArrayCollection;
		}
	}
}