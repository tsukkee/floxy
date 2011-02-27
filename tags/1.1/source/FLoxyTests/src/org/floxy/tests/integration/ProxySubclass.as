package org.floxy.tests.integration
{
	import flash.utils.Proxy;

	public class ProxySubclass extends Proxy
	{
		public function ProxySubclass()
		{
			super();
		}
		
		flash_proxy override function callProperty(name:*, ...rest):*
		{
			return null;
		}		
	}
}