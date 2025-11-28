import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Workloads;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Defines the environment type - Production/Non Production.")
enum SAPEnvironmentType {
  NonProd,
  Prod,
}

@doc("Defines the SAP Product type.")
enum SAPProductType {
  ECC,
  S4HANA,
  Other,
}

@doc("The type of SAP deployment, single server or Three tier.")
enum SAPDeploymentType {
  SingleServer,
  ThreeTier,
}

@doc("Defines the supported SAP Database types.")
enum SAPDatabaseType {
  HANA,
  DB2,
}

@doc("The database scale method.")
enum SAPDatabaseScaleMethod {
  ScaleUp,
}

@doc("The high availability type (AvailabilitySet or AvailabilityZone).")
enum SAPHighAvailabilityType {
  AvailabilitySet,
  AvailabilityZone,
}

@doc("Defines the disk sku name.")
enum DiskSkuName {
  Standard_LRS,
  Premium_LRS,
  StandardSSD_LRS,
  UltraSSD_LRS,
  Premium_ZRS,
  StandardSSD_ZRS,
  PremiumV2_LRS,
}

@doc("Type of managed service identity (only None, UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  UserAssigned,
}

@doc("Defines the network access type for managed resources.")
enum ManagedResourcesNetworkAccessType {
  Public,
  Private,
}

@doc("The configuration Type.")
enum SAPConfigurationType {
  Deployment,
  Discovery,
  DeploymentWithOSConfig,
}

@doc("Defines the SAP Instance status.")
enum SAPVirtualInstanceStatus {
  Starting,
  Running,
  Stopping,
  Offline,
  PartiallyRunning,
  Unavailable,
  SoftShutdown,
}

@doc("Defines the health of SAP Instances.")
enum SAPHealthState {
  Unknown,
  Healthy,
  Unhealthy,
  Degraded,
}

@doc("Defines the Virtual Instance for SAP state.")
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
  ACSSInstallationBlocked,
}

@doc("Defines the provisioning states.")
enum SapVirtualInstanceProvisioningState {
  Succeeded,
  Updating,
  Creating,
  Failed,
  Deleting,
  Canceled,
}

@doc("Defines the type of Enqueue Replication Server.")
enum EnqueueReplicationServerType {
  EnqueueReplicator1,
  EnqueueReplicator2,
}

@doc("Defines the type of central server VM.")
enum CentralServerVirtualMachineType {
  Primary,
  Secondary,
  Unknown,
  ASCS,
  ERSInactive,
  ERS,
  Standby,
}

@doc("Defines the type of application server VM.")
enum ApplicationServerVirtualMachineType {
  Active,
  Standby,
  Unknown,
}

@doc("The OS Type")
enum OSType {
  Linux,
  Windows,
}

@doc("The pattern type to be used for resource naming.")
enum NamingPatternType {
  FullResourceName,
}

@doc("The type of file share config.")
enum ConfigurationType {
  Skip,
  CreateAndMount,
  Mount,
}

@doc("The SAP software installation Type.")
enum SAPSoftwareInstallationType {
  ServiceInitiated,
  SAPInstallWithoutOSConfig,
  External,
}

@doc("The SAP Sizing Recommendation request.")
model SAPSizingRecommendationRequest {
  @doc("The geo-location where the resource is to be created.")
  appLocation: string;

  @doc("Defines the environment type - Production/Non Production.")
  environment: SAPEnvironmentType;

  @doc("Defines the SAP Product type.")
  sapProduct: SAPProductType;

  @doc("The deployment type. Eg: SingleServer/ThreeTier")
  deploymentType: SAPDeploymentType;

  @doc("The SAP Application Performance Standard measurement.")
  saps: int64;

  @doc("The database memory configuration.")
  dbMemory: int64;

  @doc("The database type.")
  databaseType: SAPDatabaseType;

  @doc("The DB scale method.")
  dbScaleMethod?: SAPDatabaseScaleMethod;

  @doc("The high availability type.")
  highAvailabilityType?: SAPHighAvailabilityType;
}

@doc("The SAP sizing recommendation result.")
@discriminator("deploymentType")
model SAPSizingRecommendationResult {}

@doc("The SAP request to get list of supported SKUs.")
model SAPSupportedSkusRequest {
  @doc("The geo-location where the resource is to be created.")
  appLocation: string;

  @doc("Defines the environment type - Production/Non Production.")
  environment: SAPEnvironmentType;

  @doc("Defines the SAP Product type.")
  sapProduct: SAPProductType;

  @doc("The deployment type. Eg: SingleServer/ThreeTier")
  deploymentType: SAPDeploymentType;

  @doc("The database type. Eg: HANA, DB2, etc")
  databaseType: SAPDatabaseType;

  @doc("The high availability type.")
  highAvailabilityType?: SAPHighAvailabilityType;
}

@doc("The list of supported SKUs for different resources which are part of SAP deployment.")
model SAPSupportedResourceSkusResult {
  @doc("Gets the list of SAP supported SKUs.")
  supportedSkus?: SAPSupportedSku[];
}

@doc("The SAP supported SKU.")
model SAPSupportedSku {
  @doc("The VM Sku.")
  vmSku?: string;

  @doc("True if the Sku is certified for App server in the SAP system.")
  isAppServerCertified?: boolean;

  @doc("True if the Sku is certified for Database server in the SAP system.")
  isDatabaseCertified?: boolean;
}

@doc("The SAP request to get list of disk configurations.")
model SAPDiskConfigurationsRequest {
  @doc("The geo-location where the SAP resources will be created.")
  appLocation: string;

  @doc("Defines the environment type - Production/Non Production.")
  environment: SAPEnvironmentType;

  @doc("Defines the SAP Product type.")
  sapProduct: SAPProductType;

  @doc("The database type. Eg: HANA, DB2, etc")
  databaseType: SAPDatabaseType;

  @doc("The deployment type. Eg: SingleServer/ThreeTier")
  deploymentType: SAPDeploymentType;

  @doc("The VM SKU for database instance.")
  dbVmSku: string;
}

@doc("The list of disk configuration for vmSku which are part of SAP deployment.")
model SAPDiskConfigurationsResult {
  @doc("The disk configuration for the db volume. For HANA, Required volumes are: ['hana/data', 'hana/log', hana/shared', 'usr/sap', 'os'], Optional volume : ['backup'].")
  volumeConfigurations?: Record<SAPDiskConfiguration>;
}

@doc("The SAP Disk Configuration contains 'recommended disk' details and list of supported disks detail for a volume type.")
model SAPDiskConfiguration {
  @doc("The recommended disk details for a given VM Sku.")
  recommendedConfiguration?: DiskVolumeConfiguration;

  @doc("The list of supported disks for a given VM Sku.")
  supportedConfigurations?: DiskDetails[];
}

@doc("The disk configuration required for the selected volume.")
model DiskVolumeConfiguration {
  @doc("The total number of disks required for the concerned volume.")
  count?: int64;

  @doc("The disk size in GB.")
  sizeGB?: int64;

  @doc("The disk SKU details.")
  sku?: DiskSku;
}

@doc("The type of disk sku. For example, Standard_LRS, Standard_ZRS, Premium_LRS, Premium_ZRS.")
model DiskSku {
  @doc("Defines the disk sku name.")
  name?: DiskSkuName;
}

@doc("The supported disk size details for a disk type.")
model DiskDetails {
  @doc("The type of disk sku. For example, Standard_LRS, Standard_ZRS, Premium_LRS, Premium_ZRS.")
  sku?: DiskSku;

  @doc("The disk size in GB.")
  sizeGB?: int64;

  @doc("The minimum supported disk count.")
  minimumSupportedDiskCount?: int64;

  @doc("The maximum supported disk count.")
  maximumSupportedDiskCount?: int64;

  @doc("The disk Iops.")
  iopsReadWrite?: int64;

  @doc("The disk provisioned throughput in MBps.")
  mbpsReadWrite?: int64;

  @doc("The disk tier, e.g. P10, E10.")
  diskTier?: string;
}

@doc("The SAP request to get list of availability zones.")
model SAPAvailabilityZoneDetailsRequest {
  @doc("The geo-location where the SAP resources will be created.")
  appLocation: string;

  @doc("Defines the SAP Product type.")
  sapProduct: SAPProductType;

  @doc("The database type. Eg: HANA, DB2, etc")
  databaseType: SAPDatabaseType;
}

@doc("The list of supported availability zone pairs which are part of SAP HA deployment.")
model SAPAvailabilityZoneDetailsResult {
  @doc("Gets the list of availability zone pairs.")
  availabilityZonePairs?: SAPAvailabilityZonePair[];
}

@doc("The SAP Availability Zone Pair.")
model SAPAvailabilityZonePair {
  @doc("The zone A.")
  zoneA?: int64;

  @doc("The zone B.")
  zoneB?: int64;
}

@doc("Managed service identity (user assigned identities)")
model UserAssignedServiceIdentity {
  @doc("Type of manage identity")
  type: ManagedServiceIdentityType;

  @doc("User assigned identities dictionary")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("Defines the Virtual Instance for SAP solutions resource properties.")
model SAPVirtualInstanceProperties {
  @doc("Defines the environment type - Production/Non Production.")
  @visibility("read", "create")
  environment: SAPEnvironmentType;

  @doc("Defines the SAP Product type.")
  @visibility("read", "create")
  sapProduct: SAPProductType;

  @doc("Specifies the network access configuration for the resources that will be deployed in the Managed Resource Group. The options to choose from are Public and Private. If 'Private' is chosen, the Storage Account service tag should be enabled on the subnets in which the SAP VMs exist. This is required for establishing connectivity between VM extensions and the managed resource group storage account. This setting is currently applicable only to Storage Account. Learn more here https://go.microsoft.com/fwlink/?linkid=2247228")
  managedResourcesNetworkAccessType?: ManagedResourcesNetworkAccessType;

  @doc("Defines if the SAP system is being created using Azure Center for SAP solutions (ACSS) or if an existing SAP system is being registered with ACSS")
  configuration: SAPConfiguration;

  @doc("Managed resource group configuration")
  managedResourceGroupConfiguration?: ManagedRGConfiguration;

  @doc("Defines the SAP Instance status.")
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  @doc("Defines the health of SAP Instances.")
  @visibility("read")
  health?: SAPHealthState;

  @doc("Defines the Virtual Instance for SAP state.")
  @visibility("read")
  state?: SAPVirtualInstanceState;

  @doc("Defines the provisioning states.")
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  @doc("Indicates any errors on the Virtual Instance for SAP solutions resource.")
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

@doc("The SAP Configuration.")
@discriminator("configurationType")
model SAPConfiguration {}

@doc("Managed resource group configuration")
model ManagedRGConfiguration {
  @doc("Managed resource group name")
  name?: string;
}

@doc("An error response from the Virtual Instance for SAP Workload service.")
model SAPVirtualInstanceError {
  @doc("The Virtual Instance for SAP error body.")
  properties?: ErrorDefinition;
}

@doc("Error definition.")
model ErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("Internal error details.")
  @visibility("read")
  details?: ErrorDefinition[];
}

@doc("Defines the request body for updating Virtual Instance for SAP.")
model UpdateSAPVirtualInstanceRequest {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;

  @doc("Managed service identity (user assigned identities)")
  identity?: UserAssignedServiceIdentity;

  @doc("Defines the properties to be updated for Virtual Instance for SAP.")
  properties?: UpdateSAPVirtualInstanceProperties;
}

@doc("Defines the properties to be updated for Virtual Instance for SAP.")
model UpdateSAPVirtualInstanceProperties {
  @doc("Specifies the network access configuration for the resources that will be deployed in the Managed Resource Group. The options to choose from are Public and Private. If 'Private' is chosen, the Storage Account service tag should be enabled on the subnets in which the SAP VMs exist. This is required for establishing connectivity between VM extensions and the managed resource group storage account. This setting is currently applicable only to Storage Account. Learn more here https://go.microsoft.com/fwlink/?linkid=2247228")
  managedResourcesNetworkAccessType?: ManagedResourcesNetworkAccessType;
}

@doc("Defines the SAP Central Services Instance properties.")
model SAPCentralServerProperties {
  @doc("The central services instance number.")
  @visibility("read")
  instanceNo?: string;

  @doc("The central services instance subnet.")
  @visibility("read")
  subnet?: string;

  @doc("Defines the SAP message server properties.")
  messageServerProperties?: MessageServerProperties;

  @doc("Defines the SAP Enqueue Server properties.")
  enqueueServerProperties?: EnqueueServerProperties;

  @doc("Defines the SAP Gateway Server properties.")
  gatewayServerProperties?: GatewayServerProperties;

  @doc("Defines the SAP Enqueue Replication Server (ERS) properties.")
  enqueueReplicationServerProperties?: EnqueueReplicationServerProperties;

  @doc("The central services instance Kernel Version.")
  @visibility("read")
  kernelVersion?: string;

  @doc("The central services instance Kernel Patch level.")
  @visibility("read")
  kernelPatch?: string;

  @doc("The Load Balancer details such as LoadBalancer ID attached to ASCS Virtual Machines")
  @visibility("read")
  loadBalancerDetails?: LoadBalancerDetails;

  @doc("The list of virtual machines corresponding to the Central Services instance.")
  @visibility("read")
  vmDetails?: CentralServerVmDetails[];

  @doc("Defines the SAP Instance status.")
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  @doc("Defines the health of SAP Instances.")
  @visibility("read")
  health?: SAPHealthState;

  @doc("Defines the provisioning states.")
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  @doc("Defines the errors related to SAP Central Services Instance resource.")
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

@doc("Defines the SAP message server properties.")
model MessageServerProperties {
  @doc("message server port.")
  @visibility("read")
  msPort?: int64;

  @doc("message server internal MS port.")
  @visibility("read")
  internalMsPort?: int64;

  @doc("message server HTTP Port.")
  @visibility("read")
  httpPort?: int64;

  @doc("message server HTTPS Port.")
  @visibility("read")
  httpsPort?: int64;

  @doc("message server SAP Hostname.")
  @visibility("read")
  hostname?: string;

  @doc("message server IP Address.")
  @visibility("read")
  ipAddress?: string;

  @doc("Defines the health of SAP Instances.")
  @visibility("read")
  health?: SAPHealthState;
}

@doc("Defines the SAP Enqueue Server properties.")
model EnqueueServerProperties {
  @doc("Enqueue Server SAP Hostname.")
  @visibility("read")
  hostname?: string;

  @doc("Enqueue Server SAP IP Address.")
  @visibility("read")
  ipAddress?: string;

  @doc("Enqueue Server Port.")
  @visibility("read")
  port?: int64;

  @doc("Defines the health of SAP Instances.")
  @visibility("read")
  health?: SAPHealthState;
}

@doc("Defines the SAP Gateway Server properties.")
model GatewayServerProperties {
  @doc("Gateway Port.")
  @visibility("read")
  port?: int64;

  @doc("Defines the health of SAP Instances.")
  @visibility("read")
  health?: SAPHealthState;
}

@doc("Defines the SAP Enqueue Replication Server (ERS) properties.")
model EnqueueReplicationServerProperties {
  @doc("Defines the type of Enqueue Replication Server.")
  @visibility("read")
  ersVersion?: EnqueueReplicationServerType;

  @doc("ERS Instance Number.")
  @visibility("read")
  instanceNo?: string;

  @doc("ERS SAP Hostname.")
  @visibility("read")
  hostname?: string;

  @doc("ERS SAP Kernel Version.")
  @visibility("read")
  kernelVersion?: string;

  @doc("ERS SAP Kernel Patch level.")
  @visibility("read")
  kernelPatch?: string;

  @doc("ERS SAP IP Address.")
  @visibility("read")
  ipAddress?: string;

  @doc("Defines the health of SAP Instances.")
  @visibility("read")
  health?: SAPHealthState;
}

@doc("The Load Balancer details such as Load Balancer ID.")
model LoadBalancerDetails {
  @visibility("read")
  id?: string;
}

@doc("The SAP Central Services Instance VM details.")
model CentralServerVmDetails {
  @doc("Defines the type of central server VM.")
  @visibility("read")
  type?: CentralServerVirtualMachineType;

  @visibility("read")
  virtualMachineId?: string;

  @doc("Storage details of all the Storage Accounts attached to the ASCS Virtual Machine. For e.g. NFS on AFS Shared Storage.")
  @visibility("read")
  storageDetails?: StorageInformation[];
}

@doc("Storage details of all the Storage accounts attached to the VM. For e.g. NFS on AFS Shared Storage. ")
model StorageInformation {
  @visibility("read")
  id?: string;
}

@doc("Defines the request body for updating SAP Central Instance.")
model UpdateSAPCentralInstanceRequest {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;
}

@doc("Defines the Database properties.")
model SAPDatabaseProperties {
  @doc("Database subnet.")
  @visibility("read")
  subnet?: string;

  @doc("Database SID name.")
  @visibility("read")
  databaseSid?: string;

  @doc("Database type, that is if the DB is HANA, DB2, Oracle, SAP ASE, Max DB or MS SQL Server.")
  @visibility("read")
  databaseType?: string;

  @doc("Database IP Address.")
  @visibility("read")
  ipAddress?: string;

  @doc("The Load Balancer details such as LoadBalancer ID attached to Database Virtual Machines")
  @visibility("read")
  loadBalancerDetails?: LoadBalancerDetails;

  @doc("The list of virtual machines corresponding to the Database resource.")
  @visibility("read")
  vmDetails?: DatabaseVmDetails[];

  @doc("Defines the SAP Instance status.")
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  @doc("Defines the provisioning states.")
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  @doc("Defines the errors related to Database resource.")
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

@doc("Database VM details.")
model DatabaseVmDetails {
  @visibility("read")
  virtualMachineId?: string;

  @doc("Defines the SAP Instance status.")
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  @doc("Storage details of all the Storage Accounts attached to the Database Virtual Machine. For e.g. NFS on AFS Shared Storage.")
  @visibility("read")
  storageDetails?: StorageInformation[];
}

@doc("Defines the request body for updating SAP Database Instance.")
model UpdateSAPDatabaseInstanceRequest {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;
}

@doc("Defines the SAP Application Server instance properties.")
model SAPApplicationServerProperties {
  @doc("Application server Instance Number.")
  @visibility("read")
  instanceNo?: string;

  @doc("Application server Subnet.")
  @visibility("read")
  subnet?: string;

  @doc("Application server instance SAP hostname.")
  @visibility("read")
  hostname?: string;

  @doc(" Application server instance SAP Kernel Version.")
  @visibility("read")
  kernelVersion?: string;

  @doc("Application server instance SAP Kernel Patch level.")
  @visibility("read")
  kernelPatch?: string;

  @doc(" Application server instance SAP IP Address.")
  @visibility("read")
  ipAddress?: string;

  @doc("Application server instance gateway Port.")
  @visibility("read")
  gatewayPort?: int64;

  @doc("Application server instance ICM HTTP Port.")
  @visibility("read")
  icmHttpPort?: int64;

  @doc("Application server instance ICM HTTPS Port.")
  @visibility("read")
  icmHttpsPort?: int64;

  @doc("Application server instance dispatcher status.")
  @visibility("read")
  dispatcherStatus?: string;

  @doc("The Load Balancer details such as LoadBalancer ID attached to Application Server Virtual Machines")
  @visibility("read")
  loadBalancerDetails?: LoadBalancerDetails;

  @doc("The list of virtual machines.")
  @visibility("read")
  vmDetails?: ApplicationServerVmDetails[];

  @doc("Defines the SAP Instance status.")
  @visibility("read")
  status?: SAPVirtualInstanceStatus;

  @doc("Defines the health of SAP Instances.")
  @visibility("read")
  health?: SAPHealthState;

  @doc("Defines the provisioning states.")
  @visibility("read")
  provisioningState?: SapVirtualInstanceProvisioningState;

  @doc("Defines the Application Instance errors.")
  @visibility("read")
  errors?: SAPVirtualInstanceError;
}

@doc("The Application Server VM Details.")
model ApplicationServerVmDetails {
  @doc("Defines the type of application server VM.")
  @visibility("read")
  type?: ApplicationServerVirtualMachineType;

  @visibility("read")
  virtualMachineId?: string;

  @doc("Storage details of all the Storage Accounts attached to the App Virtual Machine. For e.g. NFS on AFS Shared Storage.")
  @visibility("read")
  storageDetails?: StorageInformation[];
}

@doc("Defines the request body for updating SAP Application Instance.")
model UpdateSAPApplicationInstanceRequest {
  @doc("Gets or sets the Resource tags.")
  tags?: Record<string>;
}

@doc("Start SAP instance(s) request body.")
model StartRequest {
  @doc("The boolean value indicates whether to start the virtual machines before starting the SAP instances.")
  startVm?: boolean;
}

@doc("Stop SAP instance(s) request body.")
model StopRequest {
  @doc("This parameter defines how long (in seconds) the soft shutdown waits until the RFC/HTTP clients no longer consider the server for calls with load balancing. Value 0 means that the kernel does not wait, but goes directly into the next shutdown state, i.e. hard stop.")
  softStopTimeoutSeconds?: int64;

  @doc("The boolean value indicates whether to Stop and deallocate the virtual machines along with the SAP instances.")
  deallocateVm?: boolean;
}

@doc("Specifies information about the image to use. You can specify information about platform images, marketplace images, or virtual machine images. This element is required when you want to use a platform image, marketplace image, or virtual machine image, but is not used in other creation operations. NOTE: Image reference publisher and offer can only be set when you create the scale set.")
model ImageReference {
  @doc("The image publisher.")
  publisher?: string;

  @doc("Specifies the offer of the platform image or marketplace image used to create the virtual machine.")
  offer?: string;

  @doc("The image SKU.")
  sku?: string;

  @doc("Specifies the version of the platform image or marketplace image used to create the virtual machine. The allowed formats are Major.Minor.Build or 'latest'. Major, Minor, and Build are decimal numbers. Specify 'latest' to use the latest version of an image available at deploy time. Even if you use 'latest', the VM image will not automatically update after deploy time even if a new version becomes available.")
  version?: string;

  @doc("Specifies the ARM resource ID of the Azure Compute Gallery image version used for creating ACSS VMs. You will need to provide this input when you choose to deploy virtual machines in ACSS with OS image from the Azure Compute gallery.")
  id?: ResourceIdentifier;
}

@doc("Specifies Windows operating system settings on the virtual machine.")
model WindowsConfiguration extends OSConfiguration {
  @doc("The OS Type")
  osType: "Windows";
}

@doc("Defines the OS configuration.")
@discriminator("osType")
model OSConfiguration {}

@doc("Contains information about SSH certificate public key and the path on the Linux VM where the public key is placed.")
model SshPublicKey {
  @doc("SSH public key certificate used to authenticate with the VM through ssh. The key needs to be at least 2048-bit and in ssh-rsa format. <br><br> For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).")
  keyData?: string;
}

@doc("SSH configuration for Linux based VMs running on Azure")
model SshConfiguration {
  @doc("The list of SSH public keys used to authenticate with linux based VMs.")
  publicKeys?: SshPublicKey[];
}

@doc("Specifies the Linux operating system settings on the virtual machine. <br><br>For a list of supported Linux distributions, see [Linux on Azure-Endorsed Distributions](https://docs.microsoft.com/azure/virtual-machines/linux/endorsed-distros).")
model LinuxConfiguration extends OSConfiguration {
  @doc("Specifies whether password authentication should be disabled.")
  disablePasswordAuthentication?: boolean;

  @doc("Specifies the ssh key configuration for a Linux OS. (This property is deprecated, please use 'sshKeyPair' instead)")
  ssh?: SshConfiguration;

  @doc("The SSH Key-pair used to authenticate with the VM's.")
  sshKeyPair?: SshKeyPair;

  @doc("The OS Type")
  osType: "Linux";
}

@doc("The SSH Key-pair used to authenticate with the VM. The key needs to be at least 2048-bit and in ssh-rsa format. <br><br> For creating ssh keys, see [Create SSH keys on Linux and Mac for Linux VMs in Azure](https://docs.microsoft.com/azure/virtual-machines/linux/create-ssh-keys-detailed).")
model SshKeyPair {
  @doc("SSH public key")
  publicKey?: string;

  @doc("SSH private key.")
  @secret
  privateKey?: string;
}

@doc("Specifies the operating system settings for the virtual machine. Some of the settings cannot be changed once VM is provisioned.")
model OSProfile {
  @doc("Specifies the name of the administrator account. <br><br> This property cannot be updated after the VM is created. <br><br> **Windows-only restriction:** Cannot end in \".\" <br><br> **Disallowed values:** \"administrator\", \"admin\", \"user\", \"user1\", \"test\", \"user2\", \"test1\", \"user3\", \"admin1\", \"1\", \"123\", \"a\", \"actuser\", \"adm\", \"admin2\", \"aspnet\", \"backup\", \"console\", \"david\", \"guest\", \"john\", \"owner\", \"root\", \"server\", \"sql\", \"support\", \"support_388945a0\", \"sys\", \"test2\", \"test3\", \"user4\", \"user5\". <br><br> **Minimum-length (Linux):** 1  character <br><br> **Max-length (Linux):** 64 characters <br><br> **Max-length (Windows):** 20 characters.")
  @secret
  adminUsername?: string;

  @doc("Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\\W_]) <br><br> **Disallowed values:** \"abc@123\", \"P@$$w0rd\", \"P@ssw0rd\", \"P@ssword123\", \"Pa$$word\", \"pass@word1\", \"Password!\", \"Password1\", \"Password22\", \"iloveyou!\" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)")
  adminPassword?: string;

  @doc("Specifies Windows operating system settings on the virtual machine.")
  osConfiguration?: OSConfiguration;
}

@doc("The recommended configuration for a single server SAP system.")
model SingleServerRecommendationResult extends SAPSizingRecommendationResult {
  @doc("The recommended VM SKU for single server.")
  vmSku?: string;

  @doc("The type of SAP deployment, single server or Three tier.")
  deploymentType: "SingleServer";
}

@doc("The recommended configuration for a three tier SAP system.")
model ThreeTierRecommendationResult extends SAPSizingRecommendationResult {
  @doc("The database VM SKU.")
  dbVmSku?: string;

  @doc("The database server instance count.")
  databaseInstanceCount?: int64;

  @doc("The central server VM SKU.")
  centralServerVmSku?: string;

  @doc("The central server instance count.")
  centralServerInstanceCount?: int64;

  @doc("The application server VM SKU.")
  applicationServerVmSku?: string;

  @doc("The application server instance count.")
  applicationServerInstanceCount?: int64;

  @doc("The type of SAP deployment, single server or Three tier.")
  deploymentType: "ThreeTier";
}

@doc("The Disk Configuration Details.")
model DiskConfiguration {
  @doc("The disk configuration for the db volume. For HANA, Required volumes are: ['hana/data', 'hana/log', hana/shared', 'usr/sap', 'os'], Optional volume : ['backup'].")
  diskVolumeConfigurations?: Record<DiskVolumeConfiguration>;
}

@doc("Defines the virtual machine configuration.")
model VirtualMachineConfiguration {
  @doc("The virtual machine size.")
  vmSize: string;

  @doc("The image reference.")
  imageReference: ImageReference;

  @doc("The OS profile.")
  osProfile: OSProfile;
}

@doc("Gets or sets the single server configuration. For prerequisites for creating the infrastructure, please see [here](https://go.microsoft.com/fwlink/?linkid=2212611&clcid=0x409)")
model SingleServerConfiguration extends InfrastructureConfiguration {
  @doc("Network configuration for the server")
  networkConfiguration?: NetworkConfiguration;

  @doc("The database type.")
  databaseType?: SAPDatabaseType;

  @doc("The subnet id.")
  subnetId: string;

  @doc("Gets or sets the virtual machine configuration.")
  virtualMachineConfiguration: VirtualMachineConfiguration;

  @doc("Gets or sets the disk configuration.")
  dbDiskConfiguration?: DiskConfiguration;

  @doc("The set of custom names to be used for underlying azure resources that are part of the SAP system.")
  customResourceNames?: SingleServerCustomResourceNames;

  @doc("The type of SAP deployment, single server or Three tier.")
  deploymentType: "SingleServer";
}

@doc("Defines the network configuration type for SAP system infrastructure that is being deployed ")
model NetworkConfiguration {
  @doc("Specifies whether a secondary IP address should be added to the network interface on all VMs of the SAP system being deployed")
  isSecondaryIpEnabled?: boolean;
}

@doc("The resource-names input to specify custom names for underlying azure resources that are part of a single server SAP system.")
@discriminator("namingPatternType")
model SingleServerCustomResourceNames {}

@doc("Deploy SAP Infrastructure Details.")
@discriminator("deploymentType")
model InfrastructureConfiguration {
  @doc("The application resource group where SAP system resources will be deployed.")
  appResourceGroup: string;
}

@doc("Gets or sets the central server configuration.")
model CentralServerConfiguration {
  @doc("The subnet id.")
  subnetId: string;

  @doc("Gets or sets the virtual machine configuration.")
  virtualMachineConfiguration: VirtualMachineConfiguration;

  @doc("The number of central server VMs.")
  instanceCount: int64;
}

@doc("Gets or sets the database configuration.")
model DatabaseConfiguration {
  @doc("The database type.")
  databaseType?: SAPDatabaseType;

  @doc("The subnet id.")
  subnetId: string;

  @doc("Gets or sets the virtual machine configuration.")
  virtualMachineConfiguration: VirtualMachineConfiguration;

  @doc("The number of database VMs.")
  instanceCount: int64;

  @doc("Gets or sets the disk configuration.")
  diskConfiguration?: DiskConfiguration;
}

@doc("Gets or sets the application server configuration.")
model ApplicationServerConfiguration {
  @doc("The subnet id.")
  subnetId: string;

  @doc("Gets or sets the virtual machine configuration.")
  virtualMachineConfiguration: VirtualMachineConfiguration;

  @doc("The number of app server instances.")
  instanceCount: int64;
}

@doc("Gets or sets the high availability configuration.")
model HighAvailabilityConfiguration {
  @doc("The high availability type.")
  highAvailabilityType: SAPHighAvailabilityType;
}

@doc("Gets or sets the file share configuration for scenarios where transport directory fileshare is not created or required.")
model SkipFileShareConfiguration extends FileShareConfiguration {
  @doc("The type of file share config.")
  configurationType: "Skip";
}

@doc("File Share configuration details, populated with information on storage configuration mounted on the VIS. The createAndMount option is selected in case of missing input.")
@discriminator("configurationType")
model FileShareConfiguration {}

@doc("Gets or sets the file share configuration where the transport directory fileshare is created and mounted as a part of the create infra flow. Please pre-create the resource group you intend to place the transport directory in. The storage account and fileshare will be auto-created by the ACSS and doesn't need to be pre-created.")
model CreateAndMountFileShareConfiguration extends FileShareConfiguration {
  @doc("The name of transport file share resource group. This should be pre created by the customer. The app rg is used in case of missing input.")
  resourceGroup?: string;

  @doc("The name of file share storage account name . A custom name is used in case of missing input.")
  storageAccountName?: string;

  @doc("The type of file share config.")
  configurationType: "CreateAndMount";
}

@doc("Gets or sets the file share configuration where the transport directory fileshare already exists, and user wishes to mount the fileshare as a part of the create infra flow.")
model MountFileShareConfiguration extends FileShareConfiguration {
  @doc("The fileshare resource ID")
  id: string;

  @doc("The private endpoint resource ID")
  privateEndpointId: string;

  @doc("The type of file share config.")
  configurationType: "Mount";
}

@doc("Gets or sets the storage configuration.")
model StorageConfiguration {
  @doc("The properties of the transport directory attached to the VIS. The default for transportFileShareConfiguration is the createAndMount flow if storage configuration is missing.")
  transportFileShareConfiguration?: FileShareConfiguration;
}

@doc("Gets or sets the three tier SAP configuration. For prerequisites for creating the infrastructure, please see [here](https://go.microsoft.com/fwlink/?linkid=2212611&clcid=0x409)")
model ThreeTierConfiguration extends InfrastructureConfiguration {
  @doc("Network configuration common to all servers")
  networkConfiguration?: NetworkConfiguration;

  @doc("The central server configuration.")
  centralServer: CentralServerConfiguration;

  @doc("The application server configuration.")
  applicationServer: ApplicationServerConfiguration;

  @doc("The database configuration.")
  databaseServer: DatabaseConfiguration;

  @doc("The high availability configuration.")
  highAvailabilityConfig?: HighAvailabilityConfiguration;

  @doc("The storage configuration.")
  storageConfiguration?: StorageConfiguration;

  @doc("The set of custom names to be used for underlying azure resources that are part of the SAP system.")
  customResourceNames?: ThreeTierCustomResourceNames;

  @doc("The type of SAP deployment, single server or Three tier.")
  deploymentType: "ThreeTier";
}

@doc("The resource-names input to specify custom names for underlying azure resources that are part of a three tier SAP system.")
@discriminator("namingPatternType")
model ThreeTierCustomResourceNames {}

@doc("The resource name object where the specified values will be full resource names of the corresponding resources in a single server SAP system.")
model SingleServerFullResourceNames extends SingleServerCustomResourceNames {
  @doc("The resource names object for virtual machine and related resources.")
  virtualMachine?: VirtualMachineResourceNames;

  @doc("The pattern type to be used for resource naming.")
  namingPatternType: "FullResourceName";
}

@doc("The resource names object for virtual machine and related resources.")
model VirtualMachineResourceNames {
  @doc("The full name for virtual machine. The length of this field can be upto 64 characters. If name is not provided, service uses a default name based on the deployment type. For SingleServer, default name is {SID}vm. In case of HA-AvZone systems, default name will be {SID}{app/ascs/db}z{a/b}vm with an incrementor at the end in case of more than 1 vm per layer. For distributed and HA-AvSet systems, default name will be {SID}{app/ascs/db}vm with an incrementor at the end in case of more than 1 vm per layer.")
  vmName?: string;

  @doc("The full name for virtual-machine's host (computer name). Currently, ACSS only supports host names which are less than or equal to 13 characters long. If this value is not provided, vmName will be used as host name.")
  hostName?: string;

  @doc("The list of network interface name objects for the selected virtual machine. Currently, only one network interface is supported per virtual machine.")
  @maxItems(1)
  networkInterfaces?: NetworkInterfaceResourceNames[];

  @doc("The full name for OS disk attached to the VM. If this value is not provided, it will be named by ARM as per its default naming standards (prefixed with vm name). There is only one OS disk attached per Virtual Machine.")
  osDiskName?: string;

  @doc("The full resource names for virtual machine data disks. This is a dictionary containing list of names of data disks per volume. Currently supported volumes for database layer are ['hana/data', 'hana/log', hana/shared', 'usr/sap', 'os', 'backup']. For application and cs layers, only 'default' volume is supported")
  dataDiskNames?: Record<string[]>;
}

@doc("The resource names object for network interface and related resources.")
model NetworkInterfaceResourceNames {
  @doc("The full name for network interface. If name is not provided, service uses a default name based on the deployment type. For SingleServer, default name is {SID}-Nic. In case of HA-AvZone systems, default name will be {SID}-{App/ASCS/DB}-Zone{A/B}-Nic with an incrementor at the end in case of more than 1 instance per layer. For distributed and HA-AvSet systems, default name will be {SID}-{App/ASCS/DB}-Nic with an incrementor at the end in case of more than 1 instance per layer.")
  networkInterfaceName?: string;
}

@doc("The resource name object where the specified values will be full resource names of the corresponding resources in a three tier SAP system.")
model ThreeTierFullResourceNames extends ThreeTierCustomResourceNames {
  @doc("The full resource names object for central server layer resources.")
  centralServer?: CentralServerFullResourceNames;

  @doc("The full resource names object for application layer resources. The number of entries in this list should be equal to the number VMs to be created for application layer.")
  applicationServer?: ApplicationServerFullResourceNames;

  @doc("The full resource names object for database layer resources. The number of entries in this list should be equal to the number VMs to be created for database layer.")
  databaseServer?: DatabaseServerFullResourceNames;

  @doc("The resource names object for shared storage.")
  sharedStorage?: SharedStorageResourceNames;

  @doc("The pattern type to be used for resource naming.")
  namingPatternType: "FullResourceName";
}

@doc("The full resource names object for central server layer resources.")
model CentralServerFullResourceNames {
  @doc("The list of names for all ASCS virtual machines to be deployed. The number of entries in this list should be equal to the number VMs to be created for ASCS layer. At maximum, there can be two virtual machines at this layer: ASCS and ERS.")
  @maxItems(2)
  virtualMachines?: VirtualMachineResourceNames[];

  @doc("The full name for availability set. In case name is not provided, it will be defaulted to {SID}-ASCS-AvSet.")
  availabilitySetName?: string;

  @doc("The resource names object for load balancer and related resources.")
  loadBalancer?: LoadBalancerResourceNames;
}

@doc("The resource names object for load balancer and related resources.")
model LoadBalancerResourceNames {
  @doc("The full resource name for load balancer. If this value is not provided, load balancer will be name as {ASCS/DB}-loadBalancer.")
  loadBalancerName?: string;

  @doc("The list of frontend IP configuration names. If provided as input, size of this list should be 2 for cs layer and should be 1 for database layer.")
  @maxItems(2)
  frontendIpConfigurationNames?: string[];

  @doc("The list of backend pool names. Currently, ACSS deploys only one backend pool and hence, size of this list should be 1")
  @maxItems(1)
  backendPoolNames?: string[];

  @doc("The list of health probe names. If provided as input, size of this list should be 2 for cs layer and should be 1 for database layer.")
  @maxItems(2)
  healthProbeNames?: string[];
}

@doc("The full resource names object for application layer resources. The number of entries in this list should be equal to the number VMs to be created for application layer.")
model ApplicationServerFullResourceNames {
  @doc("The list of virtual machine naming details.")
  virtualMachines?: VirtualMachineResourceNames[];

  @doc("The full name for availability set. In case name is not provided, it will be defaulted to {SID}-App-AvSet.")
  availabilitySetName?: string;
}

@doc("The full resource names object for database layer resources. The number of entries in this list should be equal to the number VMs to be created for database layer.")
model DatabaseServerFullResourceNames {
  @doc("The list of virtual machine naming details.")
  @maxItems(2)
  virtualMachines?: VirtualMachineResourceNames[];

  @doc("The full name for availability set. In case name is not provided, it will be defaulted to {SID}-DB-AvSet.")
  availabilitySetName?: string;

  @doc("The resource names object for load balancer and related resources.")
  loadBalancer?: LoadBalancerResourceNames;
}

@doc("The resource names object for shared storage.")
model SharedStorageResourceNames {
  @doc("The full name of the shared storage account. If it is not provided, it will be defaulted to {SID}nfs{guid of 15 chars}.")
  sharedStorageAccountName?: string;

  @doc("The full name of private end point for the shared storage account. If it is not provided, it will be defaulted to {storageAccountName}_pe")
  sharedStorageAccountPrivateEndPointName?: string;
}

@doc("The SAP Software configuration Input.")
@discriminator("softwareInstallationType")
model SoftwareConfiguration {}

@doc("The SAP Software configuration Input when the software is to be installed by service.")
model ServiceInitiatedSoftwareConfiguration extends SoftwareConfiguration {
  @doc("The URL to the SAP Build of Materials(BOM) file.")
  bomUrl: string;

  @doc("The software version to install.")
  softwareVersion: string;

  @doc("The SAP bits storage account id.")
  sapBitsStorageAccountId: string;

  @doc("The FQDN to set for the SAP system during install.")
  sapFqdn: string;

  @doc("The SSH private key.")
  @secret
  sshPrivateKey: string;

  @doc("Gets or sets the HA software configuration.")
  highAvailabilitySoftwareConfiguration?: HighAvailabilitySoftwareConfiguration;

  @doc("The SAP software installation Type.")
  softwareInstallationType: "ServiceInitiated";
}

@doc("Gets or sets the HA software configuration.")
model HighAvailabilitySoftwareConfiguration {
  @doc("The fencing client id.")
  fencingClientId: string;

  @doc("The fencing client id secret/password. The secret should never expire. This will be used pacemaker to start/stop the cluster VMs.")
  @secret
  fencingClientPassword: string;
}

@doc("The SAP Software configuration Input when the software is to be installed by service without OS Configurations")
model SAPInstallWithoutOSConfigSoftwareConfiguration
  extends SoftwareConfiguration {
  @doc("The URL to the SAP Build of Materials(BOM) file.")
  bomUrl: string;

  @doc("The SAP bits storage account id.")
  sapBitsStorageAccountId: string;

  @doc("The software version to install.")
  softwareVersion: string;

  @doc("Gets or sets the HA software configuration.")
  highAvailabilitySoftwareConfiguration?: HighAvailabilitySoftwareConfiguration;

  @doc("The SAP software installation Type.")
  softwareInstallationType: "SAPInstallWithoutOSConfig";
}

@doc("The SAP Software configuration Input when the software is installed externally outside the service.")
model ExternalInstallationSoftwareConfiguration extends SoftwareConfiguration {
  @doc("The resource ID of the virtual machine containing the central server instance.")
  centralServerVmId?: string;

  @doc("The SAP software installation Type.")
  softwareInstallationType: "External";
}

@doc("Discovery Details.")
model DiscoveryConfiguration extends SAPConfiguration {
  @doc("The virtual machine ID of the Central Server.")
  centralServerVmId?: string;

  @doc("The custom storage account name for the storage account created by the service in the managed resource group created as part of VIS deployment.<br><br>Refer to the storage account naming rules [here](https://learn.microsoft.com/azure/azure-resource-manager/management/resource-name-rules#microsoftstorage).<br><br>If not provided, the service will create the storage account with a random name.")
  @maxLength(24)
  @minLength(3)
  managedRgStorageAccountName?: string;

  @doc("The geo-location where the SAP system exists.")
  @visibility("read")
  appLocation?: string;

  @doc("The configuration Type.")
  configurationType: "Discovery";
}

@doc("Deployment Configuration.")
model DeploymentConfiguration extends SAPConfiguration {
  @doc("The geo-location where the SAP system is to be created.")
  appLocation?: string;

  @doc("The infrastructure configuration.")
  infrastructureConfiguration?: InfrastructureConfiguration;

  @doc("The software configuration.")
  softwareConfiguration?: SoftwareConfiguration;

  @doc("The configuration Type.")
  configurationType: "Deployment";
}

@doc("Deployment along with OS Configuration.")
model DeploymentWithOSConfiguration extends SAPConfiguration {
  @doc("The geo-location where the SAP system is to be created.")
  appLocation?: string;

  @doc("The infrastructure configuration.")
  infrastructureConfiguration?: InfrastructureConfiguration;

  @doc("The software configuration.")
  softwareConfiguration?: SoftwareConfiguration;

  @doc("The OS and SAP configuration.")
  osSapConfiguration?: OsSapConfiguration;

  @doc("The configuration Type.")
  configurationType: "DeploymentWithOSConfig";
}

@doc("Defines the OS and SAP Configurations for Deployment")
model OsSapConfiguration {
  @doc("The url and storage account ID where deployer VM packages are uploaded")
  deployerVmPackages?: DeployerVmPackages;

  @doc("The FQDN to set for the SAP system")
  sapFqdn?: string;
}

@doc("Defines the url and storage account ID where deployer VM packages are uploaded")
model DeployerVmPackages {
  @doc("The URL to the deployer VM packages file.")
  url?: string;

  @doc("The deployer VM packages storage account id")
  storageAccountId?: string;
}
