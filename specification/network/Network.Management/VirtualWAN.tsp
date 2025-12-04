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
model VirtualWAN
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<VirtualWanProperties> {
  ...ResourceNameParameter<
    Resource = VirtualWAN,
    KeyName = "VirtualWANName",
    SegmentName = "virtualWans",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
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
    @path
    @segment("virtualWans")
    @key
    virtualWANName: string;
  }
>;

@armResourceOperations
interface VirtualWANS {
  /**
   * Retrieves the details of a VirtualWAN.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualWans_Get")
  get is ArmResourceRead<VirtualWAN, Error = CloudError>;

  /**
   * Creates a VirtualWAN resource if it doesn't exist else updates the existing VirtualWAN.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualWans_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualWAN,
    Error = CloudError
  >;

  /**
   * Updates a VirtualWAN tags.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("VirtualWans_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualWAN,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualWANs in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualWans_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    VirtualWAN,
    Response = ArmResponse<ListVirtualWANsResult>,
    Error = CloudError
  >;

  /**
   * Lists all the VirtualWANs in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualWans_List")
  list is ArmListBySubscription<
    VirtualWAN,
    Response = ArmResponse<ListVirtualWANsResult>,
    Error = CloudError
  >;

  /**
   * Gives the supported security providers for the virtual wan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("generatevirtualwanvpnserverconfigurationvpnprofile")
  @action("GenerateVpnProfile")
  generatevirtualwanvpnserverconfigurationvpnprofile is VirtualWanOps.ActionAsync<
    VirtualWAN,
    VirtualWanVpnProfileParameters,
    ArmResponse<VpnProfileResponse>,
    OverrideErrorType = CloudError
  >;

  /**
   * Gives the sas-url to download the configurations for vpn-sites in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnSitesConfiguration_Download")
  @action("vpnConfiguration")
  download is VirtualWanOps.ActionAsync<
    VirtualWAN,
    GetVpnSitesConfigurationRequest,
    OkResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gives the list of VpnServerConfigurations associated with Virtual Wan in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VpnServerConfigurationsAssociatedWithVirtualWan_List")
  @action("vpnServerConfigurations")
  vpnServerConfigurationsAssociatedWithVirtualWanList is VirtualWanOps.ActionAsync<
    VirtualWAN,
    void,
    ArmResponse<VpnServerConfigurationsResponse>,
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
