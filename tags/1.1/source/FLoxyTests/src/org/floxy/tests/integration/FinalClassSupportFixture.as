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
	public class FinalClassSupportFixture
	{
		private var _proxyRepository : IProxyRepository;

		[Test(async, expected="ArgumentError")]
		public function final_classes_are_not_supported() : void
		{
			_proxyRepository = new ProxyRepository();
			
			var result : IEventDispatcher = 
					_proxyRepository.prepare([FinalClass], ApplicationDomain.currentDomain);
					
			result.addEventListener(ErrorEvent.ERROR, Async.asyncHandler(this, function(e:ErrorEvent, ... args):void
			{
				throw new IllegalOperationError(e.text);
								
			}, 1000));
		}
	}
}
