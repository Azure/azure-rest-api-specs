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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@parentResource(VpnSite)
@Http.Private.includeInapplicableMetadataInPayload(false)
model VpnSiteLink extends SubResourceModel {
  properties?: VpnSiteLinkProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("vpnSiteLinkName")
  @segment("vpnSiteLinks")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface VpnSiteLinks {
  /**
   * Retrieves the details of a VPN site link.
   */
  get is ArmResourceRead<VpnSiteLink, Error = CloudError>;

  /**
   * Lists all the vpnSiteLinks in a resource group for a vpn site.
   */
  listByVpnSite is ArmResourceListByParent<
    VpnSiteLink,
    Response = ArmResponse<ListVpnSiteLinksResult>,
    Error = CloudError
  >;
}

@@doc(VpnSiteLink.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(VpnSiteLink.properties, "Properties of the VPN site link.");
