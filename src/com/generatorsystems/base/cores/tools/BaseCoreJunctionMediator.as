package com.generatorsystems.base.cores.tools
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class BaseCoreJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = "BaseCoreJunctionMediator";
		
		/**
		 * Constructor.
		 * <P>
		 * Handles sending LogMessages.</P>
		 */ 		
		public function BaseCoreJunctionMediator( __name:String, __junction:Junction )
		{
			super( __name, __junction );
			
		}
		
		/**
		 * List Notification Interests.
		 * <P>
		 * Adds subclass interests to those of the JunctionMediator.</P>
		 */
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();

			return __interests;
		}
		
		/**
		 * Handle Logging related Notifications for a JunctionMediator subclass.
		 * <P>
		 * Override in subclass and call super.handleNotification to 
		 * Send messages to the logger and set the log level as well as
		 * IPipeAware actions (accepting input/output pipes).</P>
		 */		
		override public function handleNotification( __note:INotification ):void
		{
			
			switch( __note.getName() )
			{				
				
				// And let super handle the rest (ACCEPT_OUTPUT_PIPE, ACCEPT_INPUT_PIPE, SEND_TO_LOG)								
				default:
					super.handleNotification(__note);
					
			}
		}
	}
}