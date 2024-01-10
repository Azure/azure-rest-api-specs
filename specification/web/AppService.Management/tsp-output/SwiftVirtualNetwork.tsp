import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.CertificateRegistration;
@doc("Swift Virtual Network Contract. This is used to enable the new Swift way of doing virtual network integration.")
@singleton("virtualNetwork")
@parentResource(Site)
model SwiftVirtualNetwork is ProxyResource<SwiftVirtualNetworkProperties> {
  @key("networkConfig")
  @segment("networkConfig")
  name: string;
}

@armResourceOperations
@projectedName("client", "WebApps")
interface SwiftVirtualNetworks_WebApps {
  @doc("Description for Gets a Swift Virtual Network connection.")
  getSwiftVirtualNetworkConnection is ArmResourceRead<SwiftVirtualNetwork>;

  @doc("""
Description for Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  createOrUpdateSwiftVirtualNetworkConnectionWithCheck is ArmResourceCreateOrReplaceSync<SwiftVirtualNetwork>;

  @doc("""
Description for Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  updateSwiftVirtualNetworkConnectionWithCheck is ArmCustomPatchSync<
    SwiftVirtualNetwork,
    SwiftVirtualNetwork
  >;

  @doc("Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).")
  deleteSwiftVirtualNetwork is ArmResourceDeleteSync<SwiftVirtualNetwork>;
}
