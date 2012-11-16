package com.generatorsystems.base.cores.tools.messages
{
	import mx.collections.ArrayCollection;
	
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;

	public class LogMessage extends BaseCoreMessage
	{
		public static const DEBUG:int	= 5;
		public static const INFO:int	= 4;
		public static const WARN:int	= 3;
		public static const ERROR:int	= 2;
		public static const FATAL:int	= 1; 
		public static const NONE:int	= 0; 
		
		public static const CHANGE:int	= -1; 

		public static const LEVELS:ArrayCollection = new ArrayCollection([ 'NONE', 'FATAL', 'ERROR', 'WARN', 'INFO', 'DEBUG' ]);
		 
		public static const SEND_TO_LOG:String = Message.BASE+'LoggerModule/sendToLog';

		public static const STDLOG:String = 'standardLog';
		
		public function LogMessage( __logLevel:int, __sender:String, __message:String  )
		{
			var __time:String = new Date().toString();
			var __headers:Object = {logLevel:__logLevel, sender:__sender, time:__time};
			super( Message.NORMAL, __headers, __message );
		}
		
		public function set logLevel(__logLevel:int):void
		{
			header.logLevel = __logLevel;
		}

		public function get logLevel():int
		{
			return header.logLevel as int;
		}
		
		public function get sender():String
		{
			return header.sender as String;
		}
		
		public function get time():String
		{
			return header.time as String;			
		}
		
		public function get message():String 
		{
			return body as String;			
		}
		
	}
}