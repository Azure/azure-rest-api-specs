import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric resource definition.
 */
model NetworkFabric
  is Azure.ResourceManager.TrackedResource<NetworkFabricProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkFabric,
    KeyName = "networkFabricName",
    SegmentName = "networkFabrics",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkFabric, PatchModel = NetworkFabricPatch>;

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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkFabrics_provision")
  provision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmResponse<CommonPostActionResponseForDeviceUpdate>
  >;

  /**
   * Deprovisions the underlying resources in the given Network Fabric instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkFabrics_deprovision")
  deprovision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmResponse<CommonPostActionResponseForDeviceUpdate>
  >;

  /**
   * Upgrades the version of the underlying resources in the given Network Fabric instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkFabrics_upgrade")
  upgrade is ArmResourceActionAsync<
    NetworkFabric,
    UpgradeNetworkFabricProperties,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Refreshes the configuration of the underlying resources in the given Network Fabric instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkFabrics_refreshConfiguration")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.
   */
  updateWorkloadManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.
   */
  updateInfraManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Validates the configuration of the underlying resources in the given Network Fabric instance.
   */
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ArmResponse<ValidateConfigurationResponse>
  >;

  /**
   * Gets Topology of the underlying resources in the given Network Fabric instance.
   */
  getTopology is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmResponse<ValidateConfigurationResponse>
  >;

  /**
   * Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.
   */
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(NetworkFabric.name, "Name of the Network Fabric.");
@@doc(NetworkFabric.properties, "Resource properties.");
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
