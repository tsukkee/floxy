package org.floxy.tests.integration
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.system.ApplicationDomain;
	
	import org.flemit.reflection.MethodInfo;
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.floxy.IInvocation;
	import org.floxy.IProxyRepository;
	import org.floxy.ProxyRepository;
	import org.floxy.tests.*;
	
	[TestCase]
	public class FunctionSupportFixture
	{
		private var _proxyRepository : IProxyRepository;
		
		[Before(async)]
		public function setupProxy() : void
		{
			_proxyRepository = new ProxyRepository();
			
			var result : IEventDispatcher = 
					_proxyRepository.prepare([Function], ApplicationDomain.currentDomain);
					
			result.addEventListener(Event.COMPLETE, Async.asyncHandler(this, function(... args):void
			{
								
			}, 1000));
		}
		
		[Test]
		public function returns_a_function_instance() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter();
			
			var a : Function =
				_proxyRepository.create(Function, [], interceptor) as Function;
			
			Assert.assertNotNull(a);
		}
		
		[Test]
		public function can_be_called_with_no_arguments() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter();
			
			var a : Function =
				_proxyRepository.create(Function, [], interceptor) as Function;
			
			a();
			
			Assert.assertEquals(1, interceptor.invocationCount);
		}
		
		[Test]
		public function can_be_called_with_arguments() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter();
			
			var a : Function =
				_proxyRepository.create(Function, [], interceptor) as Function;
			
			var objectArg : Object = new Object();
			
			a(1, "test", objectArg);
			
			Assert.assertEquals(1, interceptor.invocationCount);
			Assert.assertStrictlyEquals(1, interceptor.invocations[0].arguments[0]);
			Assert.assertStrictlyEquals("test", interceptor.invocations[0].arguments[1]);
			Assert.assertStrictlyEquals(objectArg, interceptor.invocations[0].arguments[2]);
		}
		
		[Test]
		public function can_return_a_value() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter(function(invocation : IInvocation) : void
			{
				invocation.returnValue = 5;
			});
			
			var a : Function =
				_proxyRepository.create(Function, [], interceptor) as Function;
			
			var objectArg : Object = new Object();
			
			var returnValue : int = a(1, "test", objectArg);
			
			Assert.assertEquals(1, interceptor.invocationCount);
			Assert.assertStrictlyEquals(5, returnValue);
		}
		
		[Test]
		public function passes_function_reference_to_intercepter() : void
		{
			var interceptor : MockIntercepter = new MockIntercepter(function(invocation : IInvocation) : void
			{
				Assert.assertTrue(invocation.proxy is Function);
			});
			
			var a : Function =
				_proxyRepository.create(Function, [], interceptor) as Function;
			
			var objectArg : Object = new Object();
			
			a(1, "test", objectArg);
			
			Assert.assertEquals(1, interceptor.invocationCount);
		}
		
		[Test]
		public function invocations_always_have_the_same_methodinfo() : void
		{
			var methodInfo : MethodInfo = null;
			
			var interceptor : MockIntercepter = new MockIntercepter(function(invocation : IInvocation) : void
			{
				if (methodInfo == null)
				{
					Assert.assertNotNull(invocation.method);
					
					methodInfo = invocation.method;
				}
				else
				{
					Assert.assertStrictlyEquals(methodInfo, invocation.method);
				}
			});
			
			var a : Function =
				_proxyRepository.create(Function, [], interceptor) as Function;
			
			a();
			a();
		}
	}
}

