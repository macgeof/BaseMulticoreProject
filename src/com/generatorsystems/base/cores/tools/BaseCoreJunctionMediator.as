package com.generatorsystems.base.cores.tools
{
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	
	public class BaseCoreJunctionMediator extends JunctionMediator
	{
		
		/**
		 * Constructor.
		 * <P>
		 * Handles sending LogMessages.</P>
		 */ 		
		public function BaseCoreJunctionMediator( name:String, junction:Junction )
		{
			super( name, junction );
			
		}
		
		/**
		 * List Notification Interests.
		 * <P>
		 * Adds subclass interests to those of the JunctionMediator.</P>
		 */
		override public function listNotificationInterests():Array
		{
			var interests:Array = super.listNotificationInterests();

			return interests;
		}
		
		/**
		 * Handle Logging related Notifications for a JunctionMediator subclass.
		 * <P>
		 * Override in subclass and call super.handleNotification to 
		 * Send messages to the logger and set the log level as well as
		 * IPipeAware actions (accepting input/output pipes).</P>
		 */		
		override public function handleNotification( note:INotification ):void
		{
			
			switch( note.getName() )
			{				
				
				// And let super handle the rest (ACCEPT_OUTPUT_PIPE, ACCEPT_INPUT_PIPE, SEND_TO_LOG)								
				default:
					super.handleNotification(note);
					
			}
		}
	}
}