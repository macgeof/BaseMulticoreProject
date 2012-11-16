/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks - Prattler Module
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>

 Parts originally from: 
 PureMVC AS3 Demo – AIR RSS Headlines 
 Copyright (c) 2007-08 Simon Bailey <simon.bailey@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.base.cores.tools
{
	import com.generatorsystems.base.cores.tools.messages.LogFilterMessage;
	import com.generatorsystems.base.cores.tools.messages.LogMessage;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.messages.FilterControlMessage;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	
	public class LoggingJunctionMediator extends BaseCoreJunctionMediator
	{
		public static const NAME:String = "LoggingJunctionMediator";

		/**
		 * Constructor.
		 * <P>
		 * Handles sending LogMessages.</P>
		 */ 		
		public function LoggingJunctionMediator( __name:String, __junction:Junction )
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
			__interests.push(LogMessage.SEND_TO_LOG);
			__interests.push(LogFilterMessage.SET_LOG_LEVEL);
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
                // Send messages to the Log
                case LogMessage.SEND_TO_LOG:
                    var level:int;
                    switch (__note.getType())
                    {
                        case LogMessage.LEVELS[LogMessage.DEBUG]:
                            level = LogMessage.DEBUG;
                            break;

                        case LogMessage.LEVELS[LogMessage.ERROR]:
                            level = LogMessage.ERROR;
                            break;
                        
                        case LogMessage.LEVELS[LogMessage.FATAL]:
                            level = LogMessage.FATAL;
                            break;
                        
                        case LogMessage.LEVELS[LogMessage.INFO]:
                            level = LogMessage.INFO;
                            break;
                        
                        case LogMessage.LEVELS[LogMessage.WARN]:
                            level = LogMessage.WARN;
                            break;
                        
                        default:
                            level = LogMessage.DEBUG;
                            break;
                        
                    }
                    var __logMessage:LogMessage = new LogMessage( level, this.multitonKey, __note.getBody() as String);
                    junction.sendMessage( PipeAwareModule.STDLOG, __logMessage );
                    break;

                // Modify the Log Level filter 
                case LogFilterMessage.SET_LOG_LEVEL:
                    var __logLevel:Number = __note.getBody() as Number;
                    var __setLogLevelMessage:LogFilterMessage = new LogFilterMessage(FilterControlMessage.SET_PARAMS, __logLevel);
                    var __changedLevel:Boolean = junction.sendMessage( PipeAwareModule.STDLOG, __setLogLevelMessage );
                    var __changedLevelMessage:LogMessage = new LogMessage( LogMessage.CHANGE, this.multitonKey, "Changed Log Level to: "+LogMessage.LEVELS[__logLevel])
                    var __logChanged:Boolean = junction.sendMessage( PipeAwareModule.STDLOG, __changedLevelMessage );
                    break;

				
				// And let super handle the rest (ACCEPT_OUTPUT_PIPE, ACCEPT_INPUT_PIPE, SEND_TO_LOG)								
				default:
					super.handleNotification(__note);
					
			}
		}
		
	}
}