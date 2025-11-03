import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

@doc("EdgeMachine details.")
model EdgeMachine
  is Azure.ResourceManager.TrackedResource<EdgeMachineProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachine,
    KeyName = "edgeMachineName",
    SegmentName = "edgeMachines",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
  ...ManagedServiceIdentityProperty;
}

@doc("Edge Machine Type.")
union EdgeMachineType {
  string,

  @doc("EdgeMachine resource created using Zero-touch provisioning flow")
  Standard: "Standard",

  @doc("EdgeMachine resource created for brownfield HCI customers without zero touch")
  Dedicated: "Dedicated",
}

@armResourceOperations
interface EdgeMachines {
  /**
   * Get a EdgeDevice
   */
  get is ArmResourceRead<EdgeMachine>;

  /**
   * Create a EdgeDevice
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeMachine>;

  /**
   * Delete a EdgeDevice
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachine>;

  @doc("List all edge machines in a resource group.")
  listByResourceGroup is ArmResourceListByParent<EdgeMachine>;

  @doc("List all edge machines in a subscription.")
  listBySubscription is ArmListBySubscription<EdgeMachine>;

  @doc("Update an edgeMachine")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<EdgeMachine, EdgeMachinePatch>;

  /**
   * Set failure state for edge machine.
   */
  setFailedMachineState is ArmResourceActionAsync<
    EdgeMachine,
    SetFailedMachineStateRequest,
    EdgeMachine
  >;

  /**
   * Reset failure state for edge machine.
   */
  resetFailedMachineState is ArmResourceActionAsync<
    EdgeMachine,
    void,
    EdgeMachine
  >;
}

@@doc(EdgeMachine.name, "Name of Device");

//////////////////////models//////////////////////

@doc("Properties for edge machine.")
model EdgeMachineProperties {
  @doc("Edge Machine type.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  edgeMachineType?: EdgeMachineType;

  @doc("The provisioning state of a resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Unique, immutable resource id.")
  @visibility(Lifecycle.Read)
  cloudId?: string;

  @doc("Optional property to create arc machine in custom resource group.")
  arcMachineResourceGroupId?: Azure.Core.armResourceIdentifier;

  @doc("Arc machine instance resource id.")
  arcMachineResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Link to Arc Gateway ARM resource Id")
  arcGatewayResourceId?: Azure.Core.armResourceIdentifier;

  @doc("Service fetches common configuration from site.")
  siteDetails?: SiteDetails;

  @doc("A machine can only be assigned to single device pool")
  @visibility(Lifecycle.Read)
  devicePoolResourceId?: string;

  @doc("OS configuration status details ")
  @visibility(Lifecycle.Read)
  machineState?: EdgeMachineState;

  @doc("machine connectivity status")
  @visibility(Lifecycle.Read)
  connectivityStatus?: EdgeMachineConnectivityStatus;

  @doc("Tracks the ID of the consuming resource, Settingthe machine as in-use.")
  @visibility(Lifecycle.Read)
  claimedBy?: string;

  @doc("Reported properties for edge machine.")
  @visibility(Lifecycle.Read)
  reportedProperties?: ReportedProperties;

  @doc("operation status details for edge machine.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  operationDetails?: OperationDetail[];

  @doc("Last time data updated to service.")
  @visibility(Lifecycle.Read)
  lastSyncTimestamp?: utcDateTime;
}

@doc("operation detail.")
model OperationDetail {
  @doc("operation name.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("operation id.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("operation type.")
  @visibility(Lifecycle.Read)
  type?: string;

  @doc("operation resource id.")
  @visibility(Lifecycle.Read)
  resourceId?: armResourceIdentifier;

  @doc("operation description.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("operation status.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("error details.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("The Set Failed request for Edge Machine..")
model SetFailedMachineStateRequest {
  @doc("Failure details to set why edge machine set to Failed state.")
  failureDetails?: FailureDetails;
}

@doc("Failure details to set why edge machine set to Failed state.")
model FailureDetails {
  @doc("Operation name which caused edge machine set to Failed state.")
  operation?: string;

  @doc("description of failure why edge machine set to Failed state.")
  description?: string;
}

@doc("Overall connectivity status for the machine resource.")
union EdgeMachineConnectivityStatus {
  string,

  @doc("The connectivity status of the machine resource is not specified.")
  NotSpecified: "NotSpecified",

  @doc("The machine resource is disconnected.")
  Disconnected: "Disconnected",

  @doc("The machine resource is connected.")
  Connected: "Connected",
}

@doc("Site Details consists of common configurations.")
model SiteDetails {
  @doc("Site resource Id set EM resource creation, once set can be reset only on EdgeMachine Reset API invocation.")
  siteResourceId: Azure.Core.armResourceIdentifier;

  @doc("Edge Device configuration received from site common configuration.")
  deviceConfiguration?: DeviceConfiguration;
}

@doc("Model for patching edge machine.")
model EdgeMachinePatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@doc("OS State")
union EdgeMachineState {
  string,

  @doc("Created when EdgeMachine resource created")
  Created: "Created",

  @doc("EdgeMachine state during device discovery and registration")
  Registering: "Registering",

  @doc("EdgeMachine state when machine configured with restricted OS and not provisioned to deploy workloads")
  Unpurposed: "Unpurposed",

  @doc("EdgeMachine state when transitioning from initial OS to target OS")
  Transitioning: "Transitioning",

  @doc("EdgeMachine state when machine configured with target OS to deploy workloads")
  Purposed: "Purposed",

  @doc("EdgeMachine state when OS updates are in-progress")
  Updating: "Updating",

  @doc("EdgeMachine state when transitioning from target OS to restricted OS")
  Resetting: "Resetting",

  @doc("EdgeMachine failed state and only option to recover is to re-provisioning machine")
  Failed: "Failed",

  @doc("Preparing EdgeMachine")
  Preparing: "Preparing",
}

@doc("NetworkProfile of edge machine.")
model NetworkProfile {
  @doc("List of NIC Details of edge machine.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["adapterName"])
  nicDetails?: NicDetail[];

  @doc("List of switch Details of edge machine.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["switchName"])
  switchDetails?: SwitchDetail[];
}

/**
 * OS configurations for HCI device.
 */
model OsProfile {
  /**
   * The boot type of the device. e.g. UEFI, Legacy etc
   */
  @visibility(Lifecycle.Read)
  bootType?: string;

  /**
   * Version of assembly present on device
   */
  @visibility(Lifecycle.Read)
  assemblyVersion?: string;

  /**
   * OS type (“windows", “linux”)
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * OS SKU (e.g., “ Microsoft Azure Linux ROE“, “Azure Stack HCI", "Microsoft Azure Linux 3.0")
   */
  @visibility(Lifecycle.Read)
  osSku?: string;

  /**
   * OS Version
   */
  @visibility(Lifecycle.Read)
  osVersion?: string;
}

/**
 * Hardware profile for the machine
 */
model HardwareProfile {
  /**
   * Number of cpu cores in the machine
   */
  @visibility(Lifecycle.Read)
  cpuCores?: int64;

  /**
   * Number of cpu sockets in the machine
   */
  @visibility(Lifecycle.Read)
  cpuSockets?: int64;

  /**
   * Memory capacity of the machine
   */
  @visibility(Lifecycle.Read)
  memoryCapacityInGb?: int64;

  /**
   * Model info of the machine
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * manufacturer info of the machine
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * Serial number of the machine
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Process type of the machine
   */
  @visibility(Lifecycle.Read)
  processorType?: string;
}

@doc("StorageProfile of edge machine.")
model StorageProfile {
  @doc("Number of storage disks in the device with $CanPool as true.")
  @visibility(Lifecycle.Read)
  poolableDisksCount?: int64;
}

/**
 * Arc extension installed on edge device.
 */
model EdgeMachineExtension {
  /**
   * Arc extension name installed on edge device.
   */
  @visibility(Lifecycle.Read)
  extensionName?: string;

  /**
   * Arc extension state from arc machine extension.
   */
  @visibility(Lifecycle.Read)
  state?: ArcExtensionState;

  /**
   * Error details while installing Arc extension.
   */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  errorDetails?: ErrorDetailModel[];

  /**
   * Exception details while installing Arc extension.
   */
  @visibility(Lifecycle.Read)
  exception?: string;

  /**
   * Arc Extension Azure resource id.
   */
  @visibility(Lifecycle.Read)
  extensionResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Extension version installed.
   */
  @visibility(Lifecycle.Read)
  typeHandlerVersion?: string;

  /**
   * Extension managed by user or Azure.
   */
  @visibility(Lifecycle.Read)
  managedBy?: ExtensionManagedBy;
}

/**
 * details of validation failure
 */
model ErrorDetailModel {
  /**
   * Exception details while installing extension.
   */
  @visibility(Lifecycle.Read)
  exception?: string;
}
