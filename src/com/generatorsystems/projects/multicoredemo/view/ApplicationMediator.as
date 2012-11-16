package com.generatorsystems.projects.multicoredemo.view
{
	import com.generatorsystems.base.cores.tools.messages.LogFilterMessage;
	import com.generatorsystems.projects.multicoredemo.ApplicationFacade;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;
	
	import spark.components.Button;
	import spark.components.TitleWindow;
	
	public class ApplicationMediator extends Mediator implements IMediator
	{
		public static const NAME:String = 'ApplicationMediator';
		
		public function ApplicationMediator(mediatorName:String, viewComponent:BaseMulticoreProject)
		{			
			super(mediatorName, viewComponent);
		}
		
		/**
		 * Register event listeners with the app and its fixed controls.
		 */
		override public function onRegister():void
		{		
			app.addEventListener( BaseMulticoreProject.LOG_LEVEL, onLogLevel );		
		}
		
		/**
		 * Application related Notification list.
		 */
		override public function listNotificationInterests():Array
		{
			return [ ApplicationFacade.SHOW_LOG_WINDOW,
				ApplicationFacade.SHOW_LOG_BUTTON,
				ApplicationFacade.SHOW_FEED_WINDOW
			];	
		}
		
		/**
		 * Handle MainApp / Shell related notifications.
		 * <P>
		 * Display and/or remove the module-manufactured LogButton, 
		 * LogWindow, and FeedWindows.</P>
		 */
		override public function handleNotification( note:INotification ):void
		{
			switch( note.getName() )
			{
				case  ApplicationFacade.SHOW_LOG_BUTTON:
					var logButton:Button = note.getBody() as Button;
					logButton.addEventListener(MouseEvent.CLICK, onLogButtonClick);
					app.addLogButton(note.getBody() as Button); 
					break;
				
				case  ApplicationFacade.SHOW_LOG_WINDOW:
					if (logWindow == null) {
						logWindow = UIComponent(note.getBody()) as TitleWindow;
						logWindow.addEventListener(Event.CLOSE, onLogWindowClose);
					}
					app.addLogWindow(logWindow);
					logWindowDisplayed=true;
					break;
				
			}
		}
		
		/**
		 * Log LevelChanged.
		 * <P>
		 * Change the LogLevel.</P>
		 */
		private function onLogLevel(event:Event):void
		{
			sendNotification(LogFilterMessage.SET_LOG_LEVEL,app.logLevel);
		}
		
		/**
		 * Log Window button clicked.
		 * <P>
		 * If the window hasn't been created yet, request
		 * it. If the window exists but is open, close it,
		 * or visaversa.</P>
		 */
		private function onLogButtonClick(event:Event):void
		{
			if (logWindowDisplayed) return onLogWindowClose(event);
			if (logWindow != null) {
				sendNotification(ApplicationFacade.SHOW_LOG_WINDOW, logWindow)
			} else {
				sendNotification(ApplicationFacade.REQUEST_LOG_WINDOW);
			}
		}
		
		/**
		 * Close the Log Window Popup. 
		 * <P>
		 * We keep the log window around and reuse 
		 * it each time you, so we leave the event listener in place.</P>
		 */
		private function onLogWindowClose(event:Event):void
		{
			app.removeLogWindow(logWindow); 	
			logWindowDisplayed=false;
		}
		
		/**
		 * The Application component.
		 */
		private function get app():BaseMulticoreProject
		{
			return viewComponent as BaseMulticoreProject;
		}
		
		private var logWindowDisplayed:Boolean = false;
		private var logWindow:TitleWindow;
	}
}