import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Workloads;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Defines the environment type - Production/Non Production.
 */
enum SAPEnvironmentType {
  NonProd,
  Prod,
}

/**
 * Defines the SAP Product type.
 */
enum SAPProductType {
  ECC,
  S4HANA,
  Other,
}

/**
 * The type of SAP deployment, single server or Three tier.
 */
enum SAPDeploymentType {
  SingleServer,
  ThreeTier,
}

/**
 * Defines the supported SAP Database types.
 */
enum SAPDatabaseType {
  HANA,
  DB2,
}

/**
 * The database scale method.
 */
enum SAPDatabaseScaleMethod {
  ScaleUp,
}

/**
 * The high availability type (AvailabilitySet or AvailabilityZone).
 */
enum SAPHighAvailabilityType {
  AvailabilitySet,
  AvailabilityZone,
}

/**
 * Defines the disk sku name.
 */
enum DiskSkuName {
  Standard_LRS,
  Premium_LRS,
  StandardSSD_LRS,
  UltraSSD_LRS,
  Premium_ZRS,
  StandardSSD_ZRS,
  PremiumV2_LRS,
}

/**
 * Type of managed service identity (only None, UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  UserAssigned,
}

/**
 * The configuration Type.
 */
enum SAPConfigurationType {
  Deployment,
  Discovery,
  DeploymentWithOSConfig,
}

/**
 * Defines the SAP Instance status.
 */
enum SAPVirtualInstanceStatus {
  Starting,
  Running,
  Stopping,
  Offline,
  PartiallyRunning,
  Unavailable,
  SoftShutdown,
}

/**
 * Defines the health of SAP Instances.
 */
enum SAPHealthState {
  Unknown,
  Healthy,
  Unhealthy,
  Degraded,
}

/**
 * Defines the Virtual Instance for SAP state.
 */
enum SAPVirtualInstanceState {
  InfrastructureDeploymentPending,
  InfrastructureDeploymentInProgress,
  InfrastructureDeploymentFailed,
  SoftwareInstallationPending,
  SoftwareInstallationInProgress,
  SoftwareInstallationFailed,
  SoftwareDetectionInProgress,
  SoftwareDetectionFailed,
  DiscoveryPending,
  DiscoveryInProgress,
  DiscoveryFailed,
  RegistrationComplete,
}

/**
 * Defines the provisioning states.
 */
enum SapVirtualInstanceProvisioningState {
  Succeeded,
  Updating,
  Creating,
  Failed,
  Deleting,
}

/**
 * Defines the type of Enqueue Replication Server.
 */
enum EnqueueReplicationServerType {
  EnqueueReplicator1,
  EnqueueReplicator2,
}

/**
 * Defines the type of central server VM.
 */
enum CentralServerVirtualMachineType {
  Primary,
  Secondary,
  Unknown,
  ASCS,
  ERSInactive,
  ERS,
  Standby,
}

/**
 * Defines the type of application server VM.
 */
enum ApplicationServerVirtualMachineType {
  Active,
  Standby,
  Unknown,
}

/**
 * State of provisioning of the SAP monitor.
 */
enum WorkloadMonitorProvisioningState {
  Accepted,
  Creating,
  Updating,
  Failed,
  Succeeded,
  Deleting,
  Migrating,
}

/**
 * Sets the routing preference of the SAP monitor. By default only RFC1918 traffic is routed to the customer VNET.
 */
enum RoutingPreference {
  Default,
  RouteAll,
}

/**
 * State of provisioning of the SAP monitor.
 */
enum SapLandscapeMonitorProvisioningState {
  Accepted,
  Created,
  Failed,
  Succeeded,
  Canceled,
}

/**
 * The OS Type
 */
enum OSType {
  Linux,
  Windows,
}

/**
 * The pattern type to be used for resource naming.
 */
enum NamingPatternType {
  FullResourceName,
}

/**
 * The type of file share config.
 */
enum ConfigurationType {
  Skip,
  CreateAndMount,
  Mount,
}

/**
 * The SAP software installation Type.
 */
enum SAPSoftwareInstallationType {
  ServiceInitiated,
  SAPInstallWithoutOSConfig,
  External,
}

/**
 * Defines the workload operation origin.
 */
enum OperationProperties {
  NotSpecified,
  User,
  System,
}

/**
 * Defines the action type of workload operation.
 */
enum WorkloadMonitorActionType {
  NotSpecified,
  Internal,
}

/**
 * Gets or sets certificate preference if secure communication is enabled.
 */
enum SslPreference {
  Disabled,
  RootCertificate,
  ServerCertificate,
}

/**
 * The SAP Sizing Recommendation request.
 */
model SAPSizingRecommendationRequest {
  /**
   * The geo-location where the resource is to be created.
   */
  appLocation: string;

  /**
   * Defines the environment type - Production/Non Production.
   */
  environment: SAPEnvironmentType;

  /**
   * Defines the SAP Product type.
   */
  sapProduct: SAPProductType;

  /**
   * The deployment type. Eg: SingleServer/ThreeTier
   */
  deploymentType: SAPDeploymentType;

  /**
   * The SAP Application Performance Standard measurement.
   */
  saps: int64;

  /**
   * The database memory configuration.
   */
  dbMemory: int64;

  /**
   * The database type.
   */
  databaseType: SAPDatabaseType;

  /**
   * The DB scale method.
   */
  dbScaleMethod?: SAPDatabaseScaleMethod;

  /**
   * The high availability type.
   */
  highAvailabilityType?: SAPHighAvailabilityType;
}

/**
 * The SAP sizing recommendation result.
 */
@discriminator("deploymentType")
model SAPSizingRecommendationResult {}

/**
 * The SAP request to get list of supported SKUs.
 */
model SAPSupportedSkusRequest {
  /**
   * The geo-location where the resource is to be created.
   */
  appLocation: string;

  /**
   * Defines the environment type - Production/Non Production.
   */
  environment: SAPEnvironmentType;

  /**
   * Defines the SAP Product type.
   */
  sapProduct: SAPProductType;

  /**
   * The deployment type. Eg: SingleServer/ThreeTier
   */
  deploymentType: SAPDeploymentType;

  /**
   * The database type. Eg: HANA, DB2, etc
   */
  databaseType: SAPDatabaseType;

  /**
   * The high availability type.
   */
  highAvailabilityType?: SAPHighAvailabilityType;
}

/**
 * The list of supported SKUs for different resources which are part of SAP deployment.
 */
model SAPSupportedResourceSkusResult {
  /**
   * Gets the list of SAP supported SKUs.
   */
  supportedSkus?: SAPSupportedSku[];
}

/**
 * The SAP supported SKU.
 */
model SAPSupportedSku {
  /**
   * The VM Sku.
   */
  vmSku?: string;

  /**
   * True if the Sku is certified for App server in the SAP system.
   */
  isAppServerCertified?: boolean;

  /**
   * True if the Sku is certified for Database server in the SAP system.
   */
  isDatabaseCertified?: boolean;
}

/**
 * The SAP request to get list of disk configurations.
 */
model SAPDiskConfigurationsRequest {
  /**
   * The geo-location where the SAP resources will be created.
   */
  appLocation: string;

  /**
   * Defines the environment type - Production/Non Production.
   */
  environment: SAPEnvironmentType;

  /**
   * Defines the SAP Product type.
   */
  sapProduct: SAPProductType;

  /**
   * The database type. Eg: HANA, DB2, etc
   */
  databaseType: SAPDatabaseType;

  /**
   * The deployment type. Eg: SingleServer/ThreeTier
   */
  deploymentType: SAPDeploymentType;

  /**
   * The VM SKU for database instance.
   */
  dbVmSku: string;
}

/**
 * The list of disk configuration for vmSku which are part of SAP deployment.
 */
model SAPDiskConfigurationsResult {
  /**
   * The disk configuration for the db volume. For HANA, Required volumes are: ['hana/data', 'hana/log', hana/shared', 'usr/sap', 'os'], Optional volume : ['backup'].
   */
  volumeConfigurations?: Record<SAPDiskConfiguration>;
}

/**
 * The SAP Disk Configuration contains 'recommended disk' details and list of supported disks detail for a volume type.
 */
model SAPDiskConfiguration {
  /**
   * The recommended disk details for a given VM Sku.
   */
  recommendedConfiguration?: DiskVolumeConfiguration;

  /**
   * The list of supported disks for a given VM Sku.
   */
  supportedConfigurations?: DiskDetails[];
}

/**
 * The disk configuration required for the selected volume.
 */
model DiskVolumeConfiguration {
  /**
   * The total number of disks required for the concerned volume.
   */
  count?: int64;

  /**
   * The disk size in GB.
   */
  sizeGB?: int64;

  /**
   * The disk SKU details.
   */
  sku?: DiskSku;
}

/**
 * The type of disk sku. For example, Standard_LRS, Standard_ZRS, Premium_LRS, Premium_ZRS.
 */
model DiskSku {
  /**
   * Defines the disk sku name.
   */
  name?: DiskSkuName;
}

/**
 * The supported disk size details for a disk type.
 */
model DiskDetails {
  /**
   * The type of disk sku. For example, Standard_LRS, Standard_ZRS, Premium_LRS, Premium_ZRS.
   */
  sku?: DiskSku;

  /**
   * The disk size in GB.
   */
  sizeGB?: int64;

  /**
   * The minimum supported disk count.
   */
  minimumSupportedDiskCount?: int64;

  /**
   * The maximum supported disk count.
   */
  maximumSupportedDiskCount?: int64;

  /**
   * The disk Iops.
   */
  iopsReadWrite?: int64;

  /**
   * The disk provisioned throughput in MBps.
   */
  mbpsReadWrite?: int64;

  /**
   * The disk tier, e.g. P10, E10.
   */
  diskTier?: string;
}

/**
 * The SAP request to get list of availability zones.
 */
model SAPAvailabilityZoneDetailsRequest {
  /**
   * The geo-location where the SAP resources will be created.
   */
  appLocation: string;

  /**
   * Defines the SAP Product type.
   */
  sapProduct: SAPProductType;

  /**
   * The database type. Eg: HANA, DB2, etc
   */
  databaseType: SAPDatabaseType;
}

/**
 * The list of supported availability zone pairs which are part of SAP HA deployment.
 */
model SAPAvailabilityZoneDetailsResult {
  /**
   * Gets the list of availability zone pairs.
   */
  availabilityZonePairs?: SAPAvailabilityZonePair[];
}

/**
 * The SAP Availability Zone Pair.
 */
model SAPAvailabilityZonePair {
  /**
   * The zone A.
   */
  zoneA?: int64;

  /**
   * The zone B.
   */
  zoneB?: int64;
}

/**
 * A pre-created user assigned identity with appropriate roles assigned. To learn more on identity and roles required, visit the ACSS how-to-guide.
 */
model UserAssignedServiceIdentity {
  /**
   * Type of manage identity
   */
  type: ManagedServiceIdentityType;

  /**
   * User assigned identities dictionary
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Defines the Virtual Instance for SAP solutions resource properties.
 */
model SAPVirtualInstanceProperties {
  /**
   * Defines the environment type - Production/Non Production.
   */
  @visibility("read", "create")
  environment: SAPEnvironmentType;

  /**
   * Defines the SAP Product type.
   */
  @visibility("read", "create")
  sapProduct: SAPProductType;

  /**
   * Defines if the SAP system is being created using Azure Center for SAP solutions (ACSS) or if an existing SAP system is being registered with ACSS
   */
  configuration: SAPConfiguration;

  /**
   * Managed resource group configuration
   */
  managedResourceGroupConfiguration?: ManagedRGConfiguration;

  /**
   * Defines the SAP Instance status.
   */
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  /**
   * Defines the health of SAP Instances.
   */
  @visibility("read")
  health?: SAPHealthState;

  /**
   * Defines the Virtual Instance for SAP state.
   */
  @visibility("read")
  state?: SAPVirtualInstanceState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  /**
   * Indicates any errors on the Virtual Instance for SAP solutions resource.
   */
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

/**
 * The SAP Configuration.
 */
@discriminator("configurationType")
model SAPConfiguration {}

/**
 * Managed resource group configuration
 */
model ManagedRGConfiguration {
  /**
   * Managed resource group name
   */
  name?: string;
}

/**
 * An error response from the Virtual Instance for SAP Workload service.
 */
model SAPVirtualInstanceError {
  /**
   * The Virtual Instance for SAP error body.
   */
  properties?: ErrorDefinition;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  details?: ErrorDefinition[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Defines the request body for updating Virtual Instance for SAP.
 */
model UpdateSAPVirtualInstanceRequest {
  /**
   * Gets or sets the Resource tags.
   */
  tags?: Record<string>;

  /**
   * A pre-created user assigned identity with appropriate roles assigned. To learn more on identity and roles required, visit the ACSS how-to-guide.
   */
  identity?: UserAssignedServiceIdentity;
}

/**
 * Defines the SAP Central Services Instance properties.
 */
model SAPCentralServerProperties {
  /**
   * The central services instance number.
   */
  @visibility("read")
  instanceNo?: string;

  /**
   * The central services instance subnet.
   */
  @visibility("read")
  @projectedName("json", "subnet")
  subnetId?: string;

  /**
   * Defines the SAP Message Server properties.
   */
  messageServerProperties?: MessageServerProperties;

  /**
   * Defines the SAP Enqueue Server properties.
   */
  enqueueServerProperties?: EnqueueServerProperties;

  /**
   * Defines the SAP Gateway Server properties.
   */
  gatewayServerProperties?: GatewayServerProperties;

  /**
   * Defines the SAP Enqueue Replication Server (ERS) properties.
   */
  enqueueReplicationServerProperties?: EnqueueReplicationServerProperties;

  /**
   * The central services instance Kernel Version.
   */
  @visibility("read")
  kernelVersion?: string;

  /**
   * The central services instance Kernel Patch level.
   */
  @visibility("read")
  kernelPatch?: string;

  /**
   * The Load Balancer details such as LoadBalancer ID attached to ASCS Virtual Machines
   */
  @visibility("read")
  loadBalancerDetails?: LoadBalancerDetails;

  /**
   * The list of virtual machines corresponding to the Central Services instance.
   */
  @visibility("read")
  vmDetails?: CentralServerVmDetails[];

  /**
   * Defines the SAP Instance status.
   */
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  /**
   * Defines the health of SAP Instances.
   */
  @visibility("read")
  health?: SAPHealthState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  /**
   * Defines the errors related to SAP Central Services Instance resource.
   */
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

/**
 * Defines the SAP Message Server properties.
 */
model MessageServerProperties {
  /**
   * Message Server port.
   */
  @visibility("read")
  msPort?: int64;

  /**
   * Message Server internal MS port.
   */
  @visibility("read")
  internalMsPort?: int64;

  /**
   * Message Server HTTP Port.
   */
  @visibility("read")
  httpPort?: int64;

  /**
   * Message Server HTTPS Port.
   */
  @visibility("read")
  httpsPort?: int64;

  /**
   * Message Server SAP Hostname.
   */
  @visibility("read")
  hostname?: string;

  /**
   * Message server IP Address.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * Defines the health of SAP Instances.
   */
  @visibility("read")
  health?: SAPHealthState;
}

/**
 * Defines the SAP Enqueue Server properties.
 */
model EnqueueServerProperties {
  /**
   * Enqueue Server SAP Hostname.
   */
  @visibility("read")
  hostname?: string;

  /**
   * Enqueue Server SAP IP Address.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * Enqueue Server Port.
   */
  @visibility("read")
  port?: int64;

  /**
   * Defines the health of SAP Instances.
   */
  @visibility("read")
  health?: SAPHealthState;
}

/**
 * Defines the SAP Gateway Server properties.
 */
model GatewayServerProperties {
  /**
   * Gateway Port.
   */
  @visibility("read")
  port?: int64;

  /**
   * Defines the health of SAP Instances.
   */
  @visibility("read")
  health?: SAPHealthState;
}

/**
 * Defines the SAP Enqueue Replication Server (ERS) properties.
 */
model EnqueueReplicationServerProperties {
  /**
   * Defines the type of Enqueue Replication Server.
   */
  @visibility("read")
  ersVersion?: EnqueueReplicationServerType;

  /**
   * ERS Instance Number.
   */
  @visibility("read")
  instanceNo?: string;

  /**
   * ERS SAP Hostname.
   */
  @visibility("read")
  hostname?: string;

  /**
   * ERS SAP Kernel Version.
   */
  @visibility("read")
  kernelVersion?: string;

  /**
   * ERS SAP Kernel Patch level.
   */
  @visibility("read")
  kernelPatch?: string;

  /**
   * ERS SAP IP Address.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * Defines the health of SAP Instances.
   */
  @visibility("read")
  health?: SAPHealthState;
}

/**
 * The Load Balancer details such as Load Balancer ID.
 */
model LoadBalancerDetails {
  @visibility("read")
  id?: string;
}

/**
 * The SAP Central Services Instance VM details.
 */
model CentralServerVmDetails {
  /**
   * Defines the type of central server VM.
   */
  @visibility("read")
  type?: CentralServerVirtualMachineType;

  @visibility("read")
  virtualMachineId?: string;

  /**
   * Storage details of all the Storage Accounts attached to the ASCS Virtual Machine. For e.g. NFS on AFS Shared Storage.
   */
  @visibility("read")
  storageDetails?: StorageInformation[];
}

/**
 * Storage details of all the Storage accounts attached to the VM. For e.g. NFS on AFS Shared Storage.
 */
model StorageInformation {
  @visibility("read")
  id?: string;
}

/**
 * Defines the request body for updating SAP Central Instance.
 */
model UpdateSAPCentralInstanceRequest {
  /**
   * Gets or sets the Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Defines the Database properties.
 */
model SAPDatabaseProperties {
  /**
   * Database subnet.
   */
  @visibility("read")
  @projectedName("json", "subnet")
  subnetId?: string;

  /**
   * Database SID name.
   */
  @visibility("read")
  databaseSid?: string;

  /**
   * Database type, that is if the DB is HANA, DB2, Oracle, SAP ASE, Max DB or MS SQL Server.
   */
  @visibility("read")
  databaseType?: string;

  /**
   * Database IP Address.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * The Load Balancer details such as LoadBalancer ID attached to Database Virtual Machines
   */
  @visibility("read")
  loadBalancerDetails?: LoadBalancerDetails;

  /**
   * The list of virtual machines corresponding to the Database resource.
   */
  @visibility("read")
  vmDetails?: DatabaseVmDetails[];

  /**
   * Defines the SAP Instance status.
   */
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  /**
   * Defines the errors related to Database resource.
   */
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

/**
 * Database VM details.
 */
model DatabaseVmDetails {
  @visibility("read")
  virtualMachineId?: string;

  /**
   * Defines the SAP Instance status.
   */
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  /**
   * Storage details of all the Storage Accounts attached to the Database Virtual Machine. For e.g. NFS on AFS Shared Storage.
   */
  @visibility("read")
  storageDetails?: StorageInformation[];
}

/**
 * Defines the request body for updating SAP Database Instance.
 */
model UpdateSAPDatabaseInstanceRequest {
  /**
   * Gets or sets the Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Defines the SAP Application Server instance properties.
 */
model SAPApplicationServerProperties {
  /**
   * Application server Instance Number.
   */
  @visibility("read")
  instanceNo?: string;

  /**
   * Application server Subnet.
   */
  @visibility("read")
  @projectedName("json", "subnet")
  subnetId?: string;

  /**
   * Application server instance SAP hostname.
   */
  @visibility("read")
  hostname?: string;

  /**
   *  Application server instance SAP Kernel Version.
   */
  @visibility("read")
  kernelVersion?: string;

  /**
   * Application server instance SAP Kernel Patch level.
   */
  @visibility("read")
  kernelPatch?: string;

  /**
   *  Application server instance SAP IP Address.
   */
  @visibility("read")
  ipAddress?: string;

  /**
   * Application server instance gateway Port.
   */
  @visibility("read")
  gatewayPort?: int64;

  /**
   * Application server instance ICM HTTP Port.
   */
  @visibility("read")
  icmHttpPort?: int64;

  /**
   * Application server instance ICM HTTPS Port.
   */
  @visibility("read")
  icmHttpsPort?: int64;

  /**
   * The Load Balancer details such as LoadBalancer ID attached to Application Server Virtual Machines
   */
  @visibility("read")
  loadBalancerDetails?: LoadBalancerDetails;

  /**
   * The list of virtual machines.
   */
  @visibility("read")
  vmDetails?: ApplicationServerVmDetails[];

  /**
   * Defines the SAP Instance status.
   */
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  /**
   * Defines the health of SAP Instances.
   */
  @visibility("read")
  health?: SAPHealthState;

  /**
   * Defines the provisioning states.
   */
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  /**
   * Defines the Application Instance errors.
   */
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

/**
 * The Application Server VM Details.
 */
model ApplicationServerVmDetails {
  /**
   * Defines the type of application server VM.
   */
  @visibility("read")
  type?: ApplicationServerVirtualMachineType;

  @visibility("read")
  virtualMachineId?: string;

  /**
   * Storage details of all the Storage Accounts attached to the App Virtual Machine. For e.g. NFS on AFS Shared Storage.
   */
  @visibility("read")
  storageDetails?: StorageInformation[];
}

/**
 * Defines the request body for updating SAP Application Instance.
 */
model UpdateSAPApplicationInstanceRequest {
  /**
   * Gets or sets the Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Stop SAP instance(s) request body.
 */
model StopRequest {
  /**
   * This parameter defines how long (in seconds) the soft shutdown waits until the RFC/HTTP clients no longer consider the server for calls with load balancing. Value 0 means that the kernel does not wait, but goes directly into the next shutdown state, i.e. hard stop.
   */
  softStopTimeoutSeconds?: int64;
}

/**
 * Describes the properties of a SAP monitor.
 */
model MonitorProperties {
  /**
   * State of provisioning of the SAP monitor.
   */
  @visibility("read")
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Defines the SAP monitor errors.
   */
  @visibility("read")
  errors?: MonitorPropertiesErrors;

  /**
   * The SAP monitor resources will be deployed in the SAP monitoring region. The subnet region should be same as the SAP monitoring region.
   */
  appLocation?: string;

  /**
   * Sets the routing preference of the SAP monitor. By default only RFC1918 traffic is routed to the customer VNET.
   */
  routingPreference?: RoutingPreference;

  /**
   * Sets the preference for zone redundancy on resources created for the SAP monitor. By default resources will be created which do not support zone redundancy.
   */
  zoneRedundancyPreference?: string;

  /**
   * Managed resource group configuration
   */
  managedResourceGroupConfiguration?: ManagedRGConfiguration;

  /**
   * The ARM ID of the Log Analytics Workspace that is used for SAP monitoring.
   */
  logAnalyticsWorkspaceArmId?: string;

  /**
   * The subnet which the SAP monitor will be deployed in
   */
  monitorSubnet?: string;

  /**
   * The ARM ID of the MSI used for SAP monitoring.
   */
  @visibility("read")
  msiArmId?: string;

  /**
   * The ARM ID of the Storage account used for SAP monitoring.
   */
  @visibility("read")
  storageAccountArmId?: string;
}

/**
 * Defines the SAP monitor errors.
 */
model MonitorPropertiesErrors extends Error {}

/**
 * Standard error object.
 */
model Error {
  /**
   * Server-defined set of error codes.
   */
  @visibility("read")
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Target of the error.
   */
  @visibility("read")
  target?: string;

  /**
   * Array of details about specific errors that led to this reported error.
   */
  @visibility("read")
  details?: Error[];

  /**
   * Object containing more specific information than  the current object about the error.
   */
  @visibility("read")
  innerError?: ErrorInnerError;
}

/**
 * Object containing more specific information than  the current object about the error.
 */
model ErrorInnerError {
  /**
   * Standard error object.
   */
  innerError?: Error;
}

/**
 * Defines the request body for updating SAP monitor resource.
 */
model UpdateMonitorRequest {
  /**
   * Gets or sets the Resource tags.
   */
  tags?: Record<string>;

  /**
   * [currently not in use] Managed service identity(user assigned identities)
   */
  identity?: UserAssignedServiceIdentity;
}

/**
 * Describes the properties of a provider instance.
 */
model ProviderInstanceProperties {
  /**
   * State of provisioning of the provider instance
   */
  @visibility("read")
  provisioningState?: WorkloadMonitorProvisioningState;

  /**
   * Defines the provider instance errors.
   */
  @visibility("read")
  errors?: ProviderInstancePropertiesErrors;

  /**
   * Defines the provider specific properties.
   */
  providerSettings?: ProviderSpecificProperties;
}

/**
 * Defines the provider instance errors.
 */
model ProviderInstancePropertiesErrors extends Error {}

/**
 * Gets or sets the provider specific properties.
 */
@discriminator("providerType")
model ProviderSpecificProperties {}

/**
 * Gets or sets the properties for Sap Landscape Monitor Dashboard.
 */
model SapLandscapeMonitorProperties {
  /**
   * State of provisioning of the SAP monitor.
   */
  @visibility("read")
  provisioningState?: SapLandscapeMonitorProvisioningState;

  /**
   * Gets or sets the SID groupings by landscape and Environment.
   */
  grouping?: SapLandscapeMonitorPropertiesGrouping;

  /**
   * Gets or sets the list Top Metric Thresholds for SAP Landscape Monitor Dashboard
   */
  topMetricsThresholds?: SapLandscapeMonitorMetricThresholds[];
}

/**
 * Gets or sets the SID groupings by landscape and Environment.
 */
model SapLandscapeMonitorPropertiesGrouping {
  /**
   * Gets or sets the list of landscape to SID mappings.
   */
  landscape?: SapLandscapeMonitorSidMapping[];

  /**
   * Gets or sets the list of Sap Applications to SID mappings.
   */
  sapApplication?: SapLandscapeMonitorSidMapping[];
}

/**
 * Gets or sets the mapping for SID to Environment/Applications.
 */
model SapLandscapeMonitorSidMapping {
  /**
   * Gets or sets the name of the grouping.
   */
  name?: string;

  /**
   * Gets or sets the list of SID's.
   */
  topSid?: string[];
}

/**
 * Gets or sets the Threshold Values for Top Metrics Health.
 */
model SapLandscapeMonitorMetricThresholds {
  /**
   * Gets or sets the name of the threshold.
   */
  name?: string;

  /**
   * Gets or sets the threshold value for Green.
   */
  green?: float32;

  /**
   * Gets or sets the threshold value for Yellow.
   */
  yellow?: float32;

  /**
   * Gets or sets the threshold value for Red.
   */
  red?: float32;
}

/**
 * Specifies information about the image to use. You can specify information about platform images, marketplace images, or virtual machine images. This element is required when you want to use a platform image, marketplace image, or virtual machine image, but is not used in other creation operations. NOTE: Image reference publisher and offer can only be set when you create the scale set.
 */
model ImageReference {
  /**
   * The image publisher.
   */
  publisher?: string;

  /**
   * Specifies the offer of the platform image or marketplace image used to create the virtual machine.
   */
  offer?: string;

  /**
   * The image SKU.
   */
  sku?: string;

  /**
   * Specifies the version of the platform image or marketplace image used to create the virtual machine. The allowed formats are Major.Minor.Build or 'latest'. Major, Minor, and Build are decimal numbers. Specify 'latest' to use the latest version of an image available at deploy time. Even if you use 'latest', the VM image will not automatically update after deploy time even if a new version becomes available.
   */
  version?: string;
}

/**
 * Specifies Windows operating system settings on the virtual machine.
 */
model WindowsConfiguration extends OSConfiguration {
  /**
   * The OS Type
   */
  osType: "Windows";
}

/**
 * Defines the OS configuration.
 */
@discriminator("osType")
model OSConfiguration {}

/**
 * Contains information about SSH certificate public key and the path on the Linux VM where the public key is placed.
 */
model SshPublicKey {
  /**
   * SSH public key certificate used to authenticate with the VM through ssh. The key needs to be at least 2048-bit and in ssh-rsa format. <br><br> For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).
   */
  keyData?: string;
}

/**
 * SSH configuration for Linux based VMs running on Azure
 */
model SshConfiguration {
  /**
   * The list of SSH public keys used to authenticate with linux based VMs.
   */
  publicKeys?: SshPublicKey[];
}

/**
 * Specifies the Linux operating system settings on the virtual machine. <br><br>For a list of supported Linux distributions, see [Linux on Azure-Endorsed Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).
 */
model LinuxConfiguration extends OSConfiguration {
  /**
   * Specifies whether password authentication should be disabled.
   */
  disablePasswordAuthentication?: boolean;

  /**
   * Specifies the ssh key configuration for a Linux OS. (This property is deprecated, please use 'sshKeyPair' instead)
   */
  ssh?: SshConfiguration;

  /**
   * The SSH Key-pair used to authenticate with the VM's.
   */
  sshKeyPair?: SshKeyPair;

  /**
   * The OS Type
   */
  osType: "Linux";
}

/**
 * The SSH Key-pair used to authenticate with the VM. The key needs to be at least 2048-bit and in ssh-rsa format. <br><br> For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).
 */
model SshKeyPair {
  /**
   * SSH public key
   */
  publicKey?: string;

  /**
   * SSH private key.
   */
  privateKey?: string;
}

/**
 * Specifies the operating system settings for the virtual machine. Some of the settings cannot be changed once VM is provisioned.
 */
model OSProfile {
  /**
   * Specifies the name of the administrator account. <br><br> This property cannot be updated after the VM is created. <br><br> **Windows-only restriction:** Cannot end in "." <br><br> **Disallowed values:** "administrator", "admin", "user", "user1", "test", "user2", "test1", "user3", "admin1", "1", "123", "a", "actuser", "adm", "admin2", "aspnet", "backup", "console", "david", "guest", "john", "owner", "root", "server", "sql", "support", "support_388945a0", "sys", "test2", "test3", "user4", "user5". <br><br> **Minimum-length (Linux):** 1  character <br><br> **Max-length (Linux):** 64 characters <br><br> **Max-length (Windows):** 20 characters.
   */
  adminUsername?: string;

  /**
   * Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\W_]) <br><br> **Disallowed values:** "abc@123", "P@$$w0rd", "P@ssw0rd", "P@ssword123", "Pa$$word", "pass@word1", "Password!", "Password1", "Password22", "iloveyou!" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)
   */
  adminPassword?: string;

  /**
   * Specifies Windows operating system settings on the virtual machine.
   */
  osConfiguration?: OSConfiguration;
}

/**
 * The recommended configuration for a single server SAP system.
 */
model SingleServerRecommendationResult extends SAPSizingRecommendationResult {
  /**
   * The recommended VM SKU for single server.
   */
  vmSku?: string;

  /**
   * The type of SAP deployment, single server or Three tier.
   */
  deploymentType: "SingleServer";
}

/**
 * The recommended configuration for a three tier SAP system.
 */
model ThreeTierRecommendationResult extends SAPSizingRecommendationResult {
  /**
   * The database VM SKU.
   */
  dbVmSku?: string;

  /**
   * The database server instance count.
   */
  databaseInstanceCount?: int64;

  /**
   * The central server VM SKU.
   */
  centralServerVmSku?: string;

  /**
   * The central server instance count.
   */
  centralServerInstanceCount?: int64;

  /**
   * The application server VM SKU.
   */
  applicationServerVmSku?: string;

  /**
   * The application server instance count.
   */
  applicationServerInstanceCount?: int64;

  /**
   * The type of SAP deployment, single server or Three tier.
   */
  deploymentType: "ThreeTier";
}

/**
 * The Disk Configuration Details.
 */
model DiskConfiguration {
  /**
   * The disk configuration for the db volume. For HANA, Required volumes are: ['hana/data', 'hana/log', hana/shared', 'usr/sap', 'os'], Optional volume : ['backup'].
   */
  diskVolumeConfigurations?: Record<DiskVolumeConfiguration>;
}

/**
 * Defines the virtual machine configuration.
 */
model VirtualMachineConfiguration {
  /**
   * The virtual machine size.
   */
  vmSize: string;

  /**
   * The image reference.
   */
  imageReference: ImageReference;

  /**
   * The OS profile.
   */
  osProfile: OSProfile;
}

/**
 * Gets or sets the single server configuration. For prerequisites for creating the infrastructure, please see [here](https://go.microsoft.com/fwlink/?linkid=2212611&clcid=0x409)
 */
model SingleServerConfiguration extends InfrastructureConfiguration {
  /**
   * Network configuration for the server
   */
  networkConfiguration?: NetworkConfiguration;

  /**
   * The database type.
   */
  databaseType?: SAPDatabaseType;

  /**
   * The subnet id.
   */
  subnetId: string;

  /**
   * Gets or sets the virtual machine configuration.
   */
  virtualMachineConfiguration: VirtualMachineConfiguration;

  /**
   * Gets or sets the disk configuration.
   */
  dbDiskConfiguration?: DiskConfiguration;

  /**
   * The set of custom names to be used for underlying azure resources that are part of the SAP system.
   */
  customResourceNames?: SingleServerCustomResourceNames;

  /**
   * The type of SAP deployment, single server or Three tier.
   */
  deploymentType: "SingleServer";
}

/**
 * Defines the network configuration type for SAP system infrastructure that is being deployed
 */
model NetworkConfiguration {
  /**
   * Specifies whether a secondary IP address should be added to the network interface on all VMs of the SAP system being deployed
   */
  isSecondaryIpEnabled?: boolean;
}

/**
 * The resource-names input to specify custom names for underlying azure resources that are part of a single server SAP system.
 */
@discriminator("namingPatternType")
model SingleServerCustomResourceNames {}

/**
 * Deploy SAP Infrastructure Details.
 */
@discriminator("deploymentType")
model InfrastructureConfiguration {
  /**
   * The application resource group where SAP system resources will be deployed.
   */
  appResourceGroup: string;
}

/**
 * Gets or sets the central server configuration.
 */
model CentralServerConfiguration {
  /**
   * The subnet id.
   */
  subnetId: string;

  /**
   * Gets or sets the virtual machine configuration.
   */
  virtualMachineConfiguration: VirtualMachineConfiguration;

  /**
   * The number of central server VMs.
   */
  instanceCount: int64;
}

/**
 * Gets or sets the database configuration.
 */
model DatabaseConfiguration {
  /**
   * The database type.
   */
  databaseType?: SAPDatabaseType;

  /**
   * The subnet id.
   */
  subnetId: string;

  /**
   * Gets or sets the virtual machine configuration.
   */
  virtualMachineConfiguration: VirtualMachineConfiguration;

  /**
   * The number of database VMs.
   */
  instanceCount: int64;

  /**
   * Gets or sets the disk configuration.
   */
  diskConfiguration?: DiskConfiguration;
}

/**
 * Gets or sets the application server configuration.
 */
model ApplicationServerConfiguration {
  /**
   * The subnet id.
   */
  subnetId: string;

  /**
   * Gets or sets the virtual machine configuration.
   */
  virtualMachineConfiguration: VirtualMachineConfiguration;

  /**
   * The number of app server instances.
   */
  instanceCount: int64;
}

/**
 * Gets or sets the high availability configuration.
 */
model HighAvailabilityConfiguration {
  /**
   * The high availability type.
   */
  highAvailabilityType: SAPHighAvailabilityType;
}

/**
 * Gets or sets the file share configuration for scenarios where transport directory fileshare is not created or required.
 */
model SkipFileShareConfiguration extends FileShareConfiguration {
  /**
   * The type of file share config.
   */
  configurationType: "Skip";
}

/**
 * File Share configuration details, populated with information on storage configuration mounted on the VIS. The createAndMount option is selected in case of missing input.
 */
@discriminator("configurationType")
model FileShareConfiguration {}

/**
 * Gets or sets the file share configuration where the transport directory fileshare is created and mounted as a part of the create infra flow. Please pre-create the resource group you intend to place the transport directory in. The storage account and fileshare will be auto-created by the ACSS and doesn’t need to pre-created.
 */
model CreateAndMountFileShareConfiguration extends FileShareConfiguration {
  /**
   * The name of transport file share resource group. This should be pre created by the customer. The app rg is used in case of missing input.
   */
  resourceGroup?: string;

  /**
   * The name of file share storage account name . A custom name is used in case of missing input.
   */
  storageAccountName?: string;

  /**
   * The type of file share config.
   */
  configurationType: "CreateAndMount";
}

/**
 * Gets or sets the file share configuration where the transport directory fileshare already exists, and user wishes to mount the fileshare as a part of the create infra flow.
 */
model MountFileShareConfiguration extends FileShareConfiguration {
  /**
   * The fileshare resource ID
   */
  id: string;

  /**
   * The private endpoint resource ID
   */
  privateEndpointId: string;

  /**
   * The type of file share config.
   */
  configurationType: "Mount";
}

/**
 * Gets or sets the storage configuration.
 */
model StorageConfiguration {
  /**
   * The properties of the transport directory attached to the VIS. The default for transportFileShareConfiguration is the createAndMount flow if storage configuration is missing.
   */
  transportFileShareConfiguration?: FileShareConfiguration;
}

/**
 * Gets or sets the three tier SAP configuration. For prerequisites for creating the infrastructure, please see [here](https://go.microsoft.com/fwlink/?linkid=2212611&clcid=0x409)
 */
model ThreeTierConfiguration extends InfrastructureConfiguration {
  /**
   * Network configuration common to all servers
   */
  networkConfiguration?: NetworkConfiguration;

  /**
   * The central server configuration.
   */
  centralServer: CentralServerConfiguration;

  /**
   * The application server configuration.
   */
  applicationServer: ApplicationServerConfiguration;

  /**
   * The database configuration.
   */
  databaseServer: DatabaseConfiguration;

  /**
   * The high availability configuration.
   */
  highAvailabilityConfig?: HighAvailabilityConfiguration;

  /**
   * The storage configuration.
   */
  storageConfiguration?: StorageConfiguration;

  /**
   * The set of custom names to be used for underlying azure resources that are part of the SAP system.
   */
  customResourceNames?: ThreeTierCustomResourceNames;

  /**
   * The type of SAP deployment, single server or Three tier.
   */
  deploymentType: "ThreeTier";
}

/**
 * The resource-names input to specify custom names for underlying azure resources that are part of a three tier SAP system.
 */
@discriminator("namingPatternType")
model ThreeTierCustomResourceNames {}

/**
 * The resource name object where the specified values will be full resource names of the corresponding resources in a single server SAP system.
 */
model SingleServerFullResourceNames extends SingleServerCustomResourceNames {
  /**
   * The resource names object for virtual machine and related resources.
   */
  virtualMachine?: VirtualMachineResourceNames;

  /**
   * The pattern type to be used for resource naming.
   */
  namingPatternType: "FullResourceName";
}

/**
 * The resource names object for virtual machine and related resources.
 */
model VirtualMachineResourceNames {
  /**
   * The full name for virtual machine. The length of this field can be upto 64 characters. If name is not provided, service uses a default name based on the deployment type. For SingleServer, default name is {SID}vm. In case of HA-AvZone systems, default name will be {SID}{app/ascs/db}z{a/b}vm with an incrementor at the end in case of more than 1 vm per layer. For distributed and HA-AvSet systems, default name will be {SID}{app/ascs/db}vm with an incrementor at the end in case of more than 1 vm per layer.
   */
  vmName?: string;

  /**
   * The full name for virtual-machine's host (computer name). Currently, ACSS only supports host names which are less than or equal to 13 characters long. If this value is not provided, vmName will be used as host name.
   */
  hostName?: string;

  /**
   * The list of network interface name objects for the selected virtual machine. Currently, only one network interface is supported per virtual machine.
   */
  networkInterfaces?: NetworkInterfaceResourceNames[];

  /**
   * The full name for OS disk attached to the VM. If this value is not provided, it will be named by ARM as per its default naming standards (prefixed with vm name). There is only one OS disk attached per Virtual Machine.
   */
  osDiskName?: string;

  /**
   * The full resource names for virtual machine data disks. This is a dictionary containing list of names of data disks per volume. Currently supported volumes for database layer are ['hana/data', 'hana/log', hana/shared', 'usr/sap', 'os', 'backup']. For application and cs layers, only 'default' volume is supported
   */
  dataDiskNames?: Record<string[]>;
}

/**
 * The resource names object for network interface and related resources.
 */
model NetworkInterfaceResourceNames {
  /**
   * The full name for network interface. If name is not provided, service uses a default name based on the deployment type. For SingleServer, default name is {SID}-Nic. In case of HA-AvZone systems, default name will be {SID}-{App/ASCS/DB}-Zone{A/B}-Nic with an incrementor at the end in case of more than 1 instance per layer. For distributed and HA-AvSet systems, default name will be {SID}-{App/ASCS/DB}-Nic with an incrementor at the end in case of more than 1 instance per layer.
   */
  networkInterfaceName?: string;
}

/**
 * The resource name object where the specified values will be full resource names of the corresponding resources in a three tier SAP system.
 */
model ThreeTierFullResourceNames extends ThreeTierCustomResourceNames {
  /**
   * The full resource names object for central server layer resources.
   */
  centralServer?: CentralServerFullResourceNames;

  /**
   * The full resource names object for application layer resources. The number of entries in this list should be equal to the number VMs to be created for application layer.
   */
  applicationServer?: ApplicationServerFullResourceNames;

  /**
   * The full resource names object for database layer resources. The number of entries in this list should be equal to the number VMs to be created for database layer.
   */
  databaseServer?: DatabaseServerFullResourceNames;

  /**
   * The resource names object for shared storage.
   */
  sharedStorage?: SharedStorageResourceNames;

  /**
   * The pattern type to be used for resource naming.
   */
  namingPatternType: "FullResourceName";
}

/**
 * The full resource names object for central server layer resources.
 */
model CentralServerFullResourceNames {
  /**
   * The list of names for all ASCS virtual machines to be deployed. The number of entries in this list should be equal to the number VMs to be created for ASCS layer. At maximum, there can be two virtual machines at this layer: ASCS and ERS.
   */
  virtualMachines?: VirtualMachineResourceNames[];

  /**
   * The full name for availability set. In case name is not provided, it will be defaulted to {SID}-ASCS-AvSet.
   */
  availabilitySetName?: string;

  /**
   * The resource names object for load balancer and related resources.
   */
  loadBalancer?: LoadBalancerResourceNames;
}

/**
 * The resource names object for load balancer and related resources.
 */
model LoadBalancerResourceNames {
  /**
   * The full resource name for load balancer. If this value is not provided, load balancer will be name as {ASCS/DB}-loadBalancer.
   */
  loadBalancerName?: string;

  /**
   * The list of frontend IP configuration names. If provided as input, size of this list should be 2 for cs layer and should be 1 for database layer.
   */
  frontendIpConfigurationNames?: string[];

  /**
   * The list of backend pool names. Currently, ACSS deploys only one backend pool and hence, size of this list should be 1
   */
  backendPoolNames?: string[];

  /**
   * The list of health probe names. If provided as input, size of this list should be 2 for cs layer and should be 1 for database layer.
   */
  healthProbeNames?: string[];
}

/**
 * The full resource names object for application layer resources. The number of entries in this list should be equal to the number VMs to be created for application layer.
 */
model ApplicationServerFullResourceNames {
  /**
   * The list of virtual machine naming details.
   */
  virtualMachines?: VirtualMachineResourceNames[];

  /**
   * The full name for availability set. In case name is not provided, it will be defaulted to {SID}-App-AvSet.
   */
  availabilitySetName?: string;
}

/**
 * The full resource names object for database layer resources. The number of entries in this list should be equal to the number VMs to be created for database layer.
 */
model DatabaseServerFullResourceNames {
  /**
   * The list of virtual machine naming details.
   */
  virtualMachines?: VirtualMachineResourceNames[];

  /**
   * The full name for availability set. In case name is not provided, it will be defaulted to {SID}-DB-AvSet.
   */
  availabilitySetName?: string;

  /**
   * The resource names object for load balancer and related resources.
   */
  loadBalancer?: LoadBalancerResourceNames;
}

/**
 * The resource names object for shared storage.
 */
model SharedStorageResourceNames {
  /**
   * The full name of the shared storage account. If it is not provided, it will be defaulted to {SID}nfs{guid of 15 chars}.
   */
  sharedStorageAccountName?: string;

  /**
   * The full name of private end point for the shared storage account. If it is not provided, it will be defaulted to {storageAccountName}_pe
   */
  sharedStorageAccountPrivateEndPointName?: string;
}

/**
 * The SAP Software configuration Input.
 */
@discriminator("softwareInstallationType")
model SoftwareConfiguration {}

/**
 * The SAP Software configuration Input when the software is to be installed by service.
 */
model ServiceInitiatedSoftwareConfiguration extends SoftwareConfiguration {
  /**
   * The URL to the SAP Build of Materials(BOM) file.
   */
  bomUrl: string;

  /**
   * The software version to install.
   */
  softwareVersion: string;

  /**
   * The SAP bits storage account id.
   */
  sapBitsStorageAccountId: string;

  /**
   * The FQDN to set for the SAP system during install.
   */
  sapFqdn: string;

  /**
   * The SSH private key.
   */
  sshPrivateKey: string;

  /**
   * Gets or sets the HA software configuration.
   */
  highAvailabilitySoftwareConfiguration?: HighAvailabilitySoftwareConfiguration;

  /**
   * The SAP software installation Type.
   */
  softwareInstallationType: "ServiceInitiated";
}

/**
 * Gets or sets the HA software configuration.
 */
model HighAvailabilitySoftwareConfiguration {
  /**
   * The fencing client id.
   */
  fencingClientId: string;

  /**
   * The fencing client id secret/password. The secret should never expire. This will be used pacemaker to start/stop the cluster VMs.
   */
  fencingClientPassword: string;
}

/**
 * The SAP Software configuration Input when the software is to be installed by service without OS Configurations
 */
model SAPInstallWithoutOSConfigSoftwareConfiguration
  extends SoftwareConfiguration {
  /**
   * The URL to the SAP Build of Materials(BOM) file.
   */
  bomUrl: string;

  /**
   * The SAP bits storage account id.
   */
  sapBitsStorageAccountId: string;

  /**
   * The software version to install.
   */
  softwareVersion: string;

  /**
   * Gets or sets the HA software configuration.
   */
  highAvailabilitySoftwareConfiguration?: HighAvailabilitySoftwareConfiguration;

  /**
   * The SAP software installation Type.
   */
  softwareInstallationType: "SAPInstallWithoutOSConfig";
}

/**
 * The SAP Software configuration Input when the software is installed externally outside the service.
 */
model ExternalInstallationSoftwareConfiguration extends SoftwareConfiguration {
  /**
   * The resource ID of the virtual machine containing the central server instance.
   */
  centralServerVmId?: string;

  /**
   * The SAP software installation Type.
   */
  softwareInstallationType: "External";
}

/**
 * Discovery Details.
 */
model DiscoveryConfiguration extends SAPConfiguration {
  /**
   * The virtual machine ID of the Central Server.
   */
  centralServerVmId?: string;

  /**
   * The custom storage account name for the storage account created by the service in the managed resource group created as part of VIS deployment.<br><br>Refer to the storage account naming rules [here](https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftstorage).<br><br>If not provided, the service will create the storage account with a random name.
   */
  @maxLength(24)
  @minLength(3)
  managedRgStorageAccountName?: string;

  /**
   * The geo-location where the SAP system exists.
   */
  @visibility("read")
  appLocation?: string;

  /**
   * The configuration Type.
   */
  configurationType: "Discovery";
}

/**
 * Deployment Configuration.
 */
model DeploymentConfiguration extends SAPConfiguration {
  /**
   * The geo-location where the SAP system is to be created.
   */
  appLocation?: string;

  /**
   * The infrastructure configuration.
   */
  infrastructureConfiguration?: InfrastructureConfiguration;

  /**
   * The software configuration.
   */
  softwareConfiguration?: SoftwareConfiguration;

  /**
   * The configuration Type.
   */
  configurationType: "Deployment";
}

/**
 * Deployment along with OS Configuration.
 */
model DeploymentWithOSConfiguration extends SAPConfiguration {
  /**
   * The geo-location where the SAP system is to be created.
   */
  appLocation?: string;

  /**
   * The infrastructure configuration.
   */
  infrastructureConfiguration?: InfrastructureConfiguration;

  /**
   * The software configuration.
   */
  softwareConfiguration?: SoftwareConfiguration;

  /**
   * The OS and SAP configuration.
   */
  osSapConfiguration?: OsSapConfiguration;

  /**
   * The configuration Type.
   */
  configurationType: "DeploymentWithOSConfig";
}

/**
 * Defines the OS and SAP Configurations for Deployment
 */
model OsSapConfiguration {
  /**
   * The url and storage account ID where deployer VM packages are uploaded
   */
  deployerVmPackages?: DeployerVmPackages;

  /**
   * The FQDN to set for the SAP system
   */
  sapFqdn?: string;
}

/**
 * Defines the url and storage account ID where deployer VM packages are uploaded
 */
model DeployerVmPackages {
  /**
   * The URL to the deployer VM packages file.
   */
  url?: string;

  /**
   * The deployer VM packages storage account id
   */
  storageAccountId?: string;
}

/**
 * Defines the workload operation.
 */
model OperationsDisplayDefinition {
  /**
   * Defines the workload provider.
   */
  provider: string;

  /**
   * Defines the workload resource.
   */
  resource: string;

  /**
   * Defines the workload operation.
   */
  operation: string;

  /**
   * Describes the workload operation.
   */
  description: string;
}

/**
 * Properties of an Operation.
 */
model OperationsDefinition {
  /**
   * Name of the operation.
   */
  name: string;

  /**
   * Indicates whether the operation applies to data-plane.
   */
  isDataAction?: boolean;

  /**
   * Defines the workload operation origin.
   */
  origin?: OperationProperties;

  /**
   * Display information of the operation.
   */
  display: OperationsDisplayDefinition;

  /**
   * Defines the action type of workload operation.
   */
  actionType?: WorkloadMonitorActionType;

  /**
   * Defines the workload operation properties.
   */
  properties?: unknown;
}

/**
 * Defines the workload operation content.
 */
model OperationsContent extends Resource {
  /**
   * Operations content.
   */
  properties?: OperationsDefinition;
}

/**
 * Defines the workload operation definition response.
 */
model OperationsDefinitionArrayResponseWithContinuation {
  /**
   * Defines the workload operation definition response properties.
   */
  value?: OperationsDefinition[];

  /**
   * The URL to get to the next set of results, if there are any.
   */
  nextLink?: string;
}

/**
 * Tags field of the resource.
 */
model Tags {
  /**
   * Tags field of the resource.
   */
  tags?: Record<string>;
}

/**
 * Gets or sets the provider properties.
 */
model HanaDbProviderInstanceProperties extends ProviderSpecificProperties {
  /**
   * Gets or sets the target virtual machine size.
   */
  hostname?: string;

  /**
   * Gets or sets the hana database name.
   */
  dbName?: string;

  /**
   * Gets or sets the database sql port.
   */
  sqlPort?: string;

  /**
   * Gets or sets the database instance number.
   */
  instanceNumber?: string;

  /**
   * Gets or sets the database user name.
   */
  dbUsername?: string;

  /**
   * Gets or sets the database password.
   */
  dbPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the database password.
   */
  dbPasswordUri?: string;

  /**
   * Gets or sets the blob URI to SSL certificate for the DB.
   */
  sslCertificateUri?: string;

  /**
   * Gets or sets the hostname(s) in the SSL certificate.
   */
  sslHostNameInCertificate?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the SAP System Identifier.
   */
  sapSid?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "SapHana";
}

/**
 * Gets or sets the provider properties.
 */
model SapNetWeaverProviderInstanceProperties
  extends ProviderSpecificProperties {
  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * Gets or sets the target virtual machine IP Address/FQDN.
   */
  sapHostname?: string;

  /**
   * Gets or sets the instance number of SAP NetWeaver.
   */
  sapInstanceNr?: string;

  /**
   * Gets or sets the list of HostFile Entries
   */
  sapHostFileEntries?: string[];

  /**
   * Gets or sets the SAP user name.
   */
  sapUsername?: string;

  /**
   * Sets the SAP password.
   */
  sapPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the SAP password.
   */
  sapPasswordUri?: string;

  /**
   * Gets or sets the SAP Client ID.
   */
  sapClientId?: string;

  /**
   * Gets or sets the SAP HTTP port number.
   */
  sapPortNumber?: string;

  /**
   * Gets or sets the blob URI to SSL certificate for the SAP system.
   */
  sslCertificateUri?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "SapNetWeaver";
}

/**
 * Gets or sets the PrometheusOS provider properties.
 */
model PrometheusOSProviderInstanceProperties
  extends ProviderSpecificProperties {
  /**
   * URL of the Node Exporter endpoint
   */
  prometheusUrl?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the prometheus node exporter.
   */
  sslCertificateUri?: string;

  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "PrometheusOS";
}

/**
 * Gets or sets the DB2 provider properties.
 */
model DB2ProviderInstanceProperties extends ProviderSpecificProperties {
  /**
   * Gets or sets the target virtual machine name.
   */
  hostname?: string;

  /**
   * Gets or sets the db2 database name.
   */
  dbName?: string;

  /**
   * Gets or sets the db2 database sql port.
   */
  dbPort?: string;

  /**
   * Gets or sets the db2 database user name.
   */
  dbUsername?: string;

  /**
   * Gets or sets the db2 database password.
   */
  dbPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the database password.
   */
  dbPasswordUri?: string;

  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the DB2 Database.
   */
  sslCertificateUri?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "Db2";
}

/**
 * Gets or sets the PrometheusHaCluster provider properties.
 */
model PrometheusHaClusterProviderInstanceProperties
  extends ProviderSpecificProperties {
  /**
   * URL of the Node Exporter endpoint.
   */
  prometheusUrl?: string;

  /**
   * Gets or sets the target machine name.
   */
  hostname?: string;

  /**
   * Gets or sets the cluster sid.
   */
  sid?: string;

  /**
   * Gets or sets the clusterName.
   */
  clusterName?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the HA cluster exporter.
   */
  sslCertificateUri?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "PrometheusHaCluster";
}

/**
 * Gets or sets the SQL server provider properties.
 */
model MsSqlServerProviderInstanceProperties extends ProviderSpecificProperties {
  /**
   * Gets or sets the SQL server host name.
   */
  hostname?: string;

  /**
   * Gets or sets the database sql port.
   */
  dbPort?: string;

  /**
   * Gets or sets the database user name.
   */
  dbUsername?: string;

  /**
   * Gets or sets the database password.
   */
  dbPassword?: string;

  /**
   * Gets or sets the key vault URI to secret with the database password.
   */
  dbPasswordUri?: string;

  /**
   * Gets or sets the SAP System Identifier
   */
  sapSid?: string;

  /**
   * Gets or sets certificate preference if secure communication is enabled.
   */
  sslPreference?: SslPreference;

  /**
   * Gets or sets the blob URI to SSL certificate for the SQL Database.
   */
  sslCertificateUri?: string;

  /**
   * The provider type. For example, the value can be SapHana.
   */
  providerType: "MsSqlServer";
}
