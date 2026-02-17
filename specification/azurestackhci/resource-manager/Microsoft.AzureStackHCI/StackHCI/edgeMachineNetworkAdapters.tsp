import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./edgeMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

namespace Microsoft.AzureStackHCI;

// ==================== Network Adapter Resource ====================

/**
 * Edge Machine Network Adapter Resource.
 */
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineNetworkAdapter
  is Azure.ResourceManager.ProxyResource<EdgeMachineNetworkAdapterProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineNetworkAdapter,
    KeyName = "networkAdapterName",
    SegmentName = "networkAdapters",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Edge Machine Network Adapters.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineNetworkAdapters {
  /** Get a specific network adapter on an Edge Machine. */
  get is ArmResourceRead<EdgeMachineNetworkAdapter>;

  /** List all network adapters on an Edge Machine. */
  list is ArmResourceListByParent<EdgeMachineNetworkAdapter>;
}

// ==================== Network Adapter Jobs Resource ====================

/**
 * Job for an Edge Machine Network Adapter.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@added(Versions.v2026_03_15_preview)
@parentResource(EdgeMachineNetworkAdapter)
model EdgeMachineNetworkAdapterJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineNetworkAdapterJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineNetworkAdapterJob,
    KeyName = "jobName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

/**
 * Operations for Edge Machine Network Adapter Jobs.
 */
@added(Versions.v2026_03_15_preview)
@armResourceOperations
interface EdgeMachineNetworkAdapterJobs {
  /** Get a specific network adapter job. */
  get is ArmResourceRead<EdgeMachineNetworkAdapterJob>;

  /** List all jobs for a network adapter. */
  list is ArmResourceListByParent<EdgeMachineNetworkAdapterJob>;

  /** Create or update a network adapter job. */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineNetworkAdapterJob>;
}

// ==================== Network Adapter Models ====================

/**
 * Properties of the Network Adapter resource.
 */
@added(Versions.v2026_03_15_preview)
model EdgeMachineNetworkAdapterProperties {
  /** The authoritative desired configuration for this specific interface. */
  networkConfiguration?: NetworkAdapterConfiguration;

  /** The actual applied configuration reported by the device. */
  @visibility(Lifecycle.Read)
  reportedProperties?: NetworkAdapterReportedProperties;

  /** Provisioning state of the network adapter resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Network adapter configuration.
 */
@added(Versions.v2026_03_15_preview)
model NetworkAdapterConfiguration {
  /** Adapter name. */
  adapterName?: string;

  /** IP address. */
  ip4Address?: string;

  /** Subnet mask. */
  subnetMask?: string;

  /** Default gateway. */
  defaultGateway?: string;

  /** List of DNS servers. */
  dnsServers?: string[];
}

/**
 * Reported properties of a network adapter.
 */
@added(Versions.v2026_03_15_preview)
model NetworkAdapterReportedProperties {
  ...NetworkAdapterConfiguration;

  /** Interface description of NIC. */
  @visibility(Lifecycle.Read)
  interfaceDescription?: string;

  /** Component ID of NIC. */
  @visibility(Lifecycle.Read)
  componentId?: string;

  /** Driver version of NIC. */
  @visibility(Lifecycle.Read)
  driverVersion?: string;

  /** Default isolation of management NIC. */
  @visibility(Lifecycle.Read)
  defaultIsolationId?: string;

  /** MAC address. */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /** The slot attached to the NIC. */
  @visibility(Lifecycle.Read)
  slot?: string;

  /** The switch attached to the NIC, if any. */
  @visibility(Lifecycle.Read)
  switchName?: string;

  /** Type of network interface. */
  @visibility(Lifecycle.Read)
  interfaceType?: NetworkInterfaceType;

  /** Interface speed in Mbps. */
  @visibility(Lifecycle.Read)
  interfaceSpeed?: int32;

  /** Current state of the interface. */
  @visibility(Lifecycle.Read)
  interfaceState?: InterfaceState;

  /** The type of NIC (physical, virtual, management). */
  @visibility(Lifecycle.Read)
  nicType?: string;

  /** The status of NIC (up, disconnected). */
  @visibility(Lifecycle.Read)
  nicStatus?: string;

  /** IP configuration type. */
  @visibility(Lifecycle.Read)
  ipInterfaceType?: IpInterfaceType;

  /** VLAN identifier (0-4096). */
  @visibility(Lifecycle.Read)
  @minValue(0)
  @maxValue(4096)
  vlanId?: int32;

  /** Indicates if this is a management interface. */
  @visibility(Lifecycle.Read)
  managementInterface?: boolean;

  /** RDMA capability of the network adapter. */
  @visibility(Lifecycle.Read)
  rdmaCapability?: RdmaCapability;

  /** The observed state of network adapter. */
  @visibility(Lifecycle.Read)
  networkAdapterStatus?: NetworkAdapterStatus;
}

/**
 * Type of network interface.
 */
@added(Versions.v2026_03_15_preview)
union NetworkInterfaceType {
  string,

  /** Ethernet interface. */
  Eth: "Eth",

  /** Wi-Fi interface. */
  wifi: "wifi",
}

/**
 * Current state of the interface.
 */
@added(Versions.v2026_03_15_preview)
union InterfaceState {
  string,

  /** Interface is up. */
  up: "up",

  /** Interface is down. */
  down: "down",
}

/**
 * IP configuration type.
 */
@added(Versions.v2026_03_15_preview)
union IpInterfaceType {
  string,

  /** DHCP configuration. */
  Dhcp: "Dhcp",

  /** Static configuration. */
  static: "static",
}

/**
 * The observed state of network adapters.
 */
@added(Versions.v2026_03_15_preview)
model NetworkAdapterStatus {
  /** Network adapter provisioning error code. */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /** Descriptive error message. */
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  /** Network adapter provisioning status. */
  @visibility(Lifecycle.Read)
  provisioningStatus?: NetworkAdapterProvisioningStatus;
}

/**
 * Network adapter provisioning status.
 */
@added(Versions.v2026_03_15_preview)
model NetworkAdapterProvisioningStatus {
  /** The ID of the operation performed on the network adapter. */
  @visibility(Lifecycle.Read)
  operationId?: string;

  /** The status of the operation performed on the network adapter. */
  @visibility(Lifecycle.Read)
  status?: NetworkAdapterOperationStatus;
}

/**
 * Status of network adapter operation.
 */
@added(Versions.v2026_03_15_preview)
union NetworkAdapterOperationStatus {
  string,

  /** Operation succeeded. */
  Succeeded: "Succeeded",

  /** Operation failed. */
  Failed: "Failed",

  /** Operation in progress. */
  InProgress: "InProgress",
}

// ==================== Network Adapter Job Models ====================

/**
 * Properties of the Network Adapter Job.
 */
@added(Versions.v2026_03_15_preview)
model EdgeMachineNetworkAdapterJobProperties {
  /** Type of operation. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: NetworkAdapterJobType;

  /** The desired network configuration to apply. */
  targetConfiguration: NetworkAdapterConfiguration;

  /** Provisioning state of the job. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Status of the job. */
  @visibility(Lifecycle.Read)
  status?: string;

  /** Reported properties for Network Adapter Job. */
  @visibility(Lifecycle.Read)
  reportedProperties?: NetworkAdapterJobReportedProperties;
}

/**
 * Type of network adapter job operation.
 */
@added(Versions.v2026_03_15_preview)
union NetworkAdapterJobType {
  string,

  /** Apply configuration to the network adapter. */
  ApplyConfiguration: "ApplyConfiguration",

  /** Force push configuration to the network adapter. */
  ForcePush: "ForcePush",
}

/**
 * Reported properties for Network Adapter Job.
 */
@added(Versions.v2026_03_15_preview)
model NetworkAdapterJobReportedProperties {
  /** Validation status of Network Adapter Job. */
  @visibility(Lifecycle.Read)
  validationStatus?: NetworkAdapterActionStatus;

  /** Deployment status of Network Adapter Job. */
  @visibility(Lifecycle.Read)
  deploymentStatus?: NetworkAdapterActionStatus;
}

/**
 * The action plan deployment status for Network Adapter Job.
 */
@added(Versions.v2026_03_15_preview)
model NetworkAdapterActionStatus {
  /** Status of ECE action Network Adapter Job. */
  @visibility(Lifecycle.Read)
  status?: string;

  /** List of steps of Network Adapter Job. */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: NetworkAdapterDeploymentStep[];
}

/**
 * The Step of Network Adapter Job.
 */
@added(Versions.v2026_03_15_preview)
model NetworkAdapterDeploymentStep {
  /** Name of step. */
  @visibility(Lifecycle.Read)
  name?: string;

  /** Description of step. */
  @visibility(Lifecycle.Read)
  description?: string;

  /** FullStepIndex of step. */
  @visibility(Lifecycle.Read)
  fullStepIndex?: string;

  /** Start time of step. */
  @visibility(Lifecycle.Read)
  startTimeUtc?: string;

  /** End time of step. */
  @visibility(Lifecycle.Read)
  endTimeUtc?: string;

  /** Status of step (Error, Success, InProgress). */
  @visibility(Lifecycle.Read)
  status?: string;

  /** List of nested steps. */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: NetworkAdapterDeploymentStep[];

  /** List of exceptions. */
  @visibility(Lifecycle.Read)
  exception?: string[];
}
