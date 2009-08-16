package org.floxy
{
	internal interface IProxyListener
	{
		function methodExecuted(target : Object, methodType : uint, methodName : String, arguments : Array, baseMethod : Function) : *;
	}
}