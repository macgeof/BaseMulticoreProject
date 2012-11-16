package com.generatorsystems.base.cores.tools.messages
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.FilterControlMessage;
	import org.puremvc.as3.multicore.utilities.pipes.messages.Message;

	public class LogFilterMessage extends FilterControlMessage
	{
		protected static const BASE:String 			= FilterControlMessage.BASE+'/LoggerModule/'
		public static const LOG_FILTER_NAME:String 	= BASE+'/LoggerModule/logFilter/';
		public static const SET_LOG_LEVEL:String 	= BASE+'LoggerModule/setLogLevel';
		
		public var logLevel:Number;

		public function LogFilterMessage( __action:String, __logLevel:Number=0 )
		{
			super( __action, LOG_FILTER_NAME, null, {logLevel:__logLevel});
			this.logLevel=__logLevel; 
		}
		
		public static function filterLogByLevel( __message:IPipeMessage, __params:Object):void		
		{
			if (__message.getHeader().logLevel > __params.logLevel) { throw new Error(); }
		}
		
	}
}