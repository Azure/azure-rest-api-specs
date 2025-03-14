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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Legacy"
model EdgeDevice is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDevice,
    KeyName = "edgeDeviceName",
    SegmentName = "edgeDevices",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Legacy"
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

@doc("Job Type supported by Azure Linux Edge Devices.")
union AzureLinuxEdgeDeviceJobType {
  string,

  @doc("Job to collect logs from the device.")
  CollectLog: "CollectLog",

  @doc("Job to provide remote support to the device.")
  RemoteSupport: "RemoteSupport",
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

@doc("Edge device job properties")
@discriminator("jobType")
model AzureLinuxEdgeDeviceJobProperties {
  ...EdgeDeviceJobProperties;

  @doc("Job Type to support polymorphic resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  jobType: AzureLinuxEdgeDeviceJobType;
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
