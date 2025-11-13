import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VpnSite.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * VpnSiteLink Resource.
 */
@parentResource(VpnSite)
model VpnSiteLink
  is Azure.ResourceManager.ProxyResource<VpnSiteLinkProperties> {
  ...ResourceNameParameter<
    Resource = VpnSiteLink,
    KeyName = "vpnSiteLinkName",
    SegmentName = "vpnSiteLinks",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface VpnSiteLinks {
  /**
   * Retrieves the details of a VPN site link.
   */
  get is ArmResourceRead<VpnSiteLink>;

  /**
   * Lists all the vpnSiteLinks in a resource group for a vpn site.
   */
  listByVpnSite is ArmResourceListByParent<
    VpnSiteLink,
    Response = ArmResponse<ListVpnSiteLinksResult>
  >;
}

@@doc(VpnSiteLink.name, "The name of the VpnSiteLink being retrieved.");
@@doc(VpnSiteLink.properties, "Properties of the VPN site link.");
