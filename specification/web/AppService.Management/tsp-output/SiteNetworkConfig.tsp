import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Swift Virtual Network Contract. This is used to enable the new Swift way of doing virtual network integration.")
@parentResource(WebSite)
@singleton("virtualNetwork")
model SiteNetworkConfig is ProxyResource<SwiftVirtualNetworkProperties> {
  @key("virtualNetwork")
  @segment("networkConfig")
  name: string;
}

@armResourceOperations
interface SiteNetworkConfigs {
  @doc("Description for Gets a Swift Virtual Network connection.")
  getSwiftVirtualNetworkConnection is ArmResourceRead<SiteNetworkConfig>;
  @doc("""
Description for Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  createOrUpdateSwiftVirtualNetworkConnectionWithCheck is ArmResourceCreateOrReplaceSync<SiteNetworkConfig>;
  @doc("""
Description for Integrates this Web App with a Virtual Network. This requires that 1) \"swiftSupported\" is true when doing a GET against this resource, and 2) that the target Subnet has already been delegated, and is not
in use by another App Service Plan other than the one this App is in.
""")
  updateSwiftVirtualNetworkConnectionWithCheck is ArmResourcePatchSync<
    SiteNetworkConfig,
    SwiftVirtualNetworkProperties
  >;
  @doc("Description for Deletes a Swift Virtual Network connection from an app (or deployment slot).")
  deleteSwiftVirtualNetwork is ArmResourceDeleteSync<SiteNetworkConfig>;
}
