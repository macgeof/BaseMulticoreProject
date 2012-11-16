/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.projects.multicoredemo.controller
{
    import com.generatorsystems.projects.multicoredemo.ShellFacade;
    import com.generatorsystems.projects.multicoredemo.tools.ShellJunctionMediator;
    import com.generatorsystems.projects.multicoredemo.view.ShellMediator;
    import com.generatorsystems.projects.multicoredemo.view.LoggerModuleMediator;
    
    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	/**
	 * Startup the Main Application/Shell.
	 * <P>
	 * Create and register ApplicationMediator which will own and 
	 * manage the app and its visual components.<P>
	 * <P>
	 * Create and register LoggerModuleMediator which will own
	 * the logger module and be responsible for connecting things
	 * to it via pipes.</P>
	 * <P>
	 * Create and register ShellJunctionMediator which will own
	 * and manage the Junction for the Main App/Shell.</P>
	 * <P>
	 * Send a notification to request the LogButton UI component.
	 * This will result in a UIQueryMessage being sent to the 
	 * LoggerModule, and the LoggerModule will respond by creating
	 * the button and sending it back to the shell, where it will
	 * be placed in the visual hierarchy of the Main Application.</P>
	 */
    public class StartupCommand extends SimpleCommand implements ICommand
    {
        override public function execute(note:INotification):void
        {
			// Create and Register the Logger Module and its Mediator
       		facade.registerMediator(new LoggerModuleMediator());
       		
       		// Create and Register the Shell Junction and its Mediator
			facade.registerMediator(new ShellJunctionMediator());

			// Create and Register the Application and its Mediator
        	var app:BaseMulticoreProject = note.getBody() as BaseMulticoreProject;
       		facade.registerMediator(new ShellMediator(ShellMediator.NAME, app));
			
			// Request the Log Button UI from the Logger Module       		
			sendNotification(ShellFacade.REQUEST_LOG_BUTTON);
        }
        
    }
}