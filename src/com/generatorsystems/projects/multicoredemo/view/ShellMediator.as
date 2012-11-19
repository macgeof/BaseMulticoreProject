package com.generatorsystems.projects.multicoredemo.view
{
	import com.gb.puremvc.model.messages.LogFilterMessage;
	import com.gb.puremvc.view.GBFlexMediator;
	import com.generatorsystems.projects.multicoredemo.ShellFacade;
	import com.generatorsystems.puremvc.multicore.cores.logger.view.components.LogWindow;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	import org.puremvc.as3.multicore.interfaces.IMediator;
	import org.puremvc.as3.multicore.interfaces.INotification;
	
	import spark.components.Button;
	import spark.components.TitleWindow;
	
	public class ShellMediator extends GBFlexMediator implements IMediator
	{
		public static const NAME:String = 'ApplicationMediator';
		
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
			return [ ShellFacade.SHOW_LOG_WINDOW,
				ShellFacade.SHOW_LOG_BUTTON,
				ShellFacade.SHOW_FEED_WINDOW
			];	
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
				case  ShellFacade.SHOW_LOG_BUTTON:
					var logButton:Button = __note.getBody() as Button;
					logButton.addEventListener(MouseEvent.CLICK, onLogButtonClick);
					app.addLogButton(__note.getBody() as Button); 
					break;
				
				case  ShellFacade.SHOW_LOG_WINDOW:
					if (_logWindow == null) {
						_logWindow = UIComponent(__note.getBody()) as LogWindow;
						_logWindow.addEventListener(Event.CLOSE, onLogWindowClose);
					}
					app.addLogWindow(_logWindow);
					_logWindowDisplayed=true;
					break;
				
			}
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
			if (_logWindow != null) {
				sendNotification(ShellFacade.SHOW_LOG_WINDOW, _logWindow)
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
			app.removeLogWindow(_logWindow); 	
			_logWindowDisplayed=false;
		}
		
		/**
		 * The Application component.
		 */
		private function get app():BaseMulticoreProject
		{
			return viewComponent as BaseMulticoreProject;
		}
		
		private var _logWindowDisplayed:Boolean = false;
		private var _logWindow:TitleWindow;
	}
}