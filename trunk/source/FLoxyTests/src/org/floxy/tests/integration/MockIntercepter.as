package org.floxy.tests.integration
{
	import org.floxy.IInterceptor;
	import org.floxy.IInvocation;
	
	public class MockIntercepter implements IInterceptor
	{
		private var _invocations : Array = new Array();
	
		public function get invocationCount() : int
		{
			return _invocations.length;
		}
		
		public function get invocations() : Array
		{
			return _invocations;
		}
		
		public function intercept(invocation : IInvocation) : void
		{
			_invocations.push(invocation);
		}
	}
}