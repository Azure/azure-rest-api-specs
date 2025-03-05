import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

// these contains OS Provisioning Job

@doc("A EdgeDevice")
@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
model EdgeDevice is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDevice,
    KeyName = "edgeDeviceName",
    SegmentName = "edgeDevices",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@doc("EdgeDevice Jobs resource")
@parentResource(EdgeDevice)
@discriminator("kind")
model EdgeDeviceJob is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDeviceJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @doc("Edge Solution type to support polymorphic resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: EdgeDeviceKind;
}

@armResourceOperations
interface EdgeDeviceJobs {
  @doc("Get a EdgeDeviceJob")
  get is ArmResourceRead<EdgeDeviceJob>;

  @doc("Create a EdgeDeviceJob")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeDeviceJob>;

  @doc("Delete a EdgeDeviceJob")
  delete is ArmResourceDeleteWithoutOkAsync<EdgeDeviceJob>;

  @doc("List EdgeDeviceJob resources by EdgeDevice")
  listByEdgeDevice is ArmResourceListByParent<EdgeDeviceJob>;
}

@@doc(EdgeDeviceJob.name, "Name of EdgeDevice Job");

///////////////////models///////////

@doc("Represents the provisioning operating system type.")
union ProvisioningOsType {
  string,

  @doc("AzureLinux OS.")
  AzureLinux: "AzureLinux",

  @doc("HCI OS.")
  HCI: "HCI",
}

@doc("Job Type supported by Azure Linux Edge Devices in Restricted operating environment.")
union AzureLinuxRoeEdgeDeviceJobType {
  string,

  @doc("Job to provision operating system in the device.")
  ProvisionOs: "ProvisionOs",
}

@doc("Job Type supported.")
union HciEdgeDeviceJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provide remote support to the device.")
  RemoteSupport: "RemoteSupport",

  @doc("Job to update confidential VM support to the device.")
  UpdateConfidentialVm: "UpdateConfidentialVm",
}

@doc("Common Job Types supported.")
union EdgeDeviceJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provide remote support to the device.")
  RemoteSupport: "RemoteSupport",

  @doc("Job to establish a remote connection to the device.")
  RemoteConnect: "RemoteConnect",
}

@doc("Represents the reported properties of a log collection job.")
model LogCollectionReportedProperties {
  ...JobReportedProperties;

  @doc("Details of the log collection session.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["correlationId"])
  logCollectionSessionDetails?: LogCollectionSession[];
}

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

@doc("Azure linux edge device job properties in restricted operating environment")
@discriminator("jobType")
model AzureLinuxRoeEdgeDeviceJobProperties {
  ...EdgeDeviceJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: AzureLinuxRoeEdgeDeviceJobType;
}

@doc("Edge device job properties")
model EdgeDeviceJobProperties {
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
}

@doc("Edge device job for Azure Linux restricted operating environment solution.")
model AzureLinuxRoeEdgeDeviceJob extends EdgeDeviceJob {
  @doc("Edge device job properties for restricted operating environment")
  properties: AzureLinuxRoeEdgeDeviceJobProperties;

  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeDeviceKind.AzureLinuxRoe;
}

@doc("Represents the properties of an Azure Linux restricted operating environment Provision Os job.")
model AzureLinuxRoeProvisionOsJobProperties
  extends AzureLinuxRoeEdgeDeviceJobProperties {
  @doc("Job Type to support polymorphic resource.")
  jobType: AzureLinuxRoeEdgeDeviceJobType.ProvisionOs;

  @doc("Os Provisioning request.")
  provisioningRequest: ProvisioningRequest;

  @doc("Reported Properties for Provision Os job")
  reportedProperties?: ProvisionOsReportedProperties;
}

@doc("Reported Properties for Provision Os job")
model ProvisionOsReportedProperties {
  ...JobReportedProperties;
}

@discriminator("target")
@doc("Represents a provisioning request.")
model ProvisioningRequest {
  @doc("Target operating system to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  target: ProvisioningOsType;
}

@doc("Azure Linux provisioning request.")
model AzureLinuxProvisioningRequest extends ProvisioningRequest {
  @doc("Target operating system type to support polymorphic resource.")
  target: ProvisioningOsType.AzureLinux;

  @doc("Operating system profile.")
  osProfile: OsProfile;

  @doc("User configuration.")
  userConfiguration: UserConfiguration;

  @doc("Onboarding configuration.")
  onboardingConfiguration: OnboardingConfiguration;

  @doc("Device configuration.")
  deviceConfiguration: DeviceConfiguration;
}

@doc("HCI provisioning request.")
model HciProvisioningRequest extends ProvisioningRequest {
  @doc("Target operating system type to support polymorphic resource.")
  target: ProvisioningOsType.HCI;

  @doc("Operating system profile.")
  osProfile: OsProfile;

  @doc("User configuration.")
  userConfiguration: UserConfiguration;

  @doc("Onboarding configuration.")
  onboardingConfiguration: OnboardingConfiguration;

  @doc("Device configuration.")
  deviceConfiguration: DeviceConfiguration;
}

@doc("Operating system profile.")
model OsProfile {
  @doc("Name of the operating system.")
  osName?: string;

  @doc("Type of the operating system.")
  osType?: string;

  @doc("Version of the operating system.")
  osVersion?: string;

  @doc("URL of the operating system image.")
  osImageUrl?: string;
}

@doc("User configuration.")
model UserConfiguration {
  @doc("Name of the user.")
  userName: string;

  @doc("Type of the secret used for authentication.")
  secretType: string;

  @doc("Location of the secret used for authentication.")
  secretLocation: string;
}

@doc("Onboarding resource type.")
union OnboardingResourceType {
  string,

  @doc("Hybrid Compute Machine.")
  HybridComputeMachine: "HybridComputeMachine",
}

@discriminator("type")
@doc("Onboarding configuration.")
model OnboardingConfiguration {
  @doc("Type of the onboarding resource to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type: OnboardingResourceType;
}

@doc("Represents properties for hybrid compute machine onboarding resource.")
model HybridComputeMachineOnboardingConfiguration
  extends OnboardingConfiguration {
  @doc("Type of the onboarding resource to support polymorphic resource.")
  type: OnboardingResourceType.HybridComputeMachine;

  @doc("Resource ID.")
  resourceId: string;

  @doc("Location of the resource.")
  location: string;

  @doc("Tenant ID of the resource.")
  tenantId?: string;

  @doc("Azure Arc virtual machine ID.")
  arcVirtualMachineId: string;
}

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

@doc("Represents the properties of a log collection job.")
model CollectLogJobProperties {
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

@doc("Represents the properties of an HCI Collect Log job.")
model HciCollectLogJobProperties extends HciEdgeDeviceJobProperties {
  ...CollectLogJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: HciEdgeDeviceJobType.CollectLog;
}

@doc("Represents the properties of an HCI Update Confidential Vm job.")
model HciUpdateConfidentialVmProperties extends HciEdgeDeviceJobProperties {
  @doc("Job Type to support polymorphic resource.")
  jobType: HciEdgeDeviceJobType.UpdateConfidentialVm;

  @doc("Defines the customer's intent for updating confidential VM properties")
  confidentialVmIntent: ConfidentialVmIntent;
}

@discriminator("jobType")
@doc("HCI Edge device job properties")
model HciEdgeDeviceJobProperties {
  ...EdgeDeviceJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: HciEdgeDeviceJobType;
}

@doc("Edge device job for Azure Stack HCI solution.")
model HciEdgeDeviceJob extends EdgeDeviceJob {
  @doc("HCI Edge device job properties")
  properties: HciEdgeDeviceJobProperties;

  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeDeviceKind.HCI;
}

@doc("Represents the properties of a remote support job for HCI.")
model HciRemoteSupportJobProperties extends HciEdgeDeviceJobProperties {
  ...RemoteSupportJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: HciEdgeDeviceJobType.RemoteSupport;
}

@doc("Represents the properties of a remote support job.")
model RemoteSupportJobProperties {
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

@doc("Defines the customer's intent for updating confidential VM properties")
union ConfidentialVmIntent {
  @doc("Intent provided as a string.")
  string,

  @doc("Enable confidential VM properties on device")
  Enable: "Enable",
}
