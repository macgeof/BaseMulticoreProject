/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.welcome.model
{
	
	import com.gb.puremvc.model.AbstractProxy;
	
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
	public class WelcomeProxy extends AbstractProxy
	{
        public static const NAME:String = 'WelcomeProxy';

		public function WelcomeProxy(__name:String, __data:* = null)
        {
            super( NAME, new ArrayCollection() );
        }
		
		override public function onRegister():void
		{
			super.onRegister();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			
			data = null;
		}
	}
}