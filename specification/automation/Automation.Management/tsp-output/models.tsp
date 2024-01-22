import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Automation;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Gets or sets the agent registration key name - primary or secondary.
 */
enum AgentRegistrationKeyName {
  primary,
  secondary,
}

/**
 * Gets or sets the content source type.
 */
enum ContentSourceType {
  embeddedContent,
  uri,
}

/**
 * The provisioning state of the resource.
 */
enum JobProvisioningState {
  Failed,
  Succeeded,
  Suspended,
  Processing,
}

/**
 * Gets or sets the status of the job.
 */
enum JobStatus {
  New,
  Activating,
  Running,
  Completed,
  Failed,
  Stopped,
  Blocked,
  Suspended,
  Disconnected,
  Suspending,
  Stopping,
  Resuming,
  Removing,
}

/**
 * Gets or sets the stream type.
 */
enum JobStreamType {
  Progress,
  Output,
  Warning,
  Error,
  Debug,
  Verbose,
  Any,
}

enum CountType {
  status,
  nodeconfiguration,
}

/**
 * The source type. Must be one of VsoGit, VsoTfvc, GitHub.
 */
enum SourceType {
  VsoGit,
  VsoTfvc,
  GitHub,
}

/**
 * The token type. Must be either PersonalAccessToken or Oauth.
 */
enum TokenType {
  PersonalAccessToken,
  Oauth,
}

/**
 * The provisioning state of the job.
 */
enum ProvisioningState {
  Completed,
  Failed,
  Running,
}

/**
 * The sync type.
 */
enum SyncType {
  PartialSync,
  FullSync,
}

/**
 * The type of the sync job stream.
 */
enum StreamType {
  Error,
  Output,
}

/**
 * Gets or sets the SKU name of the account.
 */
enum SkuNameEnum {
  Free,
  Basic,
}

/**
 * Gets status of account.
 */
enum AutomationAccountState {
  Ok,
  Unavailable,
  Suspended,
}

/**
 * Automation key name.
 */
enum AutomationKeyName {
  Primary,
  Secondary,
}

/**
 * Automation key permissions.
 */
enum AutomationKeyPermissions {
  Read,
  Full,
}

/**
 * Gets or sets the frequency of the schedule.
 */
enum ScheduleFrequency {
  OneTime,
  Day,
  Hour,
  Week,
  Month,

  /**
   * The minimum allowed interval for Minute schedules is 15 minutes.
   */
  Minute,
}

/**
 * Day of the occurrence. Must be one of monday, tuesday, wednesday, thursday, friday, saturday, sunday.
 */
enum ScheduleDay {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * Gets or sets the state of the configuration.
 */
enum DscConfigurationState {
  New,
  Edit,
  Published,
}

/**
 * Runbook Type
 */
enum GraphRunbookType {
  GraphPowerShell,
  GraphPowerShellWorkflow,
}

/**
 * Update classification included in the software update configuration. A comma separated string with required values
 */
enum WindowsUpdateClasses {
  Unclassified,
  Critical,
  Security,
  UpdateRollup,
  FeaturePack,
  ServicePack,
  Definition,
  Tools,
  Updates,
}

/**
 * Update classifications included in the software update configuration.
 */
enum LinuxUpdateClasses {
  Unclassified,
  Critical,
  Security,
  Other,
}

enum HttpStatusCode {
  Continue,
  SwitchingProtocols,
  OK,
  Created,
  Accepted,
  NonAuthoritativeInformation,
  NoContent,
  ResetContent,
  PartialContent,
  MultipleChoices,
  Ambiguous,
  MovedPermanently,
  Moved,
  Found,
  Redirect,
  SeeOther,
  RedirectMethod,
  NotModified,
  UseProxy,
  Unused,
  TemporaryRedirect,
  RedirectKeepVerb,
  BadRequest,
  Unauthorized,
  PaymentRequired,
  Forbidden,
  NotFound,
  MethodNotAllowed,
  NotAcceptable,
  ProxyAuthenticationRequired,
  RequestTimeout,
  Conflict,
  Gone,
  LengthRequired,
  PreconditionFailed,
  RequestEntityTooLarge,
  RequestUriTooLong,
  UnsupportedMediaType,
  RequestedRangeNotSatisfiable,
  ExpectationFailed,
  UpgradeRequired,
  InternalServerError,
  NotImplemented,
  BadGateway,
  ServiceUnavailable,
  GatewayTimeout,
  HttpVersionNotSupported,
}

/**
 * Gets or sets the type of the runbook.
 */
enum RunbookTypeEnum {
  Script,
  Graph,
  PowerShellWorkflow,
  PowerShell,
  GraphPowerShellWorkflow,
  GraphPowerShell,
  Python2,
  Python3,
}

/**
 * Gets or sets the state of the runbook.
 */
enum RunbookState {
  New,
  Edit,
  Published,
}

/**
 * Type of the HybridWorker.
 */
enum WorkerType {
  HybridV1,
  HybridV2,
}

/**
 * Type of the HybridWorkerGroup.
 */
enum GroupTypeEnum {
  User,
  System,
}

/**
 * Gets or sets the provisioning state of the module.
 */
@fixed
enum ModuleProvisioningState {
  Created,
  Creating,
  StartingImportModuleRunbook,
  RunningImportModuleRunbook,
  ContentRetrieved,
  ContentDownloaded,
  ContentValidated,
  ConnectionTypeImported,
  ContentStored,
  ModuleDataStored,
  ActivitiesStored,
  ModuleImportRunbookComplete,
  Succeeded,
  Failed,
  Cancelled,
  Updating,
}

/**
 * Encryption Key Source
 */
@fixed
enum EncryptionKeySourceType {
  `Microsoft.Automation`,
  `Microsoft.Keyvault`,
}

/**
 * The identity type.
 */
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * Target operating system for the software update configuration.
 */
@fixed
enum OperatingSystemType {
  Windows,
  Linux,
}

/**
 * Filter VMs by Any or All specified tags.
 */
@fixed
enum TagOperators {
  All,
  Any,
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * Private endpoint which the connection belongs to.
   */
  privateEndpoint?: PrivateEndpointProperty;

  /**
   * Gets the groupIds.
   */
  groupIds?: string[];

  /**
   * Connection State of the Private Endpoint Connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionStateProperty;
}

/**
 * Private endpoint which the connection belongs to.
 */
model PrivateEndpointProperty {
  /**
   * Resource id of the private endpoint.
   */
  id?: string;
}

/**
 * Connection State of the Private Endpoint Connection.
 */
model PrivateLinkServiceConnectionStateProperty {
  /**
   * The private link service connection status.
   */
  status?: string;

  /**
   * The private link service connection description.
   */
  description?: string;

  /**
   * Any action that is required beyond basic workflow (approve/ reject/ disconnect)
   */
  @visibility("read")
  actionsRequired?: string;
}

/**
 * The core properties of ARM resources
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;
}

/**
 * A list of private link resources
 */
@pagedResult
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @items
  value?: PrivateLinkResource[];
}

/**
 * A private link resource
 */
model PrivateLinkResource extends ProxyResource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];
}

/**
 * Definition of the module property type.
 */
model ModuleProperties {
  /**
   * Gets or sets the isGlobal flag of the module.
   */
  isGlobal?: boolean;

  /**
   * Gets or sets the version of the module.
   */
  version?: string;

  /**
   * Gets or sets the size in bytes of the module.
   */
  sizeInBytes?: int64;

  /**
   * Gets or sets the activity count of the module.
   */
  activityCount?: int32;

  /**
   * Gets or sets the provisioning state of the module.
   */
  provisioningState?: ModuleProvisioningState;

  /**
   * Gets or sets the contentLink of the module.
   */
  contentLink?: ContentLink;

  /**
   * Gets or sets the error info of the module.
   */
  error?: ModuleErrorInfo;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;

  /**
   * Gets or sets type of module, if its composite or not.
   */
  isComposite?: boolean;
}

/**
 * Definition of the content link.
 */
model ContentLink {
  /**
   * Gets or sets the uri of the runbook content.
   */
  uri?: string;

  /**
   * Gets or sets the hash.
   */
  contentHash?: ContentHash;

  /**
   * Gets or sets the version of the content.
   */
  version?: string;
}

/**
 * Definition of the runbook property type.
 */
model ContentHash {
  /**
   * Gets or sets the content hash algorithm used to hash the content.
   */
  algorithm: string;

  /**
   * Gets or sets expected hash value of the content.
   */
  value: string;
}

/**
 * Definition of the module error info type.
 */
model ModuleErrorInfo {
  /**
   * Gets or sets the error code.
   */
  code?: string;

  /**
   * Gets or sets the error message.
   */
  message?: string;
}

/**
 * The parameters supplied to the create or update module operation.
 */
model PythonPackageCreateParameters {
  /**
   * Gets or sets the module create properties.
   */
  properties: PythonPackageCreateProperties;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the create or update module properties.
 */
model PythonPackageCreateProperties {
  /**
   * Gets or sets the module content link.
   */
  contentLink: ContentLink;
}

/**
 * The parameters supplied to the update module operation.
 */
model PythonPackageUpdateParameters {
  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * Definition of the agent registration information type.
 */
model AgentRegistration {
  /**
   * Gets or sets the dsc meta configuration.
   */
  dscMetaConfiguration?: string;

  /**
   * Gets or sets the dsc server endpoint.
   */
  endpoint?: string;

  /**
   * Gets or sets the agent registration keys.
   */
  keys?: AgentRegistrationKeys;

  /**
   * Gets or sets the id.
   */
  id?: string;
}

/**
 * Definition of the agent registration keys.
 */
model AgentRegistrationKeys {
  /**
   * Gets or sets the primary key.
   */
  primary?: string;

  /**
   * Gets or sets the secondary key.
   */
  secondary?: string;
}

/**
 * The parameters supplied to the regenerate keys operation.
 */
model AgentRegistrationRegenerateKeyParameter {
  /**
   * Gets or sets the agent registration key name - primary or secondary.
   */
  keyName: AgentRegistrationKeyName;
}

/**
 * The properties of a DscNode
 */
model DscNodeProperties {
  /**
   * Gets or sets the last seen time of the node.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSeen?: utcDateTime;

  /**
   * Gets or sets the registration time of the node.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registrationTime?: utcDateTime;

  /**
   * Gets or sets the ip of the node.
   */
  ip?: string;

  /**
   * Gets or sets the account id of the node.
   */
  accountId?: string;

  /**
   * Gets or sets the configuration of the node.
   */
  nodeConfiguration?: DscNodeConfigurationAssociationProperty;

  /**
   * Gets or sets the status of the node.
   */
  status?: string;

  /**
   * Gets or sets the node id.
   */
  nodeId?: string;

  /**
   * Gets or sets the etag of the resource.
   */
  etag?: string;

  /**
   * Gets the total number of records matching filter criteria.
   */
  totalCount?: int32;

  /**
   * Gets or sets the list of extensionHandler properties for a Node.
   */
  extensionHandler?: DscNodeExtensionHandlerAssociationProperty[];
}

/**
 * The dsc node configuration property associated with the entity.
 */
model DscNodeConfigurationAssociationProperty {
  /**
   * Gets or sets the name of the dsc node configuration.
   */
  name?: string;
}

/**
 * The dsc extensionHandler property associated with the node
 */
model DscNodeExtensionHandlerAssociationProperty {
  /**
   * Gets or sets the name of the extension handler.
   */
  name?: string;

  /**
   * Gets or sets the version of the extension handler.
   */
  version?: string;
}

/**
 * The parameters supplied to the update dsc node operation.
 */
model DscNodeUpdateParameters {
  /**
   * Gets or sets the id of the dsc node.
   */
  nodeId?: string;

  properties?: DscNodeUpdateParametersProperties;
}

model DscNodeUpdateParametersProperties {
  /**
   * Gets or sets the configuration of the node.
   */
  nodeConfiguration?: DscNodeConfigurationAssociationProperty;
}

/**
 * The response model for the list dsc nodes operation.
 */
model DscNodeReportListResult is Azure.Core.Page<DscNodeReport>;

/**
 * Definition of the dsc node report type.
 */
model DscNodeReport {
  /**
   * Gets or sets the end time of the node report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets or sets the lastModifiedTime of the node report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the start time of the node report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets the type of the node report.
   */
  type?: string;

  /**
   * Gets or sets the id of the node report.
   */
  reportId?: string;

  /**
   * Gets or sets the status of the node report.
   */
  status?: string;

  /**
   * Gets or sets the refreshMode of the node report.
   */
  refreshMode?: string;

  /**
   * Gets or sets the rebootRequested of the node report.
   */
  rebootRequested?: string;

  /**
   * Gets or sets the reportFormatVersion of the node report.
   */
  reportFormatVersion?: string;

  /**
   * Gets or sets the configurationVersion of the node report.
   */
  configurationVersion?: string;

  /**
   * Gets or sets the id.
   */
  id?: string;

  /**
   * Gets or sets the errors for the node report.
   */
  errors?: DscReportError[];

  /**
   * Gets or sets the resource for the node report.
   */
  resources?: DscReportResource[];

  /**
   * Gets or sets the metaConfiguration of the node at the time of the report.
   */
  metaConfiguration?: DscMetaConfiguration;

  /**
   * Gets or sets the hostname of the node that sent the report.
   */
  hostName?: string;

  /**
   * Gets or sets the IPv4 address of the node that sent the report.
   */
  iPV4Addresses?: string[];

  /**
   * Gets or sets the IPv6 address of the node that sent the report.
   */
  iPV6Addresses?: string[];

  /**
   * Gets or sets the number of resource in the node report.
   */
  numberOfResources?: int32;

  /**
   * Gets or sets the unparsed errors for the node report.
   */
  rawErrors?: string;
}

/**
 * Definition of the dsc node report error type.
 */
model DscReportError {
  /**
   * Gets or sets the source of the error.
   */
  errorSource?: string;

  /**
   * Gets or sets the resource ID which generated the error.
   */
  resourceId?: string;

  /**
   * Gets or sets the error code.
   */
  errorCode?: string;

  /**
   * Gets or sets the error message.
   */
  errorMessage?: string;

  /**
   * Gets or sets the locale of the error.
   */
  locale?: string;

  /**
   * Gets or sets the error details.
   */
  errorDetails?: string;
}

/**
 * Definition of the DSC Report Resource.
 */
model DscReportResource {
  /**
   * Gets or sets the ID of the resource.
   */
  resourceId?: string;

  /**
   * Gets or sets the source info of the resource.
   */
  sourceInfo?: string;

  /**
   * Gets or sets the Resource Navigation values for resources the resource depends on.
   */
  dependsOn?: DscReportResourceNavigation[];

  /**
   * Gets or sets the module name of the resource.
   */
  moduleName?: string;

  /**
   * Gets or sets the module version of the resource.
   */
  moduleVersion?: string;

  /**
   * Gets or sets the name of the resource.
   */
  resourceName?: string;

  /**
   * Gets or sets the error of the resource.
   */
  error?: string;

  /**
   * Gets or sets the status of the resource.
   */
  status?: string;

  /**
   * Gets or sets the duration in seconds for the resource.
   */
  durationInSeconds?: float64;

  /**
   * Gets or sets the start date of the resource.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;
}

/**
 * Navigation for DSC Report Resource.
 */
model DscReportResourceNavigation {
  /**
   * Gets or sets the ID of the resource to navigate to.
   */
  resourceId?: string;
}

/**
 * Definition of the DSC Meta Configuration.
 */
model DscMetaConfiguration {
  /**
   * Gets or sets the ConfigurationModeFrequencyMins value of the meta configuration.
   */
  configurationModeFrequencyMins?: int32;

  /**
   * Gets or sets the RebootNodeIfNeeded value of the meta configuration.
   */
  rebootNodeIfNeeded?: boolean;

  /**
   * Gets or sets the ConfigurationMode value of the meta configuration.
   */
  configurationMode?: string;

  /**
   * Gets or sets the ActionAfterReboot value of the meta configuration.
   */
  actionAfterReboot?: string;

  /**
   * Gets or sets the CertificateId value of the meta configuration.
   */
  certificateId?: string;

  /**
   * Gets or sets the RefreshFrequencyMins value of the meta configuration.
   */
  refreshFrequencyMins?: int32;

  /**
   * Gets or sets the AllowModuleOverwrite value of the meta configuration.
   */
  allowModuleOverwrite?: boolean;
}

/**
 * Properties for the DscNodeConfiguration
 */
model DscNodeConfigurationProperties {
  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the configuration of the node.
   */
  configuration?: DscConfigurationAssociationProperty;

  /**
   * Source of node configuration.
   */
  source?: string;

  /**
   * Number of nodes with this node configuration assigned
   */
  nodeCount?: int64;

  /**
   * If a new build version of NodeConfiguration is required.
   */
  incrementNodeConfigurationBuild?: boolean;
}

/**
 * The Dsc configuration property associated with the entity.
 */
model DscConfigurationAssociationProperty {
  /**
   * Gets or sets the name of the Dsc configuration.
   */
  name?: string;
}

/**
 * The parameters supplied to the create or update node configuration operation.
 */
model DscNodeConfigurationCreateOrUpdateParameters {
  /**
   * Node configuration properties
   */
  properties?: DscNodeConfigurationCreateOrUpdateParametersProperties;

  /**
   * Name of the node configuration.
   */
  name?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameter properties supplied to the create or update node configuration operation.
 */
model DscNodeConfigurationCreateOrUpdateParametersProperties {
  /**
   * Gets or sets the source.
   */
  source: ContentSource;

  /**
   * Gets or sets the configuration of the node.
   */
  configuration: DscConfigurationAssociationProperty;

  /**
   * If a new build version of NodeConfiguration is required.
   */
  incrementNodeConfigurationBuild?: boolean;
}

/**
 * Definition of the content source.
 */
model ContentSource {
  /**
   * Gets or sets the hash.
   */
  hash?: ContentHash;

  /**
   * Gets or sets the content source type.
   */
  type?: ContentSourceType;

  /**
   * Gets or sets the value of the content. This is based on the content source type.
   */
  value?: string;

  /**
   * Gets or sets the version of the content.
   */
  version?: string;
}

/**
 * The parameters supplied to the create compilation job operation.
 */
model DscCompilationJobCreateParameters {
  /**
   * Gets or sets the list of compilation job properties.
   */
  properties: DscCompilationJobCreateProperties;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the create compilation job operation.
 */
model DscCompilationJobCreateProperties {
  /**
   * Gets or sets the configuration.
   */
  configuration: DscConfigurationAssociationProperty;

  /**
   * Gets or sets the parameters of the job.
   */
  parameters?: Record<string>;

  /**
   * If a new build version of NodeConfiguration is required.
   */
  incrementNodeConfigurationBuild?: boolean;
}

/**
 * Definition of Dsc Compilation job properties.
 */
model DscCompilationJobProperties {
  /**
   * Gets or sets the configuration.
   */
  configuration?: DscConfigurationAssociationProperty;

  /**
   * Gets the compilation job started by.
   */
  @visibility("read")
  startedBy?: string;

  /**
   * Gets the id of the job.
   */
  @visibility("read")
  jobId?: string;

  /**
   * Gets the creation time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The current provisioning state of the job.
   */
  provisioningState?: JobProvisioningState;

  /**
   * Gets or sets the runOn which specifies the group name where the job is to be executed.
   */
  runOn?: string;

  /**
   * Gets or sets the status of the job.
   */
  status?: JobStatus;

  /**
   * Gets or sets the status details of the job.
   */
  statusDetails?: string;

  /**
   * Gets the start time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the end time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the exception of the job.
   */
  @visibility("read")
  exception?: string;

  /**
   * Gets the last modified time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets the last status modified time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusModifiedTime?: utcDateTime;

  /**
   * Gets or sets the parameters of the job.
   */
  parameters?: Record<string>;
}

/**
 * The response model for the list job stream operation.
 */
model JobStreamListResult is Azure.Core.Page<JobStream>;

/**
 * Definition of the job stream.
 */
model JobStream {
  /**
   * Gets or sets the id of the resource.
   */
  id?: string;

  /**
   * Gets or sets the id of the job stream.
   */
  properties?: JobStreamProperties;
}

/**
 * Definition of the job stream.
 */
model JobStreamProperties {
  /**
   * Gets or sets the id of the job stream.
   */
  jobStreamId?: string;

  /**
   * Gets or sets the creation time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * Gets or sets the stream type.
   */
  streamType?: JobStreamType;

  /**
   * Gets or sets the stream text.
   */
  streamText?: string;

  /**
   * Gets or sets the summary.
   */
  summary?: string;

  /**
   * Gets or sets the values of the job stream.
   */
  value?: Record<Record<unknown>>;
}

/**
 * Gets the count of nodes by count type
 */
model NodeCounts {
  /**
   * Gets an array of counts
   */
  value?: NodeCount[];

  /**
   * Gets the total number of records matching countType criteria.
   */
  totalCount?: int32;
}

/**
 * Number of nodes based on the Filter
 */
model NodeCount {
  /**
   * Gets the name of a count type
   */
  name?: string;

  properties?: NodeCountProperties;
}

model NodeCountProperties {
  /**
   * Gets the count for the name
   */
  count?: int32;
}

/**
 * The parameters supplied to the create or update source control operation.
 */
model SourceControlCreateOrUpdateParameters {
  /**
   * The properties of the source control.
   */
  properties: SourceControlCreateOrUpdateProperties;
}

/**
 * The properties of the create source control operation.
 */
model SourceControlCreateOrUpdateProperties {
  /**
   * The repo url of the source control.
   */
  @maxLength(2000)
  repoUrl?: string;

  /**
   * The repo branch of the source control. Include branch as empty string for VsoTfvc.
   */
  @maxLength(255)
  branch?: string;

  /**
   * The folder path of the source control. Path must be relative.
   */
  @maxLength(255)
  folderPath?: string;

  /**
   * The auto async of the source control. Default is false.
   */
  autoSync?: boolean;

  /**
   * The auto publish of the source control. Default is true.
   */
  publishRunbook?: boolean;

  /**
   * The source type. Must be one of VsoGit, VsoTfvc, GitHub, case sensitive.
   */
  sourceType?: SourceType;

  /**
   * The authorization token for the repo of the source control.
   */
  securityToken?: SourceControlSecurityTokenProperties;

  /**
   * The user description of the source control.
   */
  @maxLength(512)
  description?: string;
}

model SourceControlSecurityTokenProperties {
  /**
   * The access token.
   */
  @maxLength(1024)
  accessToken?: string;

  /**
   * The refresh token.
   */
  @maxLength(1024)
  refreshToken?: string;

  /**
   * The token type. Must be either PersonalAccessToken or Oauth.
   */
  tokenType?: TokenType;
}

/**
 * Definition of the source control properties
 */
model SourceControlProperties {
  /**
   * The repo url of the source control.
   */
  repoUrl?: string;

  /**
   * The repo branch of the source control. Include branch as empty string for VsoTfvc.
   */
  branch?: string;

  /**
   * The folder path of the source control.
   */
  folderPath?: string;

  /**
   * The auto sync of the source control. Default is false.
   */
  autoSync?: boolean;

  /**
   * The auto publish of the source control. Default is true.
   */
  publishRunbook?: boolean;

  /**
   * The source type. Must be one of VsoGit, VsoTfvc, GitHub.
   */
  sourceType?: SourceType;

  /**
   * The description.
   */
  description?: string;

  /**
   * The creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;
}

/**
 * The parameters supplied to the update source control operation.
 */
model SourceControlUpdateParameters {
  /**
   * The value of the source control.
   */
  properties?: SourceControlUpdateProperties;
}

/**
 * The properties of the update source control
 */
model SourceControlUpdateProperties {
  /**
   * The repo branch of the source control.
   */
  branch?: string;

  /**
   * The folder path of the source control. Path must be relative.
   */
  folderPath?: string;

  /**
   * The auto sync of the source control. Default is false.
   */
  autoSync?: boolean;

  /**
   * The auto publish of the source control. Default is true.
   */
  publishRunbook?: boolean;

  /**
   * The authorization token for the repo of the source control.
   */
  securityToken?: SourceControlSecurityTokenProperties;

  /**
   * The user description of the source control.
   */
  description?: string;
}

/**
 * The parameters supplied to the create source control sync job operation.
 */
model SourceControlSyncJobCreateParameters {
  /**
   * The properties of the source control sync job.
   */
  properties: SourceControlSyncJobCreateProperties;
}

/**
 * Definition of create source control sync job properties.
 */
model SourceControlSyncJobCreateProperties {
  /**
   * The commit id of the source control sync job. If not syncing to a commitId, enter an empty string.
   */
  commitId: string;
}

/**
 * Definition of the source control sync job.
 */
model SourceControlSyncJob {
  /**
   * Resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * Resource id.
   */
  @visibility("read")
  id?: string;

  /**
   * The properties of the source control sync job.
   */
  properties?: SourceControlSyncJobProperties;
}

/**
 * Definition of source control sync job properties.
 */
model SourceControlSyncJobProperties {
  /**
   * The source control sync job id.
   */
  sourceControlSyncJobId?: string;

  /**
   * The creation time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The provisioning state of the job.
   */
  provisioningState?: ProvisioningState;

  /**
   * The start time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The sync type.
   */
  syncType?: SyncType;
}

/**
 * Definition of the source control sync job.
 */
model SourceControlSyncJobById {
  /**
   * The id of the job.
   */
  id?: string;

  /**
   * The properties of the source control sync job.
   */
  properties?: SourceControlSyncJobByIdProperties;
}

/**
 * Definition of source control sync job properties.
 */
model SourceControlSyncJobByIdProperties {
  /**
   * The source control sync job id.
   */
  sourceControlSyncJobId?: string;

  /**
   * The creation time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The provisioning state of the job.
   */
  provisioningState?: ProvisioningState;

  /**
   * The start time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The sync type.
   */
  syncType?: SyncType;

  /**
   * The exceptions that occurred while running the sync job.
   */
  exception?: string;
}

/**
 * The response model for the list source control sync jobs operation.
 */
model SourceControlSyncJobListResult is Azure.Core.Page<SourceControlSyncJob>;

/**
 * The response model for the list source control sync job streams operation.
 */
model SourceControlSyncJobStreamsListBySyncJob
  is Azure.Core.Page<SourceControlSyncJobStream>;

/**
 * Definition of the source control sync job stream.
 */
model SourceControlSyncJobStream {
  /**
   * Resource id.
   */
  @visibility("read")
  id?: string;

  /**
   * The properties of the source control sync job stream.
   */
  properties?: SourceControlSyncJobStreamProperties;
}

/**
 * Definition of source control sync job stream properties.
 */
model SourceControlSyncJobStreamProperties {
  /**
   * The sync job stream id.
   */
  sourceControlSyncJobStreamId?: string;

  /**
   * The summary of the sync job stream.
   */
  summary?: string;

  /**
   * The time of the sync job stream.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The type of the sync job stream.
   */
  streamType?: StreamType;
}

/**
 * Definition of the source control sync job stream by id.
 */
model SourceControlSyncJobStreamById {
  /**
   * Resource id.
   */
  @visibility("read")
  id?: string;

  /**
   * The properties of the source control sync job stream.
   */
  properties?: SourceControlSyncJobStreamByIdProperties;
}

/**
 * Definition of source control sync job stream by id properties.
 */
model SourceControlSyncJobStreamByIdProperties {
  /**
   * The sync job stream id.
   */
  sourceControlSyncJobStreamId?: string;

  /**
   * The summary of the sync job stream.
   */
  summary?: string;

  /**
   * The time of the sync job stream.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  /**
   * The type of the sync job stream.
   */
  streamType?: StreamType;

  /**
   * The text of the sync job stream.
   */
  streamText?: string;

  /**
   * The values of the job stream.
   */
  value?: Record<Record<unknown>>;
}

/**
 * The parameters supplied to the update automation account operation.
 */
model AutomationAccountUpdateParameters {
  /**
   * Gets or sets account update properties.
   */
  properties?: AutomationAccountUpdateProperties;

  /**
   * Gets or sets the name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Sets the identity property for automation account
   */
  identity?: Identity;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the update account properties.
 */
model AutomationAccountUpdateProperties {
  /**
   * Gets or sets account SKU.
   */
  sku?: Sku;

  /**
   * Set the encryption properties for the automation account
   */
  encryption?: EncryptionProperties;

  /**
   * Indicates whether traffic on the non-ARM endpoint (Webhook/Agent) is allowed from the public internet
   */
  publicNetworkAccess?: boolean;

  /**
   * Indicates whether requests using non-AAD authentication are blocked
   */
  disableLocalAuth?: boolean;
}

/**
 * The account SKU.
 */
model Sku {
  /**
   * Gets or sets the SKU name of the account.
   */
  name: SkuNameEnum;

  /**
   * Gets or sets the SKU family.
   */
  family?: string;

  /**
   * Gets or sets the SKU capacity.
   */
  capacity?: int32;
}

/**
 * The encryption settings for automation account
 */
model EncryptionProperties {
  /**
   * Key vault properties.
   */
  keyVaultProperties?: KeyVaultProperties;

  /**
   * Encryption Key Source
   */
  keySource?: EncryptionKeySourceType;

  /**
   * User identity used for CMK.
   */
  identity?: EncryptionPropertiesIdentity;
}

/**
 * Settings concerning key vault encryption for a configuration store.
 */
model KeyVaultProperties {
  /**
   * The URI of the key vault key used to encrypt data.
   */
  keyvaultUri?: string;

  /**
   * The name of key used to encrypt data.
   */
  keyName?: string;

  /**
   * The key version of the key used to encrypt data.
   */
  keyVersion?: string;
}

/**
 * User identity used for CMK.
 */
model EncryptionPropertiesIdentity {
  /**
   * The user identity used for CMK. It will be an ARM resource id in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentity?: Record<unknown>;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  userAssignedIdentities?: Record<ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties>;
}

model ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility("read")
  clientId?: string;
}

/**
 * Definition of the account property.
 */
model AutomationAccountProperties {
  /**
   * Gets or sets the SKU of account.
   */
  sku?: Sku;

  /**
   * Gets or sets the last modified by.
   */
  lastModifiedBy?: string;

  /**
   * Gets status of account.
   */
  @visibility("read")
  state?: AutomationAccountState;

  /**
   * Gets the creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;

  /**
   * Encryption properties for the automation account
   */
  encryption?: EncryptionProperties;

  /**
   * List of Automation operations supported by the Automation resource provider.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Indicates whether traffic on the non-ARM endpoint (Webhook/Agent) is allowed from the public internet
   */
  publicNetworkAccess?: boolean;

  /**
   * Indicates whether requests using non-AAD authentication are blocked
   */
  disableLocalAuth?: boolean;

  /**
   * URL of automation hybrid service which is used for hybrid worker on-boarding.
   */
  automationHybridServiceUrl?: string;
}

/**
 * The parameters supplied to the create or update automation account operation.
 */
model AutomationAccountCreateOrUpdateParameters {
  /**
   * Gets or sets account create or update properties.
   */
  properties?: AutomationAccountCreateOrUpdateProperties;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Sets the identity property for automation account
   */
  identity?: Identity;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the create or update account properties.
 */
model AutomationAccountCreateOrUpdateProperties {
  /**
   * Gets or sets account SKU.
   */
  sku?: Sku;

  /**
   * Set the encryption properties for the automation account
   */
  encryption?: EncryptionProperties;

  /**
   * Indicates whether traffic on the non-ARM endpoint (Webhook/Agent) is allowed from the public internet
   */
  publicNetworkAccess?: boolean;

  /**
   * Indicates whether requests using non-AAD authentication are blocked
   */
  disableLocalAuth?: boolean;
}

/**
 * The response model for the list statistics operation.
 */
@pagedResult
model StatisticsListResult {
  /**
   * Gets or sets a list of statistics.
   */
  @items
  value?: Statistics[];
}

/**
 * Definition of the statistic.
 */
model Statistics {
  /**
   * Gets the property value of the statistic.
   */
  @visibility("read")
  counterProperty?: string;

  /**
   * Gets the value of the statistic.
   */
  @visibility("read")
  counterValue?: int64;

  /**
   * Gets the startTime of the statistic.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the endTime of the statistic.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets the id.
   */
  @visibility("read")
  id?: string;
}

/**
 * The response model for the get usage operation.
 */
@pagedResult
model UsageListResult {
  /**
   * Gets or sets usage.
   */
  @items
  value?: Usage[];
}

/**
 * Definition of Usage.
 */
model Usage {
  /**
   * Gets or sets the id of the resource.
   */
  id?: string;

  /**
   * Gets or sets the usage counter name.
   */
  name?: UsageCounterName;

  /**
   * Gets or sets the usage unit name.
   */
  unit?: string;

  /**
   * Gets or sets the current usage value.
   */
  currentValue?: float64;

  /**
   * Gets or sets max limit. -1 for unlimited
   */
  limit?: int64;

  /**
   * Gets or sets the throttle status.
   */
  throttleStatus?: string;
}

/**
 * Definition of usage counter name.
 */
model UsageCounterName {
  /**
   * Gets or sets the usage counter name.
   */
  value?: string;

  /**
   * Gets or sets the localized usage counter name.
   */
  localizedValue?: string;
}

@pagedResult
model KeyListResult {
  /**
   * Lists the automation keys.
   */
  @items
  keys?: Key[];
}

/**
 * Automation key which is used to register a DSC Node
 */
model Key {
  /**
   * Automation key name.
   */
  @visibility("read")
  @projectedName("json", "KeyName")
  keyName?: AutomationKeyName;

  /**
   * Automation key permissions.
   */
  @visibility("read")
  @projectedName("json", "Permissions")
  permissions?: AutomationKeyPermissions;

  /**
   * Value of the Automation Key used for registration.
   */
  @visibility("read")
  @projectedName("json", "Value")
  value?: string;
}

/**
 * Properties of the certificate.
 */
model CertificateProperties {
  /**
   * Gets the thumbprint of the certificate.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Gets the expiry time of the certificate.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Gets the is exportable flag of the certificate.
   */
  @visibility("read")
  isExportable?: boolean;

  /**
   * Gets the creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * The parameters supplied to the create or update or replace certificate operation.
 */
model CertificateCreateOrUpdateParameters {
  /**
   * Gets or sets the name of the certificate.
   */
  name: string;

  /**
   * Gets or sets the properties of the certificate.
   */
  properties: CertificateCreateOrUpdateProperties;
}

/**
 * The properties of the create certificate operation.
 */
model CertificateCreateOrUpdateProperties {
  /**
   * Gets or sets the base64 encoded value of the certificate.
   */
  base64Value: string;

  /**
   * Gets or sets the description of the certificate.
   */
  description?: string;

  /**
   * Gets or sets the thumbprint of the certificate.
   */
  thumbprint?: string;

  /**
   * Gets or sets the is exportable flag of the certificate.
   */
  isExportable?: boolean;
}

/**
 * The parameters supplied to the update certificate operation.
 */
model CertificateUpdateParameters {
  /**
   * Gets or sets the name of the certificate.
   */
  name?: string;

  /**
   * Gets or sets the properties of the certificate.
   */
  properties?: CertificateUpdateProperties;
}

/**
 * The properties of the update certificate operation
 */
model CertificateUpdateProperties {
  /**
   * Gets or sets the description of the certificate.
   */
  description?: string;
}

/**
 * Definition of the connection properties.
 */
model ConnectionProperties {
  /**
   * Gets or sets the connectionType of the connection.
   */
  connectionType?: ConnectionTypeAssociationProperty;

  /**
   * Gets the field definition values of the connection.
   */
  @visibility("read")
  fieldDefinitionValues?: Record<string>;

  /**
   * Gets the creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * The connection type property associated with the entity.
 */
model ConnectionTypeAssociationProperty {
  /**
   * Gets or sets the name of the connection type.
   */
  name?: string;
}

/**
 * The parameters supplied to the create or update connection operation.
 */
model ConnectionCreateOrUpdateParameters {
  /**
   * Gets or sets the name of the connection.
   */
  name: string;

  /**
   * Gets or sets the properties of the connection.
   */
  properties: ConnectionCreateOrUpdateProperties;
}

/**
 * The properties of the create connection properties
 */
model ConnectionCreateOrUpdateProperties {
  /**
   * Gets or sets the description of the connection.
   */
  description?: string;

  /**
   * Gets or sets the connectionType of the connection.
   */
  connectionType: ConnectionTypeAssociationProperty;

  /**
   * Gets or sets the field definition properties of the connection.
   */
  fieldDefinitionValues?: Record<string>;
}

/**
 * The parameters supplied to the update connection operation.
 */
model ConnectionUpdateParameters {
  /**
   * Gets or sets the name of the connection.
   */
  name?: string;

  /**
   * Gets or sets the properties of the connection.
   */
  properties?: ConnectionUpdateProperties;
}

/**
 * The properties of the update connection operation.
 */
model ConnectionUpdateProperties {
  /**
   * Gets or sets the description of the connection.
   */
  description?: string;

  /**
   * Gets or sets the field definition values of the connection.
   */
  fieldDefinitionValues?: Record<string>;
}

/**
 * Properties of the connection type.
 */
model ConnectionTypeProperties {
  /**
   * Gets or sets a Boolean value to indicate if the connection type is global.
   */
  isGlobal?: boolean;

  /**
   * Gets the field definitions of the connection type.
   */
  @visibility("read")
  fieldDefinitions?: Record<FieldDefinition>;

  /**
   * Gets the creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * Definition of the connection fields.
 */
model FieldDefinition {
  /**
   * Gets or sets the isEncrypted flag of the connection field definition.
   */
  isEncrypted?: boolean;

  /**
   * Gets or sets the isOptional flag of the connection field definition.
   */
  isOptional?: boolean;

  /**
   * Gets or sets the type of the connection field definition.
   */
  type: string;
}

/**
 * The parameters supplied to the create or update connection type operation.
 */
model ConnectionTypeCreateOrUpdateParameters {
  /**
   * Gets or sets the name of the connection type.
   */
  name: string;

  /**
   * Gets or sets the value of the connection type.
   */
  properties: ConnectionTypeCreateOrUpdateProperties;
}

/**
 * The properties of the create connection type.
 */
model ConnectionTypeCreateOrUpdateProperties {
  /**
   * Gets or sets a Boolean value to indicate if the connection type is global.
   */
  isGlobal?: boolean;

  /**
   * Gets or sets the field definitions of the connection type.
   */
  fieldDefinitions: Record<FieldDefinition>;
}

/**
 * Definition of the credential properties
 */
model CredentialProperties {
  /**
   * Gets the user name of the credential.
   */
  @visibility("read")
  userName?: string;

  /**
   * Gets the creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * The parameters supplied to the create or update credential operation.
 */
model CredentialCreateOrUpdateParameters {
  /**
   * Gets or sets the name of the credential.
   */
  name: string;

  /**
   * Gets or sets the properties of the credential.
   */
  properties: CredentialCreateOrUpdateProperties;
}

/**
 * The properties of the create credential operation.
 */
model CredentialCreateOrUpdateProperties {
  /**
   * Gets or sets the user name of the credential.
   */
  userName: string;

  /**
   * Gets or sets the password of the credential.
   */
  password: string;

  /**
   * Gets or sets the description of the credential.
   */
  description?: string;
}

/**
 * The parameters supplied to the Update credential operation.
 */
model CredentialUpdateParameters {
  /**
   * Gets or sets the name of the credential.
   */
  name?: string;

  /**
   * Gets or sets the properties of the variable.
   */
  properties?: CredentialUpdateProperties;
}

/**
 * The properties of the Update credential
 */
model CredentialUpdateProperties {
  /**
   * Gets or sets the user name of the credential.
   */
  userName?: string;

  /**
   * Gets or sets the password of the credential.
   */
  password?: string;

  /**
   * Gets or sets the description of the credential.
   */
  description?: string;
}

/**
 * Definition of job schedule parameters.
 */
model JobScheduleProperties {
  /**
   * Gets or sets the id of job schedule.
   */
  jobScheduleId?: string;

  /**
   * Gets or sets the schedule.
   */
  schedule?: ScheduleAssociationProperty;

  /**
   * Gets or sets the runbook.
   */
  runbook?: RunbookAssociationProperty;

  /**
   * Gets or sets the hybrid worker group that the scheduled job should run on.
   */
  runOn?: string;

  /**
   * Gets or sets the parameters of the job schedule.
   */
  parameters?: Record<string>;
}

/**
 * The schedule property associated with the entity.
 */
model ScheduleAssociationProperty {
  /**
   * Gets or sets the name of the Schedule.
   */
  name?: string;
}

/**
 * The runbook property associated with the entity.
 */
model RunbookAssociationProperty {
  /**
   * Gets or sets the name of the runbook.
   */
  name?: string;
}

/**
 * The parameters supplied to the create job schedule operation.
 */
model JobScheduleCreateParameters {
  /**
   * Gets or sets the list of job schedule properties.
   */
  properties: JobScheduleCreateProperties;
}

/**
 * The parameters supplied to the create job schedule operation.
 */
model JobScheduleCreateProperties {
  /**
   * Gets or sets the schedule.
   */
  schedule: ScheduleAssociationProperty;

  /**
   * Gets or sets the runbook.
   */
  runbook: RunbookAssociationProperty;

  /**
   * Gets or sets the hybrid worker group that the scheduled job should run on.
   */
  runOn?: string;

  /**
   * Gets or sets a list of job properties.
   */
  parameters?: Record<string>;
}

/**
 * Definition of the linked workspace.
 */
model LinkedWorkspace {
  /**
   * Gets the id of the linked workspace.
   */
  @visibility("read")
  id?: string;
}

/**
 * Definition of the activity.
 */
model Activity {
  /**
   * Gets or sets the id of the resource.
   */
  id?: string;

  /**
   * Gets the name of the activity.
   */
  @visibility("read")
  name?: string;

  /**
   * Gets or sets the properties of the activity.
   */
  properties?: ActivityProperties;
}

/**
 * Properties of the activity.
 */
model ActivityProperties {
  /**
   * Gets or sets the user name of the activity.
   */
  definition?: string;

  /**
   * Gets or sets the parameter sets of the activity.
   */
  parameterSets?: ActivityParameterSet[];

  /**
   * Gets or sets the output types of the activity.
   */
  outputTypes?: ActivityOutputType[];

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * Definition of the activity parameter set.
 */
model ActivityParameterSet {
  /**
   * Gets or sets the name of the activity parameter set.
   */
  name?: string;

  /**
   * Gets or sets the parameters of the activity parameter set.
   */
  parameters?: ActivityParameter[];
}

/**
 * Definition of the activity parameter.
 */
model ActivityParameter {
  /**
   * Gets or sets the name of the activity parameter.
   */
  name?: string;

  /**
   * Gets or sets the type of the activity parameter.
   */
  type?: string;

  /**
   * Gets or sets a Boolean value that indicates true if the parameter is required. If the value is false, the parameter is optional.
   */
  isMandatory?: boolean;

  /**
   * Gets or sets a Boolean value that indicates true if the parameter is dynamic.
   */
  isDynamic?: boolean;

  /**
   * Gets or sets the position of the activity parameter.
   */
  position?: int64;

  /**
   * Gets or sets a Boolean value that indicates true if the parameter can take values from the incoming pipeline objects. This setting is used if the cmdlet must access the complete input object. false indicates that the parameter cannot take values from the complete input object.
   */
  valueFromPipeline?: boolean;

  /**
   * Gets or sets a Boolean value that indicates true if the parameter can be filled from a property of the incoming pipeline object that has the same name as this parameter. false indicates that the parameter cannot be filled from the incoming pipeline object property with the same name.
   */
  valueFromPipelineByPropertyName?: boolean;

  /**
   * Gets or sets a Boolean value that indicates true if the cmdlet parameter accepts all the remaining command-line arguments that are associated with this parameter in the form of an array. false if the cmdlet parameter does not accept all the remaining argument values.
   */
  valueFromRemainingArguments?: boolean;

  /**
   * Gets or sets the description of the activity parameter.
   */
  description?: string;

  /**
   * Gets or sets the validation set of activity parameter.
   */
  validationSet?: ActivityParameterValidationSet[];
}

/**
 * Definition of the activity parameter validation set.
 */
model ActivityParameterValidationSet {
  /**
   * Gets or sets the name of the activity parameter validation set member.
   */
  memberValue?: string;
}

/**
 * Definition of the activity output type.
 */
model ActivityOutputType {
  /**
   * Gets or sets the name of the activity output type.
   */
  name?: string;

  /**
   * Gets or sets the type of the activity output type.
   */
  type?: string;
}

/**
 * The response model for the list activity operation.
 */
model ActivityListResult is Azure.Core.Page<Activity>;

/**
 * The parameters supplied to the create or update module operation.
 */
model ModuleCreateOrUpdateParameters {
  /**
   * Gets or sets the module create properties.
   */
  properties: ModuleCreateOrUpdateProperties;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the create or update module properties.
 */
model ModuleCreateOrUpdateProperties {
  /**
   * Gets or sets the module content link.
   */
  contentLink: ContentLink;
}

/**
 * The parameters supplied to the update module operation.
 */
model ModuleUpdateParameters {
  /**
   * Gets or sets the module update properties.
   */
  properties?: ModuleUpdateProperties;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the update properties.
 */
model ModuleUpdateProperties {
  /**
   * Gets or sets the module content link.
   */
  contentLink?: ContentLink;
}

/**
 * The response model for the list fields operation.
 */
@pagedResult
model TypeFieldListResult {
  /**
   * Gets or sets a list of fields.
   */
  @items
  value?: TypeField[];
}

/**
 * Information about a field of a type.
 */
model TypeField {
  /**
   * Gets or sets the name of the field.
   */
  name?: string;

  /**
   * Gets or sets the type of the field.
   */
  type?: string;
}

/**
 * The parameters supplied to the create or update schedule operation.
 */
model ScheduleCreateOrUpdateParameters {
  /**
   * Gets or sets the name of the Schedule.
   */
  name: string;

  /**
   * Gets or sets the list of schedule properties.
   */
  properties: ScheduleCreateOrUpdateProperties;
}

/**
 * The parameters supplied to the create or update schedule operation.
 */
model ScheduleCreateOrUpdateProperties {
  /**
   * Gets or sets the description of the schedule.
   */
  description?: string;

  /**
   * Gets or sets the start time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  /**
   * Gets or sets the end time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Gets or sets the interval of the schedule.
   */
  interval?: unknown;

  /**
   * Gets or sets the frequency of the schedule.
   */
  frequency: ScheduleFrequency;

  /**
   * Gets or sets the time zone of the schedule.
   */
  timeZone?: string;

  /**
   * Gets or sets the AdvancedSchedule.
   */
  advancedSchedule?: AdvancedSchedule;
}

/**
 * The properties of the create Advanced Schedule.
 */
model AdvancedSchedule {
  /**
   * Days of the week that the job should execute on.
   */
  weekDays?: string[];

  /**
   * Days of the month that the job should execute on. Must be between 1 and 31.
   */
  monthDays?: int32[];

  /**
   * Occurrences of days within a month.
   */
  monthlyOccurrences?: AdvancedScheduleMonthlyOccurrence[];
}

/**
 * The properties of the create advanced schedule monthly occurrence.
 */
model AdvancedScheduleMonthlyOccurrence {
  /**
   * Occurrence of the week within the month. Must be between 1 and 5
   */
  occurrence?: int32;

  /**
   * Day of the occurrence. Must be one of monday, tuesday, wednesday, thursday, friday, saturday, sunday.
   */
  day?: ScheduleDay;
}

/**
 * Definition of schedule parameters.
 */
model ScheduleProperties {
  /**
   * Gets or sets the start time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the start time's offset in minutes.
   */
  @visibility("read")
  startTimeOffsetMinutes?: float64;

  /**
   * Gets or sets the end time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Gets or sets the expiry time's offset in minutes.
   */
  expiryTimeOffsetMinutes?: float64;

  /**
   * Gets or sets a value indicating whether this schedule is enabled.
   */
  isEnabled?: boolean;

  /**
   * Gets or sets the next run time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRun?: utcDateTime;

  /**
   * Gets or sets the next run time's offset in minutes.
   */
  nextRunOffsetMinutes?: float64;

  /**
   * Gets or sets the interval of the schedule.
   */
  interval?: unknown;

  /**
   * Gets or sets the frequency of the schedule.
   */
  frequency?: ScheduleFrequency;

  /**
   * Gets or sets the time zone of the schedule.
   */
  timeZone?: string;

  /**
   * Gets or sets the advanced schedule.
   */
  advancedSchedule?: AdvancedSchedule;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * The parameters supplied to the update schedule operation.
 */
model ScheduleUpdateParameters {
  /**
   * Gets or sets the name of the Schedule.
   */
  name?: string;

  /**
   * Gets or sets the list of schedule properties.
   */
  properties?: ScheduleUpdateProperties;
}

/**
 * The parameters supplied to the update schedule operation.
 */
model ScheduleUpdateProperties {
  /**
   * Gets or sets the description of the schedule.
   */
  description?: string;

  /**
   * Gets or sets a value indicating whether this schedule is enabled.
   */
  isEnabled?: boolean;
}

/**
 * The parameters supplied to the create or update variable operation.
 */
model VariableCreateOrUpdateParameters {
  /**
   * Gets or sets the name of the variable.
   */
  name: string;

  /**
   * Gets or sets the properties of the variable.
   */
  properties: VariableCreateOrUpdateProperties;
}

/**
 * The properties of the create variable operation.
 */
model VariableCreateOrUpdateProperties {
  /**
   * Gets or sets the value of the variable.
   */
  value?: string;

  /**
   * Gets or sets the description of the variable.
   */
  description?: string;

  /**
   * Gets or sets the encrypted flag of the variable.
   */
  isEncrypted?: boolean;
}

/**
 * Definition of the variable properties
 */
model VariableProperties {
  /**
   * Gets or sets the value of the variable.
   */
  value?: string;

  /**
   * Gets or sets the encrypted flag of the variable.
   */
  isEncrypted?: boolean;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * The parameters supplied to the update variable operation.
 */
model VariableUpdateParameters {
  /**
   * Gets or sets the name of the variable.
   */
  name?: string;

  /**
   * Gets or sets the value of the variable.
   */
  properties?: VariableUpdateProperties;
}

/**
 * The properties of the update variable
 */
model VariableUpdateProperties {
  /**
   * Gets or sets the value of the variable.
   */
  value?: string;

  /**
   * Gets or sets the description of the variable.
   */
  description?: string;
}

/**
 * Definition of the watcher properties
 */
model WatcherProperties {
  /**
   * Gets or sets the frequency at which the watcher is invoked.
   */
  executionFrequencyInSeconds?: int64;

  /**
   * Gets or sets the name of the script the watcher is attached to, i.e. the name of an existing runbook.
   */
  scriptName?: string;

  /**
   * Gets or sets the parameters of the script.
   */
  scriptParameters?: Record<string>;

  /**
   * Gets or sets the name of the hybrid worker group the watcher will run on.
   */
  scriptRunOn?: string;

  /**
   * Gets the current status of the watcher.
   */
  @visibility("read")
  status?: string;

  /**
   * Gets or sets the creation time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Details of the user who last modified the watcher.
   */
  @visibility("read")
  lastModifiedBy?: string;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

model WatcherUpdateParameters {
  /**
   * Gets or sets the watcher update properties.
   */
  properties?: WatcherUpdateProperties;

  /**
   * Gets or sets the name of the resource.
   */
  name?: string;
}

/**
 * The properties of the update watcher operation.
 */
model WatcherUpdateProperties {
  /**
   * Gets or sets the frequency at which the watcher is invoked.
   */
  executionFrequencyInSeconds?: int64;
}

/**
 * Definition of the configuration property type.
 */
model DscConfigurationProperties {
  /**
   * Gets or sets the provisioning state of the configuration.
   */
  provisioningState?: "Succeeded";

  /**
   * Gets or sets the job count of the configuration.
   */
  jobCount?: int32;

  /**
   * Gets or sets the configuration parameters.
   */
  parameters?: Record<DscConfigurationParameter>;

  /**
   * Gets or sets the source.
   */
  source?: ContentSource;

  /**
   * Gets or sets the state of the configuration.
   */
  state?: DscConfigurationState;

  /**
   * Gets or sets verbose log option.
   */
  logVerbose?: boolean;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets the number of compiled node configurations.
   */
  nodeConfigurationCount?: int32;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * Definition of the configuration parameter type.
 */
model DscConfigurationParameter {
  /**
   * Gets or sets the type of the parameter.
   */
  type?: string;

  /**
   * Gets or sets a Boolean value to indicate whether the parameter is mandatory or not.
   */
  isMandatory?: boolean;

  /**
   * Get or sets the position of the parameter.
   */
  position?: int32;

  /**
   * Gets or sets the default value of parameter.
   */
  defaultValue?: string;
}

/**
 * The parameters supplied to the create or update configuration operation.
 */
model DscConfigurationCreateOrUpdateParameters {
  /**
   * Gets or sets configuration create or update properties.
   */
  properties: DscConfigurationCreateOrUpdateProperties;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The properties to create or update configuration.
 */
model DscConfigurationCreateOrUpdateProperties {
  /**
   * Gets or sets verbose log option.
   */
  logVerbose?: boolean;

  /**
   * Gets or sets progress log option.
   */
  logProgress?: boolean;

  /**
   * Gets or sets the source.
   */
  source: ContentSource;

  /**
   * Gets or sets the configuration parameters.
   */
  parameters?: Record<DscConfigurationParameter>;

  /**
   * Gets or sets the description of the configuration.
   */
  description?: string;
}

/**
 * The parameters supplied to the create or update configuration operation.
 */
model DscConfigurationUpdateParameters {
  /**
   * Gets or sets configuration create or update properties.
   */
  properties?: DscConfigurationCreateOrUpdateProperties;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * Definition of job properties.
 */
model JobProperties {
  /**
   * Gets or sets the runbook.
   */
  runbook?: RunbookAssociationProperty;

  /**
   * Gets or sets the job started by.
   */
  startedBy?: string;

  /**
   * Gets or sets the runOn which specifies the group name where the job is to be executed.
   */
  runOn?: string;

  /**
   * Gets or sets the id of the job.
   */
  jobId?: string;

  /**
   * Gets or sets the creation time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the status of the job.
   */
  status?: JobStatus;

  /**
   * Gets or sets the status details of the job.
   */
  statusDetails?: string;

  /**
   * Gets or sets the start time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets the end time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets or sets the exception of the job.
   */
  exception?: string;

  /**
   * Gets or sets the last modified time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the last status modified time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusModifiedTime?: utcDateTime;

  /**
   * Gets or sets the parameters of the job.
   */
  parameters?: Record<string>;

  /**
   * The current provisioning state of the job.
   */
  provisioningState?: JobProvisioningState;
}

/**
 * The parameters supplied to the create job operation.
 */
model JobCreateParameters {
  /**
   * Gets or sets the list of job properties.
   */
  properties: JobCreateProperties;
}

model JobCreateProperties {
  /**
   * Gets or sets the runbook.
   */
  runbook?: RunbookAssociationProperty;

  /**
   * Gets or sets the parameters of the job.
   */
  parameters?: Record<string>;

  /**
   * Gets or sets the runOn which specifies the group name where the job is to be executed.
   */
  runOn?: string;
}

/**
 * Job collection item properties.
 */
model JobCollectionItem extends ProxyResource {
  /**
   * Job properties.
   */
  properties: JobCollectionItemProperties;
}

/**
 * Job collection item properties.
 */
model JobCollectionItemProperties {
  /**
   * The runbook association.
   */
  @visibility("read")
  runbook?: RunbookAssociationProperty;

  /**
   * The id of the job.
   */
  @visibility("read")
  jobId?: string;

  /**
   * The creation time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The status of the job.
   */
  @visibility("read")
  status?: JobStatus;

  /**
   * The start time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The end time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The last modified time of the job.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * The provisioning state of a resource.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Specifies the runOn group name where the job was executed.
   */
  runOn?: string;
}

/**
 * Graphical Runbook Content
 */
model GraphicalRunbookContent {
  /**
   * Raw graphical Runbook content.
   */
  rawContent?: RawGraphicalRunbookContent;

  /**
   * Graphical Runbook content as JSON
   */
  graphRunbookJson?: string;
}

/**
 * Raw Graphical Runbook content
 */
model RawGraphicalRunbookContent {
  /**
   * Schema version of the serializer.
   */
  schemaVersion?: string;

  /**
   * Serialized Graphical runbook
   */
  runbookDefinition?: string;

  /**
   * Runbook Type
   */
  runbookType?: GraphRunbookType;
}

/**
 * Software update configuration properties.
 */
model SoftwareUpdateConfigurationProperties {
  /**
   * update specific properties for the Software update configuration
   */
  updateConfiguration: UpdateConfiguration;

  /**
   * Schedule information for the Software update configuration
   */
  scheduleInfo: SUCScheduleProperties;

  /**
   * Provisioning state for the software update configuration, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Details of provisioning error
   */
  error?: ErrorResponse;

  /**
   * Creation time of the resource, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * CreatedBy property, which only appears in the response.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Last time resource was modified, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * LastModifiedBy property, which only appears in the response.
   */
  @visibility("read")
  lastModifiedBy?: string;

  /**
   * Tasks information for the Software update configuration.
   */
  tasks?: SoftwareUpdateConfigurationTasks;
}

/**
 * Update specific properties of the software update configuration.
 */
model UpdateConfiguration {
  /**
   * operating system of target machines
   */
  operatingSystem: OperatingSystemType;

  /**
   * Windows specific update configuration.
   */
  windows?: WindowsProperties;

  /**
   * Linux specific update configuration.
   */
  linux?: LinuxProperties;

  /**
   * Maximum time allowed for the software update configuration run. Duration needs to be specified using the format PT[n]H[n]M[n]S as per ISO8601
   */
  duration?: duration;

  /**
   * List of azure resource Ids for azure virtual machines targeted by the software update configuration.
   */
  azureVirtualMachines?: string[];

  /**
   * List of names of non-azure machines targeted by the software update configuration.
   */
  nonAzureComputerNames?: string[];

  /**
   * Group targets for the software update configuration.
   */
  targets?: TargetProperties;
}

/**
 * Windows specific update configuration.
 */
model WindowsProperties {
  /**
   * Update classification included in the software update configuration. A comma separated string with required values
   */
  includedUpdateClassifications?: WindowsUpdateClasses;

  /**
   * KB numbers excluded from the software update configuration.
   */
  excludedKbNumbers?: string[];

  /**
   * KB numbers included from the software update configuration.
   */
  includedKbNumbers?: string[];

  /**
   * Reboot setting for the software update configuration.
   */
  rebootSetting?: string;
}

/**
 * Linux specific update configuration.
 */
model LinuxProperties {
  /**
   * Update classifications included in the software update configuration.
   */
  includedPackageClassifications?: LinuxUpdateClasses;

  /**
   * packages excluded from the software update configuration.
   */
  excludedPackageNameMasks?: string[];

  /**
   * packages included from the software update configuration.
   */
  includedPackageNameMasks?: string[];

  /**
   * Reboot setting for the software update configuration.
   */
  rebootSetting?: string;
}

/**
 * Group specific to the update configuration.
 */
model TargetProperties {
  /**
   * List of Azure queries in the software update configuration.
   */
  azureQueries?: AzureQueryProperties[];

  /**
   * List of non Azure queries in the software update configuration.
   */
  nonAzureQueries?: NonAzureQueryProperties[];
}

/**
 * Azure query for the update configuration.
 */
model AzureQueryProperties {
  /**
   * List of Subscription or Resource Group ARM Ids.
   */
  scope?: string[];

  /**
   * List of locations to scope the query to.
   */
  locations?: string[];

  /**
   * Tag settings for the VM.
   */
  tagSettings?: TagSettingsProperties;
}

/**
 * Tag filter information for the VM.
 */
model TagSettingsProperties {
  /**
   * Dictionary of tags with its list of values.
   */
  tags?: Record<string[]>;

  /**
   * Filter VMs by Any or All specified tags.
   */
  filterOperator?: TagOperators;
}

/**
 * Non Azure query for the update configuration.
 */
model NonAzureQueryProperties {
  /**
   * Log Analytics Saved Search name.
   */
  functionAlias?: string;

  /**
   * Workspace Id for Log Analytics in which the saved Search is resided.
   */
  workspaceId?: string;
}

/**
 * Definition of schedule parameters.
 */
model SUCScheduleProperties {
  /**
   * Gets or sets the start time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the start time's offset in minutes.
   */
  @visibility("read")
  startTimeOffsetMinutes?: float64;

  /**
   * Gets or sets the end time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Gets or sets the expiry time's offset in minutes.
   */
  expiryTimeOffsetMinutes?: float64;

  /**
   * Gets or sets a value indicating whether this schedule is enabled.
   */
  isEnabled?: boolean;

  /**
   * Gets or sets the next run time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRun?: utcDateTime;

  /**
   * Gets or sets the next run time's offset in minutes.
   */
  nextRunOffsetMinutes?: float64;

  /**
   * Gets or sets the interval of the schedule.
   */
  interval?: int64;

  /**
   * Gets or sets the frequency of the schedule.
   */
  frequency?: ScheduleFrequency;

  /**
   * Gets or sets the time zone of the schedule.
   */
  timeZone?: string;

  /**
   * Gets or sets the advanced schedule.
   */
  advancedSchedule?: AdvancedSchedule;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * Task properties of the software update configuration.
 */
model SoftwareUpdateConfigurationTasks {
  /**
   * Pre task properties.
   */
  preTask?: TaskProperties;

  /**
   * Post task properties.
   */
  postTask?: TaskProperties;
}

/**
 * Task properties of the software update configuration.
 */
model TaskProperties {
  /**
   * Gets or sets the parameters of the task.
   */
  parameters?: Record<string>;

  /**
   * Gets or sets the name of the runbook.
   */
  source?: string;
}

/**
 * Software update configuration collection item properties.
 */
model SoftwareUpdateConfigurationCollectionItem {
  /**
   * Name of the software update configuration.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource Id of the software update configuration
   */
  @visibility("read")
  id?: string;

  /**
   * Software update configuration properties.
   */
  properties: SoftwareUpdateConfigurationCollectionItemProperties;
}

/**
 * Software update configuration collection item properties.
 */
model SoftwareUpdateConfigurationCollectionItemProperties {
  /**
   * Update specific properties of the software update configuration.
   */
  updateConfiguration?: UpdateConfiguration;

  /**
   * Pre and Post Tasks defined
   */
  tasks?: SoftwareUpdateConfigurationTasks;

  /**
   * execution frequency of the schedule associated with the software update configuration
   */
  frequency?: ScheduleFrequency;

  /**
   * the start time of the update.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Creation time of the software update configuration, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Last time software update configuration was modified, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Provisioning state for the software update configuration, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * ext run time of the update.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRun?: utcDateTime;
}

/**
 * Software update configuration Run properties.
 */
model SoftwareUpdateConfigurationRun {
  /**
   * Name of the software update configuration run.
   */
  @visibility("read")
  name?: string;

  /**
   * Resource Id of the software update configuration run
   */
  @visibility("read")
  id?: string;

  /**
   * Software update configuration Run properties.
   */
  properties?: SoftwareUpdateConfigurationRunProperties;
}

/**
 * Software update configuration properties.
 */
model SoftwareUpdateConfigurationRunProperties {
  /**
   * software update configuration triggered this run
   */
  softwareUpdateConfiguration?: UpdateConfigurationNavigation;

  /**
   * Status of the software update configuration run.
   */
  @visibility("read")
  status?: string;

  /**
   * Configured duration for the software update configuration run.
   */
  @visibility("read")
  configuredDuration?: duration;

  /**
   * Operating system target of the software update configuration triggered this run
   */
  @visibility("read")
  osType?: string;

  /**
   * Start time of the software update configuration run.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the software update configuration run.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Number of computers in the software update configuration run.
   */
  @visibility("read")
  computerCount?: int32;

  /**
   * Number of computers with failed status.
   */
  @visibility("read")
  failedCount?: int32;

  /**
   * Creation time of the resource, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * CreatedBy property, which only appears in the response.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Last time resource was modified, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * LastModifiedBy property, which only appears in the response.
   */
  @visibility("read")
  lastModifiedBy?: string;

  /**
   * Software update configuration tasks triggered in this run
   */
  tasks?: SoftwareUpdateConfigurationRunTasks;
}

/**
 * Software update configuration Run Navigation model.
 */
model UpdateConfigurationNavigation {
  /**
   * Name of the software update configuration triggered the software update configuration run
   */
  @visibility("read")
  name?: string;
}

/**
 * Software update configuration run tasks model.
 */
model SoftwareUpdateConfigurationRunTasks {
  /**
   * Pre task properties.
   */
  preTask?: SoftwareUpdateConfigurationRunTaskProperties;

  /**
   * Post task properties.
   */
  postTask?: SoftwareUpdateConfigurationRunTaskProperties;
}

/**
 * Task properties of the software update configuration.
 */
model SoftwareUpdateConfigurationRunTaskProperties {
  /**
   * The status of the task.
   */
  status?: string;

  /**
   * The name of the source of the task.
   */
  source?: string;

  /**
   * The job id of the task.
   */
  jobId?: string;
}

/**
 * result of listing all software update configuration runs
 */
model SoftwareUpdateConfigurationRunListResult {
  /**
   * outer object returned when listing all software update configuration runs
   */
  value?: SoftwareUpdateConfigurationRun[];

  /**
   * link to next page of results.
   */
  nextLink?: string;
}

/**
 * Software update configuration machine run model.
 */
model SoftwareUpdateConfigurationMachineRun {
  /**
   * Name of the software update configuration machine run
   */
  @visibility("read")
  name?: string;

  /**
   * Resource Id of the software update configuration machine run
   */
  @visibility("read")
  id?: string;

  /**
   * Software update configuration machine run properties.
   */
  properties?: UpdateConfigurationMachineRunProperties;
}

/**
 * Software update configuration machine run properties.
 */
model UpdateConfigurationMachineRunProperties {
  /**
   * name of the updated computer
   */
  @visibility("read")
  targetComputer?: string;

  /**
   * type of the updated computer.
   */
  @visibility("read")
  targetComputerType?: string;

  /**
   * software update configuration triggered this run
   */
  softwareUpdateConfiguration?: UpdateConfigurationNavigation;

  /**
   * Status of the software update configuration machine run.
   */
  @visibility("read")
  status?: string;

  /**
   * Operating system target of the software update configuration triggered this run
   */
  @visibility("read")
  osType?: string;

  /**
   * correlation id of the software update configuration machine run
   */
  @visibility("read")
  correlationId?: string;

  /**
   * source computer id of the software update configuration machine run
   */
  @visibility("read")
  sourceComputerId?: string;

  /**
   * Start time of the software update configuration machine run.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the software update configuration machine run.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * configured duration for the software update configuration run.
   */
  @visibility("read")
  configuredDuration?: duration;

  /**
   * Job associated with the software update configuration machine run
   */
  job?: JobNavigation;

  /**
   * Creation time of the resource, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * createdBy property, which only appears in the response.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Last time resource was modified, which only appears in the response.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * lastModifiedBy property, which only appears in the response.
   */
  @visibility("read")
  lastModifiedBy?: string;

  /**
   * Details of provisioning error
   */
  error?: ErrorResponse;
}

/**
 * Software update configuration machine run job navigation properties.
 */
model JobNavigation {
  /**
   * Id of the job associated with the software update configuration run
   */
  @visibility("read")
  id?: string;
}

/**
 * result of listing all software update configuration machine runs
 */
model SoftwareUpdateConfigurationMachineRunListResult {
  /**
   * outer object returned when listing all software update configuration machine runs
   */
  value?: SoftwareUpdateConfigurationMachineRun[];

  /**
   * link to next page of results.
   */
  nextLink?: string;
}

model RunbookDraft {
  /**
   * Gets or sets whether runbook is in edit mode.
   */
  inEdit?: boolean;

  /**
   * Gets or sets the draft runbook content link.
   */
  draftContentLink?: ContentLink;

  /**
   * Gets or sets the creation time of the runbook draft.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time of the runbook draft.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the runbook draft parameters.
   */
  parameters?: Record<RunbookParameter>;

  /**
   * Gets or sets the runbook output types.
   */
  outputTypes?: string[];
}

/**
 * Definition of the runbook parameter type.
 */
model RunbookParameter {
  /**
   * Gets or sets the type of the parameter.
   */
  type?: string;

  /**
   * Gets or sets a Boolean value to indicate whether the parameter is mandatory or not.
   */
  isMandatory?: boolean;

  /**
   * Get or sets the position of the parameter.
   */
  position?: int32;

  /**
   * Gets or sets the default value of parameter.
   */
  defaultValue?: string;
}

/**
 * The response model for the undo edit runbook operation.
 */
model RunbookDraftUndoEditResult {
  statusCode?: HttpStatusCode;
  requestId?: string;
}

/**
 * Definition of the runbook property type.
 */
model RunbookProperties {
  /**
   * Gets or sets the type of the runbook.
   */
  runbookType?: RunbookTypeEnum;

  /**
   * Gets or sets the published runbook content link.
   */
  publishContentLink?: ContentLink;

  /**
   * Gets or sets the state of the runbook.
   */
  state?: RunbookState;

  /**
   * Gets or sets verbose log option.
   */
  logVerbose?: boolean;

  /**
   * Gets or sets progress log option.
   */
  logProgress?: boolean;

  /**
   * Gets or sets the option to log activity trace of the runbook.
   */
  logActivityTrace?: int32;

  /**
   * Gets or sets the job count of the runbook.
   */
  jobCount?: int32;

  /**
   * Gets or sets the runbook parameters.
   */
  parameters?: Record<RunbookParameter>;

  /**
   * Gets or sets the runbook output types.
   */
  outputTypes?: string[];

  /**
   * Gets or sets the draft runbook properties.
   */
  draft?: RunbookDraft;

  /**
   * Gets or sets the provisioning state of the runbook.
   */
  provisioningState?: "Succeeded";

  /**
   * Gets or sets the last modified by.
   */
  lastModifiedBy?: string;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * The parameters supplied to the create or update runbook operation.
 */
model RunbookCreateOrUpdateParameters {
  /**
   * Gets or sets runbook create or update properties.
   */
  properties: RunbookCreateOrUpdateProperties;

  /**
   * Gets or sets the name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the create or update runbook properties.
 */
model RunbookCreateOrUpdateProperties {
  /**
   * Gets or sets verbose log option.
   */
  logVerbose?: boolean;

  /**
   * Gets or sets progress log option.
   */
  logProgress?: boolean;

  /**
   * Gets or sets the type of the runbook.
   */
  runbookType: RunbookTypeEnum;

  /**
   * Gets or sets the draft runbook properties.
   */
  draft?: RunbookDraft;

  /**
   * Gets or sets the published runbook content link.
   */
  publishContentLink?: ContentLink;

  /**
   * Gets or sets the description of the runbook.
   */
  description?: string;

  /**
   * Gets or sets the activity-level tracing options of the runbook.
   */
  logActivityTrace?: int32;
}

/**
 * The parameters supplied to the update runbook operation.
 */
model RunbookUpdateParameters {
  /**
   * Gets or sets the runbook update properties.
   */
  properties?: RunbookUpdateProperties;

  /**
   * Gets or sets the name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  tags?: Record<string>;
}

/**
 * The parameters supplied to the update runbook properties.
 */
model RunbookUpdateProperties {
  /**
   * Gets or sets the description of the runbook.
   */
  description?: string;

  /**
   * Gets or sets verbose log option.
   */
  logVerbose?: boolean;

  /**
   * Gets or sets progress log option.
   */
  logProgress?: boolean;

  /**
   * Gets or sets the activity-level tracing options of the runbook.
   */
  logActivityTrace?: int32;
}

/**
 * The parameters supplied to the create test job operation.
 */
model TestJobCreateParameters {
  /**
   * Gets or sets the parameters of the test job.
   */
  parameters?: Record<string>;

  /**
   * Gets or sets the runOn which specifies the group name where the job is to be executed.
   */
  runOn?: string;
}

/**
 * Definition of the test job.
 */
model TestJob {
  /**
   * Gets or sets the creation time of the test job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the status of the test job.
   */
  status?: string;

  /**
   * Gets or sets the status details of the test job.
   */
  statusDetails?: string;

  /**
   * Gets or sets the runOn which specifies the group name where the job is to be executed.
   */
  runOn?: string;

  /**
   * Gets or sets the start time of the test job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets or sets the end time of the test job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Gets or sets the exception of the test job.
   */
  exception?: string;

  /**
   * Gets or sets the last modified time of the test job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the last status modified time of the test job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusModifiedTime?: utcDateTime;

  /**
   * Gets or sets the parameters of the test job.
   */
  parameters?: Record<string>;

  /**
   * The activity-level tracing options of the runbook.
   */
  logActivityTrace?: int32;
}

/**
 * Definition of the webhook properties
 */
model WebhookProperties {
  /**
   * Gets or sets the value of the enabled flag of the webhook.
   */
  isEnabled?: boolean;

  /**
   * Gets or sets the webhook uri.
   */
  uri?: string;

  /**
   * Gets or sets the expiry time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Gets or sets the last invoked time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastInvokedTime?: utcDateTime;

  /**
   * Gets or sets the parameters of the job that is created when the webhook calls the runbook it is associated with.
   */
  parameters?: Record<string>;

  /**
   * Gets or sets the runbook the webhook is associated with.
   */
  runbook?: RunbookAssociationProperty;

  /**
   * Gets or sets the name of the hybrid worker group the webhook job will run on.
   */
  runOn?: string;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Details of the user who last modified the Webhook
   */
  lastModifiedBy?: string;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * The parameters supplied to the create or update webhook operation.
 */
model WebhookCreateOrUpdateParameters {
  /**
   * Gets or sets the name of the webhook.
   */
  name: string;

  /**
   * Gets or sets the properties of the webhook.
   */
  properties: WebhookCreateOrUpdateProperties;
}

/**
 * The properties of the create webhook operation.
 */
model WebhookCreateOrUpdateProperties {
  /**
   * Gets or sets the value of the enabled flag of webhook.
   */
  isEnabled?: boolean;

  /**
   * Gets or sets the uri.
   */
  uri?: string;

  /**
   * Gets or sets the expiry time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Gets or sets the parameters of the job.
   */
  parameters?: Record<string>;

  /**
   * Gets or sets the runbook.
   */
  runbook?: RunbookAssociationProperty;

  /**
   * Gets or sets the name of the hybrid worker group the webhook job will run on.
   */
  runOn?: string;
}

/**
 * The parameters supplied to the update webhook operation.
 */
model WebhookUpdateParameters {
  /**
   * Gets or sets the name of the webhook.
   */
  name?: string;

  /**
   * Gets or sets the value of the webhook.
   */
  properties?: WebhookUpdateProperties;
}

/**
 * The properties of the update webhook.
 */
model WebhookUpdateProperties {
  /**
   * Gets or sets the value of the enabled flag of webhook.
   */
  isEnabled?: boolean;

  /**
   * Gets or sets the name of the hybrid worker group the webhook job will run on.
   */
  runOn?: string;

  /**
   * Gets or sets the parameters of the job.
   */
  parameters?: Record<string>;

  /**
   * Gets or sets the description of the webhook.
   */
  description?: string;
}

/**
 * Definition of hybrid runbook worker property.
 */
model HybridRunbookWorkerProperties {
  /**
   * Gets or sets the assigned machine IP address.
   */
  ip?: string;

  /**
   * Gets or sets the registration time of the worker machine.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registeredDateTime?: utcDateTime;

  /**
   * Last Heartbeat from the Worker
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSeenDateTime?: utcDateTime;

  /**
   * Azure Resource Manager Id for a virtual machine.
   */
  vmResourceId?: string;

  /**
   * Type of the HybridWorker.
   */
  workerType?: WorkerType;

  /**
   * Name of the HybridWorker.
   */
  workerName?: string;
}

/**
 * The parameters supplied to the create hybrid runbook worker operation.
 */
model HybridRunbookWorkerCreateParameters {
  /**
   * Gets or sets hybrid runbook worker group create or update properties.
   */
  properties: HybridRunbookWorkerCreateOrUpdateParameters;

  /**
   * Gets or sets the name of the resource.
   */
  name?: string;
}

/**
 * The parameters supplied to the create or update hybrid runbook worker operation.
 */
model HybridRunbookWorkerCreateOrUpdateParameters {
  /**
   * Azure Resource Manager Id for a virtual machine.
   */
  vmResourceId?: string;
}

/**
 * Parameters supplied to move hybrid worker operation.
 */
model HybridRunbookWorkerMoveParameters {
  /**
   * Gets or sets the target hybrid runbook worker group.
   */
  hybridRunbookWorkerGroupName?: string;
}

/**
 * The response model for the list deleted automation account.
 */
model DeletedAutomationAccountListResult {
  /**
   * Gets or sets the list of deleted automation accounts.
   */
  value?: DeletedAutomationAccount[];
}

/**
 * Definition of the deleted automation account type.
 */
model DeletedAutomationAccount {
  /**
   * Gets or sets the automation account properties.
   */
  properties?: DeletedAutomationAccountProperties;

  /**
   * The resource id.
   */
  id?: string;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;
}

/**
 * Definition of the deleted automation account properties.
 */
model DeletedAutomationAccountProperties {
  /**
   * Gets or sets the Automation Account Resource Id.
   */
  automationAccountResourceId?: string;

  /**
   * Gets or sets the Automation Account Id.
   */
  automationAccountId?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;

  /**
   * Gets the deletion time.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;
}

/**
 * Definition of hybrid runbook worker group property.
 */
model HybridRunbookWorkerGroupProperties {
  /**
   * Type of the HybridWorkerGroup.
   */
  groupType?: GroupTypeEnum;

  /**
   * Sets the credential of a worker group.
   */
  credential?: RunAsCredentialAssociationProperty;
}

/**
 * Definition of RunAs credential to use for hybrid worker.
 */
model RunAsCredentialAssociationProperty {
  /**
   * Gets or sets the name of the credential.
   */
  name?: string;
}

/**
 * The parameters supplied to the create hybrid runbook worker group operation.
 */
model HybridRunbookWorkerGroupCreateOrUpdateParameters {
  /**
   * Gets or sets hybrid runbook worker group create or update properties.
   */
  properties?: HybridRunbookWorkerGroupCreateOrUpdateProperties;

  /**
   * Gets or sets the name of the resource.
   */
  name?: string;
}

/**
 * The hybrid runbook worker group properties.
 */
model HybridRunbookWorkerGroupCreateOrUpdateProperties {
  /**
   * Sets the credential of a worker group.
   */
  credential?: RunAsCredentialAssociationProperty;
}

/**
 * The parameters supplied to the create or update draft runbook properties.
 */
model RunbookCreateOrUpdateDraftProperties {
  /**
   * Gets or sets verbose log option.
   */
  logVerbose?: boolean;

  /**
   * Gets or sets progress log option.
   */
  logProgress?: boolean;

  /**
   * Gets or sets the type of the runbook.
   */
  runbookType: RunbookTypeEnum;

  /**
   * Gets or sets the draft runbook properties.
   */
  draft: RunbookDraft;

  /**
   * Gets or sets the description of the runbook.
   */
  description?: string;

  /**
   * Gets or sets the activity-level tracing options of the runbook.
   */
  logActivityTrace?: int32;
}

/**
 * The parameters supplied to the create or update runbook operation.
 */
model RunbookCreateOrUpdateDraftParameters {
  /**
   * Content of the Runbook.
   */
  runbookContent: string;
}
