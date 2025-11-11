import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.NetworkCloud;

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,

  /**
   * user
   */
  user: "user",

  /**
   * system
   */
  system: "system",

  /**
   * user,system
   */
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,

  /**
   * Internal
   */
  Internal: "Internal",
}

/**
 * The detailed status reported by the access bridge.
 */
union AccessBridgeDetailedStatus {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The provisioning state of the access bridge.
 */
union AccessBridgeProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * The direction of allowed network traffic based on the rule. Inbound indicates network traffic flowing to the on-premises cluster.
 */
union SecurityRuleDirection {
  string,

  /**
   * Inbound
   */
  Inbound: "Inbound",

  /**
   * Outbound
   */
  Outbound: "Outbound",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * The status of the action.
 */
union ActionStateStatus {
  string,

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The status of the step. A value of Completed or Failed indicates a terminal state for the step.
 */
union StepStateStatus {
  string,

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",
}

/**
 * The cordon status of the bare metal machine.
 */
union BareMetalMachineCordonStatus {
  string,

  /**
   * Cordoned
   */
  Cordoned: "Cordoned",

  /**
   * Uncordoned
   */
  Uncordoned: "Uncordoned",
}

/**
 * The more detailed status of the bare metal machine.
 */
union BareMetalMachineDetailedStatus {
  string,

  /**
   * Preparing
   */
  Preparing: "Preparing",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Provisioned
   */
  Provisioned: "Provisioned",

  /**
   * Deprovisioning
   */
  Deprovisioning: "Deprovisioning",
}

/**
 * The outcome of the hardware validation.
 */
union BareMetalMachineHardwareValidationResult {
  string,

  /**
   * Pass
   */
  Pass: "Pass",

  /**
   * Fail
   */
  Fail: "Fail",
}

/**
 * The power state derived from the baseboard management controller.
 */
union BareMetalMachinePowerState {
  string,

  /**
   * On
   */
  On: "On",

  /**
   * Off
   */
  Off: "Off",
}

/**
 * The provisioning state of the bare metal machine.
 */
union BareMetalMachineProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The indicator of whether the bare metal machine is ready to receive workloads.
 */
union BareMetalMachineReadyState {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The runtime protection agent health status.
 */
union RuntimeProtectionAgentHealthStatus {
  string,

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * HealthIssuesPresent
   */
  HealthIssuesPresent: "HealthIssuesPresent",
}

/**
 * The runtime protection agent license status.
 */
union RuntimeProtectionAgentLicenseStatus {
  string,

  /**
   * Licensed
   */
  Licensed: "Licensed",

  /**
   * Unlicensed
   */
  Unlicensed: "Unlicensed",
}

/**
 * The definition update mode for runtime protection.
 */
union RuntimeProtectionDefinitionUpdateMode {
  string,

  /**
   * Automatic
   */
  Automatic: "Automatic",

  /**
   * None
   */
  None: "None",
}

/**
 * The mode of operation for runtime protection.
 */
union RuntimeProtectionEnforcementLevel {
  string,

  /**
   * Audit
   */
  Audit: "Audit",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * OnDemand
   */
  OnDemand: "OnDemand",

  /**
   * Passive
   */
  Passive: "Passive",

  /**
   * RealTime
   */
  RealTime: "RealTime",
}

/**
 * The more detailed status of the cloud services network.
 */
union CloudServicesNetworkDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The indicator of whether the platform default endpoints are allowed for the egress traffic.
 */
union CloudServicesNetworkEnableDefaultEgressEndpoints {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The provisioning state of the cloud services network.
 */
union CloudServicesNetworkProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The indicator to enable shared storage on the cloud services network. If not specified, the allocation will align with the standard storage enablement.
 */
union CloudServicesNetworkStorageMode {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Standard
   */
  Standard: "Standard",
}

/**
 * The status of the storage allocation for the cloud services network.
 */
union CloudServicesNetworkStorageStatusStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * ExpandingVolume
   */
  ExpandingVolume: "ExpandingVolume",

  /**
   * ExpansionFailed
   */
  ExpansionFailed: "ExpansionFailed",
}

/**
 * The type (kind) of the cluster. When specified, the value must exactly match the kind configured on the cluster manager that manages the cluster. If omitted, the service will default the value to the kind value of the cluster manager.
 */
union DeploymentType {
  string,

  /**
   * Nexus
   */
  Nexus: "Nexus",

  /**
   * AzureLocal
   */
  AzureLocal: "AzureLocal",
}

/**
 * The detailed status that provides additional information about the cluster manager.
 */
union ClusterManagerDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * ProvisioningFailed
   */
  ProvisioningFailed: "ProvisioningFailed",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * UpdateFailed
   */
  UpdateFailed: "UpdateFailed",
}

/**
 * ProductType represents the type of the cluster manager product.e.g ALRS or Nexus.
 */
union ClusterManagerInternalMetadataProductType {
  string,

  /**
   * ALRS
   */
  ALRS: "ALRS",

  /**
   * Nexus
   */
  Nexus: "Nexus",
}

/**
 * The provisioning state of the cluster manager.
 */
union ClusterManagerProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The type of managed identity that is being selected.
 */
union ManagedServiceIdentitySelectorType {
  string,

  /**
   * SystemAssignedIdentity
   */
  SystemAssignedIdentity: "SystemAssignedIdentity",

  /**
   * UserAssignedIdentity
   */
  UserAssignedIdentity: "UserAssignedIdentity",
}

/**
 * The indicator of whether the control plane will be impacted during the upgrade.
 */
union ControlImpact {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The indicator of whether the workload will be impacted during the upgrade.
 */
union WorkloadImpact {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The latest heartbeat status between the cluster manager and the cluster.
 */
union ClusterConnectionStatus {
  string,

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Timeout
   */
  Timeout: "Timeout",

  /**
   * Undefined
   */
  Undefined: "Undefined",
}

/**
 * The latest connectivity status between cluster manager and the cluster.
 */
union ClusterManagerConnectionStatus {
  string,

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Unreachable
   */
  Unreachable: "Unreachable",
}

/**
 * The type of rack configuration for the cluster.
 */
union ClusterType {
  string,

  /**
   * SingleRack
   */
  SingleRack: "SingleRack",

  /**
   * MultiRack
   */
  MultiRack: "MultiRack",
}

/**
 * The type of command output for the override.
 */
union CommandOutputType {
  string,

  /**
   * BareMetalMachineRunCommand
   */
  BareMetalMachineRunCommand: "BareMetalMachineRunCommand",

  /**
   * BareMetalMachineRunDataExtracts
   */
  BareMetalMachineRunDataExtracts: "BareMetalMachineRunDataExtracts",

  /**
   * BareMetalMachineRunReadCommands
   */
  BareMetalMachineRunReadCommands: "BareMetalMachineRunReadCommands",

  /**
   * StorageRunReadCommands
   */
  StorageRunReadCommands: "StorageRunReadCommands",

  /**
   * BareMetalMachineRunDataExtractsRestricted
   */
  BareMetalMachineRunDataExtractsRestricted: "BareMetalMachineRunDataExtractsRestricted",
}

/**
 * Selection of how the type evaluation is applied to the cluster calculation.
 */
union ValidationThresholdGrouping {
  string,

  /**
   * PerCluster
   */
  PerCluster: "PerCluster",

  /**
   * PerRack
   */
  PerRack: "PerRack",
}

/**
 * Selection of how the threshold should be evaluated.
 */
union ValidationThresholdType {
  string,

  /**
   * CountSuccess
   */
  CountSuccess: "CountSuccess",

  /**
   * PercentSuccess
   */
  PercentSuccess: "PercentSuccess",
}

/**
 * The current detailed status of the cluster.
 */
union ClusterDetailedStatus {
  string,

  /**
   * PendingDeployment
   */
  PendingDeployment: "PendingDeployment",

  /**
   * Deploying
   */
  Deploying: "Deploying",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * UpdatePaused
   */
  UpdatePaused: "UpdatePaused",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The provisioning state of the cluster.
 */
union ClusterProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Validating
   */
  Validating: "Validating",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The indicator if the specified key vault should be used to archive the secrets of the cluster.
 */
union ClusterSecretArchiveEnabled {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The mode of operation for runtime protection.
 */
union ClusterUpdateStrategyType {
  string,

  /**
   * Rack
   */
  Rack: "Rack",

  /**
   * PauseAfterRack
   */
  PauseAfterRack: "PauseAfterRack",
}

/**
 * The mode selection for container vulnerability scanning.
 */
union VulnerabilityScanningSettingsContainerScan {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The version lifecycle indicator.
 */
union AvailabilityLifecycle {
  string,

  /**
   * Preview
   */
  Preview: "Preview",

  /**
   * GenerallyAvailable
   */
  GenerallyAvailable: "GenerallyAvailable",
}

/**
 * The current status of the Kubernetes cluster.
 */
union KubernetesClusterDetailedStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The status representing the state of this feature.
 */
union FeatureDetailedStatus {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The size of the hugepages to allocate.
 */
union HugepagesSize {
  string,

  /**
   * 2M
   */
  `2M`: "2M",

  /**
   * 1G
   */
  `1G`: "1G",
}

/**
 * The indicator of how this network will be utilized by the Kubernetes cluster.
 */
union KubernetesPluginType {
  string,

  /**
   * DPDK
   */
  DPDK: "DPDK",

  /**
   * SRIOV
   */
  SRIOV: "SRIOV",

  /**
   * OSDevice
   */
  OSDevice: "OSDevice",

  /**
   * MACVLAN
   */
  MACVLAN: "MACVLAN",

  /**
   * IPVLAN
   */
  IPVLAN: "IPVLAN",
}

/**
 * The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.
 */
union L3NetworkConfigurationIpamEnabled {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
 */
union AgentPoolMode {
  string,

  /**
   * System
   */
  System: "System",

  /**
   * User
   */
  User: "User",

  /**
   * NotApplicable
   */
  NotApplicable: "NotApplicable",
}

/**
 * The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.
 */
union AdvertiseToFabric {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The indicator to determine if automatic allocation from the pool should occur.
 */
union BfdEnabled {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The indicator to enable multi-hop peering support.
 */
union BgpMultiHop {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The indicator to specify if the load balancer peers with the network fabric.
 */
union FabricPeeringEnabled {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The detailed state of this node.
 */
union KubernetesClusterNodeDetailedStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Scheduling
   */
  Scheduling: "Scheduling",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Terminating
   */
  Terminating: "Terminating",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The indicator of whether this is the default gateway. Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
 */
union DefaultGateway {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The IP allocation mechanism for the virtual machine. Dynamic and Static are only valid for l3Network which may also specify Disabled. Otherwise, Disabled is the only permitted value.
 */
union VirtualMachineIPAllocationMethod {
  string,

  /**
   * Dynamic
   */
  Dynamic: "Dynamic",

  /**
   * Static
   */
  Static: "Static",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * The power state of this node.
 */
union KubernetesNodePowerState {
  string,

  /**
   * On
   */
  On: "On",

  /**
   * Off
   */
  Off: "Off",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The role of this node in the cluster.
 */
union KubernetesNodeRole {
  string,

  /**
   * ControlPlane
   */
  ControlPlane: "ControlPlane",

  /**
   * Worker
   */
  Worker: "Worker",
}

/**
 * The provisioning state of the Kubernetes cluster resource.
 */
union KubernetesClusterProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Created
   */
  Created: "Created",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * The provisioning state of the Kubernetes version resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union KubernetesVersionProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Cancelled
   */
  Cancelled: "Cancelled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * The more detailed status of the L2 network.
 */
union L2NetworkDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
 */
union HybridAksPluginType {
  string,

  /**
   * DPDK
   */
  DPDK: "DPDK",

  /**
   * SRIOV
   */
  SRIOV: "SRIOV",

  /**
   * OSDevice
   */
  OSDevice: "OSDevice",
}

/**
 * The provisioning state of the L2 network.
 */
union L2NetworkProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The more detailed status of the L3 network.
 */
union L3NetworkDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.
 */
union HybridAksIpamEnabled {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The type of the IP address allocation, defaulted to "DualStack".
 */
union IpAllocationType {
  string,

  /**
   * IPV4
   */
  IPV4: "IPV4",

  /**
   * IPV6
   */
  IPV6: "IPV6",

  /**
   * DualStack
   */
  DualStack: "DualStack",
}

/**
 * The provisioning state of the L3 network.
 */
union L3NetworkProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The type of bootstrap protocol used.
 */
union BootstrapProtocol {
  string,

  /**
   * PXE
   */
  PXE: "PXE",
}

/**
 * The connection type of the rack SKU resource.
 */
union MachineSkuDiskConnectionType {
  string,

  /**
   * PCIE
   */
  PCIE: "PCIE",

  /**
   * SATA
   */
  SATA: "SATA",

  /**
   * RAID
   */
  RAID: "RAID",

  /**
   * SAS
   */
  SAS: "SAS",
}

/**
 * The disk type of rack SKU resource.
 */
union DiskType {
  string,

  /**
   * HDD
   */
  HDD: "HDD",

  /**
   * SSD
   */
  SSD: "SSD",
}

/**
 * The connection type of the device.
 */
union DeviceConnectionType {
  string,

  /**
   * PCI
   */
  PCI: "PCI",
}

/**
 * The provisioning state of the rack SKU resource.
 */
union RackSkuProvisioningState {
  string,

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * The type of the rack.
 */
union RackSkuType {
  string,

  /**
   * Aggregator
   */
  Aggregator: "Aggregator",

  /**
   * Compute
   */
  Compute: "Compute",

  /**
   * Single
   */
  Single: "Single",
}

/**
 * The more detailed status of the rack.
 */
union RackDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the rack resource.
 */
union RackProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The registered feature state.
 */
union RegisteredSubscriptionRegisteredFeatureState {
  string,

  /**
   * Registered
   */
  Registered: "Registered",
}

/**
 * The detailed status of the storage appliance.
 */
union StorageApplianceDetailedStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the storage appliance.
 */
union StorageApplianceProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The indicator of whether the storage appliance supports remote vendor management.
 */
union RemoteVendorManagementFeature {
  string,

  /**
   * Supported
   */
  Supported: "Supported",

  /**
   * Unsupported
   */
  Unsupported: "Unsupported",
}

/**
 * The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
 */
union RemoteVendorManagementStatus {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Unsupported
   */
  Unsupported: "Unsupported",
}

/**
 * The more detailed status of the trunked network.
 */
union TrunkedNetworkDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Available
   */
  Available: "Available",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the trunked network.
 */
union TrunkedNetworkProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * Selects the boot method for the virtual machine.
 */
union VirtualMachineBootMethod {
  string,

  /**
   * UEFI
   */
  UEFI: "UEFI",

  /**
   * BIOS
   */
  BIOS: "BIOS",
}

/**
 * The more detailed status of the virtual machine.
 */
union VirtualMachineDetailedStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Scheduling
   */
  Scheduling: "Scheduling",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Terminating
   */
  Terminating: "Terminating",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
 */
union VirtualMachineIsolateEmulatorThread {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The specification of whether this hint supports affinity or anti-affinity with the referenced resources.
 */
union VirtualMachinePlacementHintType {
  string,

  /**
   * Affinity
   */
  Affinity: "Affinity",

  /**
   * AntiAffinity
   */
  AntiAffinity: "AntiAffinity",
}

/**
 * The indicator of whether the hint is a hard or soft requirement during scheduling.
 */
union VirtualMachineSchedulingExecution {
  string,

  /**
   * Hard
   */
  Hard: "Hard",

  /**
   * Soft
   */
  Soft: "Soft",
}

/**
 * The scope for the virtual machine affinity or anti-affinity placement hint. It should always be "Machine" in the case of node affinity.
 */
union VirtualMachinePlacementHintPodAffinityScope {
  string,

  /**
   * Rack
   */
  Rack: "Rack",

  /**
   * Machine
   */
  Machine: "Machine",
}

/**
 * The power state of the virtual machine.
 */
union VirtualMachinePowerState {
  string,

  /**
   * On
   */
  On: "On",

  /**
   * Off
   */
  Off: "Off",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The provisioning state of the virtual machine.
 */
union VirtualMachineProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The strategy for creating the OS disk.
 */
union OsDiskCreateOption {
  string,

  /**
   * Utilize the local storage of the host machine.
   */
  Ephemeral: "Ephemeral",

  /**
   * Utilize a storage appliance backed volume to host the disk.
   */
  Persistent: "Persistent",
}

/**
 * The strategy for deleting the OS disk.
 */
union OsDiskDeleteOption {
  string,

  /**
   * Delete
   */
  Delete: "Delete",
}

/**
 * Field Deprecated, use virtualizationModel instead. The type of the virtio interface.
 */
union VirtualMachineVirtioInterfaceType {
  string,

  /**
   * Modern
   */
  Modern: "Modern",

  /**
   * Transitional
   */
  Transitional: "Transitional",
}

/**
 * The type of the device model to use.
 */
union VirtualMachineDeviceModelType {
  string,

  /**
   * Traditional and most compatible device virtualization interface.
   */
  T1: "T1",

  /**
   * Modern and enhanced device virtualization interface.
   */
  T2: "T2",

  /**
   * Improved security and functionality (including TPM and secure boot support). Required for windows 11 and server 2025.
   */
  T3: "T3",
}

/**
 * The more detailed status of the volume.
 */
union VolumeDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Active
   */
  Active: "Active",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the volume.
 */
union VolumeProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AccessBridgeAllowedName {
  string,

  /**
   * Bastion
   */
  Bastion: "Bastion",

  /**
   * PrivateVault
   */
  PrivateVault: "PrivateVault",

  /**
   * StorageDashboard
   */
  StorageDashboard: "StorageDashboard",
}

/**
 * The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.
 */
union BareMetalMachineEvacuate {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The indicator of whether to skip the graceful OS shutdown and power off the bare metal machine immediately.
 */
union BareMetalMachineSkipShutdown {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The safeguard mode to use for the replace action, where None indicates to bypass safeguards and All indicates to utilize all safeguards.
 */
union BareMetalMachineReplaceSafeguardMode {
  string,

  /**
   * All
   */
  All: "All",

  /**
   * None
   */
  None: "None",
}

/**
 * The indicator of whether to bypass clearing storage while replacing a bare metal machine.
 */
union BareMetalMachineReplaceStoragePolicy {
  string,

  /**
   * Preserve
   */
  Preserve: "Preserve",

  /**
   * DiscardAll
   */
  DiscardAll: "DiscardAll",
}

/**
 * The state to set for the private endpoint connection.
 */
union RelayPrivateEndpointConnectionState {
  string,

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",
}

/**
 * The more detailed status of the key set.
 */
union BareMetalMachineKeySetDetailedStatus {
  string,

  /**
   * AllActive
   */
  AllActive: "AllActive",

  /**
   * SomeInvalid
   */
  SomeInvalid: "SomeInvalid",

  /**
   * AllInvalid
   */
  AllInvalid: "AllInvalid",

  /**
   * Validating
   */
  Validating: "Validating",
}

/**
 * The access level allowed for the users in this key set.
 */
union BareMetalMachineKeySetPrivilegeLevel {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Superuser
   */
  Superuser: "Superuser",

  /**
   * Other
   */
  Other: "Other",
}

/**
 * The provisioning state of the bare metal machine key set.
 */
union BareMetalMachineKeySetProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The indicator of whether the user is currently deployed for access.
 */
union BareMetalMachineKeySetUserSetupStatus {
  string,

  /**
   * Active
   */
  Active: "Active",

  /**
   * Invalid
   */
  Invalid: "Invalid",
}

/**
 * The more detailed status of the key set.
 */
union BmcKeySetDetailedStatus {
  string,

  /**
   * AllActive
   */
  AllActive: "AllActive",

  /**
   * SomeInvalid
   */
  SomeInvalid: "SomeInvalid",

  /**
   * AllInvalid
   */
  AllInvalid: "AllInvalid",

  /**
   * Validating
   */
  Validating: "Validating",
}

/**
 * The access level allowed for the users in this key set.
 */
union BmcKeySetPrivilegeLevel {
  string,

  /**
   * ReadOnly
   */
  ReadOnly: "ReadOnly",

  /**
   * Administrator
   */
  Administrator: "Administrator",
}

/**
 * The provisioning state of the baseboard management controller key set.
 */
union BmcKeySetProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The mode by which the cluster will target the next grouping of servers to continue the update.
 */
union ClusterContinueUpdateVersionMachineGroupTargetingMode {
  string,

  /**
   * AlphaByRack
   */
  AlphaByRack: "AlphaByRack",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union ClusterInspectParametersAdditionalActionsItem {
  string,

  /**
   * ResetHardware
   */
  ResetHardware: "ResetHardware",
}

/**
 * The more detailed status of the metrics configuration.
 */
union ClusterMetricsConfigurationDetailedStatus {
  string,

  /**
   * Processing
   */
  Processing: "Processing",

  /**
   * Applied
   */
  Applied: "Applied",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * The provisioning state of the metrics configuration.
 */
union ClusterMetricsConfigurationProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The choice of if the scan operation should run the scan.
 */
union ClusterScanRuntimeParametersScanActivity {
  string,

  /**
   * Scan
   */
  Scan: "Scan",

  /**
   * Skip
   */
  Skip: "Skip",
}

/**
 * The current status of the agent pool.
 */
union AgentPoolDetailedStatus {
  string,

  /**
   * Available
   */
  Available: "Available",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the agent pool.
 */
union AgentPoolProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The lifecycle indicator of the feature.
 */
union KubernetesClusterFeatureAvailabilityLifecycle {
  string,

  /**
   * Preview
   */
  Preview: "Preview",

  /**
   * GenerallyAvailable
   */
  GenerallyAvailable: "GenerallyAvailable",
}

/**
 * The detailed status of the feature.
 */
union KubernetesClusterFeatureDetailedStatus {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Installed
   */
  Installed: "Installed",
}

/**
 * The provisioning state of the Kubernetes cluster feature.
 */
union KubernetesClusterFeatureProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The indicator of if the feature is required or optional. Optional features may be deleted by the user, while required features are managed with the kubernetes cluster lifecycle.
 */
union KubernetesClusterFeatureRequired {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The provisioning state of the Kubernetes cluster feature . Cannot be patched by the user.
 */
union KubernetesClusterFeaturePatchPropertiesProvisioningState {
  string,

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * The indicator of which relay type the machine should be assigned to use. Platform indicates the use of a platform-dedicated relay. Public indicates the use of the standard public relay for Arc services.
 */
union RelayType {
  string,

  /**
   * Platform
   */
  Platform: "Platform",

  /**
   * Public
   */
  Public: "Public",
}

/**
 * The more detailed status of the console.
 */
union ConsoleDetailedStatus {
  string,

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * The indicator of whether the console access is enabled.
 */
union ConsoleEnabled {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * The provisioning state of the virtual machine console.
 */
union ConsoleProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Accepted
   */
  Accepted: "Accepted",
}

/**
 * The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.
 */
union SkipShutdown {
  string,

  /**
   * True
   */
  True: "True",

  /**
   * False
   */
  False: "False",
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * AccessBridgeList represents a paged list of access bridges.
 */
model AccessBridgeList is Azure.Core.Page<AccessBridge>;

/**
 * ExtendedLocation represents the Azure custom location where the resource will be created.
 */
model ExtendedLocation {
  /**
   * The resource ID of the extended location on which the resource will be created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  /**
   * The extended location type, for example, CustomLocation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  type: string;
}

/**
 * AccessBridgeProperties captures the input and status for an access bridge.
 */
model AccessBridgeProperties {
  /**
   * The detailed status reported by the access bridge.
   */
  detailedStatus?: AccessBridgeDetailedStatus;

  /**
   * The descriptive message that accompanies the detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The observed endpoints that clients should use to reach the access bridge.
   */
  @identifiers(#["fqdn"])
  endpoints?: AccessBridgeEndpoint[];

  /**
   * The IPv4 subnet from which the access bridge allocates an address. This subnet must be part of the internal network specified by networkId.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4ConnectedPrefix?: string;

  /**
   * The IPv6 subnet from which the access bridge allocates an address. This subnet must be part of the internal network specified by networkId.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv6ConnectedPrefix?: string;

  /**
   * The resource ID of the internal network in a layer 3 isolation domain containing the IP subnets to use.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains/internalNetworks";
    }
  ]>;

  /**
   * The protocol advertised by the access bridge endpoints.
   */
  protocol?: string;

  /**
   * The provisioning state of the access bridge.
   */
  provisioningState?: AccessBridgeProvisioningState;

  /**
   * The list of security rules enforced by the access bridge.
   */
  @identifiers(#[])
  securityRules?: AccessBridgeSecurityRule[];
}

/**
 * AccessBridgeEndpoint describes a single advertised service endpoint.
 */
model AccessBridgeEndpoint {
  /**
   * The fully qualified domain name used to describe the certificate name for the endpoint.
   */
  fqdn?: string;

  /**
   * The IPv4 address associated with the endpoint.
   */
  ipv4Address?: string;

  /**
   * The IPv6 address associated with the endpoint.
   */
  ipv6Address?: string;

  /**
   * The name that identifies the type of endpoint (for example VIP or host).
   */
  name?: string;
}

/**
 * AccessBridgeSecurityRule captures an individual access rule enforced by the bridge.
 */
model AccessBridgeSecurityRule {
  /**
   * The user provided value describing this rule.
   */
  description?: string;

  /**
   * The direction of allowed network traffic based on the rule. Inbound indicates network traffic flowing to the on-premises cluster.
   */
  direction: SecurityRuleDirection;

  /**
   * The set of IPv4 addresses permitted as the source or destination of the security rule. For as single address, utilize a /32 (CIDR notation). One or both Ipv4Addresses and Ipv6Addresses must be specified. Example formats: 10.10.10.10-10.10.10.20 or 10.10.10.10/24.
   */
  ipv4Addresses?: string[];

  /**
   * The set of IPv6 addresses permitted as the source or destination of the security rule. For as single address, utilize a /128 (CIDR notation). One or both Ipv4Addresses and Ipv6Addresses must be specified. Example formats: 2001:db8:abcd::1-2001:db8:abcd::ff or 2001:db8:abcd::1/64.
   */
  ipv6Addresses?: string[];

  /**
   * The source or destination port or port range. Example 24562 or 24562-24570.
   */
  port: string;
}

/**
 * BareMetalMachineList represents a list of bare metal machines.
 */
model BareMetalMachineList is Azure.Core.Page<BareMetalMachine>;

/**
 * BareMetalMachineProperties represents the properties of a bare metal machine.
 */
model BareMetalMachineProperties {
  /**
   * The current state of any in progress or completed actions. The most recent known instance of each action type is shown.
   */
  @identifiers(#["actionType"])
  actionStates?: ActionState[];

  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  associatedResourceIds?: string[];

  /**
   * The connection string for the baseboard management controller including IP address and protocol.
   */
  bmcConnectionString: string;

  /**
   * The credentials of the baseboard management controller on this bare metal machine.
   */
  bmcCredentials: AdministrativeCredentials;

  /**
   * The IPv4 address of the BMC interface for the bare metal machine.
   */
  bmcIpv4Address?: string;

  /**
   * The IPv6 address of the BMC interface for the bare metal machine.
   */
  bmcIpv6Address?: string;

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
   * The CA certificate information issued by the platform for connecting to TLS interfaces for the bare metal machine. Callers add this certificate to the trusted CA store on the Kubernetes control plane nodes to allow secure communication with the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  caCertificate?: CertificateInfo;

  /**
   * The resource ID of the cluster this bare metal machine is associated with.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The cordon status of the bare metal machine.
   */
  cordonStatus?: BareMetalMachineCordonStatus;

  /**
   * The more detailed status of the bare metal machine.
   */
  detailedStatus?: BareMetalMachineDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
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
  hybridAksClustersAssociatedIds?: string[];

  /**
   * BareMetalMachineInternalMetadata represents the configuration details of the bare metal machine that are NOT exposed to the customer.
   */
  internalMetadata?: BareMetalMachineInternalMetadata;

  /**
   * The name of this machine represented by the host object in the Cluster's Kubernetes control plane.
   */
  kubernetesNodeName?: string;

  /**
   * The version of Kubernetes running on this machine.
   */
  kubernetesVersion?: string;

  /**
   * The cluster version that has been applied to this machine during deployment or a version update.
   */
  machineClusterVersion?: string;

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
   * The list of roles that are assigned to the cluster node running on this machine.
   */
  machineRoles?: string[];

  /**
   * The unique internal identifier of the bare metal machine SKU.
   */
  machineSkuId: string;

  /**
   * The IPv4 address that is assigned to the bare metal machine during the cluster deployment.
   */
  oamIpv4Address?: string;

  /**
   * The IPv6 address that is assigned to the bare metal machine during the cluster deployment.
   */
  oamIpv6Address?: string;

  /**
   * The image that is currently provisioned to the OS disk.
   */
  osImage?: string;

  /**
   * The power state derived from the baseboard management controller.
   */
  powerState?: BareMetalMachinePowerState;

  /**
   * The provisioning state of the bare metal machine.
   */
  provisioningState?: BareMetalMachineProvisioningState;

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
   * The indicator of whether the bare metal machine is ready to receive workloads.
   */
  readyState?: BareMetalMachineReadyState;

  /**
   * The runtime protection status of the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  runtimeProtectionStatus?: RuntimeProtectionStatus;

  /**
   * The list of statuses that represent secret rotation activity.
   */
  @identifiers(#["secretType"])
  secretRotationStatus?: SecretRotationStatus[];

  /**
   * The serial number of the bare metal machine.
   */
  @maxLength(64)
  @minLength(1)
  serialNumber: string;

  /**
   * The discovered value of the machine's service tag.
   */
  serviceTag?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the VirtualMachines that are hosted on this bare metal machine.
   */
  virtualMachinesAssociatedIds?: string[];
}

/**
 * ActionState represents the state of an action taken against a resource. This can be used to represent both explicitly and implicitly defined action types.
 */
model ActionState {
  /**
   * The representation of the action for which this is a status. Matches ARM resource action format when the action is an ARM-based action.
   */
  actionType?: string;

  /**
   * The correlation ID for the original action request. Omitted if there is no related correlation ID.
   */
  correlationId?: string;

  /**
   * The timestamp of when the action reached its final, terminal state. Uses ISO 8601 format.
   */
  endTime?: string;

  /**
   * The description providing additional context for the status value. May be empty or contain guidance in the case of a failure.
   */
  message?: string;

  /**
   * The timestamp of when the action began, in ISO 8601 format.
   */
  startTime?: string;

  /**
   * The status of the action.
   */
  status?: ActionStateStatus;

  /**
   * The ordered list of the individual steps which make up the action.
   */
  @identifiers(#[])
  stepStates?: StepState[];
}

/**
 * StepState represents the state of a step in an action.
 */
model StepState {
  /**
   * The timestamp for when processing of the step reached its terminal state, in ISO 8601 format.
   */
  endTime?: string;

  /**
   * The message providing additional context for the status value. May be empty, or contain diagnostic information in the case of a failure.
   */
  message?: string;

  /**
   * The timestamp for when processing of the step began, in ISO 8601 format.
   */
  startTime?: string;

  /**
   * The status of the step. A value of Completed or Failed indicates a terminal state for the step.
   */
  status?: StepStateStatus;

  /**
   * The name for the step.
   */
  stepName?: string;
}

/**
 * AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.
 */
model AdministrativeCredentials {
  /**
   * The password of the administrator of the device used during initialization.
   */
  @minLength(1)
  password: string;

  /**
   * PasswordReference contains the reference to the source of a password.
   */
  passwordRef?: PasswordReference;

  /**
   * The username of the administrator of the device used during initialization.
   */
  @minLength(1)
  username: string;
}

/**
 * PasswordReference contains the reference to the source of a password.
 */
model PasswordReference {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  kind?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `namespace`?: string;
}

/**
 * CertificateInfo represents the non-private information of an X.509 Certificate.
 */
model CertificateInfo {
  /**
   * The hash value of the X.509 Certificate.
   */
  hash?: string;

  /**
   * The textual value of the X.509 Certificate.
   */
  value?: string;
}

/**
 * HardwareInventory represents the hardware configuration of this machine as exposed to the customer, including information acquired from the model/sku information and from the ironic inspector.
 */
model HardwareInventory {
  /**
   * Freeform data extracted from the environment about this machine. This information varies depending on the specific hardware and configuration.
   */
  additionalHostInformation?: string;

  /**
   * The list of network interfaces and associated details for the bare metal machine.
   */
  @identifiers(#["name"])
  interfaces?: HardwareInventoryNetworkInterface[];

  /**
   * Field Deprecated. Will be removed in an upcoming version. The list of network interface cards and associated details for the bare metal machine.
   */
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
  linkStatus?: string;

  /**
   * The MAC address associated with this interface.
   */
  macAddress?: string;

  /**
   * The name of the interface.
   */
  name?: string;

  /**
   * The resource ID of the network interface for the port on the switch that this machine's interface is connected to.
   */
  networkInterfaceId?: string;
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
  macAddress?: string;

  /**
   * The name of the NIC/interface.
   */
  name?: string;
}

/**
 * Type Deprecated. Will be removed in an upcoming version. LldpNeighbor represents the details about the device connected to the NIC.
 */
model LldpNeighbor {
  /**
   * The descriptive information about the port on the connected device.
   */
  portDescription?: string;

  /**
   * The system-assigned name of the port on the connected device.
   */
  portName?: string;

  /**
   * The descriptive information about the connected device.
   */
  systemDescription?: string;

  /**
   * The system-assigned name of the connected device.
   */
  systemName?: string;
}

/**
 * HardwareValidationStatus represents the latest hardware validation details performed for this bare metal machine.
 */
model HardwareValidationStatus {
  /**
   * The timestamp of the hardware validation execution.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastValidationTime?: utcDateTime;

  /**
   * The outcome of the hardware validation.
   */
  result?: BareMetalMachineHardwareValidationResult;
}

/**
 * BareMetalMachineInternalMetadata represents the configuration details of the bare metal machine that are NOT exposed to the customer.
 */
model BareMetalMachineInternalMetadata {
  /**
   * BareMetalHost represents the details of the bare metal host.
   */
  bareMetalHost?: BareMetalHost;

  /**
   * The reference of the credential manager secret version for the bmc credential.
   */
  bmcCredentialSecretVersion?: string;

  /**
   * The list of statuses that represent secret rotation activity.
   */
  secretRotationStatus?: SecretRotationStatus[];

  /**
   * The thumbprint or SHA of the TPM endorsement key that ensures authenticity of the bare metal machine.
   */
  tpmEndorsementKey?: string;
}

/**
 * BareMetalHost represents the details of the bare metal host.
 */
model BareMetalHost {
  /**
   * The name of the secret containing the BMC credentials.
   */
  bmcCredentialsSecretName?: string;

  /**
   * The namespace of the secret containing the BMC credentials.
   */
  bmcCredentialsSecretNamespace?: string;

  /**
   * BmcNcUser represents the details of the BMC NC user.
   */
  bmcNcUsers?: BmcNcUserData;

  /**
   * The name of the bare metal host that implements this bare metal machine in Metal3.
   */
  hostName?: string;

  /**
   * The namespace of the bare metal host that implements this bare metal machine in Metal3.
   */
  hostNamespace?: string;
}

/**
 * BmcNcUser represents the details of the BMC NC user.
 */
model BmcNcUserData {
  /**
   * The list of BMC users created internally.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  bmcUsers?: Record<BmcUserDetails>;
}

/**
 * BmcUserDetails represents the details of the BMC user.
 */
model BmcUserDetails {
  /**
   * User Role of the BMC user. Either Administrator or Readonly.
   */
  role?: string;

  /**
   * Secret name of the BMC user.
   */
  secretName?: string;

  /**
   * Secret namespace of the BMC user.
   */
  secretNamespace?: string;

  /**
   * The username of the BMC user.
   */
  username?: string;
}

/**
 * SecretRotationStatus represents the status of a secret rotation.
 */
model SecretRotationStatus {
  /**
   * The maximum number of days the secret may be used before it must be changed.
   */
  expirePeriodDays?: int64;

  /**
   * The system name used to identify the secret.
   */
  k8sSecretName?: string;

  /**
   * The date and time when the secret was last changed.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRotationTime?: utcDateTime;

  /**
   * The number of days a secret exists before rotations will be attempted.
   */
  rotationPeriodDays?: int64;

  /**
   * The reference to the secret in a key vault.
   */
  @visibility(Lifecycle.Read)
  secretArchiveReference?: SecretArchiveReference;

  /**
   * The type name used to identify the purpose of the secret.
   */
  secretType?: string;
}

/**
 * SecretArchiveReference represents the reference to a secret in a key vault.
 */
model SecretArchiveReference {
  /**
   * The resource ID of the key vault containing the secret.
   */
  keyVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * The URI of the key containing the secret.
   */
  keyVaultUri?: url;

  /**
   * The name of the secret in the key vault.
   */
  secretName?: string;

  /**
   * The version of the secret in the key vault.
   */
  secretVersion?: string;
}

/**
 * RuntimeProtectionStatus represents the runtime protection status of the bare metal machine.
 */
model RuntimeProtectionStatus {
  /**
   * The runtime protection agent health status.
   */
  agentHealthStatus?: RuntimeProtectionAgentHealthStatus;

  /**
   * The runtime protection agent health status issues, if present.
   */
  @identifiers(#[])
  agentHealthStatusIssues?: string[];

  /**
   * The runtime protection agent license status.
   */
  agentLicenseStatus?: RuntimeProtectionAgentLicenseStatus;

  /**
   * The definition update mode for runtime protection.
   */
  definitionUpdateMode?: RuntimeProtectionDefinitionUpdateMode;

  /**
   * The timestamp when the malware definitions were last updated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  definitionsLastUpdated?: utcDateTime;

  /**
   * The version of the malware definitions.
   */
  definitionsVersion?: string;

  /**
   * The enforcement level set for the runtime protection on the bare metal machine.
   */
  enforcementLevel?: RuntimeProtectionEnforcementLevel;

  /**
   * The timestamp of the most recently completed scan, or empty if there has never been a scan.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanCompletedTime?: utcDateTime;

  /**
   * The timestamp of the most recently scheduled scan, or empty if no scan has been scheduled.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanScheduledTime?: utcDateTime;

  /**
   * The timestamp of the most recently started scan, or empty if there has never been a scan.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanStartedTime?: utcDateTime;
}

/**
 * CloudServicesNetworkList represents a list of cloud services networks.
 */
model CloudServicesNetworkList is Azure.Core.Page<CloudServicesNetwork>;

/**
 * CloudServicesNetworkProperties represents properties of the cloud services network.
 */
model CloudServicesNetworkProperties {
  /**
   * The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.
   */
  @identifiers(#[])
  additionalEgressEndpoints?: EgressEndpoint[];

  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this cloud services network is associated with.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the cloud services network.
   */
  detailedStatus?: CloudServicesNetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The indicator of whether the platform default endpoints are allowed for the egress traffic.
   */
  enableDefaultEgressEndpoints?: CloudServicesNetworkEnableDefaultEgressEndpoints;

  /**
   * The full list of additional and default egress endpoints that are currently enabled.
   */
  @identifiers(#[])
  enabledEgressEndpoints?: EgressEndpoint[];

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this cloud services network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * The name of the interface that will be present in the virtual machine to represent this network.
   */
  interfaceName?: string;

  /**
   * The provisioning state of the cloud services network.
   */
  provisioningState?: CloudServicesNetworkProvisioningState;

  /**
   * The storage options for the cloud services network.
   */
  storageOptions?: CloudServicesNetworkStorageOptions;

  /**
   * The storage status for the cloud services network.
   */
  @visibility(Lifecycle.Read)
  storageStatus?: CloudServicesNetworkStorageStatus;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this cloud services network.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];
}

/**
 * EgressEndpoint represents the connection from a cloud services network to the specified endpoint for a common purpose.
 */
model EgressEndpoint {
  /**
   * The descriptive category name of endpoints accessible by the AKS agent node. For example, azure-resource-management, API server, etc. The platform egress endpoints provided by default will use the category 'default'.
   */
  category: string;

  /**
   * The list of endpoint dependencies.
   */
  @identifiers(#[])
  endpoints: EndpointDependency[];
}

/**
 * EndpointDependency represents the definition of an endpoint, including the domain and details.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency.
   */
  domainName: string;

  /**
   * The port of this endpoint.
   */
  @maxValue(65535)
  @minValue(1)
  port?: int64;
}

/**
 * CloudServicesNetworkStorageOptions represents the storage options for the cloud services network.
 */
model CloudServicesNetworkStorageOptions {
  /**
   * The indicator to enable shared storage on the cloud services network. If not specified, the allocation will align with the standard storage enablement.
   */
  mode?: CloudServicesNetworkStorageMode;

  /**
   * The requested storage allocation for the volume in Mebibytes.
   */
  @minValue(1)
  sizeMiB?: int64;

  /**
   * The resource ID of the storage appliance that hosts the storage.
   */
  storageApplianceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/storageAppliances";
    }
  ]>;
}

/**
 * CloudServicesNetworkStorageStatus represents the storage status of the cloud services network.
 */
model CloudServicesNetworkStorageStatus {
  /**
   * The indicator of if shared storage is enabled on the cloud services network.
   */
  mode?: CloudServicesNetworkStorageMode;

  /**
   * The size in Mebibytes of the storage allocation.
   */
  sizeMiB?: int64;

  /**
   * The status of the storage allocation for the cloud services network.
   */
  status?: CloudServicesNetworkStorageStatusStatus;

  /**
   * The description for the status of the shared storage.
   */
  statusMessage?: string;

  /**
   * The resource ID of the volume created to host the shared storage.
   */
  volumeId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/volumes";
    }
  ]>;
}

/**
 * ClusterManagerList represents a list of cluster manager objects.
 */
model ClusterManagerList is Azure.Core.Page<ClusterManager>;

/**
 * ClusterManagerProperties represents the properties of a cluster manager.
 */
model ClusterManagerProperties {
  /**
   * The resource ID of the Log Analytics workspace that is used for the logs collection.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  analyticsWorkspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The Azure availability zones within the region that will be used to support the cluster manager resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  availabilityZones?: string[];

  /**
   * The list of the cluster versions the manager supports. It is used as input in clusterVersion property of a cluster resource.
   */
  @identifiers(#["targetClusterVersion"])
  clusterVersions?: ClusterAvailableVersion[];

  /**
   * The detailed status that provides additional information about the cluster manager.
   */
  detailedStatus?: ClusterManagerDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The resource ID of the fabric controller that has one to one mapping with the cluster manager.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricControllerId: Azure.Core.armResourceIdentifier;

  /**
   * ClusterManagerInternalMetadata represents configuration details of cluster manager that are NOT exposed to the customer.
   */
  internalMetadata?: ClusterManagerInternalMetadata;

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The extended location (custom location) that represents the cluster manager's control plane location. This extended location is used when creating cluster and rack manifest resources.
   */
  @visibility(Lifecycle.Read)
  managerExtendedLocation?: ExtendedLocation;

  /**
   * The provisioning state of the cluster manager.
   */
  provisioningState?: ClusterManagerProvisioningState;

  /**
   * The relay configuration for the cluster manager.
   */
  @visibility(Lifecycle.Read)
  relayConfiguration?: ClusterManagerRelayConfiguration;

  /**
   * The size of the Azure virtual machines to use for hosting the cluster manager resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSize?: string;
}

/**
 * ClusterAvailableVersion represents the cluster version that the cluster manager can be asked to create and manage.
 */
model ClusterAvailableVersion {
  /**
   * The last date the version of the platform is supported.
   */
  supportExpiryDate?: string;

  /**
   * The version of the cluster to be deployed.
   */
  targetClusterVersion?: string;
}

/**
 * ClusterManagerInternalMetadata represents configuration details of cluster manager that are NOT exposed to the customer.
 */
model ClusterManagerInternalMetadata {
  /**
   * The resource ID of the AKS cluster created to run the cluster manager.
   */
  aksClusterId?: string;

  /**
   * AksMrgId is the ID of the AKS cluster's managed resource group.
   */
  aksMrgId?: string;

  /**
   * The resource ID of the UAMI used by the AKS cluster created to run the cluster manager.
   */
  aksUserAssignedIdentityId?: string;

  /**
   * The object ID of the UAMI used by the AKS cluster created to run the cluster manager.
   */
  aksUserAssignedIdentityObjectId?: string;

  /**
   * The resource ID of the Cluster Operator Extension
   */
  clusterOperatorExtensionId?: string;

  /**
   * The resource ID of the connected cluster resource created by the cluster manager.
   */
  connectedClusterId?: string;

  /**
   * The cluster manager extension current version
   */
  currentVersion?: string;

  /**
   * The cluster manager extension desired version
   */
  desiredVersion?: string;

  /**
   * Whether or not to redeploy resources for the cluster manager
   */
  forceReconcile?: boolean;

  /**
   * The resource ID of the HOBO resource group containing component resources for the cluster manager.
   */
  hoboResourceGroupId?: string;

  /**
   * The subscription ID where the HOBO resources for the cluster manager will be housed.
   */
  hoboSubscriptionId?: string;

  /**
   * InfraProxyConfig represents the infrastructure proxy configuration.
   */
  infraProxyConfig?: InfraProxyConfig;

  /**
   * The resource ID of the key vault created and used by the cluster manager.
   */
  keyVaultId?: string;

  /**
   * The cluster manager kubernetes current version
   */
  kubernetesCurrentVersion?: string;

  /**
   * The cluster manager kubernetes desired version
   */
  kubernetesDesiredVersion?: string;

  /**
   * The resource ID of the managed resource group containing component resources for the cluster manager.
   */
  managedResourceGroupId?: string;

  /**
   * The Network Cloud environment name
   */
  networkCloudEnvironmentName?: string;

  /**
   * ClusterManagerInternalMetadataNfcInfrastructureConfiguration represents a cache of the NFC Provided and owned InfrastructureConfiguration data.
   */
  nfcInfrastructureConfiguration?: ClusterManagerInternalMetadataNfcInfrastructureConfiguration;

  /**
   * ProductType represents the type of the cluster manager product.e.g ALRS or Nexus.
   */
  productType?: ClusterManagerInternalMetadataProductType;

  /**
   * ClusterManagerInternalMetadataPublicIpPrefix represents details about the per ClusterManager Public IP Prefix.
   */
  publicIpPrefix?: ClusterManagerInternalMetadataPublicIpPrefix;

  /**
   * ReconcileStatus represents the information about reconciliation operations that were unsuccessful or bypassed.
   */
  reconcileStatus?: ReconcileStatus;

  /**
   * ClusterManagerInternalMetadataRegistryCredentials represents details about the per ClusterManager ACR Credentials generated by the RP.
   */
  registryCredentials?: ClusterManagerInternalMetadataRegistryCredentials;

  /**
   * ClusterManagerInternalMetadataRelay represents details about the per ClusterManager Arc Relay.
   */
  relay?: ClusterManagerInternalMetadataRelay;

  /**
   * The resource ID of the storage account created and used to store bootstrap images, command execution results, etc.
   */
  storageAccountId?: string;

  /**
   * Predefined list of IP addresses or CIDRs used for Cluster manager storage account firewall configuration to limit access
   */
  storageAccountIpMasks?: string[];

  /**
   * The Tenant ID used by cluster manager
   */
  tenantId?: string;

  /**
   * The copy of nc-versions data that the cluster manager can refer to.
   */
  versions?: string;
}

/**
 * InfraProxyConfig represents the infrastructure proxy configuration.
 */
model InfraProxyConfig {
  /**
   * List of service bus endpoints supplied by Arc at the time of creation, update, or upgrade of the Cluster Manager.
   */
  arcServiceBusEndpoints?: string[];

  /**
   * Complete list of the infra proxy allowlist.
   */
  completeInfraProxyAllowlist?: string[];

  /**
   * List of dynamic endpoints provided by the cluster operator.
   */
  dynamicCMEndpoints?: string[];

  /**
   * List of endpoints provided by the RP at the time of creation or upgrade of the Cluster Manager.
   */
  staticRPEndpoints?: string[];
}

/**
 * ClusterManagerInternalMetadataNfcInfrastructureConfiguration represents a cache of the NFC Provided and owned InfrastructureConfiguration data.
 */
model ClusterManagerInternalMetadataNfcInfrastructureConfiguration {
  /**
   * The Docker CIDR for both the NFA and NC AKS's
   */
  aksDockerCidrPrefix?: string;

  /**
   * The Service CIDR for both the NFA and NC AKS's
   */
  aksServiceCidrPrefix?: string;

  /**
   * The Subnet Ipv4 Prefix for the NC AKS
   */
  networkCloudSubnetIPv4Prefix?: string;

  /**
   * The SubnetId for the NC AKS
   */
  networkCloudSubnetId?: string;
}

/**
 * ClusterManagerInternalMetadataPublicIpPrefix represents details about the per ClusterManager Public IP Prefix.
 */
model ClusterManagerInternalMetadataPublicIpPrefix {
  /**
   * The resource ID of the Public IP Prefix created for this cluster manager.
   */
  id?: string;

  /**
   * The IP Prefix in CIDR format
   */
  ipPrefix?: string;
}

/**
 * ReconcileStatus represents the information about reconciliation operations that were unsuccessful or bypassed.
 */
model ReconcileStatus {
  /**
   * The number of reconciliation attempts that have failed.
   */
  failedReconcileAttempts?: int64;

  /**
   * The date and time of the last reconcile attempt.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastReconcileAttempt?: utcDateTime;

  /**
   * The number of reconciliation attempts that have been skipped.
   */
  skippedReconcileAttempts?: int64;
}

/**
 * ClusterManagerInternalMetadataRegistryCredentials represents details about the per ClusterManager ACR Credentials generated by the RP.
 */
model ClusterManagerInternalMetadataRegistryCredentials {
  /**
   * TokenPasswordName - The password name "password1" or "password2".
   */
  activeTokenPasswordName?: string;

  /**
   * ACR Password1
   */
  password1?: string;

  /**
   * ACR Password2
   */
  password2?: string;

  /**
   * Token ID
   */
  tokenId?: string;

  /**
   * Token Name
   */
  tokenName?: string;

  /**
   * ACR Username
   */
  username?: string;
}

/**
 * ClusterManagerInternalMetadataRelay represents details about the per ClusterManager Arc Relay.
 */
model ClusterManagerInternalMetadataRelay {
  /**
   * The resource ID of the "manage" Auth Rule.
   */
  authRuleManageId?: string;

  /**
   * The resource ID of the "sender" Auth Rule.
   */
  authRuleSenderId?: string;

  /**
   * The desired relay stamp name. This will be set when the update is required on the running cluster manager.
   */
  desiredStampName?: string;

  /**
   * The resource ID of the Relay Namespace created for this cluster manager.
   */
  namespaceId?: string;

  /**
   * custom IP Rules injected into the Relays NetworkRuleSet.
   */
  networkRuleSetsCustomIpRules?: ClusterManagerInternalMetadataRelayNetworkRuleSetsCustomIpRules[];

  /**
   * The Azure Service Bus FQDN for this Relay Namespace.
   */
  serviceBusEndpoint?: string;

  /**
   * The Relay Stamp Name in use. This will be set to "public" for usage of the default public stamp.
   */
  stampName?: string;
}

/**
 * ClusterManagerInternalMetadataRelayNetworkRuleSetsCustomIpRules custom IP Rules injected into this Cluster Managers Relay NetworkRuleSet.
 */
model ClusterManagerInternalMetadataRelayNetworkRuleSetsCustomIpRules {
  /**
   * The Network Rule Set Action. Currently this must be "Allow".
   */
  action: string;

  /**
   * The Network Rule Set IP Mask in CIDR format.
   */
  ipMask: string;
}

/**
 * ManagedResourceGroupConfiguration represents the configuration of the resource group managed by Azure.
 */
model ManagedResourceGroupConfiguration {
  /**
   * The location of the managed resource group. If not specified, the location of the parent resource is chosen.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * The name for the managed resource group. If not specified, the unique name is automatically generated.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(75)
  name?: string;
}

/**
 * ClusterManagerRelayConfiguration represents the relay configuration for the cluster manager.
 */
model ClusterManagerRelayConfiguration {
  /**
   * The resource ID of the Azure relay namespace managed by the cluster manager.
   */
  relayNamespaceId?: string;
}

/**
 * ClusterList represents a list of clusters.
 */
model ClusterList is Azure.Core.Page<Cluster>;

/**
 * ClusterProperties represents the properties of a cluster.
 */
model ClusterProperties {
  /**
   * The current state of any in progress or completed actions. The most recent known instance of each action type is shown.
   */
  @identifiers(#["actionType"])
  actionStates?: ActionState[];

  /**
   * The rack definition that is intended to reflect only a single rack in a single rack cluster, or an aggregator rack in a multi-rack cluster.
   */
  aggregatorOrSingleRackDefinition: RackDefinition;

  /**
   * The settings for the log analytics workspace used for output of logs from this cluster.
   */
  analyticsOutputSettings?: AnalyticsOutputSettings;

  /**
   * Field Deprecated. The resource ID of the Log Analytics Workspace that will be used for storing relevant logs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  analyticsWorkspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The list of cluster runtime version upgrades available for this cluster.
   */
  @identifiers(#["targetClusterVersion"])
  availableUpgradeVersions?: ClusterAvailableUpgradeVersion[];

  /**
   * The capacity supported by this cluster.
   */
  @visibility(Lifecycle.Read)
  clusterCapacity?: ClusterCapacity;

  /**
   * The latest heartbeat status between the cluster manager and the cluster.
   */
  clusterConnectionStatus?: ClusterConnectionStatus;

  /**
   * The extended location (custom location) that represents the cluster's control plane location. This extended location is used to route the requests of child objects of the cluster that are handled by the platform operator.
   */
  @visibility(Lifecycle.Read)
  clusterExtendedLocation?: ExtendedLocation;

  /**
   * The customer-provided location information to identify where the cluster resides.
   */
  @maxLength(256)
  clusterLocation?: string;

  /**
   * The latest connectivity status between cluster manager and the cluster.
   */
  clusterManagerConnectionStatus?: ClusterManagerConnectionStatus;

  /**
   * The resource ID of the cluster manager that manages this cluster. This is set by the Cluster Manager when the cluster is created.
   */
  clusterManagerId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/clusterManagers";
    }
  ]>;

  /**
   * Field Deprecated: Use managed identity to provide cluster privileges. The service principal to be used by the cluster during Arc Appliance installation.
   */
  clusterServicePrincipal?: ServicePrincipalInformation;

  /**
   * The type of rack configuration for the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clusterType: ClusterType;

  /**
   * The current runtime version of the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clusterVersion: string;

  /**
   * The settings for commands run in this cluster, such as bare metal machine run read only commands and data extracts.
   */
  commandOutputSettings?: CommandOutputSettings;

  /**
   * The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.
   */
  computeDeploymentThreshold?: ValidationThreshold;

  /**
   * The list of rack definitions for the compute racks in a multi-rack cluster, or an empty list in a single-rack cluster.
   */
  @identifiers(#["networkRackId"])
  computeRackDefinitions?: RackDefinition[];

  /**
   * The current detailed status of the cluster.
   */
  detailedStatus?: ClusterDetailedStatus;

  /**
   * The descriptive message about the detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. This field will not be populated in an upcoming version. The extended location (custom location) that represents the Hybrid AKS control plane location. This extended location is used when creating provisioned clusters (Hybrid AKS clusters).
   */
  @visibility(Lifecycle.Read)
  hybridAksExtendedLocation?: ExtendedLocation;

  /**
   * ClusterInternalMetadata is a separate struct to exclude from the public API.
   */
  internalMetadata?: ClusterInternalMetadata;

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The count of Manual Action Taken (MAT) events that have not been validated.
   */
  manualActionCount?: int64;

  /**
   * The resource ID of the Network Fabric associated with the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricId: Azure.Core.armResourceIdentifier;

  /**
   * The provisioning state of the cluster.
   */
  provisioningState?: ClusterProvisioningState;

  /**
   * The settings for cluster runtime protection.
   */
  runtimeProtectionConfiguration?: RuntimeProtectionConfiguration;

  /**
   * The configuration for use of a key vault to store secrets for later retrieval by the operator.
   */
  secretArchive?: ClusterSecretArchive;

  /**
   * The settings for the secret archive used to hold credentials for the cluster.
   */
  secretArchiveSettings?: SecretArchiveSettings;

  /**
   * The support end date of the runtime version of the cluster.
   */
  supportExpiryDate?: string;

  /**
   * The strategy for updating the cluster.
   */
  updateStrategy?: ClusterUpdateStrategy;

  /**
   * The settings for how security vulnerability scanning is applied to the cluster.
   */
  vulnerabilityScanningSettings?: VulnerabilityScanningSettings;

  /**
   * The list of workload resource IDs that are hosted within this cluster.
   */
  workloadResourceIds?: string[];
}

/**
 * RackDefinition represents details regarding the rack.
 */
model RackDefinition {
  /**
   * The zone name used for this rack when created. Availability zones are used for workload placement.
   */
  @pattern("^[a-zA-Z0-9]{1,10}$")
  availabilityZone?: string;

  /**
   * The unordered list of bare metal machine configuration.
   */
  @identifiers(#[])
  bareMetalMachineConfigurationData?: BareMetalMachineConfigurationData[];

  /**
   * The resource ID of the network rack that matches this rack definition.
   */
  networkRackId: Azure.Core.armResourceIdentifier;

  /**
   * The free-form description of the rack's location.
   */
  @maxLength(256)
  rackLocation?: string;

  /**
   * The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.
   */
  @maxLength(64)
  @minLength(1)
  rackSerialNumber: string;

  /**
   * The resource ID of the sku for the rack being added.
   */
  rackSkuId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/rackSkus";
    }
  ]>;

  /**
   * The list of storage appliance configuration data for this rack.
   */
  @identifiers(#[])
  storageApplianceConfigurationData?: StorageApplianceConfigurationData[];
}

/**
 * BareMetalMachineConfigurationData represents configuration for the bare metal machine.
 */
model BareMetalMachineConfigurationData {
  /**
   * The connection string for the baseboard management controller including IP address and protocol.
   */
  bmcConnectionString?: string;

  /**
   * The credentials of the baseboard management controller on this bare metal machine. The password field is expected to be an Azure Key Vault key URL. Until the cluster is converted to utilize managed identity by setting the secret archive settings, the actual password value should be provided instead.
   */
  bmcCredentials: AdministrativeCredentials;

  /**
   * The MAC address of the BMC for this machine.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bmcMacAddress: string;

  /**
   * The MAC address associated with the PXE NIC card.
   */
  @pattern("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$")
  bootMacAddress: string;

  /**
   * The free-form additional information about the machine, e.g. an asset tag.
   */
  @maxLength(256)
  machineDetails?: string;

  /**
   * The user-provided name for the bare metal machine created from this specification. If not provided, the machine name will be generated programmatically.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  machineName?: string;

  /**
   * The slot the physical machine is in the rack based on the BOM configuration.
   */
  @maxValue(256)
  @minValue(1)
  rackSlot: int64;

  /**
   * The serial number of the machine. Hardware suppliers may use an alternate value. For example, service tag.
   */
  @maxLength(64)
  serialNumber: string;
}

/**
 * StorageApplianceConfigurationData represents configuration for the storage application.
 */
model StorageApplianceConfigurationData {
  /**
   * The credentials of the administrative interface on this storage appliance. The password field is expected to be an Azure Key Vault key URL. Until the cluster is converted to utilize managed identity by setting the secret archive settings, the actual password value should be provided instead.
   */
  adminCredentials: AdministrativeCredentials;

  /**
   * The slot that storage appliance is in the rack based on the BOM configuration.
   */
  @maxValue(256)
  @minValue(1)
  rackSlot: int64;

  /**
   * The serial number of the appliance.
   */
  serialNumber: string;

  /**
   * The user-provided name for the storage appliance that will be created from this specification.
   */
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  storageApplianceName?: string;
}

/**
 * AnalyticsOutputSettings represents the settings for the log analytics workspace used for output of logs from this cluster.
 */
model AnalyticsOutputSettings {
  /**
   * The resource ID of the analytics workspace that is to be used by the specified identity.
   */
  analyticsWorkspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The selection of the managed identity to use with this analytics workspace. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;
}

/**
 * IdentitySelector represents the selection of a managed identity for use.
 */
model IdentitySelector {
  /**
   * The type of managed identity that is being selected.
   */
  identityType?: ManagedServiceIdentitySelectorType;

  /**
   * The user assigned managed identity resource ID to use. Mutually exclusive with a system assigned identity type.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * ClusterAvailableUpgradeVersion represents the various cluster upgrade parameters.
 */
model ClusterAvailableUpgradeVersion {
  /**
   * The indicator of whether the control plane will be impacted during the upgrade.
   */
  controlImpact?: ControlImpact;

  /**
   * The expected duration needed for this upgrade.
   */
  expectedDuration?: string;

  /**
   * The impact description including the specific details and release notes.
   */
  impactDescription?: string;

  /**
   * The last date the version of the platform is supported.
   */
  supportExpiryDate?: string;

  /**
   * The target version this cluster will be upgraded to.
   */
  targetClusterVersion?: string;

  /**
   * The indicator of whether the workload will be impacted during the upgrade.
   */
  workloadImpact?: WorkloadImpact;
}

/**
 * ClusterCapacity represents various details regarding compute capacity.
 */
model ClusterCapacity {
  /**
   * The remaining appliance-based storage in GB available for workload use. Measured in gibibytes.
   */
  availableApplianceStorageGB?: int64;

  /**
   * The remaining number of cores that are available in this cluster for workload use.
   */
  availableCoreCount?: int64;

  /**
   * The remaining machine or host-based storage in GB available for workload use. Measured in gibibytes.
   */
  availableHostStorageGB?: int64;

  /**
   * The remaining memory in GB that are available in this cluster for workload use. Measured in gibibytes.
   */
  availableMemoryGB?: int64;

  /**
   * The total appliance-based storage in GB supported by this cluster for workload use. Measured in gibibytes.
   */
  totalApplianceStorageGB?: int64;

  /**
   * The total number of cores that are supported by this cluster for workload use.
   */
  totalCoreCount?: int64;

  /**
   * The total machine or host-based storage in GB supported by this cluster for workload use. Measured in gibibytes.
   */
  totalHostStorageGB?: int64;

  /**
   * The total memory supported by this cluster for workload use. Measured in gibibytes.
   */
  totalMemoryGB?: int64;
}

/**
 * ServicePrincipalInformation represents the details of the service principal to be used by the cluster during Arc Appliance installation.
 */
model ServicePrincipalInformation {
  /**
   * The application ID, also known as client ID, of the service principal.
   */
  applicationId: string;

  /**
   * The password of the service principal.
   */
  password: string;

  /**
   * PasswordReference contains the reference to the source of a password.
   */
  passwordRef?: PasswordReference;

  /**
   * The principal ID, also known as the object ID, of the service principal.
   */
  principalId: string;

  /**
   * The tenant ID, also known as the directory ID, of the tenant in which the service principal is created.
   */
  tenantId: string;
}

/**
 * CommandOutputSettings represents the settings for commands run within the cluster such as bare metal machine run read-only commands.
 */
model CommandOutputSettings {
  /**
   * The selection of the managed identity to use with this storage account container. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;

  /**
   * The URL of the storage account container that is to be used by the specified identities.
   */
  containerUrl?: url;

  /**
   * The list of optional overrides allowing for association of storage containers and identities to specific types of command output. If a type is not overridden, the default identity and storage container will be utilized.
   */
  @identifiers(#["commandOutputType"])
  overrides?: CommandOutputOverride[];
}

/**
 * CommandOutputOverride represents an overridden value for the command output settings.
 */
model CommandOutputOverride {
  /**
   * The selection of the managed identity to use with this storage account container. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;

  /**
   * The type of command output for the override.
   */
  commandOutputType?: CommandOutputType;

  /**
   * The URL of the storage account container that is to be used by the specified identities.
   */
  containerUrl?: url;
}

/**
 * ValidationThreshold indicates allowed machine and node hardware and deployment failures.
 */
model ValidationThreshold {
  /**
   * Selection of how the type evaluation is applied to the cluster calculation.
   */
  grouping: ValidationThresholdGrouping;

  /**
   * Selection of how the threshold should be evaluated.
   */
  type: ValidationThresholdType;

  /**
   * The numeric threshold value.
   */
  value: int64;
}

/**
 * ClusterInternalMetadata is a separate struct to exclude from the public API.
 */
model ClusterInternalMetadata {
  /**
   * Depicts the version of the set of the cluster extension(s) that are upgraded when a new version of the cluster manager indicates a new version being available. The cluster manager will walk the clusters it controls and perform the upgrades needed to bring this to current. The management version implies a set of versions of the cluster extensions used by the cluster.
   */
  afoManagementVersion?: string;

  /**
   * The timestamp of the last time the cluster connection status changed.
   */
  clusterConnectionStatusLastChanged?: string;

  /**
   * The timestamp of the last heartbeat to the cluster manager.
   */
  clusterToClusterManagerLastHeartBeat?: string;

  /**
   * The resource ID of the connected cluster that references this cluster, after the cluster is deployed.
   */
  connectedClusterId?: string;

  /**
   * The history of the management bundle upgrades that have been attempted for this cluster.
   */
  managementBundleUpdateHistory?: ManagementBundleUpdateHistory[];

  /**
   * The MSI of the cluster that is captured at the time of deploying the platform operator.
   */
  msiVerifiedAuthIdentity?: string;

  /**
   * ExtendedLocation represents the Azure custom location where the resource will be created.
   */
  networkFabricExtendedLocation?: ExtendedLocation;

  /**
   * A reference to a storage account created with the cluster manager. This is used to store the output from invocation of Extract System Information against BareMetalMachines.
   */
  storageAccountId?: string;
}

/**
 * ManagementBundleUpdateHistory represents the details of the cluster management bundle upgrade.
 */
model ManagementBundleUpdateHistory {
  /**
   * The upgrade attempt number that increments each time an update is attempted for the same target management version.
   */
  @minValue(1)
  attempt?: int64;

  /**
   * The time when the update attempt ended.
   */
  endTime?: string;

  /**
   * The list of messages associated with the result.
   */
  messages?: string[];

  /**
   * ManagementBundleUpdateHistoryResultStatus indicates the result status of the cluster management bundle update.
   */
  resultStatus?: string;

  /**
   * The time when the update attempt started.
   */
  startTime?: string;

  /**
   * The detailed status of the cluster at the time this attempt to update was started.
   */
  startingDetailedStatus?: string;

  /**
   * The management bundle version that the cluster has at the beginning of the attempt.
   */
  startingManagementBundleVersion?: string;

  /**
   * The provisioning state of the cluster at the time this attempt to update was started.
   */
  startingProvisioningState?: string;

  /**
   * The management bundle version that the cluster is being updated to.
   */
  targetManagementBundleVersion?: string;
}

/**
 * RuntimeProtectionConfiguration represents the runtime protection configuration for the cluster.
 */
model RuntimeProtectionConfiguration {
  /**
   * The definition update mode for runtime protection.
   */
  definitionUpdateMode?: RuntimeProtectionDefinitionUpdateMode;

  /**
   * The mode of operation for runtime protection.
   */
  enforcementLevel?: RuntimeProtectionEnforcementLevel;
}

/**
 * ClusterSecretArchive configures the key vault to archive the secrets of the cluster for later retrieval.
 */
model ClusterSecretArchive {
  /**
   * The resource ID of the key vault to archive the secrets of the cluster.
   */
  keyVaultId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * The indicator if the specified key vault should be used to archive the secrets of the cluster.
   */
  useKeyVault?: ClusterSecretArchiveEnabled = ClusterSecretArchiveEnabled.False;
}

/**
 * SecretArchiveSettings represents the settings for the secret archive used to hold credentials for the cluster.
 */
model SecretArchiveSettings {
  /**
   * The selection of the managed identity to use with this vault URI. The identity type must be either system assigned or user assigned.
   */
  associatedIdentity?: IdentitySelector;

  /**
   * The URI for the key vault used as the secret archive.
   */
  vaultUri?: url;
}

/**
 * ClusterUpdateStrategy represents the strategy for updating the cluster.
 */
model ClusterUpdateStrategy {
  /**
   * The maximum number of worker nodes that can be offline within the increment of update, e.g., rack-by-rack. Limited by the maximum number of machines in the increment. Defaults to the whole increment size.
   */
  @minValue(1)
  maxUnavailable?: int64;

  /**
   * The mode of operation for runtime protection.
   */
  strategyType: ClusterUpdateStrategyType;

  /**
   * Selection of how the threshold should be evaluated.
   */
  thresholdType: ValidationThresholdType;

  /**
   * The numeric threshold value.
   */
  thresholdValue: int64;

  /**
   * The time to wait between the increments of update defined by the strategy.
   */
  @maxValue(60)
  waitTimeMinutes?: int64 = 15;
}

/**
 * VulnerabilityScanningSettings represents the settings for how security vulnerability scanning is applied to the cluster.
 */
model VulnerabilityScanningSettings {
  /**
   * The mode selection for container vulnerability scanning.
   */
  containerScan?: VulnerabilityScanningSettingsContainerScan;
}

/**
 * KubernetesClusterList represents a list of Kubernetes clusters.
 */
model KubernetesClusterList is Azure.Core.Page<KubernetesCluster>;

/**
 * KubernetesClusterProperties represents the properties of Kubernetes cluster resource.
 */
model KubernetesClusterProperties {
  /**
   * The Azure Active Directory Integration properties.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  aadConfiguration?: AadConfiguration;

  /**
   * The administrative credentials that will be applied to the control plane and agent pool nodes that do not specify their own values.
   */
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The full list of network resource IDs that are attached to this cluster, including those attached only to specific agent pools.
   */
  attachedNetworkIds?: string[];

  /**
   * The list of versions that this Kubernetes cluster can be upgraded to.
   */
  @identifiers(#[])
  availableUpgrades?: AvailableUpgrade[];

  /**
   * The resource ID of the Network Cloud cluster.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the connected cluster set up when this Kubernetes cluster is created.
   */
  connectedClusterId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters";
    }
  ]>;

  /**
   * The current running version of Kubernetes on the control plane.
   */
  controlPlaneKubernetesVersion?: string;

  /**
   * The defining characteristics of the control plane for this Kubernetes Cluster.
   */
  controlPlaneNodeConfiguration: ControlPlaneNodeConfiguration;

  /**
   * The current status of the Kubernetes cluster.
   */
  detailedStatus?: KubernetesClusterDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The current feature settings.
   */
  @identifiers(#["name"])
  featureStatuses?: FeatureStatus[];

  /**
   * The agent pools that are created with this Kubernetes cluster for running critical system services and workloads. This data in this field is only used during creation, and the field will be empty following the creation of the Kubernetes Cluster. After creation, the management of agent pools is done using the agentPools sub-resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#["name"])
  initialAgentPoolConfigurations: InitialAgentPoolConfiguration[];

  /**
   * KubernetesClusterInternalMetadata represents the internal metadata of the Kubernetes cluster.
   */
  internalMetadata?: KubernetesClusterInternalMetadata;

  /**
   * The Kubernetes version for this cluster.
   */
  kubernetesVersion: string;

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The configuration of the Kubernetes cluster networking, including the attachment of networks that span the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkConfiguration: NetworkConfiguration;

  /**
   * The details of the nodes in this cluster.
   */
  @identifiers(#["name"])
  nodes?: KubernetesClusterNode[];

  /**
   * The provisioning state of the Kubernetes cluster resource.
   */
  provisioningState?: KubernetesClusterProvisioningState;
}

/**
 * AadConfiguration represents the Azure Active Directory Integration properties.
 */
model AadConfiguration {
  /**
   * The list of Azure Active Directory group object IDs that will have an administrative role on the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  adminGroupObjectIds: string[];
}

/**
 * AdministratorConfiguration represents the administrative credentials that will be applied to the control plane and agent pool nodes in Kubernetes clusters.
 */
model AdministratorConfiguration {
  /**
   * The user name for the administrator that will be applied to the operating systems that run Kubernetes nodes. If not supplied, a user name will be chosen by the service.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  adminUsername?: string;

  /**
   * The SSH configuration for the operating systems that run the nodes in the Kubernetes cluster. In some cases, specification of public keys may be required to produce a working environment.
   */
  sshPublicKeys?: SshPublicKey[];
}

/**
 * SshPublicKey represents the public key used to authenticate with a resource through SSH.
 */
model SshPublicKey {
  /**
   * The SSH public key data.
   */
  @minLength(1)
  keyData: string;
}

/**
 * AvailableUpgrade represents an upgrade available for a Kubernetes cluster.
 */
model AvailableUpgrade {
  /**
   * The version lifecycle indicator.
   */
  availabilityLifecycle?: AvailabilityLifecycle;

  /**
   * The version available for upgrading.
   */
  version?: string;
}

/**
 * ControlPlaneNodeConfiguration represents the selection of virtual machines and size of the control plane for a Kubernetes cluster.
 */
model ControlPlaneNodeConfiguration {
  /**
   * The administrator credentials to be used for the nodes in the control plane.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The list of availability zones of the Network Cloud cluster to be used for the provisioning of nodes in the control plane. If not specified, all availability zones will be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZones?: string[];

  /**
   * The number of virtual machines that use this configuration.
   */
  @minValue(1)
  count: int64;

  /**
   * The name of the VM SKU supplied during creation.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSkuName: string;
}

/**
 * FeatureStatus contains information regarding a Kubernetes cluster feature.
 */
model FeatureStatus {
  /**
   * The status representing the state of this feature.
   */
  detailedStatus?: FeatureDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The name of the feature.
   */
  name?: string;

  /**
   * The version of the feature.
   */
  version?: string;
}

/**
 * InitialAgentPoolConfiguration specifies the configuration of a pool of virtual machines that are initially defined with a Kubernetes cluster.
 */
model InitialAgentPoolConfiguration {
  /**
   * The administrator credentials to be used for the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The configurations that will be applied to each agent in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  agentOptions?: AgentOptions;

  /**
   * The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  /**
   * The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZones?: string[];

  /**
   * The number of virtual machines that use this configuration.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  count: int64;

  /**
   * The labels applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  labels?: KubernetesLabel[];

  /**
   * The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: AgentPoolMode;

  /**
   * The name that will be used for the agent pool resource representing this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9-_]{0,28}[a-zA-Z0-9])$")
  name: string;

  /**
   * The taints applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  taints?: KubernetesLabel[];

  /**
   * The configuration of the agent pool.
   */
  upgradeSettings?: AgentPoolUpgradeSettings;

  /**
   * The name of the VM SKU that determines the size of resources allocated for node VMs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSkuName: string;
}

/**
 * AgentOptions are configurations that will be applied to each agent in an agent pool.
 */
model AgentOptions {
  /**
   * The number of hugepages to allocate.
   */
  hugepagesCount: int64;

  /**
   * The size of the hugepages to allocate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hugepagesSize?: HugepagesSize = HugepagesSize.`2M`;
}

/**
 * AttachedNetworkConfiguration represents the set of workload networks to attach to a resource.
 */
model AttachedNetworkConfiguration {
  /**
   * The list of Layer 2 Networks and related configuration for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l2Networks?: L2NetworkAttachmentConfiguration[];

  /**
   * The list of Layer 3 Networks and related configuration for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l3Networks?: L3NetworkAttachmentConfiguration[];

  /**
   * The list of Trunked Networks and related configuration for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  trunkedNetworks?: TrunkedNetworkAttachmentConfiguration[];
}

/**
 * L2NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 2 network.
 */
model L2NetworkAttachmentConfiguration {
  /**
   * The resource ID of the network that is being configured for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/l2Networks";
    }
  ]>;

  /**
   * The indicator of how this network will be utilized by the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pluginType?: KubernetesPluginType;
}

/**
 * L3NetworkAttachmentConfiguration represents the configuration of the attachment of a Layer 3 network.
 */
model L3NetworkAttachmentConfiguration {
  /**
   * The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipamEnabled?: L3NetworkConfigurationIpamEnabled = L3NetworkConfigurationIpamEnabled.False;

  /**
   * The resource ID of the network that is being configured for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/l3Networks";
    }
  ]>;

  /**
   * The indicator of how this network will be utilized by the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pluginType?: KubernetesPluginType;
}

/**
 * TrunkedNetworkAttachmentConfiguration represents the configuration of the attachment of a trunked network.
 */
model TrunkedNetworkAttachmentConfiguration {
  /**
   * The resource ID of the network that is being configured for attachment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/trunkedNetworks";
    }
  ]>;

  /**
   * The indicator of how this network will be utilized by the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  pluginType?: KubernetesPluginType;
}

/**
 * KubernetesLabel represents a single entry for a Kubernetes label or taint such as those used on a node or pod.
 */
model KubernetesLabel {
  /**
   * The name of the label or taint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  key: string;

  /**
   * The value of the label or taint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  value: string;
}

/**
 * AgentPoolUpgradeSettings specifies the upgrade settings for an agent pool.
 */
model AgentPoolUpgradeSettings {
  /**
   * The maximum time in seconds that is allowed for a node drain to complete before proceeding with the upgrade of the agent pool. If not specified during creation, a value of 1800 seconds is used.
   */
  @maxValue(86400)
  @minValue(60)
  drainTimeout?: int64;

  /**
   * The maximum number or percentage of nodes that are surged during upgrade. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified during creation, a value of 1 is used. One of MaxSurge and MaxUnavailable must be greater than 0.
   */
  maxSurge?: string;

  /**
   * The maximum number or percentage of nodes that can be unavailable during upgrade. This can either be set to an integer (e.g. '5') or a percentage (e.g. '50%'). If a percentage is specified, it is the percentage of the total agent pool size at the time of the upgrade. For percentages, fractional nodes are rounded up. If not specified during creation, a value of 0 is used. One of MaxSurge and MaxUnavailable must be greater than 0.
   */
  maxUnavailable?: string;
}

/**
 * KubernetesClusterInternalMetadata represents the internal metadata of the Kubernetes cluster.
 */
model KubernetesClusterInternalMetadata {
  /**
   * AddOn Conditions. This field was renamed to FeatureConditions. Field remains here for compatibility.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  addonConditions?: Record<KubernetesCondition[]>;

  /**
   * The list of Arc enrolled servers
   */
  arcServers?: ArcServer[];

  /**
   * The cluster administrator credentials.
   */
  clusterCredentials?: KubeconfigInfo[];

  /**
   * A copy of the current kubernetes conditions on this cluster.
   */
  conditions?: KubernetesCondition[];

  /**
   * The name of the controlplane proxy deployment this cluster is leveraging so we can correlate proxy logs.
   */
  controlPlaneProxyDeploymentName?: string;

  /**
   * A debug storage key value map that may contain low level diagnostic information and results.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  debug?: Record<string>;

  /**
   * The extension version used to originally deploy this cluster.
   */
  extensionVersionOnCreation?: string;

  /**
   * The extension version used to last update this cluster during Cluster Management Bundle Update.
   */
  extensionVersionOnUpgrade?: string;

  /**
   * Feature Conditions. This field was renamed from AddOnConditions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  featureConditions?: Record<KubernetesCondition[]>;

  /**
   * The kubernetes resource name of the kubernetes cluster which may be different than the arm resource name.
   */
  kubernetesResourceName?: string;
}

/**
 * KubernetesCondition represents a single condition of a Kubernetes cluster.
 */
model KubernetesCondition {
  /**
   * The last time the condition transitioned from one status to another.
   */
  lastTransitionTime?: string;

  /**
   * A human readable message indicating details about the transition.
   */
  message?: string;

  /**
   * The reason for the condition's last transition.
   */
  reason?: string;

  /**
   * The severity of the condition.
   */
  severity?: string;

  /**
   * The status of the condition.
   */
  status?: string;

  /**
   * The type name of the condition.
   */
  type?: string;
}

/**
 * ArcServer represents details of an Arc enrolled server.
 */
model ArcServer {
  /**
   * The node name is the name of the node
   */
  nodeName?: string;

  /**
   * The relay move state indicates if the node has been moved to the private relay, or is currently being moved.
   */
  relayMoveState?: string;

  /**
   * The resource ID refers to the ARM ID of the HybridCompute
   */
  resourceId?: string;

  /**
   * The VM UID is a generated unique ID created for the node VM which is used for arc enrolling the HybridCompute during the azcmagent connect existing process. This is used to correlate the HybridCompute with the NAKS node VM.
   */
  vmUid?: string;
}

/**
 * Design Note: This is implemented as a struct to allow for later move to use an external reference for the kubeconfig data.
 */
model KubeconfigInfo {
  /**
   * The name of the credential.
   */
  name?: string;

  /**
   * The Base64 encoded Kubernetes configuration file.
   */
  value?: string;
}

/**
 * NetworkConfiguration specifies the Kubernetes cluster network related configuration.
 */
model NetworkConfiguration {
  /**
   * The configuration of networks being attached to the cluster for use by the workloads that run on this Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  /**
   * The configuration of the BGP service load balancer for this Kubernetes cluster. A maximum of one service load balancer may be specified, either Layer 2 or BGP.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bgpServiceLoadBalancerConfiguration?: BgpServiceLoadBalancerConfiguration;

  /**
   * The resource ID of the associated Cloud Services network.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cloudServicesNetworkId: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the Layer 3 network that is used for creation of the Container Networking Interface network.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cniNetworkId: Azure.Core.armResourceIdentifier;

  /**
   * The IP address assigned to the Kubernetes DNS service. It must be within the Kubernetes service address range specified in service CIDR.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dnsServiceIp?: string;

  /**
   * The configuration of the Layer 2 service load balancer for this Kubernetes cluster. A maximum of one service load balancer may be specified, either Layer 2 or BGP.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l2ServiceLoadBalancerConfiguration?: L2ServiceLoadBalancerConfiguration;

  /**
   * The CIDR notation IP ranges from which to assign pod IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  podCidrs?: string[];

  /**
   * The CIDR notation IP ranges from which to assign service IPs. One IPv4 CIDR is expected for single-stack networking. Two CIDRs, one for each IP family (IPv4/IPv6), is expected for dual-stack networking.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceCidrs?: string[];
}

/**
 * BgpServiceLoadBalancerConfiguration represents the configuration of a BGP service load balancer.
 */
model BgpServiceLoadBalancerConfiguration {
  /**
   * The association of IP address pools to the communities and peers, allowing for announcement of IPs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  bgpAdvertisements?: BgpAdvertisement[];

  /**
   * The list of additional BgpPeer entities that the Kubernetes cluster will peer with. All peering must be explicitly defined.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  bgpPeers?: ServiceLoadBalancerBgpPeer[];

  /**
   * The indicator to specify if the load balancer peers with the network fabric.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricPeeringEnabled?: FabricPeeringEnabled = FabricPeeringEnabled.True;

  /**
   * The list of pools of IP addresses that can be allocated to load balancer services.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  ipAddressPools?: IpAddressPool[];
}

/**
 * BgpAdvertisement represents the association of IP address pools to the communities and peers.
 */
model BgpAdvertisement {
  /**
   * The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  advertiseToFabric?: AdvertiseToFabric = AdvertiseToFabric.True;

  /**
   * The names of the BGP communities to be associated with the announcement, utilizing a BGP community string in 1234:1234 format.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  communities?: string[];

  /**
   * The names of the IP address pools associated with this announcement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipAddressPools: string[];

  /**
   * The names of the BGP peers to limit this advertisement to. If no values are specified, all BGP peers will receive this advertisement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peers?: string[];
}

/**
 * ServiceLoadBalancerBgpPeer represents the configuration of the BGP service load balancer for the Kubernetes cluster.
 */
model ServiceLoadBalancerBgpPeer {
  /**
   * The indicator of BFD enablement for this BgpPeer.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bfdEnabled?: BfdEnabled;

  /**
   * The indicator to enable multi-hop peering support.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bgpMultiHop?: BgpMultiHop = BgpMultiHop.False;

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The requested BGP hold time value. This field uses ISO 8601 duration format, for example P1H.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  holdTime?: string;

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The requested BGP keepalive time value. This field uses ISO 8601 duration format, for example P1H.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keepAliveTime?: string;

  /**
   * The autonomous system number used for the local end of the BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxValue(4294967295)
  myAsn?: int64;

  /**
   * The name used to identify this BGP peer for association with a BGP advertisement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
  name: string;

  /**
   * The authentication password for routers enforcing TCP MD5 authenticated sessions.
   */
  @visibility(Lifecycle.Create)
  @maxLength(80)
  @pattern("^[a-zA-Z0-9]{0,80}$")
  password?: string;

  /**
   * PasswordReference contains the reference to the source of a password.
   */
  passwordRef?: PasswordReference;

  /**
   * The IPv4 or IPv6 address used to connect this BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peerAddress: string;

  /**
   * The autonomous system number expected from the remote end of the BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxValue(4294967295)
  peerAsn: int64;

  /**
   * The port used to connect this BGP session.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  peerPort?: int64 = 179;
}

/**
 * IpAddressPool represents a pool of IP addresses that can be allocated to a service.
 */
model IpAddressPool {
  /**
   * The list of IP address ranges. Each range can be a either a subnet in CIDR format or an explicit start-end range of IP addresses. For a BGP service load balancer configuration, only CIDR format is supported and excludes /32 (IPv4) and /128 (IPv6) prefixes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  addresses: string[];

  /**
   * The indicator to determine if automatic allocation from the pool should occur.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  autoAssign?: BfdEnabled;

  /**
   * The name used to identify this IP address pool for association with a BGP advertisement.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^[a-z0-9]([a-z0-9.-]{0,61}[a-z0-9]){0,1}$")
  name: string;

  /**
   * The indicator to prevent the use of IP addresses ending with .0 and .255 for this pool. Enabling this option will only use IP addresses between .1 and .254 inclusive.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  onlyUseHostIps?: BfdEnabled;
}

/**
 * L2ServiceLoadBalancerConfiguration represents the configuration of a layer 2 service load balancer.
 */
model L2ServiceLoadBalancerConfiguration {
  /**
   * The list of pools of IP addresses that can be allocated to load balancer services.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  ipAddressPools?: IpAddressPool[];
}

/**
 * KubernetesClusterNode represents the details of a node in a Kubernetes cluster.
 */
model KubernetesClusterNode {
  /**
   * The resource ID of the agent pool that this node belongs to. This value is not represented on control plane nodes.
   */
  agentPoolId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/kubernetesClusters/agentPools";
    }
  ]>;

  /**
   * The availability zone this node is running within.
   */
  availabilityZone?: string;

  /**
   * The resource ID of the bare metal machine that hosts this node.
   */
  bareMetalMachineId?: Azure.Core.armResourceIdentifier;

  /**
   * The number of CPU cores configured for this node, derived from the VM SKU specified.
   */
  cpuCores?: int64;

  /**
   * The detailed state of this node.
   */
  detailedStatus?: KubernetesClusterNodeDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The size of the disk configured for this node. Allocations are measured in gibibytes.
   */
  diskSizeGB?: int64;

  /**
   * The machine image used to deploy this node.
   */
  image?: string;

  /**
   * The currently running version of Kubernetes and bundled features running on this node.
   */
  kubernetesVersion?: string;

  /**
   * The list of labels on this node that have been assigned to the agent pool containing this node.
   */
  @identifiers(#["key"])
  labels?: KubernetesLabel[];

  /**
   * The amount of memory configured for this node, derived from the vm SKU specified. Allocations are measured in gibibytes.
   */
  memorySizeGB?: int64;

  /**
   * The mode of the agent pool containing this node. Not applicable for control plane nodes.
   */
  mode?: AgentPoolMode;

  /**
   * The name of this node, as realized in the Kubernetes cluster.
   */
  name?: string;

  /**
   * The NetworkAttachments made to this node.
   */
  @identifiers(#["networkAttachmentName"])
  networkAttachments?: NetworkAttachment[];

  /**
   * The power state of this node.
   */
  powerState?: KubernetesNodePowerState;

  /**
   * The role of this node in the cluster.
   */
  role?: KubernetesNodeRole;

  /**
   * The list of taints that have been assigned to the agent pool containing this node.
   */
  @identifiers(#["key"])
  taints?: KubernetesLabel[];

  /**
   * The VM SKU name that was used to create this cluster node.
   */
  vmSkuName?: string;
}

/**
 * NetworkAttachment represents the single network attachment.
 */
model NetworkAttachment {
  /**
   * The resource ID of the associated network attached to the virtual machine. It can be one of cloudServicesNetwork, l3Network, l2Network or trunkedNetwork resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkId: Azure.Core.armResourceIdentifier;

  /**
   * The indicator of whether this is the default gateway. Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
   */
  defaultGateway?: DefaultGateway;

  /**
   * The IP allocation mechanism for the virtual machine. Dynamic and Static are only valid for l3Network which may also specify Disabled. Otherwise, Disabled is the only permitted value.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipAllocationMethod: VirtualMachineIPAllocationMethod;

  /**
   * The IPv4 address of the virtual machine.  This field is used only if the attached network has IPAllocationType of IPV4 or DualStack.  If IPAllocationMethod is: Static - this field must contain a user specified IPv4 address from within the subnet specified in the attached network. Dynamic - this field is read-only, but will be populated with an address from within the subnet specified in the attached network. Disabled - this field will be empty.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4Address?: string;

  /**
   * The IPv6 address of the virtual machine.  This field is used only if the attached network has IPAllocationType of IPV6 or DualStack.  If IPAllocationMethod is: Static - this field must contain an IPv6 address range from within the range specified in the attached network. Dynamic - this field is read-only, but will be populated with an range from within the subnet specified in the attached network. Disabled - this field will be empty.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv6Address?: string;

  /**
   * The MAC address of the interface for the virtual machine that corresponds to this network attachment.
   */
  macAddress?: string;

  /**
   * The associated network's interface name. If specified, the network attachment name has a maximum length of 15 characters and must be unique to this virtual machine. If the user doesn’t specify this value, the default interface name of the network resource will be used. For a CloudServicesNetwork resource, this name will be ignored.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(15)
  networkAttachmentName?: string;
}

/**
 * KubernetesVersionList represents a list of Kubernetes version resources.
 */
model KubernetesVersionList is Azure.Core.Page<KubernetesVersion>;

/**
 * KubernetesVersionProperties contains the read-only properties describing available versions.
 */
model KubernetesVersionProperties {
  /**
   * The provisioning state of the Kubernetes version resource.
   */
  provisioningState?: KubernetesVersionProvisioningState;

  /**
   * The list of available Kubernetes versions.
   */
  values?: KubernetesVersionValue[];
}

/**
 * KubernetesVersionValue describes a specific Kubernetes version that can be deployed.
 */
model KubernetesVersionValue {
  /**
   * Additional description for the Kubernetes version.
   */
  description?: string;

  /**
   * The Kubernetes version identifier.
   */
  version?: string;
}

/**
 * L2NetworkList represents a list of L2 networks.
 */
model L2NetworkList is Azure.Core.Page<L2Network>;

/**
 * L2NetworkProperties represents properties of the L2 network.
 */
model L2NetworkProperties {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this L2 network is associated with.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the L2 network.
   */
  detailedStatus?: L2NetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource ID(s) that are associated with this L2 network.
   */
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType;

  /**
   * The default interface name for this L2 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  /**
   * The resource ID of the Network Fabric l2IsolationDomain.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l2IsolationDomainId: Azure.Core.armResourceIdentifier;

  /**
   * The provisioning state of the L2 network.
   */
  provisioningState?: L2NetworkProvisioningState;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource ID(s), excluding any Hybrid AKS virtual machines, that are currently using this L2 network.
   */
  virtualMachinesAssociatedIds?: string[];
}

/**
 * L3NetworkList represents a list of L3 networks.
 */
model L3NetworkList is Azure.Core.Page<L3Network>;

/**
 * L3NetworkProperties represents properties of the L3 network.
 */
model L3NetworkProperties {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this L3 network is associated with.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the L3 network.
   */
  detailedStatus?: L3NetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this L3 network.
   */
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksIpamEnabled?: HybridAksIpamEnabled = HybridAksIpamEnabled.True;

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType;

  /**
   * The default interface name for this L3 network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  /**
   * The type of the IP address allocation, defaulted to "DualStack".
   */
  ipAllocationType?: IpAllocationType = IpAllocationType.DualStack;

  /**
   * The IPV4 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type is IPV4 or DualStack.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4ConnectedPrefix?: string;

  /**
   * The IPV6 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type is IPV6 or DualStack.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv6ConnectedPrefix?: string;

  /**
   * The resource ID of the Network Fabric l3IsolationDomain.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l3IsolationDomainId: Azure.Core.armResourceIdentifier;

  /**
   * The provisioning state of the L3 network.
   */
  provisioningState?: L3NetworkProvisioningState;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this L3 network.
   */
  virtualMachinesAssociatedIds?: string[];

  /**
   * The VLAN from the l3IsolationDomain that is used for this network.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vlan: int64;
}

/**
 * RackSkuList represents a list of rack SKUs.
 */
model RackSkuList is Azure.Core.Page<RackSku>;

/**
 * RackSkuProperties represents the properties of compute-related hardware for a rack. This supports both aggregator and compute racks.
 */
model RackSkuProperties {
  /**
   * The list of machine SKUs and associated rack slot for the compute-dedicated machines in this rack model.
   */
  @identifiers(#[])
  computeMachines?: MachineSkuSlot[];

  /**
   * The list of machine SKUs and associated rack slot for the control-plane dedicated machines in this rack model.
   */
  @identifiers(#[])
  controllerMachines?: MachineSkuSlot[];

  /**
   * The deployment type supported by the rack SKU.
   */
  deploymentType?: DeploymentType;

  /**
   * The free-form text describing the rack.
   */
  description?: string;

  /**
   * The maximum number of compute racks supported by an aggregator rack. 0 if this is a compute rack or a rack for a single rack cluster(rackType="Single").
   */
  maxClusterSlots?: int64;

  /**
   * The provisioning state of the rack SKU resource.
   */
  provisioningState?: RackSkuProvisioningState;

  /**
   * The type of the rack.
   */
  rackType?: RackSkuType;

  /**
   * The list of appliance SKUs and associated rack slot for the storage appliance(s) in this rack model.
   */
  @identifiers(#[])
  storageAppliances?: StorageApplianceSkuSlot[];

  /**
   * The list of supported SKUs if the rack is an aggregator.
   */
  supportedRackSkuIds?: string[];
}

/**
 * MachineSkuSlot represents a single SKU and rack slot associated with the machine.
 */
model MachineSkuSlot {
  /**
   * The list of the resource properties.
   */
  properties?: MachineSkuProperties;

  /**
   * The position in the rack for the machine.
   */
  rackSlot?: int64;
}

/**
 * MachineSkuProperties represents the properties of the machine SKU.
 */
model MachineSkuProperties {
  /**
   * The type of bootstrap protocol used.
   */
  bootstrapProtocol?: BootstrapProtocol;

  /**
   * The count of CPU cores for this machine.
   */
  cpuCores?: int64;

  /**
   * The count of CPU sockets for this machine.
   */
  cpuSockets?: int64;

  /**
   * The list of disks.
   */
  @identifiers(#[])
  disks?: MachineDisk[];

  /**
   * The generation of the architecture.
   */
  generation?: string;

  /**
   * The hardware version of the machine.
   */
  hardwareVersion?: string;

  /**
   * The maximum amount of memory. Measured in gibibytes.
   */
  memoryCapacityGB?: int64;

  /**
   * The model of the machine.
   */
  `model`?: string;

  /**
   * The list of network interfaces.
   */
  @identifiers(#[])
  networkInterfaces?: NetworkInterface[];

  /**
   * The count of SMT and physical core threads for this machine.
   */
  totalThreads?: int64;

  /**
   * The make of the machine.
   */
  vendor?: string;
}

/**
 * Disk represents the properties of the disk.
 */
model MachineDisk {
  /**
   * The maximum amount of storage. Measured in gibibytes.
   */
  capacityGB?: int64;

  /**
   * The connection type of the rack SKU resource.
   */
  connection?: MachineSkuDiskConnectionType;

  /**
   * The disk type of rack SKU resource.
   */
  type?: DiskType;
}

/**
 * NetworkInterface represents properties of the network interface.
 */
model NetworkInterface {
  /**
   * The partial address of Peripheral Component Interconnect (PCI).
   */
  address?: string;

  /**
   * The connection type of the device.
   */
  deviceConnectionType?: DeviceConnectionType;

  /**
   * The model name of the device.
   */
  `model`?: string;

  /**
   * The physical slot for this device.
   */
  physicalSlot?: int64;

  /**
   * The number of ports on the device.
   */
  portCount?: int64;

  /**
   * The maximum amount of data in gigabits that the line card transmits through a port at any given second.
   */
  portSpeed?: int64;

  /**
   * The vendor name of the device.
   */
  vendor?: string;
}

/**
 * StorageApplianceSkuSlot represents the single SKU and rack slot associated with the storage appliance.
 */
model StorageApplianceSkuSlot {
  /**
   * The list of the resource properties.
   */
  properties?: StorageApplianceSkuProperties;

  /**
   * The position in the rack for the storage appliance.
   */
  rackSlot?: int64;
}

/**
 * StorageApplianceSkuProperties represents the properties of the storage appliance SKU.
 */
model StorageApplianceSkuProperties {
  /**
   * The maximum capacity of the storage appliance. Measured in gibibytes.
   */
  capacityGB?: int64;

  /**
   * The model of the storage appliance.
   */
  `model`?: string;
}

/**
 * RackList represents a list of racks.
 */
model RackList is Azure.Core.Page<Rack>;

/**
 * RackProperties represents the properties of the rack.
 */
model RackProperties {
  /**
   * The value that will be used for machines in this rack to represent the availability zones that can be referenced by Hybrid AKS Clusters for node arrangement.
   */
  @pattern("^[a-zA-Z0-9]{1,10}$")
  availabilityZone: string;

  /**
   * The resource ID of the cluster the rack is created for. This value is set when the rack is created by the cluster.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the rack.
   */
  detailedStatus?: RackDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The provisioning state of the rack resource.
   */
  provisioningState?: RackProvisioningState;

  /**
   * The free-form description of the rack location. (e.g. “DTN Datacenter, Floor 3, Isle 9, Rack 2B”)
   */
  @maxLength(256)
  rackLocation: string;

  /**
   * The unique identifier for the rack within Network Cloud cluster. An alternate unique alphanumeric value other than a serial number may be provided if desired.
   */
  @maxLength(64)
  @minLength(1)
  rackSerialNumber: string;

  /**
   * The SKU for the rack.
   */
  rackSkuId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/rackSkus";
    }
  ]>;
}

/**
 * RegisteredSubscriptionList represents a list of Kubernetes cluster agent pools.
 */
model RegisteredSubscriptionList is Azure.Core.Page<RegisteredSubscription>;

/**
 * See: https://eng.ms/docs/products/arm/rpaas/subregistrations
 */
model RegisteredSubscription {
  /**
   * The Account Owner.
   */
  accountOwner?: RegisteredSubscriptionAccountOwner;

  /**
   * The Registered Feature Details.
   */
  registeredFeatures?: RegisteredSubscriptionRegisteredFeature[];

  /**
   * The Registered Subscription ID.
   */
  subscriptionId?: string;

  /**
   * The Registered Subscription's Tenant ID.
   */
  tenantId?: string;
}

/**
 * Account Owner Details.
 */
model RegisteredSubscriptionAccountOwner {
  /**
   * The Account Owner Email.
   */
  email?: string;

  /**
   * The Account Owner Puid.
   */
  puid?: string;
}

/**
 * Registered Feature Details.
 */
model RegisteredSubscriptionRegisteredFeature {
  /**
   * The registered feature name.
   */
  name?: string;

  /**
   * The registered feature state.
   */
  state?: RegisteredSubscriptionRegisteredFeatureState;
}

/**
 * StorageApplianceList represents a list of storage appliances.
 */
model StorageApplianceList is Azure.Core.Page<StorageAppliance>;

/**
 * StorageApplianceProperties represents the properties of the storage appliance.
 */
model StorageApplianceProperties {
  /**
   * The credentials of the administrative interface on this storage appliance.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorCredentials: AdministrativeCredentials;

  /**
   * The CA certificate information issued by the platform for connecting to TLS interfaces for the storage appliance. Callers add this certificate to their trusted CA store to allow secure communication with the storage appliance.
   */
  @visibility(Lifecycle.Read)
  caCertificate?: CertificateInfo;

  /**
   * The total capacity of the storage appliance. Measured in GiB.
   */
  capacity?: int64;

  /**
   * The amount of storage consumed. Measured in GiB.
   */
  capacityUsed?: int64;

  /**
   * The resource ID of the cluster this storage appliance is associated with.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The detailed status of the storage appliance.
   */
  detailedStatus?: StorageApplianceDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The list of expansion shelves connected to the storage appliance.
   */
  @identifiers(#[])
  expansionShelves?: StorageApplianceExpansionShelf[];

  /**
   * StorageApplianceInternalMetadata represents the configuration details of the storage appliance that are NOT exposed to the customer.
   */
  internalMetadata?: StorageApplianceInternalMetadata;

  /**
   * The endpoint for the management interface of the storage appliance.
   */
  managementIpv4Address?: string;

  /**
   * The manufacturer of the storage appliance.
   */
  manufacturer?: string;

  /**
   * The model of the storage appliance.
   */
  `model`?: string;

  /**
   * The provisioning state of the storage appliance.
   */
  provisioningState?: StorageApplianceProvisioningState;

  /**
   * The resource ID of the rack where this storage appliance resides.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  rackId: Azure.Core.armResourceIdentifier;

  /**
   * The slot the storage appliance is in the rack based on the BOM configuration.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxValue(256)
  @minValue(1)
  rackSlot: int64;

  /**
   * The indicator of whether the storage appliance supports remote vendor management.
   */
  remoteVendorManagementFeature?: RemoteVendorManagementFeature;

  /**
   * The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
   */
  remoteVendorManagementStatus?: RemoteVendorManagementStatus;

  /**
   * The list of statuses that represent secret rotation activity.
   */
  @identifiers(#["secretType"])
  secretRotationStatus?: SecretRotationStatus[];

  /**
   * The serial number for the storage appliance.
   */
  serialNumber: string;

  /**
   * The SKU for the storage appliance.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageApplianceSkuId: string;

  /**
   * The version of the storage appliance.
   */
  version?: string;
}

/**
 * StorageApplianceExpansionShelf represents an expansion shelf connected to a storage appliance.
 */
model StorageApplianceExpansionShelf {
  /**
   * The model of the expansion shelf.
   */
  `model`?: string;

  /**
   * The version of the expansion shelf.
   */
  version?: string;
}

/**
 * StorageApplianceInternalMetadata represents the configuration details of the storage appliance that are NOT exposed to the customer.
 */
model StorageApplianceInternalMetadata {
  /**
   * AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.
   */
  deviceManagerCredentials?: AdministrativeCredentials;

  /**
   * The user token of the Device Manager User
   */
  deviceManagerToken?: string;

  /**
   * The connection Expiry Time when RemoteVendorManagement is Enabled
   */
  remoteAssistExpiryTime?: string;

  /**
   * The connection Start Time when RemoteVendorManagement is Enabled
   */
  remoteAssistStartTime?: string;

  /**
   * The connection Status when RemoteVendorManagement is Enabled
   */
  remoteAssistStatus?: string;

  /**
   * The list of statuses that represent secret rotation activity.
   */
  secretRotationStatus?: SecretRotationStatus[];

  /**
   * The Storage Appliance Name
   */
  storageApplianceName?: string;

  /**
   * The Storage Appliance NTP servers
   */
  storageApplianceNtpServers?: string[];

  /**
   * The Storage Appliance Proxy Server
   */
  storageApplianceProxyServer?: string;

  /**
   * The Storage Appliance Syslog Server
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  storageApplianceSyslogServers?: Record<string>;

  /**
   * AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.
   */
  storageUserCredentials?: AdministrativeCredentials;

  /**
   * The user token of the Storage User
   */
  storageUserToken?: string;

  /**
   * AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.
   */
  telemetryCredentials?: AdministrativeCredentials;

  /**
   * The user token of the Telemetry User
   */
  telemetryToken?: string;
}

/**
 * TrunkedNetworkList represents a list of trunked networks.
 */
model TrunkedNetworkList is Azure.Core.Page<TrunkedNetwork>;

/**
 * TrunkedNetworkProperties represents properties of the trunked network.
 */
model TrunkedNetworkProperties {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this trunked network is associated with.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the trunked network.
   */
  detailedStatus?: TrunkedNetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this trunked network.
   */
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType;

  /**
   * The default interface name for this trunked network in the virtual machine. This name can be overridden by the name supplied in the network attachment configuration of that virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(12)
  @pattern("^[a-zA-Z0-9@._-]*$")
  interfaceName?: string;

  /**
   * The list of resource IDs representing the Network Fabric isolation domains. It can be any combination of l2IsolationDomain and l3IsolationDomain resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isolationDomainIds: string[];

  /**
   * The provisioning state of the trunked network.
   */
  provisioningState?: TrunkedNetworkProvisioningState;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this trunked network.
   */
  virtualMachinesAssociatedIds?: string[];

  /**
   * The list of vlans that are selected from the isolation domains for trunking.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vlans: int64[];
}

/**
 * VirtualMachineList represents a list of virtual machines.
 */
model VirtualMachineList is Azure.Core.Page<VirtualMachine>;

/**
 * VirtualMachineProperties represents the properties of the virtual machine.
 */
model VirtualMachineProperties {
  /**
   * The name of the administrator to which the ssh public keys will be added into the authorized keys.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(32)
  @minLength(1)
  @pattern("^[a-z_][a-z0-9_]{0,31}$")
  adminUsername: string;

  /**
   * The cluster availability zone containing this virtual machine.
   */
  availabilityZone?: string;

  /**
   * The resource ID of the bare metal machine that hosts the virtual machine.
   */
  bareMetalMachineId?: Azure.Core.armResourceIdentifier;

  /**
   * Selects the boot method for the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  bootMethod?: VirtualMachineBootMethod = VirtualMachineBootMethod.UEFI;

  /**
   * The cloud service network that provides platform-level services for the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cloudServicesNetworkAttachment: NetworkAttachment;

  /**
   * The resource ID of the cluster the virtual machine is created for.
   */
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The extended location to use for creation of a VM console resource.
   */
  consoleExtendedLocation?: ExtendedLocation;

  /**
   * The number of CPU cores in the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(2)
  cpuCores: int64;

  /**
   * The more detailed status of the virtual machine.
   */
  detailedStatus?: VirtualMachineDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isolateEmulatorThread?: VirtualMachineIsolateEmulatorThread = VirtualMachineIsolateEmulatorThread.True;

  /**
   * The memory size of the virtual machine. Allocations are measured in gibibytes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(1)
  memorySizeGB: int64;

  /**
   * The list of network attachments to the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  networkAttachments?: NetworkAttachment[];

  /**
   * Field Deprecated: The Base64 encoded cloud-init network data. The networkDataContent property will be used in preference to this property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkData?: string;

  /**
   * The Base64 encoded cloud-init network data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkDataContent?: string;

  /**
   * PasswordReference contains the reference to the source of a password.
   */
  networkDataContentRef?: PasswordReference;

  /**
   * The scheduling hints for the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  placementHints?: VirtualMachinePlacementHint[];

  /**
   * The power state of the virtual machine.
   */
  powerState?: VirtualMachinePowerState;

  /**
   * The provisioning state of the virtual machine.
   */
  provisioningState?: VirtualMachineProvisioningState;

  /**
   * The list of ssh public keys. Each key will be added to the virtual machine using the cloud-init ssh_authorized_keys mechanism for the adminUsername.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  sshPublicKeys?: SshPublicKey[];

  /**
   * The storage profile that specifies size and other parameters about the disks related to the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageProfile: StorageProfile;

  /**
   * Field Deprecated: The Base64 encoded cloud-init user data. The userDataContent property will be used in preference to this property.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  userData?: string;

  /**
   * The Base64 encoded cloud-init user data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  userDataContent?: string;

  /**
   * PasswordReference contains the reference to the source of a password.
   */
  userDataContentRef?: PasswordReference;

  /**
   * Field Deprecated, use virtualizationModel instead. The type of the virtio interface.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  virtioInterface?: VirtualMachineVirtioInterfaceType = VirtualMachineVirtioInterfaceType.Modern;

  /**
   * The type of the device model to use.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmDeviceModel?: VirtualMachineDeviceModelType = VirtualMachineDeviceModelType.T2;

  /**
   * The virtual machine image that is currently provisioned to the OS disk, using the full url and tag notation used to pull the image.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmImage: string;

  /**
   * The credentials used to login to the image repository that has access to the specified image.
   */
  vmImageRepositoryCredentials?: ImageRepositoryCredentials;

  /**
   * The resource IDs of volumes that are attached to the virtual machine.
   */
  volumes?: string[];
}

/**
 * VirtualMachinePlacementHint represents a single scheduling hint of the virtual machine.
 */
model VirtualMachinePlacementHint {
  /**
   * The specification of whether this hint supports affinity or anti-affinity with the referenced resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hintType: VirtualMachinePlacementHintType;

  /**
   * The resource ID of the target object that the placement hints will be checked against, e.g., the bare metal node to host the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * The indicator of whether the hint is a hard or soft requirement during scheduling.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  schedulingExecution: VirtualMachineSchedulingExecution;

  /**
   * The scope for the virtual machine affinity or anti-affinity placement hint. It should always be "Machine" in the case of node affinity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  scope: VirtualMachinePlacementHintPodAffinityScope;
}

/**
 * StorageProfile represents information about a disk.
 */
model StorageProfile {
  /**
   * The disk to use with this virtual machine.
   */
  osDisk: OsDisk;

  /**
   * The resource IDs of volumes that are requested to be attached to the virtual machine.
   */
  volumeAttachments?: string[];
}

/**
 * OsDisk represents configuration of the boot disk.
 */
model OsDisk {
  /**
   * The strategy for creating the OS disk.
   */
  createOption?: OsDiskCreateOption = OsDiskCreateOption.Ephemeral;

  /**
   * The strategy for deleting the OS disk.
   */
  deleteOption?: OsDiskDeleteOption = OsDiskDeleteOption.Delete;

  /**
   * The size of the disk. Required if the createOption is Ephemeral. Allocations are measured in gibibytes.
   */
  diskSizeGB: int64;
}

/**
 * ImageRepositoryCredentials represents the credentials used to login to the image repository.
 */
model ImageRepositoryCredentials {
  /**
   * The password or token used to access an image in the target repository.
   */
  @minLength(1)
  password: string;

  /**
   * PasswordReference contains the reference to the source of a password.
   */
  passwordRef?: PasswordReference;

  /**
   * The URL of the authentication server used to validate the repository credentials.
   */
  registryUrl: string;

  /**
   * The username used to access an image in the target repository.
   */
  @minLength(1)
  username: string;
}

/**
 * VolumeList represents a list of volumes.
 */
model VolumeList is Azure.Core.Page<Volume>;

/**
 * VolumeProperties represents properties of the volume resource.
 */
model VolumeProperties {
  /**
   * The allocated size of the volume in Mebibytes.
   */
  allocatedSizeMiB?: int64;

  /**
   * The list of resource IDs that attach the volume. It may include virtual machines and Hybrid AKS clusters.
   */
  attachedTo?: string[];

  /**
   * The more detailed status of the volume.
   */
  detailedStatus?: VolumeDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The provisioning state of the volume.
   */
  provisioningState?: VolumeProvisioningState;

  /**
   * The unique identifier of the volume.
   */
  serialNumber?: string;

  /**
   * The requested storage allocation for the volume in Mebibytes.
   */
  @minValue(1)
  sizeMiB: int64;

  /**
   * The resource ID of the storage appliance that hosts the volume.
   */
  storageApplianceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/storageAppliances";
    }
  ]>;
}

/**
 * The current status of an async operation.
 */
model OperationStatusResult {
  /**
   * The end time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * If present, details of the operation error.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /**
   * Fully qualified ID for the async operation.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Name of the async operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The operations list.
   */
  @visibility(Lifecycle.Read)
  operations?: OperationStatusResult[];

  /**
   * Percent of the operation that is complete.
   */
  @visibility(Lifecycle.Read)
  @maxValue(100)
  percentComplete?: float32;

  /**
   * The additional properties of the operation status result.
   */
  properties?: OperationStatusResultProperties;

  /**
   * Fully qualified ID of the resource against which the original async operation was started.
   */
  @visibility(Lifecycle.Read)
  resourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The start time of the operation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Operation status.
   */
  status: string;
}

/**
 * OperationStatusResultProperties represents additional properties of the operation status result.
 */
model OperationStatusResultProperties {
  /**
   * For actions that run commands or scripts, the exit code of the script execution.
   */
  @visibility(Lifecycle.Read)
  exitCode?: string;

  /**
   * For actions that run commands or scripts, the leading bytes of the output of the script execution.
   */
  @visibility(Lifecycle.Read)
  outputHead?: string;

  /**
   * For actions that run commands or scripts, a reference to the location of the result.
   */
  @visibility(Lifecycle.Read)
  resultRef?: url;

  /**
   * For actions that run commands or scripts, the URL where the full output of the script output can be retrieved.
   */
  @visibility(Lifecycle.Read)
  resultUrl?: url;
}

/**
 * AccessBridgePatchParameters represents the payload for a PATCH request to an access bridge.
 */
model AccessBridgePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: AccessBridgePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * AccessBridgePatchProperties identifies the mutable properties for patch operations.
 */
model AccessBridgePatchProperties {
  /**
   * The list of security rules enforced by the access bridge.
   */
  @identifiers(#[])
  securityRules?: AccessBridgeSecurityRule[];
}

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
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
 * BareMetalMachineCordonParameters represents the body of the request to evacuate workloads from node on a bare metal machine.
 */
model BareMetalMachineCordonParameters {
  /**
   * The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.
   */
  evacuate?: BareMetalMachineEvacuate = BareMetalMachineEvacuate.False;
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
  commands: BareMetalMachineCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run. If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
   */
  @maxValue(14400)
  @minValue(60)
  limitTimeSeconds: int64;
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
 * BareMetalMachineRunReadCommandsParameters represents the body of request containing list of read-only commands to run on the bare metal machine.
 */
model BareMetalMachineRunReadCommandsParameters {
  /**
   * The list of read-only commands to be executed directly against the target machine.
   */
  @identifiers(#[])
  commands: BareMetalMachineCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run. If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
   */
  @maxValue(14400)
  @minValue(60)
  limitTimeSeconds: int64;
}

/**
 * CloudServicesNetworkPatchParameters represents the body of the request to patch the cloud services network.
 */
model CloudServicesNetworkPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: CloudServicesNetworkPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * CloudServicesNetworkPatchProperties represents the properties of the cloud services network that can be updated using a patch request.
 */
model CloudServicesNetworkPatchProperties {
  /**
   * The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.
   */
  @identifiers(#[])
  additionalEgressEndpoints?: EgressEndpoint[];

  /**
   * The indicator of whether the platform default endpoints are allowed for the egress traffic.
   */
  enableDefaultEgressEndpoints?: CloudServicesNetworkEnableDefaultEgressEndpoints;

  /**
   * The storage options for the cloud services network.
   */
  storageOptions?: CloudServicesNetworkStorageOptionsPatch;
}

/**
 * CloudServicesNetworkStorageOptionsPatch represents the patchable storage options for the cloud services network.
 */
model CloudServicesNetworkStorageOptionsPatch {
  /**
   * The indicator to enable shared storage on the cloud services network.
   */
  mode?: CloudServicesNetworkStorageMode;

  /**
   * The requested storage allocation for the volume in Mebibytes.
   */
  @minValue(1)
  sizeMiB?: int64;

  /**
   * The resource ID of the storage appliance that hosts the storage.
   */
  storageApplianceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/storageAppliances";
    }
  ]>;
}

/**
 * ClusterManagerPatchParameters represents the body of the request to patch the cluster properties.
 */
model ClusterManagerPatchParameters {
  /**
   * The identity for the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The list of the resource properties.
   */
  properties?: ClusterManagerPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * ClusterManagerPatchProperties represents the properties of the cluster for internal patching.
 */
model ClusterManagerPatchProperties {
  /**
   * The resource ID of the Log Analytics workspace that is used for the logs collection.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  analyticsWorkspaceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  /**
   * The Azure availability zones within the region that will be used to support the cluster manager resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @identifiers(#[])
  availabilityZones?: string[];

  /**
   * The list of the cluster versions the manager supports. It is used as input in clusterVersion property of a cluster resource.
   */
  @identifiers(#["targetClusterVersion"])
  clusterVersions?: ClusterAvailableVersion[];

  /**
   * The detailed status that provides additional information about the cluster manager.
   */
  detailedStatus?: ClusterManagerDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The resource ID of the fabric controller that has one to one mapping with the cluster manager.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricControllerId: Azure.Core.armResourceIdentifier;

  /**
   * ClusterManagerInternalMetadata represents configuration details of cluster manager that are NOT exposed to the customer.
   */
  internalMetadata?: ClusterManagerInternalMetadata;

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * ExtendedLocation represents the Azure custom location where the resource will be created.
   */
  managerExtendedLocation?: ExtendedLocation;

  /**
   * The provisioning state of the cluster manager.
   */
  provisioningState?: ClusterManagerProvisioningState;

  /**
   * ClusterManagerRelayConfiguration represents the relay configuration for the cluster manager.
   */
  relayConfiguration?: ClusterManagerRelayConfiguration;

  /**
   * The size of the Azure virtual machines to use for hosting the cluster manager resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSize?: string;
}

/**
 * ClusterManagerUpdateRelayPrivateEndpointConnectionParameters represents the body of the request to approve or reject the relay private endpoint connection for the private relay managed by a cluster manager.
 */
model ClusterManagerUpdateRelayPrivateEndpointConnectionParameters {
  /**
   * The state to set for the private endpoint connection.
   */
  connectionState: RelayPrivateEndpointConnectionState;

  /**
   * The description to associate with the private endpoint connection.
   */
  description?: string;

  /**
   * The resource ID of private endpoint to be permitted or denied connection to the relay namespace.
   */
  privateEndpointResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateEndpoints";
    }
  ]>;
}

/**
 * ClusterPatchParameters represents the body of the request to patch the cluster properties.
 */
model ClusterPatchParameters {
  /**
   * The identity for the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The list of the resource properties.
   */
  properties?: ClusterPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * ClusterPatchProperties represents the properties of the cluster for patching.
 */
model ClusterPatchProperties {
  /**
   * The rack definition that is intended to reflect only a single rack in a single rack cluster, or an aggregator rack in a multi-rack cluster.
   */
  aggregatorOrSingleRackDefinition?: RackDefinition;

  /**
   * The settings for the log analytics workspace used for output of logs from this cluster.
   */
  analyticsOutputSettings?: AnalyticsOutputSettings;

  /**
   * The customer-provided location information to identify where the cluster resides.
   */
  clusterLocation?: string;

  /**
   * Field Deprecated: Use managed identity to provide cluster privileges. The service principal to be used by the cluster during Arc Appliance installation.
   */
  clusterServicePrincipal?: ServicePrincipalInformation;

  /**
   * The settings for commands run in this cluster, such as bare metal machine run read only commands and data extracts.
   */
  commandOutputSettings?: CommandOutputSettings;

  /**
   * The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.
   */
  computeDeploymentThreshold?: ValidationThreshold;

  /**
   * The list of rack definitions for the compute racks in a multi-rack cluster, or an empty list in a single-rack cluster.
   */
  @identifiers(#["networkRackId"])
  computeRackDefinitions?: RackDefinition[];

  /**
   * ClusterInternalMetadata is a separate struct to exclude from the public API.
   */
  internalMetadata?: ClusterInternalMetadata;

  /**
   * The settings for cluster runtime protection.
   */
  runtimeProtectionConfiguration?: RuntimeProtectionConfiguration;

  /**
   * The configuration for use of a key vault to store secrets for later retrieval by the operator.
   */
  secretArchive?: ClusterSecretArchive;

  /**
   * The settings for the secret archive used to hold credentials for the cluster.
   */
  secretArchiveSettings?: SecretArchiveSettings;

  /**
   * The strategy for updating the cluster.
   */
  updateStrategy?: ClusterUpdateStrategy;

  /**
   * The settings for how security vulnerability scanning is applied to the cluster.
   */
  vulnerabilityScanningSettings?: VulnerabilityScanningSettingsPatch;
}

/**
 * VulnerabilityScanningSettingsPatch represents the settings for how security vulnerability scanning is applied to the cluster.
 */
model VulnerabilityScanningSettingsPatch {
  /**
   * The mode selection for container vulnerability scanning.
   */
  containerScan?: VulnerabilityScanningSettingsContainerScan;
}

/**
 * BareMetalMachineKeySetList represents a list of bare metal machine key sets.
 */
model BareMetalMachineKeySetList is Azure.Core.Page<BareMetalMachineKeySet>;

/**
 * BareMetalMachineKeySetProperties represents the properties of bare metal machine key set.
 */
model BareMetalMachineKeySetProperties {
  /**
   * The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureGroupId: string;

  /**
   * The more detailed status of the key set.
   */
  detailedStatus?: BareMetalMachineKeySetDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The date and time after which the users in this key set will be removed from the bare metal machines.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration: utcDateTime;

  /**
   * The list of IP addresses of jump hosts with management network access from which a login will be allowed for the users.
   */
  jumpHostsAllowed: string[];

  /**
   * The last time this key set was validated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastValidation?: utcDateTime;

  /**
   * The name of the group that users will be assigned to on the operating system of the machines.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(32)
  @pattern("^([A-Za-z]([A-Za-z0-9]*))$")
  osGroupName?: string;

  /**
   * The access level allowed for the users in this key set.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privilegeLevel: BareMetalMachineKeySetPrivilegeLevel;

  /**
   * The name of the access level to apply when the privilege level is set to Other.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privilegeLevelName?: string;

  /**
   * The provisioning state of the bare metal machine key set.
   */
  provisioningState?: BareMetalMachineKeySetProvisioningState;

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList: KeySetUser[];

  /**
   * The status evaluation of each user.
   */
  @identifiers(#["azureUserName"])
  userListStatus?: KeySetUserStatus[];
}

/**
 * KeySetUser represents the properties of the user in the key set.
 */
model KeySetUser {
  /**
   * The user name that will be used for access.
   */
  azureUserName: string;

  /**
   * The free-form description for this user.
   */
  @maxLength(256)
  description?: string;

  /**
   * The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
   */
  sshPublicKey: SshPublicKey;

  /**
   * The user principal name (email format) used to validate this user's group membership.
   */
  userPrincipalName?: string;
}

/**
 * KeySetUserStatus represents the status of the key set user.
 */
model KeySetUserStatus {
  /**
   * The user name that will be used for access.
   */
  azureUserName?: string;

  /**
   * The indicator of whether the user is currently deployed for access.
   */
  status?: BareMetalMachineKeySetUserSetupStatus;

  /**
   * The additional information describing the current status of this user, if any available.
   */
  @maxLength(256)
  statusMessage?: string;
}

/**
 * BareMetalMachineKeySetPatchParameters represents the body of the request to patch the bare metal machine key set.
 */
model BareMetalMachineKeySetPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: BareMetalMachineKeySetPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * BareMetalMachineKeySetPatchProperties represents the properties of bare metal machine key set that can be patched.
 */
model BareMetalMachineKeySetPatchProperties {
  /**
   * The date and time after which the users in this key set will be removed from the bare metal machines.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;

  /**
   * The list of IP addresses of jump hosts with management network access from which a login will be allowed for the users.
   */
  jumpHostsAllowed?: string[];

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList?: KeySetUser[];
}

/**
 * BmcKeySetList represents a list of baseboard management controller key sets.
 */
model BmcKeySetList is Azure.Core.Page<BmcKeySet>;

/**
 * BmcKeySetProperties represents the properties of baseboard management controller key set.
 */
model BmcKeySetProperties {
  /**
   * The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureGroupId: string;

  /**
   * The more detailed status of the key set.
   */
  detailedStatus?: BmcKeySetDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The date and time after which the users in this key set will be removed from the baseboard management controllers.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration: utcDateTime;

  /**
   * The last time this key set was validated.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastValidation?: utcDateTime;

  /**
   * The access level allowed for the users in this key set.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privilegeLevel: BmcKeySetPrivilegeLevel;

  /**
   * The provisioning state of the baseboard management controller key set.
   */
  provisioningState?: BmcKeySetProvisioningState;

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList: KeySetUser[];

  /**
   * The status evaluation of each user.
   */
  @identifiers(#["azureUserName"])
  userListStatus?: KeySetUserStatus[];
}

/**
 * BmcKeySetPatchParameters represents the body of the request to patch the baseboard management controller key set.
 */
model BmcKeySetPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: BmcKeySetPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * BmcKeySetPatchProperties represents the properties of baseboard management controller key set that are patchable.
 */
model BmcKeySetPatchProperties {
  /**
   * The date and time after which the users in this key set will be removed from the baseboard management controllers.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList?: KeySetUser[];
}

/**
 * ClusterContinueUpdateVersionParameters represents the body of the request to continue the update of a cluster version.
 */
model ClusterContinueUpdateVersionParameters {
  /**
   * The mode by which the cluster will target the next grouping of servers to continue the update.
   */
  machineGroupTargetingMode?: ClusterContinueUpdateVersionMachineGroupTargetingMode = ClusterContinueUpdateVersionMachineGroupTargetingMode.AlphaByRack;
}

/**
 * ClusterDeployParameters represents the body of the request to deploy cluster.
 */
model ClusterDeployParameters {
  /**
   * The names of bare metal machines in the cluster that should be skipped during environment validation.
   */
  skipValidationsForMachines?: string[];
}

/**
 * ClusterInspectParameters represents the body of the request to inspect the cluster.
 */
model ClusterInspectParameters {
  /**
   * Additional actions supplement the default non-disruptive cluster inspection. Additional actions may be disallowed if the cluster is in a deployed and running state.
   */
  additionalActions?: ClusterInspectParametersAdditionalActionsItem[];

  /**
   * Indicates which devices are included in the inspection. By default, all devices that can be targeted will be included in the inspection.
   */
  filterDevices?: FilterDevices;
}

/**
 * FilterDevices defines the filtered target of the inspection.
 */
model FilterDevices {
  /**
   * The list of bare metal machine names to include in the inspection.
   */
  bareMetalMachineNames?: string[];

  /**
   * The list of rack names to include in the inspection.
   */
  rackNames?: string[];
}

/**
 * ClusterMetricsConfigurationList represents a list of metrics configuration of the cluster.
 */
model ClusterMetricsConfigurationList
  is Azure.Core.Page<ClusterMetricsConfiguration>;

/**
 * ClusterMetricsConfigurationProperties represents the properties of metrics configuration for the cluster.
 */
model ClusterMetricsConfigurationProperties {
  /**
   * The interval in minutes by which metrics will be collected.
   */
  @maxValue(1440)
  @minValue(1)
  collectionInterval: int64;

  /**
   * The more detailed status of the metrics configuration.
   */
  detailedStatus?: ClusterMetricsConfigurationDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The list of metrics that are available for the cluster but disabled at the moment.
   */
  disabledMetrics?: string[];

  /**
   * The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.
   */
  enabledMetrics?: string[];

  /**
   * The provisioning state of the metrics configuration.
   */
  provisioningState?: ClusterMetricsConfigurationProvisioningState;
}

/**
 * ClusterMetricsConfigurationPatchParameters represents the body of the request to patch the metrics configuration of cluster.
 */
model ClusterMetricsConfigurationPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: ClusterMetricsConfigurationPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * ClusterMetricsConfigurationPatchProperties represents the properties of metrics configuration for the cluster for patching.
 */
model ClusterMetricsConfigurationPatchProperties {
  /**
   * The interval in minutes by which metrics will be collected.
   */
  @maxValue(1440)
  @minValue(1)
  collectionInterval?: int64;

  /**
   * The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.
   */
  enabledMetrics?: string[];
}

/**
 * ClusterScanRuntimeParameters defines the parameters for the cluster scan runtime operation.
 */
model ClusterScanRuntimeParameters {
  /**
   * The choice of if the scan operation should run the scan.
   */
  scanActivity?: ClusterScanRuntimeParametersScanActivity = ClusterScanRuntimeParametersScanActivity.Scan;
}

/**
 * ClusterUpdateVersionParameters represents the body of the request to update cluster version.
 */
model ClusterUpdateVersionParameters {
  /**
   * The version to be applied to the cluster during update.
   */
  targetClusterVersion: string;
}

/**
 * KubernetesClusterPatchParameters represents the body of the request to patch the Hybrid AKS cluster.
 */
model KubernetesClusterPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: KubernetesClusterPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * KubernetesClusterPatchProperties represents the properties of the Kubernetes cluster that can be patched.
 */
model KubernetesClusterPatchProperties {
  /**
   * The configuration of the default administrator credentials.
   */
  administratorConfiguration?: AdministratorConfigurationPatch;

  /**
   * The defining characteristics of the control plane that can be patched for this Kubernetes cluster.
   */
  controlPlaneNodeConfiguration?: ControlPlaneNodePatchConfiguration;

  /**
   * The Kubernetes version for this cluster.
   */
  kubernetesVersion?: string;
}

/**
 * AdministratorConfigurationPatch represents the patching capabilities for the administrator configuration.
 */
model AdministratorConfigurationPatch {
  /**
   * SshPublicKey represents the public key used to authenticate with a resource through SSH.
   */
  @identifiers(#["keyData"])
  sshPublicKeys?: SshPublicKey[];
}

/**
 * ControlPlaneNodePatchConfiguration represents the properties of the control plane that can be patched for this Kubernetes cluster.
 */
model ControlPlaneNodePatchConfiguration {
  /**
   * The configuration of administrator credentials for the control plane nodes.
   */
  administratorConfiguration?: AdministratorConfigurationPatch;

  /**
   * The number of virtual machines that use this configuration.
   */
  @minValue(1)
  count?: int64;
}

/**
 * AgentPoolList represents a list of Kubernetes cluster agent pools.
 */
model AgentPoolList is Azure.Core.Page<AgentPool>;

/**
 * AgentPoolProperties represents the properties of the Kubernetes cluster agent pool.
 */
model AgentPoolProperties {
  /**
   * The administrator credentials to be used for the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The configurations that will be applied to each agent in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  agentOptions?: AgentOptions;

  /**
   * The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  /**
   * The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZones?: string[];

  /**
   * The number of virtual machines that use this configuration.
   */
  count: int64;

  /**
   * The current status of the agent pool.
   */
  detailedStatus?: AgentPoolDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The Kubernetes version running in this agent pool.
   */
  kubernetesVersion?: string;

  /**
   * The labels applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  labels?: KubernetesLabel[];

  /**
   * The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: AgentPoolMode;

  /**
   * The provisioning state of the agent pool.
   */
  provisioningState?: AgentPoolProvisioningState;

  /**
   * The taints applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  taints?: KubernetesLabel[];

  /**
   * The configuration of the agent pool.
   */
  upgradeSettings?: AgentPoolUpgradeSettings;

  /**
   * The name of the VM SKU that determines the size of resources allocated for node VMs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSkuName: string;
}

/**
 * AgentPoolPatchParameters represents the body of the request to patch the Kubernetes cluster agent pool.
 */
model AgentPoolPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: AgentPoolPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * AgentPoolPatchProperties represents the properties of an agent pool that can be modified.
 */
model AgentPoolPatchProperties {
  /**
   * The configuration of administrator credentials for the control plane nodes.
   */
  administratorConfiguration?: NodePoolAdministratorConfigurationPatch;

  /**
   * The number of virtual machines that use this configuration.
   */
  count?: int64;

  /**
   * The configuration of the agent pool.
   */
  upgradeSettings?: AgentPoolUpgradeSettings;
}

/**
 * NodePoolAdministratorConfigurationPatch represents the patching capabilities for the administrator configuration.
 */
model NodePoolAdministratorConfigurationPatch {
  /**
   * SshPublicKey represents the public key used to authenticate with a resource through SSH.
   */
  @identifiers(#["keyData"])
  sshPublicKeys?: SshPublicKey[];
}

/**
 * KubernetesClusterFeatureList represents the list of Kubernetes cluster feature resources.
 */
model KubernetesClusterFeatureList is Azure.Core.Page<KubernetesClusterFeature>;

/**
 * KubernetesClusterFeatureProperties represents the properties of a Kubernetes cluster feature.
 */
model KubernetesClusterFeatureProperties {
  /**
   * The lifecycle indicator of the feature.
   */
  availabilityLifecycle?: KubernetesClusterFeatureAvailabilityLifecycle;

  /**
   * The detailed status of the feature.
   */
  detailedStatus?: KubernetesClusterFeatureDetailedStatus;

  /**
   * The descriptive message for the detailed status of the feature.
   */
  detailedStatusMessage?: string;

  /**
   * KubernetesClusterFeatureInternalMetadata represents the internal metadata for the Kubernetes cluster feature.
   */
  internalMetadata?: KubernetesClusterFeatureInternalMetadata;

  /**
   * The configured options for the feature.
   */
  @identifiers(#["key"])
  options?: StringKeyValuePair[];

  /**
   * The provisioning state of the Kubernetes cluster feature.
   */
  provisioningState?: KubernetesClusterFeatureProvisioningState;

  /**
   * The indicator of if the feature is required or optional. Optional features may be deleted by the user, while required features are managed with the kubernetes cluster lifecycle.
   */
  required?: KubernetesClusterFeatureRequired;

  /**
   * The version of the feature.
   */
  version?: string;
}

/**
 * KubernetesClusterFeatureInternalMetadata represents the internal metadata for the Kubernetes cluster feature.
 */
model KubernetesClusterFeatureInternalMetadata {
  /**
   * The chart version used to manage the feature
   */
  chartVersion?: string;
}

/**
 * StringKeyValuePair represents a single entry in a mapping of keys to values.
 */
model StringKeyValuePair {
  /**
   * The key to the mapped value.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  key: string;

  /**
   * The value of the mapping key.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  value: string;
}

/**
 * KubernetesClusterFeaturePatchParameters represents the body of the request to patch the Kubernetes cluster feature.
 */
model KubernetesClusterFeaturePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: KubernetesClusterFeaturePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * KubernetesClusterFeaturePatchProperties represents the Kubernetes cluster feature properties for patching.
 */
model KubernetesClusterFeaturePatchProperties {
  /**
   * The lifecycle indicator of the feature.
   */
  availabilityLifecycle?: KubernetesClusterFeatureAvailabilityLifecycle;

  /**
   * The detailed status of the feature.
   */
  detailedStatus?: KubernetesClusterFeatureDetailedStatus;

  /**
   * The descriptive message for the detailed status of the feature.
   */
  detailedStatusMessage?: string;

  /**
   * KubernetesClusterFeatureInternalMetadata represents the internal metadata for the Kubernetes cluster feature.
   */
  internalMetadata?: KubernetesClusterFeatureInternalMetadata;

  /**
   * The configured options for the feature.
   */
  @identifiers(#["key"])
  options?: StringKeyValuePair[];

  /**
   * The provisioning state of the Kubernetes cluster feature . Cannot be patched by the user.
   */
  provisioningState?: KubernetesClusterFeaturePatchPropertiesProvisioningState;

  /**
   * The indicator of if the feature is required or optional. Optional features may be deleted by the user, while required features are managed with the kubernetes cluster lifecycle.
   */
  required?: KubernetesClusterFeatureRequired;

  /**
   * The version of the feature.
   */
  version?: string;
}

/**
 * KubernetesClusterRestartNodeParameters represents the body of the request to restart the node of a Kubernetes cluster.
 */
model KubernetesClusterRestartNodeParameters {
  /**
   * The name of the node to restart.
   */
  nodeName: string;
}

/**
 * KubernetesVersionPatchParameters represents the body of the request to patch Kubernetes version tags.
 */
model KubernetesVersionPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * L2NetworkPatchParameters represents the body of the request to patch the L2 network.
 */
model L2NetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * L3NetworkPatchParameters represents the body of the request to patch the cloud services network.
 */
model L3NetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * RackPatchParameters represents the body of the request to patch the rack properties.
 */
model RackPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: RacksPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * RacksPatchProperties represents the properties of the rack during patching.
 */
model RacksPatchProperties {
  /**
   * The free-form description of the rack location. (e.g. “DTN Datacenter, Floor 3, Isle 9, Rack 2B”)
   */
  @maxLength(256)
  rackLocation?: string;

  /**
   * The globally unique identifier for the rack.
   */
  @maxLength(64)
  @minLength(1)
  rackSerialNumber?: string;
}

/**
 * StorageAppliancePatchParameters represents the body of the request to patch storage appliance properties.
 */
model StorageAppliancePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: StorageAppliancePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * StorageAppliancePatchProperties represents the properties of the storage appliance that can be patched.
 */
model StorageAppliancePatchProperties {
  /**
   * The serial number for the storage appliance.
   */
  serialNumber?: string;
}

/**
 * StorageApplianceEnableRemoteVendorManagementParameters represents the body of the request to enable remote vendor management of a storage appliance.
 */
model StorageApplianceEnableRemoteVendorManagementParameters {
  /**
   * Field Deprecated. This field is not used and will be rejected if provided. The list of IPv4 subnets (in CIDR format), IPv6 subnets (in CIDR format), or hostnames that the storage appliance needs accessible in order to turn on the remote vendor management.
   */
  supportEndpoints?: string[];
}

/**
 * StorageApplianceRunReadCommandsParameters represents the body of request containing list of read-only commands to run on the storage appliance.
 */
model StorageApplianceRunReadCommandsParameters {
  /**
   * The list of read-only commands to be executed directly against the target storage appliance.
   */
  @identifiers(#[])
  commands: StorageApplianceCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run.
   */
  @maxValue(14400)
  @minValue(60)
  limitTimeSeconds: int64;
}

/**
 * StorageApplianceCommandSpecification represents the command and optional arguments to run.
 */
model StorageApplianceCommandSpecification {
  /**
   * The list of strings that will be passed to the script in order as separate arguments.
   */
  arguments?: string[];

  /**
   * The command to execute.
   */
  command: string;
}

/**
 * TrunkedNetworkPatchParameters represents the body of the request to patch the Trunked network.
 */
model TrunkedNetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * VirtualMachinePatchParameters represents the body of the request to patch the virtual machine.
 */
model VirtualMachinePatchParameters {
  /**
   * The identity for the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * The list of the resource properties.
   */
  properties?: VirtualMachinePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * VirtualMachinePatchProperties represents the properties of the virtual machine that can be patched.
 */
model VirtualMachinePatchProperties {
  /**
   * The credentials used to login to the image repository that has access to the specified image.
   */
  vmImageRepositoryCredentials?: ImageRepositoryCredentials;
}

/**
 * VirtualMachineAssignRelayParameters represents the body of the request to update the relay used for a Microsoft.HybridCompute machine associated with the virtual machine.
 */
model VirtualMachineAssignRelayParameters {
  /**
   * The resourceId of the Microsoft.HybridCompute machine resource to assign relay usage.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  machineId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/machines";
    }
  ]>;

  /**
   * The indicator of which relay type the machine should be assigned to use. Platform indicates the use of a platform-dedicated relay. Public indicates the use of the standard public relay for Arc services.
   */
  relayType?: RelayType = RelayType.Platform;
}

/**
 * ConsoleList represents a list of virtual machine consoles.
 */
model ConsoleList is Azure.Core.Page<Console>;

/**
 * ConsoleProperties represents the properties of the virtual machine console.
 */
model ConsoleProperties {
  /**
   * The more detailed status of the console.
   */
  detailedStatus?: ConsoleDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  detailedStatusMessage?: string;

  /**
   * The indicator of whether the console access is enabled.
   */
  enabled: ConsoleEnabled;

  /**
   * The date and time after which the key will be disallowed access.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;

  /**
   * ClusterInternalMetadata is a separate struct to exclude from the public API.
   */
  internalMetadata?: ConsoleInternalMetadata;

  /**
   * The resource ID of the private link service that is used to provide virtual machine console access.
   */
  privateLinkServiceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateLinkServices";
    }
  ]>;

  /**
   * The provisioning state of the virtual machine console.
   */
  provisioningState?: ConsoleProvisioningState;

  /**
   * The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
   */
  sshPublicKey: SshPublicKey;

  /**
   * The unique identifier for the virtual machine that is used to access the console.
   */
  virtualMachineAccessId?: string;
}

/**
 * ClusterInternalMetadata is a separate struct to exclude from the public API.
 */
model ConsoleInternalMetadata {
  /**
   * The cluster ID of the cluster this virtual machine is created on.
   */
  clusterId?: string;
}

/**
 * ConsolePatchParameters represents the body of the request to patch the virtual machine console.
 */
model ConsolePatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: ConsolePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * ConsolePatchProperties represents the properties of the virtual machine console that can be patched.
 */
model ConsolePatchProperties {
  /**
   * The indicator of whether the console access is enabled.
   */
  enabled?: ConsoleEnabled;

  /**
   * The date and time after which the key will be disallowed access.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration?: utcDateTime;

  /**
   * The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
   */
  sshPublicKey?: SshPublicKey;
}

/**
 * VirtualMachinePowerOffParameters represents the body of the request to power off virtual machine.
 */
model VirtualMachinePowerOffParameters {
  /**
   * The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.
   */
  skipShutdown?: SkipShutdown = SkipShutdown.False;
}

/**
 * VolumePatchParameters represents the body of the request to patch the volume resource.
 */
model VolumePatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * AgentPoolConfiguration specifies the configuration of a pool of nodes.
 */
model AgentPoolConfiguration {
  /**
   * The administrator credentials to be used for the nodes in this agent pool.
   */
  administratorConfiguration?: AdministratorConfiguration;

  /**
   * The configurations that will be applied to each agent in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  agentOptions?: AgentOptions;

  /**
   * The configuration of networks being attached to the agent pool for use by the workloads that run on this Kubernetes cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkConfiguration?: AttachedNetworkConfiguration;

  /**
   * The list of availability zones of the Network Cloud cluster used for the provisioning of nodes in this agent pool. If not specified, all availability zones will be used.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  availabilityZones?: string[];

  /**
   * The number of virtual machines that use this configuration.
   */
  count: int64;

  /**
   * The labels applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  labels?: KubernetesLabel[];

  /**
   * The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  mode: AgentPoolMode;

  /**
   * The taints applied to the nodes in this agent pool.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  taints?: KubernetesLabel[];

  /**
   * The configuration of the agent pool.
   */
  upgradeSettings?: AgentPoolUpgradeSettings;

  /**
   * The name of the VM SKU that determines the size of resources allocated for node VMs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSkuName: string;
}

/**
 * TagsParameter represents the resource tags.
 */
model TagsParameter {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}
