import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.ContainerRegistry;

/**
 * The OS of agent machine
 */
union OS {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Linux: "Linux",
}

/**
 * The provisioning state of this agent pool
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The type of identity that last modified the resource.
 */
union LastModifiedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The current status of the run.
 */
union RunStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Queued: "Queued",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Started: "Started",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Timeout: "Timeout",
}

/**
 * The type of run.
 */
union RunType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QuickBuild: "QuickBuild",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QuickRun: "QuickRun",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutoBuild: "AutoBuild",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutoRun: "AutoRun",
}

/**
 * The OS architecture.
 */
union Architecture {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  amd64: "amd64",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  x86: "x86",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `386`: "386",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  arm: "arm",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  arm64: "arm64",
}

/**
 * Variant of the CPU.
 */
union Variant {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  v6: "v6",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  v7: "v7",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  v8: "v8",
}

/**
 * The current status of task.
 */
union TaskStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * The type of the step.
 */
union StepType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Docker: "Docker",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FileTask: "FileTask",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EncodedTask: "EncodedTask",
}

/**
 * The type of the base image dependency.
 */
union BaseImageDependencyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BuildTime: "BuildTime",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RunTime: "RunTime",
}

/**
 * The current status of trigger.
 */
union TriggerStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * The type of source control service.
 */
union SourceControlType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Github: "Github",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VisualStudioTeamService: "VisualStudioTeamService",
}

/**
 * The type of Auth token.
 */
union TokenType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PAT: "PAT",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OAuth: "OAuth",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union SourceTriggerEvent {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  commit: "commit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  pullrequest: "pullrequest",
}

/**
 * The type of the auto trigger for base image dependency updates.
 */
union BaseImageTriggerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  All: "All",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Runtime: "Runtime",
}

/**
 * Type of Payload body for Base image update triggers.
 */
union UpdateTriggerPayloadType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Token: "Token",
}

/**
 * The authentication mode which determines the source registry login scope. The credentials for the source registry
 * will be generated using the given scope. These credentials will be used to login to
 * the source registry during the run.
 */
union SourceRegistryLoginMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
}

/**
 * The type of the secret object which determines how the value of the secret object has to be
 * interpreted.
 */
union SecretObjectType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Opaque: "Opaque",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Vaultsecret: "Vaultsecret",
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The properties of agent pool.
 */
model AgentPoolProperties {
  /**
   * The count of agent machine
   */
  count?: int32;

  /**
   * The Tier of agent machine
   */
  tier?: string;

  /**
   * The OS of agent machine
   */
  os?: OS;

  /**
   * The Virtual Network Subnet Resource Id of the agent machine
   */
  virtualNetworkSubnetResourceId?: string;

  /**
   * The provisioning state of this agent pool
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * The resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource. This cannot be changed after the resource is created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: CreatedByType;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: LastModifiedByType;

  /**
   * The timestamp of resource modification (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * The parameters for updating an agent pool.
 */
model AgentPoolUpdateParameters {
  /**
   * The properties associated with the agent pool
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: AgentPoolPropertiesUpdateParameters;

  /**
   * The ARM resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AgentPoolPropertiesUpdateParameters {
  /**
   * The count of agent machine
   */
  count?: int32;
}

/**
 * The QueueStatus of Agent Pool
 */
model AgentPoolQueueStatus {
  /**
   * The number of pending runs in the queue
   */
  count?: int32;
}

/**
 * The collection of agent pools.
 */
model AgentPoolListResult {
  /**
   * The collection value.
   */
  @pageItems
  value?: AgentPool[];

  /**
   * The URI that can be used to request the next set of paged results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The collection of runs.
 */
model RunListResult {
  /**
   * The collection value.
   */
  @pageItems
  value?: Run[];

  /**
   * The URI that can be used to request the next set of paged results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The collection of tasks.
 */
model TaskListResult {
  /**
   * The collection value.
   */
  @pageItems
  value?: Task[];

  /**
   * The URI that can be used to request the next set of paged results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The collection of task runs.
 */
model TaskRunListResult {
  /**
   * The collection value.
   */
  @pageItems
  value?: TaskRun[];

  /**
   * The URI that can be used to request the next set of paged results.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The request parameters for scheduling a run.
 */
@discriminator("type")
model RunRequest {
  /**
   * The type of the run request.
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  type: string;

  /**
   * The value that indicates whether archiving is enabled for the run or not.
   */
  isArchiveEnabled?: boolean = false;

  /**
   * The dedicated agent pool for the run.
   */
  agentPoolName?: string;

  /**
   * The template that describes the repository and tag information for run log artifact.
   */
  logTemplate?: string;
}

/**
 * The properties for a run.
 */
model RunProperties {
  /**
   * The unique identifier for the run.
   */
  runId?: string;

  /**
   * The current status of the run.
   */
  status?: RunStatus;

  /**
   * The last updated time for the run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The type of run.
   */
  runType?: RunType;

  /**
   * The dedicated agent pool for the run.
   */
  agentPoolName?: string;

  /**
   * The time the run was scheduled.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The time the run started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time the run finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
   * The list of all images that were generated from the run. This is applicable if the run generates base image dependencies.
   */
  @identifiers(#["registry"])
  outputImages?: ImageDescriptor[];

  /**
   * The task against which run was scheduled.
   */
  task?: string;

  /**
   * The image update trigger that caused the run. This is applicable if the task has base image trigger configured.
   */
  imageUpdateTrigger?: ImageUpdateTrigger;

  /**
   * The source trigger that caused the run.
   */
  sourceTrigger?: SourceTriggerDescriptor;

  /**
   * The timer trigger that caused the run.
   */
  timerTrigger?: TimerTriggerDescriptor;

  /**
   * The platform properties against which the run will happen.
   */
  platform?: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The scope of the credentials that were used to login to the source registry during this run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  sourceRegistryAuth?: string;

  /**
   * The list of custom registries that were logged in during this run.
   */
  customRegistries?: string[];

  /**
   * The error message received from backend systems after the run is scheduled.
   */
  @visibility(Lifecycle.Read)
  runErrorMessage?: string;

  /**
   * The update trigger token passed for the Run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  updateTriggerToken?: string;

  /**
   * The image description for the log artifact.
   */
  @visibility(Lifecycle.Read)
  logArtifact?: ImageDescriptor;

  /**
   * The provisioning state of a run.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: ProvisioningState;

  /**
   * The value that indicates whether archiving is enabled or not.
   */
  isArchiveEnabled?: boolean = false;
}

/**
 * Properties for a registry image.
 */
model ImageDescriptor {
  /**
   * The registry login server.
   */
  registry?: string;

  /**
   * The repository name.
   */
  repository?: string;

  /**
   * The tag name.
   */
  tag?: string;

  /**
   * The sha256-based digest of the image manifest.
   */
  digest?: string;
}

/**
 * The image update trigger that caused a build.
 */
model ImageUpdateTrigger {
  /**
   * The unique ID of the trigger.
   */
  id?: string;

  /**
   * The timestamp when the image update happened.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The list of image updates that caused the build.
   */
  @identifiers(#["registry"])
  images?: ImageDescriptor[];
}

/**
 * The source trigger that caused a run.
 */
model SourceTriggerDescriptor {
  /**
   * The unique ID of the trigger.
   */
  id?: string;

  /**
   * The event type of the trigger.
   */
  eventType?: string;

  /**
   * The unique ID that identifies a commit.
   */
  commitId?: string;

  /**
   * The unique ID that identifies pull request.
   */
  pullRequestId?: string;

  /**
   * The repository URL.
   */
  repositoryUrl?: string;

  /**
   * The branch name in the repository.
   */
  branchName?: string;

  /**
   * The source control provider type.
   */
  providerType?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TimerTriggerDescriptor {
  /**
   * The timer trigger name that caused the run.
   */
  timerTriggerName?: string;

  /**
   * The occurrence that triggered the run.
   */
  scheduleOccurrence?: string;
}

/**
 * The platform properties against which the run has to happen.
 */
model PlatformProperties {
  /**
   * The operating system type required for the run.
   */
  os: OS;

  /**
   * The OS architecture.
   */
  architecture?: Architecture;

  /**
   * Variant of the CPU.
   */
  variant?: Variant;
}

/**
 * The properties that determine the run agent configuration.
 */
model AgentProperties {
  /**
   * The CPU configuration in terms of number of cores required for the run.
   */
  cpu?: int32;
}

/**
 * The resource model definition for a ARM proxy resource. It will have everything other than required location and tags.
 */
model ProxyResource {
  /**
   * The resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The properties of a response to source upload request.
 */
model SourceUploadDefinition {
  /**
   * The URL where the client can upload the source.
   */
  uploadUrl?: string;

  /**
   * The relative path to the source. This is used to submit the subsequent queue build request.
   */
  relativePath?: string;
}

/**
 * The set of run properties that can be updated.
 */
model RunUpdateParameters {
  /**
   * The value that indicates whether archiving is enabled or not.
   */
  isArchiveEnabled?: boolean;
}

/**
 * The result of get log link operation.
 */
model RunGetLogResult {
  /**
   * The link to logs for a run on a azure container registry.
   */
  logLink?: string;

  /**
   * The link to logs in registry for a run on a azure container registry.
   */
  logArtifactLink?: string;
}

/**
 * Managed identity for the resource.
 */
model IdentityProperties {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity
   * dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/
   *     providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserIdentityProperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The properties of task run.
 */
model TaskRunProperties {
  /**
   * The provisioning state of this task run
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The request (parameters) for the run
   */
  runRequest?: RunRequest;

  /**
   * The result of this task run
   */
  @visibility(Lifecycle.Read)
  runResult?: Run;

  /**
   * How the run should be forced to rerun even if the run request configuration has not changed
   */
  forceUpdateTag?: string;
}

/**
 * The parameters for updating a task run.
 */
model TaskRunUpdateParameters {
  /**
   * Identity for the resource.
   */
  identity?: IdentityProperties;

  /**
   * The properties for updating a task run.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: TaskRunPropertiesUpdateParameters;

  /**
   * The location of the resource
   */
  location?: string;

  /**
   * The ARM resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The properties of a task run update parameters.
 */
model TaskRunPropertiesUpdateParameters {
  /**
   * The request (parameters) for the new run
   */
  runRequest?: RunRequest;

  /**
   * How the run should be forced to rerun even if the run request configuration has not changed
   */
  forceUpdateTag?: string;
}

/**
 * The properties of a task.
 */
model TaskProperties {
  /**
   * The provisioning state of the task.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The creation date of task.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The current status of task.
   */
  status?: TaskStatus;

  /**
   * The platform properties against which the run has to happen.
   */
  platform?: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The dedicated agent pool for the task.
   */
  agentPoolName?: string;

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The properties of a task step.
   */
  step?: TaskStepProperties;

  /**
   * The properties that describe all triggers for the task.
   */
  trigger?: TriggerProperties;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The template that describes the repository and tag information for run log artifact.
   */
  logTemplate?: string;

  /**
   * The value of this property indicates whether the task resource is system task or not.
   */
  isSystemTask?: boolean = false;
}

/**
 * Base properties for any task step.
 */
@discriminator("type")
model TaskStepProperties {
  /**
   * The type of the step.
   */
  type: StepType;

  /**
   * List of base image dependencies for a step.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  baseImageDependencies?: BaseImageDependency[];

  /**
   * The URL(absolute or relative) of the source context for the task step.
   */
  contextPath?: string;

  /**
   * The token (git PAT or SAS token of storage account blob) associated with the context for a step.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  contextAccessToken?: string;
}

/**
 * Properties that describe a base image dependency.
 */
model BaseImageDependency {
  /**
   * The type of the base image dependency.
   */
  type?: BaseImageDependencyType;

  /**
   * The registry login server.
   */
  registry?: string;

  /**
   * The repository name.
   */
  repository?: string;

  /**
   * The tag name.
   */
  tag?: string;

  /**
   * The sha256-based digest of the image manifest.
   */
  digest?: string;
}

/**
 * The properties of a trigger.
 */
model TriggerProperties {
  /**
   * The collection of timer triggers.
   */
  @identifiers(#["name"])
  timerTriggers?: TimerTrigger[];

  /**
   * The collection of triggers based on source code repository.
   */
  @identifiers(#["name", "sourceRepository/repositoryUrl"])
  sourceTriggers?: SourceTrigger[];

  /**
   * The trigger based on base image dependencies.
   */
  baseImageTrigger?: BaseImageTrigger;
}

/**
 * The properties of a timer trigger.
 */
model TimerTrigger {
  /**
   * The CRON expression for the task schedule
   */
  schedule: string;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus = TriggerStatus.Enabled;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties of a source based trigger.
 */
model SourceTrigger {
  /**
   * The properties that describes the source(code) for the task.
   */
  sourceRepository: SourceProperties;

  /**
   * The source event corresponding to the trigger.
   */
  sourceTriggerEvents: SourceTriggerEvent[];

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus = TriggerStatus.Enabled;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties of the source code repository.
 */
model SourceProperties {
  /**
   * The type of source control service.
   */
  sourceControlType: SourceControlType;

  /**
   * The full URL to the source code repository
   */
  repositoryUrl: string;

  /**
   * The branch name of the source code.
   */
  branch?: string;

  /**
   * The authorization properties for accessing the source code repository and to set up
   * webhooks for notifications.
   */
  sourceControlAuthProperties?: AuthInfo;
}

/**
 * The authorization properties for accessing the source code repository.
 */
model AuthInfo {
  /**
   * The type of Auth token.
   */
  tokenType: TokenType;

  /**
   * The access token used to access the source control provider.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  token: string;

  /**
   * The refresh token used to refresh the access token.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  refreshToken?: string;

  /**
   * The scope of the access token.
   */
  scope?: string;

  /**
   * Time in seconds that the token remains valid
   */
  expiresIn?: int32;
}

/**
 * The trigger based on base image dependency.
 */
model BaseImageTrigger {
  /**
   * The type of the auto trigger for base image dependency updates.
   */
  baseImageTriggerType: BaseImageTriggerType;

  /**
   * The endpoint URL for receiving update triggers.
   */
  updateTriggerEndpoint?: string;

  /**
   * Type of Payload body for Base image update triggers.
   */
  updateTriggerPayloadType?: UpdateTriggerPayloadType;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus = TriggerStatus.Enabled;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The parameters that describes a set of credentials that will be used when a run is invoked.
 */
model Credentials {
  /**
   * Describes the credential parameters for accessing the source registry.
   */
  sourceRegistry?: SourceRegistryCredentials;

  /**
   * Describes the credential parameters for accessing other custom registries. The key
   * for the dictionary item will be the registry login server (myregistry.azurecr.io) and
   * the value of the item will be the registry credentials for accessing the registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  customRegistries?: Record<CustomRegistryCredentials>;
}

/**
 * Describes the credential parameters for accessing the source registry.
 */
model SourceRegistryCredentials {
  /**
   * The Entra identity used for source registry login.
   * The value is `[system]` for system-assigned managed identity, `[caller]` for caller identity,
   * and client ID for user-assigned managed identity.
   */
  identity?: string;

  /**
   * The authentication mode which determines the source registry login scope. The credentials for the source registry
   * will be generated using the given scope. These credentials will be used to login to
   * the source registry during the run.
   */
  loginMode?: SourceRegistryLoginMode;
}

/**
 * Describes the credentials that will be used to access a custom registry during a run.
 */
model CustomRegistryCredentials {
  /**
   * The username for logging into the custom registry.
   */
  userName?: SecretObject;

  /**
   * The password for logging into the custom registry. The password is a secret
   * object that allows multiple ways of providing the value for it.
   */
  password?: SecretObject;

  /**
   * Indicates the managed identity assigned to the custom credential. If a user-assigned identity
   * this value is the Client ID. If a system-assigned identity, the value will be `system`. In
   * the case of a system-assigned identity, the Client ID will be determined by the runner. This
   * identity may be used to authenticate to key vault to retrieve credentials or it may be the only
   * source of authentication used for accessing the registry.
   */
  identity?: string;
}

/**
 * Describes the properties of a secret object value.
 */
model SecretObject {
  /**
   * The value of the secret. The format of this value will be determined
   * based on the type of the secret object. If the type is Opaque, the value will be
   * used as is without any modification.
   */
  value?: string;

  /**
   * The type of the secret object which determines how the value of the secret object has to be
   * interpreted.
   */
  type?: SecretObjectType;
}

/**
 * The parameters for updating a task.
 */
model TaskUpdateParameters {
  /**
   * Identity for the resource.
   */
  identity?: IdentityProperties;

  /**
   * The properties for updating a task.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Backward compatibility"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: TaskPropertiesUpdateParameters;

  /**
   * The ARM resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The properties for updating a task.
 */
model TaskPropertiesUpdateParameters {
  /**
   * The current status of task.
   */
  status?: TaskStatus;

  /**
   * The platform properties against which the run has to happen.
   */
  platform?: PlatformUpdateParameters;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The dedicated agent pool for the task.
   */
  agentPoolName?: string;

  /**
   * Run timeout in seconds.
   */
  timeout?: int32;

  /**
   * The properties for updating a task step.
   */
  step?: TaskStepUpdateParameters;

  /**
   * The properties for updating trigger properties.
   */
  trigger?: TriggerUpdateParameters;

  /**
   * The parameters that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The template that describes the repository and tag information for run log artifact.
   */
  logTemplate?: string;
}

/**
 * The properties for updating the platform configuration.
 */
model PlatformUpdateParameters {
  /**
   * The operating system type required for the run.
   */
  os?: OS;

  /**
   * The OS architecture.
   */
  architecture?: Architecture;

  /**
   * Variant of the CPU.
   */
  variant?: Variant;
}

/**
 * Base properties for updating any task step.
 */
@discriminator("type")
model TaskStepUpdateParameters {
  /**
   * The type of the step.
   */
  type: StepType;

  /**
   * The URL(absolute or relative) of the source context for the task step.
   */
  contextPath?: string;

  /**
   * The token (git PAT or SAS token of storage account blob) associated with the context for a step.
   */
  contextAccessToken?: string;
}

/**
 * The properties for updating triggers.
 */
model TriggerUpdateParameters {
  /**
   * The collection of timer triggers.
   */
  @identifiers(#["name"])
  timerTriggers?: TimerTriggerUpdateParameters[];

  /**
   * The collection of triggers based on source code repository.
   */
  @identifiers(#["name"])
  sourceTriggers?: SourceTriggerUpdateParameters[];

  /**
   * The trigger based on base image dependencies.
   */
  baseImageTrigger?: BaseImageTriggerUpdateParameters;
}

/**
 * The properties for updating a timer trigger.
 */
model TimerTriggerUpdateParameters {
  /**
   * The CRON expression for the task schedule
   */
  schedule?: string;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus = TriggerStatus.Enabled;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties for updating a source based trigger.
 */
model SourceTriggerUpdateParameters {
  /**
   * The properties that describes the source(code) for the task.
   */
  sourceRepository?: SourceUpdateParameters;

  /**
   * The source event corresponding to the trigger.
   */
  sourceTriggerEvents?: SourceTriggerEvent[];

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus = TriggerStatus.Enabled;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * The properties for updating the source code repository.
 */
model SourceUpdateParameters {
  /**
   * The type of source control service.
   */
  sourceControlType?: SourceControlType;

  /**
   * The full URL to the source code repository
   */
  repositoryUrl?: string;

  /**
   * The branch name of the source code.
   */
  branch?: string;

  /**
   * The authorization properties for accessing the source code repository and to set up
   * webhooks for notifications.
   */
  sourceControlAuthProperties?: AuthInfoUpdateParameters;
}

/**
 * The authorization properties for accessing the source code repository.
 */
model AuthInfoUpdateParameters {
  /**
   * The type of Auth token.
   */
  tokenType?: TokenType;

  /**
   * The access token used to access the source control provider.
   */
  token?: string;

  /**
   * The refresh token used to refresh the access token.
   */
  refreshToken?: string;

  /**
   * The scope of the access token.
   */
  scope?: string;

  /**
   * Time in seconds that the token remains valid
   */
  expiresIn?: int32;
}

/**
 * The properties for updating base image dependency trigger.
 */
model BaseImageTriggerUpdateParameters {
  /**
   * The type of the auto trigger for base image dependency updates.
   */
  baseImageTriggerType?: BaseImageTriggerType;

  /**
   * The endpoint URL for receiving update triggers.
   */
  updateTriggerEndpoint?: string;

  /**
   * Type of Payload body for Base image update triggers.
   */
  updateTriggerPayloadType?: UpdateTriggerPayloadType;

  /**
   * The current status of trigger.
   */
  status?: TriggerStatus = TriggerStatus.Enabled;

  /**
   * The name of the trigger.
   */
  name: string;
}

/**
 * Properties that are enabled for Odata querying on runs.
 */
model RunFilter {
  /**
   * The unique identifier for the run.
   */
  runId?: string;

  /**
   * The type of run.
   */
  runType?: RunType;

  /**
   * The current status of the run.
   */
  status?: RunStatus;

  /**
   * The create time for a run.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createTime?: utcDateTime;

  /**
   * The time the run finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
   * The list of comma-separated image manifests that were generated from the run. This is applicable if the run is of
   * build type.
   */
  outputImageManifests?: string;

  /**
   * The value that indicates whether archiving is enabled or not.
   */
  isArchiveEnabled?: boolean;

  /**
   * The name of the task that the run corresponds to.
   */
  taskName?: string;

  /**
   * The name of the agent pool that the run corresponds to.
   */
  agentPoolName?: string;
}

/**
 * The parameters for a docker quick build.
 */
model DockerBuildRequest extends RunRequest {
  /**
   * The fully qualified image names including the repository and tag.
   */
  imageNames?: string[];

  /**
   * The value of this property indicates whether the image built should be pushed to the registry or not.
   */
  isPushEnabled?: boolean = true;

  /**
   * The value of this property indicates whether the image cache is enabled or not.
   */
  noCache?: boolean = false;

  /**
   * The Docker file path relative to the source location.
   */
  dockerFilePath: string;

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The collection of override arguments to be used when executing the run.
   */
  @identifiers(#["name"])
  arguments?: Argument[];

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The platform properties against which the run has to happen.
   */
  platform: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
   * If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
   */
  sourceLocation?: string;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The type of the run request.
   */
  type: "DockerBuildRequest";
}

/**
 * The properties of a run argument.
 */
model Argument {
  /**
   * The name of the argument.
   */
  name: string;

  /**
   * The value of the argument.
   */
  value: string;

  /**
   * Flag to indicate whether the argument represents a secret and want to be removed from build logs.
   */
  isSecret?: boolean = false;
}

/**
 * The request parameters for a scheduling run against a task file.
 */
model FileTaskRunRequest extends RunRequest {
  /**
   * The template/definition file path relative to the source.
   */
  taskFilePath: string;

  /**
   * The values/parameters file path relative to the source.
   */
  valuesFilePath?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  @identifiers(#[])
  values?: SetValue[];

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The platform properties against which the run has to happen.
   */
  platform: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
   * If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
   */
  sourceLocation?: string;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The type of the run request.
   */
  type: "FileTaskRunRequest";
}

/**
 * The properties of a overridable value that can be passed to a task template.
 */
model SetValue {
  /**
   * The name of the overridable value.
   */
  name: string;

  /**
   * The overridable value.
   */
  value: string;

  /**
   * Flag to indicate whether the value represents a secret or not.
   */
  isSecret?: boolean = false;
}

/**
 * The parameters for a task run request.
 */
model TaskRunRequest extends RunRequest {
  /**
   * The resource ID of task against which run has to be queued.
   */
  taskId: string;

  /**
   * Set of overridable parameters that can be passed when running a Task.
   */
  overrideTaskStepProperties?: OverrideTaskStepProperties;

  /**
   * The type of the run request.
   */
  type: "TaskRunRequest";
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model OverrideTaskStepProperties {
  /**
   * The source context against which run has to be queued.
   */
  contextPath?: string;

  /**
   * The file against which run has to be queued.
   */
  file?: string;

  /**
   * Gets or sets the collection of override arguments to be used when
   * executing a build step.
   */
  @identifiers(#["name"])
  arguments?: Argument[];

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The collection of overridable values that can be passed when running a Task.
   */
  @identifiers(#[])
  values?: SetValue[];

  /**
   * Base64 encoded update trigger token that will be attached with the base image trigger webhook.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "TODO: Check if this is a secret and add @secret or update reason"
  updateTriggerToken?: string;
}

/**
 * The parameters for a quick task run request.
 */
model EncodedTaskRunRequest extends RunRequest {
  /**
   * Base64 encoded value of the template/definition file content.
   */
  encodedTaskContent: string;

  /**
   * Base64 encoded value of the parameters/values file content.
   */
  encodedValuesContent?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  @identifiers(#[])
  values?: SetValue[];

  /**
   * Run timeout in seconds.
   */
  @maxValue(28800)
  @minValue(300)
  timeout?: int32 = 3600;

  /**
   * The platform properties against which the run has to happen.
   */
  platform: PlatformProperties;

  /**
   * The machine configuration of the run agent.
   */
  agentConfiguration?: AgentProperties;

  /**
   * The URL(absolute or relative) of the source context. It can be an URL to a tar or git repository.
   * If it is relative URL, the relative path should be obtained from calling listBuildSourceUploadUrl API.
   */
  sourceLocation?: string;

  /**
   * The properties that describes a set of credentials that will be used when this run is invoked.
   */
  credentials?: Credentials;

  /**
   * The type of the run request.
   */
  type: "EncodedTaskRunRequest";
}

/**
 * The Docker build step.
 */
model DockerBuildStep extends TaskStepProperties {
  /**
   * The fully qualified image names including the repository and tag.
   */
  imageNames?: string[];

  /**
   * The value of this property indicates whether the image built should be pushed to the registry or not.
   */
  isPushEnabled?: boolean = true;

  /**
   * The value of this property indicates whether the image cache is enabled or not.
   */
  noCache?: boolean = false;

  /**
   * The Docker file path relative to the source context.
   */
  dockerFilePath: string;

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The collection of override arguments to be used when executing this build step.
   */
  @identifiers(#["name"])
  arguments?: Argument[];

  /**
   * The type of the step.
   */
  type: "Docker";
}

/**
 * The properties of a task step.
 */
model FileTaskStep extends TaskStepProperties {
  /**
   * The task template/definition file path relative to the source context.
   */
  taskFilePath: string;

  /**
   * The task values/parameters file path relative to the source context.
   */
  valuesFilePath?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  @identifiers(#[])
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "FileTask";
}

/**
 * The properties of a encoded task step.
 */
model EncodedTaskStep extends TaskStepProperties {
  /**
   * Base64 encoded value of the template/definition file content.
   */
  encodedTaskContent: string;

  /**
   * Base64 encoded value of the parameters/values file content.
   */
  encodedValuesContent?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  @identifiers(#[])
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "EncodedTask";
}

/**
 * The properties for updating a docker build step.
 */
model DockerBuildStepUpdateParameters extends TaskStepUpdateParameters {
  /**
   * The fully qualified image names including the repository and tag.
   */
  imageNames?: string[];

  /**
   * The value of this property indicates whether the image built should be pushed to the registry or not.
   */
  isPushEnabled?: boolean;

  /**
   * The value of this property indicates whether the image cache is enabled or not.
   */
  noCache?: boolean;

  /**
   * The Docker file path relative to the source context.
   */
  dockerFilePath?: string;

  /**
   * The collection of override arguments to be used when executing this build step.
   */
  @identifiers(#["name"])
  arguments?: Argument[];

  /**
   * The name of the target build stage for the docker build.
   */
  target?: string;

  /**
   * The type of the step.
   */
  type: "Docker";
}

/**
 * The properties of updating a task step.
 */
model FileTaskStepUpdateParameters extends TaskStepUpdateParameters {
  /**
   * The task template/definition file path relative to the source context.
   */
  taskFilePath?: string;

  /**
   * The values/parameters file path relative to the source context.
   */
  valuesFilePath?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  @identifiers(#[])
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "FileTask";
}

/**
 * The properties for updating encoded task step.
 */
model EncodedTaskStepUpdateParameters extends TaskStepUpdateParameters {
  /**
   * Base64 encoded value of the template/definition file content.
   */
  encodedTaskContent?: string;

  /**
   * Base64 encoded value of the parameters/values file content.
   */
  encodedValuesContent?: string;

  /**
   * The collection of overridable values that can be passed when running a task.
   */
  @identifiers(#[])
  values?: SetValue[];

  /**
   * The type of the step.
   */
  type: "EncodedTask";
}

model Registry is Azure.ResourceManager.TrackedResource<never> {
  ...ResourceNameParameter<
    Resource = Registry,
    KeyName = "registryName",
    SegmentName = "registries",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
}
@@maxLength(Registry.name, 50);
@@minLength(Registry.name, 5);
