/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.projects.multicoredemo.view
{
	import com.gb.puremvc.GBPipeAwareFlexCore;
	import com.gb.puremvc.view.GBFlexMediator;
	import com.generatorsystems.projects.multicoredemo.ShellFacade;
	import com.generatorsystems.puremvc.multicore.cores.logger.LoggerModule;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeAware;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Junction;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.Pipe;
	import org.puremvc.as3.multicore.utilities.pipes.plumbing.TeeMerge;
	
	/**
	 * Mediator for the LoggerModule.
	 * <P>
	 * Instantiates and manages the LoggerModule for the application.</P>
	 * <P>
	 * Listens for Notifications to connect things to the 
	 * LoggerModule, which implements IPipeAware, an interface that
	 * requires methods for accepting input and output pipes.</P>
	 */
	public class LoggerModuleMediator extends GBFlexMediator
	{
		public static const NAME:String = 'LoggerModuleMediator';
		
		public function LoggerModuleMediator( )
		{
			super( NAME, new LoggerModule() );
		}

		/**
		 * LoggerModule related Notification list.
		 */
		override public function listNotificationInterests():Array
		{
			return [ ShellFacade.CONNECT_MODULE_TO_LOGGER,
					 ShellFacade.CONNECT_SHELL_TO_LOGGER 
			       ];	
		}
		
		/**
		 * Handle LoggerModule related Notifications.
		 * <P>
		 * Connecting modules and the Shell to the LoggerModule.
		 */
		override public function handleNotification( __note:INotification ):void
		{
			switch( __note.getName() )
			{
				// Connect any Module's STDLOG to the logger's STDIN
				case  ShellFacade.CONNECT_MODULE_TO_LOGGER:
					var __module:IPipeAware = __note.getBody() as IPipeAware;
					var __pipe:Pipe = new Pipe();
					__module.acceptOutputPipe(GBPipeAwareFlexCore.STDLOG,__pipe);
					loggerCore.acceptInputPipe(GBPipeAwareFlexCore.STDIN,__pipe);
					break;

				// Bidirectionally connect shell and logger on STDLOG/STDSHELL
				case  ShellFacade.CONNECT_SHELL_TO_LOGGER:
					// The junction was passed from ShellJunctionMediator
					var __junction:Junction = __note.getBody() as Junction;
					
					// Connect the shell's STDLOG to the logger's STDIN
					var __shellToLog:IPipeFitting = __junction.retrievePipe(GBPipeAwareFlexCore.STDLOG);
					loggerCore.acceptInputPipe(GBPipeAwareFlexCore.STDIN, __shellToLog);
					
					// Connect the logger's STDSHELL to the shell's STDIN
					var __logToShell:Pipe = new Pipe();
					var __shellIn:TeeMerge = __junction.retrievePipe(GBPipeAwareFlexCore.STDIN) as TeeMerge;
					__shellIn.connectInput(__logToShell);
					loggerCore.acceptOutputPipe(GBPipeAwareFlexCore.STDSHELL,__logToShell);
					break;
			}
		}
		
		/**
		 * The Logger Module.
		 */
		private function get loggerCore():LoggerModule
		{
			return viewComponent as LoggerModule;
		}
		
	
	}
}