import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;

/**
 * The cordon status of the bare metal machine.
 */
union BareMetalMachineCordonStatus {
  string,

  /**
   * The bare metal machine is cordoned.
   */
  Cordoned: "Cordoned",

  /**
   * The bare metal machine is uncordoned.
   */
  Uncordoned: "Uncordoned",
}

/**
 * The more detailed status of the bare metal machine.
 */
union BareMetalMachineDetailedStatus {
  string,

  /**
   * The Preparing status.
   */
  Preparing: "Preparing",

  /**
   * The Error status.
   */
  Error: "Error",

  /**
   * The Available status.
   */
  Available: "Available",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Provisioned status.
   */
  Provisioned: "Provisioned",

  /**
   * The Deprovisioning status.
   */
  Deprovisioning: "Deprovisioning",
}

/**
 * The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.
 */
union BareMetalMachineEvacuate {
  string,

  /**
   * Evacuate workloads from the node when the bare metal machine is cordoned.
   */
  True: "True",

  /**
   * Do not evacuate workloads from the node when the bare metal machine is cordoned.
   */
  False: "False",
}

/**
 * The outcome of the hardware validation.
 */
union BareMetalMachineHardwareValidationResult {
  string,

  /**
   * The hardware validation passed.
   */
  Pass: "Pass",

  /**
   * The hardware validation failed.
   */
  Fail: "Fail",
}

/**
 * The power state derived from the baseboard management controller.
 */
union BareMetalMachinePowerState {
  string,

  /**
   * The bare metal machine was marked as powered on in the latest check of the baseboard management controller.
   */
  On: "On",

  /**
   * The bare metal machine was marked as powered off in the latest check of the baseboard management controller.
   */
  Off: "Off",
}

/**
 * The provisioning state of the bare metal machine.
 */
union BareMetalMachineProvisioningState {
  string,

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",
}

/**
 * The indicator of whether the bare metal machine is ready to receive workloads.
 */
union BareMetalMachineReadyState {
  string,

  /**
   * The bare metal machine is ready to receive workloads.
   */
  True: "True",

  /**
   * The bare metal machine is not ready to receive workloads.
   */
  False: "False",
}

/**
 * The safeguard mode to use for the replace action, where None indicates to bypass safeguards and All indicates to utilize all safeguards.
 */
union BareMetalMachineReplaceSafeguardMode {
  string,

  /**
   * All safeguards will be utilized during the replace action.
   */
  All: "All",

  /**
   * No safeguards will be utilized during the replace action.
   */
  None: "None",
}

/**
 * The indicator of whether to bypass clearing storage while replacing a bare metal machine.
 */
union BareMetalMachineReplaceStoragePolicy {
  string,

  /**
   * Storage will be preserved and not cleared during the replace action.
   */
  Preserve: "Preserve",

  /**
   * Storage will be cleared during the replace action.
   */
  DiscardAll: "DiscardAll",
}

/**
 * The indicator of whether to skip the graceful OS shutdown and power off the bare metal machine immediately.
 */
union BareMetalMachineSkipShutdown {
  string,

  /**
   * Skip the graceful OS shutdown and power off the bare metal machine immediately.
   */
  True: "True",

  /**
   * Do not skip the graceful OS shutdown and power off the bare metal machine immediately.
   */
  False: "False",
}

/**
 * The runtime protection agent health status.
 */
@added(Versions.v2026_01_01_preview)
union RuntimeProtectionAgentHealthStatus {
  string,

  /**
   * The runtime protection agent is healthy.
   */
  Healthy: "Healthy",

  /**
   * The runtime protection agent has health issues.
   */
  Unhealthy: "Unhealthy",
}

/**
 * The runtime protection agent license status.
 */
@added(Versions.v2026_01_01_preview)
union RuntimeProtectionAgentLicenseStatus {
  string,

  /**
   * The runtime protection agent license is valid.
   */
  Licensed: "Licensed",

  /**
   * The runtime protection agent license is not valid.
   */
  Unlicensed: "Unlicensed",
}

/**
 * The definition update mode for runtime protection.
 */
@added(Versions.v2026_01_01_preview)
union RuntimeProtectionDefinitionUpdateMode {
  string,

  /**
   * Update definitions automatically through the connected runtime protection agent.
   */
  Automatic: "Automatic",

  /**
   * Do not update definitions.
   */
  None: "None",
}

/**
 * The mode of operation for runtime protection.
 */
union RuntimeProtectionEnforcementLevel {
  string,

  /**
   * Real-time scans detect but do not remediate detected issues.
   */
  Audit: "Audit",

  /**
   * Real-time scans are disabled and can not be triggered.
   */
  Disabled: "Disabled",

  /**
   * Real-time scans are disabled but can be triggered to remediate detected issues.
   */
  OnDemand: "OnDemand",

  /**
   * Real-time scans are disabled but can be triggered to detect issues without remediation.
   */
  Passive: "Passive",

  /**
   * Real-time scans detect and remediate detected issues.
   */
  RealTime: "RealTime",
}

/**
 * BareMetalMachineCommandSpecification represents the command and optional arguments to exercise against the bare metal machine.
 */
model BareMetalMachineCommandSpecification {
  /**
   * The list of string arguments that will be passed to the script in order as separate arguments.
   */
  arguments?: string[];

  /**
   * The command to execute against the bare metal machine.
   */
  command: string;
}

/**
 * BareMetalMachineCordonParameters represents the body of the request to evacuate workloads from node on a bare metal machine.
 */
model BareMetalMachineCordonParameters {
  /**
   * The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.
   */
  evacuate?: BareMetalMachineEvacuate = BareMetalMachineEvacuate.False;
}

/**
 * BareMetalMachineList represents a list of bare metal machines.
 */
model BareMetalMachineList is Azure.Core.Page<BareMetalMachine>;

/**
 * BareMetalMachinePatchParameters represents the body of the request to patch bare metal machine properties.
 */
model BareMetalMachinePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: BareMetalMachinePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * BareMetalMachinePatchProperties represents the properties of the bare metal machine that can be patched.
 */
model BareMetalMachinePatchProperties {
  /**
   * The details provided by the customer during the creation of rack manifests that allows for custom data to be associated with this machine.
   */
  @maxLength(256)
  machineDetails?: string;
}

/**
 * BareMetalMachinePowerOffParameters represents the body of the request to power off bare metal machine.
 */
model BareMetalMachinePowerOffParameters {
  /**
   * The indicator of whether to skip the graceful OS shutdown and power off the bare metal machine immediately.
   */
  skipShutdown?: BareMetalMachineSkipShutdown = BareMetalMachineSkipShutdown.False;
}

/**
 * BareMetalMachineProperties represents the properties of a bare metal machine.
 */
model BareMetalMachineProperties {
  ...BareMetalMachineSpec;
  ...BareMetalMachineStatus;

  /**
   * The provisioning state of the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BareMetalMachineProvisioningState;
}
/**
 * BareMetalMachineSpec represents the properties that are used as an input to the operator.
 */
model BareMetalMachineSpec {
  /**
   * The connection string for the baseboard management controller including IP address and protocol.
   */
  bmcConnectionString: string;

  /**
   * The credentials of the baseboard management controller on this bare metal machine.
   */
  bmcCredentials: AdministrativeCredentials;

  /**
   * The MAC address of the BMC device.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bmcMacAddress: string;

  /**
   * The MAC address of a NIC connected to the PXE network.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bootMacAddress: string;

  /**
   * The custom details provided by the customer.
   */
  @maxLength(256)
  machineDetails: string;

  /**
   * The OS-level hostname assigned to this machine.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  machineName: string;

  /**
   * The unique internal identifier of the bare metal machine SKU.
   */
  machineSkuId: string;

  /**
   * The resource ID of the rack where this bare metal machine resides.
   */
  rackId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/racks";
    }
  ]>;

  /**
   * The rack slot in which this bare metal machine is located, ordered from the bottom up i.e. the lowest slot is 1.
   */
  @maxValue(256)
  @minValue(1)
  rackSlot: int64;

  /**
   * The serial number of the bare metal machine.
   */
  @maxLength(64)
  @minLength(1)
  serialNumber: string;
}

/**
 * BareMetalMachineStatus represents the properties produced by the API implementing logic in the operator.
 */
model BareMetalMachineStatus {
  /**
   * The current state of any in progress or completed actions. The most recent known instance of each action type is shown.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["actionType"])
  actionStates?: ActionState[];

  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The IPv4 address of the BMC interface for the bare metal machine.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  bmcIpv4Address?: string;

  /**
   * The IPv6 address of the BMC interface for the bare metal machine.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  bmcIpv6Address?: string;

  /**
   * The CA certificate information issued by the platform for connecting to TLS interfaces for the bare metal machine. Callers add this certificate to the trusted CA store on the Kubernetes control plane nodes to allow secure communication with the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  caCertificate?: CertificateInfo;

  /**
   * The resource ID of the cluster this bare metal machine is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The cordon status of the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  cordonStatus?: BareMetalMachineCordonStatus;

  /**
   * The more detailed status of the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: BareMetalMachineDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The hardware inventory, including information acquired from the model/sku information and from the ironic inspector.
   */
  @visibility(Lifecycle.Read)
  hardwareInventory?: HardwareInventory;

  /**
   * The details of the latest hardware validation performed for this bare metal machine.
   */
  @visibility(Lifecycle.Read)
  hardwareValidationStatus?: HardwareValidationStatus;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the HybridAksClusters that have nodes hosted on this bare metal machine.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * The name of this machine represented by the host object in the Cluster's Kubernetes control plane.
   */
  @visibility(Lifecycle.Read)
  kubernetesNodeName?: string;

  /**
   * The version of Kubernetes running on this machine.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * The cluster version that has been applied to this machine during deployment or a version update.
   */
  /* Should have been read-only, isn't... */
  machineClusterVersion?: string;

  /**
   * The list of roles that are assigned to the cluster node running on this machine.
   */
  @visibility(Lifecycle.Read)
  machineRoles?: string[];

  /**
   * The IPv4 address that is assigned to the bare metal machine during the cluster deployment.
   */
  @visibility(Lifecycle.Read)
  oamIpv4Address?: string;

  /**
   * The IPv6 address that is assigned to the bare metal machine during the cluster deployment.
   */
  @visibility(Lifecycle.Read)
  oamIpv6Address?: string;

  /**
   * The image that is currently provisioned to the OS disk.
   */
  @visibility(Lifecycle.Read)
  osImage?: string;

  /**
   * The power state derived from the baseboard management controller.
   */
  @visibility(Lifecycle.Read)
  powerState?: BareMetalMachinePowerState;

  /**
   * The indicator of whether the bare metal machine is ready to receive workloads.
   */
  @visibility(Lifecycle.Read)
  readyState?: BareMetalMachineReadyState;

  /**
   * The runtime protection status of the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  runtimeProtectionStatus?: RuntimeProtectionStatus;

  /**
   * The list of statuses that represent secret rotation activity.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["secretType"])
  secretRotationStatus?: SecretRotationStatus[];

  /**
   * The discovered value of the machine's service tag.
   */
  @visibility(Lifecycle.Read)
  serviceTag?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the VirtualMachines that are hosted on this bare metal machine.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];
}

/**
 * BareMetalMachineReplaceParameters represents the body of the request to physically swap a bare metal machine for another.
 */
model BareMetalMachineReplaceParameters {
  /**
   * The credentials of the baseboard management controller on this bare metal machine. The password field is expected to be an Azure Key Vault key URL. Until the cluster is converted to utilize managed identity by setting the secret archive settings, the actual password value should be provided instead.
   */
  bmcCredentials?: AdministrativeCredentials;

  /**
   * The MAC address of the BMC device.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bmcMacAddress?: string;

  /**
   * The MAC address of a NIC connected to the PXE network.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bootMacAddress?: string;

  /**
   * The OS-level hostname assigned to this machine.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  machineName?: string;

  /**
   * The safeguard mode to use for the replace action, where None indicates to bypass safeguards and All indicates to utilize all safeguards.
   */
  // TODO: for Go, should be: BareMetalMachineReplaceSafeguardMode
  safeguardMode?: BareMetalMachineReplaceSafeguardMode = BareMetalMachineReplaceSafeguardMode.All;

  /**
   * The serial number of the bare metal machine.
   */
  @maxLength(64)
  @minLength(1)
  serialNumber?: string;

  /**
   * The indicator of whether to bypass clearing storage while replacing a bare metal machine.
   */
  // TODO: for Go, should be: BareMetalMachineReplaceStoragePolicy
  storagePolicy?: BareMetalMachineReplaceStoragePolicy = BareMetalMachineReplaceStoragePolicy.DiscardAll;
}

/**
 * BareMetalMachineRunCommandParameters represents the body of the request to execute a script on the bare metal machine.
 */
model BareMetalMachineRunCommandParameters {
  /**
   * The list of string arguments that will be passed to the script in order as separate arguments.
   */
  arguments?: string[];

  /**
   * The maximum time the script is allowed to run. If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
   */
  @maxValue(14400)
  @minValue(60)
  limitTimeSeconds: int64;

  /**
   * The base64 encoded script to execute on the bare metal machine.
   */
  script: string;
}

/**
 * BareMetalMachineRunDataExtractsParameters represents the body of request containing list of curated data extraction commands to run on the bare metal machine.
 */
model BareMetalMachineRunDataExtractsParameters {
  /**
   * The list of curated data extraction commands to be executed directly against the target machine.
   */
  @identifiers(#[])
  @minItems(1)
  commands: BareMetalMachineCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run. If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
   */
  @maxValue(14400)
  @minValue(60)
  limitTimeSeconds: int64;
}

/**
 * BareMetalMachineRunReadCommandsParameters represents the body of request containing list of read-only commands to run on the bare metal machine.
 */
model BareMetalMachineRunReadCommandsParameters {
  /**
   * The list of read-only commands to be executed directly against the target machine.
   */
  @identifiers(#[])
  @minItems(1)
  commands: BareMetalMachineCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run. If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
   */
  @maxValue(14400)
  @minValue(60)
  limitTimeSeconds: int64;
}

/**
 * HardwareInventory represents the hardware configuration of this machine as exposed to the customer, including information acquired from the model/sku information and from the ironic inspector.
 */
model HardwareInventory {
  /**
   * Freeform data extracted from the environment about this machine. This information varies depending on the specific hardware and configuration.
   */
  @visibility(Lifecycle.Read)
  additionalHostInformation?: string;

  /**
   * The list of network interfaces and associated details for the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  interfaces?: HardwareInventoryNetworkInterface[];

  /**
   * Field Deprecated. Will be removed in an upcoming version. The list of network interface cards and associated details for the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  nics?: Nic[];
}

/**
 * HardwareInventoryNetworkInterface represents the network interface details as part of a hardware inventory.
 */
model HardwareInventoryNetworkInterface {
  /**
   * The current status of the link.
   */
  @visibility(Lifecycle.Read)
  linkStatus?: string;

  /**
   * The MAC address associated with this interface.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The name of the interface.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The resource ID of the network interface for the port on the switch that this machine's interface is connected to.
   */
  @visibility(Lifecycle.Read)
  networkInterfaceId?: string;
}

/**
 * HardwareValidationStatus represents the latest hardware validation details performed for this bare metal machine.
 */
model HardwareValidationStatus {
  /**
   * The timestamp of the hardware validation execution.
   */
  @visibility(Lifecycle.Read)
  lastValidationTime?: utcDateTime;

  /**
   * The outcome of the hardware validation.
   */
  @visibility(Lifecycle.Read)
  result?: BareMetalMachineHardwareValidationResult;
}

/**
 * Type Deprecated. Will be removed in an upcoming version. LldpNeighbor represents the details about the device connected to the NIC.
 */
model LldpNeighbor {
  /**
   * The descriptive information about the port on the connected device.
   */
  @visibility(Lifecycle.Read)
  portDescription?: string;

  /**
   * The system-assigned name of the port on the connected device.
   */
  @visibility(Lifecycle.Read)
  portName?: string;

  /**
   * The descriptive information about the connected device.
   */
  @visibility(Lifecycle.Read)
  systemDescription?: string;

  /**
   * The system-assigned name of the connected device.
   */
  @visibility(Lifecycle.Read)
  systemName?: string;
}

/**
 * Type Deprecated. Will be removed in an upcoming version. Nic represents the network interface card details.
 */
model Nic {
  /**
   * The information about the device connected to this NIC.
   */
  @visibility(Lifecycle.Read)
  lldpNeighbor?: LldpNeighbor;

  /**
   * The MAC address associated with this NIC.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The name of the NIC/interface.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * RuntimeProtectionStatus represents the runtime protection status of the bare metal machine.
 */
model RuntimeProtectionStatus {
  /**
   * The runtime protection agent health status.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  agentHealthStatus?: RuntimeProtectionAgentHealthStatus;

  /**
   * The runtime protection agent health status issues, if present.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  agentHealthStatusIssues?: string[];

  /**
   * The runtime protection agent license status.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  agentLicenseStatus?: RuntimeProtectionAgentLicenseStatus;

  /**
   * The definition update mode for runtime protection.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  definitionUpdateMode?: RuntimeProtectionDefinitionUpdateMode;

  /**
   * The timestamp when the malware definitions were last updated.
   */
  @visibility(Lifecycle.Read)
  definitionsLastUpdated?: utcDateTime;

  /**
   * The version of the malware definitions.
   */
  @visibility(Lifecycle.Read)
  definitionsVersion?: string;

  /**
   * The enforcement level set for the runtime protection on the bare metal machine.
   */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  enforcementLevel?: RuntimeProtectionEnforcementLevel;

  /**
   * The timestamp of the most recently completed scan, or empty if there has never been a scan.
   */
  @visibility(Lifecycle.Read)
  scanCompletedTime?: utcDateTime;

  /**
   * The timestamp of the most recently scheduled scan, or empty if no scan has been scheduled.
   */
  @visibility(Lifecycle.Read)
  scanScheduledTime?: utcDateTime;

  /**
   * The timestamp of the most recently started scan, or empty if there has never been a scan.
   */
  @visibility(Lifecycle.Read)
  scanStartedTime?: utcDateTime;
}
