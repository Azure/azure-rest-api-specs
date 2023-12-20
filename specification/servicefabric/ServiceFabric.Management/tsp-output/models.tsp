import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.ServiceFabric;

interface Operations extends Azure.ResourceManager.Operations {}

enum AddOnFeatures {
  RepairManager,
  DnsService,
  BackupRestoreService,
  ResourceMonitorService,
}

enum ClusterEnvironment {
  Windows,
  Linux,
}

enum StoreName {
  AddressBook,
  AuthRoot,
  CertificateAuthority,
  Disallowed,
  My,
  Root,
  TrustedPeople,
  TrustedPublisher,
}

enum ClusterState {
  WaitingForNodes,
  Deploying,
  BaselineUpgrade,
  UpdatingUserConfiguration,
  UpdatingUserCertificate,
  UpdatingInfrastructure,
  EnforcingClusterVersion,
  UpgradeServiceUnreachable,
  AutoScale,
  Ready,
}

enum DurabilityLevel {
  Bronze,
  Silver,
  Gold,
}

enum ProvisioningState {
  Updating,
  Succeeded,
  Failed,
  Canceled,
}

enum ReliabilityLevel {
  None,
  Bronze,
  Silver,
  Gold,
  Platinum,
}

enum UpgradeMode {
  @doc("The cluster will be automatically upgraded to the latest Service Fabric runtime version, **upgradeWave** will determine when the upgrade starts after the new version becomes available.")
  Automatic,
  @doc("The cluster will not be automatically upgraded to the latest Service Fabric runtime version. The cluster is upgraded by setting the **clusterCodeVersion** property in the cluster resource.")
  Manual,
}

enum SfZonalUpgradeMode {
  @doc("VMs under the node type are grouped into UDs and ignore the zone info in five UDs. This setting causes UDs across all zones to be upgraded at the same time. This deployment mode is faster for upgrades, we don't recommend it because it goes against the SDP guidelines, which state that the updates should be applied to one zone at a time.")
  Parallel,
  @doc("If this value is omitted or set to Hierarchical, VMs are grouped to reflect the zonal distribution in up to 15 UDs. Each of the three zones has five UDs. This ensures that the zones are updated one at a time, moving to next zone only after completing five UDs within the first zone. This update process is safer for the cluster and the user application.")
  Hierarchical,
}

enum VmssZonalUpgradeMode {
  @doc("Updates will happen in all Availability Zones at once for the virtual machine scale sets.")
  Parallel,
  @doc("VMs are grouped to reflect the zonal distribution in up to 15 UDs. Each of the three zones has five UDs. This ensures that the zones are updated one at a time, moving to next zone only after completing five UDs within the first zone.")
  Hierarchical,
}

enum ClusterUpgradeCadence {
  @doc("Cluster upgrade starts immediately after a new version is rolled out. Recommended for Test/Dev clusters.")
  Wave0,
  @doc("Cluster upgrade starts 7 days after a new version is rolled out. Recommended for Pre-prod clusters.")
  Wave1,
  @doc("Cluster upgrade starts 14 days after a new version is rolled out. Recommended for Production clusters.")
  Wave2,
}

enum NotificationCategory {
  @doc("Notification will be regarding wave progress.") WaveProgress,
}

enum NotificationLevel {
  @doc("Receive only critical notifications.") Critical,
  @doc("Receive all notifications.") All,
}

enum NotificationChannel {
  @doc("For email user receivers. In this case, the parameter receivers should be a list of email addresses that will receive the notifications.")
  EmailUser,
  @doc("For subscription receivers. In this case, the parameter receivers should be a list of roles of the subscription for the cluster (eg. Owner, AccountAdmin, etc) that will receive the notifications.")
  EmailSubscription,
}

enum ClusterVersionsEnvironment {
  Windows,
  Linux,
}

enum ArmUpgradeFailureAction {
  @doc("Indicates that a rollback of the upgrade will be performed by Service Fabric if the upgrade fails.")
  Rollback,
  @doc("Indicates that a manual repair will need to be performed by the administrator if the upgrade fails. Service Fabric will not proceed to the next upgrade domain automatically.")
  Manual,
}

enum RollingUpgradeMode {
  @doc("Indicates the upgrade mode is invalid. All Service Fabric enumerations have the invalid type. The value is zero.")
  Invalid,
  @doc("The upgrade will proceed automatically without performing any health monitoring. The value is 1")
  UnmonitoredAuto,
  @doc("The upgrade will stop after completing each upgrade domain, giving the opportunity to manually monitor health before proceeding. The value is 2")
  UnmonitoredManual,
  @doc("The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 3")
  Monitored,
}

enum ServiceKind {
  @doc("Indicates the service kind is invalid. All Service Fabric enumerations have the invalid type. The value is zero.")
  Invalid,
  @doc("Does not use Service Fabric to make its state highly available or reliable. The value is 1.")
  Stateless,
  @doc("Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 2.")
  Stateful,
}

enum PartitionScheme {
  @doc("Indicates the partition kind is invalid. All Service Fabric enumerations have the invalid type. The value is zero.")
  Invalid,
  @doc("Indicates that the partition is based on string names, and is a SingletonPartitionSchemeDescription object, The value is 1.")
  Singleton,
  @doc("Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionSchemeDescription object. The value is 2.")
  UniformInt64Range,
  @doc("Indicates that the partition is based on string names, and is a NamedPartitionSchemeDescription object. The value is 3")
  Named,
}

enum ArmServicePackageActivationMode {
  @doc("Indicates the application package activation mode will use shared process.")
  SharedProcess,
  @doc("Indicates the application package activation mode will use exclusive process.")
  ExclusiveProcess,
}

enum ServiceCorrelationScheme {
  @doc("An invalid correlation scheme. Cannot be used. The value is zero.")
  Invalid,
  @doc("Indicates that this service has an affinity relationship with another service. Provided for backwards compatibility, consider preferring the Aligned or NonAlignedAffinity options. The value is 1.")
  Affinity,
  @doc("Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 2.")
  AlignedAffinity,
  @doc("Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 3.")
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
  @doc("Indicates the type of the placement policy is invalid. All Service Fabric enumerations have the invalid type. The value is zero.")
  Invalid,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 1.")
  InvalidDomain,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 2.")
  RequiredDomain,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 3.")
  PreferredPrimaryDomain,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 4.")
  RequiredDomainDistribution,
  @doc("Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 5.")
  NonPartiallyPlaceService,
}

enum MoveCost {
  @doc("Zero move cost. This value is zero.") Zero,
  @doc("Specifies the move cost of the service as Low. The value is 1.") Low,
  @doc("Specifies the move cost of the service as Medium. The value is 2.")
  Medium,
  @doc("Specifies the move cost of the service as High. The value is 3.") High,
}
@Azure.Core.fixed
enum ManagedIdentityType {
  @doc("Indicates that system assigned identity is associated with the resource.")
  SystemAssigned,
  @doc("Indicates that user assigned identity is associated with the resource.")
  UserAssigned,
  @doc("Indicates that both system assigned and user assigned identity are associated with the resource.")
  `SystemAssigned, UserAssigned`,
  @doc("Indicates that no identity is associated with the resource.") None,
}

@doc("Describes the cluster resource properties.")
model ClusterProperties {
  @doc("The list of add-on features to enable in the cluster.")
  addOnFeatures?: AddOnFeatures[];

  @doc("The Service Fabric runtime versions available for this cluster.")
  @visibility("read")
  availableClusterVersions?: ClusterVersionDetails[];

  @doc("The AAD authentication settings of the cluster.")
  azureActiveDirectory?: AzureActiveDirectory;

  @doc("The certificate to use for securing the cluster. The certificate provided will be used for node to node security within the cluster, SSL certificate for cluster management endpoint and default admin client.")
  certificate?: CertificateDescription;

  @doc("Describes a list of server certificates referenced by common name that are used to secure the cluster.")
  certificateCommonNames?: ServerCertificateCommonNames;

  @doc("The list of client certificates referenced by common name that are allowed to manage the cluster.")
  clientCertificateCommonNames?: ClientCertificateCommonName[];

  @doc("The list of client certificates referenced by thumbprint that are allowed to manage the cluster.")
  clientCertificateThumbprints?: ClientCertificateThumbprint[];

  @doc("The Service Fabric runtime version of the cluster. This property can only by set the user when **upgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](./ClusterVersion.md). To get the list of available version for existing clusters use **availableClusterVersions**.")
  clusterCodeVersion?: string;

  @doc("The Azure Resource Provider endpoint. A system service in the cluster connects to this  endpoint.")
  @visibility("read")
  clusterEndpoint?: string;

  @doc("A service generated unique identifier for the cluster resource.")
  @visibility("read")
  clusterId?: string;

  @doc("""
The current state of the cluster.

  - WaitingForNodes - Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
  - Deploying - Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
  - BaselineUpgrade - Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
  - UpdatingUserConfiguration - Indicates that the cluster is being upgraded with the user provided configuration.
  - UpdatingUserCertificate - Indicates that the cluster is being upgraded with the user provided certificate.
  - UpdatingInfrastructure - Indicates that the cluster is being upgraded with the latest Service Fabric runtime version. This happens only when the **upgradeMode** is set to 'Automatic'.
  - EnforcingClusterVersion - Indicates that cluster is on a different version than expected and the cluster is being upgraded to the expected version.
  - UpgradeServiceUnreachable - Indicates that the system service in the cluster is no longer polling the Resource Provider. Clusters in this state cannot be managed by the Resource Provider.
  - AutoScale - Indicates that the ReliabilityLevel of the cluster is being adjusted.
  - Ready - Indicates that the cluster is in a stable state.

""")
  @visibility("read")
  clusterState?: ClusterState;

  @doc("The storage account information for storing Service Fabric diagnostic logs.")
  diagnosticsStorageAccountConfig?: DiagnosticsStorageAccountConfig;

  @doc("Indicates if the event store service is enabled.")
  eventStoreServiceEnabled?: boolean;

  @doc("The list of custom fabric settings to configure the cluster.")
  fabricSettings?: SettingsSectionDescription[];

  @doc("The http management endpoint of the cluster.")
  managementEndpoint: string;

  @doc("The list of node types in the cluster.")
  nodeTypes: NodeTypeDescription[];

  @doc("The provisioning state of the cluster resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("""
The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).

  - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
  - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
  - Silver - Run the System services with a target replica set count of 5.
  - Gold - Run the System services with a target replica set count of 7.
  - Platinum - Run the System services with a target replica set count of 9.

""")
  reliabilityLevel?: ReliabilityLevel;

  @doc("The server certificate used by reverse proxy.")
  reverseProxyCertificate?: CertificateDescription;

  @doc("Describes a list of server certificates referenced by common name that are used to secure the cluster.")
  reverseProxyCertificateCommonNames?: ServerCertificateCommonNames;

  @doc("The policy to use when upgrading the cluster.")
  upgradeDescription?: ClusterUpgradePolicy;

  @doc("The upgrade mode of the cluster when new Service Fabric runtime version is available.")
  upgradeMode?: UpgradeMode;

  @doc("The policy used to clean up unused versions.")
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  @doc("The VM image VMSS has been configured with. Generic names such as Windows or Linux can be used.")
  vmImage?: string;

  @doc("This property controls the logical grouping of VMs in upgrade domains (UDs). This property can't be modified if a node type with multiple Availability Zones is already present in the cluster.")
  sfZonalUpgradeMode?: SfZonalUpgradeMode;

  @doc("This property defines the upgrade mode for the virtual machine scale set, it is mandatory if a node type with multiple Availability Zones is added.")
  vmssZonalUpgradeMode?: VmssZonalUpgradeMode;

  @doc("Indicates if infrastructure service manager is enabled.")
  infrastructureServiceManager?: boolean;

  @doc("Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **upgradeMode** is set to 'Automatic'.")
  upgradeWave?: ClusterUpgradeCadence;

  @doc("Indicates the start date and time to pause automatic runtime version upgrades on the cluster for an specific period of time on the cluster (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseStartTimestampUtc?: utcDateTime;

  @doc("Indicates the end date and time to pause automatic runtime version upgrades on the cluster for an specific period of time on the cluster (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseEndTimestampUtc?: utcDateTime;

  @doc("Boolean to pause automatic runtime version upgrades to the cluster.")
  waveUpgradePaused?: boolean;

  @doc("Indicates a list of notification channels for cluster events.")
  notifications?: Notification[];
}

@doc("The detail of the Service Fabric runtime version result")
model ClusterVersionDetails {
  @doc("The Service Fabric runtime version of the cluster.")
  codeVersion?: string;

  @doc("The date of expiry of support of the version.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  supportExpiryUtc?: utcDateTime;

  @doc("Indicates if this version is for Windows or Linux operating system.")
  environment?: ClusterEnvironment;
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

@doc("Describes the certificate details.")
model CertificateDescription {
  @doc("Thumbprint of the primary certificate.")
  thumbprint: string;

  @doc("Thumbprint of the secondary certificate.")
  thumbprintSecondary?: string;

  @doc("The local certificate store location.")
  x509StoreName?: StoreName;
}

@doc("Describes a list of server certificates referenced by common name that are used to secure the cluster.")
model ServerCertificateCommonNames {
  @doc("The list of server certificates referenced by common name that are used to secure the cluster.")
  commonNames?: ServerCertificateCommonName[];

  @doc("The local certificate store location.")
  x509StoreName?: StoreName;
}

@doc("Describes the server certificate details using common name.")
model ServerCertificateCommonName {
  @doc("The common name of the server certificate.")
  certificateCommonName: string;

  @doc("The issuer thumbprint of the server certificate.")
  certificateIssuerThumbprint: string;
}

@doc("Describes the client certificate details using common name.")
model ClientCertificateCommonName {
  @doc("Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.")
  isAdmin: boolean;

  @doc("The common name of the client certificate.")
  certificateCommonName: string;

  @doc("The issuer thumbprint of the client certificate.")
  certificateIssuerThumbprint: string;
}

@doc("Describes the client certificate details using thumbprint.")
model ClientCertificateThumbprint {
  @doc("Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.")
  isAdmin: boolean;

  @doc("The thumbprint of the client certificate.")
  certificateThumbprint: string;
}

@doc("The storage account information for storing Service Fabric diagnostic logs.")
model DiagnosticsStorageAccountConfig {
  @doc("The Azure storage account name.")
  storageAccountName: string;

  @doc("The protected diagnostics storage key name.")
  protectedAccountKeyName: string;

  @doc("The secondary protected diagnostics storage key name. If one of the storage account keys is rotated the cluster will fallback to using the other.")
  protectedAccountKeyName2?: string;

  @doc("The blob endpoint of the azure storage account.")
  blobEndpoint: string;

  @doc("The queue endpoint of the azure storage account.")
  queueEndpoint: string;

  @doc("The table endpoint of the azure storage account.")
  tableEndpoint: string;
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

@doc("Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.")
model NodeTypeDescription {
  @doc("The name of the node type.")
  name: string;

  @doc("The placement tags applied to nodes in the node type, which can be used to indicate where certain services (workload) should run.")
  placementProperties?: Record<string>;

  @doc("The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.")
  capacities?: Record<string>;

  @doc("The TCP cluster management endpoint port.")
  clientConnectionEndpointPort: int32;

  @doc("The HTTP cluster management endpoint port.")
  httpGatewayEndpointPort: int32;

  @doc("""
The durability level of the node type. Learn about [DurabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).

  - Bronze - No privileges. This is the default.
  - Silver - The infrastructure jobs can be paused for a duration of 10 minutes per UD.
  - Gold - The infrastructure jobs can be paused for a duration of 2 hours per UD. Gold durability can be enabled only on full node VM skus like D15_V2, G5 etc.

""")
  durabilityLevel?: DurabilityLevel;

  @doc("The range of ports from which cluster assigned port to Service Fabric applications.")
  applicationPorts?: EndpointRangeDescription;

  @doc("The range of ephemeral ports that nodes in this node type should be configured with.")
  ephemeralPorts?: EndpointRangeDescription;

  @doc("The node type on which system services will run. Only one node type should be marked as primary. Primary node type cannot be deleted or changed for existing clusters.")
  isPrimary: boolean;

  @doc("VMInstanceCount should be 1 to n, where n indicates the number of VM instances corresponding to this nodeType. VMInstanceCount = 0 can be done only in these scenarios: NodeType is a secondary nodeType. Durability = Bronze or Durability >= Bronze and InfrastructureServiceManager = true. If VMInstanceCount = 0, implies the VMs for this nodeType will not be used for the initial cluster size computation.")
  @maxValue(2147483647)
  vmInstanceCount: int32;

  @doc("The endpoint used by reverse proxy.")
  reverseProxyEndpointPort?: int32;

  @doc("Indicates if the node type can only host Stateless workloads.")
  isStateless?: boolean;

  @doc("Indicates if the node type is enabled to support multiple zones.")
  multipleAvailabilityZones?: boolean;
}

@doc("Port range details")
model EndpointRangeDescription {
  @doc("Starting port of a range of ports")
  startPort: int32;

  @doc("End port of a range of ports")
  endPort: int32;
}

@doc("Describes the policy used when upgrading the cluster.")
model ClusterUpgradePolicy {
  @doc("If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).")
  forceRestart?: boolean;

  @doc("The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.")
  upgradeReplicaSetCheckTimeout: string;

  @doc("The length of time to wait after completing an upgrade domain before performing health checks. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.")
  healthCheckWaitDuration: string;

  @doc("The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.")
  healthCheckStableDuration: string;

  @doc("The amount of time to retry health evaluation when the application or cluster is unhealthy before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.")
  healthCheckRetryTimeout: string;

  @doc("The amount of time the overall upgrade has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.")
  upgradeTimeout: string;

  @doc("The amount of time each upgrade domain has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.")
  upgradeDomainTimeout: string;

  @doc("The cluster health policy used when upgrading the cluster.")
  healthPolicy: ClusterHealthPolicy;

  @doc("The cluster delta health policy used when upgrading the cluster.")
  deltaHealthPolicy?: ClusterUpgradeDeltaHealthPolicy;
}

@doc("""
Defines a health policy used to evaluate the health of the cluster or of a cluster node.

""")
model ClusterHealthPolicy {
  @doc("""
The maximum allowed percentage of unhealthy nodes before reporting an error. For example, to allow 10% of nodes to be unhealthy, this value would be 10.

The percentage represents the maximum tolerated percentage of nodes that can be unhealthy before the cluster is considered in error.
If the percentage is respected but there is at least one unhealthy node, the health is evaluated as Warning.
The percentage is calculated by dividing the number of unhealthy nodes over the total number of nodes in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.

In large clusters, some nodes will always be down or out for repairs, so this percentage should be configured to tolerate that.

""")
  @maxValue(100)
  maxPercentUnhealthyNodes?: int32;

  @doc("""
The maximum allowed percentage of unhealthy applications before reporting an error. For example, to allow 10% of applications to be unhealthy, this value would be 10.

The percentage represents the maximum tolerated percentage of applications that can be unhealthy before the cluster is considered in error.
If the percentage is respected but there is at least one unhealthy application, the health is evaluated as Warning.
This is calculated by dividing the number of unhealthy applications over the total number of application instances in the cluster, excluding applications of application types that are included in the ApplicationTypeHealthPolicyMap.
The computation rounds up to tolerate one failure on small numbers of applications. Default percentage is zero.

""")
  @maxValue(100)
  maxPercentUnhealthyApplications?: int32;

  @doc("Defines the application health policy map used to evaluate the health of an application or one of its children entities.")
  applicationHealthPolicies?: Record<ApplicationHealthPolicy>;
}

@doc("""
Defines a health policy used to evaluate the health of an application or one of its children entities.

""")
model ApplicationHealthPolicy {
  @doc("The health policy used by default to evaluate the health of a service type.")
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  @doc("The map with service type health policy per service type name. The map is empty by default.")
  serviceTypeHealthPolicies?: Record<ServiceTypeHealthPolicy>;
}

@doc("""
Represents the health policy used to evaluate the health of services belonging to a service type.

""")
model ServiceTypeHealthPolicy {
  @doc("""
The maximum percentage of services allowed to be unhealthy before your application is considered in error.

""")
  @maxValue(100)
  maxPercentUnhealthyServices?: int32;
}

@doc("Describes the delta health policies for the cluster upgrade.")
model ClusterUpgradeDeltaHealthPolicy {
  @doc("""
The maximum allowed percentage of nodes health degradation allowed during cluster upgrades.
The delta is measured between the state of the nodes at the beginning of upgrade and the state of the nodes at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.

""")
  @maxValue(100)
  maxPercentDeltaUnhealthyNodes: int32;

  @doc("""
The maximum allowed percentage of upgrade domain nodes health degradation allowed during cluster upgrades.
The delta is measured between the state of the upgrade domain nodes at the beginning of upgrade and the state of the upgrade domain nodes at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion for all completed upgrade domains to make sure the state of the upgrade domains is within tolerated limits.

""")
  @maxValue(100)
  maxPercentUpgradeDomainDeltaUnhealthyNodes: int32;

  @doc("""
The maximum allowed percentage of applications health degradation allowed during cluster upgrades.
The delta is measured between the state of the applications at the beginning of upgrade and the state of the applications at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits. System services are not included in this.

""")
  @maxValue(100)
  maxPercentDeltaUnhealthyApplications: int32;

  @doc("Defines the application delta health policy map used to evaluate the health of an application or one of its child entities when upgrading the cluster.")
  applicationDeltaHealthPolicies?: Record<ApplicationDeltaHealthPolicy>;
}

@doc("""
Defines a delta health policy used to evaluate the health of an application or one of its child entities when upgrading the cluster.

""")
model ApplicationDeltaHealthPolicy {
  @doc("The delta health policy used by default to evaluate the health of a service type when upgrading the cluster.")
  defaultServiceTypeDeltaHealthPolicy?: ServiceTypeDeltaHealthPolicy;

  @doc("The map with service type delta health policy per service type name. The map is empty by default.")
  serviceTypeDeltaHealthPolicies?: Record<ServiceTypeDeltaHealthPolicy>;
}

@doc("""
Represents the delta health policy used to evaluate the health of services belonging to a service type when upgrading the cluster.

""")
model ServiceTypeDeltaHealthPolicy {
  @doc("""
The maximum allowed percentage of services health degradation allowed during cluster upgrades.
The delta is measured between the state of the services at the beginning of upgrade and the state of the services at the time of the health evaluation.
The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.

""")
  @maxValue(100)
  maxPercentDeltaUnhealthyServices?: int32;
}

model ApplicationTypeVersionsCleanupPolicy {
  @doc("Number of unused versions per application type to keep.")
  maxUnusedVersionsToKeep: int32;
}

@doc("Describes the notification channel for cluster events.")
model Notification {
  @doc("Indicates if the notification is enabled.")
  isEnabled: boolean;

  @doc("The category of notification.")
  notificationCategory: NotificationCategory;

  @doc("The level of notification.")
  notificationLevel: NotificationLevel;

  @doc("List of targets that subscribe to the notification.")
  notificationTargets: NotificationTarget[];
}

@doc("Describes the notification target properties.")
model NotificationTarget {
  @doc("The notification channel indicates the type of receivers subscribed to the notification, either user or subscription.")
  notificationChannel: NotificationChannel;

  @doc("List of targets that subscribe to the notification.")
  receivers: string[];
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

@doc("The list results of the Service Fabric runtime versions.")
model ClusterCodeVersionsListResult {
  value?: ClusterCodeVersionsResult[];

  @doc("The URL to use for getting the next set of results.")
  nextLink?: string;
}

@doc("The result of the Service Fabric runtime versions")
model ClusterCodeVersionsResult {
  @doc("The identification of the result")
  id?: string;

  @doc("The name of the result")
  name?: string;

  @doc("The result resource type")
  type?: string;

  @doc("The detail of the Service Fabric runtime version result")
  properties?: ClusterVersionDetails;
}

model UpgradableVersionsDescription {
  @doc("The target code version.")
  targetVersion: string;
}

@doc("The list of intermediate cluster code versions for an upgrade or downgrade. Or minimum and maximum upgradable version if no target was given")
model UpgradableVersionPathResult {
  supportedPath?: string[];
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

@doc("The application type name properties")
model ApplicationTypeResourceProperties {
  @doc("The current deployment or provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;
}

@doc("The properties of the application type version resource.")
model ApplicationTypeVersionResourceProperties {
  @doc("The current deployment or provisioning state, which only appears in the response")
  @visibility("read")
  provisioningState?: string;

  @doc("The URL to the application package")
  appPackageUrl: string;

  @doc("List of application type parameters that can be overridden when creating or updating the application.")
  @visibility("read")
  defaultParameterList?: Record<string>;
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

model UserAssignedIdentity {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("The application resource properties.")
model ApplicationResourceProperties {
  ...ApplicationResourceUpdateProperties;

  @doc("The current deployment or provisioning state, which only appears in the response")
  @visibility("read")
  provisioningState?: string;

  @doc("The application type name as defined in the application manifest.")
  typeName?: string;
}

@doc("Describes the policy for a monitored application upgrade.")
model ApplicationUpgradePolicy {
  @doc("The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).")
  upgradeReplicaSetCheckTimeout?: string;

  @doc("If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).")
  forceRestart?: boolean;

  @doc("The policy used for monitoring the application upgrade")
  rollingUpgradeMonitoringPolicy?: ArmRollingUpgradeMonitoringPolicy;

  @doc("""
Defines a health policy used to evaluate the health of an application or one of its children entities.

""")
  applicationHealthPolicy?: ArmApplicationHealthPolicy;

  @doc("The mode used to monitor health during a rolling upgrade. The values are UnmonitoredAuto, UnmonitoredManual, and Monitored.")
  upgradeMode?: RollingUpgradeMode;

  @doc("Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed and it will result in availability loss.")
  recreateApplication?: boolean;
}

@doc("The policy used for monitoring the application upgrade")
model ArmRollingUpgradeMonitoringPolicy {
  @doc("The activation Mode of the service package")
  failureAction?: ArmUpgradeFailureAction;

  @doc("The amount of time to wait after completing an upgrade domain before applying health policies. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.")
  healthCheckWaitDuration?: string;

  @doc("The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.")
  healthCheckStableDuration?: string;

  @doc("The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.")
  healthCheckRetryTimeout?: string;

  @doc("The amount of time the overall upgrade has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.")
  upgradeTimeout?: string;

  @doc("The amount of time each upgrade domain has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.")
  upgradeDomainTimeout?: string;
}

@doc("""
Defines a health policy used to evaluate the health of an application or one of its children entities.

""")
model ArmApplicationHealthPolicy {
  @doc("Indicates whether warnings are treated with the same severity as errors.")
  considerWarningAsError?: boolean;

  @doc("""
The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.

""")
  maxPercentUnhealthyDeployedApplications?: int32;

  @doc("The health policy used by default to evaluate the health of a service type.")
  defaultServiceTypeHealthPolicy?: ArmServiceTypeHealthPolicy;

  @doc("The map with service type health policy per service type name. The map is empty by default.")
  serviceTypeHealthPolicyMap?: Record<ArmServiceTypeHealthPolicy>;
}

@doc("""
Represents the health policy used to evaluate the health of services belonging to a service type.

""")
model ArmServiceTypeHealthPolicy {
  @doc("""
The maximum percentage of services allowed to be unhealthy before your application is considered in error.

""")
  @maxValue(100)
  maxPercentUnhealthyServices?: int32;

  @doc("""
The maximum percentage of partitions per service allowed to be unhealthy before your application is considered in error.

""")
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService?: int32;

  @doc("""
The maximum percentage of replicas per partition allowed to be unhealthy before your application is considered in error.

""")
  @maxValue(100)
  maxPercentUnhealthyReplicasPerPartition?: int32;
}

@doc("""
Describes capacity information for a custom resource balancing metric. This can be used to limit the total consumption of this metric by the services of this application.

""")
model ApplicationMetricDescription {
  @doc("The name of the metric.")
  name?: string;

  @doc("""
The maximum node capacity for Service Fabric application.
This is the maximum Load for an instance of this application on a single node. Even if the capacity of node is greater than this value, Service Fabric will limit the total load of services within the application on each node to this value.
If set to zero, capacity for this metric is unlimited on each node.
When creating a new application with application capacity defined, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
When updating existing application with application capacity, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.

""")
  maximumCapacity?: int32;

  @doc("""
The node reservation capacity for Service Fabric application.
This is the amount of load which is reserved on nodes which have instances of this application.
If MinimumNodes is specified, then the product of these values will be the capacity reserved in the cluster for the application.
If set to zero, no capacity is reserved for this metric.
When setting application capacity or when updating application capacity; this value must be smaller than or equal to MaximumCapacity for each metric.

""")
  reservationCapacity?: int32;

  @doc("""
The total metric capacity for Service Fabric application.
This is the total metric capacity for this application in the cluster. Service Fabric will try to limit the sum of loads of services within the application to this value.
When creating a new application with application capacity defined, the product of MaximumNodes and MaximumCapacity must always be smaller than or equal to this value.

""")
  totalApplicationCapacity?: int32;
}

model ApplicationUserAssignedIdentity {
  @doc("The friendly name of user assigned identity.")
  name: string;

  @doc("The principal id of user assigned identity.")
  principalId: string;
}

@doc("The service resource properties.")
@discriminator("serviceKind")
model ServiceResourceProperties {
  ...ServiceResourcePropertiesBase;

  @doc("The current deployment or provisioning state, which only appears in the response")
  @visibility("read")
  provisioningState?: string;

  @doc("The name of the service type")
  serviceTypeName?: string;

  @doc("Describes how the service is partitioned.")
  partitionDescription?: PartitionSchemeDescription;

  @doc("The activation Mode of the service package")
  servicePackageActivationMode?: ArmServicePackageActivationMode;

  @doc("Dns name used for the service. If this is specified, then the service can be accessed via its DNS name instead of service name.")
  serviceDnsName?: string;
}

@doc("Describes how the service is partitioned.")
@discriminator("partitionScheme")
model PartitionSchemeDescription {}

@doc("The common service resource properties.")
model ServiceResourcePropertiesBase {
  @doc("The placement constraints as a string. Placement constraints are boolean expressions on node properties and allow for restricting a service to particular nodes based on the service requirements. For example, to place a service on nodes where NodeType is blue specify the following: \"NodeColor == blue)\".")
  placementConstraints?: string;

  @doc("A list that describes the correlation of the service with other services.")
  correlationScheme?: ServiceCorrelationDescription[];

  @doc("The service load metrics is given as an array of ServiceLoadMetricDescription objects.")
  serviceLoadMetrics?: ServiceLoadMetricDescription[];

  @doc("A list that describes the correlation of the service with other services.")
  servicePlacementPolicies?: ServicePlacementPolicyDescription[];

  @doc("Specifies the move cost for the service.")
  defaultMoveCost?: MoveCost;
}

@doc("Creates a particular correlation between services.")
model ServiceCorrelationDescription {
  @doc("The ServiceCorrelationScheme which describes the relationship between this service and the service specified via ServiceName.")
  scheme: ServiceCorrelationScheme;

  @doc("The name of the service that the correlation relationship is established with.")
  serviceName: string;
}

@doc("Specifies a metric to load balance a service during runtime.")
model ServiceLoadMetricDescription {
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
model ServicePlacementPolicyDescription {}

@doc("Describes the named partition scheme of the service.")
model NamedPartitionSchemeDescription extends PartitionSchemeDescription {
  @doc("The number of partitions.")
  count: int32;

  @doc("Array of size specified by the ‘count’ parameter, for the names of the partitions.")
  names: string[];

  @doc("Specifies how the service is partitioned.")
  partitionScheme: "Named";
}

@doc("SingletonPartitionSchemeDescription")
model SingletonPartitionSchemeDescription extends PartitionSchemeDescription {
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

  @doc("The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format (hh:mm:ss.s).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaRestartWaitDuration?: utcDateTime;

  @doc("The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format (hh:mm:ss.s).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  quorumLossWaitDuration?: utcDateTime;

  @doc("The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format (hh:mm:ss.s).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  standByReplicaKeepDuration?: utcDateTime;

  @doc("The kind of service (Stateless or Stateful).")
  serviceKind: "Stateful";
}

@doc("The properties of a stateful service resource for patch operations.")
model StatefulServiceUpdateProperties extends ServiceResourceUpdateProperties {
  @doc("The target replica set size as a number.")
  @minValue(1)
  targetReplicaSetSize?: int32;

  @doc("The minimum replica set size as a number.")
  @minValue(1)
  minReplicaSetSize?: int32;

  @doc("The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format (hh:mm:ss.s).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaRestartWaitDuration?: utcDateTime;

  @doc("The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format (hh:mm:ss.s).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  quorumLossWaitDuration?: utcDateTime;

  @doc("The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format (hh:mm:ss.s).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  standByReplicaKeepDuration?: utcDateTime;

  @doc("The kind of service (Stateless or Stateful).")
  serviceKind: "Stateful";
}

@doc("The properties of a stateless service resource.")
model StatelessServiceProperties extends ServiceResourceProperties {
  @doc("The instance count.")
  @minValue(-1)
  instanceCount?: int32;

  @doc("Delay duration for RequestDrain feature to ensures that the endpoint advertised by the stateless instance is removed before the delay starts prior to closing the instance. This delay enables existing requests to drain gracefully before the instance actually goes down (https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-application-upgrade-advanced#avoid-connection-drops-during-stateless-service-planned-downtime-preview). It is represented in ISO 8601 format (hh:mm:ss.s).")
  instanceCloseDelayDuration?: string;

  @doc("The kind of service (Stateless or Stateful).")
  serviceKind: "Stateless";
}

@doc("The properties of a stateless service resource for patch operations.")
model StatelessServiceUpdateProperties extends ServiceResourceUpdateProperties {
  @doc("The instance count.")
  @minValue(-1)
  instanceCount?: int32;

  @doc("Delay duration for RequestDrain feature to ensures that the endpoint advertised by the stateless instance is removed before the delay starts prior to closing the instance. This delay enables existing requests to drain gracefully before the instance actually goes down (https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-application-upgrade-advanced#avoid-connection-drops-during-stateless-service-planned-downtime-preview). It is first interpreted as a string representing an ISO 8601 duration. It is represented in ISO 8601 format (hh:mm:ss.s).")
  instanceCloseDelayDuration?: string;

  @doc("The kind of service (Stateless or Stateful).")
  serviceKind: "Stateless";
}

@doc("Describes a partitioning scheme where an integer range is allocated evenly across a number of partitions.")
model UniformInt64RangePartitionSchemeDescription
  extends PartitionSchemeDescription {
  @doc("The number of partitions.")
  count: int32;

  @doc("""
String indicating the lower bound of the partition key range that
should be split between the partition ‘count’

""")
  lowKey: string;

  @doc("""
String indicating the upper bound of the partition key range that
should be split between the partition ‘count’

""")
  highKey: string;

  @doc("Specifies how the service is partitioned.")
  partitionScheme: "UniformInt64Range";
}
