/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger.controller
{
    import com.generatorsystems.base.cores.tools.messages.LogMessage;
    import com.generatorsystems.puremvc.multicore.cores.logger.model.LoggerProxy;
    
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * Add an entry in the log.
	 * <P>
	 * This command is triggered when a LogMessage comes in, and adds it to 
	 * the LoggerProxy. The LoggerProxy uses an ArrayCollection for its list,
	 * so any UI controls listening to it will be updated automatically.</P>
	 */
    public class LogMessageCommand extends SimpleCommand implements ICommand
    {
        override public function execute(note:INotification):void
        {
			var proxy:LoggerProxy = facade.retrieveProxy(LoggerProxy.NAME) as LoggerProxy;
			proxy.addLogEntry( note.getBody() as LogMessage );
			
        }
        
    }
}