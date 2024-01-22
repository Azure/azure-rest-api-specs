import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceFabric;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.
 */
enum FailureAction {
  /**
   * Indicates that a rollback of the upgrade will be performed by Service Fabric if the upgrade fails.
   */
  Rollback,

  /**
   * Indicates that a manual repair will need to be performed by the administrator if the upgrade fails. Service Fabric will not proceed to the next upgrade domain automatically.
   */
  Manual,
}

/**
 * The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.
 */
enum RollingUpgradeMode {
  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 0.
   */
  Monitored,

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 1.
   */
  UnmonitoredAuto,
}

/**
 * The kind of service (Stateless or Stateful).
 */
enum ServiceKind {
  /**
   * Does not use Service Fabric to make its state highly available or reliable. The value is 0.
   */
  Stateless,

  /**
   * Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 1.
   */
  Stateful,
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
enum PartitionScheme {
  /**
   * Indicates that the partition is based on string names, and is a SingletonPartitionScheme object, The value is 0.
   */
  Singleton,

  /**
   * Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionScheme object. The value is 1.
   */
  UniformInt64Range,

  /**
   * Indicates that the partition is based on string names, and is a NamedPartitionScheme object. The value is 2.
   */
  Named,
}

/**
 * The activation Mode of the service package
 */
enum ServicePackageActivationMode {
  /**
   * Indicates the application package activation mode will use shared process.
   */
  SharedProcess,

  /**
   * Indicates the application package activation mode will use exclusive process.
   */
  ExclusiveProcess,
}

/**
 * The service correlation scheme.
 */
enum ServiceCorrelationScheme {
  /**
   * Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 0.
   */
  AlignedAffinity,

  /**
   * Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 1.
   */
  NonAlignedAffinity,
}

/**
 * Determines the metric weight relative to the other metrics that are configured for this service. During runtime, if two metrics end up in conflict, the Cluster Resource Manager prefers the metric with the higher weight.
 */
enum ServiceLoadMetricWeight {
  /**
   * Disables resource balancing for this metric. This value is zero.
   */
  Zero,

  /**
   * Specifies the metric weight of the service load as Low. The value is 1.
   */
  Low,

  /**
   * Specifies the metric weight of the service load as Medium. The value is 2.
   */
  Medium,

  /**
   * Specifies the metric weight of the service load as High. The value is 3.
   */
  High,
}

/**
 * The type of placement policy for a service fabric service. Following are the possible values.
 */
enum ServicePlacementPolicyType {
  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 0.
   */
  InvalidDomain,

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 1.
   */
  RequiredDomain,

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 2.
   */
  PreferredPrimaryDomain,

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 3.
   */
  RequiredDomainDistribution,

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 4.
   */
  NonPartiallyPlaceService,
}

/**
 * Specifies the move cost for the service.
 */
enum MoveCost {
  /**
   * Zero move cost. This value is zero.
   */
  Zero,

  /**
   * Specifies the move cost of the service as Low. The value is 1.
   */
  Low,

  /**
   * Specifies the move cost of the service as Medium. The value is 2.
   */
  Medium,

  /**
   * Specifies the move cost of the service as High. The value is 3.
   */
  High,
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
enum ServiceScalingMechanismKind {
  /**
   * Represents a scaling mechanism for adding or removing instances of stateless service partition. The value is 0.
   */
  ScalePartitionInstanceCount,

  /**
   * Represents a scaling mechanism for adding or removing named partitions of a stateless service. The value is 1.
   */
  AddRemoveIncrementalNamedPartition,
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
enum ServiceScalingTriggerKind {
  /**
   * Represents a scaling trigger related to an average load of a metric/resource of a partition. The value is 0.
   */
  AveragePartitionLoadTrigger,

  /**
   * Represents a scaling policy related to an average load of a metric/resource of a service. The value is 1.
   */
  AverageServiceLoadTrigger,
}

/**
* The current state of the cluster.

*/
enum ClusterState {
  /**
   * Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
   */
  WaitingForNodes,

  /**
   * Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
   */
  Deploying,

  /**
   * Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
   */
  BaselineUpgrade,

  /**
   * Indicates that the cluster is being upgraded with the user provided configuration.
   */
  Upgrading,

  /**
   * Indicates that the last upgrade for the cluster has failed.
   */
  UpgradeFailed,

  /**
   * Indicates that the cluster is in a stable state.
   */
  Ready,
}

/**
 * The reference to the transport protocol used by the load balancing rule.
 */
enum Protocol {
  tcp,
  udp,
}

/**
 * the reference to the load balancer probe used by the load balancing rule.
 */
enum ProbeProtocol {
  tcp,
  http,
  https,
}

/**
 * Network protocol this rule applies to.
 */
enum NsgProtocol {
  http,
  https,
  tcp,
  udp,
  icmp,
  ah,
  esp,
}

/**
 * The network traffic is allowed or denied.
 */
enum Access {
  allow,
  deny,
}

/**
 * Network security rule direction.
 */
enum Direction {
  inbound,
  outbound,
}

/**
 * The provisioning state of the managed resource.
 */
enum ManagedResourceProvisioningState {
  None,
  Creating,
  Created,
  Updating,
  Succeeded,
  Failed,
  Canceled,
  Deleting,
  Deleted,
  Other,
}

/**
* The upgrade mode of the cluster when new Service Fabric runtime version is available.

*/
enum ClusterUpgradeMode {
  /**
   * The cluster will be automatically upgraded to the latest Service Fabric runtime version, **clusterUpgradeCadence** will determine when the upgrade starts after the new version becomes available.
   */
  Automatic,

  /**
   * The cluster will not be automatically upgraded to the latest Service Fabric runtime version. The cluster is upgraded by setting the **clusterCodeVersion** property in the cluster resource.
   */
  Manual,
}

/**
 * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0.
 */
enum ClusterUpgradeCadence {
  /**
   * Cluster upgrade starts immediately after a new version is rolled out. Recommended for Test/Dev clusters.
   */
  Wave0,

  /**
   * Cluster upgrade starts 7 days after a new version is rolled out. Recommended for Pre-prod clusters.
   */
  Wave1,

  /**
   * Cluster upgrade starts 14 days after a new version is rolled out. Recommended for Production clusters.
   */
  Wave2,
}

/**
 * Available cluster add-on features
 */
enum ManagedClusterAddOnFeature {
  /**
   * Dns service
   */
  DnsService,

  /**
   * Backup and restore service
   */
  BackupRestoreService,

  /**
   * Resource monitor service
   */
  ResourceMonitorService,
}

/**
 * Enable or Disable apply network policies on private end point in the subnet.
 */
enum PrivateEndpointNetworkPolicies {
  enabled,
  disabled,
}

/**
 * Enable or Disable apply network policies on private link service in the subnet.
 */
enum PrivateLinkServiceNetworkPolicies {
  enabled,
  disabled,
}

/**
 * Indicates the update mode for Cross Az clusters.
 */
enum ZonalUpdateMode {
  /**
   * The cluster will use 5 upgrade domains for Cross Az Node types.
   */
  Standard,

  /**
   * The cluster will use a maximum of 3 upgrade domains per zone instead of 5 for Cross Az Node types for faster deployments.
   */
  Fast,
}

/**
 * Sku Name.
 */
enum SkuName {
  /**
   * Basic requires a minimum of 3 nodes and allows only 1 node type.
   */
  Basic,

  /**
   * Requires a minimum of 5 nodes and allows 1 or more node type.
   */
  Standard,
}

/**
 * Cluster operating system, the default will be Windows
 */
enum OsType {
  /**
   * Indicates os is Windows.
   */
  Windows,
}

enum ManagedClusterVersionEnvironment {
  /**
   * Windows.
   */
  Windows,
}

/**
* Managed data disk type. IOPS and throughput are given by the disk size, to see more information go to https://docs.microsoft.com/en-us/azure/virtual-machines/disks-types.

*/
enum DiskType {
  /**
   * Standard HDD locally redundant storage. Best for backup, non-critical, and infrequent access.
   */
  Standard_LRS,

  /**
   * Standard SSD locally redundant storage. Best for web servers, lightly used enterprise applications and dev/test.
   */
  StandardSSD_LRS,

  /**
   * Premium SSD locally redundant storage. Best for production and performance sensitive workloads.
   */
  Premium_LRS,
}

/**
* The IP address type.

*/
enum IPAddressType {
  /**
   * IPv4 address type.
   */
  IPv4,

  /**
   * IPv6 address type.
   */
  IPv6,
}

/**
 * Specifies the eviction policy for virtual machines in a SPOT node type.
 */
enum EvictionPolicyType {
  /**
   * Eviction policy will be Delete for SPOT vms.
   */
  Delete,

  /**
   * Eviction policy will be Deallocate for SPOT vms.
   */
  Deallocate,
}

/**
 * action to be performed on the vms before bootstrapping the service fabric runtime.
 */
enum VmSetupAction {
  /**
   * Enable windows containers feature.
   */
  EnableContainers,

  /**
   * Enables windows HyperV feature.
   */
  EnableHyperV,
}

/**
 * Specifies the security type of the nodeType. Only TrustedLaunch is currently supported
 */
enum SecurityType {
  /**
   * Trusted Launch is a security type that secures generation 2 virtual machines.
   */
  TrustedLaunch,
}

/**
 * Specifies the way the operation will be performed.
 */
enum UpdateType {
  /**
   * The operation will proceed in all specified nodes at the same time.
   */
  Default,

  /**
   * The operation will proceed one upgrade domain at a time, checking the health in between each to continue.
   */
  ByUpgradeDomain,
}

/**
* Node type capacity scale type.

*/
enum NodeTypeSkuScaleType {
  /**
   * Node count is not adjustable in any way (e.g. it is fixed).
   */
  None,

  /**
   * The user must manually scale out/in.
   */
  Manual,

  /**
   * Automatic scale is allowed.
   */
  Automatic,
}

/**
 * The application type name properties
 */
model ApplicationTypeResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;
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
 * Application type update request
 */
model ApplicationTypeUpdateParameters {
  /**
   * Application type update parameters
   */
  tags?: Record<string>;
}

/**
 * The properties of the application type version resource.
 */
model ApplicationTypeVersionResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
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
  tags?: Record<string>;
}

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
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.

*/
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The application resource properties.
 */
model ApplicationResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility("read")
  provisioningState?: string;

  /**
* The version of the application type as defined in the application manifest.
This name must be the full Arm Resource ID for the referenced application type version.

*/
  version?: string;

  /**
   * List of application parameters with overridden values from their default values specified in the application manifest.
   */
  parameters?: Record<string>;

  /**
   * Describes the policy for a monitored application upgrade.
   */
  upgradePolicy?: ApplicationUpgradePolicy;

  /**
   * List of user assigned identities for the application, each mapped to a friendly name.
   */
  managedIdentities?: ApplicationUserAssignedIdentity[];
}

/**
 * Describes the policy for a monitored application upgrade.
 */
model ApplicationUpgradePolicy {
  /**
* Defines a health policy used to evaluate the health of an application or one of its children entities.

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

*/
model ApplicationHealthPolicy {
  /**
   * Indicates whether warnings are treated with the same severity as errors.
   */
  considerWarningAsError: boolean;

  /**
* The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.

*/
  maxPercentUnhealthyDeployedApplications: int32;

  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  serviceTypeHealthPolicyMap?: Record<ServiceTypeHealthPolicy>;
}

/**
* Represents the health policy used to evaluate the health of services belonging to a service type.

*/
model ServiceTypeHealthPolicy {
  /**
* The maximum allowed percentage of unhealthy services.

The percentage represents the maximum tolerated percentage of services that can be unhealthy before the application is considered in error.
If the percentage is respected but there is at least one unhealthy service, the health is evaluated as Warning.
This is calculated by dividing the number of unhealthy services of the specific service type over the total number of services of the specific service type.
The computation rounds up to tolerate one failure on small numbers of services.

*/
  @maxValue(100)
  maxPercentUnhealthyServices: int32;

  /**
* The maximum allowed percentage of unhealthy partitions per service.

The percentage represents the maximum tolerated percentage of partitions that can be unhealthy before the service is considered in error.
If the percentage is respected but there is at least one unhealthy partition, the health is evaluated as Warning.
The percentage is calculated by dividing the number of unhealthy partitions over the total number of partitions in the service.
The computation rounds up to tolerate one failure on small numbers of partitions.

*/
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService: int32;

  /**
* The maximum allowed percentage of unhealthy replicas per partition.

The percentage represents the maximum tolerated percentage of replicas that can be unhealthy before the partition is considered in error.
If the percentage is respected but there is at least one unhealthy replica, the health is evaluated as Warning.
The percentage is calculated by dividing the number of unhealthy replicas over the total number of replicas in the partition.
The computation rounds up to tolerate one failure on small numbers of replicas.

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
  healthCheckWaitDuration: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  healthCheckStableDuration: string;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  healthCheckRetryTimeout: string;

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  upgradeTimeout: string;

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format "hh:mm:ss.fff".
   */
  upgradeDomainTimeout: string;
}

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
 * Application update request
 */
model ApplicationUpdateParameters {
  /**
   * Application update parameters
   */
  tags?: Record<string>;
}

/**
 * The service resource properties.
 */
@discriminator("serviceKind")
model ServiceResourceProperties extends ServiceResourcePropertiesBase {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility("read")
  provisioningState?: string;

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
When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.

*/
  serviceDnsName?: string;
}

/**
 * Describes how the service is partitioned.
 */
@discriminator("partitionScheme")
model Partition {}

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
  correlationScheme?: ServiceCorrelation[];

  /**
   * The service load metrics is given as an array of ServiceLoadMetric objects.
   */
  serviceLoadMetrics?: ServiceLoadMetric[];

  /**
   * A list that describes the correlation of the service with other services.
   */
  servicePlacementPolicies?: ServicePlacementPolicy[];

  /**
   * Specifies the move cost for the service.
   */
  defaultMoveCost?: MoveCost;

  /**
   * Scaling policies for this service.
   */
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
model ServicePlacementPolicy {}

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
model ScalingMechanism {}

/**
 * Describes the trigger for performing a scaling operation.
 */
@discriminator("kind")
model ScalingTrigger {}

/**
 * Service update request
 */
model ServiceUpdateParameters {
  /**
   * Service update parameters
   */
  tags?: Record<string>;
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
  loadBalancingRules?: LoadBalancingRule[];

  /**
   * Setting this to true enables RDP access to the VM. The default NSG rule opens RDP port to Internet which can be overridden with custom Network Security Rules. The default value for this setting is false.
   */
  allowRdpAccess?: boolean;

  /**
   * Custom Network Security Rules that are applied to the Virtual Network of the cluster.
   */
  networkSecurityRules?: NetworkSecurityRule[];

  /**
   * Client certificates that are allowed to manage the cluster.
   */
  clients?: ClientCertificate[];

  /**
   * The AAD authentication settings of the cluster.
   */
  azureActiveDirectory?: AzureActiveDirectory;

  /**
   * The list of custom fabric settings to configure the cluster.
   */
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
   * Setting this to true enables automatic OS upgrade for the node types that are created using any platform OS image with version 'latest'. The default value for this setting is false.
   */
  enableAutoOSUpgrade?: boolean;

  /**
   * Indicates if the cluster has zone resiliency.
   */
  zonalResiliency?: boolean;

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
  ipTags?: IPTag[];

  /**
   * IPv6 address for the cluster if IPv6 is enabled.
   */
  @visibility("read")
  ipv6Address?: string;

  /**
   * Setting this to true will link the IPv4 address as the ServicePublicIP of the IPv6 address. It can only be set to True if IPv6 is enabled on the cluster.
   */
  enableServicePublicIP?: boolean;

  /**
   * Auxiliary subnets for the cluster.
   */
  auxiliarySubnets?: Subnet[];

  /**
   * Service endpoints for subnets in the cluster.
   */
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
   * Specify the resource id of a public IP prefix that the load balancer will allocate a public IP address from. Only supports IPv4.
   */
  publicIPPrefixId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;
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
 * IPTag associated with the object.
 */
model IPTag {
  /**
   * The IP tag type.
   */
  ipTagType: string;

  /**
   * The value of the IP tag.
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
 * Service Fabric managed cluster Sku definition
 */
model Sku {
  /**
   * Sku Name.
   */
  name: SkuName;
}

/**
 * The resource model definition.
 */
model Resource {
  /**
   * Azure resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Azure resource location.
   */
  @visibility("read", "create")
  location: string;

  /**
   * Azure resource tags.
   */
  tags?: Record<string>;

  /**
   * Azure resource etag.
   */
  @visibility("read")
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Managed cluster update request
 */
model ManagedClusterUpdateParameters {
  /**
   * Managed cluster update parameters
   */
  tags?: Record<string>;
}

/**
 * Describes the result of the request to list Managed VM Sizes for Service Fabric Managed Clusters.
 */
model ManagedAzResiliencyStatus {
  /**
   * List of Managed VM Sizes for Service Fabric Managed Clusters.
   */
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
}

/**
 * The result of the Service Fabric runtime versions
 */
model ManagedClusterCodeVersionResult {
  /**
   * The identification of the result
   */
  id?: string;

  /**
   * The name of the result
   */
  name?: string;

  /**
   * The result resource type
   */
  type?: string;

  /**
   * The detail of the Service Fabric runtime version result
   */
  properties?: ManagedClusterVersionDetails;
}

/**
 * The detail of the Service Fabric runtime version result
 */
model ManagedClusterVersionDetails {
  /**
   * The Service Fabric runtime version of the cluster.
   */
  clusterCodeVersion?: string;

  /**
   * The date of expiry of support of the version.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  supportExpiryUtc?: utcDateTime;

  /**
   * Cluster operating system, the default will be Windows
   */
  osType?: OsType;
}

/**
 * Describes the result of the request to list Managed VM Sizes for Service Fabric Managed Clusters.
 */
model ManagedVMSizesResult is Azure.Core.Page<ManagedVMSize>;

/**
 * Describes a VM Sizes.
 */
model ManagedVMSize {
  /**
   * VM Size properties.
   */
  @visibility("read")
  properties?: VMSize;

  /**
   * VM Size id.
   */
  @visibility("read")
  id?: string;

  /**
   * VM Size name.
   */
  @visibility("read")
  name?: string;

  /**
   * VM Size type.
   */
  @visibility("read")
  type?: string;
}

/**
 * VM Sizes properties.
 */
model VMSize {
  /**
   * VM Size name.
   */
  @visibility("read")
  size?: string;
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
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
model NodeTypeProperties {
  /**
   * Indicates the Service Fabric system services for the cluster will run on this node type. This setting cannot be changed once the node type is created.
   */
  isPrimary: boolean;

  /**
   * The number of nodes in the node type. <br /><br />**Values:** <br />-1 - Use when auto scale rules are configured or sku.capacity is defined <br /> 0 - Not supported <br /> >0 - Use for manual scale.
   */
  @maxValue(2147483647)
  @minValue(-1)
  vmInstanceCount: int32;

  /**
   * Disk size for the managed disk attached to the vms on the node type in GBs.
   */
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
  placementProperties?: Record<string>;

  /**
   * The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.
   */
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
  vmSecrets?: VaultSecretGroup[];

  /**
   * Set of extensions that should be installed onto the virtual machines.
   */
  vmExtensions?: VmssExtension[];

  /**
   * Identities to assign to the virtual machine scale set under the node type.
   */
  vmManagedIdentity?: VmManagedIdentity;

  /**
   * Indicates if the node type can only host Stateless workloads.
   */
  isStateless?: boolean;

  /**
   * Indicates if scale set associated with the node type can be composed of multiple placement groups.
   */
  multiplePlacementGroups?: boolean;

  /**
   * Indicates the node type uses its own frontend configurations instead of the default one for the cluster. This setting can only be specified for non-primary node types and can not be added or removed after the node type is created.
   */
  frontendConfigurations?: FrontendConfiguration[];

  /**
   * The Network Security Rules for this node type. This setting can only be specified for node types that are configured with frontend configurations.
   */
  networkSecurityRules?: NetworkSecurityRule[];

  /**
   * Additional managed data disks.
   */
  additionalDataDisks?: VmssDataDisk[];

  /**
   * Enable or disable the Host Encryption for the virtual machines on the node type. This will enable the encryption for all the disks including Resource/Temp disk at host itself. Default: The Encryption at host will be disabled unless this property is set to true for the resource.
   */
  enableEncryptionAtHost?: boolean;

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
  isSpotVM?: boolean;

  /**
   * Specifies the full host group resource Id. This property is used for deploying on azure dedicated hosts.
   */
  hostGroupId?: string;

  /**
   * Indicates whether to use ephemeral os disk. The sku selected on the vmSize property needs to support this feature.
   */
  useEphemeralOSDisk?: boolean;

  /**
   * Indicates the time duration after which the platform will not try to restore the VMSS SPOT instances specified as ISO 8601.
   */
  spotRestoreTimeout?: string;

  /**
   * Specifies the eviction policy for virtual machines in a SPOT node type. Default is Delete.
   */
  evictionPolicy?: EvictionPolicyType = EvictionPolicyType.Delete;

  /**
   * Indicates the resource id of the vm image. This parameter is used for custom vm image.
   */
  vmImageResourceId?: ResourceIdentifier<[
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
  subnetId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  /**
   * Specifies the actions to be performed on the vms before bootstrapping the service fabric runtime.
   */
  vmSetupActions?: VmSetupAction[];

  /**
   * Specifies the security type of the nodeType. Only TrustedLaunch is currently supported
   */
  securityType?: SecurityType;

  /**
   * Specifies whether secure boot should be enabled on the nodeType. Can only be used with TrustedLaunch SecurityType
   */
  secureBootEnabled?: boolean;

  /**
   * Specifies whether each node is allocated its own public IP address. This is only supported on secondary node types with custom Load Balancers.
   */
  enableNodePublicIP?: boolean;

  /**
   * Indicates the resource id of the vm shared galleries image. This parameter is used for custom vm image.
   */
  vmSharedGalleryImageId?: ResourceIdentifier<[
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
  natGatewayId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/natGateways";
    }
  ]>;

  /**
   * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started ->. Enter any required information and then click Save.
   */
  vmImagePlan?: VmImagePlan;
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
   * This is the URL of a certificate that has been uploaded to Key Vault as a secret. For adding a secret to the Key Vault, see [Add a key or secret to the key vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add). In this case, your certificate needs to be It is the Base64 encoding of the following JSON Object which is encoded in UTF-8: <br><br> {<br>  "data":"<Base64-encoded-certificate>",<br>  "dataType":"pfx",<br>  "password":"<pfx-file-password>"<br>}
   */
  certificateUrl: string;

  /**
   * For Windows VMs, specifies the certificate store on the Virtual Machine to which the certificate should be added. The specified certificate store is implicitly in the LocalMachine account. <br><br>For Linux VMs, the certificate file is placed under the /var/lib/waagent directory, with the file name <UppercaseThumbprint>.crt for the X509 certificate file and <UppercaseThumbprint>.prv for private key. Both of these files are .pem formatted.
   */
  certificateStore: string;
}

/**
 * Specifies set of extensions that should be installed onto the virtual machines.
 */
model VmssExtension {
  /**
   * The name of the extension.
   */
  name: string;

  /**
   * Describes the properties of a Virtual Machine Scale Set Extension.
   */
  properties: VmssExtensionProperties;
}

/**
 * Describes the properties of a Virtual Machine Scale Set Extension.
 */
model VmssExtensionProperties {
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
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  protectedSettings?: Record<unknown>;

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
   * The resource Id of the Load Balancer backend address pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/loadBalancers/<loadBalancerName>/backendAddressPools/<backendAddressPoolName>'.
   */
  loadBalancerBackendAddressPoolId?: string;

  /**
   * The resource Id of the Load Balancer inbound NAT pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/loadBalancers/<loadBalancerName>/inboundNatPools/<inboundNatPoolName>'.
   */
  loadBalancerInboundNatPoolId?: string;

  /**
   * The resource Id of application gateway backend address pool. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/applicationGateways/<applicationGatewayName>/backendAddressPools/<backendAddressPoolName>'.
   */
  applicationGatewayBackendAddressPoolId?: ResourceIdentifier<[
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
 * Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started ->. Enter any required information and then click Save.
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
 * Describes a node type sku.
 */
model NodeTypeSku {
  /**
   * The sku name. <br /><br />Name is internally generated and is used in auto-scale scenarios.<br /> Property does not allow to be changed to other values than generated.<br /> To avoid deployment errors please omit the property.
   */
  name?: string;

  /**
   * Specifies the tier of the node type. <br /><br /> Possible Values:<br /> **Standard**
   */
  tier?: string;

  /**
   * The number of nodes in the node type.<br /><br />If present in request it will override properties.vmInstanceCount.
   */
  @maxValue(2147483647)
  @minValue(1)
  capacity: int32;
}

/**
 * The resource model definition for proxy-only resource.
 */
model ManagedProxyResource {
  /**
   * Azure resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Azure resource tags.
   */
  @visibility("read", "create")
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility("read")
  systemData?: SystemData;
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
   * The type of resource the sku applies to.  <br /><br />Value: Microsoft.ServiceFabric/managedClusters/nodeTypes.
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
   * Specifies the tier of the node type. <br /><br /> Possible Values:<br /> **Standard**
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
 * Node type update request
 */
model NodeTypeUpdateParameters {
  /**
   * Node type update parameters
   */
  tags?: Record<string>;

  /**
   * The node type sku.
   */
  sku?: NodeTypeSku;
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
 * ServicePlacementNonPartiallyPlaceServicePolicy
 */
model ServicePlacementNonPartiallyPlaceServicePolicy
  extends ServicePlacementPolicy {
  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: "NonPartiallyPlaceService";
}

/**
* Describes the policy to be used for placement of a Service Fabric service where the service's 
Primary replicas should optimally be placed in a particular domain.

This placement policy is usually used with fault domains in scenarios where the Service Fabric
cluster is geographically distributed in order to indicate that a service's primary replica should
be located in a particular fault domain, which in geo-distributed scenarios usually aligns with regional
or datacenter boundaries. Note that since this is an optimization it is possible that the Primary replica
may not end up located in this domain due to failures, capacity limits, or other constraints.

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
* Describes the policy to be used for placement of a Service Fabric service where two replicas
from the same partition should never be placed in the same fault or upgrade domain.

While this is not common it can expose the service to an increased risk of concurrent failures
due to unplanned outages or other cases of subsequent/concurrent failures. As an example, consider
a case where replicas are deployed across different data center, with one replica per location.
In the event that one of the datacenters goes offline, normally the replica that was placed in that
datacenter will be packed into one of the remaining datacenters. If this is not desirable then this
policy should be set.

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
 * SingletonPartitionScheme
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
  replicaRestartWaitDuration?: string;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format "hh:mm:ss".
   */
  quorumLossWaitDuration?: string;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format "hh:mm:ss".
   */
  standByReplicaKeepDuration?: string;

  /**
   * The duration for which replicas can stay InBuild before reporting that build is stuck, represented in ISO 8601 format "hh:mm:ss".
   */
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
should be split between the partition ‘Count’

*/
  lowKey: int64;

  /**
* The upper bound of the partition key range that
should be split between the partition ‘Count’

*/
  highKey: int64;

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "UniformInt64Range";
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the operation.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
