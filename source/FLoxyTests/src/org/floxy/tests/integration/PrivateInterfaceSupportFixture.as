package org.floxy.tests.integration
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.getQualifiedSuperclassName;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.floxy.IProxyRepository;
	import org.floxy.ProxyRepository;
	import org.floxy.tests.*;
	
	[TestCase]
	public class PrivateInterfaceSupportFixture
	{
		private var _proxyRepository : IProxyRepository;
		
		[Before(async)]
		public function setupProxy() : void
		{
			_proxyRepository = new ProxyRepository();
			
			var result : IEventDispatcher = 
					_proxyRepository.prepare([ICombinedInterface], ApplicationDomain.currentDomain);
					
			result.addEventListener(Event.COMPLETE, Async.asyncHandler(this, function(... args):void
			{
								
			}, 1000));
		}
		
		[Test]
		public function can_be_used_as_multiple_public_interfaces() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter();
			
			var a : IInterfaceA =
				IInterfaceA(_proxyRepository.create(ICombinedInterface, [], interceptor));
			
			var b : IInterfaceB = Object(a) as IInterfaceB;
			
			a.getValueA();
			b.getValueB();
			
			Assert.assertEquals(2, interceptor.invocationCount);
		}
		
		[Test(expected="Error")]
		public function cannot_be_cast_to_original_private_type() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter();
			
			var a : ICombinedInterface =
				ICombinedInterface(_proxyRepository.create(ICombinedInterface, [], interceptor));
		}
	}
}
	import org.floxy.tests.integration.IInterfaceB;
	import org.floxy.tests.integration.IInterfaceA;
	
interface ICombinedInterface extends IInterfaceA, IInterfaceB
{
}

