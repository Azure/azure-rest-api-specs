import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.StorageMover;

/**
 * Represents arbitrary object properties preserved from resource snapshots.
 */
model ArbitraryProperties {
  ...Record<unknown>;
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * The provisioning state of a resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The Agent status.
 */
union AgentStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registering: "Registering",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Executing: "Executing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RequiresAttention: "RequiresAttention",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unregistering: "Unregistering",
}

/**
 * The minute element of the time. Allowed values are 0 and 30. If not specified, its value defaults to 0.
 */
union Minute {
  int32,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `0`: 0,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `30`: 30,
}

/**
 * The Endpoint resource type.
 */
union EndpointType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlobContainer: "AzureStorageBlobContainer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NfsMount: "NfsMount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageSmbFileShare: "AzureStorageSmbFileShare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SmbMount: "SmbMount",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_07_01)
  AzureMultiCloudConnector: "AzureMultiCloudConnector",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_07_01)
  AzureStorageNfsFileShare: "AzureStorageNfsFileShare",
}

/**
 * The type of the Job.
 */
@added(Versions.v2025_07_01)
union JobType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OnPremToCloud: "OnPremToCloud",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CloudToCloud: "CloudToCloud",
}

/**
 * Strategy to use for copy.
 */
union CopyMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Additive: "Additive",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Mirror: "Mirror",
}

/**
 * The current status of the Job Run in a non-terminal state, if exists.
 */
union JobRunStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Queued: "Queued",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Started: "Started",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CancelRequested: "CancelRequested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceling: "Canceling",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PausedByBandwidthManagement: "PausedByBandwidthManagement",
}

/**
 * The status of Agent's scanning of source.
 */
union JobRunScanStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotStarted: "NotStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Scanning: "Scanning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Completed: "Completed",
}

/**
 * The NFS protocol version.
 */
union NfsVersion {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NFSauto: "NFSauto",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NFSv3: "NFSv3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NFSv4: "NFSv4",
}

/**
 * The Credentials type.
 */
union CredentialType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureKeyVaultSmb: "AzureKeyVaultSmb",
}

/**
 * The day of week.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum DayOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * List of Storage Movers.
 */
model StorageMoverList is Azure.Core.Page<StorageMover>;

@@visibility(StorageMoverList.value, Lifecycle.Read);

/**
 * The resource specific properties for the Storage Mover resource.
 */
model StorageMoverProperties {
  /**
   * A description for the Storage Mover.
   */
  description?: string;

  /**
   * The provisioning state of this resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The Storage Mover resource.
 */
model StorageMoverUpdateParameters {
  /**
   * The resource specific properties for the Storage Mover resource.
   */
  properties?: StorageMoverUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * The resource specific properties for the Storage Mover resource.
 */
model StorageMoverUpdateProperties {
  /**
   * A description for the Storage Mover.
   */
  description?: string;
}

/**
 * List of Agents.
 */
model AgentList is Azure.Core.Page<Agent>;

@@visibility(AgentList.value, Lifecycle.Read);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgentProperties {
  /**
   * A description for the Agent.
   */
  description?: string;

  /**
   * The Agent version.
   */
  @visibility(Lifecycle.Read)
  agentVersion?: string;

  /**
   * The fully qualified resource ID of the Hybrid Compute resource for the Agent.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  arcResourceId: string;

  /**
   * The VM UUID of the Hybrid Compute resource for the Agent.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  arcVmUuid: string;

  /**
   * The Agent status.
   */
  @visibility(Lifecycle.Read)
  agentStatus?: AgentStatus;

  /**
   * The last updated time of the Agent status.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusUpdate?: utcDateTime;

  /**
   * Local IP address reported by the Agent.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  localIPAddress?: string;

  /**
   * Available memory reported by the Agent, in MB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  memoryInMB?: int64;

  /**
   * Available compute cores reported by the Agent.
   */
  @visibility(Lifecycle.Read)
  numberOfCores?: int64;

  /**
   * Uptime of the Agent in seconds.
   */
  @visibility(Lifecycle.Read)
  uptimeInSeconds?: int64;

  /**
   * The agent's local time zone represented in Windows format.
   */
  @visibility(Lifecycle.Read)
  timeZone?: string;

  /**
   * The WAN-link upload limit schedule that applies to any Job Run the agent executes. Data plane operations (migrating files) are affected. Control plane operations ensure seamless migration functionality and are not limited by this schedule. The schedule is interpreted with the agent's local time.
   */
  uploadLimitSchedule?: UploadLimitSchedule;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  errorDetails?: AgentPropertiesErrorDetails;

  /**
   * The provisioning state of this resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The WAN-link upload limit schedule. Overlapping recurrences are not allowed.
 */
model UploadLimitSchedule {
  /**
   * The set of weekly repeating recurrences of the WAN-link upload limit schedule.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  weeklyRecurrences?: UploadLimitWeeklyRecurrence[];
}

/**
 * The weekly recurrence of the WAN-link upload limit schedule. The start time must be earlier in the day than the end time. The recurrence must not span across multiple days.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UploadLimitWeeklyRecurrence extends WeeklyRecurrence {
  ...UploadLimit;
}

/**
 * The weekly recurrence of the schedule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model WeeklyRecurrence extends Recurrence {
  /**
   * The set of days of week for the schedule recurrence. A day must not be specified more than once in a recurrence.
   */
  days: DayOfWeek[];
}

/**
 * The schedule recurrence.
 */
model Recurrence {
  /**
   * The start time of the schedule recurrence. Full hour and 30-minute intervals are supported.
   */
  startTime: Time;

  /**
   * The end time of the schedule recurrence. Full hour and 30-minute intervals are supported.
   */
  endTime: Time;
}

/**
 * The time of day.
 */
model Time {
  /**
   * The hour element of the time. Allowed values range from 0 (start of the selected day) to 24 (end of the selected day). Hour value 24 cannot be combined with any other minute value but 0.
   */
  @minValue(0)
  @maxValue(24)
  hour: int32;

  /**
   * The minute element of the time. Allowed values are 0 and 30. If not specified, its value defaults to 0.
   */
  minute?: Minute = 0;
}

/**
 * The WAN-link upload limit.
 */
model UploadLimit {
  /**
   * The WAN-link upload bandwidth (maximum data transfer rate) in megabits per second. Value of 0 indicates no throughput is allowed and any running migration job is effectively paused for the duration of this recurrence. Only data plane operations are governed by this limit. Control plane operations ensure seamless functionality. The agent may exceed this limit with control messages, if necessary.
   */
  @maxValue(2147483647)
  limitInMbps: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgentPropertiesErrorDetails {
  /**
   * Error code reported by Agent
   */
  code?: string;

  /**
   * Expanded description of reported error code
   */
  message?: string;
}

/**
 * The Agent resource.
 */
model AgentUpdateParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: AgentUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AgentUpdateProperties {
  /**
   * A description for the Agent.
   */
  description?: string;

  /**
   * The WAN-link upload limit schedule that applies to any Job Run the agent executes. Data plane operations (migrating files) are affected. Control plane operations ensure seamless migration functionality and are not limited by this schedule. The schedule is interpreted with the agent's local time.
   */
  uploadLimitSchedule?: UploadLimitSchedule;
}

/**
 * List of Endpoints.
 */
model EndpointList is Azure.Core.Page<Endpoint>;

@@visibility(EndpointList.value, Lifecycle.Read);

/**
 * The resource specific properties for the Storage Mover resource.
 */
@discriminator("endpointType")
model EndpointBaseProperties {
  /**
   * The Endpoint resource type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpointType: EndpointType;

  /**
   * A description for the Endpoint.
   */
  description?: string;

  /**
   * The provisioning state of this resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The Endpoint resource.
 */
model EndpointBaseUpdateParameters {
  /**
   * The Endpoint resource, which contains information about file sources and targets.
   */
  properties?: EndpointBaseUpdateProperties;

  /**
   * The managed system identity assigned to this resource.
   */
  @added(Versions.v2025_07_01)
  identity?: Foundations.ManagedServiceIdentity;
}

/**
 * The Endpoint resource, which contains information about file sources and targets.
 */
@discriminator("endpointType")
model EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  endpointType: EndpointType;

  /**
   * A description for the Endpoint.
   */
  description?: string;
}

/**
 * List of Project resources.
 */
model ProjectList is Azure.Core.Page<Project>;

@@visibility(ProjectList.value, Lifecycle.Read);

/**
 * Project properties.
 */
model ProjectProperties {
  /**
   * A description for the Project.
   */
  description?: string;

  /**
   * The provisioning state of this resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The Project resource.
 */
model ProjectUpdateParameters {
  /**
   * Project properties.
   */
  properties?: ProjectUpdateProperties;
}

/**
 * Project properties.
 */
model ProjectUpdateProperties {
  /**
   * A description for the Project.
   */
  description?: string;
}

/**
 * List of Job Definitions.
 */
model JobDefinitionList is Azure.Core.Page<JobDefinition>;

@@visibility(JobDefinitionList.value, Lifecycle.Read);

/**
 * Job definition properties.
 */
model JobDefinitionProperties {
  /**
   * A description for the Job Definition. OnPremToCloud is for migrating data from on-premises to cloud. CloudToCloud is for migrating data between cloud to cloud.
   */
  description?: string;

  /**
   * The type of the Job.
   */
  @added(Versions.v2025_07_01)
  jobType?: JobType = JobType.OnPremToCloud;

  /**
   * Strategy to use for copy.
   */
  copyMode: CopyMode;

  /**
   * The name of the source Endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceName: string;

  /**
   * Fully qualified resource ID of the source Endpoint.
   */
  @visibility(Lifecycle.Read)
  sourceResourceId?: string;

  /**
   * The subpath to use when reading from the source Endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceSubpath?: string;

  /**
   * The name of the target Endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetName: string;

  /**
   * Fully qualified resource ID of the target Endpoint.
   */
  @visibility(Lifecycle.Read)
  targetResourceId?: string;

  /**
   * The subpath to use when writing to the target Endpoint.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetSubpath?: string;

  /**
   * The name of the Job Run in a non-terminal state, if exists.
   */
  @visibility(Lifecycle.Read)
  latestJobRunName?: string;

  /**
   * The fully qualified resource ID of the Job Run in a non-terminal state, if exists.
   */
  @visibility(Lifecycle.Read)
  latestJobRunResourceId?: string;

  /**
   * The current status of the Job Run in a non-terminal state, if exists.
   */
  @visibility(Lifecycle.Read)
  latestJobRunStatus?: JobRunStatus;

  /**
   * Name of the Agent to assign for new Job Runs of this Job Definition.
   */
  agentName?: string;

  /**
   * Fully qualified resource id of the Agent to assign for new Job Runs of this Job Definition.
   */
  @visibility(Lifecycle.Read)
  agentResourceId?: string;

  /**
   * The list of cloud endpoints to migrate.
   */
  @added(Versions.v2025_07_01)
  sourceTargetMap?: {
    @visibility(Lifecycle.Read)
    @added(Versions.v2025_07_01)
    @OpenAPI.extension("x-ms-identifiers", #[])
    value?: SourceTargetMap[];
  };

  /**
   * The provisioning state of this resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of cloud endpoints to migrate.
 */
@added(Versions.v2025_07_01)
model SourceTargetMap {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_07_01)
  sourceEndpoint: SourceEndpoint;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_07_01)
  targetEndpoint: TargetEndpoint;
}

/**
 * The source endpoint resource for source and target mapping.
 */
@added(Versions.v2025_07_01)
model SourceEndpoint {
  /**
   * The properties of the cloud source endpoint to migrate.
   */
  properties?: SourceEndpointProperties;
}

/**
 * The properties of the cloud source endpoint to migrate.
 */
@added(Versions.v2025_07_01)
model SourceEndpointProperties {
  /**
   * The name of the cloud source endpoint to migrate.
   */
  name?: string;

  /**
   * The fully qualified ARM resource ID of the cloud source endpoint to migrate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sourceEndpointResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.StorageMover/storageMovers/endpoints";
    }
  ]>;

  /**
   * The fully qualified ARM resource ID of the AWS S3 bucket to migrate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  awsS3BucketId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.StorageMover/storageMovers/endpoints";
    }
  ]>;
}

/**
 * The target endpoint resource for source and target mapping.
 */
@added(Versions.v2025_07_01)
model TargetEndpoint {
  /**
   * The properties of the cloud target endpoint to migrate.
   */
  properties?: TargetEndpointProperties;
}

/**
 * The properties of the cloud target endpoint to migrate.
 */
@added(Versions.v2025_07_01)
model TargetEndpointProperties {
  /**
   * The name of the cloud target endpoint to migrate.
   */
  name?: string;

  /**
   * The fully qualified ARM resource ID of the cloud target endpoint to migrate.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  targetEndpointResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.StorageMover/storageMovers/endpoints";
    }
  ]>;

  /**
   * The fully qualified ARM resource ID of the Azure Storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureStorageAccountResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The name of the Azure Storage blob container.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureStorageBlobContainerName?: string;
}

/**
 * The Job Definition resource.
 */
model JobDefinitionUpdateParameters {
  /**
   * Job definition properties.
   */
  properties?: JobDefinitionUpdateProperties;
}

/**
 * Job definition properties.
 */
model JobDefinitionUpdateProperties {
  /**
   * A description for the Job Definition.
   */
  description?: string;

  /**
   * Strategy to use for copy.
   */
  copyMode?: CopyMode;

  /**
   * Name of the Agent to assign for new Job Runs of this Job Definition.
   */
  agentName?: string;
}

/**
 * Response that identifies a Job Run.
 */
model JobRunResourceId {
  /**
   * Fully qualified resource id of the Job Run.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  jobRunResourceId?: string;
}

/**
 * List of Job Runs.
 */
model JobRunList is Azure.Core.Page<JobRun>;

@@visibility(JobRunList.value, Lifecycle.Read);

/**
 * Job run properties.
 */
model JobRunProperties {
  /**
   * The state of the job execution.
   */
  @visibility(Lifecycle.Read)
  status?: JobRunStatus;

  /**
   * The status of Agent's scanning of source.
   */
  @visibility(Lifecycle.Read)
  scanStatus?: JobRunScanStatus;

  /**
   * Name of the Agent assigned to this run.
   */
  @visibility(Lifecycle.Read)
  agentName?: string;

  /**
   * Fully qualified resource id of the Agent assigned to this run.
   */
  @visibility(Lifecycle.Read)
  agentResourceId?: string;

  /**
   * Start time of the run. Null if no Agent reported that the job has started.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionStartTime?: utcDateTime;

  /**
   * End time of the run. Null if Agent has not reported that the job has ended.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  executionEndTime?: utcDateTime;

  /**
   * The last updated time of the Job Run.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusUpdate?: utcDateTime;

  /**
   * Number of items scanned so far in source.
   */
  @visibility(Lifecycle.Read)
  itemsScanned?: int64;

  /**
   * Number of items that will not be transferred, as they are excluded by user configuration.
   */
  @visibility(Lifecycle.Read)
  itemsExcluded?: int64;

  /**
   * Number of items that will not be transferred, as they are unsupported on target.
   */
  @visibility(Lifecycle.Read)
  itemsUnsupported?: int64;

  /**
   * Number of items that will not be transferred, as they are already found on target (e.g. mirror mode).
   */
  @visibility(Lifecycle.Read)
  itemsNoTransferNeeded?: int64;

  /**
   * Number of items that were attempted to transfer and failed.
   */
  @visibility(Lifecycle.Read)
  itemsFailed?: int64;

  /**
   * Number of items successfully transferred to target.
   */
  @visibility(Lifecycle.Read)
  itemsTransferred?: int64;

  /**
   * Bytes of data scanned so far in source.
   */
  @visibility(Lifecycle.Read)
  bytesScanned?: int64;

  /**
   * Bytes of data that will not be transferred, as they are excluded by user configuration.
   */
  @visibility(Lifecycle.Read)
  bytesExcluded?: int64;

  /**
   * Bytes of data that will not be transferred, as they are unsupported on target.
   */
  @visibility(Lifecycle.Read)
  bytesUnsupported?: int64;

  /**
   * Bytes of data that will not be transferred, as they are already found on target (e.g. mirror mode).
   */
  @visibility(Lifecycle.Read)
  bytesNoTransferNeeded?: int64;

  /**
   * Bytes of data that were attempted to transfer and failed.
   */
  @visibility(Lifecycle.Read)
  bytesFailed?: int64;

  /**
   * Bytes of data successfully transferred to target.
   */
  @visibility(Lifecycle.Read)
  bytesTransferred?: int64;

  /**
   * Name of source Endpoint resource. This resource may no longer exist.
   */
  @visibility(Lifecycle.Read)
  sourceName?: string;

  /**
   * Fully qualified resource id of source Endpoint. This id may no longer exist.
   */
  @visibility(Lifecycle.Read)
  sourceResourceId?: string;

  /**
   * Copy of source Endpoint resource's properties at time of Job Run creation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sourceProperties?: unknown;

  /**
   * Name of target Endpoint resource. This resource may no longer exist.
   */
  @visibility(Lifecycle.Read)
  targetName?: string;

  /**
   * Fully qualified resource id of of Endpoint. This id may no longer exist.
   */
  @visibility(Lifecycle.Read)
  targetResourceId?: string;

  /**
   * Copy of Endpoint resource's properties at time of Job Run creation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  targetProperties?: unknown;

  /**
   * Copy of parent Job Definition's properties at time of Job Run creation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  jobDefinitionProperties?: unknown;

  /**
   * Error details.
   */
  @visibility(Lifecycle.Read)
  error?: JobRunError;

  /**
   * The provisioning state of this resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Error type
 */
model JobRunError {
  /**
   * Error code of the given entry.
   */
  code?: string;

  /**
   * Error message of the given entry.
   */
  message?: string;

  /**
   * Target of the given error entry.
   */
  target?: string;
}

/**
 * The properties of Azure Storage blob container endpoint.
 */
model AzureStorageBlobContainerEndpointProperties
  extends EndpointBaseProperties {
  /**
   * The Azure Resource ID of the storage account that is the target destination.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageAccountResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The name of the Storage blob container that is the target destination.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  blobContainerName: string;

  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageBlobContainer";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureStorageBlobContainerEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageBlobContainer";
}

/**
 * The properties of NFS share endpoint.
 */
model NfsMountEndpointProperties extends EndpointBaseProperties {
  /**
   * The host name or IP address of the server exporting the file system.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  host: string;

  /**
   * The NFS protocol version.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  nfsVersion?: NfsVersion;

  /**
   * The directory being exported from the server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  export: string;

  /**
   * The Endpoint resource type.
   */
  endpointType: "NfsMount";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model NfsMountEndpointUpdateProperties extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "NfsMount";
}

/**
 * The properties of Azure Storage SMB file share endpoint.
 */
model AzureStorageSmbFileShareEndpointProperties
  extends EndpointBaseProperties {
  /**
   * The Azure Resource ID of the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageAccountResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The name of the Azure Storage file share.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fileShareName: string;

  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageSmbFileShare";
}

/**
 * The properties of Azure Storage SMB file share endpoint to update.
 */
model AzureStorageSmbFileShareEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageSmbFileShare";
}

/**
 * The properties of SMB share endpoint.
 */
model SmbMountEndpointProperties extends EndpointBaseProperties {
  /**
   * The host name or IP address of the server exporting the file system.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  host: string;

  /**
   * The name of the SMB share being exported from the server.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  shareName: string;

  /**
   * The Azure Key Vault secret URIs which store the required credentials to access the SMB share.
   */
  credentials?: AzureKeyVaultSmbCredentials;

  /**
   * The Endpoint resource type.
   */
  endpointType: "SmbMount";
}

/**
 * The properties of Azure Storage NFS file share endpoint.
 */
@added(Versions.v2025_07_01)
model AzureStorageNfsFileShareEndpointProperties
  extends EndpointBaseProperties {
  /**
   * The Azure Resource ID of the storage account.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageAccountResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  /**
   * The name of the Azure Storage NFS file share.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fileShareName: string;

  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageNfsFileShare";
}

/**
 * The properties of Azure Storage NFS file share endpoint to update.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
model AzureStorageNfsFileShareEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureStorageNfsFileShare";
}

/**
 * The properties of Azure MultiCloudConnector endpoint.
 */
@added(Versions.v2025_07_01)
model AzureMultiCloudConnectorEndpointProperties
  extends EndpointBaseProperties {
  /**
   * The Azure Resource ID of the MultiCloud Connector resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  multiCloudConnectorId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridConnectivity/publicCloudConnectors";
    }
  ]>;

  /**
   * The AWS S3 bucket ARM resource Id.
   */
  awsS3BucketId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AwsConnector/s3Buckets";
    }
  ]>;

  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureMultiCloudConnector";
}

/**
 * The properties of Azure Storage NFS file share endpoint to update.
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@added(Versions.v2025_07_01)
model AzureMultiCloudConnectorEndpointUpdateProperties
  extends EndpointBaseUpdateProperties {
  /**
   * The Endpoint resource type.
   */
  endpointType: "AzureMultiCloudConnector";
}

/**
 * The Azure Key Vault secret URIs which store the credentials.
 */
model AzureKeyVaultSmbCredentials extends Credentials {
  /**
   * The Azure Key Vault secret URI which stores the username. Use empty string to clean-up existing value.
   */
  usernameUri?: string;

  /**
   * The Azure Key Vault secret URI which stores the password. Use empty string to clean-up existing value.
   */
  passwordUri?: string;

  /**
   * The Credentials type.
   */
  type: "AzureKeyVaultSmb";
}

/**
 * The Credentials.
 */
@discriminator("type")
model Credentials {
  /**
   * The Credentials type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  type: CredentialType;
}

/**
 * The properties of SMB share endpoint to update.
 */
model SmbMountEndpointUpdateProperties extends EndpointBaseUpdateProperties {
  /**
   * The Azure Key Vault secret URIs which store the required credentials to access the SMB share.
   */
  credentials?: AzureKeyVaultSmbCredentials;

  /**
   * The Endpoint resource type.
   */
  endpointType: "SmbMount";
}
