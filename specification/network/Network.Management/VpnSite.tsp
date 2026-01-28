import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * VpnSite Resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model VpnSite extends ResourceWithRequiredLocation {
  properties?: VpnSiteProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("vpnSiteName")
  @segment("vpnSites")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface VpnSites {
  /**
   * Retrieves the details of a VPN site.
   */
  get is ArmResourceRead<VpnSite, Error = CloudError>;

  /**
   * Creates a VpnSite resource if it doesn't exist else updates the existing VpnSite.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VpnSite,
    Error = CloudError
  >;

  /**
   * Updates VpnSite tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    VpnSite,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes a VpnSite.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VpnSite,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the vpnSites in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VpnSite,
    Response = ArmResponse<ListVpnSitesResult>,
    Error = CloudError
  >;

  /**
   * Lists all the VpnSites in a subscription.
   */
  list is ArmListBySubscription<
    VpnSite,
    Response = ArmResponse<ListVpnSitesResult>,
    Error = CloudError
  >;
}

@@doc(VpnSite.name, "The name of the VpnSite being retrieved.");
@@doc(VpnSite.properties, "Properties of the VPN site.");
@@doc(VpnSites.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update VpnSite."
);
@@doc(VpnSites.updateTags::parameters.properties,
  "Parameters supplied to update VpnSite tags."
);
