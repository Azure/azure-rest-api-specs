import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;
/**
 * EdgeDevice Jobs resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "for backward compatibility, provisioningState is defined in EdgeDeviceProperties"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "for backward compatibility, properties is defined as empty model here"
@parentResource(EdgeDevice)
model EdgeDeviceJob is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDeviceJob,
    KeyName = "jobsName",
    SegmentName = "jobs"
  >;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: EdgeDeviceKind;
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Follow existing naming for backward compatibility"
  CreateOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeDeviceJob>;

  /**
   * Delete a EdgeDeviceJob
   */
  delete is ArmResourceDeleteWithoutOkAsync<EdgeDeviceJob>;

  /**
   * List EdgeDeviceJob resources by EdgeDevice
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Follow existing naming for backward compatibility"
  listByEdgeDevice is ArmResourceListByParent<EdgeDeviceJob>;
}

@@doc(EdgeDeviceJob.name, "Name of EdgeDevice Job");
@@doc(EdgeDeviceJob.properties,
  "The resource-specific properties for this resource."
);

// Models

/**
 * Validation / deployment status details for Job.
 */
model EdgeDeviceJobsEceActionStatus {
  /**
   * Job status.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * List of steps of Edge device job.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: EdgeDeviceJobsStep[];
}

/**
 * Step details during job execution.
 */
model EdgeDeviceJobsStep {
  /**
   * Name of step.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Description of step.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * FullStepIndex of step.
   */
  @visibility(Lifecycle.Read)
  fullStepIndex?: string;

  /**
   * Start time in utc of step.
   */
  @visibility(Lifecycle.Read)
  startTimeUtc?: string;

  /**
   * End time in utc of step.
   */
  @visibility(Lifecycle.Read)
  endTimeUtc?: string;

  /**
   * Status of step. Allowed values are 'Error', 'Success', 'InProgress'
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * List of nested steps during job execution..
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  steps?: EdgeDeviceJobsStep[];

  /**
   * List of exceptions in job execution.
   */
  @visibility(Lifecycle.Read)
  exception?: string[];
}

/**
 * Represents a session for collecting logs from an edge device.
 */
model EdgeDeviceJobsLogCollectionSession {
  /**
   * The timestamp when log collection started, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The timestamp when log collection ended, in ISO 8601 format.
   */
  @visibility(Lifecycle.Read)
  endTime?: string;

  /**
   * The total time logs were collected for, in ISO 8601 duration format.
   */
  @visibility(Lifecycle.Read)
  timeCollected?: string;

  /**
   * The size of the collected logs in bytes.
   */
  @visibility(Lifecycle.Read)
  logSize?: int32;

  /**
   * The status of the log collection session.
   */
  @visibility(Lifecycle.Read)
  status?: DeviceLogCollectionStatus;

  /**
   * A unique identifier for correlating this log collection session with other operations or sessions.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;
}

/**
 * Represents the reported properties of a remote support job.
 */
model RemoteSupportJobReportedProperties {
  /**
   * The percentage of the job that is complete.
   */
  @visibility(Lifecycle.Read)
  percentComplete?: int32;

  /**
   * Validation status of job.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: EdgeDeviceJobsEceActionStatus;

  /**
   * Deployment status of job.
   */
  @visibility(Lifecycle.Read)
  deploymentStatus?: EdgeDeviceJobsEceActionStatus;

  /**
   * Optional settings for configuring the node for remote support.
   */
  @visibility(Lifecycle.Read)
  nodeSettings?: EdgeDeviceJobsRemoteSupportNodeSettings;

  /**
   * Details of the remote support session.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["sessionId"])
  sessionDetails?: RemoteSupportSession[];
}

/**
 * Represents the settings of a remote support node.
 */
model EdgeDeviceJobsRemoteSupportNodeSettings {
  /**
   * The state of the remote support node.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The timestamp when the node settings were created, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The timestamp when the node settings were last updated, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * The current connection status of the remote support session.
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  /**
   * The error message, if any, from the last connection attempt.
   */
  @visibility(Lifecycle.Read)
  connectionErrorMessage?: string;
}

/**
 * Represents a remote support session.
 */
model RemoteSupportSession {
  /**
   * Unique session Id.
   */
  @visibility(Lifecycle.Read)
  sessionId?: string;

  /**
   * The start time of the remote support session, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionStartTime?: utcDateTime;

  /**
   * The end time of the remote support session, in UTC.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionEndTime?: utcDateTime;

  /**
   * The level of access granted during the remote support session.
   */
  @visibility(Lifecycle.Read)
  accessLevel?: RemoteSupportAccessLevel;

  /**
   * The location where the session transcript is stored.
   */
  @visibility(Lifecycle.Read)
  transcriptLocation?: string;
}

/**
 * Represents the properties of a log collection job.
 */
model CollectLogJobProperties {
  /**
   * From date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate: utcDateTime;

  /**
   * To date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate: utcDateTime;

  /**
   * To date for log collection.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogGenerated?: utcDateTime;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: LogCollectionReportedProperties;
}

/**
 * Edge device job properties
 */
model EdgeDeviceJobProperties {
  /**
   * Deployment mode to trigger job.
   */
  deploymentMode?: DeploymentMode;

  /**
   * Job provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique, immutable job id.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Status of Edge device job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;
}

/**
 * Represents the properties of an HCI Collect Log job.
 */
model HciCollectLogJobProperties extends HciEdgeDeviceJobProperties {
  /**
   * From date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate: utcDateTime;

  /**
   * To date for log collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate: utcDateTime;

  /**
   * To date for log collection.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogGenerated?: utcDateTime;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: LogCollectionReportedProperties;

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: "CollectLog";
}

/**
 * HCI Edge device job properties
 */
@discriminator("jobType")
model HciEdgeDeviceJobProperties {
  /**
   * Deployment mode to trigger job.
   */
  deploymentMode?: DeploymentMode;

  /**
   * Job provisioning state
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Unique, immutable job id.
   */
  @visibility(Lifecycle.Read)
  jobId?: string;

  /**
   * The UTC date and time at which the job started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTimeUtc?: utcDateTime;

  /**
   * The UTC date and time at which the job completed.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeUtc?: utcDateTime;

  /**
   * Status of Edge device job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  /**
   * Job Type to support polymorphic resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  jobType: HciEdgeDeviceJobType;
}

/**
 * Edge device job for Azure Stack HCI solution.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Backward Compatibility"
model HciEdgeDeviceJob extends EdgeDeviceJob {
  /**
   * HCI Edge device job properties
   */
  properties: HciEdgeDeviceJobProperties;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  kind: "HCI";
}

/**
 * Represents the properties of a remote support job for HCI.
 */
model HciRemoteSupportJobProperties extends HciEdgeDeviceJobProperties {
  /**
   * Remote support access level.
   */
  accessLevel: RemoteSupportAccessLevel;

  /**
   * Remote support expiration timestamp.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimestamp: utcDateTime;

  /**
   * Remote support type.
   */
  type: RemoteSupportType;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: RemoteSupportJobReportedProperties;

  /**
   * Job Type to support polymorphic resource.
   */
  jobType: "RemoteSupport";
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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimestamp: utcDateTime;

  /**
   * Remote support type.
   */
  type: RemoteSupportType;

  /**
   * log collection job reported properties.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: RemoteSupportJobReportedProperties;
}
