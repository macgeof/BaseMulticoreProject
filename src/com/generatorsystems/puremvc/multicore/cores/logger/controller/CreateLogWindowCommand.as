/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger.controller
{
    import com.generatorsystems.puremvc.multicore.cores.logger.ApplicationFacade;
    import com.generatorsystems.puremvc.multicore.cores.logger.model.LoggerProxy;
    import com.generatorsystems.puremvc.multicore.cores.logger.view.components.LogWindow;
    
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * Create the Log Window.
	 * <P>
	 * This command is triggered when the Shell sends a UIQueryMessage
	 * asking for the log button.
	 * <P>
	 * This command creates an instance of the custom LogButton component
	 * and sets its messages property to the LoggerProxy's ArrayCollection
	 * of messages. The LogWindow will automatically update its data grid
	 * of messages anytime a new message is added to the LoggerProxy.</P>
	 * <P>
	 * Finally, send the export notification which will be used to send
	 * the manufactured UI component back to the shell.</P>  
	 */
    public class CreateLogWindowCommand extends SimpleCommand implements ICommand
    {
        override public function execute(note:INotification):void
        {
			var proxy:LoggerProxy = facade.retrieveProxy(LoggerProxy.NAME) as LoggerProxy;
			var logWindow:LogWindow = new LogWindow();
			logWindow.messages = proxy.messages;
			sendNotification( ApplicationFacade.EXPORT_LOG_WINDOW, logWindow );
        }
        
    }
}