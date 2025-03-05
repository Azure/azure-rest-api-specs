import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceFabric;

/**
 * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.
 */
union FailureAction {
  string,

  /**
   * Indicates that a rollback of the upgrade will be performed by Service Fabric if the upgrade fails.
   */
  Rollback: "Rollback",

  /**
   * Indicates that a manual repair will need to be performed by the administrator if the upgrade fails. Service Fabric will not proceed to the next upgrade domain automatically.
   */
  Manual: "Manual",
}

/**
 * The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.
 */
union RollingUpgradeMode {
  string,

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 0.
   */
  Monitored: "Monitored",

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 1.
   */
  UnmonitoredAuto: "UnmonitoredAuto",
}

/**
 * The kind of service (Stateless or Stateful).
 */
union ServiceKind {
  string,

  /**
   * Does not use Service Fabric to make its state highly available or reliable. The value is 0.
   */
  Stateless: "Stateless",

  /**
   * Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 1.
   */
  Stateful: "Stateful",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union PartitionScheme {
  string,

  /**
   * Indicates that the partition is based on string names, and is a SingletonPartitionScheme object, The value is 0.
   */
  Singleton: "Singleton",

  /**
   * Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionScheme object. The value is 1.
   */
  UniformInt64Range: "UniformInt64Range",

  /**
   * Indicates that the partition is based on string names, and is a NamedPartitionScheme object. The value is 2.
   */
  Named: "Named",
}

/**
 * The activation Mode of the service package
 */
union ServicePackageActivationMode {
  string,

  /**
   * Indicates the application package activation mode will use shared process.
   */
  SharedProcess: "SharedProcess",

  /**
   * Indicates the application package activation mode will use exclusive process.
   */
  ExclusiveProcess: "ExclusiveProcess",
}

/**
 * The service correlation scheme.
 */
union ServiceCorrelationScheme {
  string,

  /**
   * Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 0.
   */
  AlignedAffinity: "AlignedAffinity",

  /**
   * Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 1.
   */
  NonAlignedAffinity: "NonAlignedAffinity",
}

/**
 * Determines the metric weight relative to the other metrics that are configured for this service. During runtime, if two metrics end up in conflict, the Cluster Resource Manager prefers the metric with the higher weight.
 */
union ServiceLoadMetricWeight {
  string,

  /**
   * Disables resource balancing for this metric. This value is zero.
   */
  Zero: "Zero",

  /**
   * Specifies the metric weight of the service load as Low. The value is 1.
   */
  Low: "Low",

  /**
   * Specifies the metric weight of the service load as Medium. The value is 2.
   */
  Medium: "Medium",

  /**
   * Specifies the metric weight of the service load as High. The value is 3.
   */
  High: "High",
}

/**
 * The type of placement policy for a service fabric service. Following are the possible values.
 */
union ServicePlacementPolicyType {
  string,

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 0.
   */
  InvalidDomain: "InvalidDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 1.
   */
  RequiredDomain: "RequiredDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 2.
   */
  PreferredPrimaryDomain: "PreferredPrimaryDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 3.
   */
  RequiredDomainDistribution: "RequiredDomainDistribution",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 4.
   */
  NonPartiallyPlaceService: "NonPartiallyPlaceService",
}

/**
 * Specifies the move cost for the service.
 */
union MoveCost {
  string,

  /**
   * Zero move cost. This value is zero.
   */
  Zero: "Zero",

  /**
   * Specifies the move cost of the service as Low. The value is 1.
   */
  Low: "Low",

  /**
   * Specifies the move cost of the service as Medium. The value is 2.
   */
  Medium: "Medium",

  /**
   * Specifies the move cost of the service as High. The value is 3.
   */
  High: "High",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union ServiceScalingMechanismKind {
  string,

  /**
   * Represents a scaling mechanism for adding or removing instances of stateless service partition. The value is 0.
   */
  ScalePartitionInstanceCount: "ScalePartitionInstanceCount",

  /**
   * Represents a scaling mechanism for adding or removing named partitions of a stateless service. The value is 1.
   */
  AddRemoveIncrementalNamedPartition: "AddRemoveIncrementalNamedPartition",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union ServiceScalingTriggerKind {
  string,

  /**
   * Represents a scaling trigger related to an average load of a metric/resource of a partition. The value is 0.
   */
  AveragePartitionLoadTrigger: "AveragePartitionLoadTrigger",

  /**
   * Represents a scaling policy related to an average load of a metric/resource of a service. The value is 1.
   */
  AverageServiceLoadTrigger: "AverageServiceLoadTrigger",
}

/**
 * Cluster operating system, the default will be Windows
 */
union OsType {
  string,

  /**
   * Indicates os is Windows.
   */
  Windows: "Windows",
}

/**
 * The current state of the cluster.
 *
 */
union ClusterState {
  string,

  /**
   * Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
   */
  WaitingForNodes: "WaitingForNodes",

  /**
   * Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
   */
  Deploying: "Deploying",

  /**
   * Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
   */
  BaselineUpgrade: "BaselineUpgrade",

  /**
   * Indicates that the cluster is being upgraded with the user provided configuration.
   */
  Upgrading: "Upgrading",

  /**
   * Indicates that the last upgrade for the cluster has failed.
   */
  UpgradeFailed: "UpgradeFailed",

  /**
   * Indicates that the cluster is in a stable state.
   */
  Ready: "Ready",
}

/**
 * The reference to the transport protocol used by the load balancing rule.
 */
union Protocol {
  string,

  /**
   * Transport protocol is TCP.
   */
  tcp: "tcp",

  /**
   * Transport protocol is UDP.
   */
  udp: "udp",
}

/**
 * The reference to the load balancer probe used by the load balancing rule.
 */
union ProbeProtocol {
  string,

  /**
   * Probe protocol is TCP.
   */
  tcp: "tcp",

  /**
   * Probe protocol is HTTP.
   */
  http: "http",

  /**
   * Probe protocol is HTTPS.
   */
  https: "https",
}

/**
 * Network protocol this rule applies to.
 */
union NsgProtocol {
  string,

  /**
   * Protocol applies to HTTP.
   */
  http: "http",

  /**
   * Protocol applies to HTTPS.
   */
  https: "https",

  /**
   * Protocol applies to TCP.
   */
  tcp: "tcp",

  /**
   * Protocol applies to UDP.
   */
  udp: "udp",

  /**
   * Protocol applies to ICMP.
   */
  icmp: "icmp",

  /**
   * Protocol applies to AH.
   */
  ah: "ah",

  /**
   * Protocol applies to ESP.
   */
  esp: "esp",
}

/**
 * The network traffic is allowed or denied.
 */
union Access {
  string,

  /**
   * The network traffic is allowed.
   */
  allow: "allow",

  /**
   * The network traffic is denied.
   */
  deny: "deny",
}

/**
 * Network security rule direction.
 */
union Direction {
  string,

  /**
   * Inbound direction.
   */
  inbound: "inbound",

  /**
   * Outbound direction.
   */
  outbound: "outbound",
}

/**
 * The provisioning state of the managed resource.
 */
union ManagedResourceProvisioningState {
  string,

  /**
   * The resource does not have a provisioning state.
   */
  None: "None",

  /**
   * The resource is being created.
   */
  Creating: "Creating",

  /**
   * The resource is created.
   */
  Created: "Created",

  /**
   * The resource is being updated.
   */
  Updating: "Updating",

  /**
   * The resource provisioning has succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The resource provisioning has failed.
   */
  Failed: "Failed",

  /**
   * The resource provisioning has been canceled.
   */
  Canceled: "Canceled",

  /**
   * The resource is being deleted.
   */
  Deleting: "Deleting",

  /**
   * The resource has been deleted.
   */
  Deleted: "Deleted",

  /**
   * The resource provisioning state is a state other than the previously specified states.
   */
  Other: "Other",
}

/**
 * The upgrade mode of the cluster when new Service Fabric runtime version is available.
 *
 */
union ClusterUpgradeMode {
  string,

  /**
   * The cluster will be automatically upgraded to the latest Service Fabric runtime version, **clusterUpgradeCadence** will determine when the upgrade starts after the new version becomes available.
   */
  Automatic: "Automatic",

  /**
   * The cluster will not be automatically upgraded to the latest Service Fabric runtime version. The cluster is upgraded by setting the **clusterCodeVersion** property in the cluster resource.
   */
  Manual: "Manual",
}

/**
 * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0.
 */
union ClusterUpgradeCadence {
  string,

  /**
   * Cluster upgrade starts immediately after a new version is rolled out. Recommended for Test/Dev clusters.
   */
  Wave0: "Wave0",

  /**
   * Cluster upgrade starts 7 days after a new version is rolled out. Recommended for Pre-prod clusters.
   */
  Wave1: "Wave1",

  /**
   * Cluster upgrade starts 14 days after a new version is rolled out. Recommended for Production clusters.
   */
  Wave2: "Wave2",
}

/**
 * Available cluster add-on features
 */
union ManagedClusterAddOnFeature {
  string,

  /**
   * Dns service
   */
  DnsService: "DnsService",

  /**
   * Backup and restore service
   */
  BackupRestoreService: "BackupRestoreService",

  /**
   * Resource monitor service
   */
  ResourceMonitorService: "ResourceMonitorService",
}

/**
 * Enable or Disable apply network policies on private end point in the subnet.
 */
union PrivateEndpointNetworkPolicies {
  string,

  /**
   * Enable apply network policies on private end point in the subnet.
   */
  enabled: "enabled",

  /**
   * Disable apply network policies on private end point in the subnet.
   */
  disabled: "disabled",
}

/**
 * Enable or Disable apply network policies on private link service in the subnet.
 */
union PrivateLinkServiceNetworkPolicies {
  string,

  /**
   * Enable apply network policies on private link service in the subnet.
   */
  enabled: "enabled",

  /**
   * Disable apply network policies on private link service in the subnet.
   */
  disabled: "disabled",
}

/**
 * Indicates the update mode for Cross Az clusters.
 */
union ZonalUpdateMode {
  string,

  /**
   * The cluster will use 5 upgrade domains for Cross Az Node types.
   */
  Standard: "Standard",

  /**
   * The cluster will use a maximum of 3 upgrade domains per zone instead of 5 for Cross Az Node types for faster deployments.
   */
  Fast: "Fast",
}

/**
 * This enum is the entrypoint to using a certificate from a public CA for your cluster. This property was introduced to solve the
 * domain squatting problem with new domains. A domain name will be generated in the following format: {clustername}.{hash}.{regionname}.sfmcdomain.
 * The hash portion comes from Azure DNS' Deterministic Name Library. The library creates a hash using the cluster's Tenant, Subscription, Resource Group
 * and Resource Name using the AutoGeneratedDomainNameLabelScope/reuse policy chosen.
 *
 */
union AutoGeneratedDomainNameLabelScope {
  string,

  /**
   * TenantReuse allows for the same hash to be created if the resource is created in the same Tenant with the same resource name.
   */
  TenantReuse: "TenantReuse",

  /**
   * SubscriptionReuse allows for the same hash to be created if the resource is created in the same Subscription with the same resource name.
   */
  SubscriptionReuse: "SubscriptionReuse",

  /**
   * ResourceGroupReuse allows for the same hash to be created if the resource is created in the same Resource Group with the same resource name.
   */
  ResourceGroupReuse: "ResourceGroupReuse",

  /**
   * NoReuse will create a new hash regardless of the Subscription, Resource Group, Tenant and Resource name.
   */
  NoReuse: "NoReuse",
}

/**
 * Sku Name.
 */
union SkuName {
  string,

  /**
   * Basic requires a minimum of 3 nodes and allows only 1 node type.
   */
  Basic: "Basic",

  /**
   * Requires a minimum of 5 nodes and allows 1 or more node type.
   */
  Standard: "Standard",
}

/**
 * Fault simulation status.
 */
union FaultSimulationStatus {
  string,

  /**
   * Indicates the fault simulation is starting. The simulation will have this status while the start operation is in progress.
   */
  Starting: "Starting",

  /**
   * Indicates the fault simulation is active. The simulation will have this status after the start operation has completed successfully.
   */
  Active: "Active",

  /**
   * Indicates the fault simulation is stopping. The simulation will have this status while the stop operation is in progress.
   */
  Stopping: "Stopping",

  /**
   * Indicates the fault simulation is done. The simulation will have this status after the stop operation has completed successfully.
   */
  Done: "Done",

  /**
   * Indicates the fault simulation has failed on start. The simulation will have this status after the start operation fails.
   */
  StartFailed: "StartFailed",

  /**
   * Indicates the fault simulation has failed on stop. The simulation will have this status after the stop operation fails.
   */
  StopFailed: "StopFailed",
}

/**
 * Sfmc operation status.
 */
union SfmcOperationStatus {
  string,

  /**
   * Operation created.
   */
  Created: "Created",

  /**
   * Operation started.
   */
  Started: "Started",

  /**
   * Operation succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Operation failed.
   */
  Failed: "Failed",

  /**
   * Operation aborted.
   */
  Aborted: "Aborted",

  /**
   * Operation canceled.
   */
  Canceled: "Canceled",
}

/**
 * The kind of fault simulation.
 */
union FaultKind {
  string,

  /**
   * Simulates an availability zone down.
   */
  Zone: "Zone",
}

/**
 * Managed data disk type. IOPS and throughput are given by the disk size, to see more information go to https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types.
 *
 */
union DiskType {
  string,

  /**
   * Standard HDD locally redundant storage. Best for backup, non-critical, and infrequent access.
   */
  Standard_LRS: "Standard_LRS",

  /**
   * Standard SSD locally redundant storage. Best for web servers, lightly used enterprise applications and dev/test.
   */
  StandardSSD_LRS: "StandardSSD_LRS",

  /**
   * Premium SSD locally redundant storage. Best for production and performance sensitive workloads.
   */
  Premium_LRS: "Premium_LRS",

  /**
   * Premium SSD V2 locally redundant storage. Best for production and performance sensitive workloads that consistently require low latency and high IOPS and throughput.
   */
  PremiumV2_LRS: "PremiumV2_LRS",

  /**
   * Standard SSD zone redundant storage. Best for web servers, lightly used enterprise applications and dev/test that need storage resiliency against zone failures.
   */
  StandardSSD_ZRS: "StandardSSD_ZRS",

  /**
   * Premium SSD zone redundant storage. Best for production workloads that need storage resiliency against zone failures.
   */
  Premium_ZRS: "Premium_ZRS",
}

/**
 * Vm extension setup order.
 *
 */
union VmssExtensionSetupOrder {
  string,

  /**
   * Indicates that the vm extension should run before the service fabric runtime starts.
   */
  BeforeSFRuntime: "BeforeSFRuntime",
}

/**
 * The IP address type.
 *
 */
union IPAddressType {
  string,

  /**
   * IPv4 address type.
   */
  IPv4: "IPv4",

  /**
   * IPv6 address type.
   */
  IPv6: "IPv6",
}

/**
 * Specifies the eviction policy for virtual machines in a SPOT node type.
 */
union EvictionPolicyType {
  string,

  /**
   * Eviction policy will be Delete for SPOT vms.
   */
  Delete: "Delete",

  /**
   * Eviction policy will be Deallocate for SPOT vms.
   */
  Deallocate: "Deallocate",
}

/**
 * action to be performed on the vms before bootstrapping the service fabric runtime.
 */
union VmSetupAction {
  string,

  /**
   * Enable windows containers feature.
   */
  EnableContainers: "EnableContainers",

  /**
   * Enables windows HyperV feature.
   */
  EnableHyperV: "EnableHyperV",
}

/**
 * Specifies the security type of the nodeType. Only Standard and TrustedLaunch are currently supported
 */
union SecurityType {
  string,

  /**
   * Trusted Launch is a security type that secures generation 2 virtual machines.
   */
  TrustedLaunch: "TrustedLaunch",

  /**
   * Standard is the default security type for all machines.
   */
  Standard: "Standard",
}

/**
 * Specifies whether the IP configuration's private IP is IPv4 or IPv6. Default is IPv4.
 */
union PrivateIPAddressVersion {
  string,

  /**
   * The IP configuration's private IP is IPv4.
   */
  IPv4: "IPv4",

  /**
   * The IP configuration's private IP is IPv6.
   */
  IPv6: "IPv6",
}

/**
 * Specifies whether the IP configuration's public IP is IPv4 or IPv6. Default is IPv4.
 */
union PublicIPAddressVersion {
  string,

  /**
   * The IP configuration's public IP is IPv4.
   */
  IPv4: "IPv4",

  /**
   * The IP configuration's public IP is IPv6.
   */
  IPv6: "IPv6",
}

/**
 * Specifies the way the operation will be performed.
 */
union UpdateType {
  string,

  /**
   * The operation will proceed in all specified nodes at the same time.
   */
  Default: "Default",

  /**
   * The operation will proceed one upgrade domain at a time, checking the health in between each to continue.
   */
  ByUpgradeDomain: "ByUpgradeDomain",
}

/**
 * Node type capacity scale type.
 *
 */
union NodeTypeSkuScaleType {
  string,

  /**
   * Node count is not adjustable in any way (e.g. it is fixed).
   */
  None: "None",

  /**
   * The user must manually scale out/in.
   */
  Manual: "Manual",

  /**
   * Automatic scale is allowed.
   */
  Automatic: "Automatic",
}

/**
 * The mode used to monitor health during a rolling upgrade. The values are UnmonitoredAuto, UnmonitoredManual, Monitored, and UnmonitoredDeferred.
 */
union UpgradeMode {
  string,

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 0
   */
  UnmonitoredAuto: "UnmonitoredAuto",

  /**
   * The upgrade will stop after completing each upgrade domain, giving the opportunity to manually monitor health before proceeding. The value is 1
   */
  UnmonitoredManual: "UnmonitoredManual",

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 2
   */
  Monitored: "Monitored",
}

/**
 * The type of managed identity for the resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Backwards compatibility with existing flag enum"
enum ManagedIdentityType {
  /**
   * Indicates that no identity is associated with the resource.
   */
  None,

  /**
   * Indicates that system assigned identity is associated with the resource.
   */
  SystemAssigned,

  /**
   * Indicates that user assigned identity is associated with the resource.
   */
  UserAssigned,

  /**
   * Indicates that both system assigned and user assigned identity are associated with the resource.
   */
  `SystemAssigned, UserAssigned`,
}

/**
 * The structure of the error.
 */
@error
model ErrorModel {
  /**
   * The error details.
   */
  error?: ErrorModelError;
}

/**
 * The error details.
 */
model ErrorModelError {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Parameters for Resume Upgrade action. The upgrade domain name must be specified.
 */
model RuntimeResumeApplicationUpgradeParameters {
  /**
   * The upgrade domain name. Expected to be the next upgrade domain if the application is upgrading.
   */
  upgradeDomainName?: string;
}

/**
 * The list of application type names.
 */
model ApplicationTypeResourceList is Azure.Core.Page<ApplicationTypeResource>;

/**
 * The application type name properties
 */
model ApplicationTypeResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility("read")
  provisioningState?: string;
}

/**
 * Application type update request
 */
model ApplicationTypeUpdateParameters {
  /**
   * Application type update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}

/**
 * The list of application type version resources for the specified application type name resource.
 */
model ApplicationTypeVersionResourceList
  is Azure.Core.Page<ApplicationTypeVersionResource>;

/**
 * The properties of the application type version resource.
 */
model ApplicationTypeVersionResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility("read")
  provisioningState?: string;

  /**
   * The URL to the application package
   */
  appPackageUrl: string;
}

/**
 * Application type version update request
 */
model ApplicationTypeVersionUpdateParameters {
  /**
   * Application type version update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}

/**
 * The list of application resources.
 */
model ApplicationResourceList is Azure.Core.Page<ApplicationResource>;

/**
 * Describes the managed identities for an Azure resource.
 */
model ManagedIdentity {
  /**
   * The principal id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The type of managed identity for the resource.
   */
  type?: ManagedIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   *
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Backwards compatibility, used to pass user identities"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * User assigned identity.
 */
model UserAssignedIdentity {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * The application resource properties.
 */
model ApplicationResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility("read")
  provisioningState?: string;

  /**
   * The version of the application type as defined in the application manifest.
   * This name must be the full Arm Resource ID for the referenced application type version.
   *
   */
  version?: string;

  /**
   * List of application parameters with overridden values from their default values specified in the application manifest.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  parameters?: Record<string>;

  /**
   * Describes the policy for a monitored application upgrade.
   */
  upgradePolicy?: ApplicationUpgradePolicy;

  /**
   * List of user assigned identities for the application, each mapped to a friendly name.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  managedIdentities?: ApplicationUserAssignedIdentity[];
}

/**
 * Describes the policy for a monitored application upgrade.
 */
model ApplicationUpgradePolicy {
  /**
   * Defines a health policy used to evaluate the health of an application or one of its children entities.
   *
   */
  applicationHealthPolicy?: ApplicationHealthPolicy;

  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean;

  /**
   * The policy used for monitoring the application upgrade
   */
  rollingUpgradeMonitoringPolicy?: RollingUpgradeMonitoringPolicy;

  /**
   * Duration in seconds, to wait before a stateless instance is closed, to allow the active requests to drain gracefully. This would be effective when the instance is closing during the application/cluster upgrade, only for those instances which have a non-zero delay duration configured in the service description.
   */
  instanceCloseDelayDuration?: int64;

  /**
   * The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.
   */
  upgradeMode?: RollingUpgradeMode;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).
   */
  upgradeReplicaSetCheckTimeout?: int64;

  /**
   * Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed.
   */
  recreateApplication?: boolean;
}

/**
 * Defines a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model ApplicationHealthPolicy {
  /**
   * Indicates whether warnings are treated with the same severity as errors.
   */
  considerWarningAsError: boolean;

  /**
   * The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
   * The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
   * This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   */
  maxPercentUnhealthyDeployedApplications: int32;

  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to ServiceTypeHealthPolicy dictionary"
  serviceTypeHealthPolicyMap?: Record<ServiceTypeHealthPolicy>;
}

/**
 * Represents the health policy used to evaluate the health of services belonging to a service type.
 *
 */
model ServiceTypeHealthPolicy {
  /**
   * The maximum allowed percentage of unhealthy services.
   *
   * The percentage represents the maximum tolerated percentage of services that can be unhealthy before the application is considered in error.
   * If the percentage is respected but there is at least one unhealthy service, the health is evaluated as Warning.
   * This is calculated by dividing the number of unhealthy services of the specific service type over the total number of services of the specific service type.
   * The computation rounds up to tolerate one failure on small numbers of services.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyServices: int32;

  /**
   * The maximum allowed percentage of unhealthy partitions per service.
   *
   * The percentage represents the maximum tolerated percentage of partitions that can be unhealthy before the service is considered in error.
   * If the percentage is respected but there is at least one unhealthy partition, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy partitions over the total number of partitions in the service.
   * The computation rounds up to tolerate one failure on small numbers of partitions.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService: int32;

  /**
   * The maximum allowed percentage of unhealthy replicas per partition.
   *
   * The percentage represents the maximum tolerated percentage of replicas that can be unhealthy before the partition is considered in error.
   * If the percentage is respected but there is at least one unhealthy replica, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy replicas over the total number of replicas in the partition.
   * The computation rounds up to tolerate one failure on small numbers of replicas.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyReplicasPerPartition: int32;
}

/**
 * The policy used for monitoring the application upgrade
 */
model RollingUpgradeMonitoringPolicy {
  /**
   * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.
   */
  failureAction: FailureAction;

  /**
   * The amount of time to wait after completing an upgrade domain before applying health policies. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckWaitDuration: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckStableDuration: string;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckRetryTimeout: string;

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  upgradeTimeout: string;

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  upgradeDomainTimeout: string;
}

/**
 * User assigned identity for the application.
 */
model ApplicationUserAssignedIdentity {
  /**
   * The friendly name of user assigned identity.
   */
  name: string;

  /**
   * The principal id of user assigned identity.
   */
  principalId: string;
}

/**
 * Application update request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Not adding identity property as this API is for updating tags only"
model ApplicationUpdateParameters {
  /**
   * Application update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}

/**
 * The list of service resources.
 */
model ServiceResourceList is Azure.Core.Page<ServiceResource>;

/**
 * The service resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Day 0 property, keeping definition as is for backwards compatibility"
@discriminator("serviceKind")
model ServiceResourceProperties extends ServiceResourcePropertiesBase {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Day 0 property, keep as string for backwards compatibility"
  @visibility("read")
  provisioningState?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: ServiceKind;

  /**
   * The name of the service type
   */
  serviceTypeName: string;

  /**
   * Describes how the service is partitioned.
   */
  partitionDescription: Partition;

  /**
   * The activation Mode of the service package
   */
  servicePackageActivationMode?: ServicePackageActivationMode;

  /**
   * Dns name used for the service. If this is specified, then the DNS name can be used to return the IP addresses of service endpoints for application layer protocols (e.g., HTTP).
   * When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
   * When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.
   *
   */
  serviceDnsName?: string;
}

/**
 * Describes how the service is partitioned.
 */
@discriminator("partitionScheme")
model Partition {
  partitionScheme: PartitionScheme;
}

/**
 * The common service resource properties.
 */
model ServiceResourcePropertiesBase {
  /**
   * The placement constraints as a string. Placement constraints are boolean expressions on node properties and allow for restricting a service to particular nodes based on the service requirements. For example, to place a service on nodes where NodeType is blue specify the following: "NodeColor == blue)".
   */
  placementConstraints?: string;

  /**
   * A list that describes the correlation of the service with other services.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  correlationScheme?: ServiceCorrelation[];

  /**
   * The service load metrics is given as an array of ServiceLoadMetric objects.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  serviceLoadMetrics?: ServiceLoadMetric[];

  /**
   * A list that describes the correlation of the service with other services.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  servicePlacementPolicies?: ServicePlacementPolicy[];

  /**
   * Specifies the move cost for the service.
   */
  defaultMoveCost?: MoveCost;

  /**
   * Scaling policies for this service.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  scalingPolicies?: ScalingPolicy[];
}

/**
 * Creates a particular correlation between services.
 */
model ServiceCorrelation {
  /**
   * The ServiceCorrelationScheme which describes the relationship between this service and the service specified via ServiceName.
   */
  scheme: ServiceCorrelationScheme;

  /**
   * The Arm Resource ID of the service that the correlation relationship is established with.
   */
  serviceName: string;
}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ServiceLoadMetric {
  /**
   * The name of the metric. If the service chooses to report load during runtime, the load metric name should match the name that is specified in Name exactly. Note that metric names are case sensitive.
   */
  name: string;

  /**
   * The service load metric relative weight, compared to other metrics configured for this service, as a number.
   */
  weight?: ServiceLoadMetricWeight;

  /**
   * Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Primary replica.
   */
  primaryDefaultLoad?: int32;

  /**
   * Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Secondary replica.
   */
  secondaryDefaultLoad?: int32;

  /**
   * Used only for Stateless services. The default amount of load, as a number, that this service creates for this metric.
   */
  defaultLoad?: int32;
}

/**
 * Describes the policy to be used for placement of a Service Fabric service.
 */
@discriminator("type")
model ServicePlacementPolicy {
  type: ServicePlacementPolicyType;
}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ScalingPolicy {
  /**
   * Specifies the mechanism associated with this scaling policy
   */
  scalingMechanism: ScalingMechanism;

  /**
   * Specifies the trigger associated with this scaling policy.
   */
  scalingTrigger: ScalingTrigger;
}

/**
 * Describes the mechanism for performing a scaling operation.
 */
@discriminator("kind")
model ScalingMechanism {
  kind: ServiceScalingMechanismKind;
}

/**
 * Describes the trigger for performing a scaling operation.
 */
@discriminator("kind")
model ScalingTrigger {
  kind: ServiceScalingTriggerKind;
}

/**
 * Service update request
 */
model ServiceUpdateParameters {
  /**
   * Service update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}

/**
 * Available operation list result
 */
model OperationResult {
  /**
   * The name of the operation.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The object that represents the operation.
   */
  display?: AvailableOperationDisplay;

  /**
   * Origin result
   */
  origin?: string;

  /**
   * The URL to use for getting the next set of results.
   */
  nextLink?: string;
}

/**
 * Operation supported by the Service Fabric resource provider
 */
model AvailableOperationDisplay {
  /**
   * The name of the provider.
   */
  provider?: string;

  /**
   * The resource on which the operation is performed
   */
  resource?: string;

  /**
   * The operation that can be performed.
   */
  operation?: string;

  /**
   * Operation description
   */
  description?: string;
}

/**
 * Describes the result of the request to list Service Fabric resource provider operations.
 */
model OperationListResult is Azure.Core.Page<OperationResult>;

/**
 * The detail of the Service Fabric runtime version result
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource, no provisioning"
model ManagedClusterVersionDetails {
  /**
   * The Service Fabric runtime version of the cluster.
   */
  clusterCodeVersion?: string;

  /**
   * The date of expiry of support of the version.
   */
  supportExpiryUtc?: utcDateTime;

  /**
   * Cluster operating system, the default will be Windows
   */
  osType?: OsType;
}

/**
 * Long running operation result.
 */
model LongRunningOperationResult {
  /**
   * The name of the operation.
   */
  name?: string;

  /**
   * The start time of the operation.
   */
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  endTime?: utcDateTime;

  /**
   * The completion percentage of the operation.
   */
  percentComplete?: float64;

  /**
   * The status of the operation.
   */
  status?: string;

  /**
   * The operation error.
   */
  error?: ErrorModelError;
}

/**
 * VM Sizes properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource, no provisioning"
#suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well known abbreviation"
model VMSize {
  /**
   * VM Size name.
   */
  @visibility("read")
  size?: string;
}

/**
 * Describes the managed cluster resource properties.
 */
model ManagedClusterProperties {
  /**
   * The cluster dns name.
   */
  dnsName: string;

  /**
   * The fully qualified domain name associated with the public load balancer of the cluster.
   */
  @visibility("read")
  fqdn?: string;

  /**
   * The IPv4 address associated with the public load balancer of the cluster.
   */
  @visibility("read")
  ipv4Address?: string;

  /**
   * A service generated unique identifier for the cluster resource.
   */
  @visibility("read")
  clusterId?: string;

  /**
   * The current state of the cluster.
   */
  @visibility("read")
  clusterState?: ClusterState;

  /**
   * List of thumbprints of the cluster certificates.
   */
  @visibility("read")
  clusterCertificateThumbprints?: string[];

  /**
   * The port used for client connections to the cluster.
   */
  clientConnectionPort?: int32 = 19000;

  /**
   * The port used for HTTP connections to the cluster.
   */
  httpGatewayConnectionPort?: int32 = 19080;

  /**
   * VM admin user name.
   */
  adminUserName: string;

  /**
   * VM admin user password.
   */
  @secret
  adminPassword?: string;

  /**
   * Load balancing rules that are applied to the public load balancer of the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  loadBalancingRules?: LoadBalancingRule[];

  /**
   * Setting this to true enables RDP access to the VM. The default NSG rule opens RDP port to Internet which can be overridden with custom Network Security Rules. The default value for this setting is false.
   */
  allowRdpAccess?: boolean;

  /**
   * Custom Network Security Rules that are applied to the Virtual Network of the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  networkSecurityRules?: NetworkSecurityRule[];

  /**
   * Client certificates that are allowed to manage the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  clients?: ClientCertificate[];

  /**
   * The AAD authentication settings of the cluster.
   */
  azureActiveDirectory?: AzureActiveDirectory;

  /**
   * The list of custom fabric settings to configure the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  fabricSettings?: SettingsSectionDescription[];

  /**
   * The provisioning state of the managed cluster resource.
   */
  @visibility("read")
  provisioningState?: ManagedResourceProvisioningState;

  /**
   * The Service Fabric runtime version of the cluster. This property is required when **clusterUpgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](./ClusterVersion.md). To get the list of available version for existing clusters use **availableClusterVersions**.
   */
  clusterCodeVersion?: string;

  /**
   * The upgrade mode of the cluster when new Service Fabric runtime version is available.
   *
   */
  clusterUpgradeMode?: ClusterUpgradeMode = ClusterUpgradeMode.Automatic;

  /**
   * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **clusterUpgradeMode** is set to 'Automatic'.
   */
  clusterUpgradeCadence?: ClusterUpgradeCadence;

  /**
   * List of add-on features to enable on the cluster.
   */
  addonFeatures?: ManagedClusterAddOnFeature[];

  /**
   * Enables automatic OS upgrade for node types created using OS images with version 'latest'. The default value for this setting is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "OS is a well known abbreviation"
  enableAutoOSUpgrade?: boolean;

  /**
   * Indicates if the cluster has zone resiliency.
   */
  zonalResiliency?: boolean = false;

  /**
   * The policy used to clean up unused versions.
   */
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  /**
   * Setting this to true creates IPv6 address space for the default VNet used by the cluster. This setting cannot be changed once the cluster is created. The default value for this setting is false.
   */
  enableIpv6?: boolean;

  /**
   * If specified, the node types for the cluster are created in this subnet instead of the default VNet. The **networkSecurityRules** specified for the cluster are also applied to this subnet. This setting cannot be changed once the cluster is created.
   */
  subnetId?: string;

  /**
   * The list of IP tags associated with the default public IP address of the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipTags?: IpTag[];

  /**
   * IPv6 address for the cluster if IPv6 is enabled.
   */
  @visibility("read")
  ipv6Address?: string;

  /**
   * Setting this to true will link the IPv4 address as the ServicePublicIP of the IPv6 address. It can only be set to True if IPv6 is enabled on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  enableServicePublicIP?: boolean;

  /**
   * Auxiliary subnets for the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  auxiliarySubnets?: Subnet[];

  /**
   * Service endpoints for subnets in the cluster.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  serviceEndpoints?: ServiceEndpoint[];

  /**
   * Indicates the update mode for Cross Az clusters.
   */
  zonalUpdateMode?: ZonalUpdateMode;

  /**
   * For new clusters, this parameter indicates that it uses Bring your own VNet, but the subnet is specified at node type level; and for such clusters, the subnetId property is required for node types.
   */
  useCustomVnet?: boolean;

  /**
   * Specify the resource id of a public IPv4 prefix that the load balancer will allocate a public IPv4 address from. This setting cannot be changed once the cluster is created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPPrefixId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * Specify the resource id of a public IPv6 prefix that the load balancer will allocate a public IPv6 address from. This setting cannot be changed once the cluster is created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPv6PrefixId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * Specify the resource id of a DDoS network protection plan that will be associated with the virtual network of the cluster.
   */
  ddosProtectionPlanId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/ddosProtectionPlans";
    }
  ]>;

  /**
   * The policy to use when upgrading the cluster.
   */
  upgradeDescription?: ClusterUpgradePolicy;

  /**
   * The port used for token-auth based HTTPS connections to the cluster. Cannot be set to the same port as HttpGatewayEndpoint.
   */
  httpGatewayTokenAuthConnectionPort?: int32;

  /**
   * If true, token-based authentication is not allowed on the HttpGatewayEndpoint. This is required to support TLS versions 1.3 and above. If token-based authentication is used, HttpGatewayTokenAuthConnectionPort must be defined.
   */
  enableHttpGatewayExclusiveAuthMode?: boolean;

  /**
   * This property is the entry point to using a public CA cert for your cluster cert. It specifies the level of reuse allowed for the custom FQDN created, matching the subject of the public CA cert.
   */
  autoGeneratedDomainNameLabelScope?: AutoGeneratedDomainNameLabelScope;

  /**
   * The number of outbound ports allocated for SNAT for each node in the backend pool of the default load balancer. The default value is 0 which provides dynamic port allocation based on pool size.
   */
  allocatedOutboundPorts?: int32;
}

/**
 * Describes a load balancing rule.
 */
model LoadBalancingRule {
  /**
   * The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer. Acceptable values are between 1 and 65534.
   */
  @maxValue(65534)
  @minValue(1)
  frontendPort: int32;

  /**
   * The port used for internal connections on the endpoint. Acceptable values are between 1 and 65535.
   */
  @maxValue(65534)
  @minValue(1)
  backendPort: int32;

  /**
   * The reference to the transport protocol used by the load balancing rule.
   */
  protocol: Protocol;

  /**
   * The prob port used by the load balancing rule. Acceptable values are between 1 and 65535.
   */
  @maxValue(65534)
  @minValue(1)
  probePort?: int32;

  /**
   * the reference to the load balancer probe used by the load balancing rule.
   */
  probeProtocol: ProbeProtocol;

  /**
   * The probe request path. Only supported for HTTP/HTTPS probes.
   */
  probeRequestPath?: string;

  /**
   * The load distribution policy for this rule.
   */
  loadDistribution?: string;
}

/**
 * Describes a network security rule.
 */
model NetworkSecurityRule {
  /**
   * Network security rule name.
   */
  name: string;

  /**
   * Network security rule description.
   */
  description?: string;

  /**
   * Network protocol this rule applies to.
   */
  protocol: NsgProtocol;

  /**
   * The CIDR or source IP ranges.
   */
  sourceAddressPrefixes?: string[];

  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   */
  destinationAddressPrefixes?: string[];

  /**
   * The source port ranges.
   */
  sourcePortRanges?: string[];

  /**
   * The destination port ranges.
   */
  destinationPortRanges?: string[];

  /**
   * The CIDR or source IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. If this is an ingress rule, specifies where network traffic originates from.
   */
  sourceAddressPrefix?: string;

  /**
   * The destination address prefix. CIDR or destination IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used.
   */
  destinationAddressPrefix?: string;

  /**
   * The source port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.
   */
  sourcePortRange?: string;

  /**
   * he destination port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.
   */
  destinationPortRange?: string;

  /**
   * The network traffic is allowed or denied.
   */
  access: Access;

  /**
   * The priority of the rule. The value can be in the range 1000 to 3000. Values outside this range are reserved for Service Fabric ManagerCluster Resource Provider. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   */
  @maxValue(3000)
  @minValue(1000)
  priority: int32;

  /**
   * Network security rule direction.
   */
  direction: Direction;
}

/**
 * Client certificate definition.
 */
model ClientCertificate {
  /**
   * Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.
   */
  isAdmin: boolean;

  /**
   * Certificate thumbprint.
   */
  thumbprint?: string;

  /**
   * Certificate common name.
   */
  commonName?: string;

  /**
   * Issuer thumbprint for the certificate. Only used together with CommonName.
   */
  issuerThumbprint?: string;
}

/**
 * The settings to enable AAD authentication on the cluster.
 */
model AzureActiveDirectory {
  /**
   * Azure active directory tenant id.
   */
  tenantId?: string;

  /**
   * Azure active directory cluster application id.
   */
  clusterApplication?: string;

  /**
   * Azure active directory client application id.
   */
  clientApplication?: string;
}

/**
 * Describes a section in the fabric settings of the cluster.
 */
model SettingsSectionDescription {
  /**
   * The section name of the fabric settings.
   */
  name: string;

  /**
   * The collection of parameters in the section.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  parameters: SettingsParameterDescription[];
}

/**
 * Describes a parameter in fabric settings of the cluster.
 */
model SettingsParameterDescription {
  /**
   * The parameter name of fabric setting.
   */
  name: string;

  /**
   * The parameter value of fabric setting.
   */
  value: string;
}

/**
 * The policy used to clean up unused versions. When the policy is not specified explicitly, the default unused application versions to keep will be 3.
 */
model ApplicationTypeVersionsCleanupPolicy {
  /**
   * Number of unused versions per application type to keep.
   */
  maxUnusedVersionsToKeep: int32;
}

/**
 * The IP tag associated with the public IP address.
 */
model IpTag {
  /**
   * IP tag type. Example: FirstPartyUsage.
   */
  ipTagType: string;

  /**
   * IP tag associated with the public IP. Example: SQL, Storage etc.
   */
  tag: string;
}

/**
 * Describes a Subnet.
 */
model Subnet {
  /**
   * Subnet name.
   */
  name: string;

  /**
   * Indicates wether to enable Ipv6 or not. If not provided, it will take the same configuration as the cluster.
   */
  enableIpv6?: boolean;

  /**
   * Enable or Disable apply network policies on private end point in the subnet.
   */
  privateEndpointNetworkPolicies?: PrivateEndpointNetworkPolicies;

  /**
   * Enable or Disable apply network policies on private link service in the subnet.
   */
  privateLinkServiceNetworkPolicies?: PrivateLinkServiceNetworkPolicies;

  /**
   * Full resource id for the network security group.
   */
  networkSecurityGroupId?: string;
}

/**
 * The service endpoint properties.
 */
model ServiceEndpoint {
  /**
   * The type of the endpoint service.
   */
  service: string;

  /**
   * A list of locations.
   */
  locations?: string[];
}

/**
 * Describes the policy used when upgrading the cluster.
 */
model ClusterUpgradePolicy {
  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean = false;

  /**
   * The cluster health policy defines a health policy used to evaluate the health of the cluster during a cluster upgrade.
   */
  healthPolicy?: ClusterHealthPolicy;

  /**
   * The cluster delta health policy defines a health policy used to evaluate the health of the cluster during a cluster upgrade.
   */
  deltaHealthPolicy?: ClusterUpgradeDeltaHealthPolicy;

  /**
   * The cluster monitoring policy describes the parameters for monitoring an upgrade in Monitored mode.
   */
  monitoringPolicy?: ClusterMonitoringPolicy;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues.
   * When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues.
   * The timeout is reset at the start of each upgrade domain. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   * This value must be between 00:00:00 and 49710.06:28:15 (unsigned 32 bit integer for seconds)
   *
   */
  upgradeReplicaSetCheckTimeout?: string;
}

/**
 * Defines a health policy used to evaluate the health of the cluster or of a cluster node.
 *
 */
model ClusterHealthPolicy {
  /**
   * The maximum allowed percentage of unhealthy nodes before reporting an error. For example, to allow 10% of nodes to be unhealthy, this value would be 10.
   *
   * The percentage represents the maximum tolerated percentage of nodes that can be unhealthy before the cluster is considered in error.
   * If the percentage is respected but there is at least one unhealthy node, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy nodes over the total number of nodes in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   * In large clusters, some nodes will always be down or out for repairs, so this percentage should be configured to tolerate that.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyNodes: int32 = 0;

  /**
   * The maximum allowed percentage of unhealthy applications before reporting an error. For example, to allow 10% of applications to be unhealthy, this value would be 10.
   *
   * The percentage represents the maximum tolerated percentage of applications that can be unhealthy before the cluster is considered in error.
   * If the percentage is respected but there is at least one unhealthy application, the health is evaluated as Warning.
   * This is calculated by dividing the number of unhealthy applications over the total number of application instances in the cluster, excluding applications of application types that are included in the ApplicationTypeHealthPolicyMap.
   * The computation rounds up to tolerate one failure on small numbers of applications. Default percentage is zero.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyApplications: int32 = 0;
}

/**
 * Describes the delta health policies for the cluster upgrade.
 */
model ClusterUpgradeDeltaHealthPolicy {
  /**
   * The maximum allowed percentage of nodes health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the nodes at the beginning of upgrade and the state of the nodes at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.
   *
   */
  @maxValue(100)
  maxPercentDeltaUnhealthyNodes: int32;

  /**
   * The maximum allowed percentage of upgrade domain nodes health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the upgrade domain nodes at the beginning of upgrade and the state of the upgrade domain nodes at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion for all completed upgrade domains to make sure the state of the upgrade domains is within tolerated limits.
   *
   */
  @maxValue(100)
  maxPercentUpgradeDomainDeltaUnhealthyNodes?: int32;

  /**
   * The maximum allowed percentage of applications health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the applications at the beginning of upgrade and the state of the applications at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits. System services are not included in this.
   * NOTE: This value will overwrite the value specified in properties.UpgradeDescription.HealthPolicy.MaxPercentUnhealthyApplications
   *
   */
  @maxValue(100)
  maxPercentDeltaUnhealthyApplications?: int32;
}

/**
 * Describes the monitoring policies for the cluster upgrade.
 */
model ClusterMonitoringPolicy {
  /**
   * The length of time to wait after completing an upgrade domain before performing health checks. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckWaitDuration: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  healthCheckStableDuration: string;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  healthCheckRetryTimeout: string;

  /**
   * The amount of time the overall upgrade has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  upgradeTimeout: string;

  /**
   * The amount of time each upgrade domain has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  upgradeDomainTimeout: string;
}

/**
 * Service Fabric managed cluster Sku definition
 */
model Sku {
  /**
   * Sku Name.
   */
  name: SkuName;
}

/**
 * Managed cluster update request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Not adding skus property as this API is for updating tags only"
model ManagedClusterUpdateParameters {
  /**
   * Managed cluster update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}

/**
 * Parameters for Fault Simulation id.
 */
model FaultSimulationIdContent {
  /**
   * unique identifier for the fault simulation.
   */
  simulationId: string;
}

/**
 * Fault simulation object with status.
 */
model FaultSimulation {
  /**
   * unique identifier for the fault simulation.
   */
  simulationId?: string;

  /**
   * Fault simulation status
   */
  status?: FaultSimulationStatus;

  /**
   * The start time of the fault simulation.
   */
  startTime?: utcDateTime;

  /**
   * The end time of the fault simulation.
   */
  endTime?: utcDateTime;

  /**
   * Fault simulation details
   */
  details?: FaultSimulationDetails;
}

/**
 * Details for Fault Simulation.
 */
model FaultSimulationDetails {
  /**
   * unique identifier for the cluster resource.
   */
  clusterId?: string;

  /**
   * unique identifier for the operation associated with the fault simulation.
   */
  operationId?: string;

  /**
   * List of node type simulations associated with the cluster fault simulation.
   */
  @OpenAPI.extension("x-ms-identifiers", ["nodeTypeName"])
  nodeTypeFaultSimulation?: NodeTypeFaultSimulation[];

  /**
   * Fault simulation parameters.
   */
  parameters?: FaultSimulationContent;
}

/**
 * Node type fault simulation object with status.
 */
model NodeTypeFaultSimulation {
  /**
   * Node type name.
   */
  nodeTypeName?: string;

  /**
   * Fault simulation status
   */
  status?: FaultSimulationStatus;

  /**
   * Current or latest asynchronous operation identifier on the node type.
   */
  operationId?: string;

  /**
   * Current or latest asynchronous operation status on the node type
   */
  operationStatus?: SfmcOperationStatus;
}

/**
 * Parameters for Fault Simulation action.
 */
@discriminator("faultKind")
model FaultSimulationContent {
  /**
   * The kind of fault to be simulated.
   */
  faultKind: FaultKind;

  /**
   * Force the action to go through without any check on the cluster.
   */
  force?: boolean;

  /**
   * Constraints for Fault Simulation action.
   */
  constraints?: FaultSimulationConstraints;
}

/**
 * Constraints for Fault Simulation action.
 */
model FaultSimulationConstraints {
  /**
   * The absolute expiration timestamp (UTC) after which this fault simulation should be stopped if it's still active.
   */
  expirationTime?: utcDateTime;
}

/**
 * Describes the maintenance window status of the Service Fabric Managed Cluster.
 */
model ManagedMaintenanceWindowStatusContent {
  /**
   * If maintenance window is enabled on this cluster.
   */
  @visibility("read")
  isWindowEnabled?: boolean;

  /**
   * Indicates if the region is ready to configure maintenance windows.
   */
  @visibility("read")
  isRegionReady?: boolean;

  /**
   * If maintenance window is active.
   */
  @visibility("read")
  isWindowActive?: boolean;

  /**
   * If updates can be applied.
   */
  @visibility("read")
  canApplyUpdates?: boolean;

  /**
   * Last window update time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UTC is a well known abbreviation"
  @visibility("read")
  lastWindowStatusUpdateAtUTC?: utcDateTime;

  /**
   * Last window start time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UTC is a well known abbreviation"
  @visibility("read")
  lastWindowStartTimeUTC?: utcDateTime;

  /**
   * Last window end time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UTC is a well known abbreviation"
  @visibility("read")
  lastWindowEndTimeUTC?: utcDateTime;
}

/**
 * Describes the result of the request to list Managed VM Sizes for Service Fabric Managed Clusters.
 */
model ManagedAzResiliencyStatusContent {
  /**
   * List of Managed VM Sizes for Service Fabric Managed Clusters.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  baseResourceStatus?: ResourceAzStatus[];

  /**
   * URL to get the next set of Managed VM Sizes if there are any.
   */
  @visibility("read")
  isClusterZoneResilient?: boolean;
}

/**
 * Describes Az Resiliency status of Base resources
 */
model ResourceAzStatus {
  /**
   * VM Size properties.
   */
  @visibility("read")
  resourceName?: string;

  /**
   * VM Size id.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * VM Size name.
   */
  @visibility("read")
  isZoneResilient?: boolean;

  /**
   * Zone resiliency status details for the resource.
   */
  @visibility("read")
  details?: string;
}

/**
 * Fault simulation list results
 */
model FaultSimulationListResult is Azure.Core.Page<FaultSimulation>;

/**
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
model NodeTypeProperties {
  /**
   * Indicates the Service Fabric system services for the cluster will run on this node type. This setting cannot be changed once the node type is created.
   */
  isPrimary: boolean;

  /**
   * The number of nodes in the node type. **Values:** -1 - Use when auto scale rules are configured or sku.capacity is defined 0 - Not supported >0 - Use for manual scale.
   */
  @maxValue(2147483647)
  @minValue(-1)
  vmInstanceCount: int32;

  /**
   * Disk size for the managed disk attached to the vms on the node type in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is a well known abbreviation"
  dataDiskSizeGB?: int32;

  /**
   * Managed data disk type. Specifies the storage account type for the managed disk
   */
  dataDiskType?: DiskType = DiskType.StandardSSD_LRS;

  /**
   * Managed data disk letter. It can not use the reserved letter C or D and it can not change after created.
   */
  @pattern("^[a-zA-Z]{1}$")
  dataDiskLetter?: string;

  /**
   * The placement tags applied to nodes in the node type, which can be used to indicate where certain services (workload) should run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  placementProperties?: Record<string>;

  /**
   * The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  capacities?: Record<string>;

  /**
   * The range of ports from which cluster assigned port to Service Fabric applications.
   */
  applicationPorts?: EndpointRangeDescription;

  /**
   * The range of ephemeral ports that nodes in this node type should be configured with.
   */
  ephemeralPorts?: EndpointRangeDescription;

  /**
   * The size of virtual machines in the pool. All virtual machines in a pool are the same size. For example, Standard_D3.
   */
  vmSize?: string;

  /**
   * The publisher of the Azure Virtual Machines Marketplace image. For example, Canonical or MicrosoftWindowsServer.
   */
  vmImagePublisher?: string;

  /**
   * The offer type of the Azure Virtual Machines Marketplace image. For example, UbuntuServer or WindowsServer.
   */
  vmImageOffer?: string;

  /**
   * The SKU of the Azure Virtual Machines Marketplace image. For example, 14.04.0-LTS or 2012-R2-Datacenter.
   */
  vmImageSku?: string;

  /**
   * The version of the Azure Virtual Machines Marketplace image. A value of 'latest' can be specified to select the latest version of an image. If omitted, the default is 'latest'.
   */
  vmImageVersion?: string;

  /**
   * The secrets to install in the virtual machines.
   */
  @OpenAPI.extension("x-ms-identifiers", ["sourceVault"])
  vmSecrets?: VaultSecretGroup[];

  /**
   * Set of extensions that should be installed onto the virtual machines.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  vmExtensions?: VMSSExtension[];

  /**
   * Identities to assign to the virtual machine scale set under the node type.
   */
  vmManagedIdentity?: VmManagedIdentity;

  /**
   * Indicates if the node type can only host Stateless workloads.
   */
  isStateless?: boolean = false;

  /**
   * Indicates if scale set associated with the node type can be composed of multiple placement groups.
   */
  multiplePlacementGroups?: boolean = false;

  /**
   * Indicates the node type uses its own frontend configurations instead of the default one for the cluster. This setting can only be specified for non-primary node types and can not be added or removed after the node type is created.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  frontendConfigurations?: FrontendConfiguration[];

  /**
   * The Network Security Rules for this node type. This setting can only be specified for node types that are configured with frontend configurations.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  networkSecurityRules?: NetworkSecurityRule[];

  /**
   * Additional managed data disks.
   */
  @OpenAPI.extension("x-ms-identifiers", ["lun"])
  additionalDataDisks?: VmssDataDisk[];

  /**
   * Enable or disable the Host Encryption for the virtual machines on the node type. This will enable the encryption for all the disks including Resource/Temp disk at host itself. Default: The Encryption at host will be disabled unless this property is set to true for the resource.
   */
  enableEncryptionAtHost?: boolean = false;

  /**
   * The provisioning state of the node type resource.
   */
  @visibility("read")
  provisioningState?: ManagedResourceProvisioningState;

  /**
   * Specifies whether the network interface is accelerated networking-enabled.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * Specifies whether the use public load balancer. If not specified and the node type doesn't have its own frontend configuration, it will be attached to the default load balancer. If the node type uses its own Load balancer and useDefaultPublicLoadBalancer is true, then the frontend has to be an Internal Load Balancer. If the node type uses its own Load balancer and useDefaultPublicLoadBalancer is false or not set, then the custom load balancer must include a public load balancer to provide outbound connectivity.
   */
  useDefaultPublicLoadBalancer?: boolean;

  /**
   * Specifies whether to use the temporary disk for the service fabric data root, in which case no managed data disk will be attached and the temporary disk will be used. It is only allowed for stateless node types.
   */
  useTempDataDisk?: boolean;

  /**
   * Specifies whether the node type should be overprovisioned. It is only allowed for stateless node types.
   */
  enableOverProvisioning?: boolean;

  /**
   * Specifies the availability zones where the node type would span across. If the cluster is not spanning across availability zones, initiates az migration for the cluster.
   */
  zones?: string[];

  /**
   * Indicates whether the node type will be Spot Virtual Machines. Azure will allocate the VMs if there is capacity available and the VMs can be evicted at any time.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well known abbreviation"
  isSpotVM?: boolean;

  /**
   * Specifies the full host group resource Id. This property is used for deploying on azure dedicated hosts.
   */
  hostGroupId?: string;

  /**
   * Indicates whether to use ephemeral os disk. The sku selected on the vmSize property needs to support this feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "OS is a well known abbreviation"
  useEphemeralOSDisk?: boolean;

  /**
   * Indicates the time duration after which the platform will not try to restore the VMSS SPOT instances specified as ISO 8601.
   */
  spotRestoreTimeout?: string;

  /**
   * Specifies the eviction policy for virtual machines in a SPOT node type. Default is Delete.
   */
  evictionPolicy?: EvictionPolicyType;

  /**
   * Indicates the resource id of the vm image. This parameter is used for custom vm image.
   */
  vmImageResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/images";
    },
    {
      type: "Microsoft.Compute/galleries/images";
    },
    {
      type: "Microsoft.Compute/galleries/images/versions";
    }
  ]>;

  /**
   * Indicates the resource id of the subnet for the node type.
   */
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Specifies the actions to be performed on the vms before bootstrapping the service fabric runtime.
   */
  vmSetupActions?: VmSetupAction[];

  /**
   * Specifies the security type of the nodeType. Only Standard and TrustedLaunch are currently supported
   */
  securityType?: SecurityType;

  /**
   * Specifies whether secure boot should be enabled on the nodeType. Can only be used with TrustedLaunch SecurityType
   */
  secureBootEnabled?: boolean;

  /**
   * Specifies whether each node is allocated its own public IPv4 address. This is only supported on secondary node types with custom Load Balancers.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  enableNodePublicIP?: boolean;

  /**
   * Specifies whether each node is allocated its own public IPv6 address. This is only supported on secondary node types with custom Load Balancers.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  enableNodePublicIPv6?: boolean;

  /**
   * Indicates the resource id of the vm shared galleries image. This parameter is used for custom vm image.
   */
  vmSharedGalleryImageId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/sharedGalleries/images";
    },
    {
      type: "Microsoft.Compute/sharedGalleries/images/versions";
    }
  ]>;

  /**
   * Specifies the resource id of a NAT Gateway to attach to the subnet of this node type. Node type must use custom load balancer.
   */
  natGatewayId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/natGateways";
    }
  ]>;

  /**
   * Specifies the NAT configuration on default public Load Balancer for the node type. This is only supported for node types use the default public Load Balancer.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  natConfigurations?: NodeTypeNatConfig[];

  /**
   * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started ->. Enter any required information and then click Save.
   */
  vmImagePlan?: VmImagePlan;

  /**
   * Specifies the service artifact reference id used to set same image version for all virtual machines in the scale set when using 'latest' image version.
   */
  serviceArtifactReferenceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/galleries/serviceArtifacts/vmArtifactsProfiles";
    }
  ]>;

  /**
   * Specifies the resource id of the DSCP configuration to apply to the node type network interface.
   */
  dscpConfigurationId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/dscpConfigurations";
    }
  ]>;

  /**
   * Specifies the settings for any additional secondary network interfaces to attach to the node type.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  additionalNetworkInterfaceConfigurations?: AdditionalNetworkInterfaceConfiguration[];

  /**
   * Specifies the computer name prefix. Limited to 9 characters. If specified, allows for a longer name to be specified for the node type name.
   */
  computerNamePrefix?: string;

  /**
   * Specifies the gallery applications that should be made available to the underlying VMSS.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  vmApplications?: VmApplication[];
}

/**
 * Port range details
 */
model EndpointRangeDescription {
  /**
   * Starting port of a range of ports
   */
  startPort: int32;

  /**
   * End port of a range of ports
   */
  endPort: int32;
}

/**
 * Specifies set of certificates that should be installed onto the virtual machines.
 */
model VaultSecretGroup {
  /**
   * The relative URL of the Key Vault containing all of the certificates in VaultCertificates.
   */
  sourceVault: SubResource;

  /**
   * The list of key vault references in SourceVault which contain certificates.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  vaultCertificates: VaultCertificate[];
}

/**
 * Azure resource identifier.
 */
model SubResource {
  /**
   * Azure resource identifier.
   */
  id?: string;
}

/**
 * Describes a single certificate reference in a Key Vault, and where the certificate should reside on the VM.
 */
model VaultCertificate {
  /**
   * This is the URL of a certificate that has been uploaded to Key Vault as a secret. For adding a secret to the Key Vault, see [Add a key or secret to the key vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add).
   */
  certificateUrl: string;

  /**
   * For Windows VMs, specifies the certificate store on the Virtual Machine to which the certificate should be added. The specified certificate store is implicitly in the LocalMachine account. For Linux VMs, the certificate file is placed under the /var/lib/waagent directory, with the file name {UppercaseThumbprint}.crt for the X509 certificate file and {UppercaseThumbprint}.prv for private key. Both of these files are .pem formatted.
   */
  certificateStore: string;
}

/**
 * Specifies set of extensions that should be installed onto the virtual machines.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Backwards compatibility, VMSS is a well-known acronym"
model VMSSExtension {
  /**
   * The name of the extension.
   */
  name: string;

  /**
   * Describes the properties of a Virtual Machine Scale Set Extension.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Backwards compatibility with existing flatten"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: VMSSExtensionProperties;
}
/**
 * Describes the properties of a Virtual Machine Scale Set Extension.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Backwards compatibility, VMSS is a well-known acronym"
model VMSSExtensionProperties {
  /**
   * The name of the extension handler publisher.
   */
  publisher: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion: string;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Day 0 property"
  settings?: {};

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Day 0 property"
  protectedSettings?: {};

  /**
   * If a value is provided and is different from the previous value, the extension handler will be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * Collection of extension names after which this extension needs to be provisioned.
   */
  provisionAfterExtensions?: string[];

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Indicates the setup order for the extension.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  setupOrder?: VmssExtensionSetupOrder[];
}

/**
 * Identities for the virtual machine scale set under the node type.
 */
model VmManagedIdentity {
  /**
   * The list of user identities associated with the virtual machine scale set under the node type. Each entry will be an ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: string[];
}

/**
 * Describes the frontend configurations for the node type.
 */
model FrontendConfiguration {
  /**
   * The IP address type of this frontend configuration. If omitted the default value is IPv4.
   */
  ipAddressType?: IPAddressType = IPAddressType.IPv4;

  /**
   * The resource Id of the Load Balancer backend address pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/backendAddressPools/{backendAddressPoolName}'.
   */
  loadBalancerBackendAddressPoolId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource Id of the Load Balancer inbound NAT pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/loadBalancers/{loadBalancerName}/inboundNatPools/{inboundNatPoolName}'.
   */
  loadBalancerInboundNatPoolId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource Id of application gateway backend address pool. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/applicationGateways/{applicationGatewayName}/backendAddressPools/{backendAddressPoolName}'.
   */
  applicationGatewayBackendAddressPoolId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/applicationGateways/backendAddressPools";
    }
  ]>;
}

/**
 * Managed data disk description.
 */
model VmssDataDisk {
  /**
   * Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM. Lun 0 is reserved for the service fabric data disk.
   */
  @minValue(1)
  lun: int32;

  /**
   * Disk size for each vm in the node type in GBs.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "GB is a well known abbreviation"
  diskSizeGB: int32;

  /**
   * Managed data disk type. Specifies the storage account type for the managed disk
   */
  diskType: DiskType = DiskType.StandardSSD_LRS;

  /**
   * Managed data disk letter. It can not use the reserved letter C or D and it can not change after created.
   */
  @pattern("^[a-zA-Z]{1}$")
  diskLetter: string;
}

/**
 * Provides information about NAT configuration on the default public Load Balancer for the node type.
 */
model NodeTypeNatConfig {
  /**
   * The internal port for the NAT configuration.
   */
  @maxValue(65535)
  @minValue(1)
  backendPort?: int32;

  /**
   * The port range start for the external endpoint.
   */
  @maxValue(65534)
  @minValue(1)
  frontendPortRangeStart?: int32;

  /**
   * The port range end for the external endpoint.
   */
  @maxValue(65534)
  @minValue(1)
  frontendPortRangeEnd?: int32;
}

/**
 * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started. Enter any required information and then click Save.
 */
model VmImagePlan {
  /**
   * The plan ID.
   */
  name?: string;

  /**
   * Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element.
   */
  product?: string;

  /**
   * The promotion code.
   */
  promotionCode?: string;

  /**
   * The publisher ID.
   */
  publisher?: string;
}

/**
 * Specifies the settings for a network interface to attach to the node type.
 */
model AdditionalNetworkInterfaceConfiguration {
  /**
   * Name of the network interface.
   */
  name: string;

  /**
   * Specifies whether the network interface is accelerated networking-enabled.
   */
  enableAcceleratedNetworking?: boolean;

  /**
   * Specifies the DSCP configuration to apply to the network interface.
   */
  dscpConfiguration?: SubResource;

  /**
   * Specifies the IP configurations of the network interface.
   */
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  ipConfigurations: IpConfiguration[];
}

/**
 * Specifies an IP configuration of the network interface.
 */
model IpConfiguration {
  /**
   * Name of the network interface.
   */
  name: string;

  /**
   * Specifies an array of references to backend address pools of application gateways. A node type can reference backend address pools of multiple application gateways. Multiple node types cannot use the same application gateway.
   */
  applicationGatewayBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to backend address pools of load balancers. A node type can reference backend address pools of one public and one internal load balancer. Multiple node types cannot use the same basic sku load balancer.
   */
  loadBalancerBackendAddressPools?: SubResource[];

  /**
   * Specifies an array of references to inbound Nat pools of the load balancers. A node type can reference inbound nat pools of one public and one internal load balancer. Multiple node types cannot use the same basic sku load balancer.
   */
  loadBalancerInboundNatPools?: SubResource[];

  /**
   * Specifies the subnet of the network interface.
   */
  subnet?: SubResource;

  /**
   * Specifies whether the IP configuration's private IP is IPv4 or IPv6. Default is IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  privateIPAddressVersion?: PrivateIPAddressVersion = PrivateIPAddressVersion.IPv4;

  /**
   * The public IP address configuration of the network interface.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPAddressConfiguration?: IpConfigurationPublicIPAddressConfiguration;
}

/**
 * The public IP address configuration of the network interface.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
model IpConfigurationPublicIPAddressConfiguration {
  /**
   * Name of the network interface.
   */
  name: string;

  /**
   * Specifies the list of IP tags associated with the public IP address.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  ipTags?: IpTag[];

  /**
   * Specifies whether the IP configuration's public IP is IPv4 or IPv6. Default is IPv4.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPAddressVersion?: PublicIPAddressVersion = PublicIPAddressVersion.IPv4;
}

/**
 * Specifies the gallery application that should be made available to the underlying VMSS.
 */
model VmApplication {
  /**
   * Optional, Specifies the uri to an azure blob that will replace the default configuration for the package if provided.
   */
  configurationReference?: url;

  /**
   * If set to true, when a new Gallery Application version is available in PIR/SIG, it will be automatically updated for the underlying VMSS.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Optional, Specifies the order in which the packages have to be installed.
   */
  order?: int32;

  /**
   * Specifies the GalleryApplicationVersion resource id on the form of /subscriptions/{SubscriptionId}/resourceGroups/{ResourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/applications/{application}/versions/{version}.
   */
  packageReferenceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Compute/galleries/applications/versions";
    }
  ]>;

  /**
   * Optional, Specifies a passthrough value for more generic context. Accepts a JSON-formatted string e.g. '{"Tag1":"Value1","Tag2":"Value2"}'.
   */
  vmGalleryTags?: string;

  /**
   * Optional, If true, any failure for any operation in the VmApplication will fail the deployment.
   */
  treatFailureAsDeploymentFailure?: boolean;
}

/**
 * Describes a node type sku.
 */
model NodeTypeSku {
  /**
   * The sku name. Name is internally generated and is used in auto-scale scenarios. Property does not allow to be changed to other values than generated. To avoid deployment errors please omit the property.
   */
  name?: string;

  /**
   * Specifies the tier of the node type. Possible Values: **Standard**
   */
  tier?: string;

  /**
   * The number of nodes in the node type. If present in request it will override properties.vmInstanceCount.
   */
  @maxValue(2147483647)
  @minValue(1)
  capacity: int32;
}

/**
 * Node type update request
 */
model NodeTypeUpdateParameters {
  /**
   * Node type update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;

  /**
   * The node type sku.
   */
  sku?: NodeTypeSku;
}

/**
 * Parameters for Node type action. If nodes are not specified on the parameters, the operation will be performed in all nodes of the node type one upgrade domain at a time.
 */
model NodeTypeActionParameters {
  /**
   * List of node names from the node type.
   */
  nodes?: string[];

  /**
   * Force the action to go through.
   */
  force?: boolean;

  /**
   * Specifies the way the operation will be performed.
   */
  updateType?: UpdateType;
}

/**
 * Node type available sku list results
 */
model NodeTypeListSkuResult is Azure.Core.Page<NodeTypeAvailableSku>;

/**
 * Defines the type of sku available for a node type
 */
model NodeTypeAvailableSku {
  /**
   * The type of resource the sku applies to. Value: Microsoft.ServiceFabric/managedClusters/nodeTypes.
   */
  @visibility("read")
  resourceType?: string;

  /**
   * The supported SKU for a for node type.
   */
  @visibility("read")
  sku?: NodeTypeSupportedSku;

  /**
   * Provides information about how the node count can be scaled.
   */
  @visibility("read")
  capacity?: NodeTypeSkuCapacity;
}

/**
 * Describes a node type supported sku.
 */
model NodeTypeSupportedSku {
  /**
   * The sku name.
   */
  @visibility("read")
  name?: string;

  /**
   * Specifies the tier of the node type. Possible Values: **Standard**
   */
  @visibility("read")
  tier?: string;
}

/**
 * Provides information about how node type can be scaled.
 */
model NodeTypeSkuCapacity {
  /**
   * Lowest permitted node count in a node type.
   */
  @visibility("read")
  minimum?: int32;

  /**
   * Highest permitted node count in a node type.
   */
  @visibility("read")
  maximum?: int32;

  /**
   * Default node count in a node type.
   */
  @visibility("read")
  default?: int32;

  /**
   * Node type capacity scale type.
   */
  @visibility("read")
  scaleType?: NodeTypeSkuScaleType = NodeTypeSkuScaleType.None;
}

/**
 * Represents a scaling mechanism for adding or removing named partitions of a stateless service. Partition names are in the format '0','1'...'N-1'.
 */
model AddRemoveIncrementalNamedPartitionScalingMechanism
  extends ScalingMechanism {
  /**
   * Minimum number of named partitions of the service.
   */
  minPartitionCount: int32;

  /**
   * Maximum number of named partitions of the service.
   */
  maxPartitionCount: int32;

  /**
   * The number of instances to add or remove during a scaling operation.
   */
  scaleIncrement: int32;

  /**
   * Specifies the mechanism associated with this scaling policy.
   */
  kind: "AddRemoveIncrementalNamedPartition";
}

/**
 * Represents a scaling trigger related to an average load of a metric/resource of a partition.
 */
model AveragePartitionLoadScalingTrigger extends ScalingTrigger {
  /**
   * The name of the metric for which usage should be tracked.
   */
  metricName: string;

  /**
   * The lower limit of the load below which a scale in operation should be performed.
   */
  lowerLoadThreshold: float64;

  /**
   * The upper limit of the load beyond which a scale out operation should be performed.
   */
  upperLoadThreshold: float64;

  /**
   * The period in seconds on which a decision is made whether to scale or not. This property should come in ISO 8601 format "hh:mm:ss".
   */
  scaleInterval: string;

  /**
   * Specifies the trigger associated with this scaling policy.
   */
  kind: "AveragePartitionLoadTrigger";
}

/**
 * Represents a scaling policy related to an average load of a metric/resource of a service.
 */
model AverageServiceLoadScalingTrigger extends ScalingTrigger {
  /**
   * The name of the metric for which usage should be tracked.
   */
  metricName: string;

  /**
   * The lower limit of the load below which a scale in operation should be performed.
   */
  lowerLoadThreshold: float64;

  /**
   * The upper limit of the load beyond which a scale out operation should be performed.
   */
  upperLoadThreshold: float64;

  /**
   * The period in seconds on which a decision is made whether to scale or not. This property should come in ISO 8601 format "hh:mm:ss".
   */
  scaleInterval: string;

  /**
   * Flag determines whether only the load of primary replica should be considered for scaling. If set to true, then trigger will only consider the load of primary replicas of stateful service. If set to false, trigger will consider load of all replicas. This parameter cannot be set to true for stateless service.
   */
  useOnlyPrimaryLoad: boolean;

  /**
   * Specifies the trigger associated with this scaling policy.
   */
  kind: "AverageServiceLoadTrigger";
}

/**
 * Describes the named partition scheme of the service.
 */
model NamedPartitionScheme extends Partition {
  /**
   * Array for the names of the partitions.
   */
  names: string[];

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "Named";
}

/**
 * Represents a scaling mechanism for adding or removing instances of stateless service partition.
 */
model PartitionInstanceCountScaleMechanism extends ScalingMechanism {
  /**
   * Minimum number of instances of the partition.
   */
  minInstanceCount: int32;

  /**
   * Maximum number of instances of the partition.
   */
  maxInstanceCount: int32;

  /**
   * The number of instances to add or remove during a scaling operation.
   */
  scaleIncrement: int32;

  /**
   * Specifies the mechanism associated with this scaling policy.
   */
  kind: "ScalePartitionInstanceCount";
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where a particular fault or upgrade domain should not be used for placement of the instances or replicas of that service.
 */
model ServicePlacementInvalidDomainPolicy extends ServicePlacementPolicy {
  /**
   * The name of the domain that should not be used for placement.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "InvalidDomain";
}

/**
 * The type of placement policy for a service fabric service. Following are the possible values.
 */
model ServicePlacementNonPartiallyPlaceServicePolicy
  extends ServicePlacementPolicy {
  type: "NonPartiallyPlaceService";
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where the service's
 * Primary replicas should optimally be placed in a particular domain.
 *
 * This placement policy is usually used with fault domains in scenarios where the Service Fabric
 * cluster is geographically distributed in order to indicate that a service's primary replica should
 * be located in a particular fault domain, which in geo-distributed scenarios usually aligns with regional
 * or datacenter boundaries. Note that since this is an optimization it is possible that the Primary replica
 * may not end up located in this domain due to failures, capacity limits, or other constraints.
 *
 */
model ServicePlacementPreferPrimaryDomainPolicy extends ServicePlacementPolicy {
  /**
   * The name of the domain that should used for placement as per this policy.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "PreferredPrimaryDomain";
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where two replicas
 * from the same partition should never be placed in the same fault or upgrade domain.
 *
 * While this is not common it can expose the service to an increased risk of concurrent failures
 * due to unplanned outages or other cases of subsequent/concurrent failures. As an example, consider
 * a case where replicas are deployed across different data center, with one replica per location.
 * In the event that one of the datacenters goes offline, normally the replica that was placed in that
 * datacenter will be packed into one of the remaining datacenters. If this is not desirable then this
 * policy should be set.
 *
 */
model ServicePlacementRequireDomainDistributionPolicy
  extends ServicePlacementPolicy {
  /**
   * The name of the domain that should used for placement as per this policy.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "RequiredDomainDistribution";
}

/**
 * Describes the policy to be used for placement of a Service Fabric service where the instances or replicas of that service must be placed in a particular domain.
 */
model ServicePlacementRequiredDomainPolicy extends ServicePlacementPolicy {
  /**
   * The name of the domain that should used for placement as per this policy.
   */
  domainName: string;

  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "RequiredDomain";
}

/**
 * Describes the partition scheme of a singleton-partitioned, or non-partitioned service.
 */
model SingletonPartitionScheme extends Partition {
  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "Singleton";
}

/**
 * The properties of a stateful service resource.
 */
model StatefulServiceProperties extends ServiceResourceProperties {
  /**
   * A flag indicating whether this is a persistent service which stores states on the local disk. If it is then the value of this property is true, if not it is false.
   */
  hasPersistedState?: boolean;

  /**
   * The target replica set size as a number.
   */
  @minValue(1)
  targetReplicaSetSize?: int32;

  /**
   * The minimum replica set size as a number.
   */
  @minValue(1)
  minReplicaSetSize?: int32;

  /**
   * The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  replicaRestartWaitDuration?: string;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  quorumLossWaitDuration?: string;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  standByReplicaKeepDuration?: string;

  /**
   * The duration for which replicas can stay InBuild before reporting that build is stuck, represented in ISO 8601 format "hh:mm:ss".
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Day 0 property"
  @OpenAPI.extension("x-ms-format", "duration-constant")
  servicePlacementTimeLimit?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateful";
}

/**
 * The properties of a stateless service resource.
 */
model StatelessServiceProperties extends ServiceResourceProperties {
  /**
   * The instance count.
   */
  @minValue(-1)
  instanceCount: int32;

  /**
   * MinInstanceCount is the minimum number of instances that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstanceCount computation -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstanceCount?: int32;

  /**
   * MinInstancePercentage is the minimum percentage of InstanceCount that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstancePercentage computation, -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstancePercentage?: int32;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateless";
}

/**
 * Describes a partitioning scheme where an integer range is allocated evenly across a number of partitions.
 */
model UniformInt64RangePartitionScheme extends Partition {
  /**
   * The number of partitions.
   */
  count: int32;

  /**
   * The lower bound of the partition key range that
   * should be split between the partition ‘Count’
   *
   */
  lowKey: int64;

  /**
   * The upper bound of the partition key range that
   * should be split between the partition ‘Count’
   *
   */
  highKey: int64;

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "UniformInt64Range";
}

/**
 * Parameters for Zone Fault Simulation action.
 */
model ZoneFaultSimulationContent extends FaultSimulationContent {
  /**
   * Indicates the zones of the fault simulation.
   */
  zones?: string[];

  /**
   * The kind of fault simulation.
   */
  faultKind: "Zone";
}
