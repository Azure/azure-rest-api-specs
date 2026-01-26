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
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: NetworkFabricProperties;

  /** The NetworkFabric Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
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
  @action("provision")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "provision")
  @sharedRoute
  provisionDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Provisions the underlying resources in the given Network Fabric instance.")
  @action("provision")
  @added(Versions.v2025_07_15)
  @sharedRoute
  provision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    Foundations.OperationStatusResult
  >;

  @doc("Deprovisions the underlying resources in the given Network Fabric instance.")
  @action("deprovision")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "deprovision")
  @sharedRoute
  deprovisionDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Deprovisions the underlying resources in the given Network Fabric instance.")
  @action("deprovision")
  @added(Versions.v2025_07_15)
  @sharedRoute
  deprovision is ArmResourceActionAsync<
    NetworkFabric,
    void,
    Foundations.OperationStatusResult
  >;

  @doc("Upgrades the version of the underlying resources in the given Network Fabric instance.")
  @action("upgrade")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "upgrade")
  @sharedRoute
  upgradeDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    UpgradeNetworkFabricProperties,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Upgrades the version of the underlying resources in the given Network Fabric instance.")
  @action("upgrade")
  @added(Versions.v2025_07_15)
  @sharedRoute
  upgrade is ArmResourceActionAsync<
    NetworkFabric,
    UpgradeNetworkFabricProperties,
    Foundations.OperationStatusResult
  >;

  @doc("Refreshes the configuration of the underlying resources in the given Network Fabric instance.")
  @action("refreshConfiguration")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "refreshConfiguration")
  @sharedRoute
  refreshConfigurationDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Refreshes the configuration of the underlying resources in the given Network Fabric instance.")
  @action("refreshConfiguration")
  @added(Versions.v2025_07_15)
  @sharedRoute
  refreshConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    Foundations.OperationStatusResult
  >;

  @doc("Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  @action("updateWorkloadManagementBfdConfiguration")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateWorkloadManagementBfdConfiguration")
  @sharedRoute
  updateWorkloadManagementBfdConfigurationDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Workload Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  @action("updateWorkloadManagementBfdConfiguration")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateWorkloadManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  @action("updateInfraManagementBfdConfiguration")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateInfraManagementBfdConfiguration")
  @sharedRoute
  updateInfraManagementBfdConfigurationDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Infra Management BFD Configuration of the underlying resources in the given Network Fabric instance.")
  @action("updateInfraManagementBfdConfiguration")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateInfraManagementBfdConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("Validates the configuration of the underlying resources in the given Network Fabric instance.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse
  >;

  @doc("Gets Topology of the underlying resources in the given Network Fabric instance.")
  @action("getTopology")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "getTopology")
  @sharedRoute
  getTopologyDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ValidateConfigurationResponse
  >;

  @doc("Gets Topology of the underlying resources in the given Network Fabric instance.")
  @action("getTopology")
  @added(Versions.v2025_07_15)
  @sharedRoute
  getTopology is ArmResourceActionAsync<
    NetworkFabric,
    void,
    GetTopologyResponse
  >;

  @doc("Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.")
  @action("commitConfiguration")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "commitConfiguration")
  @sharedRoute
  commitConfigurationDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Atomic update of the given Network Fabric instance. Sync update of NFA resources at Fabric level.")
  @action("commitConfiguration")
  @added(Versions.v2025_07_15)
  @sharedRoute
  commitConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    CommitConfigurationRequest,
    CommitConfigurationResponse,
    OptionalRequestBody = true
  >;

  @doc("Post action: Returns a status of commit batch operation.")
  @added(Versions.v2024_06_15_preview)
  @action("commitBatchStatus")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "commitBatchStatus")
  @sharedRoute
  commitBatchStatusDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    CommitBatchStatusRequest,
    CommitBatchStatusResponse
  >;

  @doc("Post action: Returns a status of commit batch operation.")
  @added(Versions.v2025_07_15)
  @action("commitBatchStatus")
  @sharedRoute
  commitBatchStatus is ArmResourceActionAsync<
    NetworkFabric,
    CommitBatchStatusRequest,
    CommitBatchStatusOperationResponse
  >;

  @doc("Post action: Discards a Batch operation in progress.")
  @added(Versions.v2024_06_15_preview)
  @action("discardCommitBatch")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "discardCommitBatch")
  @sharedRoute
  discardCommitBatchDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    DiscardCommitBatchRequest,
    DiscardCommitBatchResponse
  >;

  @doc("Post action: Discards a Batch operation in progress.")
  @action("discardCommitBatch")
  @added(Versions.v2025_07_15)
  @sharedRoute
  discardCommitBatch is ArmResourceActionAsync<
    NetworkFabric,
    DiscardCommitBatchRequest,
    DiscardCommitBatchOperationResponse
  >;

  @doc("Post action: Triggers network fabric lock operation.")
  @added(Versions.v2024_06_15_preview)
  @action("lockFabric")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "lockFabric")
  @sharedRoute
  lockFabricDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    NetworkFabricLockRequest,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Post action: Triggers network fabric lock operation.")
  @action("lockFabric")
  @added(Versions.v2025_07_15)
  @sharedRoute
  lockFabric is ArmResourceActionAsync<
    NetworkFabric,
    NetworkFabricLockRequest,
    Foundations.OperationStatusResult
  >;

  @doc("Post action: Triggers view of network fabric configuration.")
  @added(Versions.v2024_06_15_preview)
  @action("viewDeviceConfiguration")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "viewDeviceConfiguration")
  @sharedRoute
  viewDeviceConfigurationDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ViewDeviceConfigurationResponse
  >;

  @doc("Post action: Triggers view of network fabric configuration.")
  @action("viewDeviceConfiguration")
  @added(Versions.v2025_07_15)
  @sharedRoute
  viewDeviceConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ViewDeviceConfigurationOperationResponse
  >;

  @doc("Post action: Triggers diff of NetworkFabric ARM Configuration.")
  @added(Versions.v2024_06_15_preview)
  @action("armConfigurationDiff")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "armConfigurationDiff")
  @sharedRoute
  armConfigurationDiffDeprecated is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmConfigurationDiffResponse
  >;

  @doc("Post action: Triggers diff of NetworkFabric ARM Configuration.")
  @action("armConfigurationDiff")
  @added(Versions.v2025_07_15)
  @sharedRoute
  armConfigurationDiff is ArmResourceActionAsync<
    NetworkFabric,
    void,
    ArmConfigurationDiffOperationResponse
  >;

  /**
   * Creates new passwords, then updates the Terminal Server and Network Devices to use the new passwords.
   *
   * Note that disabled devices cannot be updated and must be resynchronized with the new passwords once they are enabled.
   *
   * Fails if any of the devices could not be updated with the new password.
   * Failed devices should be resynchronized with the new passwords once possible.
   */
  @summary("Rotate all passwords on the Terminal Server and Network Devices.")
  @added(Versions.v2025_07_15)
  rotatePasswords is ArmResourceActionAsync<
    NetworkFabric,
    void,
    NetworkFabricRotatePasswordsResponse
  >;

  /**
   * Updates the Terminal Server and all Network Devices to use the latest passwords. Does not generate new passwords.
   *
   * Allows devices to be brought back in sync after a partially successful password rotation.
   */
  @summary("Resync the latest passwords to the Terminal Server and Network Devices.")
  @added(Versions.v2025_07_15)
  resyncPasswords is ArmResourceActionAsync<
    NetworkFabric,
    void,
    NetworkFabricResyncPasswordsResponse
  >;

  @summary("Rotate all certificates on Network Devices.")
  @doc("Creates new certificates, then updates the Network Devices to use the new certificates. Note that disabled devices cannot be updated and must be resynchronized with the new certificates once they are enabled.")
  @added(Versions.v2025_07_15)
  rotateCertificates is ArmResourceActionAsync<
    NetworkFabric,
    void,
    NetworkFabricRotateCertificatesResponse
  >;

  @summary("Re-sync all certificates on Network Devices.")
  @doc("Updates all Network Devices to use the latest certificates. Does not generate new certificates. Allows network devices missed during a previous certificate rotation to be brought back into sync.")
  @added(Versions.v2025_07_15)
  resyncCertificates is ArmResourceActionAsync<
    NetworkFabric,
    void,
    NetworkFabricResyncCertificatesResponse
  >;
}

@@doc(NetworkFabrics.create::parameters.resource, "Request payload.");
@@doc(NetworkFabrics.update::parameters.properties,
  "Network Fabric properties to update."
);
@@doc(NetworkFabrics.upgradeDeprecated::parameters.body,
  "Network Fabric properties to update."
);
@@doc(NetworkFabrics.upgrade::parameters.body,
  "Network Fabric properties to update."
);
@@doc(NetworkFabrics.updateWorkloadManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.updateWorkloadManagementBfdConfigurationDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.updateInfraManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.updateInfraManagementBfdConfigurationDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.validateConfiguration::parameters.body,
  "Validate configuration properties."
);
@@doc(NetworkFabrics.commitBatchStatusDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.commitBatchStatus::parameters.body, "Request payload.");
@@doc(NetworkFabrics.lockFabricDeprecated::parameters.body, "Request payload.");
@@doc(NetworkFabrics.lockFabric::parameters.body, "Request payload.");
@@doc(NetworkFabrics.discardCommitBatchDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.discardCommitBatch::parameters.body, "Request payload.");
