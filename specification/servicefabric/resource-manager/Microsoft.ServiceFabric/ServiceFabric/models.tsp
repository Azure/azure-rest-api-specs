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
 * Available cluster add-on features
 */
union AddOnFeatures {
  string,

  /**
   * RepairManager
   */
  RepairManager: "RepairManager",

  /**
   * DnsService
   */
  DnsService: "DnsService",

  /**
   * BackupRestoreService
   */
  BackupRestoreService: "BackupRestoreService",

  /**
   * ResourceMonitorService
   */
  ResourceMonitorService: "ResourceMonitorService",
}

/**
 * Cluster operating system, the default will be Windows
 */
union ClusterEnvironment {
  string,

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * Linux
   */
  Linux: "Linux",
}

/**
 * The local certificate store location.
 */
union StoreName {
  string,

  /**
   * AddressBook
   */
  AddressBook: "AddressBook",

  /**
   * AuthRoot
   */
  AuthRoot: "AuthRoot",

  /**
   * CertificateAuthority
   */
  CertificateAuthority: "CertificateAuthority",

  /**
   * Disallowed
   */
  Disallowed: "Disallowed",

  /**
   * My
   */
  My: "My",

  /**
   * Root
   */
  Root: "Root",

  /**
   * TrustedPeople
   */
  TrustedPeople: "TrustedPeople",

  /**
   * TrustedPublisher
   */
  TrustedPublisher: "TrustedPublisher",
}

/**
 * The current state of the cluster.
 *
 *   - WaitingForNodes - Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
 *   - Deploying - Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
 *   - BaselineUpgrade - Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
 *   - UpdatingUserConfiguration - Indicates that the cluster is being upgraded with the user provided configuration.
 *   - UpdatingUserCertificate - Indicates that the cluster is being upgraded with the user provided certificate.
 *   - UpdatingInfrastructure - Indicates that the cluster is being upgraded with the latest Service Fabric runtime version. This happens only when the **upgradeMode** is set to 'Automatic'.
 *   - EnforcingClusterVersion - Indicates that cluster is on a different version than expected and the cluster is being upgraded to the expected version.
 *   - UpgradeServiceUnreachable - Indicates that the system service in the cluster is no longer polling the Resource Provider. Clusters in this state cannot be managed by the Resource Provider.
 *   - AutoScale - Indicates that the ReliabilityLevel of the cluster is being adjusted.
 *   - Ready - Indicates that the cluster is in a stable state.
 *
 */
union ClusterState {
  string,

  /**
   * WaitingForNodes
   */
  WaitingForNodes: "WaitingForNodes",

  /**
   * Deploying
   */
  Deploying: "Deploying",

  /**
   * BaselineUpgrade
   */
  BaselineUpgrade: "BaselineUpgrade",

  /**
   * UpdatingUserConfiguration
   */
  UpdatingUserConfiguration: "UpdatingUserConfiguration",

  /**
   * UpdatingUserCertificate
   */
  UpdatingUserCertificate: "UpdatingUserCertificate",

  /**
   * UpdatingInfrastructure
   */
  UpdatingInfrastructure: "UpdatingInfrastructure",

  /**
   * EnforcingClusterVersion
   */
  EnforcingClusterVersion: "EnforcingClusterVersion",

  /**
   * UpgradeServiceUnreachable
   */
  UpgradeServiceUnreachable: "UpgradeServiceUnreachable",

  /**
   * AutoScale
   */
  AutoScale: "AutoScale",

  /**
   * Ready
   */
  Ready: "Ready",
}

/**
 * The durability level of the node type. Learn about [DurabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
 *
 *   - Bronze - No privileges. This is the default.
 *   - Silver - The infrastructure jobs can be paused for a duration of 10 minutes per UD.
 *   - Gold - The infrastructure jobs can be paused for a duration of 2 hours per UD. Gold durability can be enabled only on full node VM skus like D15_V2, G5 etc.
 *
 */
union DurabilityLevel {
  string,

  /**
   * Bronze
   */
  Bronze: "Bronze",

  /**
   * Silver
   */
  Silver: "Silver",

  /**
   * Gold
   */
  Gold: "Gold",
}

/**
 * The provisioning state of the cluster resource.
 */
union ProvisioningState {
  string,

  /**
   * Updating
   */
  Updating: "Updating",

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
}

/**
 * The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
 *
 *   - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
 *   - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
 *   - Silver - Run the System services with a target replica set count of 5.
 *   - Gold - Run the System services with a target replica set count of 7.
 *   - Platinum - Run the System services with a target replica set count of 9.
 *
 */
union ReliabilityLevel {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Bronze
   */
  Bronze: "Bronze",

  /**
   * Silver
   */
  Silver: "Silver",

  /**
   * Gold
   */
  Gold: "Gold",

  /**
   * Platinum
   */
  Platinum: "Platinum",
}

/**
 * The upgrade mode of the cluster when new Service Fabric runtime version is available.
 */
union UpgradeMode {
  string,

  /**
   * The cluster will be automatically upgraded to the latest Service Fabric runtime version, **upgradeWave** will determine when the upgrade starts after the new version becomes available.
   */
  Automatic: "Automatic",

  /**
   * The cluster will not be automatically upgraded to the latest Service Fabric runtime version. The cluster is upgraded by setting the **clusterCodeVersion** property in the cluster resource.
   */
  Manual: "Manual",
}

/**
 * This property controls the logical grouping of VMs in upgrade domains (UDs). This property can't be modified if a node type with multiple Availability Zones is already present in the cluster.
 */
union SfZonalUpgradeMode {
  string,

  /**
   * VMs under the node type are grouped into UDs and ignore the zone info in five UDs. This setting causes UDs across all zones to be upgraded at the same time. This deployment mode is faster for upgrades, we don't recommend it because it goes against the SDP guidelines, which state that the updates should be applied to one zone at a time.
   */
  Parallel: "Parallel",

  /**
   * If this value is omitted or set to Hierarchical, VMs are grouped to reflect the zonal distribution in up to 15 UDs. Each of the three zones has five UDs. This ensures that the zones are updated one at a time, moving to next zone only after completing five UDs within the first zone. This update process is safer for the cluster and the user application.
   */
  Hierarchical: "Hierarchical",
}

/**
 * This property defines the upgrade mode for the virtual machine scale set, it is mandatory if a node type with multiple Availability Zones is added.
 */
union VmssZonalUpgradeMode {
  string,

  /**
   * Updates will happen in all Availability Zones at once for the virtual machine scale sets.
   */
  Parallel: "Parallel",

  /**
   * VMs are grouped to reflect the zonal distribution in up to 15 UDs. Each of the three zones has five UDs. This ensures that the zones are updated one at a time, moving to next zone only after completing five UDs within the first zone.
   */
  Hierarchical: "Hierarchical",
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
 * The category of notification.
 */
union NotificationCategory {
  string,

  /**
   * Notification will be regarding wave progress.
   */
  WaveProgress: "WaveProgress",
}

/**
 * The level of notification.
 */
union NotificationLevel {
  string,

  /**
   * Receive only critical notifications.
   */
  Critical: "Critical",

  /**
   * Receive all notifications.
   */
  All: "All",
}

/**
 * The notification channel indicates the type of receivers subscribed to the notification, either user or subscription.
 */
union NotificationChannel {
  string,

  /**
   * For email user receivers. In this case, the parameter receivers should be a list of email addresses that will receive the notifications.
   */
  EmailUser: "EmailUser",

  /**
   * For subscription receivers. In this case, the parameter receivers should be a list of roles of the subscription for the cluster (eg. Owner, AccountAdmin, etc) that will receive the notifications.
   */
  EmailSubscription: "EmailSubscription",
}

union ClusterVersionsEnvironment {
  string,

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * Linux
   */
  Linux: "Linux",
}

/**
 * The activation Mode of the service package
 */
union ArmUpgradeFailureAction {
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
 * The mode used to monitor health during a rolling upgrade. The values are UnmonitoredAuto, UnmonitoredManual, and Monitored.
 */
union RollingUpgradeMode {
  string,

  /**
   * Indicates the upgrade mode is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * The upgrade will proceed automatically without performing any health monitoring. The value is 1
   */
  UnmonitoredAuto: "UnmonitoredAuto",

  /**
   * The upgrade will stop after completing each upgrade domain, giving the opportunity to manually monitor health before proceeding. The value is 2
   */
  UnmonitoredManual: "UnmonitoredManual",

  /**
   * The upgrade will stop after completing each upgrade domain and automatically monitor health before proceeding. The value is 3
   */
  Monitored: "Monitored",
}

/**
 * The kind of service (Stateless or Stateful).
 */
union ServiceKind {
  string,

  /**
   * Indicates the service kind is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Does not use Service Fabric to make its state highly available or reliable. The value is 1.
   */
  Stateless: "Stateless",

  /**
   * Uses Service Fabric to make its state or part of its state highly available and reliable. The value is 2.
   */
  Stateful: "Stateful",
}

/**
 * Enumerates the ways that a service can be partitioned.
 */
union PartitionScheme {
  string,

  /**
   * Indicates the partition kind is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Indicates that the partition is based on string names, and is a SingletonPartitionSchemeDescription object, The value is 1.
   */
  Singleton: "Singleton",

  /**
   * Indicates that the partition is based on Int64 key ranges, and is a UniformInt64RangePartitionSchemeDescription object. The value is 2.
   */
  UniformInt64Range: "UniformInt64Range",

  /**
   * Indicates that the partition is based on string names, and is a NamedPartitionSchemeDescription object. The value is 3
   */
  Named: "Named",
}

/**
 * The activation Mode of the service package
 */
union ArmServicePackageActivationMode {
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
   * An invalid correlation scheme. Cannot be used. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Indicates that this service has an affinity relationship with another service. Provided for backwards compatibility, consider preferring the Aligned or NonAlignedAffinity options. The value is 1.
   */
  Affinity: "Affinity",

  /**
   * Aligned affinity ensures that the primaries of the partitions of the affinitized services are collocated on the same nodes. This is the default and is the same as selecting the Affinity scheme. The value is 2.
   */
  AlignedAffinity: "AlignedAffinity",

  /**
   * Non-Aligned affinity guarantees that all replicas of each service will be placed on the same nodes. Unlike Aligned Affinity, this does not guarantee that replicas of particular role will be collocated. The value is 3.
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
   * Indicates the type of the placement policy is invalid. All Service Fabric enumerations have the invalid type. The value is zero.
   */
  Invalid: "Invalid",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementInvalidDomainPolicyDescription, which indicates that a particular fault or upgrade domain cannot be used for placement of this service. The value is 1.
   */
  InvalidDomain: "InvalidDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription indicating that the replicas of the service must be placed in a specific domain. The value is 2.
   */
  RequiredDomain: "RequiredDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementPreferPrimaryDomainPolicyDescription, which indicates that if possible the Primary replica for the partitions of the service should be located in a particular domain as an optimization. The value is 3.
   */
  PreferredPrimaryDomain: "PreferredPrimaryDomain",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementRequireDomainDistributionPolicyDescription, indicating that the system will disallow placement of any two replicas from the same partition in the same domain at any time. The value is 4.
   */
  RequiredDomainDistribution: "RequiredDomainDistribution",

  /**
   * Indicates that the ServicePlacementPolicyDescription is of type ServicePlacementNonPartiallyPlaceServicePolicyDescription, which indicates that if possible all replicas of a particular partition of the service should be placed atomically. The value is 5.
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
 * The type of managed identity for the resource.
 */
enum ManagedIdentityType {
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

  /**
   * Indicates that no identity is associated with the resource.
   */
  None,
}

/**
 * Describes the cluster resource properties.
 */
model ClusterProperties {
  /**
   * The list of add-on features to enable in the cluster.
   */
  addOnFeatures?: AddOnFeatures[];

  /**
   * The Service Fabric runtime versions available for this cluster.
   */
  @visibility(Lifecycle.Read)
  availableClusterVersions?: ClusterVersionDetails[];

  /**
   * The AAD authentication settings of the cluster.
   */
  azureActiveDirectory?: AzureActiveDirectory;

  /**
   * The certificate to use for securing the cluster. The certificate provided will be used for node to node security within the cluster, SSL certificate for cluster management endpoint and default admin client.
   */
  certificate?: CertificateDescription;

  /**
   * Describes a list of server certificates referenced by common name that are used to secure the cluster.
   */
  certificateCommonNames?: ServerCertificateCommonNames;

  /**
   * The list of client certificates referenced by common name that are allowed to manage the cluster.
   */
  clientCertificateCommonNames?: ClientCertificateCommonName[];

  /**
   * The list of client certificates referenced by thumbprint that are allowed to manage the cluster.
   */
  clientCertificateThumbprints?: ClientCertificateThumbprint[];

  /**
   * The Service Fabric runtime version of the cluster. This property can only by set the user when **upgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](https://learn.microsoft.com/rest/api/servicefabric/cluster-versions/list). To get the list of available version for existing clusters use **availableClusterVersions**.
   */
  clusterCodeVersion?: string;

  /**
   * The Azure Resource Provider endpoint. A system service in the cluster connects to this  endpoint.
   */
  @visibility(Lifecycle.Read)
  clusterEndpoint?: string;

  /**
   * A service generated unique identifier for the cluster resource.
   */
  @visibility(Lifecycle.Read)
  clusterId?: string;

  /**
   * The current state of the cluster.
   *
   *   - WaitingForNodes - Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
   *   - Deploying - Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
   *   - BaselineUpgrade - Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
   *   - UpdatingUserConfiguration - Indicates that the cluster is being upgraded with the user provided configuration.
   *   - UpdatingUserCertificate - Indicates that the cluster is being upgraded with the user provided certificate.
   *   - UpdatingInfrastructure - Indicates that the cluster is being upgraded with the latest Service Fabric runtime version. This happens only when the **upgradeMode** is set to 'Automatic'.
   *   - EnforcingClusterVersion - Indicates that cluster is on a different version than expected and the cluster is being upgraded to the expected version.
   *   - UpgradeServiceUnreachable - Indicates that the system service in the cluster is no longer polling the Resource Provider. Clusters in this state cannot be managed by the Resource Provider.
   *   - AutoScale - Indicates that the ReliabilityLevel of the cluster is being adjusted.
   *   - Ready - Indicates that the cluster is in a stable state.
   *
   */
  @visibility(Lifecycle.Read)
  clusterState?: ClusterState;

  /**
   * The storage account information for storing Service Fabric diagnostic logs.
   */
  diagnosticsStorageAccountConfig?: DiagnosticsStorageAccountConfig;

  /**
   * Indicates if the event store service is enabled.
   */
  eventStoreServiceEnabled?: boolean;

  /**
   * The list of custom fabric settings to configure the cluster.
   */
  fabricSettings?: SettingsSectionDescription[];

  /**
   * The http management endpoint of the cluster.
   */
  managementEndpoint: string;

  /**
   * The list of node types in the cluster.
   */
  nodeTypes: NodeTypeDescription[];

  /**
   * The provisioning state of the cluster resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
   *
   *   - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
   *   - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
   *   - Silver - Run the System services with a target replica set count of 5.
   *   - Gold - Run the System services with a target replica set count of 7.
   *   - Platinum - Run the System services with a target replica set count of 9.
   *
   */
  reliabilityLevel?: ReliabilityLevel;

  /**
   * The server certificate used by reverse proxy.
   */
  reverseProxyCertificate?: CertificateDescription;

  /**
   * Describes a list of server certificates referenced by common name that are used to secure the cluster.
   */
  reverseProxyCertificateCommonNames?: ServerCertificateCommonNames;

  /**
   * The policy to use when upgrading the cluster.
   */
  upgradeDescription?: ClusterUpgradePolicy;

  /**
   * The upgrade mode of the cluster when new Service Fabric runtime version is available.
   */
  upgradeMode?: UpgradeMode = UpgradeMode.Automatic;

  /**
   * The policy used to clean up unused versions.
   */
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  /**
   * The VM image VMSS has been configured with. Generic names such as Windows or Linux can be used.
   */
  vmImage?: string;

  /**
   * This property controls the logical grouping of VMs in upgrade domains (UDs). This property can't be modified if a node type with multiple Availability Zones is already present in the cluster.
   */
  sfZonalUpgradeMode?: SfZonalUpgradeMode;

  /**
   * This property defines the upgrade mode for the virtual machine scale set, it is mandatory if a node type with multiple Availability Zones is added.
   */
  vmssZonalUpgradeMode?: VmssZonalUpgradeMode;

  /**
   * Indicates if infrastructure service manager is enabled.
   */
  infrastructureServiceManager?: boolean;

  /**
   * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **upgradeMode** is set to 'Automatic'.
   */
  upgradeWave?: ClusterUpgradeCadence;

  /**
   * Indicates the start date and time to pause automatic runtime version upgrades on the cluster for an specific period of time on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseStartTimestampUtc?: utcDateTime;

  /**
   * Indicates the end date and time to pause automatic runtime version upgrades on the cluster for an specific period of time on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseEndTimestampUtc?: utcDateTime;

  /**
   * Boolean to pause automatic runtime version upgrades to the cluster.
   */
  waveUpgradePaused?: boolean;

  /**
   * Indicates a list of notification channels for cluster events.
   */
  notifications?: Notification[];

  /**
   * If true, token-based authentication is not allowed on the HttpGatewayEndpoint. This is required to support TLS versions 1.3 and above. If token-based authentication is used, HttpGatewayTokenAuthEndpointPort must be defined.
   */
  enableHttpGatewayExclusiveAuthMode?: boolean;
}

/**
 * The detail of the Service Fabric runtime version result
 */
model ClusterVersionDetails {
  /**
   * The Service Fabric runtime version of the cluster.
   */
  codeVersion?: string;

  /**
   * The date of expiry of support of the version.
   */
  supportExpiryUtc?: string;

  /**
   * Indicates if this version is for Windows or Linux operating system.
   */
  environment?: ClusterEnvironment;
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
 * Describes the certificate details.
 */
model CertificateDescription {
  /**
   * Thumbprint of the primary certificate.
   */
  thumbprint: string;

  /**
   * Thumbprint of the secondary certificate.
   */
  thumbprintSecondary?: string;

  /**
   * The local certificate store location.
   */
  x509StoreName?: StoreName;
}

/**
 * Describes a list of server certificates referenced by common name that are used to secure the cluster.
 */
model ServerCertificateCommonNames {
  /**
   * The list of server certificates referenced by common name that are used to secure the cluster.
   */
  commonNames?: ServerCertificateCommonName[];

  /**
   * The local certificate store location.
   */
  x509StoreName?: StoreName;
}

/**
 * Describes the server certificate details using common name.
 */
model ServerCertificateCommonName {
  /**
   * The common name of the server certificate.
   */
  certificateCommonName: string;

  /**
   * The issuer thumbprint of the server certificate.
   */
  certificateIssuerThumbprint: string;
}

/**
 * Describes the client certificate details using common name.
 */
model ClientCertificateCommonName {
  /**
   * Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.
   */
  isAdmin: boolean;

  /**
   * The common name of the client certificate.
   */
  certificateCommonName: string;

  /**
   * The issuer thumbprint of the client certificate.
   */
  certificateIssuerThumbprint: string;
}

/**
 * Describes the client certificate details using thumbprint.
 */
model ClientCertificateThumbprint {
  /**
   * Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.
   */
  isAdmin: boolean;

  /**
   * The thumbprint of the client certificate.
   */
  certificateThumbprint: string;
}

/**
 * The storage account information for storing Service Fabric diagnostic logs.
 */
model DiagnosticsStorageAccountConfig {
  /**
   * The Azure storage account name.
   */
  storageAccountName: string;

  /**
   * The protected diagnostics storage key name.
   */
  protectedAccountKeyName: string;

  /**
   * The secondary protected diagnostics storage key name. If one of the storage account keys is rotated the cluster will fallback to using the other.
   */
  protectedAccountKeyName2?: string;

  /**
   * The blob endpoint of the azure storage account.
   */
  blobEndpoint: string;

  /**
   * The queue endpoint of the azure storage account.
   */
  queueEndpoint: string;

  /**
   * The table endpoint of the azure storage account.
   */
  tableEndpoint: string;
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
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
model NodeTypeDescription {
  /**
   * The name of the node type.
   */
  name: string;

  /**
   * The placement tags applied to nodes in the node type, which can be used to indicate where certain services (workload) should run.
   */
  placementProperties?: Record<string>;

  /**
   * The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.
   */
  capacities?: Record<string>;

  /**
   * The TCP cluster management endpoint port.
   */
  clientConnectionEndpointPort: int32;

  /**
   * The HTTP cluster management endpoint port.
   */
  httpGatewayEndpointPort: int32;

  /**
   * The durability level of the node type. Learn about [DurabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
   *
   *   - Bronze - No privileges. This is the default.
   *   - Silver - The infrastructure jobs can be paused for a duration of 10 minutes per UD.
   *   - Gold - The infrastructure jobs can be paused for a duration of 2 hours per UD. Gold durability can be enabled only on full node VM skus like D15_V2, G5 etc.
   *
   */
  durabilityLevel?: DurabilityLevel;

  /**
   * The range of ports from which cluster assigned port to Service Fabric applications.
   */
  applicationPorts?: EndpointRangeDescription;

  /**
   * The range of ephemeral ports that nodes in this node type should be configured with.
   */
  ephemeralPorts?: EndpointRangeDescription;

  /**
   * The node type on which system services will run. Only one node type should be marked as primary. Primary node type cannot be deleted or changed for existing clusters.
   */
  isPrimary: boolean;

  /**
   * VMInstanceCount should be 1 to n, where n indicates the number of VM instances corresponding to this nodeType. VMInstanceCount = 0 can be done only in these scenarios: NodeType is a secondary nodeType. Durability = Bronze or Durability >= Bronze and InfrastructureServiceManager = true. If VMInstanceCount = 0, implies the VMs for this nodeType will not be used for the initial cluster size computation.
   */
  @maxValue(2147483647)
  vmInstanceCount: int32;

  /**
   * The endpoint used by reverse proxy.
   */
  reverseProxyEndpointPort?: int32;

  /**
   * Indicates if the node type can only host Stateless workloads.
   */
  isStateless?: boolean;

  /**
   * Indicates if the node type is enabled to support multiple zones.
   */
  multipleAvailabilityZones?: boolean;

  /**
   * The port used for token-auth based HTTPS connections to the cluster. Cannot be set to the same port as HttpGatewayEndpoint.
   */
  httpGatewayTokenAuthEndpointPort?: int32;
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
 * Describes the policy used when upgrading the cluster.
 */
model ClusterUpgradePolicy {
  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  upgradeReplicaSetCheckTimeout: string;

  /**
   * The length of time to wait after completing an upgrade domain before performing health checks. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  healthCheckWaitDuration: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
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

  /**
   * The cluster health policy used when upgrading the cluster.
   */
  healthPolicy: ClusterHealthPolicy;

  /**
   * The cluster delta health policy used when upgrading the cluster.
   */
  deltaHealthPolicy?: ClusterUpgradeDeltaHealthPolicy;
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
  @maxValue(100)
  maxPercentUnhealthyNodes?: int32;

  /**
   * The maximum allowed percentage of unhealthy applications before reporting an error. For example, to allow 10% of applications to be unhealthy, this value would be 10.
   *
   * The percentage represents the maximum tolerated percentage of applications that can be unhealthy before the cluster is considered in error.
   * If the percentage is respected but there is at least one unhealthy application, the health is evaluated as Warning.
   * This is calculated by dividing the number of unhealthy applications over the total number of application instances in the cluster, excluding applications of application types that are included in the ApplicationTypeHealthPolicyMap.
   * The computation rounds up to tolerate one failure on small numbers of applications. Default percentage is zero.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyApplications?: int32;

  /**
   * Defines the application health policy map used to evaluate the health of an application or one of its children entities.
   */
  applicationHealthPolicies?: Record<ApplicationHealthPolicy>;
}

/**
 * Defines a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model ApplicationHealthPolicy {
  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  serviceTypeHealthPolicies?: Record<ServiceTypeHealthPolicy>;
}

/**
 * Represents the health policy used to evaluate the health of services belonging to a service type.
 *
 */
model ServiceTypeHealthPolicy {
  /**
   * The maximum percentage of services allowed to be unhealthy before your application is considered in error.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyServices?: int32;
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
  maxPercentUpgradeDomainDeltaUnhealthyNodes: int32;

  /**
   * The maximum allowed percentage of applications health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the applications at the beginning of upgrade and the state of the applications at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits. System services are not included in this.
   *
   */
  @maxValue(100)
  maxPercentDeltaUnhealthyApplications: int32;

  /**
   * Defines the application delta health policy map used to evaluate the health of an application or one of its child entities when upgrading the cluster.
   */
  applicationDeltaHealthPolicies?: Record<ApplicationDeltaHealthPolicy>;
}

/**
 * Defines a delta health policy used to evaluate the health of an application or one of its child entities when upgrading the cluster.
 *
 */
model ApplicationDeltaHealthPolicy {
  /**
   * The delta health policy used by default to evaluate the health of a service type when upgrading the cluster.
   */
  defaultServiceTypeDeltaHealthPolicy?: ServiceTypeDeltaHealthPolicy;

  /**
   * The map with service type delta health policy per service type name. The map is empty by default.
   */
  serviceTypeDeltaHealthPolicies?: Record<ServiceTypeDeltaHealthPolicy>;
}

/**
 * Represents the delta health policy used to evaluate the health of services belonging to a service type when upgrading the cluster.
 *
 */
model ServiceTypeDeltaHealthPolicy {
  /**
   * The maximum allowed percentage of services health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the services at the beginning of upgrade and the state of the services at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.
   *
   */
  @maxValue(100)
  maxPercentDeltaUnhealthyServices?: int32;
}

model ApplicationTypeVersionsCleanupPolicy {
  /**
   * Number of unused versions per application type to keep.
   */
  maxUnusedVersionsToKeep: int64;
}

/**
 * Describes the notification channel for cluster events.
 */
model Notification {
  /**
   * Indicates if the notification is enabled.
   */
  isEnabled: boolean;

  /**
   * The category of notification.
   */
  notificationCategory: NotificationCategory;

  /**
   * The level of notification.
   */
  notificationLevel: NotificationLevel;

  /**
   * List of targets that subscribe to the notification.
   */
  notificationTargets: NotificationTarget[];
}

/**
 * Describes the notification target properties.
 */
model NotificationTarget {
  /**
   * The notification channel indicates the type of receivers subscribed to the notification, either user or subscription.
   */
  notificationChannel: NotificationChannel;

  /**
   * List of targets that subscribe to the notification.
   */
  receivers: string[];
}

/**
 * The resource model definition.
 */
model Resource {
  /**
   * Azure resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Azure resource tags.
   */
  tags?: Record<string>;

  /**
   * Azure resource etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: string;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: string;

  /**
   * The timestamp of resource last modification (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
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
 * Cluster update request
 */
model ClusterUpdateParameters {
  /**
   * Describes the cluster resource properties that can be updated during PATCH operation.
   */
  properties?: ClusterPropertiesUpdateParameters;

  /**
   * Cluster update parameters
   */
  tags?: Record<string>;
}

/**
 * Describes the cluster resource properties that can be updated during PATCH operation.
 */
model ClusterPropertiesUpdateParameters {
  /**
   * The list of add-on features to enable in the cluster.
   */
  addOnFeatures?: AddOnFeatures[];

  /**
   * The certificate to use for securing the cluster. The certificate provided will be used for  node to node security within the cluster, SSL certificate for cluster management endpoint and default  admin client.
   */
  certificate?: CertificateDescription;

  /**
   * Describes a list of server certificates referenced by common name that are used to secure the cluster.
   */
  certificateCommonNames?: ServerCertificateCommonNames;

  /**
   * The list of client certificates referenced by common name that are allowed to manage the cluster. This will overwrite the existing list.
   */
  clientCertificateCommonNames?: ClientCertificateCommonName[];

  /**
   * The list of client certificates referenced by thumbprint that are allowed to manage the cluster. This will overwrite the existing list.
   */
  clientCertificateThumbprints?: ClientCertificateThumbprint[];

  /**
   * The Service Fabric runtime version of the cluster. This property can only by set the user when **upgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](https://learn.microsoft.com/rest/api/servicefabric/cluster-versions/list). To get the list of available version for existing clusters use **availableClusterVersions**.
   */
  clusterCodeVersion?: string;

  /**
   * Indicates if the event store service is enabled.
   */
  eventStoreServiceEnabled?: boolean;

  /**
   * The list of custom fabric settings to configure the cluster. This will overwrite the existing list.
   */
  fabricSettings?: SettingsSectionDescription[];

  /**
   * The list of node types in the cluster. This will overwrite the existing list.
   */
  nodeTypes?: NodeTypeDescription[];

  /**
   * The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
   *
   *   - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
   *   - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
   *   - Silver - Run the System services with a target replica set count of 5.
   *   - Gold - Run the System services with a target replica set count of 7.
   *   - Platinum - Run the System services with a target replica set count of 9.
   *
   */
  reliabilityLevel?: ReliabilityLevel;

  /**
   * The server certificate used by reverse proxy.
   */
  reverseProxyCertificate?: CertificateDescription;

  /**
   * The policy to use when upgrading the cluster.
   */
  upgradeDescription?: ClusterUpgradePolicy;

  /**
   * The policy used to clean up unused versions.
   */
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  /**
   * The upgrade mode of the cluster when new Service Fabric runtime version is available.
   */
  upgradeMode?: UpgradeMode = UpgradeMode.Automatic;

  /**
   * This property controls the logical grouping of VMs in upgrade domains (UDs). This property can't be modified if a node type with multiple Availability Zones is already present in the cluster.
   */
  sfZonalUpgradeMode?: SfZonalUpgradeMode;

  /**
   * This property defines the upgrade mode for the virtual machine scale set, it is mandatory if a node type with multiple Availability Zones is added.
   */
  vmssZonalUpgradeMode?: VmssZonalUpgradeMode;

  /**
   * Indicates if infrastructure service manager is enabled.
   */
  infrastructureServiceManager?: boolean;

  /**
   * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **upgradeMode** is set to 'Automatic'.
   */
  upgradeWave?: ClusterUpgradeCadence;

  /**
   * The start timestamp to pause runtime version upgrades on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseStartTimestampUtc?: utcDateTime;

  /**
   * The end timestamp of pause runtime version upgrades on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseEndTimestampUtc?: utcDateTime;

  /**
   * Boolean to pause automatic runtime version upgrades to the cluster.
   */
  waveUpgradePaused?: boolean;

  /**
   * Indicates a list of notification channels for cluster events.
   */
  notifications?: Notification[];

  /**
   * If true, token-based authentication is not allowed on the HttpGatewayEndpoint. This is required to support TLS versions 1.3 and above. If token-based authentication is used, HttpGatewayTokenAuthEndpointPort must be defined.
   */
  enableHttpGatewayExclusiveAuthMode?: boolean;
}

/**
 * The result of the Service Fabric runtime versions
 */
model ClusterCodeVersionsResult {
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
  properties?: ClusterVersionDetails;
}

model UpgradableVersionsDescription {
  /**
   * The target code version.
   */
  targetVersion: string;
}

/**
 * The list of intermediate cluster code versions for an upgrade or downgrade. Or minimum and maximum upgradable version if no target was given
 */
model UpgradableVersionPathResult {
  supportedPath?: string[];
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
 * Describes the result of the request to list VM Sizes for Service Fabric Clusters.
 */
model VMSizesResult is Azure.Core.Page<VMSizeResource>;

/**
 * VM Sizes properties.
 */
model VMSize {
  /**
   * VM Size name.
   */
  @visibility(Lifecycle.Read)
  size?: string;
}

/**
 * The application type name properties
 */
model ApplicationTypeResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * The resource model definition for proxy-only resource.
 */
model ProxyResource {
  /**
   * Azure resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * It will be deprecated in New API, resource location depends on the parent resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Azure resource tags.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tags?: Record<string>;

  /**
   * Azure resource etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The list of application type names.
 */
model ApplicationTypeResourceList is Azure.Core.Page<ApplicationTypeResource>;

/**
 * The properties of the application type version resource.
 */
model ApplicationTypeVersionResourceProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The URL to the application package
   */
  appPackageUrl: string;

  /**
   * List of application type parameters that can be overridden when creating or updating the application.
   */
  @visibility(Lifecycle.Read)
  defaultParameterList?: Record<string>;
}

/**
 * The list of application type version resources for the specified application type name resource.
 */
model ApplicationTypeVersionResourceList
  is Azure.Core.Page<ApplicationTypeVersionResource>;

/**
 * Describes the managed identities for an Azure resource.
 */
model ManagedIdentity {
  /**
   * The principal id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
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
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

model UserAssignedIdentity {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The application resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApplicationResourceProperties
  extends ApplicationResourceUpdateProperties {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The application type name as defined in the application manifest.
   */
  typeName?: string;
}

/**
 * The application resource properties for patch operations.
 */
model ApplicationResourceUpdateProperties {
  /**
   * The version of the application type as defined in the application manifest.
   */
  typeVersion?: string;

  /**
   * List of application parameters with overridden values from their default values specified in the application manifest.
   */
  parameters?: Record<string>;

  /**
   * Describes the policy for a monitored application upgrade.
   */
  upgradePolicy?: ApplicationUpgradePolicy;

  /**
   * The minimum number of nodes where Service Fabric will reserve capacity for this application. Note that this does not mean that the services of this application will be placed on all of those nodes. If this property is set to zero, no capacity will be reserved. The value of this property cannot be more than the value of the MaximumNodes property.
   */
  minimumNodes?: int64;

  /**
   * The maximum number of nodes where Service Fabric will reserve capacity for this application. Note that this does not mean that the services of this application will be placed on all of those nodes. By default, the value of this property is zero and it means that the services can be placed on any node.
   */
  maximumNodes?: int64;

  /**
   * Remove the current application capacity settings.
   */
  removeApplicationCapacity?: boolean;

  /**
   * List of application capacity metric description.
   */
  metrics?: ApplicationMetricDescription[];

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
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. Valid values are between 0 and 42949672925 inclusive. (unsigned 32-bit integer).
   */
  upgradeReplicaSetCheckTimeout?: string;

  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean;

  /**
   * The policy used for monitoring the application upgrade
   */
  rollingUpgradeMonitoringPolicy?: ArmRollingUpgradeMonitoringPolicy;

  /**
   * Defines a health policy used to evaluate the health of an application or one of its children entities.
   *
   */
  applicationHealthPolicy?: ArmApplicationHealthPolicy;

  /**
   * The mode used to monitor health during a rolling upgrade. The values are UnmonitoredAuto, UnmonitoredManual, and Monitored.
   */
  upgradeMode?: RollingUpgradeMode = RollingUpgradeMode.Monitored;

  /**
   * Determines whether the application should be recreated on update. If value=true, the rest of the upgrade policy parameters are not allowed and it will result in availability loss.
   */
  recreateApplication?: boolean;
}

/**
 * The policy used for monitoring the application upgrade
 */
model ArmRollingUpgradeMonitoringPolicy {
  /**
   * The activation Mode of the service package
   */
  failureAction?: ArmUpgradeFailureAction;

  /**
   * The amount of time to wait after completing an upgrade domain before applying health policies. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckWaitDuration?: string = "0";

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckStableDuration?: string = "PT0H2M0S";

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  healthCheckRetryTimeout?: string = "PT0H10M0S";

  /**
   * The amount of time the overall upgrade has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  upgradeTimeout?: string = "P10675199DT02H48M05.4775807S";

  /**
   * The amount of time each upgrade domain has to complete before FailureAction is executed. It is first interpreted as a string representing an ISO 8601 duration. If that fails, then it is interpreted as a number representing the total number of milliseconds.
   */
  upgradeDomainTimeout?: string = "P10675199DT02H48M05.4775807S";
}

/**
 * Defines a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model ArmApplicationHealthPolicy {
  /**
   * Indicates whether warnings are treated with the same severity as errors.
   */
  considerWarningAsError?: boolean;

  /**
   * The maximum allowed percentage of unhealthy deployed applications. Allowed values are Byte values from zero to 100.
   * The percentage represents the maximum tolerated percentage of deployed applications that can be unhealthy before the application is considered in error.
   * This is calculated by dividing the number of unhealthy deployed applications over the number of nodes where the application is currently deployed on in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   */
  maxPercentUnhealthyDeployedApplications?: int32;

  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ArmServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  serviceTypeHealthPolicyMap?: Record<ArmServiceTypeHealthPolicy>;
}

/**
 * Represents the health policy used to evaluate the health of services belonging to a service type.
 *
 */
model ArmServiceTypeHealthPolicy {
  /**
   * The maximum percentage of services allowed to be unhealthy before your application is considered in error.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyServices?: int32;

  /**
   * The maximum percentage of partitions per service allowed to be unhealthy before your application is considered in error.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyPartitionsPerService?: int32;

  /**
   * The maximum percentage of replicas per partition allowed to be unhealthy before your application is considered in error.
   *
   */
  @maxValue(100)
  maxPercentUnhealthyReplicasPerPartition?: int32;
}

/**
 * Describes capacity information for a custom resource balancing metric. This can be used to limit the total consumption of this metric by the services of this application.
 *
 */
model ApplicationMetricDescription {
  /**
   * The name of the metric.
   */
  name?: string;

  /**
   * The maximum node capacity for Service Fabric application.
   * This is the maximum Load for an instance of this application on a single node. Even if the capacity of node is greater than this value, Service Fabric will limit the total load of services within the application on each node to this value.
   * If set to zero, capacity for this metric is unlimited on each node.
   * When creating a new application with application capacity defined, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
   * When updating existing application with application capacity, the product of MaximumNodes and this value must always be smaller than or equal to TotalApplicationCapacity.
   *
   */
  maximumCapacity?: int64;

  /**
   * The node reservation capacity for Service Fabric application.
   * This is the amount of load which is reserved on nodes which have instances of this application.
   * If MinimumNodes is specified, then the product of these values will be the capacity reserved in the cluster for the application.
   * If set to zero, no capacity is reserved for this metric.
   * When setting application capacity or when updating application capacity; this value must be smaller than or equal to MaximumCapacity for each metric.
   *
   */
  reservationCapacity?: int64;

  /**
   * The total metric capacity for Service Fabric application.
   * This is the total metric capacity for this application in the cluster. Service Fabric will try to limit the sum of loads of services within the application to this value.
   * When creating a new application with application capacity defined, the product of MaximumNodes and MaximumCapacity must always be smaller than or equal to this value.
   *
   */
  totalApplicationCapacity?: int64;
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
 * The application resource for patch operations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApplicationResourceUpdate extends ProxyResource {
  /**
   * The application resource properties for patch operations.
   */
  properties?: ApplicationResourceUpdateProperties;
}

/**
 * The list of application resources.
 */
model ApplicationResourceList is Azure.Core.Page<ApplicationResource>;

/**
 * The service resource properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@discriminator("serviceKind")
model ServiceResourceProperties extends ServiceResourcePropertiesBase {
  /**
   * The current deployment or provisioning state, which only appears in the response
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: ServiceKind;

  /**
   * The name of the service type
   */
  serviceTypeName?: string;

  /**
   * Describes how the service is partitioned.
   */
  partitionDescription?: PartitionSchemeDescription;

  /**
   * The activation Mode of the service package
   */
  servicePackageActivationMode?: ArmServicePackageActivationMode;

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
model PartitionSchemeDescription {
  /**
   * Specifies how the service is partitioned.
   */
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
  correlationScheme?: ServiceCorrelationDescription[];

  /**
   * The service load metrics is given as an array of ServiceLoadMetricDescription objects.
   */
  serviceLoadMetrics?: ServiceLoadMetricDescription[];

  /**
   * A list that describes the correlation of the service with other services.
   */
  servicePlacementPolicies?: ServicePlacementPolicyDescription[];

  /**
   * Specifies the move cost for the service.
   */
  defaultMoveCost?: MoveCost;
}

/**
 * Creates a particular correlation between services.
 */
model ServiceCorrelationDescription {
  /**
   * The ServiceCorrelationScheme which describes the relationship between this service and the service specified via ServiceName.
   */
  scheme: ServiceCorrelationScheme;

  /**
   * The name of the service that the correlation relationship is established with.
   */
  serviceName: string;
}

/**
 * Specifies a metric to load balance a service during runtime.
 */
model ServiceLoadMetricDescription {
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
model ServicePlacementPolicyDescription {
  /**
   * The type of placement policy for a service fabric service. Following are the possible values.
   */
  type: ServicePlacementPolicyType;
}

/**
 * The service resource for patch operations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ServiceResourceUpdate extends ProxyResource {
  /**
   * The service resource properties for patch operations.
   */
  properties?: ServiceResourceUpdateProperties;
}

/**
 * The service resource properties for patch operations.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@discriminator("serviceKind")
model ServiceResourceUpdateProperties extends ServiceResourcePropertiesBase {
  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: ServiceKind;
}

/**
 * The list of service resources.
 */
model ServiceResourceList is Azure.Core.Page<ServiceResource>;

/**
 * Describes the named partition scheme of the service.
 */
model NamedPartitionSchemeDescription extends PartitionSchemeDescription {
  /**
   * The number of partitions.
   */
  count: int32;

  /**
   * Array of size specified by the ‘count’ parameter, for the names of the partitions.
   */
  names: string[];

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "Named";
}

/**
 * SingletonPartitionSchemeDescription
 */
model SingletonPartitionSchemeDescription extends PartitionSchemeDescription {
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
   * The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaRestartWaitDuration?: utcDateTime;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  quorumLossWaitDuration?: utcDateTime;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  standByReplicaKeepDuration?: utcDateTime;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateful";
}

/**
 * The properties of a stateful service resource for patch operations.
 */
model StatefulServiceUpdateProperties extends ServiceResourceUpdateProperties {
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
   * The duration between when a replica goes down and when a new replica is created, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  replicaRestartWaitDuration?: utcDateTime;

  /**
   * The maximum duration for which a partition is allowed to be in a state of quorum loss, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  quorumLossWaitDuration?: utcDateTime;

  /**
   * The definition on how long StandBy replicas should be maintained before being removed, represented in ISO 8601 format (hh:mm:ss.s).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  standByReplicaKeepDuration?: utcDateTime;

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
  instanceCount?: int32;

  /**
   * Delay duration for RequestDrain feature to ensures that the endpoint advertised by the stateless instance is removed before the delay starts prior to closing the instance. This delay enables existing requests to drain gracefully before the instance actually goes down (https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-application-upgrade-advanced#avoid-connection-drops-during-stateless-service-planned-downtime-preview). It is represented in ISO 8601 format (hh:mm:ss.s).
   */
  instanceCloseDelayDuration?: string;

  /**
   * MinInstanceCount is the minimum number of instances that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstanceCount computation -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstanceCount?: int32;

  /**
   * MinInstancePercentage is the minimum percentage of InstanceCount that must be up to meet the EnsureAvailability safety check during operations like upgrade or deactivate node. The actual number that is used is max( MinInstanceCount, ceil( MinInstancePercentage/100.0 * InstanceCount) ). Note, if InstanceCount is set to -1, during MinInstancePercentage computation, -1 is first converted into the number of nodes on which the instances are allowed to be placed according to the placement constraints on the service.
   */
  minInstancePercentage?: bytes;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateless";
}

/**
 * The properties of a stateless service resource for patch operations.
 */
model StatelessServiceUpdateProperties extends ServiceResourceUpdateProperties {
  /**
   * The instance count.
   */
  @minValue(-1)
  instanceCount?: int32;

  /**
   * Delay duration for RequestDrain feature to ensures that the endpoint advertised by the stateless instance is removed before the delay starts prior to closing the instance. This delay enables existing requests to drain gracefully before the instance actually goes down (https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-application-upgrade-advanced#avoid-connection-drops-during-stateless-service-planned-downtime-preview). It is represented in ISO 8601 format (hh:mm:ss.s).
   */
  instanceCloseDelayDuration?: string;

  /**
   * The kind of service (Stateless or Stateful).
   */
  serviceKind: "Stateless";
}

/**
 * Describes a partitioning scheme where an integer range is allocated evenly across a number of partitions.
 */
model UniformInt64RangePartitionSchemeDescription
  extends PartitionSchemeDescription {
  /**
   * The number of partitions.
   */
  count: int32;

  /**
   * String indicating the lower bound of the partition key range that
   * should be split between the partition ‘count’
   *
   */
  lowKey: string;

  /**
   * String indicating the upper bound of the partition key range that
   * should be split between the partition ‘count’
   *
   */
  highKey: string;

  /**
   * Specifies how the service is partitioned.
   */
  partitionScheme: "UniformInt64Range";
}
