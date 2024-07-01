import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

import "./hciCommon.tsp";
// import "./edgeDevices.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

// FIXME: EdgeDeviceJob has no properties property
/**
 * Jobs resource
 */
@doc("EdgeDevice Jobs resource")
@parentResource(EdgeDevice)
@discriminator("kind")
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model EdgeDeviceJob is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDeviceJob,
    KeyName = "jobsName",
    SegmentName = "jobs",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @visibility("read", "create")
  kind: DeviceType;
}

@armResourceOperations
interface EdgeDeviceJobs {
  /**
   * Get a EdgeDeviceJob
   */
  get is ArmResourceRead<EdgeDeviceJob>;

  /**
   * Create a EdgeDeviceJob
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<EdgeDeviceJob>;

  /**
   * Delete a EdgeDeviceJob
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeDeviceJob>;

  /**
   * List EdgeDeviceJob resources by EdgeDevice
   */
  listByEdgeDevice is ArmResourceListByParent<EdgeDeviceJob>;
}

@@doc(EdgeDeviceJob.name, "Name of EdgeDevice Job");

///////////////////models///////////

/**
 * Edge device type based on host OS installed.
 */
union DeviceType {
  string,

  /**
   * Arc-enabled edge device with HCI OS.
   */
  HCI: "HCI",

  /**
   * Arc-enabled edge device with WindowsServer OS.
   */
  WindowsServer: "WindowsServer",

  /**
   * Arc-enabled edge device with WindowsIoT OS.
   */
  WindowsIoT: "WindowsIoT",

  /**
   * Arc-enabled edge device with AzureLinux OS.
   */
  AzureLinux: "AzureLinux",

  /**
   * Arc-enabled edge device with UbuntuLinux OS.
   */
  UbuntuLinux: "UbuntuLinux",
}

/**
 * The status of log collection.
 */
/**
 * Represents the status of a log collection operation.
 */
union LogCollectionStatus {
  /**
   * A custom status provided as a string.
   */
  string,

  /**
   * Indicates that no log collection operation has been initiated.
   */
  None: "None",

  /**
   * Indicates that the log collection operation is currently in progress.
   */
  InProgress: "InProgress",

  /**
   * Indicates that the log collection operation has failed.
   */
  Failed: "Failed",

  /**
   * Indicates that the log collection operation has completed successfully.
   */
  Succeeded: "Succeeded",
}

/**
 * Job Type supported.
 */
union AzureLinuxEdgeDeviceJobType {
  string,

  /**
   * CollectLog
   */
  CollectLog: "CollectLog",

  /**
   * RemoteSupport
   */
  RemoteSupport: "RemoteSupport",

  /**
   * RemoteConnect
   */
  RemoteConnect: "RemoteConnect",

  /**
   * EnableSsh
   */
  EnableSsh: "EnableSsh",
}

/**
 * Defines the level of remote support access granted.
 */
union RemoteSupportAccessLevel {
  /**
   * A custom access level provided as a string.
   */
  string,

  /**
   * No remote support access is granted.
   */
  None: "None",

  /**
   * Access is limited to diagnostics information only.
   */
  Diagnostics: "Diagnostics",

  /**
   * Access includes diagnostics information and the ability to perform repairs.
   */
  DiagnosticsAndRepair: "DiagnosticsAndRepair",
}

/**
 * Defines the type of remote support action to be performed on an edge device.
 */
union RemoteSupportType {
  /**
   * A custom action type provided as a string.
   */
  string,

  /**
   * Enables remote support for the edge device.
   */
  Enable: "Enable",

  /**
   * Revokes previously granted remote support access for the edge device.
   */
  Revoke: "Revoke",
}

/**
 * Job Type supported.
 */
union HciEdgeDeviceJobType {
  string,

  /**
   * CollectLog
   */
  CollectLog: "CollectLog",

  /**
   * RemoteSupport
   */
  RemoteSupport: "RemoteSupport",

  /**
   * RemoteConnect
   */
  RemoteConnect: "RemoteConnect",

  /**
   * RenameHostname
   */
  RenameHostname: "RenameHostname",
}

/**
 * Common Job Types supported.
 */
union EdgeDeviceJobType {
  string,

  /**
   * CollectLog
   */
  CollectLog: "CollectLog",

  /**
   * RemoteSupport
   */
  RemoteSupport: "RemoteSupport",

  /**
   * RemoteConnect
   */
  RemoteConnect: "RemoteConnect",
}

/**
 * Azure Linux Collect Log Job Properties.
 */
model AzureLinuxCollectLogJobProperties
  extends AzureLinuxEdgeDeviceJobProperties {
  ...CollectLogJobProperties,

   /**
   * Job Type to support polymorphic resource.
   */
  jobType: AzureLinuxEdgeDeviceJobType.CollectLog;
}

/**
 * Represents the reported properties of a log collection job.
 */
model LogCollectionReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * Validation status of job.
   */
  @visibility("read")
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility("read")
  deploymentStatus?: EceActionStatus;

  /**
   * Details of the log collection session.
   */
  logCollectionSessionDetails?: LogCollectionSession;
}

/**
 * Represents a session for collecting logs from an edge device.
 */
model LogCollectionSession {
  /**
   * The timestamp when log collection started, in ISO 8601 format.
   */
  startTime?: string;

  /**
   * The timestamp when log collection ended, in ISO 8601 format.
   */
  endTime?: string;

  /**
   * The total time logs were collected for, in ISO 8601 duration format.
   */
  timeCollected?: string;

  /**
   * The size of the collected logs in bytes.
   */
  logSize?: int32;

  /**
   * The status of the log collection session.
   */
  status?: LogCollectionStatus;

  /**
   * A unique identifier for correlating this log collection session with other operations or sessions.
   */
  correlationId?: string;
}
/**
 * Edgedevice job properties
 */
@discriminator("jobType")
model AzureLinuxEdgeDeviceJobProperties {
  ...EdgeDeviceJobProperties;

  /**
   * Indicates whether SSH is enabled on the edge device.
   */
  sshEnabled?: boolean;

  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: AzureLinuxEdgeDeviceJobType;
}

/**
 * Edgedevice job properties
 */
model EdgeDeviceJobProperties {
  /**
   * Deployment mode to trigger job.
   */
  deploymentMode?: DeploymentMode;


  /**
   * Job provisioning state
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Unique, immutable job id.
   */
  @visibility("read")
  jobId?: string;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility("read")
  startTimeUtc?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility("read")
  endTimeUtc?: utcDateTime;

  /**
   * Status of Edgedevice job. Allowed values are 'Failed', 'Success', 'Running', 'canceled'
   */
  @visibility("read")
  status?: string;

  /**
   * Reported properties for job
   */
  @visibility("read")
  reportedProperties?: EdgeDeviceJobReportedProperties;
}

/**
 * Reported Properties for  job triggered from cloud.
 */
model EdgeDeviceJobReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * Validation status of job.
   */
  @visibility("read")
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility("read")
  deploymentStatus?: EceActionStatus;
}

/**
 * Edgedevice job for Azure Linux solution.
 */
model AzureLinuxEdgeDeviceJob extends EdgeDeviceJob {
  /**
   * Edgedevice job properties
   */
  properties: AzureLinuxEdgeDeviceJobProperties;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  kind: "AzureLinux";
}

/**
 * Represents the properties of an Azure Linux Remote Support job.
 */
model AzureLinuxRemoteSupportJobProperties
  extends AzureLinuxEdgeDeviceJobProperties {
  ...RemoteSupportJobProperties,

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: AzureLinuxEdgeDeviceJobType.RemoteSupport;
}

/**
 * Represents the reported properties of a remote support job.
 */
model RemoteSupportReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility("read")
  percentComplete?: int32;

  /**
   * Validation status of job.
   */
  @visibility("read")
  validationStatus?: EceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility("read")
  deploymentStatus?: EceActionStatus;

  /**
   * Optional settings for configuring the node for remote support.
   */
  nodeSettings?: RemoteSupportNodeSettings;

  /**
   * Details of the remote support session.
   */
  sessionDetails?: RemoteSupportSession;
}

/**
 * Represents the settings of a remote support node.
 */
model RemoteSupportNodeSettings {
  /**
   * The resource ID of the Azure Arc enabled server.
   */
  arcResourceId?: string;

  /**
   * The state of the remote support node.
   */
  state?: string;

  /**
   * The timestamp when the node settings were created, in UTC.
   */
  createdAt?: utcDateTime;

  /**
   * The timestamp when the node settings were last updated, in UTC.
   */
  updatedAt?: utcDateTime;

  /**
   * The current connection status of the remote support session.
   */
  connectionStatus?: string;

  /**
   * The error message, if any, from the last connection attempt.
   */
  connectionErrorMessage?: string;

  /**
   * The location where the session transcript is stored.
   */
  transcriptLocation?: string;
}

/**
 * Represents a remote support session.
 */
model RemoteSupportSession {
  /**
   * The start time of the remote support session, in UTC.
   */
  sessionStartTime?: utcDateTime;

  /**
   * The end time of the remote support session, in UTC.
   */
  sessionEndTime?: utcDateTime;

  /**
   * The name of the node for which the session was initiated.
   */
  nodeName?: string;

  /**
   * The duration of the session in minutes.
   */
  duration?: int32;

  /**
   * The level of access granted during the remote support session.
   */
  accessLevel?: RemoteSupportAccessLevel;
}

/**
 * Represents the properties of a log collection job.
 */
model CollectLogJobProperties {
  /**
   * From date for log collection.
   */
  fromDate: utcDateTime;

  /**
   * To date for log collection.
   */
  toDate: utcDateTime;

  /**
   * To date for log collection.
   */
  lastLogGenerated?: utcDateTime;

  /**
   * log collection job reported properties.
   */
  reportedProperties?: LogCollectionReportedProperties;
}

/**
 * Represents the properties of an HCI Collect Log job.
 */
model HciCollectLogJobProperties extends HciEdgeDeviceJobProperties {
  ...CollectLogJobProperties,

   /**
   * Job Type to support polymorphic resource.
   */
  jobType: HciEdgeDeviceJobType.CollectLog;
}

/**
 * HCI Edgedevice job properties
 */
@discriminator("jobType") 
@doc("HCI Edgedevice job properties")
model HciEdgeDeviceJobProperties {
  ...EdgeDeviceJobProperties,
  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: HciEdgeDeviceJobType
}

/**
 * Edgedevice job for Azure Stack HCI solution.
 */
model HciEdgeDeviceJob extends EdgeDeviceJob {
  /**
   * HCI Edgedevice job properties
   */
  properties: HciEdgeDeviceJobProperties;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  kind: "HCI";
}

/**
 * Represents the properties of a remote connect job for HCI.
 */
model HciRemoteConnectJobProperties extends HciEdgeDeviceJobProperties {
  /**
   * user name.
   */
  userName: string;

  /**
   * password.
   */
  @secret
  password: string;

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: HciEdgeDeviceJobType.RemoteConnect;
}

/**
 * Represents the properties of a remote support job for HCI.
 */
model HciRemoteSupportJobProperties extends HciEdgeDeviceJobProperties {
  ...RemoteSupportJobProperties,

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: HciEdgeDeviceJobType.RemoteSupport;
}

/**
 * Represents the properties of a remote support job.
 */
model RemoteSupportJobProperties {
  /**
   * Remote support access level.
   */
  accessLevel: RemoteSupportAccessLevel;

  /**
   * Remote support expiration timestamp.
   */
  expirationTimestamp: utcDateTime;

  /**
   * Remote support type.
   */
  type: RemoteSupportType;

  /**
   * log collection job reported properties.
   */
  reportedProperties?: RemoteSupportReportedProperties;
}
