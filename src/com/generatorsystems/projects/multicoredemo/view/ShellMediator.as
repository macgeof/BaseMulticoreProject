package com.generatorsystems.projects.multicoredemo.view
{
	import com.gb.puremvc.model.enum.GBNotifications;
	import com.gb.puremvc.model.messages.LogFilterMessage;
	import com.gb.puremvc.view.GBFlexMediator;
	import com.generatorsystems.projects.multicoredemo.ShellFacade;
	import com.generatorsystems.projects.multicoredemo.model.enums.Cores;
	import com.generatorsystems.puremvc.multicore.cores.logger.view.components.LogWindow;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.facade.Facade;
	
	import spark.components.Button;
	import spark.components.TitleWindow;
	
	public class ShellMediator extends GBFlexMediator implements IMediator
	{
		public static const NAME:String = 'ApplicationMediator';
		
		private var _logWindowDisplayed:Boolean = false;
		
		public function ShellMediator(__mediatorName:String, __viewComponent:BaseMulticoreProject)
		{			
			super(__mediatorName, __viewComponent);
			
		}
		
		/**
		 * Register event listeners with the app and its fixed controls.
		 */
		override public function onRegister():void
		{
			super.onRegister();
			
			app.addEventListener( BaseMulticoreProject.LOG_LEVEL, onLogLevel );	
			app.killCreateLogger.addEventListener(MouseEvent.CLICK, _killCreateLogger_Handler);	
			app.killCreateWelcome.addEventListener(MouseEvent.CLICK, _killCreateWelcome_Handler);	
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		/**
		 * Application related Notification list.
		 */
		override public function listNotificationInterests():Array
		{
			var __interests:Array = super.listNotificationInterests();
			__interests.push(
					GBNotifications.DESTROY,
					GBNotifications.STARTUP_COMPLETE,
					ShellFacade.SHOW_LOG_WINDOW,
					ShellFacade.SHOW_LOG_BUTTON,
					ShellFacade.SHOW_FEED_WINDOW
			);
				
				return __interests;
		}
		
		/**
		 * Handle MainApp / Shell related notifications.
		 * <P>
		 * Display and/or remove the module-manufactured LogButton, 
		 * LogWindow, and FeedWindows.</P>
		 */
		override public function handleNotification( __note:INotification ):void
		{
			switch( __note.getName() )
			{
				case GBNotifications.DESTROY :
					var __targetToDestroy:String = __note.getBody().toString();
					if (app.logButton && app.logButton.hasEventListener(MouseEvent.CLICK))
					{
						app.logButton.removeEventListener(MouseEvent.CLICK, onLogButtonClick);
						app.removeLogGUI();
					}
					_logWindowDisplayed = false;
					break;
				
				case GBNotifications.STARTUP_COMPLETE :
					 
					break;
				
				case  ShellFacade.SHOW_LOG_BUTTON:
					var logButton:Button = __note.getBody() as Button;
					logButton.addEventListener(MouseEvent.CLICK, onLogButtonClick);
					app.addLogButton(__note.getBody() as Button); 
					break;
				
				case  ShellFacade.SHOW_LOG_WINDOW:
					if (app.logWindow == null) {
						app.logWindow = UIComponent(__note.getBody()) as LogWindow;
						app.logWindow.addEventListener(Event.CLOSE, onLogWindowClose);
					}
					app.addLogWindow();
					_logWindowDisplayed=true;
					break;
				
			}
			
			super.handleNotification(__note);
		}
		
		/**
		 * Log LevelChanged.
		 * <P>
		 * Change the LogLevel.</P>
		 */
		private function onLogLevel(__event:Event):void
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
		private function onLogButtonClick(__event:Event):void
		{
			if (_logWindowDisplayed) return onLogWindowClose(__event);
			if (app.logWindow != null) {
				sendNotification(ShellFacade.SHOW_LOG_WINDOW, app.logWindow)
			} else {
				sendNotification(ShellFacade.REQUEST_LOG_WINDOW);
			}
		}
		
		/**
		 * Close the Log Window Popup. 
		 * <P>
		 * We keep the log window around and reuse 
		 * it each time you, so we leave the event listener in place.</P>
		 */
		private function onLogWindowClose(__event:Event):void
		{
			app.removeLogWindow(); 	
			_logWindowDisplayed=false;
		}
		
		private function _killCreateLogger_Handler(__event:MouseEvent):void
		{
			var __noteName:String = (Facade.hasCore(Cores.LOGGER)) ? ShellFacade.KILL_LOGGER : ShellFacade.CREATE_LOGGER;
			sendNotification(__noteName);
		}
		
		private function _killCreateWelcome_Handler(__event:MouseEvent):void
		{
			var __noteName:String = (Facade.hasCore(Cores.WELCOME)) ? ShellFacade.KILL_WELCOME : ShellFacade.CREATE_WELCOME;
			sendNotification(__noteName);
		}
		
		/**
		 * The Application component.
		 */
		private function get app():BaseMulticoreProject
		{
			return viewComponent as BaseMulticoreProject;
		}
		
	}
}