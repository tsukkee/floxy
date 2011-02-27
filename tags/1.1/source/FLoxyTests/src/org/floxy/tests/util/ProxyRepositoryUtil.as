package org.floxy.tests.util
{
	import flash.events.Event;
	import flash.net.Socket;
	
	import org.floxy.ProxyLoadingEvent;
	import org.floxy.ProxyRepository;
	
	public class ProxyRepositoryUtil
	{
		public static function writeProxyByteCodeDataToServer(proxyRepo : ProxyRepository, host : String, port : int, cancelLoad : Boolean) : void
		{
			proxyRepo.addEventListener(ProxyLoadingEvent.PROXY_LOADING, function(e:ProxyLoadingEvent):void
			{
				if (cancelLoad) e.preventDefault();
				
				var socket : Socket = new Socket();
				socket.connect(host, port);
				socket.addEventListener(Event.CONNECT, function(_:Event):void
				{
					socket.writeBytes(e.data);
					socket.flush();
					socket.close();
				});
			});
		}

	}
}