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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * The cordon status of the bare metal machine.
 */
union BareMetalMachineCordonStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cordoned: "Cordoned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Uncordoned: "Uncordoned",
}

/**
 * The more detailed status of the bare metal machine.
 */
union BareMetalMachineDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preparing: "Preparing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioned: "Provisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deprovisioning: "Deprovisioning",
}

/**
 * The outcome of the hardware validation.
 */
union BareMetalMachineHardwareValidationResult {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pass: "Pass",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Fail: "Fail",
}

/**
 * The power state derived from the baseboard management controller.
 */
union BareMetalMachinePowerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  On: "On",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Off: "Off",
}

/**
 * The provisioning state of the bare metal machine.
 */
union BareMetalMachineProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The indicator of whether the bare metal machine is ready to receive workloads.
 */
union BareMetalMachineReadyState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The more detailed status of the cloud services network.
 */
union CloudServicesNetworkDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The indicator of whether the platform default endpoints are allowed for the egress traffic.
 */
union CloudServicesNetworkEnableDefaultEgressEndpoints {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The provisioning state of the cloud services network.
 */
union CloudServicesNetworkProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The detailed status that provides additional information about the cluster manager.
 */
union ClusterManagerDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ProvisioningFailed: "ProvisioningFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdateFailed: "UpdateFailed",
}

/**
 * The provisioning state of the cluster manager.
 */
union ClusterManagerProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * The type of managed identity that is being selected.
 */
union ManagedServiceIdentitySelectorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssignedIdentity: "SystemAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UserAssignedIdentity: "UserAssignedIdentity",
}

/**
 * The indicator of whether the control plane will be impacted during the upgrade.
 */
union ControlImpact {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The indicator of whether the workload will be impacted during the upgrade.
 */
union WorkloadImpact {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The latest heartbeat status between the cluster manager and the cluster.
 */
union ClusterConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Timeout: "Timeout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Undefined: "Undefined",
}

/**
 * The latest connectivity status between cluster manager and the cluster.
 */
union ClusterManagerConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unreachable: "Unreachable",
}

/**
 * The type of rack configuration for the cluster.
 */
union ClusterType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SingleRack: "SingleRack",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MultiRack: "MultiRack",
}

/**
 * Selection of how the type evaluation is applied to the cluster calculation.
 */
union ValidationThresholdGrouping {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PerCluster: "PerCluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PerRack: "PerRack",
}

/**
 * Selection of how the threshold should be evaluated.
 */
union ValidationThresholdType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CountSuccess: "CountSuccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PercentSuccess: "PercentSuccess",
}

/**
 * The current detailed status of the cluster.
 */
union ClusterDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PendingDeployment: "PendingDeployment",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deploying: "Deploying",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdatePaused: "UpdatePaused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Degraded: "Degraded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

/**
 * The provisioning state of the cluster.
 */
union ClusterProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validating: "Validating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * The mode of operation for runtime protection.
 */
union RuntimeProtectionEnforcementLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Audit: "Audit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnDemand: "OnDemand",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Passive: "Passive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RealTime: "RealTime",
}

/**
 * The indicator if the specified key vault should be used to archive the secrets of the cluster.
 */
union ClusterSecretArchiveEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The mode of operation for runtime protection.
 */
union ClusterUpdateStrategyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rack: "Rack",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PauseAfterRack: "PauseAfterRack",
}

/**
 * The mode selection for container vulnerability scanning.
 */
union VulnerabilityScanningSettingsContainerScan {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
}

/**
 * The version lifecycle indicator.
 */
union AvailabilityLifecycle {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preview: "Preview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenerallyAvailable: "GenerallyAvailable",
}

/**
 * The current status of the Kubernetes cluster.
 */
union KubernetesClusterDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The status representing the state of this feature.
 */
union FeatureDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * The size of the hugepages to allocate.
 */
union HugepagesSize {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `2M`: "2M",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `1G`: "1G",
}

/**
 * The indicator of how this network will be utilized by the Kubernetes cluster.
 */
union KubernetesPluginType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DPDK: "DPDK",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SRIOV: "SRIOV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OSDevice: "OSDevice",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  MACVLAN: "MACVLAN",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPVLAN: "IPVLAN",
}

/**
 * The indication of whether this network will or will not perform IP address management and allocate IP addresses when attached.
 */
union L3NetworkConfigurationIpamEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The selection of how this agent pool is utilized, either as a system pool or a user pool. System pools run the features and critical services for the Kubernetes Cluster, while user pools are dedicated to user workloads. Every Kubernetes cluster must contain at least one system node pool with at least one node.
 */
union AgentPoolMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  System: "System",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotApplicable: "NotApplicable",
}

/**
 * The indicator of if this advertisement is also made to the network fabric associated with the Network Cloud Cluster. This field is ignored if fabricPeeringEnabled is set to False.
 */
union AdvertiseToFabric {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The indicator to determine if automatic allocation from the pool should occur.
 */
union BfdEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The indicator to enable multi-hop peering support.
 */
union BgpMultiHop {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The indicator to specify if the load balancer peers with the network fabric.
 */
union FabricPeeringEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The detailed state of this node.
 */
union KubernetesClusterNodeDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduling: "Scheduling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Terminating: "Terminating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * The indicator of whether this is the default gateway.
 * Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
 */
union DefaultGateway {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The IP allocation mechanism for the virtual machine.
 * Dynamic and Static are only valid for l3Network which may also specify Disabled.
 * Otherwise, Disabled is the only permitted value.
 */
union VirtualMachineIPAllocationMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Dynamic: "Dynamic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Static: "Static",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The power state of this node.
 */
union KubernetesNodePowerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  On: "On",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Off: "Off",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * The role of this node in the cluster.
 */
union KubernetesNodeRole {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ControlPlane: "ControlPlane",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Worker: "Worker",
}

/**
 * The provisioning state of the Kubernetes cluster resource.
 */
union KubernetesClusterProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
}

/**
 * The more detailed status of the L2 network.
 */
union L2NetworkDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
 */
union HybridAksPluginType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DPDK: "DPDK",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SRIOV: "SRIOV",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OSDevice: "OSDevice",
}

/**
 * The provisioning state of the L2 network.
 */
union L2NetworkProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The more detailed status of the L3 network.
 */
union L3NetworkDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The indicator of whether or not to disable IPAM allocation on the network attachment definition injected into the Hybrid AKS Cluster.
 */
union HybridAksIpamEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The type of the IP address allocation, defaulted to "DualStack".
 */
union IpAllocationType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPV4: "IPV4",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IPV6: "IPV6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DualStack: "DualStack",
}

/**
 * The provisioning state of the L3 network.
 */
union L3NetworkProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The type of bootstrap protocol used.
 */
union BootstrapProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PXE: "PXE",
}

/**
 * The connection type of the rack SKU resource.
 */
union MachineSkuDiskConnectionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PCIE: "PCIE",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SATA: "SATA",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RAID: "RAID",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SAS: "SAS",
}

/**
 * The disk type of rack SKU resource.
 */
union DiskType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HDD: "HDD",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SSD: "SSD",
}

/**
 * The connection type of the device.
 */
union DeviceConnectionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PCI: "PCI",
}

/**
 * The provisioning state of the rack SKU resource.
 */
union RackSkuProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
}

/**
 * The type of the rack.
 */
union RackSkuType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Aggregator: "Aggregator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Compute: "Compute",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Single: "Single",
}

/**
 * The more detailed status of the rack.
 */
union RackDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the rack resource.
 */
union RackProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The detailed status of the storage appliance.
 */
union StorageApplianceDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Degraded: "Degraded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the storage appliance.
 */
union StorageApplianceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The indicator of whether the storage appliance supports remote vendor management.
 */
union RemoteVendorManagementFeature {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Supported: "Supported",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unsupported: "Unsupported",
}

/**
 * The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
 */
union RemoteVendorManagementStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unsupported: "Unsupported",
}

/**
 * The more detailed status of the trunked network.
 */
union TrunkedNetworkDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the trunked network.
 */
union TrunkedNetworkProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * Selects the boot method for the virtual machine.
 */
union VirtualMachineBootMethod {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UEFI: "UEFI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BIOS: "BIOS",
}

/**
 * The more detailed status of the virtual machine.
 */
union VirtualMachineDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scheduling: "Scheduling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Terminating: "Terminating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
 */
union VirtualMachineIsolateEmulatorThread {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The specification of whether this hint supports affinity or anti-affinity with the referenced resources.
 */
union VirtualMachinePlacementHintType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Affinity: "Affinity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AntiAffinity: "AntiAffinity",
}

/**
 * The indicator of whether the hint is a hard or soft requirement during scheduling.
 */
union VirtualMachineSchedulingExecution {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Hard: "Hard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Soft: "Soft",
}

/**
 * The scope for the virtual machine affinity or anti-affinity placement hint. It should always be "Machine" in the case of node affinity.
 */
union VirtualMachinePlacementHintPodAffinityScope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rack: "Rack",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Machine: "Machine",
}

/**
 * The power state of the virtual machine.
 */
union VirtualMachinePowerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  On: "On",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Off: "Off",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * The provisioning state of the virtual machine.
 */
union VirtualMachineProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Delete: "Delete",
}

/**
 * Field Deprecated, use virtualizationModel instead. The type of the virtio interface.
 */
union VirtualMachineVirtioInterfaceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Modern: "Modern",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the volume.
 */
union VolumeProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The indicator of whether to evacuate the node workload when the bare metal machine is cordoned.
 */
union BareMetalMachineEvacuate {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The indicator of whether to skip the graceful OS shutdown and power off the bare metal machine immediately.
 */
union BareMetalMachineSkipShutdown {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The more detailed status of the key set.
 */
union BareMetalMachineKeySetDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllActive: "AllActive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SomeInvalid: "SomeInvalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllInvalid: "AllInvalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validating: "Validating",
}

/**
 * The access level allowed for the users in this key set.
 */
union BareMetalMachineKeySetPrivilegeLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Superuser: "Superuser",
}

/**
 * The provisioning state of the bare metal machine key set.
 */
union BareMetalMachineKeySetProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The indicator of whether the user is currently deployed for access.
 */
union BareMetalMachineKeySetUserSetupStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Invalid: "Invalid",
}

/**
 * The more detailed status of the key set.
 */
union BmcKeySetDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllActive: "AllActive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SomeInvalid: "SomeInvalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AllInvalid: "AllInvalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validating: "Validating",
}

/**
 * The access level allowed for the users in this key set.
 */
union BmcKeySetPrivilegeLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadOnly: "ReadOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Administrator: "Administrator",
}

/**
 * The provisioning state of the baseboard management controller key set.
 */
union BmcKeySetProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The mode by which the cluster will target the next grouping of servers to continue the update.
 */
union ClusterContinueUpdateVersionMachineGroupTargetingMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AlphaByRack: "AlphaByRack",
}

/**
 * The more detailed status of the metrics configuration.
 */
union ClusterMetricsConfigurationDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Processing: "Processing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Applied: "Applied",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

/**
 * The provisioning state of the metrics configuration.
 */
union ClusterMetricsConfigurationProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The choice of if the scan operation should run the scan.
 */
union ClusterScanRuntimeParametersScanActivity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scan: "Scan",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Skip: "Skip",
}

/**
 * The current status of the agent pool.
 */
union AgentPoolDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Available: "Available",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
}

/**
 * The provisioning state of the agent pool.
 */
union AgentPoolProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * The lifecycle indicator of the feature.
 */
union KubernetesClusterFeatureAvailabilityLifecycle {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Preview: "Preview",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  GenerallyAvailable: "GenerallyAvailable",
}

/**
 * The detailed status of the feature.
 */
union KubernetesClusterFeatureDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Installed: "Installed",
}

/**
 * The provisioning state of the Kubernetes cluster feature.
 */
union KubernetesClusterFeatureProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
}

/**
 * The indicator of if the feature is required or optional. Optional features may be deleted by the user, while required features are managed with the kubernetes cluster lifecycle.
 */
union KubernetesClusterFeatureRequired {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The more detailed status of the console.
 */
union ConsoleDetailedStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ready: "Ready",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

/**
 * The indicator of whether the console access is enabled.
 */
union ConsoleEnabled {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  False: "False",
}

/**
 * The provisioning state of the virtual machine console.
 */
union ConsoleProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Provisioning: "Provisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Accepted: "Accepted",
}

/**
 * The indicator of whether to skip the graceful OS shutdown and power off the virtual machine immediately.
 */
union SkipShutdown {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  True: "True",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * BareMetalMachineList represents a list of bare metal machines.
 */
model BareMetalMachineList is Azure.Core.Page<BareMetalMachine>;

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
 * BareMetalMachineProperties represents the properties of a bare metal machine.
 */
model BareMetalMachineProperties {
  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  machineRoles?: string[];

  /**
   * The unique internal identifier of the bare metal machine SKU.
   */
  machineSkuId: string;

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
   * The provisioning state of the bare metal machine.
   */
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #["secretType"])
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
  @visibility(Lifecycle.Read)
  serviceTag?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of the resource IDs for the VirtualMachines that are hosted on this bare metal machine.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];
}

/**
 * AdministrativeCredentials represents the admin credentials for the device requiring password-based authentication.
 */
model AdministrativeCredentials {
  /**
   * The password of the administrator of the device used during initialization.
   */
  @minLength(1)
  @secret
  password: string;

  /**
   * The username of the administrator of the device used during initialization.
   */
  @minLength(1)
  username: string;
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
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  interfaces?: HardwareInventoryNetworkInterface[];

  /**
   * Field Deprecated. Will be removed in an upcoming version. The list of network interface cards and associated details for the bare metal machine.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
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
 * HardwareValidationStatus represents the latest hardware validation details performed for this bare metal machine.
 */
model HardwareValidationStatus {
  /**
   * The timestamp of the hardware validation execution.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastValidationTime?: utcDateTime;

  /**
   * The outcome of the hardware validation.
   */
  @visibility(Lifecycle.Read)
  result?: BareMetalMachineHardwareValidationResult;
}

/**
 * RuntimeProtectionStatus represents the runtime protection status of the bare metal machine.
 */
model RuntimeProtectionStatus {
  /**
   * The timestamp when the malware definitions were last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  definitionsLastUpdated?: utcDateTime;

  /**
   * The version of the malware definitions.
   */
  @visibility(Lifecycle.Read)
  definitionsVersion?: string;

  /**
   * The timestamp of the most recently completed scan, or empty if there has never been a scan.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanCompletedTime?: utcDateTime;

  /**
   * The timestamp of the most recently scheduled scan, or empty if no scan has been scheduled.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanScheduledTime?: utcDateTime;

  /**
   * The timestamp of the most recently started scan, or empty if there has never been a scan.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scanStartedTime?: utcDateTime;
}

/**
 * SecretRotationStatus represents the status of a secret rotation.
 */
model SecretRotationStatus {
  /**
   * The maximum number of days the secret may be used before it must be changed.
   */
  @visibility(Lifecycle.Read)
  expirePeriodDays?: int64;

  /**
   * The date and time when the secret was last changed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastRotationTime?: utcDateTime;

  /**
   * The number of days a secret exists before rotations will be attempted.
   */
  @visibility(Lifecycle.Read)
  rotationPeriodDays?: int64;

  /**
   * The reference to the secret in a key vault.
   */
  @visibility(Lifecycle.Read)
  secretArchiveReference?: SecretArchiveReference;

  /**
   * The type name used to identify the purpose of the secret.
   */
  @visibility(Lifecycle.Read)
  secretType?: string;
}

/**
 * SecretArchiveReference represents the reference to a secret in a key vault.
 */
model SecretArchiveReference {
  /**
   * The resource ID of the key vault containing the secret.
   */
  @visibility(Lifecycle.Read)
  keyVaultId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults";
    }
  ]>;

  /**
   * The name of the secret in the key vault.
   */
  @visibility(Lifecycle.Read)
  secretName?: string;

  /**
   * The version of the secret in the key vault.
   */
  @visibility(Lifecycle.Read)
  secretVersion?: string;
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  additionalEgressEndpoints?: EgressEndpoint[];

  /**
   * The list of resource IDs for the other Microsoft.NetworkCloud resources that have attached this network.
   */
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this cloud services network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the cloud services network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: CloudServicesNetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The indicator of whether the platform default endpoints are allowed for the egress traffic.
   */
  enableDefaultEgressEndpoints?: CloudServicesNetworkEnableDefaultEgressEndpoints = CloudServicesNetworkEnableDefaultEgressEndpoints.True;

  /**
   * The full list of additional and default egress endpoints that are currently enabled.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  enabledEgressEndpoints?: EgressEndpoint[];

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this cloud services network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * The name of the interface that will be present in the virtual machine to represent this network.
   */
  @visibility(Lifecycle.Read)
  interfaceName?: string;

  /**
   * The provisioning state of the cloud services network.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CloudServicesNetworkProvisioningState;

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
  @OpenAPI.extension("x-ms-identifiers", #[])
  @minItems(1)
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
   * Field deprecated, this value will no longer influence the cluster manager allocation process and will be removed in a future version. The Azure availability zones within the region that will be used to support the cluster manager resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  availabilityZones?: string[];

  /**
   * The list of the cluster versions the manager supports. It is used as input in clusterVersion property of a cluster resource.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["targetClusterVersion"])
  clusterVersions?: ClusterAvailableVersion[];

  /**
   * The detailed status that provides additional information about the cluster manager.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: ClusterManagerDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The resource ID of the fabric controller that has one to one mapping with the cluster manager.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fabricControllerId: Azure.Core.armResourceIdentifier;

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
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterManagerProvisioningState;

  /**
   * Field deprecated, this value will no longer influence the cluster manager allocation process and will be removed in a future version. The size of the Azure virtual machines to use for hosting the cluster manager resource.
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
  @visibility(Lifecycle.Read)
  supportExpiryDate?: string;

  /**
   * The version of the cluster to be deployed.
   */
  @visibility(Lifecycle.Read)
  targetClusterVersion?: string;
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
 * ClusterList represents a list of clusters.
 */
model ClusterList is Azure.Core.Page<Cluster>;

/**
 * ClusterProperties represents the properties of a cluster.
 */
model ClusterProperties {
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
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["targetClusterVersion"])
  availableUpgradeVersions?: ClusterAvailableUpgradeVersion[];

  /**
   * The capacity supported by this cluster.
   */
  @visibility(Lifecycle.Read)
  clusterCapacity?: ClusterCapacity;

  /**
   * The latest heartbeat status between the cluster manager and the cluster.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  clusterManagerConnectionStatus?: ClusterManagerConnectionStatus;

  /**
   * The resource ID of the cluster manager that manages this cluster. This is set by the Cluster Manager when the cluster is created.
   */
  @visibility(Lifecycle.Read)
  clusterManagerId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/clusterManagers";
    }
  ]>;

  /**
   * The service principal to be used by the cluster during Arc Appliance installation.
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
   * The list of rack definitions for the compute racks in a multi-rack
   * cluster, or an empty list in a single-rack cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", #["networkRackId"])
  computeRackDefinitions?: RackDefinition[];

  /**
   * The current detailed status of the cluster.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: ClusterDetailedStatus;

  /**
   * The descriptive message about the detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. This field will not be populated in an upcoming version. The extended location (custom location) that represents the Hybrid AKS control plane location. This extended location is used when creating provisioned clusters (Hybrid AKS clusters).
   */
  @visibility(Lifecycle.Read)
  hybridAksExtendedLocation?: ExtendedLocation;

  /**
   * The configuration of the managed resource group associated with the resource.
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * The count of Manual Action Taken (MAT) events that have not been validated.
   */
  @visibility(Lifecycle.Read)
  manualActionCount?: int64;

  /**
   * The resource ID of the Network Fabric associated with the cluster.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkFabricId: Azure.Core.armResourceIdentifier;

  /**
   * The provisioning state of the cluster.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  storageApplianceConfigurationData?: StorageApplianceConfigurationData[];
}

/**
 * BareMetalMachineConfigurationData represents configuration for the bare metal machine.
 */
model BareMetalMachineConfigurationData {
  /**
   * The connection string for the baseboard management controller including IP address and protocol.
   */
  @visibility(Lifecycle.Read)
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
   * The user-provided name for the bare metal machine created from this specification.
   * If not provided, the machine name will be generated programmatically.
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier | null;
}

/**
 * ClusterAvailableUpgradeVersion represents the various cluster upgrade parameters.
 */
model ClusterAvailableUpgradeVersion {
  /**
   * The indicator of whether the control plane will be impacted during the upgrade.
   */
  @visibility(Lifecycle.Read)
  controlImpact?: ControlImpact;

  /**
   * The expected duration needed for this upgrade.
   */
  @visibility(Lifecycle.Read)
  expectedDuration?: string;

  /**
   * The impact description including the specific details and release notes.
   */
  @visibility(Lifecycle.Read)
  impactDescription?: string;

  /**
   * The last date the version of the platform is supported.
   */
  @visibility(Lifecycle.Read)
  supportExpiryDate?: string;

  /**
   * The target version this cluster will be upgraded to.
   */
  @visibility(Lifecycle.Read)
  targetClusterVersion?: string;

  /**
   * The indicator of whether the workload will be impacted during the upgrade.
   */
  @visibility(Lifecycle.Read)
  workloadImpact?: WorkloadImpact;
}

/**
 * ClusterCapacity represents various details regarding compute capacity.
 */
model ClusterCapacity {
  /**
   * The remaining appliance-based storage in GB available for workload use. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availableApplianceStorageGB?: int64;

  /**
   * The remaining number of cores that are available in this cluster for workload use.
   */
  availableCoreCount?: int64;

  /**
   * The remaining machine or host-based storage in GB available for workload use. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availableHostStorageGB?: int64;

  /**
   * The remaining memory in GB that are available in this cluster for workload use. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availableMemoryGB?: int64;

  /**
   * The total appliance-based storage in GB supported by this cluster for workload use. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  totalApplianceStorageGB?: int64;

  /**
   * The total number of cores that are supported by this cluster for workload use.
   */
  totalCoreCount?: int64;

  /**
   * The total machine or host-based storage in GB supported by this cluster for workload use. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  totalHostStorageGB?: int64;

  /**
   * The total memory supported by this cluster for workload use. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @secret
  password: string;

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
  @minValue(0)
  value: int64;
}

/**
 * RuntimeProtectionConfiguration represents the runtime protection configuration for the cluster.
 */
model RuntimeProtectionConfiguration {
  /**
   * The mode of operation for runtime protection.
   */
  enforcementLevel?: RuntimeProtectionEnforcementLevel = RuntimeProtectionEnforcementLevel.Disabled;
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
   * The maximum number of worker nodes that can be offline within the increment of update, e.g., rack-by-rack.
   * Limited by the maximum number of machines in the increment. Defaults to the whole increment size.
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
  @minValue(0)
  thresholdValue: int64;

  /**
   * The time to wait between the increments of update defined by the strategy.
   */
  @maxValue(60)
  @minValue(0)
  waitTimeMinutes?: int64 = 15;
}

/**
 * VulnerabilityScanningSettings represents the settings for how security vulnerability scanning is applied to the cluster.
 */
model VulnerabilityScanningSettings {
  /**
   * The mode selection for container vulnerability scanning.
   */
  containerScan?: VulnerabilityScanningSettingsContainerScan = VulnerabilityScanningSettingsContainerScan.Enabled;
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
  @visibility(Lifecycle.Read)
  attachedNetworkIds?: string[];

  /**
   * The list of versions that this Kubernetes cluster can be upgraded to.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  availableUpgrades?: AvailableUpgrade[];

  /**
   * The resource ID of the Network Cloud cluster.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource ID of the connected cluster set up when this Kubernetes cluster is created.
   */
  @visibility(Lifecycle.Read)
  connectedClusterId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters";
    }
  ]>;

  /**
   * The current running version of Kubernetes on the control plane.
   */
  @visibility(Lifecycle.Read)
  controlPlaneKubernetesVersion?: string;

  /**
   * The defining characteristics of the control plane for this Kubernetes Cluster.
   */
  controlPlaneNodeConfiguration: ControlPlaneNodeConfiguration;

  /**
   * The current status of the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: KubernetesClusterDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The current feature settings.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  featureStatuses?: FeatureStatus[];

  /**
   * The agent pools that are created with this Kubernetes cluster for running critical system services and workloads. This data in this field is only used during creation, and the field will be empty following the creation of the Kubernetes Cluster. After creation, the management of agent pools is done using the agentPools sub-resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  @minItems(1)
  initialAgentPoolConfigurations: InitialAgentPoolConfiguration[];

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
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  nodes?: KubernetesClusterNode[];

  /**
   * The provisioning state of the Kubernetes cluster resource.
   */
  @visibility(Lifecycle.Read)
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
  @minItems(1)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  availabilityLifecycle?: AvailabilityLifecycle;

  /**
   * The version available for upgrading.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  detailedStatus?: FeatureDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The name of the feature.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The version of the feature.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l2Networks?: L2NetworkAttachmentConfiguration[];

  /**
   * The list of Layer 3 Networks and related configuration for attachment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  l3Networks?: L3NetworkAttachmentConfiguration[];

  /**
   * The list of Trunked Networks and related configuration for attachment.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  pluginType?: KubernetesPluginType = KubernetesPluginType.SRIOV;
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
  pluginType?: KubernetesPluginType = KubernetesPluginType.SRIOV;
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
  pluginType?: KubernetesPluginType = KubernetesPluginType.SRIOV;
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  bgpAdvertisements?: BgpAdvertisement[];

  /**
   * The list of additional BgpPeer entities that the Kubernetes cluster will peer with. All peering must be explicitly defined.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  bfdEnabled?: BfdEnabled = BfdEnabled.False;

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
  @minValue(0)
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
  @secret
  password?: string;

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
  @minValue(0)
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
  autoAssign?: BfdEnabled = BfdEnabled.True;

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
  onlyUseHostIps?: BfdEnabled = BfdEnabled.True;
}

/**
 * L2ServiceLoadBalancerConfiguration represents the configuration of a layer 2 service load balancer.
 */
model L2ServiceLoadBalancerConfiguration {
  /**
   * The list of pools of IP addresses that can be allocated to load balancer services.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipAddressPools?: IpAddressPool[];
}

/**
 * KubernetesClusterNode represents the details of a node in a Kubernetes cluster.
 */
model KubernetesClusterNode {
  /**
   * The resource ID of the agent pool that this node belongs to. This value is not represented on control plane nodes.
   */
  @visibility(Lifecycle.Read)
  agentPoolId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/kubernetesClusters/agentPools";
    }
  ]>;

  /**
   * The availability zone this node is running within.
   */
  @visibility(Lifecycle.Read)
  availabilityZone?: string;

  /**
   * The resource ID of the bare metal machine that hosts this node.
   */
  @visibility(Lifecycle.Read)
  bareMetalMachineId?: Azure.Core.armResourceIdentifier;

  /**
   * The number of CPU cores configured for this node, derived from the VM SKU specified.
   */
  @visibility(Lifecycle.Read)
  cpuCores?: int64;

  /**
   * The detailed state of this node.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: KubernetesClusterNodeDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The size of the disk configured for this node. Allocations are measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  diskSizeGB?: int64;

  /**
   * The machine image used to deploy this node.
   */
  @visibility(Lifecycle.Read)
  image?: string;

  /**
   * The currently running version of Kubernetes and bundled features running on this node.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * The list of labels on this node that have been assigned to the agent pool containing this node.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  labels?: KubernetesLabel[];

  /**
   * The amount of memory configured for this node, derived from the vm SKU specified. Allocations are measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memorySizeGB?: int64;

  /**
   * The mode of the agent pool containing this node. Not applicable for control plane nodes.
   */
  @visibility(Lifecycle.Read)
  mode?: AgentPoolMode;

  /**
   * The name of this node, as realized in the Kubernetes cluster.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The NetworkAttachments made to this node.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["networkAttachmentName"])
  networkAttachments?: NetworkAttachment[];

  /**
   * The power state of this node.
   */
  @visibility(Lifecycle.Read)
  powerState?: KubernetesNodePowerState;

  /**
   * The role of this node in the cluster.
   */
  @visibility(Lifecycle.Read)
  role?: KubernetesNodeRole;

  /**
   * The list of taints that have been assigned to the agent pool containing this node.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  taints?: KubernetesLabel[];

  /**
   * The VM SKU name that was used to create this cluster node.
   */
  @visibility(Lifecycle.Read)
  vmSkuName?: string;
}

/**
 * NetworkAttachment represents the single network attachment.
 */
model NetworkAttachment {
  /**
   * The resource ID of the associated network attached to the virtual machine.
   * It can be one of cloudServicesNetwork, l3Network, l2Network or trunkedNetwork resources.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  attachedNetworkId: Azure.Core.armResourceIdentifier;

  /**
   * The indicator of whether this is the default gateway.
   * Only one of the attached networks (including the CloudServicesNetwork attachment) for a single machine may be specified as True.
   */
  defaultGateway?: DefaultGateway;

  /**
   * The IP allocation mechanism for the virtual machine.
   * Dynamic and Static are only valid for l3Network which may also specify Disabled.
   * Otherwise, Disabled is the only permitted value.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipAllocationMethod: VirtualMachineIPAllocationMethod;

  /**
   * The IPv4 address of the virtual machine.
   *
   * This field is used only if the attached network has IPAllocationType of IPV4 or DualStack.
   *
   * If IPAllocationMethod is:
   * Static - this field must contain a user specified IPv4 address from within the subnet specified in the attached network.
   * Dynamic - this field is read-only, but will be populated with an address from within the subnet specified in the attached network.
   * Disabled - this field will be empty.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4Address?: string;

  /**
   * The IPv6 address of the virtual machine.
   *
   * This field is used only if the attached network has IPAllocationType of IPV6 or DualStack.
   *
   * If IPAllocationMethod is:
   * Static - this field must contain an IPv6 address range from within the range specified in the attached network.
   * Dynamic - this field is read-only, but will be populated with an range from within the subnet specified in the attached network.
   * Disabled - this field will be empty.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv6Address?: string;

  /**
   * The MAC address of the interface for the virtual machine that corresponds to this network attachment.
   */
  @visibility(Lifecycle.Read)
  macAddress?: string;

  /**
   * The associated network's interface name.
   * If specified, the network attachment name has a maximum length of 15 characters and must be unique to this virtual machine.
   * If the user doesn’t specify this value, the default interface name of the network resource will be used.
   * For a CloudServicesNetwork resource, this name will be ignored.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(15)
  networkAttachmentName?: string;
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
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this L2 network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the L2 network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: L2NetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource ID(s) that are associated with this L2 network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType = HybridAksPluginType.SRIOV;

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
  @visibility(Lifecycle.Read)
  provisioningState?: L2NetworkProvisioningState;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource ID(s), excluding any Hybrid AKS virtual machines, that are currently using this L2 network.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this L3 network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the L3 network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: L3NetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this L3 network.
   */
  @visibility(Lifecycle.Read)
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
  hybridAksPluginType?: HybridAksPluginType = HybridAksPluginType.SRIOV;

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
   * The IPV4 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type
   * is IPV4 or DualStack.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  ipv4ConnectedPrefix?: string;

  /**
   * The IPV6 prefix (CIDR) assigned to this L3 network. Required when the IP allocation type
   * is IPV6 or DualStack.
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
  @visibility(Lifecycle.Read)
  provisioningState?: L3NetworkProvisioningState;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this L3 network.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  computeMachines?: MachineSkuSlot[];

  /**
   * The list of machine SKUs and associated rack slot for the control-plane dedicated machines in this rack model.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  controllerMachines?: MachineSkuSlot[];

  /**
   * The free-form text describing the rack.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The maximum number of compute racks supported by an aggregator rack. 0 if this is a compute rack or a rack for a single rack cluster(rackType="Single").
   */
  @visibility(Lifecycle.Read)
  maxClusterSlots?: int64;

  /**
   * The provisioning state of the rack SKU resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: RackSkuProvisioningState;

  /**
   * The type of the rack.
   */
  @visibility(Lifecycle.Read)
  rackType?: RackSkuType;

  /**
   * The list of appliance SKUs and associated rack slot for the storage appliance(s) in this rack model.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  storageAppliances?: StorageApplianceSkuSlot[];

  /**
   * The list of supported SKUs if the rack is an aggregator.
   */
  @visibility(Lifecycle.Read)
  supportedRackSkuIds?: string[];
}

/**
 * MachineSkuSlot represents a single SKU and rack slot associated with the machine.
 */
model MachineSkuSlot {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: MachineSkuProperties;

  /**
   * The position in the rack for the machine.
   */
  @visibility(Lifecycle.Read)
  rackSlot?: int64;
}

/**
 * MachineSkuProperties represents the properties of the machine SKU.
 */
model MachineSkuProperties {
  /**
   * The type of bootstrap protocol used.
   */
  @visibility(Lifecycle.Read)
  bootstrapProtocol?: BootstrapProtocol;

  /**
   * The count of CPU cores for this machine.
   */
  @visibility(Lifecycle.Read)
  cpuCores?: int64;

  /**
   * The count of CPU sockets for this machine.
   */
  @visibility(Lifecycle.Read)
  cpuSockets?: int64;

  /**
   * The list of disks.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  disks?: MachineDisk[];

  /**
   * The generation of the architecture.
   */
  @visibility(Lifecycle.Read)
  generation?: string;

  /**
   * The hardware version of the machine.
   */
  @visibility(Lifecycle.Read)
  hardwareVersion?: string;

  /**
   * The maximum amount of memory. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memoryCapacityGB?: int64;

  /**
   * The model of the machine.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The list of network interfaces.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  networkInterfaces?: NetworkInterface[];

  /**
   * The count of SMT and physical core threads for this machine.
   */
  @visibility(Lifecycle.Read)
  totalThreads?: int64;

  /**
   * The make of the machine.
   */
  @visibility(Lifecycle.Read)
  vendor?: string;
}

/**
 * Disk represents the properties of the disk.
 */
model MachineDisk {
  /**
   * The maximum amount of storage. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  capacityGB?: int64;

  /**
   * The connection type of the rack SKU resource.
   */
  @visibility(Lifecycle.Read)
  connection?: MachineSkuDiskConnectionType;

  /**
   * The disk type of rack SKU resource.
   */
  @visibility(Lifecycle.Read)
  type?: DiskType;
}

/**
 * NetworkInterface represents properties of the network interface.
 */
model NetworkInterface {
  /**
   * The partial address of Peripheral Component Interconnect (PCI).
   */
  @visibility(Lifecycle.Read)
  address?: string;

  /**
   * The connection type of the device.
   */
  @visibility(Lifecycle.Read)
  deviceConnectionType?: DeviceConnectionType;

  /**
   * The model name of the device.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The physical slot for this device.
   */
  @visibility(Lifecycle.Read)
  physicalSlot?: int64;

  /**
   * The number of ports on the device.
   */
  @visibility(Lifecycle.Read)
  portCount?: int64;

  /**
   * The maximum amount of data in gigabits that the line card transmits through a port at any given second.
   */
  @visibility(Lifecycle.Read)
  portSpeed?: int64;

  /**
   * The vendor name of the device.
   */
  @visibility(Lifecycle.Read)
  vendor?: string;
}

/**
 * StorageApplianceSkuSlot represents the single SKU and rack slot associated with the storage appliance.
 */
model StorageApplianceSkuSlot {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StorageApplianceSkuProperties;

  /**
   * The position in the rack for the storage appliance.
   */
  @visibility(Lifecycle.Read)
  rackSlot?: int64;
}

/**
 * StorageApplianceSkuProperties represents the properties of the storage appliance SKU.
 */
model StorageApplianceSkuProperties {
  /**
   * The maximum capacity of the storage appliance. Measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  capacityGB?: int64;

  /**
   * The model of the storage appliance.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the rack.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: RackDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The provisioning state of the rack resource.
   */
  @visibility(Lifecycle.Read)
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
   * The total capacity of the storage appliance. Measured in GiB.
   */
  @visibility(Lifecycle.Read)
  capacity?: int64;

  /**
   * The amount of storage consumed.
   */
  @visibility(Lifecycle.Read)
  capacityUsed?: int64;

  /**
   * The resource ID of the cluster this storage appliance is associated with. Measured in GiB.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The detailed status of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: StorageApplianceDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The endpoint for the management interface of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  managementIpv4Address?: string;

  /**
   * The manufacturer of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * The model of the storage appliance.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * The provisioning state of the storage appliance.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  remoteVendorManagementFeature?: RemoteVendorManagementFeature;

  /**
   * The indicator of whether the remote vendor management feature is enabled or disabled, or unsupported if it is an unsupported feature.
   */
  @visibility(Lifecycle.Read)
  remoteVendorManagementStatus?: RemoteVendorManagementStatus;

  /**
   * The list of statuses that represent secret rotation activity.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["secretType"])
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
  @visibility(Lifecycle.Read)
  version?: string;
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
  @visibility(Lifecycle.Read)
  associatedResourceIds?: string[];

  /**
   * The resource ID of the Network Cloud cluster this trunked network is associated with.
   */
  @visibility(Lifecycle.Read)
  clusterId?: Azure.Core.armResourceIdentifier;

  /**
   * The more detailed status of the trunked network.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: TrunkedNetworkDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of Hybrid AKS cluster resource IDs that are associated with this trunked network.
   */
  @visibility(Lifecycle.Read)
  hybridAksClustersAssociatedIds?: string[];

  /**
   * Field Deprecated. The field was previously optional, now it will have no defined behavior and will be ignored. The network plugin type for Hybrid AKS.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hybridAksPluginType?: HybridAksPluginType = HybridAksPluginType.SRIOV;

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
  @minItems(1)
  isolationDomainIds: string[];

  /**
   * The provisioning state of the trunked network.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TrunkedNetworkProvisioningState;

  /**
   * Field Deprecated. These fields will be empty/omitted. The list of virtual machine resource IDs, excluding any Hybrid AKS virtual machines, that are currently using this trunked network.
   */
  @visibility(Lifecycle.Read)
  virtualMachinesAssociatedIds?: string[];

  /**
   * The list of vlans that are selected from the isolation domains for trunking.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minItems(1)
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
  @visibility(Lifecycle.Read)
  availabilityZone?: string;

  /**
   * The resource ID of the bare metal machine that hosts the virtual machine.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  detailedStatus?: VirtualMachineDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * Field Deprecated, the value will be ignored if provided. The indicator of whether one of the specified CPU cores is isolated to run the emulator thread for this virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  isolateEmulatorThread?: VirtualMachineIsolateEmulatorThread = VirtualMachineIsolateEmulatorThread.True;

  /**
   * The memory size of the virtual machine. Allocations are measured in gibibytes.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(1)
  memorySizeGB: int64;

  /**
   * The list of network attachments to the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  networkAttachments?: NetworkAttachment[];

  /**
   * The Base64 encoded cloud-init network data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkData?: string;

  /**
   * The scheduling hints for the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  placementHints?: VirtualMachinePlacementHint[];

  /**
   * The power state of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  powerState?: VirtualMachinePowerState;

  /**
   * The provisioning state of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: VirtualMachineProvisioningState;

  /**
   * The list of ssh public keys. Each key will be added to the virtual machine using the cloud-init ssh_authorized_keys mechanism for the adminUsername.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.extension("x-ms-identifiers", #[])
  sshPublicKeys?: SshPublicKey[];

  /**
   * The storage profile that specifies size and other parameters about the disks related to the virtual machine.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageProfile: StorageProfile;

  /**
   * The Base64 encoded cloud-init user data.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  userData?: string;

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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @secret
  password: string;

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
   * The list of resource IDs that attach the volume. It may include virtual machines and Hybrid AKS clusters.
   */
  @visibility(Lifecycle.Read)
  attachedTo?: string[];

  /**
   * The more detailed status of the volume.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: VolumeDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The provisioning state of the volume.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: VolumeProvisioningState;

  /**
   * The unique identifier of the volume.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * The size of the allocation for this volume in Mebibytes.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @minValue(1)
  sizeMiB: int64;
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
  @minValue(0)
  percentComplete?: float32;

  /**
   * The additional properties of the operation status result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * BareMetalMachinePatchParameters represents the body of the request to patch bare metal machine properties.
 */
model BareMetalMachinePatchParameters {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BareMetalMachinePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * BareMetalMachinePatchProperties represents the properties of the bare metal machine that can be patched.
 */
model BareMetalMachinePatchProperties {
  /**
   * The details provided by the customer during the creation of rack manifests
   * that allows for custom data to be associated with this machine.
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
   * The serial number of the bare metal machine.
   */
  @maxLength(64)
  @minLength(1)
  serialNumber?: string;
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
   * The maximum time the script is allowed to run.
   * If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  @minItems(1)
  commands: BareMetalMachineCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run.
   * If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  @minItems(1)
  commands: BareMetalMachineCommandSpecification[];

  /**
   * The maximum time the commands are allowed to run.
   * If the execution time exceeds the maximum, the script will be stopped, any output produced until then will be captured, and the exit code matching a timeout will be returned (252).
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: CloudServicesNetworkPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * CloudServicesNetworkPatchProperties represents the properties of the cloud services network that can be updated using a patch request.
 */
model CloudServicesNetworkPatchProperties {
  /**
   * The list of egress endpoints. This allows for connection from a Hybrid AKS cluster to the specified endpoint.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  additionalEgressEndpoints?: EgressEndpoint[];

  /**
   * The indicator of whether the platform default endpoints are allowed for the egress traffic.
   */
  enableDefaultEgressEndpoints?: CloudServicesNetworkEnableDefaultEgressEndpoints;
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
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ClusterPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  analyticsOutputSettings?: AnalyticsOutputSettings | null;

  /**
   * The customer-provided location information to identify where the cluster resides.
   */
  clusterLocation?: string;

  /**
   * The service principal to be used by the cluster during Arc Appliance installation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterServicePrincipal?: ServicePrincipalInformation | null;

  /**
   * The settings for commands run in this cluster, such as bare metal machine run read only commands and data extracts.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  commandOutputSettings?: CommandOutputSettings | null;

  /**
   * The validation threshold indicating the allowable failures of compute machines during environment validation and deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  computeDeploymentThreshold?: ValidationThreshold | null;

  /**
   * The list of rack definitions for the compute racks in a multi-rack
   * cluster, or an empty list in a single-rack cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", #["networkRackId"])
  computeRackDefinitions?: RackDefinition[];

  /**
   * The settings for cluster runtime protection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  runtimeProtectionConfiguration?: RuntimeProtectionConfiguration | null;

  /**
   * The configuration for use of a key vault to store secrets for later retrieval by the operator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretArchive?: ClusterSecretArchive | null;

  /**
   * The settings for the secret archive used to hold credentials for the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  secretArchiveSettings?: SecretArchiveSettings | null;

  /**
   * The strategy for updating the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateStrategy?: ClusterUpdateStrategy | null;

  /**
   * The settings for how security vulnerability scanning is applied to the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  vulnerabilityScanningSettings?: VulnerabilityScanningSettingsPatch | null;
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
  @visibility(Lifecycle.Read)
  detailedStatus?: BareMetalMachineKeySetDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
   * The provisioning state of the bare metal machine key set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BareMetalMachineKeySetProvisioningState;

  /**
   * The unique list of permitted users.
   */
  @OpenAPI.extension("x-ms-identifiers", #["azureUserName"])
  userList: KeySetUser[];

  /**
   * The status evaluation of each user.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["azureUserName"])
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
  @visibility(Lifecycle.Read)
  azureUserName?: string;

  /**
   * The indicator of whether the user is currently deployed for access.
   */
  @visibility(Lifecycle.Read)
  status?: BareMetalMachineKeySetUserSetupStatus;

  /**
   * The additional information describing the current status of this user, if any available.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BareMetalMachineKeySetPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @OpenAPI.extension("x-ms-identifiers", #["azureUserName"])
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
  @visibility(Lifecycle.Read)
  detailedStatus?: BmcKeySetDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The date and time after which the users in this key set will be removed from the baseboard management controllers.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiration: utcDateTime;

  /**
   * The last time this key set was validated.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  provisioningState?: BmcKeySetProvisioningState;

  /**
   * The unique list of permitted users.
   */
  @OpenAPI.extension("x-ms-identifiers", #["azureUserName"])
  userList: KeySetUser[];

  /**
   * The status evaluation of each user.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["azureUserName"])
  userListStatus?: KeySetUserStatus[];
}

/**
 * BmcKeySetPatchParameters represents the body of the request to patch the baseboard management controller key set.
 */
model BmcKeySetPatchParameters {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BmcKeySetPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @OpenAPI.extension("x-ms-identifiers", #["azureUserName"])
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
  @visibility(Lifecycle.Read)
  detailedStatus?: ClusterMetricsConfigurationDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The list of metrics that are available for the cluster but disabled at the moment.
   */
  @visibility(Lifecycle.Read)
  disabledMetrics?: string[];

  /**
   * The list of metric names that have been chosen to be enabled in addition to the core set of enabled metrics.
   */
  enabledMetrics?: string[];

  /**
   * The provisioning state of the metrics configuration.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ClusterMetricsConfigurationProvisioningState;
}

/**
 * ClusterMetricsConfigurationPatchParameters represents the body of the request to patch the metrics configuration of cluster.
 */
model ClusterMetricsConfigurationPatchParameters {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ClusterMetricsConfigurationPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: KubernetesClusterPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @OpenAPI.extension("x-ms-identifiers", #["keyData"])
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
  @visibility(Lifecycle.Read)
  detailedStatus?: AgentPoolDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The Kubernetes version running in this agent pool.
   */
  @visibility(Lifecycle.Read)
  kubernetesVersion?: string;

  /**
   * The labels applied to the nodes in this agent pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  provisioningState?: AgentPoolProvisioningState;

  /**
   * The taints applied to the nodes in this agent pool.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AgentPoolPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @OpenAPI.extension("x-ms-identifiers", #["keyData"])
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
  @visibility(Lifecycle.Read)
  availabilityLifecycle?: KubernetesClusterFeatureAvailabilityLifecycle;

  /**
   * The detailed status of the feature.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: KubernetesClusterFeatureDetailedStatus;

  /**
   * The descriptive message for the detailed status of the feature.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The configured options for the feature.
   */
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  options?: StringKeyValuePair[];

  /**
   * The provisioning state of the Kubernetes cluster feature.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: KubernetesClusterFeatureProvisioningState;

  /**
   * The indicator of if the feature is required or optional. Optional features may be deleted by the user, while required features are managed with the kubernetes cluster lifecycle.
   */
  @visibility(Lifecycle.Read)
  required?: KubernetesClusterFeatureRequired;

  /**
   * The version of the feature.
   */
  @visibility(Lifecycle.Read)
  version?: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: KubernetesClusterFeaturePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * KubernetesClusterFeaturePatchProperties represents the Kubernetes cluster feature properties for patching.
 */
model KubernetesClusterFeaturePatchProperties {
  /**
   * The configured options for the feature.
   */
  @OpenAPI.extension("x-ms-identifiers", #["key"])
  options?: StringKeyValuePair[];
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
 * L2NetworkPatchParameters represents the body of the request to patch the L2 network.
 */
model L2NetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * L3NetworkPatchParameters represents the body of the request to patch the cloud services network.
 */
model L3NetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * RackPatchParameters represents the body of the request to patch the rack properties.
 */
model RackPatchParameters {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: RacksPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: StorageAppliancePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * TrunkedNetworkPatchParameters represents the body of the request to patch the Trunked network.
 */
model TrunkedNetworkPatchParameters {
  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * VirtualMachinePatchParameters represents the body of the request to patch the virtual machine.
 */
model VirtualMachinePatchParameters {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: VirtualMachinePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @visibility(Lifecycle.Read)
  detailedStatus?: ConsoleDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
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
   * The resource ID of the private link service that is used to provide virtual machine console access.
   */
  @visibility(Lifecycle.Read)
  privateLinkServiceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateLinkServices";
    }
  ]>;

  /**
   * The provisioning state of the virtual machine console.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ConsoleProvisioningState;

  /**
   * The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
   */
  sshPublicKey: SshPublicKey;

  /**
   * The unique identifier for the virtual machine that is used to access the console.
   */
  @visibility(Lifecycle.Read)
  virtualMachineAccessId?: string;
}

/**
 * ConsolePatchParameters represents the body of the request to patch the virtual machine console.
 */
model ConsolePatchParameters {
  /**
   * The list of the resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: ConsolePatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}
