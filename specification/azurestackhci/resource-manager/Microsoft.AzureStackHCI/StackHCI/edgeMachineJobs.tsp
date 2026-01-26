import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Cluster Jobs resource")
@parentResource(EdgeMachine)
model EdgeMachineJob
  is Azure.ResourceManager.ProxyResource<EdgeMachineJobProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-_]{3,63}$"
  >;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@armResourceOperations
interface EdgeMachineJobs {
  @doc("Get a EdgeMachineJob")
  get is ArmResourceRead<EdgeMachineJob>;

  @doc("Create a EdgeMachineJob")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineJob>;

  @doc("Delete a EdgeMachineJob")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineJob>;

  @doc("List EdgeMachineJob resources by EdgeMachines")
  list is ArmResourceListByParent<EdgeMachineJob>;
}

@@doc(EdgeMachineJob.name, "Name of EdgeMachineJob");

//////////////////// models ////////////////////

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("EdgeMachine Job properties")
@discriminator("jobType")
model EdgeMachineJobProperties {
  @doc("Job Type to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: EdgeMachineJobType;

  @doc("Deployment mode to trigger job.")
  deploymentMode?: DeploymentMode;

  @doc("Job provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Unique, immutable job id.")
  @visibility(Lifecycle.Read)
  jobId?: string;

  @doc("The UTC date and time at which the job started.")
  @visibility(Lifecycle.Read)
  startTimeUtc?: utcDateTime;

  @doc("The UTC date and time at which the job completed.")
  @visibility(Lifecycle.Read)
  endTimeUtc?: utcDateTime;

  @doc("Status of Edge device job.")
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  @doc("error details.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Job Type supported.")
union EdgeMachineJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provide remote support to the device.")
  RemoteSupport: "RemoteSupport",

  @doc("Job to provision operating system in the device.")
  ProvisionOs: "ProvisionOs",

  @doc("Job to download OS packages on to the device")
  DownloadOs: "DownloadOs",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Properties for adding a server in the cluster.")
model EdgeMachineRemoteSupportJobProperties extends EdgeMachineJobProperties {
  @doc("Job Type to support polymorphic resource.")
  jobType: EdgeMachineJobType.RemoteSupport;

  @doc("Remote support access level.")
  accessLevel: RemoteSupportAccessLevel;

  @doc("Remote support expiration timestamp.")
  expirationTimestamp: utcDateTime;

  @doc("Remote support type.")
  type: RemoteSupportType;

  @doc("log collection job reported properties.")
  @visibility(Lifecycle.Read)
  reportedProperties?: EdgeMachineRemoteSupportJobReportedProperties;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Represents the properties of an Azure Linux restricted operating environment Provision Os job.")
model ProvisionOsJobProperties extends EdgeMachineJobProperties {
  @doc("Job Type to support polymorphic resource.")
  jobType: EdgeMachineJobType.ProvisionOs;

  @doc("Os Provisioning request.")
  provisioningRequest: ProvisioningRequest;

  @doc("Reported Properties for Provision Os job")
  reportedProperties?: ProvisionOsReportedProperties;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Download Request properties")
model DownloadRequest {
  @doc("Target operating system to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: ProvisioningOsType;

  @doc("Operating system profile.")
  osProfile: DownloadOsProfile;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Represents the properties of Download Os job.")
model DownloadOsJobProperties extends EdgeMachineJobProperties {
  @doc("Job Type to support polymorphic resource.")
  jobType: EdgeMachineJobType.DownloadOs;

  @doc("Download OS request.")
  downloadRequest: DownloadRequest;

  @doc("Reported Properties for Download Os job")
  reportedProperties?: ProvisionOsReportedProperties;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Reported Properties for Provision Os job")
model ProvisionOsReportedProperties {
  ...JobReportedProperties;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Represents a provisioning request.")
model ProvisioningRequest {
  @doc("Target operating system to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: ProvisioningOsType;

  @doc("Operating system profile.")
  osProfile: OsProvisionProfile;

  @doc("User configuration.")
  @Azure.ResourceManager.identifiers(#["userName"])
  userDetails?: UserDetails[];

  @doc("Onboarding configuration.")
  onboardingConfiguration?: OnboardingConfiguration;

  @doc("Device configuration.")
  deviceConfiguration?: TargetDeviceConfiguration;

  @doc("Base64 encoded custom configuration for CAPI to use")
  customConfiguration?: string;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Represents the provisioning operating system type.")
union ProvisioningOsType {
  string,

  @doc("AzureLinux OS.")
  AzureLinux: "AzureLinux",

  @doc("HCI OS.")
  HCI: "HCI",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Represents the reported properties of a remote support job.")
model EdgeMachineRemoteSupportJobReportedProperties {
  ...EdgeMachineJobReportedProperties;

  @doc("Optional settings for configuring the node for remote support.")
  @visibility(Lifecycle.Read)
  nodeSettings?: EdgeMachineRemoteSupportNodeSettings;

  @doc("Details of the remote support session.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["sessionId"])
  sessionDetails?: RemoteSupportSession[];
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Represents the settings of a remote support node.")
model EdgeMachineRemoteSupportNodeSettings {
  @doc("The state of the remote support node.")
  @visibility(Lifecycle.Read)
  state?: string;

  @doc("The timestamp when the node settings were created, in UTC.")
  @visibility(Lifecycle.Read)
  createdAt?: utcDateTime;

  @doc("The timestamp when the node settings were last updated, in UTC.")
  @visibility(Lifecycle.Read)
  updatedAt?: utcDateTime;

  @doc("The current connection status of the remote support session.")
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  @doc("The error message, if any, from the last connection attempt.")
  @visibility(Lifecycle.Read)
  connectionErrorMessage?: string;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Properties for pausing a server in the cluster.")
model EdgeMachineCollectLogJobProperties extends EdgeMachineJobProperties {
  @doc("ClusterJob Type to support polymorphic resource.")
  jobType: EdgeMachineJobType.CollectLog;

  @doc("From date for log collection.")
  fromDate: utcDateTime;

  @doc("To date for log collection.")
  toDate: utcDateTime;

  @doc("To date for log collection.")
  @visibility(Lifecycle.Read)
  lastLogGenerated?: utcDateTime;

  @doc("log collection job reported properties.")
  @visibility(Lifecycle.Read)
  reportedProperties?: EdgeMachineCollectLogJobReportedProperties;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Represents the reported properties of a log collection job.")
model EdgeMachineCollectLogJobReportedProperties {
  ...JobReportedProperties;

  @doc("Details of the log collection session.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["correlationId"])
  logCollectionSessionDetails?: LogCollectionJobSession[];
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Reported Properties for job triggered from cloud.")
model EdgeMachineJobReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  @doc("Validation status of job.")
  @visibility(Lifecycle.Read)
  validationStatus?: EceActionStatus;

  @doc("Deployment status of job.")
  @visibility(Lifecycle.Read)
  deploymentStatus?: EceActionStatus;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Operating system profile.")
model OsProvisionProfile {
  @doc("Name of the operating system.")
  osName?: string;

  @doc("Type of the operating system.")
  osType?: string;

  @doc("Version of the operating system.")
  osVersion?: string;

  @doc("Location of the operating system image.")
  osImageLocation?: string;

  @doc("Validated Solution Recipe version to be used for the job")
  vsrVersion?: string;

  @doc("Hash of the OS package downloaded")
  imageHash?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "GPG Public Key is not sensitive information"
  @doc("GPG Public Key used for package verification")
  gpgPubKey?: string;

  @doc("Operation sub type of OS Provisioning")
  operationType?: OSOperationType = OSOperationType.Provision;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Operating system profile.")
model DownloadOsProfile {
  @doc("Name of the operating system.")
  osName?: string;

  @doc("Type of the operating system.")
  osType?: string;

  @doc("Version of the operating system.")
  osVersion?: string;

  @doc("Location of the operating system image.")
  osImageLocation?: string;

  @doc("Validated Solution Recipe version to be used for the job")
  vsrVersion?: string;

  @doc("Hash of the OS package downloaded")
  imageHash?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "GPG Public Key is not sensitive information"
  @doc("GPG Public Key used for package verification")
  gpgPubKey?: string;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("OS Provision Operation type")
union OSOperationType {
  string,

  @doc("OS Provisioning operation")
  Provision: "Provision",

  @doc("OS Update operation")
  Update: "Update",

  @doc("OS ReImage operation")
  ReImage: "ReImage",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Type of secret used for authentication.")
union SecretType {
  string,

  @doc("Key Vault based authentication")
  KeyVault: "KeyVault",

  @doc("SSH Public Key based authentication")
  SshPubKey: "SshPubKey",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("User configuration.")
model UserDetails {
  @doc("Name of the user.")
  userName: string;

  @doc("Type of the secret used for authentication.")
  secretType: SecretType;

  @doc("Location of the secret used for authentication.")
  secretLocation?: string;

  @doc("SSH Public Key for the user.")
  sshPubKey?: string[];
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Onboarding resource type.")
union OnboardingResourceType {
  string,

  @doc("Hybrid Compute Machine.")
  HybridComputeMachine: "HybridComputeMachine",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Onboarding configuration.")
model OnboardingConfiguration {
  @doc("Type of the onboarding resource to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type?: OnboardingResourceType;

  @doc("Resource ID.")
  resourceId?: Azure.Core.armResourceIdentifier;

  @doc("Location of the resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  @doc("Tenant ID of the resource.")
  tenantId?: string;

  @doc("Azure Arc virtual machine ID.")
  arcVirtualMachineId?: string;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Device configuration.")
model TargetDeviceConfiguration {
  @doc("Network configuration.")
  network?: NetworkConfiguration;

  @doc("Hostname of the device.")
  hostName?: string;

  @doc("Web proxy configuration.")
  webProxy?: WebProxyConfiguration;

  @doc("Time configuration.")
  time?: TimeConfiguration;

  @doc("Storage configuration.")
  storage?: StorageConfiguration;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Network configuration.")
model NetworkConfiguration {
  @Azure.ResourceManager.identifiers(#[])
  @doc("List of network adapters.")
  networkAdapters?: NetworkAdapter[];
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Storage configuration.")
model StorageConfiguration {
  @doc("Partition size.")
  partitionSize?: string;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Network adapter configuration.")
model NetworkAdapter {
  @doc("Type of IP assignment.")
  ipAssignmentType: IpAssignmentType;

  @doc("IP address.")
  ipAddress?: string;

  @doc("Adapter Name.")
  adapterName?: string;

  @doc("MAC address.")
  macAddress?: string;

  @doc("IP address range.")
  ipAddressRange?: IpAddressRange;

  @doc("Gateway id.")
  gateway?: string;

  @doc("Subnet mask.")
  subnetMask?: string;

  @doc("Array of DNS addresses.")
  dnsAddressArray?: string[];

  @doc("VLAN ID for the network setup.")
  vlanId?: string;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("IP assignment types")
union IpAssignmentType {
  string,

  @doc("Automatic IP assignment")
  Automatic: "Automatic",

  @doc("Manual IP assignment")
  Manual: "Manual",
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("IP address range configuration.")
model IpAddressRange {
  @doc("Start IP address.")
  startIp: string;

  @doc("End IP address.")
  endIp: string;
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Web proxy configuration.")
model WebProxyConfiguration {
  @doc("Connection URI of the web proxy.")
  connectionUri?: url;

  @doc("Port of the web proxy.")
  @pattern("^[0-9]{0,5}$")
  port?: string;

  @doc("Bypass list for the web proxy.")
  bypassList?: url[];
}

@added(Versions.v2025_12_01_preview)
@removed(Versions.v2026_02_01)
@doc("Time configuration.")
model TimeConfiguration {
  @doc("Primary NTP server.")
  primaryTimeServer?: string;

  @doc("Secondary NTP server.")
  secondaryTimeServer?: string;

  @doc("Time zone.")
  timeZone?: string;
}
