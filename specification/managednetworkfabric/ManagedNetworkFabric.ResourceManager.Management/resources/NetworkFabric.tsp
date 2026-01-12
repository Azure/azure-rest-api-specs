import "../models/common.tsp";
import "../models/NetworkFabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network Fabric resource definition.")
@Azure.ResourceManager.Private.armResourceInternal(NetworkFabricProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkFabric extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Fabric.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricName")
  @segment("networkFabrics")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkFabric Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: NetworkFabricProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2024_06_15_preview)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkFabrics {
  @doc("Get Network Fabric resource details.")
  get is ArmResourceRead<NetworkFabric>;

  @doc("Create Network Fabric resource.")
  create is ArmResourceCreateOrReplaceAsync<NetworkFabric>;

  @doc("Update certain properties of the Network Fabric resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkFabric, NetworkFabricPatch>;

  @doc("Delete Network Fabric resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabric>;

  @doc("List all the Network Fabric resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkFabric>;

  @doc("List all the Network Fabric resources in the given subscription.")
  listBySubscription is ArmListBySubscription<NetworkFabric>;

  @doc("Provisions the underlying resources in the given Network Fabric instance.")
  provision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Deprovisions the underlying resources in the given Network Fabric instance.")
  deprovision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Upgrades the version of the underlying resources in the given Network Fabric instance.")
  upgrade is ArmResourceActionAsync<
    NetworkFabric,
    UpgradeNetworkFabricProperties,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Refreshes the configuration of the underlying resources in the given Network Fabric instance.")
  refreshConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  updateWorkloadManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  updateInfraManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Validates the configuration of the underlying resources in the given Network Fabric instance.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse
  >;

  @doc("Gets Topology of the underlying resources in the given Network Fabric instance.")
  getTopology is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ValidateConfigurationResponse
  >;

  @doc("Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.")
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Post action: Returns a status of commit batch operation.")
  @added(Versions.v2024_06_15_preview)
  commitBatchStatus is ArmResourceActionAsync<
    NetworkFabric,
    CommitBatchStatusRequest,
    CommitBatchStatusResponse
  >;

  @doc("Post action: Discards a Batch operation in progress.")
  @added(Versions.v2024_06_15_preview)
  discardCommitBatch is ArmResourceActionAsync<
    NetworkFabric,
    DiscardCommitBatchRequest,
    DiscardCommitBatchResponse
  >;

  @doc("Post action: Triggers network fabric lock operation.")
  @added(Versions.v2024_06_15_preview)
  lockFabric is ArmResourceActionAsync<
    NetworkFabric,
    NetworkFabricLockRequest,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Post action: Triggers view of network fabric configuration.")
  @added(Versions.v2024_06_15_preview)
  viewDeviceConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ViewDeviceConfigurationResponse
  >;

  @doc("Post action: Triggers diff of NetworkFabric ARM Configuration.")
  @added(Versions.v2024_06_15_preview)
  armConfigurationDiff is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmConfigurationDiffResponse
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
@@doc(NetworkFabrics.commitBatchStatus::parameters.body, "Request payload.");
@@doc(NetworkFabrics.lockFabric::parameters.body, "Request payload.");
@@doc(NetworkFabrics.discardCommitBatch::parameters.body, "Request payload.");
