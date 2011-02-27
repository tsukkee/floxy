package org.floxy.tests.integration
{
	import org.floxy.IInterceptor;
	import org.floxy.IInvocation;
	
	public class MockIntercepter implements IInterceptor
	{
		private var _invocations : Array = new Array();
		
		private var _interceptCallback : Function;
		
		public function MockIntercepter(interceptCallback : Function = null)
		{
			_interceptCallback = interceptCallback;
		}
	
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
			
			if (_interceptCallback != null)
			{
				_interceptCallback(invocation);
			}
		}
	}
}