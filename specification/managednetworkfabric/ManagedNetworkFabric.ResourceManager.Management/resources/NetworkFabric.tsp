import "../models/common.tsp";
import "../models/NetworkFabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@Azure.ResourceManager.Private.armResourceInternal(NetworkFabricProperties)
@includeInapplicableMetadataInPayload(false)
model NetworkFabric extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Network Fabric.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricName")
  @segment("networkFabrics")
  @visibility("read")
  name: string;

  /** The NetworkFabric Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: NetworkFabricProperties;
}

@armResourceOperations
interface NetworkFabrics {
  /**
   * Get Network Fabric resource details.
   */
  get is ArmResourceRead<NetworkFabric>;

  /**
   * Create Network Fabric resource.
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkFabric>;

  /**
   * Update certain properties of the Network Fabric resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<NetworkFabric, NetworkFabricPatch>;

  /**
   * Delete Network Fabric resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabric>;

  /**
   * List all the Network Fabric resources in the given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<NetworkFabric>;

  /**
   * List all the Network Fabric resources in the given subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkFabric>;

  /**
   * Provisions the underlying resources in the given Network Fabric instance.
   */
  provision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  /**
   * Deprovisions the underlying resources in the given Network Fabric instance.
   */
  deprovision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  /**
   * Upgrades the version of the underlying resources in the given Network Fabric instance.
   */
  upgrade is ArmResourceActionAsync<
    NetworkFabric,
    UpgradeNetworkFabricProperties,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Refreshes the configuration of the underlying resources in the given Network Fabric instance.
   */
  refreshConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.
   */
  updateWorkloadManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.
   */
  updateInfraManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Validates the configuration of the underlying resources in the given Network Fabric instance.
   */
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse
  >;

  /**
   * Gets Topology of the underlying resources in the given Network Fabric instance.
   */
  getTopology is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ValidateConfigurationResponse
  >;

  /**
   * Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.
   */
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(NetworkFabrics.create::parameters.resource, "Request payload.");
@@doc(NetworkFabrics.update::parameters.properties,
  "Network Fabric properties to update."
);
@@doc(NetworkFabrics.upgrade::parameters.body,
  "Network Fabric properties to update."
);
@@doc(NetworkFabrics.updateWorkloadManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.updateInfraManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.validateConfiguration::parameters.body,
  "Validate configuration properties."
);
