package org.floxy.tests.util
{
	import flash.net.Socket;
	
	import org.floxy.ProxyLoadingEvent;
	
	public class ProxyRepositoryUtil
	{
		public static function writeProxyByteCodeDataToServer(proxyRepo : ProxyRepository, host : String, port : int, cancelLoad : Boolean) : void
		{
			proxyRepo.addEventListener(ProxyLoadingEvent.PROXY_LOADING, function(e:ProxyLoadingEvent):void
			{
				e.preventDefault();
				
				var socket : Socket = new Socket();
				socket.connect("127.0.0.1", 30095);
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