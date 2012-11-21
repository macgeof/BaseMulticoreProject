/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.projects.multicoredemo.view
{
	import com.gb.puremvc.GBPipeAwareFlexCore;
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.model.messages.LogMessage;
	import com.gb.puremvc.model.messages.UIQueryMessage;
	import com.generatorsystems.projects.multicoredemo.ShellFacade;
	import com.generatorsystems.projects.multicoredemo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.cores.logger.LoggerModule;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeSplit;
	
	public class ShellJunctionMediator extends LoggingJunctionMediator
	{
		public static const NAME:String = 'ShellJunctionMediator';
		
		public function ShellJunctionMediator( )
		{
			super( NAME, new Junction() );
		}

		/**
		 * Called when the Mediator is registered.
		 * <P>
		 * Registers a Merging Tee for STDIN, 
		 * and sets this as the Pipe Listener.</P>
		 * <P>
		 * Registers a Pipe for STDLOG and 
		 * connects it to LoggerModule.</P>
		 */
		override public function onRegister():void
		{
			// The STDOUT pipe from the shell to all modules 
			junction.registerPipe( GBPipeAwareFlexCore.STDOUT,  Junction.OUTPUT, new TeeSplit() );
			
			// The STDIN pipe to the shell from all modules 
			junction.registerPipe( GBPipeAwareFlexCore.STDIN,  Junction.INPUT, new TeeMerge() );
			junction.addPipeListener( GBPipeAwareFlexCore.STDIN, this, handlePipeMessage );
			
			// The STDLOG pipe from the shell to the logger
			junction.registerPipe( GBPipeAwareFlexCore.STDLOG, Junction.OUTPUT, new Pipe() );

		}
		
		/**
		 * ShellJunction related Notification list.
		 * <P>
		 * Adds subclass interests to JunctionMediator interests.</P>
		 */
		override public function listNotificationInterests():Array
		{
			var interests:Array = super.listNotificationInterests();
			interests.push( ShellFacade.KILL_LOGGER);
			interests.push( ShellFacade.LOGGER_AVAILABLE_TO_CONNECT);
			interests.push( ShellFacade.REQUEST_LOG_WINDOW );
			interests.push( ShellFacade.REQUEST_LOG_BUTTON );
			interests.push( ShellFacade.CONNECT_MODULE_TO_SHELL );
			return interests;
		}

		/**
		 * Handle ShellJunction related Notifications.
		 */
		override public function handleNotification( __note:INotification ):void
		{
			
			switch( __note.getName() )
			{
				case ShellFacade.KILL_LOGGER :
					sendNotification(LogMessage.SEND_TO_LOG,"Request about to send to destroy Logger core.",LogMessage.LEVELS[LogMessage.DEBUG]);
					junction.sendMessage(GBPipeAwareFlexCore.STDLOG, new UIQueryMessage(GBNotifications.DESTROY, Cores.LOGGER));
					trace("logger destroyed = " + (!Facade.hasCore(Cores.LOGGER)));
					break;
				
				case ShellFacade.LOGGER_AVAILABLE_TO_CONNECT :
					sendNotification(ShellFacade.CONNECT_SHELL_TO_LOGGER, junction );
					sendNotification(ShellFacade.REQUEST_LOG_BUTTON);
					break;
							
				case ShellFacade.REQUEST_LOG_BUTTON:
					sendNotification(LogMessage.SEND_TO_LOG,"Requesting log button from LoggerModule.",LogMessage.LEVELS[LogMessage.DEBUG]);
					junction.sendMessage(GBPipeAwareFlexCore.STDLOG,new UIQueryMessage(UIQueryMessage.GET,LoggerModule.LOG_BUTTON_UI));
					break;

				case ShellFacade.REQUEST_LOG_WINDOW:
					sendNotification(LogMessage.SEND_TO_LOG,"Requesting log window from LoggerModule.",LogMessage.LEVELS[LogMessage.DEBUG]);
					junction.sendMessage(GBPipeAwareFlexCore.STDLOG,new UIQueryMessage(UIQueryMessage.GET,LoggerModule.LOG_WINDOW_UI));
					break;

				case  ShellFacade.CONNECT_MODULE_TO_SHELL:
					sendNotification(LogMessage.SEND_TO_LOG,"Connecting new module instance to Shell.",LogMessage.LEVELS[LogMessage.DEBUG]);

					// Connect a module's STDSHELL to the shell's STDIN
					var module:IPipeAware = __note.getBody() as IPipeAware;
					var moduleToShell:Pipe = new Pipe();
					module.acceptOutputPipe(GBPipeAwareFlexCore.STDSHELL, moduleToShell);
					var shellIn:TeeMerge = junction.retrievePipe(GBPipeAwareFlexCore.STDIN) as TeeMerge;
					shellIn.connectInput(moduleToShell);
					
					// Connect the shell's STDOUT to the module's STDIN
					var shellToModule:Pipe = new Pipe();
					module.acceptInputPipe(GBPipeAwareFlexCore.STDIN, shellToModule);
					var shellOut:IPipeFitting = junction.retrievePipe(GBPipeAwareFlexCore.STDOUT) as IPipeFitting;
					shellOut.connect(shellToModule);
					break;

				// Let super handle the rest (ACCEPT_OUTPUT_PIPE, ACCEPT_INPUT_PIPE, SEND_TO_LOG)								
				default:
					super.handleNotification(__note);
					
			}
		}
		
		/**
		 * Handle incoming pipe messages for the ShellJunction.
		 * <P>
		 * The LoggerModule sends its LogButton and LogWindow instances
		 * to the Shell for display management via an output Pipe it 
		 * knows as STDSHELL. The PrattlerModule instances also send
		 * their manufactured FeedWindow instances to the shell via
		 * their STDSHELL pipe. Those messages all show up and are
		 * handled here.</P>
		 * <P>
		 * Note that we are handling PipeMessages with the same idiom
		 * as Notifications. Conceptually they are the same, and the
		 * Mediator role doesn't change much. It takes these messages
		 * and turns them into notifications to be handled by other 
		 * actors in the main app / shell.</P> 
		 * <P>
		 * Also, it is logging its actions by sending INFO messages
		 * to the STDLOG output pipe.</P> 
		 */
		override public function handlePipeMessage( __message:IPipeMessage ):void
		{
			if ( __message is UIQueryMessage )
			{
				switch ( UIQueryMessage(__message).name )
				{
					case LoggerModule.LOG_BUTTON_UI:
						sendNotification(ShellFacade.SHOW_LOG_BUTTON, UIQueryMessage(__message).component, UIQueryMessage(__message).name )
						junction.sendMessage(GBPipeAwareFlexCore.STDLOG,new LogMessage(LogMessage.INFO,this.multitonKey,'Recieved the Log Button on STDSHELL'));
						break;

					case LoggerModule.LOG_WINDOW_UI:
						sendNotification(ShellFacade.SHOW_LOG_WINDOW, UIQueryMessage(__message).component, UIQueryMessage(__message).name )
						junction.sendMessage(GBPipeAwareFlexCore.STDLOG,new LogMessage(LogMessage.INFO,this.multitonKey,'Recieved the Log Window on STDSHELL'));
						break;
				}
			}
			else if (__message is LogMessage)
			{
				junction.sendMessage(GBPipeAwareFlexCore.STDLOG, __message);
			}
			else if (__message is Message)
			{
				junction.sendMessage(GBPipeAwareFlexCore.STDLOG, new LogMessage(LogMessage.INFO, this.multitonKey, 'Logger core startup pipe message received on STDSHELL'));
			}
		}
	}
}