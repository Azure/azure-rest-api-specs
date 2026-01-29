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
 * Virtual Network resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
model VirtualNetwork extends Resource {
  properties?: VirtualNetworkPropertiesFormat;

  @visibility(Lifecycle.Read)
  @path
  @key("virtualNetworkName")
  @segment("virtualNetworks")
  name: string;

  /**
   * The extended location of the virtual network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface VirtualNetworks {
  /**
   * Gets the specified virtual network by resource group.
   */
  get is ArmResourceRead<
    VirtualNetwork,
    Parameters = {
      /**
       * Expands referenced resources.
       */
      @query("$expand")
      $expand?: string;
    },
    Error = CloudError
  >;

  /**
   * Creates or updates a virtual network in the specified resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualNetwork,
    Error = CloudError
  >;

  /**
   * Updates a virtual network tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    VirtualNetwork,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified virtual network.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualNetwork,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets all virtual networks in a resource group.
   */
  list is ArmResourceListByParent<VirtualNetwork, Error = CloudError>;

  /**
   * Gets all virtual networks in a subscription.
   */
  listAll is ArmListBySubscription<VirtualNetwork, Error = CloudError>;

  /**
   * Checks whether a private IP address is available for use.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @get
  @action("CheckIPAddressAvailability")
  checkIPAddressAvailability is ArmResourceActionSync<
    VirtualNetwork,
    void,
    ArmResponse<IPAddressAvailabilityResult>,
    Parameters = {
      /**
       * The private IP address to be verified.
       */
      @query("ipAddress")
      ipAddress: string;
    },
    Error = CloudError
  >;

  /**
   * Lists usage stats.
   */
  @list
  @get
  @action("usages")
  listUsage is ArmResourceActionSync<
    VirtualNetwork,
    void,
    ArmResponse<VirtualNetworkListUsageResult>,
    Error = CloudError
  >;

  /**
   * Gets the Ddos Protection Status of all IP Addresses under the Virtual Network
   */
  @list
  @action("ddosProtectionStatus")
  listDdosProtectionStatus is ArmResourceActionAsync<
    VirtualNetwork,
    void,
    VirtualNetworkDdosProtectionStatusResult,
    Parameters = {
      /**
       * The max number of ip addresses to return.
       */
      @query("top")
      top?: int32;

      /**
       * The skipToken that is given with nextLink.
       */
      @query("skipToken")
      skipToken?: string;
    },
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.networkManager)
@armResourceOperations
interface EffectiveConfigurations {
  /**
   * List all effective connectivity configurations applied on a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ListNetworkManagerEffectiveConnectivityConfigurations")
  @list
  listNetworkManagerEffectiveConnectivityConfigurations is ArmResourceActionSync<
    VirtualNetwork,
    QueryRequestOptions,
    ArmResponse<NetworkManagerEffectiveConnectivityConfigurationListResult>,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;

  /**
   * List all effective security admin rules applied on a virtual network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ListNetworkManagerEffectiveSecurityAdminRules")
  @list
  listNetworkManagerEffectiveSecurityAdminRules is ArmResourceActionSync<
    VirtualNetwork,
    QueryRequestOptions,
    ArmResponse<NetworkManagerEffectiveSecurityAdminRulesListResult>,
    Parameters = {
      /**
       * An optional query parameter which specifies the maximum number of records to be returned by the server.
       */
      @maxValue(20)
      @minValue(1)
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;
}

@@doc(VirtualNetwork.name, "The name of the virtual network.");
@@doc(VirtualNetwork.properties, "Properties of the virtual network.");
@@doc(VirtualNetworks.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update virtual network operation."
);
@@doc(VirtualNetworks.updateTags::parameters.properties,
  "Parameters supplied to update virtual network tags."
);
@@doc(EffectiveConfigurations.listNetworkManagerEffectiveConnectivityConfigurations::parameters.body,
  "Parameters supplied to list correct page."
);
@@doc(EffectiveConfigurations.listNetworkManagerEffectiveSecurityAdminRules::parameters.body,
  "Parameters supplied to list correct page."
);
