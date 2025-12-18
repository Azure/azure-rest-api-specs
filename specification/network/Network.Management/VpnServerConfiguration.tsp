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
 * VpnServerConfiguration Resource.
 */
model VpnServerConfiguration
  is Azure.ResourceManager.ProxyResource<VpnServerConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = VpnServerConfiguration,
    KeyName = "vpnServerConfigurationName",
    SegmentName = "vpnServerConfigurations",
    NamePattern = ""
  >;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations
interface VpnServerConfigurations {
  /**
   * Retrieves the details of a VpnServerConfiguration.
   */
  get is ArmResourceRead<VpnServerConfiguration, Error = CloudError>;

  /**
   * Creates a VpnServerConfiguration resource if it doesn't exist else updates the existing VpnServerConfiguration.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VpnServerConfiguration,
    Error = CloudError
  >;

  /**
   * Updates VpnServerConfiguration tags.
   */
  @patch(#{ implicitOptionality: false })
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateTags is ArmCustomPatchSync<
    VpnServerConfiguration,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes a VpnServerConfiguration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VpnServerConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the vpnServerConfigurations in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VpnServerConfiguration,
    Response = ArmResponse<ListVpnServerConfigurationsResult>,
    Error = CloudError
  >;

  /**
   * Lists all the VpnServerConfigurations in a subscription.
   */
  list is ArmListBySubscription<
    VpnServerConfiguration,
    Response = ArmResponse<ListVpnServerConfigurationsResult>,
    Error = CloudError
  >;

  /**
   * List all Radius servers with respective radius secrets from VpnServerConfiguration.
   */
  @post
  listRadiusSecrets is ArmResourceActionSync<
    VpnServerConfiguration,
    void,
    ArmResponse<RadiusAuthServerListResult>,
    Error = CloudError
  >;
}

@@doc(VpnServerConfiguration.name,
  "The name of the VpnServerConfiguration being retrieved."
);
@@doc(VpnServerConfiguration.properties,
  "Properties of the P2SVpnServer configuration."
);
@@doc(VpnServerConfigurations.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update VpnServerConfiguration."
);
@@doc(VpnServerConfigurations.updateTags::parameters.properties,
  "Parameters supplied to update VpnServerConfiguration tags."
);
