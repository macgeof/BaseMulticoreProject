/*
 PureMVC AS3 MultiCore Demo – Flex PipeWorks 
 Copyright (c) 2008 Cliff Hall <cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package com.generatorsystems.projects.multicoredemo.controller
{
    import com.generatorsystems.projects.multicoredemo.ShellFacade;
    import com.generatorsystems.projects.multicoredemo.model.ShellDataProxy;
    import com.generatorsystems.projects.multicoredemo.view.LoggerCoreMediator;
    import com.generatorsystems.projects.multicoredemo.view.ShellJunctionMediator;
    import com.generatorsystems.projects.multicoredemo.view.WelcomeCoreMediator;
    
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
			super.execute(note);
			
			
			// Create and Register the Application and its Mediator
			var __app:BaseMulticoreProject = note.getBody() as BaseMulticoreProject;
			var __mediator:Class = __app.applicationMediator;
			facade.registerMediator(new __mediator(__mediator.NAME, __app));
			
			facade.registerProxy(new ShellDataProxy(ShellDataProxy.NAME));
       		
       		// Create and Register the Shell Junction and its Mediator
			facade.registerMediator(new ShellJunctionMediator(ShellJunctionMediator.NAME));
			
			// Create and Register the Logger Module and its Mediator
			facade.registerMediator(new LoggerCoreMediator(LoggerCoreMediator.NAME));
			
			// Create and Register the Welcome Module and its Mediator
			facade.registerMediator(new WelcomeCoreMediator(WelcomeCoreMediator.NAME));

			sendNotification(ShellFacade.CREATE_LOGGER);
        }
        
    }
}