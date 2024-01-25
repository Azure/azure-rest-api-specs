import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network Fabric resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(NetworkFabricProperties)
model NetworkFabric extends TrackedResourceBase {
  /**
   * Name of the Network Fabric.
   */
  @path
  @key("networkFabricName")
  @segment("networkFabrics")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
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
  create is ArmResourceCreateOrReplaceAsync<
    NetworkFabric,
    BaseParameters<NetworkFabric>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update certain properties of the Network Fabric resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkFabric,
    NetworkFabricPatch,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Delete Network Fabric resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkFabric,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * List all the Network Fabric resources in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFabrics_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NetworkFabric>;

  /**
   * List all the Network Fabric resources in the given subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkFabric>;

  /**
   * Provisions the underlying resources in the given Network Fabric instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFabrics_provision")
  provision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Deprovisions the underlying resources in the given Network Fabric instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFabrics_deprovision")
  deprovision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Upgrades the version of the underlying resources in the given Network Fabric instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFabrics_upgrade")
  upgrade is ArmResourceActionAsync<
    NetworkFabric,
    UpdateVersion,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Refreshes the configuration of the underlying resources in the given Network Fabric instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkFabrics_refreshConfiguration")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.
   */
  updateWorkloadManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.
   */
  updateInfraManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Validates the configuration of the underlying resources in the given Network Fabric instance.
   */
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Gets Topology of the underlying resources in the given Network Fabric instance.
   */
  getTopology is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ValidateConfigurationResponse,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;

  /**
   * Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.
   */
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkFabric>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkFabrics.create::parameters.resource, "json", "body");
@@extension(NetworkFabrics.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkFabrics.create::parameters.resource, "Request payload.");
@@projectedName(NetworkFabrics.update::parameters.properties, "json", "body");
@@extension(NetworkFabrics.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
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
