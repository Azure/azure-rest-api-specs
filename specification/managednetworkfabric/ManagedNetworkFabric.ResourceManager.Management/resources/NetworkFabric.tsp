import "../models/common.tsp";
import "../models/NetworkFabric.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network Fabric resource definition.")
@added(Versions.v2025_07_15)
model NetworkFabric
  is Azure.ResourceManager.TrackedResource<NetworkFabricProperties, false> {
  @doc("Name of the Network Fabric.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricName")
  @segment("networkFabrics")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@@doc(NetworkFabric.properties, "The NetworkFabric Properties");

// this is deprecated here because in the two preview versions,
// the properties property of this model does not have the "flattenProperty" decorator (x-ms-client-flatten in swagger)
// therefore we have to use this way to declare two different models to achieve it.
@doc("The Network Fabric resource definition.")
@removed(Versions.v2025_07_15)
@renamedFrom(Versions.v2025_07_15, "NetworkFabric")
model NetworkFabricDeprecated
  is Azure.ResourceManager.TrackedResource<NetworkFabricProperties, false> {
  @doc("Name of the Network Fabric.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkFabricName")
  @segment("networkFabrics")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2024_06_15_preview)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@@doc(NetworkFabricDeprecated.properties, "The NetworkFabric Properties");

@armResourceOperations
interface NetworkFabrics {
  @doc("Get Network Fabric resource details.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  get is ArmResourceRead<NetworkFabric>;

  @doc("Get Network Fabric resource details.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "get")
  @sharedRoute
  getDeprecated is ArmResourceRead<NetworkFabricDeprecated>;

  @doc("Create Network Fabric resource.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  create is ArmResourceCreateOrReplaceAsync<NetworkFabric>;

  @doc("Create Network Fabric resource.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "create")
  @sharedRoute
  createDeprecated is ArmResourceCreateOrReplaceAsync<NetworkFabricDeprecated>;

  @doc("Update certain properties of the Network Fabric resource.")
  @patch(#{ implicitOptionality: false })
  @added(Versions.v2025_07_15)
  @sharedRoute
  update is ArmCustomPatchAsync<NetworkFabric, NetworkFabricPatch>;

  @doc("Update certain properties of the Network Fabric resource.")
  @patch(#{ implicitOptionality: false })
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "update")
  @sharedRoute
  updateDeprecated is ArmCustomPatchAsync<
    NetworkFabricDeprecated,
    NetworkFabricPatch
  >;

  @doc("Delete Network Fabric resource.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  delete is ArmResourceDeleteWithoutOkAsync<NetworkFabric>;

  @doc("Delete Network Fabric resource.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "delete")
  @sharedRoute
  deleteDeprecated is ArmResourceDeleteWithoutOkAsync<NetworkFabricDeprecated>;

  @doc("List all the Network Fabric resources in the given resource group.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  listByResourceGroup is ArmResourceListByParent<
    NetworkFabric,
    Response = NetworkFabricsListResult
  >;

  @doc("List all the Network Fabric resources in the given resource group.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "listByResourceGroup")
  @sharedRoute
  listByResourceGroupDeprecated is ArmResourceListByParent<
    NetworkFabricDeprecated,
    Response = NetworkFabricsListResultDeprecated
  >;

  @doc("List all the Network Fabric resources in the given subscription.")
  @added(Versions.v2025_07_15)
  @sharedRoute
  listBySubscription is ArmListBySubscription<
    NetworkFabric,
    Response = NetworkFabricsListResult
  >;

  @doc("List all the Network Fabric resources in the given subscription.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "listBySubscription")
  @sharedRoute
  listBySubscriptionDeprecated is ArmListBySubscription<
    NetworkFabricDeprecated,
    Response = NetworkFabricsListResultDeprecated
  >;

  @doc("Provisions the underlying resources in the given Network Fabric instance.")
  @action("provision")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "provision")
  @sharedRoute
  provisionDeprecated is ArmResourceActionAsync<
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
  @added(Versions.v2025_07_15)
  @sharedRoute
  validateConfiguration is ArmResourceActionAsync<
    NetworkFabric,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse
  >;

  @doc("Validates the configuration of the underlying resources in the given Network Fabric instance.")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "validateConfiguration")
  @sharedRoute
  validateConfigurationDeprecated is ArmResourceActionAsync<
    NetworkFabricDeprecated,
    ValidateConfigurationProperties,
    ValidateConfigurationResponse
  >;

  @doc("Gets Topology of the underlying resources in the given Network Fabric instance.")
  @action("getTopology")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "getTopology")
  @sharedRoute
  getTopologyDeprecated is ArmResourceActionAsync<
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
    NetworkFabricDeprecated,
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
@@doc(NetworkFabrics.createDeprecated::parameters.resource, "Request payload.");
@@doc(
  NetworkFabrics.update::parameters.properties,
  "Network Fabric properties to update."
);
@@doc(
  NetworkFabrics.updateDeprecated::parameters.properties,
  "Network Fabric properties to update."
);
@@doc(
  NetworkFabrics.upgradeDeprecated::parameters.body,
  "Network Fabric properties to update."
);
@@doc(
  NetworkFabrics.upgrade::parameters.body,
  "Network Fabric properties to update."
);
@@doc(
  NetworkFabrics.updateWorkloadManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(
  NetworkFabrics.updateWorkloadManagementBfdConfigurationDeprecated::parameters.body,
  "Request payload."
);
@@doc(
  NetworkFabrics.updateInfraManagementBfdConfiguration::parameters.body,
  "Request payload."
);
@@doc(
  NetworkFabrics.updateInfraManagementBfdConfigurationDeprecated::parameters.body,
  "Request payload."
);

@@doc(
  NetworkFabrics.validateConfiguration::parameters.body,
  "Validate configuration properties."
);
@@doc(
  NetworkFabrics.validateConfigurationDeprecated::parameters.body,
  "Validate configuration properties."
);
@@doc(
  NetworkFabrics.commitBatchStatusDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.commitBatchStatus::parameters.body, "Request payload.");
@@doc(NetworkFabrics.lockFabricDeprecated::parameters.body, "Request payload.");
@@doc(NetworkFabrics.lockFabric::parameters.body, "Request payload.");
@@doc(
  NetworkFabrics.discardCommitBatchDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkFabrics.discardCommitBatch::parameters.body, "Request payload.");
@@doc(NetworkFabrics.refreshConfiguration::parameters.body, "Request payload.");
@@doc(
  NetworkFabrics.refreshConfigurationDeprecated::parameters.body,
  "Request payload."
);
