import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.ServiceFabricManagedClusters;

interface Operations extends Azure.ResourceManager.Operations {}

enum FailureAction {
  @doc("Indicates that a rollback of the upgrade will be performed by Service Fabric if the upgrade fails.")
  Rollback,
  @doc("Indicates that a manual repair will need to be performed by the administrator if the upgrade fails. Service Fabric will not proceed to the next upgrade domain automatically.")
  Manual,
}

enum RollingUpgradeMode {
  @doc("The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 0.")
  Monitored,
  @doc("The upgrade will proceed automatically without performing any health monitoring. The value is 1.")
  UnmonitoredAuto,
}

enum ServiceKind {
  @doc("Does not use Service Fabric to make its state highly available or reliable. The value is 0.")
  Stateless,
  @doc("Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 1.")
  Stateful,
}

enum PartitionScheme {
  @doc("Indicates that the partition is based on string names, and is a SingletonPartitionScheme object, The value is 0.")
  Singleton,
  @doc("Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionScheme object. The value is 1.")
  UniformInt64Range,
  @doc("Indicates that the partition is based on string names, and is a NamedPartitionScheme object. The value is 2.")
  Named,
}

enum ServicePackageActivationMode {
  @doc("Indicates the application package activation mode will use shared process.")
  SharedProcess,
  @doc("Indicates the application package activation mode will use exclusive process.")
  ExclusiveProcess,
}

enum ServiceCorrelationScheme {
  @doc("Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 0.")
  AlignedAffinity,
  @doc("Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 1.")
  NonAlignedAffinity,
}

enum ServiceLoadMetricWeight {
  @doc("Disables resource balancing for this metric. This value is zero.") Zero,
  @doc("Specifies the metric weight of the service load as Low. The value is 1.")
  Low,
  @doc("Specifies the metric weight of the service load as Medium. The value is 2.")
  Medium,
  @doc("Specifies the metric weight of the service load as High. The value is 3.")
  High,
}

enum ServicePlacementPolicyType {
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 0.")
  InvalidDomain,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 1.")
  RequiredDomain,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 2.")
  PreferredPrimaryDomain,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 3.")
  RequiredDomainDistribution,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 4.")
  NonPartiallyPlaceService,
}

enum MoveCost {
  @doc("Zero move cost. This value is zero.") Zero,
  @doc("Specifies the move cost of the service as Low. The value is 1.") Low,
  @doc("Specifies the move cost of the service as Medium. The value is 2.")
  Medium,
  @doc("Specifies the move cost of the service as High. The value is 3.") High,
}

enum ServiceScalingMechanismKind {
  @doc("Represents a scaling mechanism for adding or removing instances of stateless service partition. The value is 0.")
  ScalePartitionInstanceCount,
  @doc("Represents a scaling mechanism for adding or removing named partitions of a stateless service. The value is 1.")
  AddRemoveIncrementalNamedPartition,
}

enum ServiceScalingTriggerKind {
  @doc("Represents a scaling trigger related to an average load of a metric/resource of a partition. The value is 0.")
  AveragePartitionLoadTrigger,
  @doc("Represents a scaling policy related to an average load of a metric/resource of a service. The value is 1.")
  AverageServiceLoadTrigger,
}

enum ClusterState {
  @doc("Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.")
  WaitingForNodes,
  @doc("Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.")
  Deploying,
  @doc("Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.")
  BaselineUpgrade,
  @doc("Indicates that the cluster is being upgraded with the user provided configuration.")
  Upgrading,
  @doc("Indicates that the last upgrade for the cluster has failed.")
  UpgradeFailed,
  @doc("Indicates that the cluster is in a stable state.") Ready,
}

enum Protocol {
  tcp,
  udp,
}

enum ProbeProtocol {
  tcp,
  http,
  https,
}

enum NsgProtocol {
  http,
  https,
  tcp,
  udp,
  icmp,
  ah,
  esp,
}

enum Access {
  allow,
  deny,
}

enum Direction {
  inbound,
  outbound,
}

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

enum ClusterUpgradeMode {
  @doc("The cluster will be automatically upgraded to the latest Service Fabric runtime version, **clusterUpgradeCadence** will determine when the upgrade starts after the new version becomes available.")
  Automatic,
  @doc("The cluster will not be automatically upgraded to the latest Service Fabric runtime version. The cluster is upgraded by setting the **clusterCodeVersion** property in the cluster resource.")
  Manual,
}

enum ClusterUpgradeCadence {
  @doc("Cluster upgrade starts immediately after a new version is rolled out. Recommended for Test/Dev clusters.")
  Wave0,
  @doc("Cluster upgrade starts 7 days after a new version is rolled out. Recommended for Pre-prod clusters.")
  Wave1,
  @doc("Cluster upgrade starts 14 days after a new version is rolled out. Recommended for Production clusters.")
  Wave2,
}

enum ManagedClusterAddOnFeature {
  @doc("Dns service") DnsService,
  @doc("Backup and restore service") BackupRestoreService,
  @doc("Resource monitor service") ResourceMonitorService,
}

enum PrivateEndpointNetworkPolicies {
  enabled,
  disabled,
}

enum PrivateLinkServiceNetworkPolicies {
  enabled,
  disabled,
}

enum ZonalUpdateMode {
  @doc("The cluster will use 5 upgrade domains for Cross Az Node types.")
  Standard,
  @doc("The cluster will use a maximum of 3 upgrade domains per zone instead of 5 for Cross Az Node types for faster deployments.")
  Fast,
}

enum SkuName {
  @doc("Basic requires a minimum of 3 nodes and allows only 1 node type.")
  Basic,
  @doc("Requires a minimum of 5 nodes and allows 1 or more node type.")
  Standard,
}

enum OsType {
  @doc("Indicates os is Windows.") Windows,
}

enum ManagedClusterVersionEnvironment {
  @doc("Windows.") Windows,
}

enum DiskType {
  @doc("Standard HDD locally redundant storage. Best for backup, non-critical, and infrequent access.")
  Standard_LRS,
  @doc("Standard SSD locally redundant storage. Best for web servers, lightly used enterprise applications and dev/test.")
  StandardSSD_LRS,
  @doc("Premium SSD locally redundant storage. Best for production and performance sensitive workloads.")
  Premium_LRS,
}

enum IPAddressType {
  @doc("IPv4 address type.") IPv4,
  @doc("IPv6 address type.") IPv6,
}

enum EvictionPolicyType {
  @doc("Eviction policy will be Delete for SPOT vms.") Delete,
  @doc("Eviction policy will be Deallocate for SPOT vms.") Deallocate,
}

enum VmSetupAction {
  @doc("Enable windows containers feature.") EnableContainers,
  @doc("Enables windows HyperV feature.") EnableHyperV,
}

enum SecurityType {
  @doc("Trusted Launch is a security type that secures generation 2 virtual machines.")
  TrustedLaunch,
}

enum UpdateType {
  @doc("The operation will proceed in all specified nodes at the same time.")
  Default,
  @doc("The operation will proceed one upgrade domain at a time, checking the health in between each to continue.")
  ByUpgradeDomain,
}

enum NodeTypeSkuScaleType {
  @doc("Node count is not adjustable in any way (e.g. it is fixed).") None,
  @doc("The user must manually scale out/in.") Manual,
  @doc("Automatic scale is allowed.") Automatic,
}
@Azure.Core.fixed
enum ManagedIdentityType {
  @doc("Indicates that no identity is associated with the resource.") None,
  @doc("Indicates that system assigned identity is associated with the resource.")
  SystemAssigned,
  @doc("Indicates that user assigned identity is associated with the resource.")
  UserAssigned,
  @doc("Indicates that both system assigned and user assigned identity are associated with the resource.")
  `SystemAssigned, UserAssigned`,
}

@doc("The application type name properties")
model ApplicationTypeResourceProperties {
  @doc("The current deployment or provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;
}

@doc("The structure of the error.")
@error
model ErrorModel {
  @doc("The error details.")
  error?: ErrorModelError;
}

@doc("The error details.")
model ErrorModelError {
  @doc("The error code.")
  code?: string;

  @doc("The error message.")
  message?: string;
}

@doc("Application type update request")
model ApplicationTypeUpdateParameters {
  @doc("Application type update parameters")
  tags?: Record<string>;
}

@doc("The properties of the application type version resource.")
model ApplicationTypeVersionResourceProperties {
  @doc("The current deployment or provisioning state, which only appears in the response")
  @visibility("read")
  provisioningState?: string;

  @doc("The URL to the application package")
  appPackageUrl: string;
}

@doc("Application type version update request")
model ApplicationTypeVersionUpdateParameters {
  @doc("Application type version update parameters")
  tags?: Record<string>;
}

@doc("Describes the managed identities for an Azure resource.")
model ManagedIdentity {
  @doc("The principal id of the managed identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant id of the managed identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The type of managed identity for the resource.")
  type?: ManagedIdentityType;

  @doc("""
The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.

""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("The application resource properties.")
model ApplicationResourceProperties {
  @doc("The current deployment or provisioning state, which only appears in the response")
  @visibility("read")
  provisioningState?: string;

  @doc("""
The version of the application type as defined in the application manifest.
This name must be the full Arm Resource ID for the referenced application type version.

""")
  version?: string;

  @doc("List of application parameters with overridden values from their default values specified in the application manifest.")
  parameters?: Record<string>;

  @doc("Describes the policy for a monitored application upgrade.")
  upgradePolicy?: ApplicationUpgradePolicy;

  @doc("List of user assigned identities for the application, each mapped to a friendly name.")
  managedIdentities?: ApplicationUserAssignedIdentity[];
}

@doc("Describes the policy for a monitored application upgrade.")
model ApplicationUpgradePolicy {
  @doc("""
Defines a health policy used to evaluate the health of an application or one of its children entities.

""")
  applicationHealthPolicy?: ApplicationHealthPolicy;

  @doc("If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).")
  forceRestart?: boolean;

  @doc("The policy used for monitoring the application upgrade")
  rollingUpgradeMonitoringPolicy?: RollingUpgradeMonitoringPolicy;

  @doc("Duration in seconds, to wait before a stateless instance is closed, to allow the active requests to drain gracefully. This would be effective when the instance is closing during the application/cluster upgrade, only for those instances which have a non-zero delay duration configured in the service description.")
  instanceCloseDelayDuration?: int32;

  @doc("The mode used to monitor health during a rolling upgrade. The values are Monitored, and UnmonitoredAuto.")
  upgradeMode?: RollingUpgradeMode;

  @doc("The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).")
  upgradeReplicaSetCheckTimeout?: int32;

  @doc("Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed.")
  recreateApplication?: boolean;
}

@doc("""
Defines a health policy used to evaluate the health of an application or one of its children entities.

""")
model ApplicationHealthPolicy {
  @doc("Indicates whether warnings are treated with the same severity as errors.")
  considerWarningAsError: boolean;

  @doc("""
The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.

""")
  maxPercentUnhealthyDeployedApplications: int32;

  @doc("The health policy used by default to evaluate the health of a service type.")
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  @doc("The map with service type health policy per service type name. The map is empty by default.")
  serviceTypeHealthPolicyMap?: Record<ServiceTypeHealthPolicy>;
}

@doc("""
Represents the health policy used to evaluate the health of services belonging to a service type.

""")
model ServiceTypeHealthPolicy {
  @doc("""
The maximum allowed percentage of unhealthy services.

The percentage represents the maximum tolerated percentage of services that can be unhealthy before the application is considered in error.
If the percentage is respected but there is at least one unhealthy service, the health is evaluated as Warning.
This is calculated by dividing the number of unhealthy services of the specific service type over the total number of services of the specific service type.
The computation rounds up to tolerate one failure on small numbers of services.

""")
  @maxValue(100)
  maxPercentUnhealthyServices: int32;

  @doc("""
The maximum allowed percentage of unhealthy partitions per service.

The percentage represents the maximum tolerated percentage of partitions that can be unhealthy before the service is considered in error.
If the percentage is respected but there is at least one unhealthy partition, the health is evaluated as Warning.
The percentage is calculated by dividing the number of unhealthy partitions over the total number of partitions in the service.
The computation rounds up to tolerate one failure on small numbers of partitions.

""")
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService: int32;

  @doc("""
The maximum allowed percentage of unhealthy replicas per partition.

The percentage represents the maximum tolerated percentage of replicas that can be unhealthy before the partition is considered in error.
If the percentage is respected but there is at least one unhealthy replica, the health is evaluated as Warning.
The percentage is calculated by dividing the number of unhealthy replicas over the total number of replicas in the partition.
The computation rounds up to tolerate one failure on small numbers of replicas.

""")
  @maxValue(100)
  maxPercentUnhealthyReplicasPerPartition: int32;
}

@doc("The policy used for monitoring the application upgrade")
model RollingUpgradeMonitoringPolicy {
  @doc("The compensating action to perform when a Monitored upgrade encounters monitoring policy or health policy violations. Invalid indicates the failure action is invalid. Rollback specifies that the upgrade will start rolling back automatically. Manual indicates that the upgrade will switch to UnmonitoredManual upgrade mode.")
  failureAction: FailureAction;

  @doc("The amount of time to wait after completing an upgrade domain before applying health policies. It is interpreted as a string representing an ISO 8601 duration with following format \"hh:mm:ss.fff\".")
  healthCheckWaitDuration: string;

  @doc("The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is interpreted as a string representing an ISO 8601 duration with following format \"hh:mm:ss.fff\".")
  healthCheckStableDuration: string;

  @doc("The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is interpreted as a string representing an ISO 8601 duration with following format \"hh:mm:ss.fff\".")
  healthCheckRetryTimeout: string;

  @doc("The amount of time the overall upgrade has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format \"hh:mm:ss.fff\".")
  upgradeTimeout: string;

  @doc("The amount of time each upgrade domain has to complete before FailureAction is executed. Cannot be larger than 12 hours. It is interpreted as a string representing an ISO 8601 duration with following format \"hh:mm:ss.fff\".")
  upgradeDomainTimeout: string;
}

model ApplicationUserAssignedIdentity {
  @doc("The friendly name of user assigned identity.")
  name: string;

  @doc("The principal id of user assigned identity.")
  principalId: string;
}

@doc("Application update request")
model ApplicationUpdateParameters {
  @doc("Application update parameters")
  tags?: Record<string>;
}

@doc("The service resource properties.")
@discriminator("serviceKind")
model ServiceResourceProperties extends ServiceResourcePropertiesBase {
  @doc("The current deployment or provisioning state, which only appears in the response")
  @visibility("read")
  provisioningState?: string;

  @doc("The name of the service type")
  serviceTypeName: string;

  @doc("Describes how the service is partitioned.")
  partitionDescription: Partition;

  @doc("The activation Mode of the service package")
  servicePackageActivationMode?: ServicePackageActivationMode;

  @doc("""
Dns name used for the service. If this is specified, then the DNS name can be used to return the IP addresses of service endpoints for application layer protocols (e.g., HTTP).
When updating serviceDnsName, old name may be temporarily resolvable. However, rely on new name.
When removing serviceDnsName, removed name may temporarily be resolvable. Do not rely on the name being unresolvable.

""")
  serviceDnsName?: string;
}

@doc("Describes how the service is partitioned.")
@discriminator("partitionScheme")
model Partition {}

@doc("The common service resource properties.")
model ServiceResourcePropertiesBase {
  @doc("The placement constraints as a string. Placement constraints are boolean expressions on node properties and allow for restricting a service to particular nodes based on the service requirements. For example, to place a service on nodes where NodeType is blue specify the following: \"NodeColor == blue)\".")
  placementConstraints?: string;

  @doc("A list that describes the correlation of the service with other services.")
  correlationScheme?: ServiceCorrelation[];

  @doc("The service load metrics is given as an array of ServiceLoadMetric objects.")
  serviceLoadMetrics?: ServiceLoadMetric[];

  @doc("A list that describes the correlation of the service with other services.")
  servicePlacementPolicies?: ServicePlacementPolicy[];

  @doc("Specifies the move cost for the service.")
  defaultMoveCost?: MoveCost;

  @doc("Scaling policies for this service.")
  scalingPolicies?: ScalingPolicy[];
}

@doc("Creates a particular correlation between services.")
model ServiceCorrelation {
  @doc("The ServiceCorrelationScheme which describes the relationship between this service and the service specified via ServiceName.")
  scheme: ServiceCorrelationScheme;

  @doc("The Arm Resource ID of the service that the correlation relationship is established with.")
  serviceName: string;
}

@doc("Specifies a metric to load balance a service during runtime.")
model ServiceLoadMetric {
  @doc("The name of the metric. If the service chooses to report load during runtime, the load metric name should match the name that is specified in Name exactly. Note that metric names are case sensitive.")
  name: string;

  @doc("The service load metric relative weight, compared to other metrics configured for this service, as a number.")
  weight?: ServiceLoadMetricWeight;

  @doc("Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Primary replica.")
  primaryDefaultLoad?: int32;

  @doc("Used only for Stateful services. The default amount of load, as a number, that this service creates for this metric when it is a Secondary replica.")
  secondaryDefaultLoad?: int32;

  @doc("Used only for Stateless services. The default amount of load, as a number, that this service creates for this metric.")
  defaultLoad?: int32;
}

@doc("Describes the policy to be used for placement of a Service Fabric service.")
@discriminator("type")
model ServicePlacementPolicy {}

@doc("Specifies a metric to load balance a service during runtime.")
model ScalingPolicy {
  @doc("Specifies the mechanism associated with this scaling policy")
  scalingMechanism: ScalingMechanism;

  @doc("Specifies the trigger associated with this scaling policy.")
  scalingTrigger: ScalingTrigger;
}

@doc("Describes the mechanism for performing a scaling operation.")
@discriminator("kind")
model ScalingMechanism {}

@doc("Describes the trigger for performing a scaling operation.")
@discriminator("kind")
model ScalingTrigger {}

@doc("Service update request")
model ServiceUpdateParameters {
  @doc("Service update parameters")
  tags?: Record<string>;
}

@doc("Describes the managed cluster resource properties.")
model ManagedClusterProperties {
  @doc("The cluster dns name.")
  dnsName: string;

  @doc("The fully qualified domain name associated with the public load balancer of the cluster.")
  @visibility("read")
  fqdn?: string;

  @doc("The IPv4 address associated with the public load balancer of the cluster.")
  @visibility("read")
  ipv4Address?: string;

  @doc("A service generated unique identifier for the cluster resource.")
  @visibility("read")
  clusterId?: string;

  @doc("The current state of the cluster.")
  @visibility("read")
  clusterState?: ClusterState;

  @doc("List of thumbprints of the cluster certificates.")
  @visibility("read")
  clusterCertificateThumbprints?: string[];

  @doc("The port used for client connections to the cluster.")
  clientConnectionPort?: int32;

  @doc("The port used for HTTP connections to the cluster.")
  httpGatewayConnectionPort?: int32;

  @doc("VM admin user name.")
  adminUserName: string;

  @doc("VM admin user password.")
  @secret
  adminPassword?: string;

  @doc("Load balancing rules that are applied to the public load balancer of the cluster.")
  loadBalancingRules?: LoadBalancingRule[];

  @doc("Setting this to true enables RDP access to the VM. The default NSG rule opens RDP port to Internet which can be overridden with custom Network Security Rules. The default value for this setting is false.")
  allowRdpAccess?: boolean;

  @doc("Custom Network Security Rules that are applied to the Virtual Network of the cluster.")
  networkSecurityRules?: NetworkSecurityRule[];

  @doc("Client certificates that are allowed to manage the cluster.")
  clients?: ClientCertificate[];

  @doc("The AAD authentication settings of the cluster.")
  azureActiveDirectory?: AzureActiveDirectory;

  @doc("The list of custom fabric settings to configure the cluster.")
  fabricSettings?: SettingsSectionDescription[];

  @doc("The provisioning state of the managed cluster resource.")
  @visibility("read")
  provisioningState?: ManagedResourceProvisioningState;

  @doc("The Service Fabric runtime version of the cluster. This property is required when **clusterUpgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](./ClusterVersion.md). To get the list of available version for existing clusters use **availableClusterVersions**.")
  clusterCodeVersion?: string;

  @doc("""
The upgrade mode of the cluster when new Service Fabric runtime version is available.

""")
  clusterUpgradeMode?: ClusterUpgradeMode;

  @doc("Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **clusterUpgradeMode** is set to 'Automatic'.")
  clusterUpgradeCadence?: ClusterUpgradeCadence;

  @doc("List of add-on features to enable on the cluster.")
  addonFeatures?: ManagedClusterAddOnFeature[];

  @doc("Setting this to true enables automatic OS upgrade for the node types that are created using any platform OS image with version 'latest'. The default value for this setting is false.")
  enableAutoOSUpgrade?: boolean;

  @doc("Indicates if the cluster has zone resiliency.")
  zonalResiliency?: boolean;

  @doc("The policy used to clean up unused versions.")
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  @doc("Setting this to true creates IPv6 address space for the default VNet used by the cluster. This setting cannot be changed once the cluster is created. The default value for this setting is false.")
  enableIpv6?: boolean;

  @doc("If specified, the node types for the cluster are created in this subnet instead of the default VNet. The **networkSecurityRules** specified for the cluster are also applied to this subnet. This setting cannot be changed once the cluster is created.")
  subnetId?: string;

  @doc("The list of IP tags associated with the default public IP address of the cluster.")
  ipTags?: IPTag[];

  @doc("IPv6 address for the cluster if IPv6 is enabled.")
  @visibility("read")
  ipv6Address?: string;

  @doc("Setting this to true will link the IPv4 address as the ServicePublicIP of the IPv6 address. It can only be set to True if IPv6 is enabled on the cluster.")
  enableServicePublicIP?: boolean;

  @doc("Auxiliary subnets for the cluster.")
  auxiliarySubnets?: Subnet[];

  @doc("Service endpoints for subnets in the cluster.")
  serviceEndpoints?: ServiceEndpoint[];

  @doc("Indicates the update mode for Cross Az clusters.")
  zonalUpdateMode?: ZonalUpdateMode;

  @doc("For new clusters, this parameter indicates that it uses Bring your own VNet, but the subnet is specified at node type level; and for such clusters, the subnetId property is required for node types.")
  useCustomVnet?: boolean;

  @doc("Specify the resource id of a public IP prefix that the load balancer will allocate a public IP address from. Only supports IPv4.")
  publicIPPrefixId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;
}

@doc("Describes a load balancing rule.")
model LoadBalancingRule {
  @doc("The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer. Acceptable values are between 1 and 65534.")
  @maxValue(65534)
  @minValue(1)
  frontendPort: int32;

  @doc("The port used for internal connections on the endpoint. Acceptable values are between 1 and 65535.")
  @maxValue(65534)
  @minValue(1)
  backendPort: int32;

  @doc("The reference to the transport protocol used by the load balancing rule.")
  protocol: Protocol;

  @doc("The prob port used by the load balancing rule. Acceptable values are between 1 and 65535.")
  @maxValue(65534)
  @minValue(1)
  probePort?: int32;

  @doc("the reference to the load balancer probe used by the load balancing rule.")
  probeProtocol: ProbeProtocol;

  @doc("The probe request path. Only supported for HTTP/HTTPS probes.")
  probeRequestPath?: string;

  @doc("The load distribution policy for this rule.")
  loadDistribution?: string;
}

@doc("Describes a network security rule.")
model NetworkSecurityRule {
  @doc("Network security rule name.")
  name: string;

  @doc("Network security rule description.")
  description?: string;

  @doc("Network protocol this rule applies to.")
  protocol: NsgProtocol;

  @doc("The CIDR or source IP ranges.")
  sourceAddressPrefixes?: string[];

  @doc("The destination address prefixes. CIDR or destination IP ranges.")
  destinationAddressPrefixes?: string[];

  @doc("The source port ranges.")
  sourcePortRanges?: string[];

  @doc("The destination port ranges.")
  destinationPortRanges?: string[];

  @doc("The CIDR or source IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. If this is an ingress rule, specifies where network traffic originates from.")
  sourceAddressPrefix?: string;

  @doc("The destination address prefix. CIDR or destination IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used.")
  destinationAddressPrefix?: string;

  @doc("The source port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.")
  sourcePortRange?: string;

  @doc("he destination port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.")
  destinationPortRange?: string;

  @doc("The network traffic is allowed or denied.")
  access: Access;

  @doc("The priority of the rule. The value can be in the range 1000 to 3000. Values outside this range are reserved for Service Fabric ManagerCluster Resource Provider. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.")
  @maxValue(3000)
  @minValue(1000)
  priority: int32;

  @doc("Network security rule direction.")
  direction: Direction;
}

@doc("Client certificate definition.")
model ClientCertificate {
  @doc("Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.")
  isAdmin: boolean;

  @doc("Certificate thumbprint.")
  thumbprint?: string;

  @doc("Certificate common name.")
  commonName?: string;

  @doc("Issuer thumbprint for the certificate. Only used together with CommonName.")
  issuerThumbprint?: string;
}

@doc("The settings to enable AAD authentication on the cluster.")
model AzureActiveDirectory {
  @doc("Azure active directory tenant id.")
  tenantId?: string;

  @doc("Azure active directory cluster application id.")
  clusterApplication?: string;

  @doc("Azure active directory client application id.")
  clientApplication?: string;
}

@doc("Describes a section in the fabric settings of the cluster.")
model SettingsSectionDescription {
  @doc("The section name of the fabric settings.")
  name: string;

  @doc("The collection of parameters in the section.")
  parameters: SettingsParameterDescription[];
}

@doc("Describes a parameter in fabric settings of the cluster.")
model SettingsParameterDescription {
  @doc("The parameter name of fabric setting.")
  name: string;

  @doc("The parameter value of fabric setting.")
  value: string;
}

@doc("The policy used to clean up unused versions. When the policy is not specified explicitly, the default unused application versions to keep will be 3.")
model ApplicationTypeVersionsCleanupPolicy {
  @doc("Number of unused versions per application type to keep.")
  maxUnusedVersionsToKeep: int32;
}

@doc("IPTag associated with the object.")
model IPTag {
  @doc("The IP tag type.")
  ipTagType: string;

  @doc("The value of the IP tag.")
  tag: string;
}

@doc("Describes a Subnet.")
model Subnet {
  @doc("Subnet name.")
  name: string;

  @doc("Indicates wether to enable Ipv6 or not. If not provided, it will take the same configuration as the cluster.")
  enableIpv6?: boolean;

  @doc("Enable or Disable apply network policies on private end point in the subnet.")
  privateEndpointNetworkPolicies?: PrivateEndpointNetworkPolicies;

  @doc("Enable or Disable apply network policies on private link service in the subnet.")
  privateLinkServiceNetworkPolicies?: PrivateLinkServiceNetworkPolicies;

  @doc("Full resource id for the network security group.")
  networkSecurityGroupId?: string;
}

@doc("The service endpoint properties.")
model ServiceEndpoint {
  @doc("The type of the endpoint service.")
  service: string;

  @doc("A list of locations.")
  locations?: string[];
}

@doc("Service Fabric managed cluster Sku definition")
model Sku {
  @doc("Sku Name.")
  name: SkuName;
}

@doc("The resource model definition.")
model Resource {
  @doc("Azure resource identifier.")
  @visibility("read")
  id?: string;

  @doc("Azure resource name.")
  @visibility("read")
  name?: string;

  @doc("Azure resource type.")
  @visibility("read")
  type?: string;

  @doc("Azure resource location.")
  @visibility("read", "create")
  location: string;

  @doc("Azure resource tags.")
  tags?: Record<string>;

  @doc("Azure resource etag.")
  @visibility("read")
  etag?: string;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Managed cluster update request")
model ManagedClusterUpdateParameters {
  @doc("Managed cluster update parameters")
  tags?: Record<string>;
}

@doc("Describes the result of the request to list Managed VM Sizes for Service Fabric Managed Clusters.")
model ManagedAzResiliencyStatus {
  @doc("List of Managed VM Sizes for Service Fabric Managed Clusters.")
  baseResourceStatus?: ResourceAzStatus[];

  @doc("URL to get the next set of Managed VM Sizes if there are any.")
  @visibility("read")
  isClusterZoneResilient?: boolean;
}

@doc("Describes Az Resiliency status of Base resources")
model ResourceAzStatus {
  @doc("VM Size properties.")
  @visibility("read")
  resourceName?: string;

  @doc("VM Size id.")
  @visibility("read")
  resourceType?: string;

  @doc("VM Size name.")
  @visibility("read")
  isZoneResilient?: boolean;
}

@doc("The result of the Service Fabric runtime versions")
model ManagedClusterCodeVersionResult {
  @doc("The identification of the result")
  id?: string;

  @doc("The name of the result")
  name?: string;

  @doc("The result resource type")
  type?: string;

  @doc("The detail of the Service Fabric runtime version result")
  properties?: ManagedClusterVersionDetails;
}

@doc("The detail of the Service Fabric runtime version result")
model ManagedClusterVersionDetails {
  @doc("The Service Fabric runtime version of the cluster.")
  clusterCodeVersion?: string;

  @doc("The date of expiry of support of the version.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  supportExpiryUtc?: utcDateTime;

  @doc("Cluster operating system, the default will be Windows")
  osType?: OsType;
}

@doc("Describes the result of the request to list Managed VM Sizes for Service Fabric Managed Clusters.")
model ManagedVMSizesResult is Azure.Core.Page<ManagedVMSize>;

@doc("Describes a VM Sizes.")
model ManagedVMSize {
  @doc("VM Size properties.")
  @visibility("read")
  properties?: VMSize;

  @doc("VM Size id.")
  @visibility("read")
  id?: string;

  @doc("VM Size name.")
  @visibility("read")
  name?: string;

  @doc("VM Size type.")
  @visibility("read")
  type?: string;
}

@doc("VM Sizes properties.")
model VMSize {
  @doc("VM Size name.")
  @visibility("read")
  size?: string;
}

@doc("Available operation list result")
model OperationResult {
  @doc("The name of the operation.")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("The object that represents the operation.")
  display?: AvailableOperationDisplay;

  @doc("Origin result")
  origin?: string;

  @doc("The URL to use for getting the next set of results.")
  nextLink?: string;
}

@doc("Operation supported by the Service Fabric resource provider")
model AvailableOperationDisplay {
  @doc("The name of the provider.")
  provider?: string;

  @doc("The resource on which the operation is performed")
  resource?: string;

  @doc("The operation that can be performed.")
  operation?: string;

  @doc("Operation description")
  description?: string;
}

@doc("Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.")
model NodeTypeProperties {
  @doc("Indicates the Service Fabric system services for the cluster will run on this node type. This setting cannot be changed once the node type is created.")
  isPrimary: boolean;

  @doc("The number of nodes in the node type. <br /><br />**Values:** <br />-1 - Use when auto scale rules are configured or sku.capacity is defined <br /> 0 - Not supported <br /> >0 - Use for manual scale.")
  @maxValue(2147483647)
  @minValue(-1)
  vmInstanceCount: int32;

  @doc("Disk size for the managed disk attached to the vms on the node type in GBs.")
  dataDiskSizeGB?: int32;

  @doc("Managed data disk type. Specifies the storage account type for the managed disk")
  dataDiskType?: DiskType;

  @doc("Managed data disk letter. It can not use the reserved letter C or D and it can not change after created.")
  @pattern("^[a-zA-Z]{1}$")
  dataDiskLetter?: string;

  @doc("The placement tags applied to nodes in the node type, which can be used to indicate where certain services (workload) should run.")
  placementProperties?: Record<string>;

  @doc("The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.")
  capacities?: Record<string>;

  @doc("The range of ports from which cluster assigned port to Service Fabric applications.")
  applicationPorts?: EndpointRangeDescription;

  @doc("The range of ephemeral ports that nodes in this node type should be configured with.")
  ephemeralPorts?: EndpointRangeDescription;

  @doc("The size of virtual machines in the pool. All virtual machines in a pool are the same size. For example, Standard_D3.")
  vmSize?: string;

  @doc("The publisher of the Azure Virtual Machines Marketplace image. For example, Canonical or MicrosoftWindowsServer.")
  vmImagePublisher?: string;

  @doc("The offer type of the Azure Virtual Machines Marketplace image. For example, UbuntuServer or WindowsServer.")
  vmImageOffer?: string;

  @doc("The SKU of the Azure Virtual Machines Marketplace image. For example, 14.04.0-LTS or 2012-R2-Datacenter.")
  vmImageSku?: string;

  @doc("The version of the Azure Virtual Machines Marketplace image. A value of 'latest' can be specified to select the latest version of an image. If omitted, the default is 'latest'.")
  vmImageVersion?: string;

  @doc("The secrets to install in the virtual machines.")
  vmSecrets?: VaultSecretGroup[];

  @doc("Set of extensions that should be installed onto the virtual machines.")
  vmExtensions?: VmssExtension[];

  @doc("Identities to assign to the virtual machine scale set under the node type.")
  vmManagedIdentity?: VmManagedIdentity;

  @doc("Indicates if the node type can only host Stateless workloads.")
  isStateless?: boolean;

  @doc("Indicates if scale set associated with the node type can be composed of multiple placement groups.")
  multiplePlacementGroups?: boolean;

  @doc("Indicates the node type uses its own frontend configurations instead of the default one for the cluster. This setting can only be specified for non-primary node types and can not be added or removed after the node type is created.")
  frontendConfigurations?: FrontendConfiguration[];

  @doc("The Network Security Rules for this node type. This setting can only be specified for node types that are configured with frontend configurations.")
  networkSecurityRules?: NetworkSecurityRule[];

  @doc("Additional managed data disks.")
  additionalDataDisks?: VmssDataDisk[];

  @doc("Enable or disable the Host Encryption for the virtual machines on the node type. This will enable the encryption for all the disks including Resource/Temp disk at host itself. Default: The Encryption at host will be disabled unless this property is set to true for the resource.")
  enableEncryptionAtHost?: boolean;

  @doc("The provisioning state of the node type resource.")
  @visibility("read")
  provisioningState?: ManagedResourceProvisioningState;

  @doc("Specifies whether the network interface is accelerated networking-enabled.")
  enableAcceleratedNetworking?: boolean;

  @doc("Specifies whether the use public load balancer. If not specified and the node type doesn't have its own frontend configuration, it will be attached to the default load balancer. If the node type uses its own Load balancer and useDefaultPublicLoadBalancer is true, then the frontend has to be an Internal Load Balancer. If the node type uses its own Load balancer and useDefaultPublicLoadBalancer is false or not set, then the custom load balancer must include a public load balancer to provide outbound connectivity.")
  useDefaultPublicLoadBalancer?: boolean;

  @doc("Specifies whether to use the temporary disk for the service fabric data root, in which case no managed data disk will be attached and the temporary disk will be used. It is only allowed for stateless node types.")
  useTempDataDisk?: boolean;

  @doc("Specifies whether the node type should be overprovisioned. It is only allowed for stateless node types.")
  enableOverProvisioning?: boolean;

  @doc("Specifies the availability zones where the node type would span across. If the cluster is not spanning across availability zones, initiates az migration for the cluster.")
  zones?: string[];

  @doc("Indicates whether the node type will be Spot Virtual Machines. Azure will allocate the VMs if there is capacity available and the VMs can be evicted at any time.")
  isSpotVM?: boolean;

  @doc("Specifies the full host group resource Id. This property is used for deploying on azure dedicated hosts.")
  hostGroupId?: string;

  @doc("Indicates whether to use ephemeral os disk. The sku selected on the vmSize property needs to support this feature.")
  useEphemeralOSDisk?: boolean;

  @doc("Indicates the time duration after which the platform will not try to restore the VMSS SPOT instances specified as ISO 8601.")
  spotRestoreTimeout?: string;

  @doc("Specifies the eviction policy for virtual machines in a SPOT node type. Default is Delete.")
  evictionPolicy?: EvictionPolicyType;

  @doc("Indicates the resource id of the vm image. This parameter is used for custom vm image.")
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

  @doc("Indicates the resource id of the subnet for the node type.")
  subnetId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @doc("Specifies the actions to be performed on the vms before bootstrapping the service fabric runtime.")
  vmSetupActions?: VmSetupAction[];

  @doc("Specifies the security type of the nodeType. Only TrustedLaunch is currently supported")
  securityType?: SecurityType;

  @doc("Specifies whether secure boot should be enabled on the nodeType. Can only be used with TrustedLaunch SecurityType")
  secureBootEnabled?: boolean;

  @doc("Specifies whether each node is allocated its own public IP address. This is only supported on secondary node types with custom Load Balancers.")
  enableNodePublicIP?: boolean;

  @doc("Indicates the resource id of the vm shared galleries image. This parameter is used for custom vm image.")
  vmSharedGalleryImageId?: ResourceIdentifier<[
    {
      type: "Microsoft.Compute/sharedGalleries/images";
    },
    {
      type: "Microsoft.Compute/sharedGalleries/images/versions";
    }
  ]>;

  @doc("Specifies the resource id of a NAT Gateway to attach to the subnet of this node type. Node type must use custom load balancer.")
  natGatewayId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/natGateways";
    }
  ]>;

  @doc("Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started ->. Enter any required information and then click Save.")
  vmImagePlan?: VmImagePlan;
}

@doc("Port range details")
model EndpointRangeDescription {
  @doc("Starting port of a range of ports")
  startPort: int32;

  @doc("End port of a range of ports")
  endPort: int32;
}

@doc("Specifies set of certificates that should be installed onto the virtual machines.")
model VaultSecretGroup {
  @doc("The relative URL of the Key Vault containing all of the certificates in VaultCertificates.")
  sourceVault: SubResource;

  @doc("The list of key vault references in SourceVault which contain certificates.")
  vaultCertificates: VaultCertificate[];
}

@doc("Azure resource identifier.")
model SubResource {
  @doc("Azure resource identifier.")
  id?: string;
}

@doc("Describes a single certificate reference in a Key Vault, and where the certificate should reside on the VM.")
model VaultCertificate {
  @doc("This is the URL of a certificate that has been uploaded to Key Vault as a secret. For adding a secret to the Key Vault, see [Add a key or secret to the key vault](https://docs.microsoft.com/azure/key-vault/key-vault-get-started/#add). In this case, your certificate needs to be It is the Base64 encoding of the following JSON Object which is encoded in UTF-8: <br><br> {<br>  \"data\":\"<Base64-encoded-certificate>\",<br>  \"dataType\":\"pfx\",<br>  \"password\":\"<pfx-file-password>\"<br>}")
  certificateUrl: string;

  @doc("For Windows VMs, specifies the certificate store on the Virtual Machine to which the certificate should be added. The specified certificate store is implicitly in the LocalMachine account. <br><br>For Linux VMs, the certificate file is placed under the /var/lib/waagent directory, with the file name <UppercaseThumbprint>.crt for the X509 certificate file and <UppercaseThumbprint>.prv for private key. Both of these files are .pem formatted.")
  certificateStore: string;
}

@doc("Specifies set of extensions that should be installed onto the virtual machines.")
model VmssExtension {
  @doc("The name of the extension.")
  name: string;

  @doc("Describes the properties of a Virtual Machine Scale Set Extension.")
  properties: VmssExtensionProperties;
}

@doc("Describes the properties of a Virtual Machine Scale Set Extension.")
model VmssExtensionProperties {
  @doc("The name of the extension handler publisher.")
  publisher: string;

  @doc("Specifies the type of the extension; an example is \"CustomScriptExtension\".")
  type: string;

  @doc("Specifies the version of the script handler.")
  typeHandlerVersion: string;

  @doc("Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.")
  autoUpgradeMinorVersion?: boolean;

  @doc("Json formatted public settings for the extension.")
  settings?: Record<unknown>;

  @doc("The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.")
  protectedSettings?: Record<unknown>;

  @doc("If a value is provided and is different from the previous value, the extension handler will be forced to update even if the extension configuration has not changed.")
  forceUpdateTag?: string;

  @doc("Collection of extension names after which this extension needs to be provisioned.")
  provisionAfterExtensions?: string[];

  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("Indicates whether the extension should be automatically upgraded by the platform if there is a newer version of the extension available.")
  enableAutomaticUpgrade?: boolean;
}

@doc("Identities for the virtual machine scale set under the node type.")
model VmManagedIdentity {
  @doc("The list of user identities associated with the virtual machine scale set under the node type. Each entry will be an ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: string[];
}

@doc("Describes the frontend configurations for the node type.")
model FrontendConfiguration {
  @doc("The IP address type of this frontend configuration. If omitted the default value is IPv4.")
  ipAddressType?: IPAddressType;

  @doc("The resource Id of the Load Balancer backend address pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/loadBalancers/<loadBalancerName>/backendAddressPools/<backendAddressPoolName>'.")
  loadBalancerBackendAddressPoolId?: string;

  @doc("The resource Id of the Load Balancer inbound NAT pool that the VM instances of the node type are associated with. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/loadBalancers/<loadBalancerName>/inboundNatPools/<inboundNatPoolName>'.")
  loadBalancerInboundNatPoolId?: string;

  @doc("The resource Id of application gateway backend address pool. The format of the resource Id is '/subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName>/providers/Microsoft.Network/applicationGateways/<applicationGatewayName>/backendAddressPools/<backendAddressPoolName>'.")
  applicationGatewayBackendAddressPoolId?: ResourceIdentifier<[
    {
      type: "Microsoft.Network/applicationGateways/backendAddressPools";
    }
  ]>;
}

@doc("Managed data disk description.")
model VmssDataDisk {
  @doc("Specifies the logical unit number of the data disk. This value is used to identify data disks within the VM and therefore must be unique for each data disk attached to a VM. Lun 0 is reserved for the service fabric data disk.")
  @minValue(1)
  lun: int32;

  @doc("Disk size for each vm in the node type in GBs.")
  diskSizeGB: int32;

  @doc("Managed data disk type. Specifies the storage account type for the managed disk")
  diskType: DiskType;

  @doc("Managed data disk letter. It can not use the reserved letter C or D and it can not change after created.")
  @pattern("^[a-zA-Z]{1}$")
  diskLetter: string;
}

@doc("Specifies information about the marketplace image used to create the virtual machine. This element is only used for marketplace images. Before you can use a marketplace image from an API, you must enable the image for programmatic use. In the Azure portal, find the marketplace image that you want to use and then click Want to deploy programmatically, Get Started ->. Enter any required information and then click Save.")
model VmImagePlan {
  @doc("The plan ID.")
  name?: string;

  @doc("Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element.")
  product?: string;

  @doc("The promotion code.")
  promotionCode?: string;

  @doc("The publisher ID.")
  publisher?: string;
}

@doc("Describes a node type sku.")
model NodeTypeSku {
  @doc("The sku name. <br /><br />Name is internally generated and is used in auto-scale scenarios.<br /> Property does not allow to be changed to other values than generated.<br /> To avoid deployment errors please omit the property.")
  name?: string;

  @doc("Specifies the tier of the node type. <br /><br /> Possible Values:<br /> **Standard**")
  tier?: string;

  @doc("The number of nodes in the node type.<br /><br />If present in request it will override properties.vmInstanceCount.")
  @maxValue(2147483647)
  @minValue(1)
  capacity: int32;
}

@doc("The resource model definition for proxy-only resource.")
model ManagedProxyResource {
  @doc("Azure resource identifier.")
  @visibility("read")
  id?: string;

  @doc("Azure resource name.")
  @visibility("read")
  name?: string;

  @doc("Azure resource type.")
  @visibility("read")
  type?: string;

  @doc("Azure resource tags.")
  @visibility("read", "create")
  tags?: Record<string>;

  @doc("Metadata pertaining to creation and last modification of the resource.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Parameters for Node type action. If nodes are not specified on the parameters, the operation will be performed in all nodes of the node type one upgrade domain at a time.")
model NodeTypeActionParameters {
  @doc("List of node names from the node type.")
  nodes?: string[];

  @doc("Force the action to go through.")
  force?: boolean;

  @doc("Specifies the way the operation will be performed.")
  updateType?: UpdateType;
}

@doc("Node type available sku list results")
model NodeTypeListSkuResult is Azure.Core.Page<NodeTypeAvailableSku>;

@doc("Defines the type of sku available for a node type")
model NodeTypeAvailableSku {
  @doc("The type of resource the sku applies to.  <br /><br />Value: Microsoft.ServiceFabric/managedClusters/nodeTypes.")
  @visibility("read")
  resourceType?: string;

  @doc("The supported SKU for a for node type.")
  @visibility("read")
  sku?: NodeTypeSupportedSku;

  @doc("Provides information about how the node count can be scaled.")
  @visibility("read")
  capacity?: NodeTypeSkuCapacity;
}

@doc("Describes a node type supported sku.")
model NodeTypeSupportedSku {
  @doc("The sku name.")
  @visibility("read")
  name?: string;

  @doc("Specifies the tier of the node type. <br /><br /> Possible Values:<br /> **Standard**")
  @visibility("read")
  tier?: string;
}

@doc("Provides information about how node type can be scaled.")
model NodeTypeSkuCapacity {
  @doc("Lowest permitted node count in a node type.")
  @visibility("read")
  minimum?: int32;

  @doc("Highest permitted node count in a node type.")
  @visibility("read")
  maximum?: int32;

  @doc("Default node count in a node type.")
  @visibility("read")
  default?: int32;

  @doc("Node type capacity scale type.")
  @visibility("read")
  scaleType?: NodeTypeSkuScaleType;
}

@doc("Node type update request")
model NodeTypeUpdateParameters {
  @doc("Node type update parameters")
  tags?: Record<string>;

  @doc("The node type sku.")
  sku?: NodeTypeSku;
}

@doc("Represents a scaling mechanism for adding or removing named partitions of a stateless service. Partition names are in the format '0','1'...'N-1'.")
model AddRemoveIncrementalNamedPartitionScalingMechanism
  extends ScalingMechanism {
  @doc("Minimum number of named partitions of the service.")
  minPartitionCount: int32;

  @doc("Maximum number of named partitions of the service.")
  maxPartitionCount: int32;

  @doc("The number of instances to add or remove during a scaling operation.")
  scaleIncrement: int32;

  @doc("Specifies the mechanism associated with this scaling policy.")
  kind: "AddRemoveIncrementalNamedPartition";
}

@doc("Represents a scaling trigger related to an average load of a metric/resource of a partition.")
model AveragePartitionLoadScalingTrigger extends ScalingTrigger {
  @doc("The name of the metric for which usage should be tracked.")
  metricName: string;

  @doc("The lower limit of the load below which a scale in operation should be performed.")
  lowerLoadThreshold: float32;

  @doc("The upper limit of the load beyond which a scale out operation should be performed.")
  upperLoadThreshold: float32;

  @doc("The period in seconds on which a decision is made whether to scale or not. This property should come in ISO 8601 format \"hh:mm:ss\".")
  scaleInterval: string;

  @doc("Specifies the trigger associated with this scaling policy.")
  kind: "AveragePartitionLoadTrigger";
}

@doc("Represents a scaling policy related to an average load of a metric/resource of a service.")
model AverageServiceLoadScalingTrigger extends ScalingTrigger {
  @doc("The name of the metric for which usage should be tracked.")
  metricName: string;

  @doc("The lower limit of the load below which a scale in operation should be performed.")
  lowerLoadThreshold: float32;

  @doc("The upper limit of the load beyond which a scale out operation should be performed.")
  upperLoadThreshold: float32;

  @doc("The period in seconds on which a decision is made whether to scale or not. This property should come in ISO 8601 format \"hh:mm:ss\".")
  scaleInterval: string;

  @doc("Flag determines whether only the load of primary replica should be considered for scaling. If set to true, then trigger will only consider the load of primary replicas of stateful service. If set to false, trigger will consider load of all replicas. This parameter cannot be set to true for stateless service.")
  useOnlyPrimaryLoad: boolean;

  @doc("Specifies the trigger associated with this scaling policy.")
  kind: "AverageServiceLoadTrigger";
}

@doc("Describes the named partition scheme of the service.")
model NamedPartitionScheme extends Partition {
  @doc("Array for the names of the partitions.")
  names: string[];

  @doc("Specifies how the service is partitioned.")
  partitionScheme: "Named";
}

@doc("Represents a scaling mechanism for adding or removing instances of stateless service partition.")
model PartitionInstanceCountScaleMechanism extends ScalingMechanism {
  @doc("Minimum number of instances of the partition.")
  minInstanceCount: int32;

  @doc("Maximum number of instances of the partition.")
  maxInstanceCount: int32;

  @doc("The number of instances to add or remove during a scaling operation.")
  scaleIncrement: int32;

  @doc("Specifies the mechanism associated with this scaling policy.")
  kind: "ScalePartitionInstanceCount";
}

@doc("Describes the policy to be used for placement of a Service Fabric service where a particular fault or upgrade domain should not be used for placement of the instances or replicas of that service.")
model ServicePlacementInvalidDomainPolicy extends ServicePlacementPolicy {
  @doc("The name of the domain that should not be used for placement.")
  domainName: string;

  @doc("The type of placement policy for a service fabric service. Following are the possible values.")
  type: "InvalidDomain";
}

@doc("ServicePlacementNonPartiallyPlaceServicePolicy")
model ServicePlacementNonPartiallyPlaceServicePolicy
  extends ServicePlacementPolicy {
  @doc("The type of placement policy for a service fabric service. Following are the possible values.")
  type: "NonPartiallyPlaceService";
}

@doc("""
Describes the policy to be used for placement of a Service Fabric service where the service's 
Primary replicas should optimally be placed in a particular domain.

This placement policy is usually used with fault domains in scenarios where the Service Fabric
cluster is geographically distributed in order to indicate that a service's primary replica should
be located in a particular fault domain, which in geo-distributed scenarios usually aligns with regional
or datacenter boundaries. Note that since this is an optimization it is possible that the Primary replica
may not end up located in this domain due to failures, capacity limits, or other constraints.

""")
model ServicePlacementPreferPrimaryDomainPolicy extends ServicePlacementPolicy {
  @doc("The name of the domain that should used for placement as per this policy.")
  domainName: string;

  @doc("The type of placement policy for a service fabric service. Following are the possible values.")
  type: "PreferredPrimaryDomain";
}

@doc("Describes the policy to be used for placement of a Service Fabric service where the instances or replicas of that service must be placed in a particular domain.")
model ServicePlacementRequiredDomainPolicy extends ServicePlacementPolicy {
  @doc("The name of the domain that should used for placement as per this policy.")
  domainName: string;

  @doc("The type of placement policy for a service fabric service. Following are the possible values.")
  type: "RequiredDomain";
}

@doc("""
Describes the policy to be used for placement of a Service Fabric service where two replicas
from the same partition should never be placed in the same fault or upgrade domain.

While this is not common it can expose the service to an increased risk of concurrent failures
due to unplanned outages or other cases of subsequent/concurrent failures. As an example, consider
a case where replicas are deployed across different data center, with one replica per location.
In the event that one of the datacenters goes offline, normally the replica that was placed in that
datacenter will be packed into one of the remaining datacenters. If this is not desirable then this
policy should be set.

""")
model ServicePlacementRequireDomainDistributionPolicy
  extends ServicePlacementPolicy {
  @doc("The name of the domain that should used for placement as per this policy.")
  domainName: string;

  @doc("The type of placement policy for a service fabric service. Following are the possible values.")
  type: "RequiredDomainDistribution";
}

@doc("SingletonPartitionScheme")
model SingletonPartitionScheme extends Partition {
  @doc("Specifies how the service is partitioned.")
  partitionScheme: "Singleton";
}

@doc("The properties of a stateful service resource.")
model StatefulServiceProperties extends ServiceResourceProperties {
  @doc("A flag indicating whether this is a persistent service which stores states on the local disk. If it is then the value of this property is true, if not it is false.")
  hasPersistedState?: boolean;

  @doc("The target replica set size as a number.")
  @minValue(1)
  targetReplicaSetSize?: int32;

  @doc("The minimum replica set size as a number.")
  @minValue(1)
  minReplicaSetSize?: int32;

  @doc("The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format \"hh:mm:ss\".")
  replicaRestartWaitDuration?: string;

  @doc("The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format \"hh:mm:ss\".")
  quorumLossWaitDuration?: string;

  @doc("The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format \"hh:mm:ss\".")
  standByReplicaKeepDuration?: string;

  @doc("The duration for which replicas can stay InBuild before reporting that build is stuck, represented in ISO 8601 format \"hh:mm:ss\".")
  servicePlacementTimeLimit?: string;

  @doc("The kind of service (Stateless or Stateful).")
  serviceKind: "Stateful";
}

@doc("The properties of a stateless service resource.")
model StatelessServiceProperties extends ServiceResourceProperties {
  @doc("The instance count.")
  @minValue(-1)
  instanceCount: int32;

  @doc("MinInstanceCount is the minimum number of instances that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstanceCount computation -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.")
  minInstanceCount?: int32;

  @doc("MinInstancePercentage is the minimum percentage of InstanceCount that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstancePercentage computation, -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.")
  minInstancePercentage?: int32;

  @doc("The kind of service (Stateless or Stateful).")
  serviceKind: "Stateless";
}

@doc("Describes a partitioning scheme where an integer range is allocated evenly across a number of partitions.")
model UniformInt64RangePartitionScheme extends Partition {
  @doc("The number of partitions.")
  count: int32;

  @doc("""
The lower bound of the partition key range that
should be split between the partition ‘Count’

""")
  lowKey: int32;

  @doc("""
The upper bound of the partition key range that
should be split between the partition ‘Count’

""")
  highKey: int32;

  @doc("Specifies how the service is partitioned.")
  partitionScheme: "UniformInt64Range";
}

@doc("Long running operation result.")
model LongRunningOperationResult {
  @doc("The name of the operation.")
  name?: string;

  @doc("The start time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the operation.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The completion percentage of the operation.")
  percentComplete?: float32;

  @doc("The status of the operation.")
  status?: string;

  @doc("The operation error.")
  error?: ErrorModelError;
}
