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
 * VirtualWAN Resource.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
model VirtualWAN extends ResourceWithRequiredLocation {
  properties?: VirtualWanProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("VirtualWANName")
  @segment("virtualWans")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

alias VirtualWanOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the VirtualWAN. */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @path
    @segment("virtualWans")
    @key
    virtualWANName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualWAN)
@armResourceOperations
interface VirtualWANS {
  /**
   * Retrieves the details of a VirtualWAN.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualWans_Get")
  get is ArmResourceRead<VirtualWAN, Error = CloudError>;

  /**
   * Creates a VirtualWAN resource if it doesn't exist else updates the existing VirtualWAN.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualWans_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualWAN,
    Error = CloudError
  >;

  /**
   * Updates a VirtualWAN tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualWans_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    VirtualWAN,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes a VirtualWAN.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualWans_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualWAN,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualWANs in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualWans_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    VirtualWAN,
    Response = ArmResponse<ListVirtualWANsResult>,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualWANs in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualWans_List")
  list is ArmListBySubscription<
    VirtualWAN,
    Response = ArmResponse<ListVirtualWANsResult>,
    Error = CloudError
  >;

  /**
   * Gives the supported security providers for the virtual wan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("SupportedSecurityProviders")
  @get
  supportedSecurityProviders is VirtualWanOps.ActionSync<
    VirtualWAN,
    void,
    ArmResponse<VirtualWanSecurityProviders>,
    OverrideErrorType = CloudError
  >;

  /**
   * Generates a unique VPN profile for P2S clients for VirtualWan and associated VpnServerConfiguration combination in the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("generatevirtualwanvpnserverconfigurationvpnprofile")
  @action("GenerateVpnProfile")
  generatevirtualwanvpnserverconfigurationvpnprofile is VirtualWanOps.ActionAsync<
    VirtualWAN,
    VirtualWanVpnProfileParameters,
    VpnProfileResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gives the sas-url to download the configurations for vpn-sites in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnSitesConfiguration_Download")
  @action("vpnConfiguration")
  download is VirtualWanOps.ActionAsync<
    VirtualWAN,
    GetVpnSitesConfigurationRequest,
    Result = void,
    Response = {
      @body body: void;
    } | ArmAcceptedLroResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gives the list of VpnServerConfigurations associated with Virtual Wan in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VpnServerConfigurationsAssociatedWithVirtualWan_List")
  @action("vpnServerConfigurations")
  vpnServerConfigurationsAssociatedWithVirtualWanList is VirtualWanOps.ActionAsync<
    VirtualWAN,
    void,
    VpnServerConfigurationsResponse,
    OverrideErrorType = CloudError
  >;
}

@@doc(VirtualWAN.name, "The name of the VirtualWAN being retrieved.");
@@doc(VirtualWAN.properties, "Properties of the virtual WAN.");
@@doc(VirtualWANS.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update VirtualWAN."
);
@@doc(VirtualWANS.updateTags::parameters.properties,
  "Parameters supplied to Update VirtualWAN tags."
);
@@doc(VirtualWANS.generatevirtualwanvpnserverconfigurationvpnprofile::parameters.body,
  "Parameters supplied to the generate VirtualWan VPN profile generation operation."
);
@@doc(VirtualWANS.download::parameters.body,
  "Parameters supplied to download vpn-sites configuration."
);
