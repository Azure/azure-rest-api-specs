import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

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
@armResourceOperations
interface EdgeMachineJobs {
  @doc("Get a EdgeMachineJob")
  get is ArmResourceRead<EdgeMachineJob>;

  @doc("Create a EdgeMachineJob")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeMachineJob>;

  @doc("Delete a EdgeMachineJob")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeMachineJob>;

  @doc("List EdgeMachineJob resources by EdgeMachines")
  listByCluster is ArmResourceListByParent<EdgeMachineJob>;
}

@@doc(EdgeMachineJob.name, "Name of EdgeMachineJob");

////////////////////models////////////////////

@added(Versions.v2025_12_01_preview)
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
@doc("Job Type supported.")
union EdgeMachineJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provide remote support to the device.")
  RemoteSupport: "RemoteSupport",

  @doc("Job to provision operating system in the device.")
  ProvisionOs: "ProvisionOs",

  @doc("Job to debug machine issues using AI.")
  MachineAssistant: "MachineAssistant",

  @doc("Job to download OS packages on to the device")
  DownloadOs: "DownloadOs",
}

@added(Versions.v2025_12_01_preview)
@doc("Represents the various statuses a job can have throughout its lifecycle.")
union JobStatus {
  string,

  @doc("The job status has not been specified.")
  NotSpecified: "NotSpecified",

  @doc("The job is currently undergoing validation.")
  ValidationInProgress: "ValidationInProgress",

  @doc("The job has successfully passed validation.")
  ValidationSuccess: "ValidationSuccess",

  @doc("The job has failed validation.")
  ValidationFailed: "ValidationFailed",

  @doc("The job's deployment is currently in progress.")
  DeploymentInProgress: "DeploymentInProgress",

  @doc("The job's deployment has failed.")
  DeploymentFailed: "DeploymentFailed",

  @doc("The job has been successfully deployed.")
  DeploymentSuccess: "DeploymentSuccess",

  @doc("The job has succeeded.")
  Succeeded: "Succeeded",

  @doc("The job has failed.")
  Failed: "Failed",

  @doc("The job has been canceled.")
  Canceled: "Canceled",

  @doc("The job is paused.")
  Paused: "Paused",

  @doc("The job is scheduled to run.")
  Scheduled: "Scheduled",
}

@added(Versions.v2025_12_01_preview)
@doc("Properties for adding a server in the cluster.")
model RemoteSupportJobProperties extends EdgeMachineJobProperties {
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
  reportedProperties?: RemoteSupportReportedProperties;
}

@added(Versions.v2025_12_01_preview)
@doc("Properties for running Machine Assistant Job Properties.")
model MachineAssistantJobProperties extends EdgeMachineJobProperties {
  @doc("Job Type to support polymorphic resource.")
  jobType: EdgeMachineJobType.MachineAssistant;

  @doc("The user intent to be checked on the device.")
  intent: string;

  @doc("The source of the model used for analysis.")
  source?: string;

  @doc("The type of model used for analysis.")
  type?: string;

  @doc("Machine Assistant job reported properties.")
  @visibility(Lifecycle.Read)
  reportedProperties?: MachineAssistantReportedProperties;
}

@added(Versions.v2025_12_01_preview)
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
@doc("Download Request properties")
model DownloadRequest {
  @doc("Target operating system to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: ProvisioningOsType;

  @doc("Operating system profile.")
  osProfile: DownloadOsProfile;
}

@added(Versions.v2025_12_01_preview)
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
@doc("Reported Properties for Provision Os job")
model ProvisionOsReportedProperties {
  ...JobReportedProperties;
}

@added(Versions.v2025_12_01_preview)
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
  deviceConfiguration?: DeviceConfiguration;

  @doc("Base64 encoded custom configuration for CAPI to use")
  customConfiguration?: string;
}

@added(Versions.v2025_12_01_preview)
@doc("Represents the provisioning operating system type.")
union ProvisioningOsType {
  string,

  @doc("AzureLinux OS.")
  AzureLinux: "AzureLinux",

  @doc("HCI OS.")
  HCI: "HCI",
}

@added(Versions.v2025_12_01_preview)
@doc("Represents the reported properties of a remote support job.")
model RemoteSupportReportedProperties {
  ...JobReportedProperties;

  @doc("Optional settings for configuring the node for remote support.")
  @visibility(Lifecycle.Read)
  nodeSettings?: RemoteSupportNodeSettings;

  @doc("Details of the remote support session.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["sessionId"])
  sessionDetails?: RemoteSupportSession[];
}

@added(Versions.v2025_12_01_preview)
@doc("Represents the reported properties of machine assistant job.")
model MachineAssistantReportedProperties {
  ...JobReportedProperties;

  @doc("The result obtained after checking the intent on the machine.")
  @visibility(Lifecycle.Read)
  summary?: string;
}

@added(Versions.v2025_12_01_preview)
@doc("Represents the settings of a remote support node.")
model RemoteSupportNodeSettings {
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
@doc("Represents a remote support session.")
model RemoteSupportSession {
  @doc("Unique session Id.")
  @visibility(Lifecycle.Read)
  sessionId?: string;

  @doc("The start time of the remote support session, in UTC.")
  @visibility(Lifecycle.Read)
  sessionStartTime?: utcDateTime;

  @doc("The end time of the remote support session, in UTC.")
  @visibility(Lifecycle.Read)
  sessionEndTime?: utcDateTime;

  @doc("The level of access granted during the remote support session.")
  @visibility(Lifecycle.Read)
  accessLevel?: RemoteSupportAccessLevel;

  @doc("The location where the session transcript is stored.")
  @visibility(Lifecycle.Read)
  transcriptLocation?: string;
}

@added(Versions.v2025_12_01_preview)
@doc("Defines the level of remote support access granted.")
union RemoteSupportAccessLevel {
  @doc("A custom access level provided as a string.")
  string,

  @doc("No remote support access is granted.")
  None: "None",

  @doc("Access is limited to diagnostics information only.")
  Diagnostics: "Diagnostics",

  @doc("Access includes diagnostics information and the ability to perform repairs.")
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

@added(Versions.v2025_12_01_preview)
@doc("Defines the type of remote support action to be performed on an edge device.")
union RemoteSupportType {
  @doc("A custom action type provided as a string.")
  string,

  @doc("Enables remote support for the edge device.")
  Enable: "Enable",

  @doc("Revokes previously granted remote support access for the edge device.")
  Revoke: "Revoke",
}

@added(Versions.v2025_12_01_preview)
@doc("Properties for pausing a server in the cluster.")
model CollectLogJobProperties extends EdgeMachineJobProperties {
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
  reportedProperties?: LogCollectionReportedProperties;
}

@added(Versions.v2025_12_01_preview)
@doc("Represents the reported properties of a log collection job.")
model LogCollectionReportedProperties {
  ...JobReportedProperties;

  @doc("Details of the log collection session.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["correlationId"])
  logCollectionSessionDetails?: LogCollectionSession[];
}

@added(Versions.v2025_12_01_preview)
@doc("Represents a session for collecting logs from an edge device.")
model LogCollectionSession {
  @doc("The timestamp when log collection started, in ISO 8601 format.")
  @visibility(Lifecycle.Read)
  startTime?: string;

  @doc("The timestamp when log collection ended, in ISO 8601 format.")
  @visibility(Lifecycle.Read)
  endTime?: string;

  @doc("The total time logs were collected for, in ISO 8601 duration format.")
  @visibility(Lifecycle.Read)
  timeCollected?: string;

  @doc("The size of the collected logs in bytes.")
  @visibility(Lifecycle.Read)
  logSize?: int32;

  @doc("The status of the log collection session.")
  @visibility(Lifecycle.Read)
  status?: DeviceLogCollectionStatus;

  @doc("A unique identifier for correlating this log collection session with other operations or sessions.")
  @visibility(Lifecycle.Read)
  correlationId?: string;
}

@added(Versions.v2025_12_01_preview)
@doc("Reported Properties for job triggered from cloud.")
model JobReportedProperties {
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
@doc("Represents the status of a log collection operation.")
union DeviceLogCollectionStatus {
  @doc("A custom status provided as a string.")
  string,

  @doc("Log collection operation has not been initiated.")
  NotStarted: "NotStarted",

  @doc("Indicates that the log collection operation is currently running.")
  Running: "Running",

  @doc("Indicates that the log collection operation has failed.")
  Failed: "Failed",

  @doc("Indicates that the log collection operation has completed successfully.")
  Succeeded: "Succeeded",

  @doc("Indicates that the log collection operation has completed successfully.")
  Canceled: "Canceled",
}

@added(Versions.v2025_12_01_preview)
@doc("Validation / deployment status details for Job.")
model EceActionStatus {
  @doc("Job status.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("List of steps of Edge device job.")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: Step[];
}

@added(Versions.v2025_12_01_preview)
@doc("Deployment mode to trigger job.")
union DeploymentMode {
  string,

  @doc("Validate ECE action deployment for a cluster.")
  Validate: "Validate",

  @doc("Deploy ECE action deployment for a cluster.")
  Deploy: "Deploy",
}

@added(Versions.v2025_12_01_preview)
@doc("Step details during job execution.")
model Step {
  @doc("Name of step.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Description of step.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("FullStepIndex of step.")
  @visibility(Lifecycle.Read)
  fullStepIndex?: string;

  @doc("Start time in utc of step.")
  @visibility(Lifecycle.Read)
  startTimeUtc?: string;

  @doc("End time in utc of step.")
  @visibility(Lifecycle.Read)
  endTimeUtc?: string;

  @doc("Status of step. Allowed values are 'Error', 'Success', 'InProgress'")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("List of nested steps during job execution..")
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: Step[];

  @doc("List of exceptions in job execution.")
  @visibility(Lifecycle.Read)
  exception?: string[];

  @doc("Error information for the step")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@added(Versions.v2025_12_01_preview)
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

  @doc("GPG Public Key used for package verification")
  gpgPubKey?: string;

  @doc("Operation sub type of OS Provisioning")
  operationType?: OSOperationType = OSOperationType.Provision;
}

@added(Versions.v2025_12_01_preview)
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

  @doc("GPG Public Key used for package verification")
  gpgPubKey?: string;
}

@added(Versions.v2025_12_01_preview)
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
@doc("User configuration.")
model UserDetails {
  @doc("Name of the user.")
  userName: string;

  @doc("Type of the secret used for authentication. Change it to enum in public preview")
  secretType: string;

  @doc("Location of the secret used for authentication.")
  secretLocation?: string;

  @doc("Location of the secret used for authentication.")
  sshPubKey?: string[];
}

@added(Versions.v2025_12_01_preview)
@doc("Onboarding resource type.")
union OnboardingResourceType {
  string,

  @doc("Hybrid Compute Machine.")
  HybridComputeMachine: "HybridComputeMachine",
}

@added(Versions.v2025_12_01_preview)
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
@doc("Device configuration.")
model DeviceConfiguration {
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
@doc("Network configuration.")
model NetworkConfiguration {
  @Azure.ResourceManager.identifiers(#[])
  @doc("List of network adapters.")
  networkAdapters?: NetworkAdapter[];
}

@added(Versions.v2025_12_01_preview)
@doc("Storage configuration.")
model StorageConfiguration {
  @doc("Partition size.")
  partitionSize?: string;
}

@added(Versions.v2025_12_01_preview)
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
@doc("IP assignment types")
union IpAssignmentType {
  string,

  @doc("Automatic IP assignment")
  Automatic: "Automatic",

  @doc("Manual IP assignment")
  Manual: "Manual",
}

@added(Versions.v2025_12_01_preview)
@doc("IP address range configuration.")
model IpAddressRange {
  @doc("Start IP address.")
  startIp: string;

  @doc("End IP address.")
  endIp: string;
}

@added(Versions.v2025_12_01_preview)
@doc("Web proxy configuration.")
model WebProxyConfiguration {
  @doc("Connection URI of the web proxy.")
  connectionUri?: string;

  @doc("Port of the web proxy.")
  port?: string;

  @doc("Bypass list for the web proxy.")
  bypassList?: string[];
}

@added(Versions.v2025_12_01_preview)
@doc("Time configuration.")
model TimeConfiguration {
  @doc("Primary NTP server.")
  primaryTimeServer?: string;

  @doc("Secondary NTP server.")
  secondaryTimeServer?: string;

  @doc("Time zone.")
  timeZone?: string;
}
