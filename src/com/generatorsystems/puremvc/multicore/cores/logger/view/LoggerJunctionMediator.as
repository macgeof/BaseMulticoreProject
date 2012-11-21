/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger.view
{
	import com.gb.puremvc.GBPipeAwareFlexCore;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.model.messages.LogFilterMessage;
	import com.gb.puremvc.model.messages.LogMessage;
	import com.gb.puremvc.model.messages.UIQueryMessage;
	import com.generatorsystems.puremvc.multicore.cores.logger.LoggerFacade;
	import com.generatorsystems.puremvc.multicore.cores.logger.LoggerModule;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Filter;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.JunctionMediator;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.PipeListener;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	
	public class LoggerJunctionMediator extends JunctionMediator
	{
		public static const NAME:String = 'LoggerJunctionMediator';
		
		private var _loggerModule:LoggerModule;

		/**
		 * Constructor.
		 * <P>
		 * Creates and registers its own STDIN pipe
		 * and adds this instance as a listener, 
		 * because the logger uses a TeeMerge and 
		 * new inputs are added to it rather than
		 * as separate pipes registered with the
		 * Junction.</P>
		 */ 		
		public function LoggerJunctionMediator( core:LoggerModule )
		{
			super( NAME, new Junction() );
			
			_loggerModule = core;
			
		}

		/**
		 * Called when Mediator is registered.
		 * <P>
		 * Registers a short pipeline consisting of
		 * a Merging Tee connected to a Filter for STDIN, 
		 * setting the LoggerJunctionMediator as the 
		 * Pipe Listener.</P>
		 * <P>
		 * The filter is used to filter messages by log
		 * level. LogMessages falling below the current
		 * LogLevel are rejected by the filter.</P>
		 */
		override public function onRegister():void
		{
			var __teeMerge:TeeMerge = new TeeMerge();
			var __filter:Filter = new Filter( LogFilterMessage.LOG_FILTER_NAME,
										    null,
										    LogFilterMessage.filterLogByLevel as Function
										    );
			__filter.connect(new PipeListener(this,handlePipeMessage));
			__teeMerge.connect(__filter);
			junction.registerPipe( GBPipeAwareFlexCore.STDIN, Junction.INPUT, __teeMerge );
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			
			_loggerModule = null;
		}
		
		/**
		 * List Notification Interests.
		 * <P>
		 * Adds subclass interests to those of the JunctionMediator.</P>
		 */
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();
			__interests.push(GBNotifications.STARTUP_COMPLETE);
			__interests.push(LoggerFacade.EXPORT_LOG_BUTTON);
			__interests.push(LoggerFacade.EXPORT_LOG_WINDOW);
			return __interests;
		}

		/**
		 * Handle Junction related Notifications for the LoggerModule.
		 * <P>
		 * For the Logger, this consists of exporting the
		 * LogButton and LogWindow in a PipeMessage to STDSHELL, 
		 * as well as the ordinary JunctionMediator duties of 
		 * accepting input and output pipes from the Shell.</P>
		 * <P>
		 * It handles accepting input pipes instead of letting
		 * the superclass do it because the STDIN to the logger
		 * is Merging Tee and not a pipe, so the details of 
		 * connecting it differ.</P>
		 */		
		override public function handleNotification( __note:INotification ):void
		{
			var __logMessage:LogMessage;
			var __logged:Boolean;
			
			switch( __note.getName() )
			{
				//core startup complete
				case GBNotifications.STARTUP_COMPLETE :
					var __message:Message = new Message(GBNotifications.STARTUP_COMPLETE, loggerCore);
					__logged = junction.sendMessage(GBPipeAwareFlexCore.STDSHELL, __message);
					break;					
				
				// Send the LogButton UI Component 
				case LoggerFacade.EXPORT_LOG_BUTTON:
					var __logButtonMessage:UIQueryMessage = new UIQueryMessage( UIQueryMessage.SET, LoggerModule.LOG_BUTTON_UI, UIComponent(__note.getBody()) );
					__logMessage = new LogMessage(LogMessage.INFO, this.multitonKey, "LogButton about to be exported from Logger core");
					__logged = junction.sendMessage( GBPipeAwareFlexCore.STDSHELL, __logMessage);
					var buttonExported:Boolean = junction.sendMessage( GBPipeAwareFlexCore.STDSHELL, __logButtonMessage );
					break;
				
				// Send the LogWindow UI Component 
				case LoggerFacade.EXPORT_LOG_WINDOW:
					var __logWindowMessage:UIQueryMessage = new UIQueryMessage( UIQueryMessage.SET, LoggerModule.LOG_WINDOW_UI, UIComponent(__note.getBody()) );
					__logMessage = new LogMessage(LogMessage.INFO, this.multitonKey, "LogWindow about to be exported from Logger core");
					__logged = junction.sendMessage( GBPipeAwareFlexCore.STDSHELL, __logMessage);
					junction.sendMessage( GBPipeAwareFlexCore.STDSHELL, __logWindowMessage );
					break;
				
				// Add an input pipe (special handling for LoggerModule) 
				case JunctionMediator.ACCEPT_INPUT_PIPE:
					var __name:String = __note.getType();
					
					// STDIN is a Merging Tee. Overriding super to handle this.
					if (__name == GBPipeAwareFlexCore.STDIN) {
						var __pipe:IPipeFitting = __note.getBody() as IPipeFitting;
						var __tee:TeeMerge = junction.retrievePipe(GBPipeAwareFlexCore.STDIN) as TeeMerge;
						__tee.connectInput(__pipe);
					} 
					// Use super for any other input pipe
					else {
						super.handleNotification(__note); 
					} 
					break;

				// And let super handle the rest (ACCEPT_OUTPUT_PIPE)								
				default:
					super.handleNotification(__note);
					
			}
		}
		
		/**
		 * Handle incoming pipe messages.
		 */
		override public function handlePipeMessage( __message:IPipeMessage ):void
		{
//			sendNotification( LoggerFacade.LOG_MSG, new LogMessage(LogMessage.INFO, this.multitonKey, "Logger core handling pipe message : body = '" + __message.getBody() + "' : header = '" + __message.getHeader() + "' : type = '" + __message.getType() + "'") );
			var __isMessage:Boolean = __message is Message;
			if ( __message is LogMessage ) 
			{
				sendNotification( LoggerFacade.LOG_MSG, __message );
			} 
			else if ( __message is UIQueryMessage )
			{
				if (UIQueryMessage(__message).action == GBNotifications.DESTROY)
				{
					loggerCore.destroy();
					return;
				}
				switch ( UIQueryMessage(__message).name )
				{
					
					case LoggerModule.LOG_BUTTON_UI:
						sendNotification(LoggerFacade.CREATE_LOG_BUTTON)
						break;

					case LoggerModule.LOG_WINDOW_UI:
						sendNotification(LoggerFacade.CREATE_LOG_WINDOW )
						break;
				}
			}
		}
		
		protected function get loggerCore():LoggerModule
		{
			return _loggerModule as LoggerModule;
		}
	}
}