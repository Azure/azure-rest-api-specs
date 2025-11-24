import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureStackHCI;
/**
 * Edge device resource
 */
@parentResource(Cluster)
model DeploymentSetting
  is Azure.ResourceManager.ProxyResource<DeploymentSettingsProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentSetting,
    KeyName = "deploymentSettingsName",
    SegmentName = "deploymentSettings"
  >;
}

@armResourceOperations
interface DeploymentSettings {
  /**
   * Get a DeploymentSetting
   */
  get is ArmResourceRead<DeploymentSetting>;

  /**
   * Create a DeploymentSetting
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentSetting>;

  /**
   * Delete a DeploymentSetting
   */
  delete is ArmResourceDeleteWithoutOkAsync<DeploymentSetting>;

  /**
   * List DeploymentSetting resources by Clusters
   */
  listByClusters is ArmResourceListByParent<DeploymentSetting>;
}

@@doc(DeploymentSetting.name, "Name of Deployment Setting");
@@doc(DeploymentSetting.properties,
  "The resource-specific properties for this resource."
);

// Models

/**
 * DeploymentSetting properties
 */
model DeploymentSettingsProperties {
  /**
   * DeploymentSetting provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Azure resource ids of Arc machines to be part of cluster.
   */
  arcNodeResourceIds: string[];

  /**
   * The deployment mode for cluster deployment.
   */
  deploymentMode: DeploymentMode;

  /**
   * The intended operation for a cluster.
   */
  operationType?: OperationType = OperationType.ClusterProvisioning;

  /**
   * Scale units will contains list of deployment data
   */
  deploymentConfiguration: DeploymentConfiguration;

  /**
   * Deployment Status reported from cluster.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: EceReportedProperties;
}

/**
 * Deployment Configuration
 */
model DeploymentConfiguration {
  /**
   * deployment template version
   */
  version?: string;

  /**
   * Scale units will contains list of deployment data
   */
  @identifiers(#[])
  scaleUnits: ScaleUnits[];
}

/**
 * Scale units will contains list of deployment data
 */
model ScaleUnits {
  /**
   * Deployment Data to deploy AzureStackHCI Cluster.
   */
  deploymentData: DeploymentData;

  /**
   * Solution builder extension (SBE) partner properties
   */
  sbePartnerInfo?: SbePartnerInfo;
}

/**
 * The Deployment data of AzureStackHCI Cluster.
 */
model DeploymentData {
  /**
   * SecuritySettings to deploy AzureStackHCI Cluster.
   */
  securitySettings?: DeploymentSecuritySettings;

  /**
   * Observability config to deploy AzureStackHCI Cluster.
   */
  observability?: Observability;

  /**
   * Observability config to deploy AzureStackHCI Cluster.
   */
  cluster?: DeploymentCluster;

  /**
   * Identity Provider for the cluster
   */
  identityProvider?: IdentityProvider;

  /**
   * Storage config to deploy AzureStackHCI Cluster.
   */
  storage?: Storage;

  /**
   * naming prefix to deploy cluster.
   */
  @pattern("^[a-zA-Z0-9-]{1,8}$")
  namingPrefix?: string;

  /**
   * FQDN to deploy cluster
   */
  domainFqdn?: string;

  /**
   * InfrastructureNetwork config to deploy AzureStackHCI Cluster.
   */
  @identifiers(#[])
  infrastructureNetwork?: InfrastructureNetwork[];

  /**
   * list of physical nodes config to deploy AzureStackHCI Cluster.
   */
  @identifiers(#["name"])
  physicalNodes?: PhysicalNodes[];

  /**
   * HostNetwork config to deploy AzureStackHCI Cluster.
   */
  hostNetwork?: DeploymentHostNetwork;

  /**
   * Cloud Environment of the cluster. (e.g. AzurePublic, ALDO )
   */
  cloudEnvironment?: string;

  /**
   * Is Management Cluster, when true indicates that the cluster is used for managing other clusters
   */
  isManagementCluster?: boolean;

  /**
   * SDN Integration config to deploy AzureStackHCI Cluster.
   */
  sdnIntegration?: SdnIntegration;

  /**
   * The path to the Active Directory Organizational Unit container object prepared for the deployment.
   */
  adouPath?: string;

  /**
   * Azure keyvault endpoint. This property is deprecated from 2023-12-01-preview. Please use secrets property instead.
   */
  secretsLocation?: string;

  /**
   * secrets used for cloud deployment.
   */
  @identifiers(#["secretName"])
  secrets?: EceDeploymentSecrets[];

  /**
   * OptionalServices config to deploy AzureStackHCI Cluster.
   */
  optionalServices?: OptionalServices;

  /**
   * Local Availability Zone information for HCI cluster
   */
  @identifiers(#["localAvailabilityZoneName"])
  localAvailabilityZones?: LocalAvailabilityZones[];

  /**
   * Assembly Package details for Validated Solution Recipe for AzureStackHCI Cluster
   */
  assemblyInfo?: AssemblyInfo;
}

/**
 * The SecuritySettings of AzureStackHCI Cluster.
 */
model DeploymentSecuritySettings {
  /**
   * By default, Hypervisor-protected Code Integrity is enabled on your Azure HCI cluster.
   */
  hvciProtection?: boolean = true;

  /**
   * By default, Secure Boot is enabled on your Azure HCI cluster. This setting is hardware dependent.
   */
  drtmProtection?: boolean = true;

  /**
   * When set to true, the security baseline is re-applied regularly.
   */
  driftControlEnforced?: boolean = true;

  /**
   * When set to true, Credential Guard is enabled.
   */
  credentialGuardEnforced?: boolean;

  /**
   * When set to true, the SMB default instance requires sign in for the client and server services.
   */
  smbSigningEnforced?: boolean = true;

  /**
   * When set to true, cluster east-west traffic is encrypted.
   */
  smbClusterEncryption?: boolean;

  /**
   * When set to true, all the side channel mitigations are enabled
   */
  sideChannelMitigationEnforced?: boolean = true;

  /**
   * When set to true, BitLocker XTS_AES 256-bit encryption is enabled for all data-at-rest on the OS volume of your Azure Stack HCI cluster. This setting is TPM-hardware dependent.
   */
  bitlockerBootVolume?: boolean = true;

  /**
   * When set to true, BitLocker XTS-AES 256-bit encryption is enabled for all data-at-rest on your Azure Stack HCI cluster shared volumes.
   */
  bitlockerDataVolumes?: boolean = true;

  /**
   * WDAC is enabled by default and limits the applications and the code that you can run on your Azure Stack HCI cluster.
   */
  wdacEnforced?: boolean = true;
}

/**
 * The Observability of AzureStackHCI Cluster.
 */
model Observability {
  /**
   * Enables telemetry data to be sent to Microsoft
   */
  streamingDataClient?: boolean = true;

  /**
   * Location of your cluster. The log and diagnostic data is sent to the appropriate diagnostics servers depending upon where your cluster resides. Setting this to false results in all data sent to Microsoft to be stored outside of the EU.
   */
  euLocation?: boolean;

  /**
   * When set to true, collects log data to facilitate quicker issue resolution.
   */
  episodicDataUpload?: boolean = true;
}

/**
 * AzureStackHCI Cluster deployment properties.
 */
model DeploymentCluster {
  /**
   * The cluster name provided when preparing Active Directory.
   */
  name?: string;

  /**
   * Use a cloud witness if you have internet access and if you use an Azure Storage account to provide a vote on cluster quorum. A cloud witness uses Azure Blob Storage to read or write a blob file and then uses it to arbitrate in split-brain resolution. Only allowed values are 'Cloud', 'FileShare'.
   */
  witnessType?: string;

  /**
   * Specify the fileshare path for the local witness for your Azure Stack HCI cluster.
   */
  witnessPath?: string;

  /**
   * The authentication mode for the cluster witness. An example value 'ManagedIdentity'.
   */
  witnessAuthenticationMode?: string;

  /**
   * Specify the Azure Storage account name for cloud witness for your Azure Stack HCI cluster.
   */
  cloudAccountName?: string;

  /**
   * For Azure blob service endpoint type, select either Default or Custom domain. If you selected **Custom domain, enter the domain for the blob service in this format core.windows.net.
   */
  azureServiceEndpoint?: string;

  /**
   * Hardware class of the cluster.
   */
  @visibility(Lifecycle.Read)
  hardwareClass?: HardwareClass = HardwareClass.Medium;

  /**
   * Cluster Pattern supported.
   */
  clusterPattern?: ClusterPattern;
}

/**
 * The Storage config of AzureStackHCI Cluster.
 */
model Storage {
  /**
   * By default, this mode is set to Express and your storage is configured as per best practices based on the number of nodes in the cluster. Allowed values are 'Express','InfraOnly', 'KeepStorage'
   */
  configurationMode?: string = "Express";
}

/**
 * The InfrastructureNetwork of a AzureStackHCI Cluster.
 */
model InfrastructureNetwork {
  /**
   * Subnet mask that matches the provided IP address space.
   */
  subnetMask?: string;

  /**
   * Default gateway that should be used for the provided IP address space.
   */
  gateway?: string;

  /**
   * Range of IP addresses from which addresses are allocated for nodes within a subnet.
   */
  @identifiers(#[])
  ipPools?: IpPools[];

  /**
   * Specifies how DNS servers are configured for the infrastructure network. Allowed values are 'UseDnsServer' to use the provided DNS servers, and 'UseForwarder' to use DNS forwarders.
   */
  dnsServerConfig?: DnsServerConfig = DnsServerConfig.UseDnsServer;

  /**
   * Details of the DNS Zones to be configured.
   */
  @identifiers(#["dnsZoneName"])
  dnsZones?: DnsZones[];

  /**
   * IPv4 address of the DNS servers in your environment.
   */
  dnsServers?: string[];

  /**
   * Allows customers to use DHCP for Hosts and Cluster IPs. If not declared, the deployment will default to static IPs. When true, GW and DNS servers are not required
   */
  useDhcp?: boolean;
}

/**
 * Details of the DNS Zones to be configured.
 */
model DnsZones {
  /**
   * Name of the DNS Zone to be configured.
   */
  dnsZoneName?: string;

  /**
   * Forwarder details of the DNS Zone to be configured.
   */
  dnsForwarder?: string[];
}

/**
 * The dnsServers of a device.
 */
model IpPools {
  /**
   * Starting IP address for the management network. A minimum of six free, contiguous IPv4 addresses (excluding your host IPs) are needed for infrastructure services such as clustering.
   */
  startingAddress?: string;

  /**
   * Ending IP address for the management network. A minimum of six free, contiguous IPv4 addresses (excluding your host IPs) are needed for infrastructure services such as clustering.
   */
  endingAddress?: string;
}

/**
 * The PhysicalNodes of a cluster.
 */
model PhysicalNodes {
  /**
   * NETBIOS name of each physical server on your Azure Stack HCI cluster.
   */
  name?: string;

  /**
   * The IPv4 address assigned to each physical server on your Azure Stack HCI cluster.
   */
  ipv4Address?: string;
}

/**
 * The Intents of a cluster.
 */
model DeploymentIntents {
  /**
   * Name of the network intent you wish to create.
   */
  name?: string;

  /**
   * List of network traffic types. Only allowed values are 'Compute', 'Storage', 'Management'.
   */
  trafficType?: string[];

  /**
   * Array of network interfaces used for the network intent.
   */
  adapter?: string[];

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideVirtualSwitchConfiguration?: boolean = false;

  /**
   * Set virtualSwitch ConfigurationOverrides for cluster.
   */
  virtualSwitchConfigurationOverrides?: DeploymentVirtualSwitchConfigurationOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideQosPolicy?: boolean;

  /**
   * Set QoS PolicyOverrides for cluster.
   */
  qosPolicyOverrides?: QosPolicyOverrides;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  overrideAdapterProperty?: boolean;

  /**
   * Set Adapter PropertyOverrides for cluster.
   */
  adapterPropertyOverrides?: DeploymentAdapterPropertyOverrides;
}

/**
 * The HostNetwork of a cluster.
 */
model DeploymentHostNetwork {
  /**
   * The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.
   */
  @identifiers(#["name"])
  intents?: DeploymentIntents[];

  /**
   * List of StorageNetworks config to deploy AzureStackHCI Cluster.
   */
  @identifiers(#["name"])
  storageNetworks?: DeploymentStorageNetworks[];

  /**
   * Defines how the storage adapters between nodes are connected either switch or switch less..
   */
  storageConnectivitySwitchless?: boolean;

  /**
   * Optional parameter required only for 3 Nodes Switchless deployments. This allows users to specify IPs and Mask for Storage NICs when Network ATC is not assigning the IPs for storage automatically.
   */
  enableStorageAutoIp?: boolean;
}

/**
 * The VirtualSwitchConfigurationOverrides of a cluster.
 */
model DeploymentVirtualSwitchConfigurationOverrides {
  /**
   * Enable IoV for Virtual Switch
   */
  enableIov?: string;

  /**
   * Load Balancing Algorithm for Virtual Switch
   */
  loadBalancingAlgorithm?: string;
}

/**
 * The AdapterPropertyOverrides of a cluster.
 */
@clientName("AdapterPropertyOverrides")
model DeploymentAdapterPropertyOverrides {
  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  jumboPacket?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.
   */
  networkDirect?: string;

  /**
   * This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation. Expected values are 'iWARP', 'RoCEv2', 'RoCE'
   */
  networkDirectTechnology?: string;
}

/**
 * The StorageNetworks of a cluster.
 */
model DeploymentStorageNetworks {
  /**
   * Name of the storage network.
   */
  name?: string;

  /**
   * Name of the storage network adapter.
   */
  networkAdapterName?: string;

  /**
   * ID specified for the VLAN storage network. This setting is applied to the network interfaces that route the storage and VM migration traffic.
   */
  vlanId?: string;

  /**
   * List of Storage adapter physical nodes config to deploy AzureStackHCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "model nomenclature"
  @identifiers(#["physicalNode"])
  storageAdapterIPInfo?: StorageAdapterIPInfo[];
}

/**
 * The StorageAdapter physical nodes of a cluster.
 */
model StorageAdapterIPInfo {
  /**
   * storage adapter physical node name.
   */
  physicalNode?: string;

  /**
   * The IPv4 address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  ipv4Address?: string;

  /**
   * The SubnetMask address assigned to each storage adapter physical node on your Azure Stack HCI cluster.
   */
  subnetMask?: string;
}

/**
 * SDN Integration config to deploy AzureStackHCI Cluster.
 */
model SdnIntegration {
  /**
   * network controller config for SDN Integration to deploy AzureStackHCI Cluster.
   */
  networkController?: NetworkController;
}

/**
 * network controller config for SDN Integration to deploy AzureStackHCI Cluster.
 */
model NetworkController {
  /**
   * macAddressPoolStart of network controller used for SDN Integration.
   */
  macAddressPoolStart?: string;

  /**
   * macAddressPoolStop of network controller used for SDN Integration.
   */
  macAddressPoolStop?: string;

  /**
   * NetworkVirtualizationEnabled of network controller used for SDN Integration.
   */
  networkVirtualizationEnabled?: boolean;
}

/**
 * Protected parameters list stored in keyvault.
 */
model EceDeploymentSecrets {
  /**
   * Secret name stored in keyvault.
   */
  secretName?: string;

  /**
   * Secret name expected for Enterprise Cloud Engine (ECE) deployment.
   */
  eceSecretName?: EceSecrets;

  /**
   * Secret URI stored in keyvault.
   */
  secretLocation?: url;
}

/**
 * The OptionalServices of AzureStackHCI Cluster.
 */
model OptionalServices {
  /**
   * The name of custom location.
   */
  customLocation?: string;
}

/**
 * Assembly Package details for Validated Solution Recipe for AzureStackHCI Cluster
 */
model AssemblyInfo {
  /**
   * Assembly Package version for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  packageVersion?: string;

  /**
   * Payload properties for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  payload?: AssemblyInfoPayload[];
}

/**
 * Payload properties for Validated Solution Recipe for AzureStackHCI Cluster
 */
model AssemblyInfoPayload {
  /**
   * assembly identifier for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  identifier?: string;

  /**
   * Hash of assembly package for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  hash?: string;

  /**
   * File name of assembly package for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  fileName?: string;

  /**
   * Url of assembly package for Validated Solution Recipe for AzureStackHCI Cluster
   */
  @visibility(Lifecycle.Read)
  url?: string;
}

/**
 * The solution builder extension (SBE) partner deployment info for cluster.
 */
model SbePartnerInfo {
  /**
   * SBE package and manifest information for the solution Builder Extension staged for AzureStackHCI cluster deployment.
   */
  sbeDeploymentInfo?: SbeDeploymentInfo;

  /**
   * List of SBE partner properties for AzureStackHCI cluster deployment.
   */
  @identifiers(#[])
  partnerProperties?: SbePartnerProperties[];

  /**
   * SBE credentials list for AzureStackHCI cluster deployment.
   */
  @identifiers(#["secretName"])
  credentialList?: SbeCredentials[];
}

/**
 * Solution builder extension (SBE) package and manifest information for the solution builder extension staged for AzureStackHCI cluster deployment.
 */
model SbeDeploymentInfo {
  /**
   * SBE package version.
   */
  version?: string;

  /**
   * SBE family name.
   */
  family?: string;

  /**
   * SBE manifest publisher.
   */
  publisher?: string;

  /**
   * SBE Manifest Source.
   */
  sbeManifestSource?: string;

  /**
   * SBE Manifest Creation Date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sbeManifestCreationDate?: utcDateTime;
}

/**
 * Solution builder extension (SBE) partner properties object.
 */
model SbePartnerProperties {
  /**
   * SBE partner property name.
   */
  name?: string;

  /**
   * SBE partner property value.
   */
  value?: string;
}

/**
 * secrets used for solution builder extension (SBE) partner extensibility.
 */
model SbeCredentials {
  /**
   * secret name stored in keyvault.
   */
  secretName?: string;

  /**
   * secret name expected for Enterprise Cloud Engine (ECE).
   */
  eceSecretName?: string;

  /**
   * secret URI stored in keyvault.
   */
  secretLocation?: url;
}
