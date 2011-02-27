package org.floxy.tests
{
	import org.floxy.tests.integration.*;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class IntegrationSuite
	{
		public var privateInterface : PrivateInterfaceSupportFixture;
		public var privateClass : PrivateClassSupportFixture;
		
		public var noPackageInterface : NoPackageInterfaceSupportFixture;
		public var noPackageClass : NoPackageClassSupportFixture;
		
		public var functionSupport : FunctionSupportFixture;
		
		//public var finalClassSupport : FinalClassSupportFixture;
	}
}