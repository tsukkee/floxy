package org.floxy.tests
{
	import org.floxy.tests.integration.NoPackageClassSupportFixture;
	import org.floxy.tests.integration.PrivateClassSupportFixture;
	import org.floxy.tests.integration.PrivateInterfaceSupportFixture;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class IntegrationSuite
	{
		public var privateInterface : PrivateInterfaceSupportFixture;
		public var privateClass : PrivateClassSupportFixture;
		
		public var noPackageClass : NoPackageClassSupportFixture;
	}
}