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

@doc("A EdgeDevice")
@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model EdgeDevice is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDevice,
    KeyName = "edgeDeviceName",
    SegmentName = "edgeDevices",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
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
  @visibility("read", "create")
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

@doc("Represents the status of a log collection operation.")
union LogCollectionStatus {
  @doc("A custom status provided as a string.")
  string,

  @doc("Indicates that no log collection operation has been initiated.")
  None: "None",

  @doc("Indicates that the log collection operation is currently in progress.")
  InProgress: "InProgress",

  @doc("Indicates that the log collection operation has failed.")
  Failed: "Failed",

  @doc("Indicates that the log collection operation has completed successfully.")
  Succeeded: "Succeeded",
}

@doc("Job Type supported by Azure Linux Edge Devices.")
union AzureLinuxEdgeDeviceJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provide remote support to the device.")
  RemoteSupport: "RemoteSupport",
}

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

@doc("Defines the type of remote support action to be performed on an edge device.")
union RemoteSupportType {
  @doc("A custom action type provided as a string.")
  string,

  @doc("Enables remote support for the edge device.")
  Enable: "Enable",

  @doc("Revokes previously granted remote support access for the edge device.")
  Revoke: "Revoke",
}

@doc("Job Type supported.")
union HciEdgeDeviceJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provide remote support to the device.")
  RemoteSupport: "RemoteSupport",
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

@doc("Azure Linux Collect Log Job Properties.")
model AzureLinuxCollectLogJobProperties
  extends AzureLinuxEdgeDeviceJobProperties {
  ...CollectLogJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: AzureLinuxEdgeDeviceJobType.CollectLog;
}

@doc("Represents the reported properties of a log collection job.")
model LogCollectionReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility("read")
  percentComplete?: int32;

  @doc("Validation status of job.")
  @visibility("read")
  validationStatus?: EceActionStatus;

  @doc("Deployment status of job.")
  @visibility("read")
  deploymentStatus?: EceActionStatus;

  @doc("Details of the log collection session.")
  @visibility("read")
  @extension("x-ms-identifiers", ["correlationId"])
  logCollectionSessionDetails?: LogCollectionSession[];
}

@doc("Represents a session for collecting logs from an edge device.")
model LogCollectionSession {
  @doc("The timestamp when log collection started, in ISO 8601 format.")
  @visibility("read")
  startTime?: string;

  @doc("The timestamp when log collection ended, in ISO 8601 format.")
  @visibility("read")
  endTime?: string;

  @doc("The total time logs were collected for, in ISO 8601 duration format.")
  @visibility("read")
  timeCollected?: string;

  @doc("The size of the collected logs in bytes.")
  @visibility("read")
  logSize?: int32;

  @doc("The status of the log collection session.")
  @visibility("read")
  status?: LogCollectionStatus;

  @doc("A unique identifier for correlating this log collection session with other operations or sessions.")
  @visibility("read")
  correlationId?: string;
}
@doc("Edge device job properties")
@discriminator("jobType")
model AzureLinuxEdgeDeviceJobProperties {
  ...EdgeDeviceJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: AzureLinuxEdgeDeviceJobType;
}

@doc("Edge device job properties")
model EdgeDeviceJobProperties {
  @doc("Deployment mode to trigger job.")
  deploymentMode?: DeploymentMode;

  @doc("Job provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Unique, immutable job id.")
  @visibility("read")
  jobId?: string;

  @doc("The UTC date and time at which the job started.")
  @visibility("read")
  startTimeUtc?: utcDateTime;

  @doc("The UTC date and time at which the job completed.")
  @visibility("read")
  endTimeUtc?: utcDateTime;

  @doc("Status of Edge device job.")
  @visibility("read")
  status?: JobStatus;

  @doc("Reported properties for job")
  @visibility("read")
  reportedProperties?: EdgeDeviceJobReportedProperties;
}

@doc("Reported Properties for  job triggered from cloud.")
model EdgeDeviceJobReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility("read")
  percentComplete?: int32;

  @doc("Validation status of job.")
  @visibility("read")
  validationStatus?: EceActionStatus;

  @doc("Deployment status of job.")
  @visibility("read")
  deploymentStatus?: EceActionStatus;
}

@doc("Edge device job for Azure Linux solution.")
model AzureLinuxEdgeDeviceJob extends EdgeDeviceJob {
  @doc("Edge device job properties")
  properties: AzureLinuxEdgeDeviceJobProperties;

  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeDeviceKind.AzureLinux;
}

@doc("Represents the properties of an Azure Linux Remote Support job.")
model AzureLinuxRemoteSupportJobProperties
  extends AzureLinuxEdgeDeviceJobProperties {
  ...RemoteSupportJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: AzureLinuxEdgeDeviceJobType.RemoteSupport;
}

@doc("Represents the reported properties of a remote support job.")
model RemoteSupportReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility("read")
  percentComplete?: int32;

  @doc("Validation status of job.")
  @visibility("read")
  validationStatus?: EceActionStatus;

  @doc("Deployment status of job.")
  @visibility("read")
  deploymentStatus?: EceActionStatus;

  @doc("Optional settings for configuring the node for remote support.")
  @visibility("read")
  @extension("x-ms-identifiers", ["arcResourceId"])
  nodeSettings?: RemoteSupportNodeSettings[];

  @doc("Details of the remote support session.")
  @visibility("read")
  sessionDetails?: RemoteSupportSession;
}

@doc("Represents the settings of a remote support node.")
model RemoteSupportNodeSettings {
  @doc("The resource ID of the Azure Arc enabled server.")
  @visibility("read")
  arcResourceId?: string;

  @doc("The state of the remote support node.")
  @visibility("read")
  state?: string;

  @doc("The timestamp when the node settings were created, in UTC.")
  @visibility("read")
  createdAt?: utcDateTime;

  @doc("The timestamp when the node settings were last updated, in UTC.")
  @visibility("read")
  updatedAt?: utcDateTime;

  @doc("The current connection status of the remote support session.")
  @visibility("read")
  connectionStatus?: string;

  @doc("The error message, if any, from the last connection attempt.")
  @visibility("read")
  connectionErrorMessage?: string;

  @doc("The location where the session transcript is stored.")
  @visibility("read")
  transcriptLocation?: string;
}

@doc("Represents a remote support session.")
model RemoteSupportSession {
  @doc("The start time of the remote support session, in UTC.")
  @visibility("read")
  sessionStartTime?: utcDateTime;

  @doc("The end time of the remote support session, in UTC.")
  @visibility("read")
  sessionEndTime?: utcDateTime;

  @doc("The name of the node for which the session was initiated.")
  @visibility("read")
  nodeName?: string;

  @doc("The duration of the session in minutes.")
  @visibility("read")
  duration?: int32;

  @doc("The level of access granted during the remote support session.")
  @visibility("read")
  accessLevel?: RemoteSupportAccessLevel;
}

@doc("Represents the properties of a log collection job.")
model CollectLogJobProperties {
  @doc("From date for log collection.")
  fromDate: utcDateTime;

  @doc("To date for log collection.")
  toDate: utcDateTime;

  @doc("To date for log collection.")
  @visibility("read")
  lastLogGenerated?: utcDateTime;

  @doc("log collection job reported properties.")
  @visibility("read")
  reportedProperties?: LogCollectionReportedProperties;
}

@doc("Represents the properties of an HCI Collect Log job.")
model HciCollectLogJobProperties extends HciEdgeDeviceJobProperties {
  ...CollectLogJobProperties;

  @doc("Job Type to support polymorphic resource.")
  jobType: HciEdgeDeviceJobType.CollectLog;
}

@discriminator("jobType")
@doc("HCI Edge device job properties")
model HciEdgeDeviceJobProperties {
  ...EdgeDeviceJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
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
  @visibility("read")
  reportedProperties?: RemoteSupportReportedProperties;
}
