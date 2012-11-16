/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.puremvc.multicore.cores.logger.controller
{
    import com.generatorsystems.puremvc.multicore.cores.logger.LoggerFacade;
    import com.generatorsystems.puremvc.multicore.cores.logger.model.LoggerProxy;
    import com.generatorsystems.puremvc.multicore.cores.logger.view.components.LogButton;
    
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * Create the Log Button.
	 * <P>
	 * This command is triggered when the Shell sends a UIQueryMessage
	 * asking for the log button.
	 * <P>
	 * This command creates an instance of the custom LogButton component
	 * and sets its messages property to the LoggerProxy's ArrayCollection
	 * of messages. The LogButton will automatically update its count of
	 * messages anytime a new message is added to the LoggerProxy.</P>
	 * <P>
	 * Finally, send the export notification which will be used to send
	 * the manufactured UI component back to the shell.</P>  
	 */
    public class CreateLogButtonCommand extends SimpleCommand implements ICommand
    {
        override public function execute(note:INotification):void
        {
			var proxy:LoggerProxy = facade.retrieveProxy(LoggerProxy.NAME) as LoggerProxy;
			var logButton:LogButton = new LogButton();
			logButton.messages = proxy.messages;
			sendNotification( LoggerFacade.EXPORT_LOG_BUTTON, logButton );
        }
        
    }
}