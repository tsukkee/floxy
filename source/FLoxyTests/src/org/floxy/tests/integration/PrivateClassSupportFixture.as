package org.floxy.tests.integration
{
	import flash.errors.IllegalOperationError;
	import flash.events.ErrorEvent;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	
	import org.flexunit.async.Async;
	import org.floxy.IProxyRepository;
	import org.floxy.ProxyRepository;
	import org.floxy.tests.*;
	
	[TestCase]
	public class PrivateClassSupportFixture
	{
		private var _proxyRepository : IProxyRepository;

		[Test(async, expected="flash.errors.IllegalOperationError")]
		public function private_classes_are_not_supported() : void
		{
			_proxyRepository = new ProxyRepository();
			
			var result : IEventDispatcher = 
					_proxyRepository.prepare([PrivateClass], ApplicationDomain.currentDomain);
					
			result.addEventListener(ErrorEvent.ERROR, Async.asyncHandler(this, function(e:ErrorEvent, ... args):void
			{
				throw new IllegalOperationError(e.text);
								
			}, 1000));
		}
	}
}
	import org.floxy.tests.integration.IInterfaceB;
	import org.floxy.tests.integration.IInterfaceA;
	
class PrivateClass implements IInterfaceA, IInterfaceB
{
	public function getValueA() : int { return 0; }
	public function getValueB() : int { return 0; }
}

