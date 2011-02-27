package org.floxy
{
	import org.flemit.reflection.MemberVisibility;
	import org.flemit.reflection.MethodInfo;
	import org.flemit.reflection.ParameterInfo;
	import org.flemit.reflection.PropertyInfo;
	import org.flemit.reflection.Type;

	public class FunctionInvocation implements IInvocation
	{
		private var _target : Function;
		private var _args : Array;
		private var _method : MethodInfo;
		private var _returnValue : Object;
		
		public function FunctionInvocation(target : Function, methodInfo : MethodInfo, args : Array)
		{
			_target = target;
			_method = methodInfo;
			_args = args;
		}

		public function get arguments():Array
		{
			return _args;
		}
		
		public function get targetType():Type
		{
			return null;
		}
		
		public function get proxy():Object
		{
			return _target as Object;
		}
		
		public function get method():MethodInfo
		{
			return _method;
		}
		
		public function get property():PropertyInfo
		{
			return null;
		}
		
		public function get invocationTarget():Object
		{
			return _target as Object;
		}
		
		public function get methodInvocationTarget():MethodInfo
		{
			return method;
		}
		
		public function get returnValue():Object
		{
			return _returnValue;
		}
		
		public function set returnValue(value:Object):void
		{
			_returnValue = value;
		}
		
		public function get canProceed():Boolean
		{
			return false;
		}
		
		public function proceed():void
		{
		}
		
	}
}