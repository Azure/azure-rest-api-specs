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

@doc("Gets or sets the agent registration key name - primary or secondary.")
enum AgentRegistrationKeyName {
  primary,
  secondary,
}

@doc("Gets or sets the content source type.")
enum ContentSourceType {
  embeddedContent,
  uri,
}

@doc("The provisioning state of the resource.")
enum JobProvisioningState {
  Failed,
  Succeeded,
  Suspended,
  Processing,
}

@doc("Gets or sets the status of the job.")
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

@doc("Gets or sets the stream type.")
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

@doc("The source type. Must be one of VsoGit, VsoTfvc, GitHub.")
enum SourceType {
  VsoGit,
  VsoTfvc,
  GitHub,
}

@doc("The token type. Must be either PersonalAccessToken or Oauth.")
enum TokenType {
  PersonalAccessToken,
  Oauth,
}

@doc("The provisioning state of the job.")
enum ProvisioningState {
  Completed,
  Failed,
  Running,
}

@doc("The sync type.")
enum SyncType {
  PartialSync,
  FullSync,
}

@doc("The type of the sync job stream.")
enum StreamType {
  Error,
  Output,
}

@doc("Gets or sets the SKU name of the account.")
enum SkuNameEnum {
  Free,
  Basic,
}

@doc("Gets status of account.")
enum AutomationAccountState {
  Ok,
  Unavailable,
  Suspended,
}

@doc("Automation key name.")
enum AutomationKeyName {
  Primary,
  Secondary,
}

@doc("Automation key permissions.")
enum AutomationKeyPermissions {
  Read,
  Full,
}

@doc("Gets or sets the frequency of the schedule.")
enum ScheduleFrequency {
  OneTime,
  Day,
  Hour,
  Week,
  Month,
  @doc("The minimum allowed interval for Minute schedules is 15 minutes.")
  Minute,
}

@doc("Day of the occurrence. Must be one of monday, tuesday, wednesday, thursday, friday, saturday, sunday.")
enum ScheduleDay {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

@doc("Gets or sets the state of the configuration.")
enum DscConfigurationState {
  New,
  Edit,
  Published,
}

@doc("Runbook Type")
enum GraphRunbookType {
  GraphPowerShell,
  GraphPowerShellWorkflow,
}

@doc("Update classification included in the software update configuration. A comma separated string with required values")
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

@doc("Update classifications included in the software update configuration.")
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

@doc("Gets or sets the type of the runbook.")
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

@doc("Gets or sets the state of the runbook.")
enum RunbookState {
  New,
  Edit,
  Published,
}

@doc("Type of the HybridWorker.")
enum WorkerType {
  HybridV1,
  HybridV2,
}

@doc("Type of the HybridWorkerGroup.")
enum GroupTypeEnum {
  User,
  System,
}

@doc("Gets or sets the provisioning state of the module.")
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

@doc("Encryption Key Source")
@fixed
enum EncryptionKeySourceType {
  `Microsoft.Automation`,
  `Microsoft.Keyvault`,
}

@doc("The identity type.")
@fixed
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

@doc("Target operating system for the software update configuration.")
@fixed
enum OperatingSystemType {
  Windows,
  Linux,
}

@doc("Filter VMs by Any or All specified tags.")
@fixed
enum TagOperators {
  All,
  Any,
}

@doc("Properties of a private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("Private endpoint which the connection belongs to.")
  privateEndpoint?: PrivateEndpointProperty;

  @doc("Gets the groupIds.")
  groupIds?: string[];

  @doc("Connection State of the Private Endpoint Connection.")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionStateProperty;
}

@doc("Private endpoint which the connection belongs to.")
model PrivateEndpointProperty {
  @doc("Resource id of the private endpoint.")
  id?: string;
}

@doc("Connection State of the Private Endpoint Connection.")
model PrivateLinkServiceConnectionStateProperty {
  @doc("The private link service connection status.")
  status?: string;

  @doc("The private link service connection description.")
  description?: string;

  @doc("Any action that is required beyond basic workflow (approve/ reject/ disconnect)")
  @visibility("read")
  actionsRequired?: string;
}

@doc("The core properties of ARM resources")
model Resource {
  @doc("Fully qualified resource Id for the resource")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;
}

@doc("A list of private link resources")
@pagedResult
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  @items
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource extends ProxyResource {
  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];
}

@doc("Definition of the module property type.")
model ModuleProperties {
  @doc("Gets or sets the isGlobal flag of the module.")
  isGlobal?: boolean;

  @doc("Gets or sets the version of the module.")
  version?: string;

  @doc("Gets or sets the size in bytes of the module.")
  sizeInBytes?: int32;

  @doc("Gets or sets the activity count of the module.")
  activityCount?: int32;

  @doc("Gets or sets the provisioning state of the module.")
  provisioningState?: ModuleProvisioningState;

  @doc("Gets or sets the contentLink of the module.")
  contentLink?: ContentLink;

  @doc("Gets or sets the error info of the module.")
  error?: ModuleErrorInfo;

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;

  @doc("Gets or sets type of module, if its composite or not.")
  isComposite?: boolean;
}

@doc("Definition of the content link.")
model ContentLink {
  @doc("Gets or sets the uri of the runbook content.")
  uri?: string;

  @doc("Gets or sets the hash.")
  contentHash?: ContentHash;

  @doc("Gets or sets the version of the content.")
  version?: string;
}

@doc("Definition of the runbook property type.")
model ContentHash {
  @doc("Gets or sets the content hash algorithm used to hash the content.")
  algorithm: string;

  @doc("Gets or sets expected hash value of the content.")
  value: string;
}

@doc("Definition of the module error info type.")
model ModuleErrorInfo {
  @doc("Gets or sets the error code.")
  code?: string;

  @doc("Gets or sets the error message.")
  message?: string;
}

@doc("The parameters supplied to the create or update module operation.")
model PythonPackageCreateParameters {
  @doc("Gets or sets the module create properties.")
  properties: PythonPackageCreateProperties;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the create or update module properties.")
model PythonPackageCreateProperties {
  @doc("Gets or sets the module content link.")
  contentLink: ContentLink;
}

@doc("The parameters supplied to the update module operation.")
model PythonPackageUpdateParameters {
  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("Definition of the agent registration information type.")
model AgentRegistration {
  @doc("Gets or sets the dsc meta configuration.")
  dscMetaConfiguration?: string;

  @doc("Gets or sets the dsc server endpoint.")
  endpoint?: string;

  @doc("Gets or sets the agent registration keys.")
  keys?: AgentRegistrationKeys;

  @doc("Gets or sets the id.")
  id?: string;
}

@doc("Definition of the agent registration keys.")
model AgentRegistrationKeys {
  @doc("Gets or sets the primary key.")
  primary?: string;

  @doc("Gets or sets the secondary key.")
  secondary?: string;
}

@doc("The parameters supplied to the regenerate keys operation.")
model AgentRegistrationRegenerateKeyParameter {
  @doc("Gets or sets the agent registration key name - primary or secondary.")
  keyName: AgentRegistrationKeyName;
}

@doc("The properties of a DscNode")
model DscNodeProperties {
  @doc("Gets or sets the last seen time of the node.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSeen?: utcDateTime;

  @doc("Gets or sets the registration time of the node.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registrationTime?: utcDateTime;

  @doc("Gets or sets the ip of the node.")
  ip?: string;

  @doc("Gets or sets the account id of the node.")
  accountId?: string;

  @doc("Gets or sets the configuration of the node.")
  nodeConfiguration?: DscNodeConfigurationAssociationProperty;

  @doc("Gets or sets the status of the node.")
  status?: string;

  @doc("Gets or sets the node id.")
  nodeId?: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;

  @doc("Gets the total number of records matching filter criteria.")
  totalCount?: int32;

  @doc("Gets or sets the list of extensionHandler properties for a Node.")
  extensionHandler?: DscNodeExtensionHandlerAssociationProperty[];
}

@doc("The dsc node configuration property associated with the entity.")
model DscNodeConfigurationAssociationProperty {
  @doc("Gets or sets the name of the dsc node configuration.")
  name?: string;
}

@doc("The dsc extensionHandler property associated with the node")
model DscNodeExtensionHandlerAssociationProperty {
  @doc("Gets or sets the name of the extension handler.")
  name?: string;

  @doc("Gets or sets the version of the extension handler.")
  version?: string;
}

@doc("The parameters supplied to the update dsc node operation.")
model DscNodeUpdateParameters {
  @doc("Gets or sets the id of the dsc node.")
  nodeId?: string;

  properties?: DscNodeUpdateParametersProperties;
}

model DscNodeUpdateParametersProperties {
  @doc("Gets or sets the configuration of the node.")
  nodeConfiguration?: DscNodeConfigurationAssociationProperty;
}

@doc("The response model for the list dsc nodes operation.")
model DscNodeReportListResult is Azure.Core.Page<DscNodeReport>;

@doc("Definition of the dsc node report type.")
model DscNodeReport {
  @doc("Gets or sets the end time of the node report.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets or sets the lastModifiedTime of the node report.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the start time of the node report.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets or sets the type of the node report.")
  type?: string;

  @doc("Gets or sets the id of the node report.")
  reportId?: string;

  @doc("Gets or sets the status of the node report.")
  status?: string;

  @doc("Gets or sets the refreshMode of the node report.")
  refreshMode?: string;

  @doc("Gets or sets the rebootRequested of the node report.")
  rebootRequested?: string;

  @doc("Gets or sets the reportFormatVersion of the node report.")
  reportFormatVersion?: string;

  @doc("Gets or sets the configurationVersion of the node report.")
  configurationVersion?: string;

  @doc("Gets or sets the id.")
  id?: string;

  @doc("Gets or sets the errors for the node report.")
  errors?: DscReportError[];

  @doc("Gets or sets the resource for the node report.")
  resources?: DscReportResource[];

  @doc("Gets or sets the metaConfiguration of the node at the time of the report.")
  metaConfiguration?: DscMetaConfiguration;

  @doc("Gets or sets the hostname of the node that sent the report.")
  hostName?: string;

  @doc("Gets or sets the IPv4 address of the node that sent the report.")
  iPV4Addresses?: string[];

  @doc("Gets or sets the IPv6 address of the node that sent the report.")
  iPV6Addresses?: string[];

  @doc("Gets or sets the number of resource in the node report.")
  numberOfResources?: int32;

  @doc("Gets or sets the unparsed errors for the node report.")
  rawErrors?: string;
}

@doc("Definition of the dsc node report error type.")
model DscReportError {
  @doc("Gets or sets the source of the error.")
  errorSource?: string;

  @doc("Gets or sets the resource ID which generated the error.")
  resourceId?: string;

  @doc("Gets or sets the error code.")
  errorCode?: string;

  @doc("Gets or sets the error message.")
  errorMessage?: string;

  @doc("Gets or sets the locale of the error.")
  locale?: string;

  @doc("Gets or sets the error details.")
  errorDetails?: string;
}

@doc("Definition of the DSC Report Resource.")
model DscReportResource {
  @doc("Gets or sets the ID of the resource.")
  resourceId?: string;

  @doc("Gets or sets the source info of the resource.")
  sourceInfo?: string;

  @doc("Gets or sets the Resource Navigation values for resources the resource depends on.")
  dependsOn?: DscReportResourceNavigation[];

  @doc("Gets or sets the module name of the resource.")
  moduleName?: string;

  @doc("Gets or sets the module version of the resource.")
  moduleVersion?: string;

  @doc("Gets or sets the name of the resource.")
  resourceName?: string;

  @doc("Gets or sets the error of the resource.")
  error?: string;

  @doc("Gets or sets the status of the resource.")
  status?: string;

  @doc("Gets or sets the duration in seconds for the resource.")
  durationInSeconds?: float32;

  @doc("Gets or sets the start date of the resource.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDate?: utcDateTime;
}

@doc("Navigation for DSC Report Resource.")
model DscReportResourceNavigation {
  @doc("Gets or sets the ID of the resource to navigate to.")
  resourceId?: string;
}

@doc("Definition of the DSC Meta Configuration.")
model DscMetaConfiguration {
  @doc("Gets or sets the ConfigurationModeFrequencyMins value of the meta configuration.")
  configurationModeFrequencyMins?: int32;

  @doc("Gets or sets the RebootNodeIfNeeded value of the meta configuration.")
  rebootNodeIfNeeded?: boolean;

  @doc("Gets or sets the ConfigurationMode value of the meta configuration.")
  configurationMode?: string;

  @doc("Gets or sets the ActionAfterReboot value of the meta configuration.")
  actionAfterReboot?: string;

  @doc("Gets or sets the CertificateId value of the meta configuration.")
  certificateId?: string;

  @doc("Gets or sets the RefreshFrequencyMins value of the meta configuration.")
  refreshFrequencyMins?: int32;

  @doc("Gets or sets the AllowModuleOverwrite value of the meta configuration.")
  allowModuleOverwrite?: boolean;
}

@doc("Properties for the DscNodeConfiguration")
model DscNodeConfigurationProperties {
  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the configuration of the node.")
  configuration?: DscConfigurationAssociationProperty;

  @doc("Source of node configuration.")
  source?: string;

  @doc("Number of nodes with this node configuration assigned")
  nodeCount?: int32;

  @doc("If a new build version of NodeConfiguration is required.")
  incrementNodeConfigurationBuild?: boolean;
}

@doc("The Dsc configuration property associated with the entity.")
model DscConfigurationAssociationProperty {
  @doc("Gets or sets the name of the Dsc configuration.")
  name?: string;
}

@doc("The parameters supplied to the create or update node configuration operation.")
model DscNodeConfigurationCreateOrUpdateParameters {
  @doc("Node configuration properties")
  properties?: DscNodeConfigurationCreateOrUpdateParametersProperties;

  @doc("Name of the node configuration.")
  name?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameter properties supplied to the create or update node configuration operation.")
model DscNodeConfigurationCreateOrUpdateParametersProperties {
  @doc("Gets or sets the source.")
  source: ContentSource;

  @doc("Gets or sets the configuration of the node.")
  configuration: DscConfigurationAssociationProperty;

  @doc("If a new build version of NodeConfiguration is required.")
  incrementNodeConfigurationBuild?: boolean;
}

@doc("Definition of the content source.")
model ContentSource {
  @doc("Gets or sets the hash.")
  hash?: ContentHash;

  @doc("Gets or sets the content source type.")
  type?: ContentSourceType;

  @doc("Gets or sets the value of the content. This is based on the content source type.")
  value?: string;

  @doc("Gets or sets the version of the content.")
  version?: string;
}

@doc("The parameters supplied to the create compilation job operation.")
model DscCompilationJobCreateParameters {
  @doc("Gets or sets the list of compilation job properties.")
  properties: DscCompilationJobCreateProperties;

  @doc("Gets or sets name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the create compilation job operation.")
model DscCompilationJobCreateProperties {
  @doc("Gets or sets the configuration.")
  configuration: DscConfigurationAssociationProperty;

  @doc("Gets or sets the parameters of the job.")
  parameters?: Record<string>;

  @doc("If a new build version of NodeConfiguration is required.")
  incrementNodeConfigurationBuild?: boolean;
}

@doc("Definition of Dsc Compilation job properties.")
model DscCompilationJobProperties {
  @doc("Gets or sets the configuration.")
  configuration?: DscConfigurationAssociationProperty;

  @doc("Gets the compilation job started by.")
  @visibility("read")
  startedBy?: string;

  @doc("Gets the id of the job.")
  @visibility("read")
  jobId?: string;

  @doc("Gets the creation time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The current provisioning state of the job.")
  provisioningState?: JobProvisioningState;

  @doc("Gets or sets the runOn which specifies the group name where the job is to be executed.")
  runOn?: string;

  @doc("Gets or sets the status of the job.")
  status?: JobStatus;

  @doc("Gets or sets the status details of the job.")
  statusDetails?: string;

  @doc("Gets the start time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the end time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets the exception of the job.")
  @visibility("read")
  exception?: string;

  @doc("Gets the last modified time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets the last status modified time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusModifiedTime?: utcDateTime;

  @doc("Gets or sets the parameters of the job.")
  parameters?: Record<string>;
}

@doc("The response model for the list job stream operation.")
model JobStreamListResult is Azure.Core.Page<JobStream>;

@doc("Definition of the job stream.")
model JobStream {
  @doc("Gets or sets the id of the resource.")
  id?: string;

  @doc("Gets or sets the id of the job stream.")
  properties?: JobStreamProperties;
}

@doc("Definition of the job stream.")
model JobStreamProperties {
  @doc("Gets or sets the id of the job stream.")
  jobStreamId?: string;

  @doc("Gets or sets the creation time of the job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  @doc("Gets or sets the stream type.")
  streamType?: JobStreamType;

  @doc("Gets or sets the stream text.")
  streamText?: string;

  @doc("Gets or sets the summary.")
  summary?: string;

  @doc("Gets or sets the values of the job stream.")
  value?: Record<Record<unknown>>;
}

@doc("Gets the count of nodes by count type")
model NodeCounts {
  @doc("Gets an array of counts")
  value?: NodeCount[];

  @doc("Gets the total number of records matching countType criteria.")
  totalCount?: int32;
}

@doc("Number of nodes based on the Filter")
model NodeCount {
  @doc("Gets the name of a count type")
  name?: string;

  properties?: NodeCountProperties;
}

model NodeCountProperties {
  @doc("Gets the count for the name")
  count?: int32;
}

@doc("The parameters supplied to the create or update source control operation.")
model SourceControlCreateOrUpdateParameters {
  @doc("The properties of the source control.")
  properties: SourceControlCreateOrUpdateProperties;
}

@doc("The properties of the create source control operation.")
model SourceControlCreateOrUpdateProperties {
  @doc("The repo url of the source control.")
  @maxLength(2000)
  repoUrl?: string;

  @doc("The repo branch of the source control. Include branch as empty string for VsoTfvc.")
  @maxLength(255)
  branch?: string;

  @doc("The folder path of the source control. Path must be relative.")
  @maxLength(255)
  folderPath?: string;

  @doc("The auto async of the source control. Default is false.")
  autoSync?: boolean;

  @doc("The auto publish of the source control. Default is true.")
  publishRunbook?: boolean;

  @doc("The source type. Must be one of VsoGit, VsoTfvc, GitHub, case sensitive.")
  sourceType?: SourceType;

  @doc("The authorization token for the repo of the source control.")
  securityToken?: SourceControlSecurityTokenProperties;

  @doc("The user description of the source control.")
  @maxLength(512)
  description?: string;
}

model SourceControlSecurityTokenProperties {
  @doc("The access token.")
  @maxLength(1024)
  accessToken?: string;

  @doc("The refresh token.")
  @maxLength(1024)
  refreshToken?: string;

  @doc("The token type. Must be either PersonalAccessToken or Oauth.")
  tokenType?: TokenType;
}

@doc("Definition of the source control properties")
model SourceControlProperties {
  @doc("The repo url of the source control.")
  repoUrl?: string;

  @doc("The repo branch of the source control. Include branch as empty string for VsoTfvc.")
  branch?: string;

  @doc("The folder path of the source control.")
  folderPath?: string;

  @doc("The auto sync of the source control. Default is false.")
  autoSync?: boolean;

  @doc("The auto publish of the source control. Default is true.")
  publishRunbook?: boolean;

  @doc("The source type. Must be one of VsoGit, VsoTfvc, GitHub.")
  sourceType?: SourceType;

  @doc("The description.")
  description?: string;

  @doc("The creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;
}

@doc("The parameters supplied to the update source control operation.")
model SourceControlUpdateParameters {
  @doc("The value of the source control.")
  properties?: SourceControlUpdateProperties;
}

@doc("The properties of the update source control")
model SourceControlUpdateProperties {
  @doc("The repo branch of the source control.")
  branch?: string;

  @doc("The folder path of the source control. Path must be relative.")
  folderPath?: string;

  @doc("The auto sync of the source control. Default is false.")
  autoSync?: boolean;

  @doc("The auto publish of the source control. Default is true.")
  publishRunbook?: boolean;

  @doc("The authorization token for the repo of the source control.")
  securityToken?: SourceControlSecurityTokenProperties;

  @doc("The user description of the source control.")
  description?: string;
}

@doc("The parameters supplied to the create source control sync job operation.")
model SourceControlSyncJobCreateParameters {
  @doc("The properties of the source control sync job.")
  properties: SourceControlSyncJobCreateProperties;
}

@doc("Definition of create source control sync job properties.")
model SourceControlSyncJobCreateProperties {
  @doc("The commit id of the source control sync job. If not syncing to a commitId, enter an empty string.")
  commitId: string;
}

@doc("Definition of the source control sync job.")
model SourceControlSyncJob {
  @doc("Resource name.")
  @visibility("read")
  name?: string;

  @doc("Resource type.")
  @visibility("read")
  type?: string;

  @doc("Resource id.")
  @visibility("read")
  id?: string;

  @doc("The properties of the source control sync job.")
  properties?: SourceControlSyncJobProperties;
}

@doc("Definition of source control sync job properties.")
model SourceControlSyncJobProperties {
  @doc("The source control sync job id.")
  sourceControlSyncJobId?: string;

  @doc("The creation time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The provisioning state of the job.")
  provisioningState?: ProvisioningState;

  @doc("The start time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The sync type.")
  syncType?: SyncType;
}

@doc("Definition of the source control sync job.")
model SourceControlSyncJobById {
  @doc("The id of the job.")
  id?: string;

  @doc("The properties of the source control sync job.")
  properties?: SourceControlSyncJobByIdProperties;
}

@doc("Definition of source control sync job properties.")
model SourceControlSyncJobByIdProperties {
  @doc("The source control sync job id.")
  sourceControlSyncJobId?: string;

  @doc("The creation time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The provisioning state of the job.")
  provisioningState?: ProvisioningState;

  @doc("The start time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The sync type.")
  syncType?: SyncType;

  @doc("The exceptions that occurred while running the sync job.")
  exception?: string;
}

@doc("The response model for the list source control sync jobs operation.")
model SourceControlSyncJobListResult is Azure.Core.Page<SourceControlSyncJob>;

@doc("The response model for the list source control sync job streams operation.")
model SourceControlSyncJobStreamsListBySyncJob
  is Azure.Core.Page<SourceControlSyncJobStream>;

@doc("Definition of the source control sync job stream.")
model SourceControlSyncJobStream {
  @doc("Resource id.")
  @visibility("read")
  id?: string;

  @doc("The properties of the source control sync job stream.")
  properties?: SourceControlSyncJobStreamProperties;
}

@doc("Definition of source control sync job stream properties.")
model SourceControlSyncJobStreamProperties {
  @doc("The sync job stream id.")
  sourceControlSyncJobStreamId?: string;

  @doc("The summary of the sync job stream.")
  summary?: string;

  @doc("The time of the sync job stream.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  @doc("The type of the sync job stream.")
  streamType?: StreamType;
}

@doc("Definition of the source control sync job stream by id.")
model SourceControlSyncJobStreamById {
  @doc("Resource id.")
  @visibility("read")
  id?: string;

  @doc("The properties of the source control sync job stream.")
  properties?: SourceControlSyncJobStreamByIdProperties;
}

@doc("Definition of source control sync job stream by id properties.")
model SourceControlSyncJobStreamByIdProperties {
  @doc("The sync job stream id.")
  sourceControlSyncJobStreamId?: string;

  @doc("The summary of the sync job stream.")
  summary?: string;

  @doc("The time of the sync job stream.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;

  @doc("The type of the sync job stream.")
  streamType?: StreamType;

  @doc("The text of the sync job stream.")
  streamText?: string;

  @doc("The values of the job stream.")
  value?: Record<Record<unknown>>;
}

@doc("The parameters supplied to the update automation account operation.")
model AutomationAccountUpdateParameters {
  @doc("Gets or sets account update properties.")
  properties?: AutomationAccountUpdateProperties;

  @doc("Gets or sets the name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Sets the identity property for automation account")
  identity?: Identity;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the update account properties.")
model AutomationAccountUpdateProperties {
  @doc("Gets or sets account SKU.")
  sku?: Sku;

  @doc("Set the encryption properties for the automation account")
  encryption?: EncryptionProperties;

  @doc("Indicates whether traffic on the non-ARM endpoint (Webhook/Agent) is allowed from the public internet")
  publicNetworkAccess?: boolean;

  @doc("Indicates whether requests using non-AAD authentication are blocked")
  disableLocalAuth?: boolean;
}

@doc("The account SKU.")
model Sku {
  @doc("Gets or sets the SKU name of the account.")
  name: SkuNameEnum;

  @doc("Gets or sets the SKU family.")
  family?: string;

  @doc("Gets or sets the SKU capacity.")
  capacity?: int32;
}

@doc("The encryption settings for automation account")
model EncryptionProperties {
  @doc("Key vault properties.")
  keyVaultProperties?: KeyVaultProperties;

  @doc("Encryption Key Source")
  keySource?: EncryptionKeySourceType;

  @doc("User identity used for CMK.")
  identity?: EncryptionPropertiesIdentity;
}

@doc("Settings concerning key vault encryption for a configuration store.")
model KeyVaultProperties {
  @doc("The URI of the key vault key used to encrypt data.")
  keyvaultUri?: string;

  @doc("The name of key used to encrypt data.")
  keyName?: string;

  @doc("The key version of the key used to encrypt data.")
  keyVersion?: string;
}

@doc("User identity used for CMK.")
model EncryptionPropertiesIdentity {
  @doc("The user identity used for CMK. It will be an ARM resource id in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentity?: Record<unknown>;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: ResourceIdentityType;

  @doc("The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.")
  userAssignedIdentities?: Record<ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties>;
}

model ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties {
  @doc("The principal id of user assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client id of user assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Definition of the account property.")
model AutomationAccountProperties {
  @doc("Gets or sets the SKU of account.")
  sku?: Sku;

  @doc("Gets or sets the last modified by.")
  lastModifiedBy?: string;

  @doc("Gets status of account.")
  @visibility("read")
  state?: AutomationAccountState;

  @doc("Gets the creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets the last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;

  @doc("Encryption properties for the automation account")
  encryption?: EncryptionProperties;

  @doc("List of Automation operations supported by the Automation resource provider.")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Indicates whether traffic on the non-ARM endpoint (Webhook/Agent) is allowed from the public internet")
  publicNetworkAccess?: boolean;

  @doc("Indicates whether requests using non-AAD authentication are blocked")
  disableLocalAuth?: boolean;

  @doc("URL of automation hybrid service which is used for hybrid worker on-boarding.")
  automationHybridServiceUrl?: string;
}

@doc("The parameters supplied to the create or update automation account operation.")
model AutomationAccountCreateOrUpdateParameters {
  @doc("Gets or sets account create or update properties.")
  properties?: AutomationAccountCreateOrUpdateProperties;

  @doc("Gets or sets name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Sets the identity property for automation account")
  identity?: Identity;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the create or update account properties.")
model AutomationAccountCreateOrUpdateProperties {
  @doc("Gets or sets account SKU.")
  sku?: Sku;

  @doc("Set the encryption properties for the automation account")
  encryption?: EncryptionProperties;

  @doc("Indicates whether traffic on the non-ARM endpoint (Webhook/Agent) is allowed from the public internet")
  publicNetworkAccess?: boolean;

  @doc("Indicates whether requests using non-AAD authentication are blocked")
  disableLocalAuth?: boolean;
}

@doc("The response model for the list statistics operation.")
@pagedResult
model StatisticsListResult {
  @doc("Gets or sets a list of statistics.")
  @items
  value?: Statistics[];
}

@doc("Definition of the statistic.")
model Statistics {
  @doc("Gets the property value of the statistic.")
  @visibility("read")
  counterProperty?: string;

  @doc("Gets the value of the statistic.")
  @visibility("read")
  counterValue?: int32;

  @doc("Gets the startTime of the statistic.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the endTime of the statistic.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets the id.")
  @visibility("read")
  id?: string;
}

@doc("The response model for the get usage operation.")
@pagedResult
model UsageListResult {
  @doc("Gets or sets usage.")
  @items
  value?: Usage[];
}

@doc("Definition of Usage.")
model Usage {
  @doc("Gets or sets the id of the resource.")
  id?: string;

  @doc("Gets or sets the usage counter name.")
  name?: UsageCounterName;

  @doc("Gets or sets the usage unit name.")
  unit?: string;

  @doc("Gets or sets the current usage value.")
  currentValue?: float32;

  @doc("Gets or sets max limit. -1 for unlimited")
  limit?: int32;

  @doc("Gets or sets the throttle status.")
  throttleStatus?: string;
}

@doc("Definition of usage counter name.")
model UsageCounterName {
  @doc("Gets or sets the usage counter name.")
  value?: string;

  @doc("Gets or sets the localized usage counter name.")
  localizedValue?: string;
}

@pagedResult
model KeyListResult {
  @doc("Lists the automation keys.")
  @items
  keys?: Key[];
}

@doc("Automation key which is used to register a DSC Node")
model Key {
  @doc("Automation key name.")
  @visibility("read")
  @projectedName("json", "KeyName")
  keyName?: AutomationKeyName;

  @doc("Automation key permissions.")
  @visibility("read")
  @projectedName("json", "Permissions")
  permissions?: AutomationKeyPermissions;

  @doc("Value of the Automation Key used for registration.")
  @visibility("read")
  @projectedName("json", "Value")
  value?: string;
}

@doc("Properties of the certificate.")
model CertificateProperties {
  @doc("Gets the thumbprint of the certificate.")
  @visibility("read")
  thumbprint?: string;

  @doc("Gets the expiry time of the certificate.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("Gets the is exportable flag of the certificate.")
  @visibility("read")
  isExportable?: boolean;

  @doc("Gets the creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets the last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("The parameters supplied to the create or update or replace certificate operation.")
model CertificateCreateOrUpdateParameters {
  @doc("Gets or sets the name of the certificate.")
  name: string;

  @doc("Gets or sets the properties of the certificate.")
  properties: CertificateCreateOrUpdateProperties;
}

@doc("The properties of the create certificate operation.")
model CertificateCreateOrUpdateProperties {
  @doc("Gets or sets the base64 encoded value of the certificate.")
  base64Value: string;

  @doc("Gets or sets the description of the certificate.")
  description?: string;

  @doc("Gets or sets the thumbprint of the certificate.")
  thumbprint?: string;

  @doc("Gets or sets the is exportable flag of the certificate.")
  isExportable?: boolean;
}

@doc("The parameters supplied to the update certificate operation.")
model CertificateUpdateParameters {
  @doc("Gets or sets the name of the certificate.")
  name?: string;

  @doc("Gets or sets the properties of the certificate.")
  properties?: CertificateUpdateProperties;
}

@doc("The properties of the update certificate operation")
model CertificateUpdateProperties {
  @doc("Gets or sets the description of the certificate.")
  description?: string;
}

@doc("Definition of the connection properties.")
model ConnectionProperties {
  @doc("Gets or sets the connectionType of the connection.")
  connectionType?: ConnectionTypeAssociationProperty;

  @doc("Gets the field definition values of the connection.")
  @visibility("read")
  fieldDefinitionValues?: Record<string>;

  @doc("Gets the creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets the last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("The connection type property associated with the entity.")
model ConnectionTypeAssociationProperty {
  @doc("Gets or sets the name of the connection type.")
  name?: string;
}

@doc("The parameters supplied to the create or update connection operation.")
model ConnectionCreateOrUpdateParameters {
  @doc("Gets or sets the name of the connection.")
  name: string;

  @doc("Gets or sets the properties of the connection.")
  properties: ConnectionCreateOrUpdateProperties;
}

@doc("The properties of the create connection properties")
model ConnectionCreateOrUpdateProperties {
  @doc("Gets or sets the description of the connection.")
  description?: string;

  @doc("Gets or sets the connectionType of the connection.")
  connectionType: ConnectionTypeAssociationProperty;

  @doc("Gets or sets the field definition properties of the connection.")
  fieldDefinitionValues?: Record<string>;
}

@doc("The parameters supplied to the update connection operation.")
model ConnectionUpdateParameters {
  @doc("Gets or sets the name of the connection.")
  name?: string;

  @doc("Gets or sets the properties of the connection.")
  properties?: ConnectionUpdateProperties;
}

@doc("The properties of the update connection operation.")
model ConnectionUpdateProperties {
  @doc("Gets or sets the description of the connection.")
  description?: string;

  @doc("Gets or sets the field definition values of the connection.")
  fieldDefinitionValues?: Record<string>;
}

@doc("Properties of the connection type.")
model ConnectionTypeProperties {
  @doc("Gets or sets a Boolean value to indicate if the connection type is global.")
  isGlobal?: boolean;

  @doc("Gets the field definitions of the connection type.")
  @visibility("read")
  fieldDefinitions?: Record<FieldDefinition>;

  @doc("Gets the creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("Definition of the connection fields.")
model FieldDefinition {
  @doc("Gets or sets the isEncrypted flag of the connection field definition.")
  isEncrypted?: boolean;

  @doc("Gets or sets the isOptional flag of the connection field definition.")
  isOptional?: boolean;

  @doc("Gets or sets the type of the connection field definition.")
  type: string;
}

@doc("The parameters supplied to the create or update connection type operation.")
model ConnectionTypeCreateOrUpdateParameters {
  @doc("Gets or sets the name of the connection type.")
  name: string;

  @doc("Gets or sets the value of the connection type.")
  properties: ConnectionTypeCreateOrUpdateProperties;
}

@doc("The properties of the create connection type.")
model ConnectionTypeCreateOrUpdateProperties {
  @doc("Gets or sets a Boolean value to indicate if the connection type is global.")
  isGlobal?: boolean;

  @doc("Gets or sets the field definitions of the connection type.")
  fieldDefinitions: Record<FieldDefinition>;
}

@doc("Definition of the credential properties")
model CredentialProperties {
  @doc("Gets the user name of the credential.")
  @visibility("read")
  userName?: string;

  @doc("Gets the creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets the last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("The parameters supplied to the create or update credential operation.")
model CredentialCreateOrUpdateParameters {
  @doc("Gets or sets the name of the credential.")
  name: string;

  @doc("Gets or sets the properties of the credential.")
  properties: CredentialCreateOrUpdateProperties;
}

@doc("The properties of the create credential operation.")
model CredentialCreateOrUpdateProperties {
  @doc("Gets or sets the user name of the credential.")
  userName: string;

  @doc("Gets or sets the password of the credential.")
  password: string;

  @doc("Gets or sets the description of the credential.")
  description?: string;
}

@doc("The parameters supplied to the Update credential operation.")
model CredentialUpdateParameters {
  @doc("Gets or sets the name of the credential.")
  name?: string;

  @doc("Gets or sets the properties of the variable.")
  properties?: CredentialUpdateProperties;
}

@doc("The properties of the Update credential")
model CredentialUpdateProperties {
  @doc("Gets or sets the user name of the credential.")
  userName?: string;

  @doc("Gets or sets the password of the credential.")
  password?: string;

  @doc("Gets or sets the description of the credential.")
  description?: string;
}

@doc("Definition of job schedule parameters.")
model JobScheduleProperties {
  @doc("Gets or sets the id of job schedule.")
  jobScheduleId?: string;

  @doc("Gets or sets the schedule.")
  schedule?: ScheduleAssociationProperty;

  @doc("Gets or sets the runbook.")
  runbook?: RunbookAssociationProperty;

  @doc("Gets or sets the hybrid worker group that the scheduled job should run on.")
  runOn?: string;

  @doc("Gets or sets the parameters of the job schedule.")
  parameters?: Record<string>;
}

@doc("The schedule property associated with the entity.")
model ScheduleAssociationProperty {
  @doc("Gets or sets the name of the Schedule.")
  name?: string;
}

@doc("The runbook property associated with the entity.")
model RunbookAssociationProperty {
  @doc("Gets or sets the name of the runbook.")
  name?: string;
}

@doc("The parameters supplied to the create job schedule operation.")
model JobScheduleCreateParameters {
  @doc("Gets or sets the list of job schedule properties.")
  properties: JobScheduleCreateProperties;
}

@doc("The parameters supplied to the create job schedule operation.")
model JobScheduleCreateProperties {
  @doc("Gets or sets the schedule.")
  schedule: ScheduleAssociationProperty;

  @doc("Gets or sets the runbook.")
  runbook: RunbookAssociationProperty;

  @doc("Gets or sets the hybrid worker group that the scheduled job should run on.")
  runOn?: string;

  @doc("Gets or sets a list of job properties.")
  parameters?: Record<string>;
}

@doc("Definition of the linked workspace.")
model LinkedWorkspace {
  @doc("Gets the id of the linked workspace.")
  @visibility("read")
  id?: string;
}

@doc("Definition of the activity.")
model Activity {
  @doc("Gets or sets the id of the resource.")
  id?: string;

  @doc("Gets the name of the activity.")
  @visibility("read")
  name?: string;

  @doc("Gets or sets the properties of the activity.")
  properties?: ActivityProperties;
}

@doc("Properties of the activity.")
model ActivityProperties {
  @doc("Gets or sets the user name of the activity.")
  definition?: string;

  @doc("Gets or sets the parameter sets of the activity.")
  parameterSets?: ActivityParameterSet[];

  @doc("Gets or sets the output types of the activity.")
  outputTypes?: ActivityOutputType[];

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("Definition of the activity parameter set.")
model ActivityParameterSet {
  @doc("Gets or sets the name of the activity parameter set.")
  name?: string;

  @doc("Gets or sets the parameters of the activity parameter set.")
  parameters?: ActivityParameter[];
}

@doc("Definition of the activity parameter.")
model ActivityParameter {
  @doc("Gets or sets the name of the activity parameter.")
  name?: string;

  @doc("Gets or sets the type of the activity parameter.")
  type?: string;

  @doc("Gets or sets a Boolean value that indicates true if the parameter is required. If the value is false, the parameter is optional.")
  isMandatory?: boolean;

  @doc("Gets or sets a Boolean value that indicates true if the parameter is dynamic.")
  isDynamic?: boolean;

  @doc("Gets or sets the position of the activity parameter.")
  position?: int32;

  @doc("Gets or sets a Boolean value that indicates true if the parameter can take values from the incoming pipeline objects. This setting is used if the cmdlet must access the complete input object. false indicates that the parameter cannot take values from the complete input object.")
  valueFromPipeline?: boolean;

  @doc("Gets or sets a Boolean value that indicates true if the parameter can be filled from a property of the incoming pipeline object that has the same name as this parameter. false indicates that the parameter cannot be filled from the incoming pipeline object property with the same name. ")
  valueFromPipelineByPropertyName?: boolean;

  @doc("Gets or sets a Boolean value that indicates true if the cmdlet parameter accepts all the remaining command-line arguments that are associated with this parameter in the form of an array. false if the cmdlet parameter does not accept all the remaining argument values.")
  valueFromRemainingArguments?: boolean;

  @doc("Gets or sets the description of the activity parameter.")
  description?: string;

  @doc("Gets or sets the validation set of activity parameter.")
  validationSet?: ActivityParameterValidationSet[];
}

@doc("Definition of the activity parameter validation set.")
model ActivityParameterValidationSet {
  @doc("Gets or sets the name of the activity parameter validation set member.")
  memberValue?: string;
}

@doc("Definition of the activity output type.")
model ActivityOutputType {
  @doc("Gets or sets the name of the activity output type.")
  name?: string;

  @doc("Gets or sets the type of the activity output type.")
  type?: string;
}

@doc("The response model for the list activity operation.")
model ActivityListResult is Azure.Core.Page<Activity>;

@doc("The parameters supplied to the create or update module operation.")
model ModuleCreateOrUpdateParameters {
  @doc("Gets or sets the module create properties.")
  properties: ModuleCreateOrUpdateProperties;

  @doc("Gets or sets name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the create or update module properties.")
model ModuleCreateOrUpdateProperties {
  @doc("Gets or sets the module content link.")
  contentLink: ContentLink;
}

@doc("The parameters supplied to the update module operation.")
model ModuleUpdateParameters {
  @doc("Gets or sets the module update properties.")
  properties?: ModuleUpdateProperties;

  @doc("Gets or sets name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the update properties.")
model ModuleUpdateProperties {
  @doc("Gets or sets the module content link.")
  contentLink?: ContentLink;
}

@doc("The response model for the list fields operation.")
@pagedResult
model TypeFieldListResult {
  @doc("Gets or sets a list of fields.")
  @items
  value?: TypeField[];
}

@doc("Information about a field of a type.")
model TypeField {
  @doc("Gets or sets the name of the field.")
  name?: string;

  @doc("Gets or sets the type of the field.")
  type?: string;
}

@doc("The parameters supplied to the create or update schedule operation.")
model ScheduleCreateOrUpdateParameters {
  @doc("Gets or sets the name of the Schedule.")
  name: string;

  @doc("Gets or sets the list of schedule properties.")
  properties: ScheduleCreateOrUpdateProperties;
}

@doc("The parameters supplied to the create or update schedule operation.")
model ScheduleCreateOrUpdateProperties {
  @doc("Gets or sets the description of the schedule.")
  description?: string;

  @doc("Gets or sets the start time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime: utcDateTime;

  @doc("Gets or sets the end time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("Gets or sets the interval of the schedule.")
  interval?: unknown;

  @doc("Gets or sets the frequency of the schedule.")
  frequency: ScheduleFrequency;

  @doc("Gets or sets the time zone of the schedule.")
  timeZone?: string;

  @doc("Gets or sets the AdvancedSchedule.")
  advancedSchedule?: AdvancedSchedule;
}

@doc("The properties of the create Advanced Schedule.")
model AdvancedSchedule {
  @doc("Days of the week that the job should execute on.")
  weekDays?: string[];

  @doc("Days of the month that the job should execute on. Must be between 1 and 31.")
  monthDays?: int32[];

  @doc("Occurrences of days within a month.")
  monthlyOccurrences?: AdvancedScheduleMonthlyOccurrence[];
}

@doc("The properties of the create advanced schedule monthly occurrence.")
model AdvancedScheduleMonthlyOccurrence {
  @doc("Occurrence of the week within the month. Must be between 1 and 5")
  occurrence?: int32;

  @doc("Day of the occurrence. Must be one of monday, tuesday, wednesday, thursday, friday, saturday, sunday.")
  day?: ScheduleDay;
}

@doc("Definition of schedule parameters.")
model ScheduleProperties {
  @doc("Gets or sets the start time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the start time's offset in minutes.")
  @visibility("read")
  startTimeOffsetMinutes?: float32;

  @doc("Gets or sets the end time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("Gets or sets the expiry time's offset in minutes.")
  expiryTimeOffsetMinutes?: float32;

  @doc("Gets or sets a value indicating whether this schedule is enabled.")
  isEnabled?: boolean;

  @doc("Gets or sets the next run time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRun?: utcDateTime;

  @doc("Gets or sets the next run time's offset in minutes.")
  nextRunOffsetMinutes?: float32;

  @doc("Gets or sets the interval of the schedule.")
  interval?: unknown;

  @doc("Gets or sets the frequency of the schedule.")
  frequency?: ScheduleFrequency;

  @doc("Gets or sets the time zone of the schedule.")
  timeZone?: string;

  @doc("Gets or sets the advanced schedule.")
  advancedSchedule?: AdvancedSchedule;

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("The parameters supplied to the update schedule operation.")
model ScheduleUpdateParameters {
  @doc("Gets or sets the name of the Schedule.")
  name?: string;

  @doc("Gets or sets the list of schedule properties.")
  properties?: ScheduleUpdateProperties;
}

@doc("The parameters supplied to the update schedule operation.")
model ScheduleUpdateProperties {
  @doc("Gets or sets the description of the schedule.")
  description?: string;

  @doc("Gets or sets a value indicating whether this schedule is enabled.")
  isEnabled?: boolean;
}

@doc("The parameters supplied to the create or update variable operation.")
model VariableCreateOrUpdateParameters {
  @doc("Gets or sets the name of the variable.")
  name: string;

  @doc("Gets or sets the properties of the variable.")
  properties: VariableCreateOrUpdateProperties;
}

@doc("The properties of the create variable operation.")
model VariableCreateOrUpdateProperties {
  @doc("Gets or sets the value of the variable.")
  value?: string;

  @doc("Gets or sets the description of the variable.")
  description?: string;

  @doc("Gets or sets the encrypted flag of the variable.")
  isEncrypted?: boolean;
}

@doc("Definition of the variable properties")
model VariableProperties {
  @doc("Gets or sets the value of the variable.")
  value?: string;

  @doc("Gets or sets the encrypted flag of the variable.")
  isEncrypted?: boolean;

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("The parameters supplied to the update variable operation.")
model VariableUpdateParameters {
  @doc("Gets or sets the name of the variable.")
  name?: string;

  @doc("Gets or sets the value of the variable.")
  properties?: VariableUpdateProperties;
}

@doc("The properties of the update variable")
model VariableUpdateProperties {
  @doc("Gets or sets the value of the variable.")
  value?: string;

  @doc("Gets or sets the description of the variable.")
  description?: string;
}

@doc("Definition of the watcher properties")
model WatcherProperties {
  @doc("Gets or sets the frequency at which the watcher is invoked.")
  executionFrequencyInSeconds?: int32;

  @doc("Gets or sets the name of the script the watcher is attached to, i.e. the name of an existing runbook.")
  scriptName?: string;

  @doc("Gets or sets the parameters of the script.")
  scriptParameters?: Record<string>;

  @doc("Gets or sets the name of the hybrid worker group the watcher will run on.")
  scriptRunOn?: string;

  @doc("Gets the current status of the watcher.")
  @visibility("read")
  status?: string;

  @doc("Gets or sets the creation time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Details of the user who last modified the watcher.")
  @visibility("read")
  lastModifiedBy?: string;

  @doc("Gets or sets the description.")
  description?: string;
}

model WatcherUpdateParameters {
  @doc("Gets or sets the watcher update properties.")
  properties?: WatcherUpdateProperties;

  @doc("Gets or sets the name of the resource.")
  name?: string;
}

@doc("The properties of the update watcher operation.")
model WatcherUpdateProperties {
  @doc("Gets or sets the frequency at which the watcher is invoked.")
  executionFrequencyInSeconds?: int32;
}

@doc("Definition of the configuration property type.")
model DscConfigurationProperties {
  @doc("Gets or sets the provisioning state of the configuration.")
  provisioningState?: "Succeeded";

  @doc("Gets or sets the job count of the configuration.")
  jobCount?: int32;

  @doc("Gets or sets the configuration parameters.")
  parameters?: Record<DscConfigurationParameter>;

  @doc("Gets or sets the source.")
  source?: ContentSource;

  @doc("Gets or sets the state of the configuration.")
  state?: DscConfigurationState;

  @doc("Gets or sets verbose log option.")
  logVerbose?: boolean;

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets the number of compiled node configurations.")
  nodeConfigurationCount?: int32;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("Definition of the configuration parameter type.")
model DscConfigurationParameter {
  @doc("Gets or sets the type of the parameter.")
  type?: string;

  @doc("Gets or sets a Boolean value to indicate whether the parameter is mandatory or not.")
  isMandatory?: boolean;

  @doc("Get or sets the position of the parameter.")
  position?: int32;

  @doc("Gets or sets the default value of parameter.")
  defaultValue?: string;
}

@doc("The parameters supplied to the create or update configuration operation.")
model DscConfigurationCreateOrUpdateParameters {
  @doc("Gets or sets configuration create or update properties.")
  properties: DscConfigurationCreateOrUpdateProperties;

  @doc("Gets or sets name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The properties to create or update configuration.")
model DscConfigurationCreateOrUpdateProperties {
  @doc("Gets or sets verbose log option.")
  logVerbose?: boolean;

  @doc("Gets or sets progress log option.")
  logProgress?: boolean;

  @doc("Gets or sets the source.")
  source: ContentSource;

  @doc("Gets or sets the configuration parameters.")
  parameters?: Record<DscConfigurationParameter>;

  @doc("Gets or sets the description of the configuration.")
  description?: string;
}

@doc("The parameters supplied to the create or update configuration operation.")
model DscConfigurationUpdateParameters {
  @doc("Gets or sets configuration create or update properties.")
  properties?: DscConfigurationCreateOrUpdateProperties;

  @doc("Gets or sets name of the resource.")
  name?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("Definition of job properties.")
model JobProperties {
  @doc("Gets or sets the runbook.")
  runbook?: RunbookAssociationProperty;

  @doc("Gets or sets the job started by.")
  startedBy?: string;

  @doc("Gets or sets the runOn which specifies the group name where the job is to be executed.")
  runOn?: string;

  @doc("Gets or sets the id of the job.")
  jobId?: string;

  @doc("Gets or sets the creation time of the job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the status of the job.")
  status?: JobStatus;

  @doc("Gets or sets the status details of the job.")
  statusDetails?: string;

  @doc("Gets or sets the start time of the job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets or sets the end time of the job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets or sets the exception of the job.")
  exception?: string;

  @doc("Gets or sets the last modified time of the job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the last status modified time of the job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusModifiedTime?: utcDateTime;

  @doc("Gets or sets the parameters of the job.")
  parameters?: Record<string>;

  @doc("The current provisioning state of the job.")
  provisioningState?: JobProvisioningState;
}

@doc("The parameters supplied to the create job operation.")
model JobCreateParameters {
  @doc("Gets or sets the list of job properties.")
  properties: JobCreateProperties;
}

model JobCreateProperties {
  @doc("Gets or sets the runbook.")
  runbook?: RunbookAssociationProperty;

  @doc("Gets or sets the parameters of the job.")
  parameters?: Record<string>;

  @doc("Gets or sets the runOn which specifies the group name where the job is to be executed.")
  runOn?: string;
}

@doc("Job collection item properties.")
model JobCollectionItem extends ProxyResource {
  @doc("Job properties.")
  properties: JobCollectionItemProperties;
}

@doc("Job collection item properties.")
model JobCollectionItemProperties {
  @doc("The runbook association.")
  @visibility("read")
  runbook?: RunbookAssociationProperty;

  @doc("The id of the job.")
  @visibility("read")
  jobId?: string;

  @doc("The creation time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("The status of the job.")
  @visibility("read")
  status?: JobStatus;

  @doc("The start time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The end time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The last modified time of the job.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("The provisioning state of a resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("Specifies the runOn group name where the job was executed.")
  runOn?: string;
}

@doc("Graphical Runbook Content")
model GraphicalRunbookContent {
  @doc("Raw graphical Runbook content.")
  rawContent?: RawGraphicalRunbookContent;

  @doc("Graphical Runbook content as JSON")
  graphRunbookJson?: string;
}

@doc("Raw Graphical Runbook content")
model RawGraphicalRunbookContent {
  @doc("Schema version of the serializer.")
  schemaVersion?: string;

  @doc("Serialized Graphical runbook")
  runbookDefinition?: string;

  @doc("Runbook Type")
  runbookType?: GraphRunbookType;
}

@doc("Software update configuration properties.")
model SoftwareUpdateConfigurationProperties {
  @doc("update specific properties for the Software update configuration")
  updateConfiguration: UpdateConfiguration;

  @doc("Schedule information for the Software update configuration")
  scheduleInfo: SUCScheduleProperties;

  @doc("Provisioning state for the software update configuration, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("Details of provisioning error")
  error?: ErrorResponse;

  @doc("Creation time of the resource, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("CreatedBy property, which only appears in the response.")
  @visibility("read")
  createdBy?: string;

  @doc("Last time resource was modified, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("LastModifiedBy property, which only appears in the response.")
  @visibility("read")
  lastModifiedBy?: string;

  @doc("Tasks information for the Software update configuration.")
  tasks?: SoftwareUpdateConfigurationTasks;
}

@doc("Update specific properties of the software update configuration.")
model UpdateConfiguration {
  @doc("operating system of target machines")
  operatingSystem: OperatingSystemType;

  @doc("Windows specific update configuration.")
  windows?: WindowsProperties;

  @doc("Linux specific update configuration.")
  linux?: LinuxProperties;

  @doc("Maximum time allowed for the software update configuration run. Duration needs to be specified using the format PT[n]H[n]M[n]S as per ISO8601")
  duration?: duration;

  @doc("List of azure resource Ids for azure virtual machines targeted by the software update configuration.")
  azureVirtualMachines?: string[];

  @doc("List of names of non-azure machines targeted by the software update configuration.")
  nonAzureComputerNames?: string[];

  @doc("Group targets for the software update configuration.")
  targets?: TargetProperties;
}

@doc("Windows specific update configuration.")
model WindowsProperties {
  @doc("Update classification included in the software update configuration. A comma separated string with required values")
  includedUpdateClassifications?: WindowsUpdateClasses;

  @doc("KB numbers excluded from the software update configuration.")
  excludedKbNumbers?: string[];

  @doc("KB numbers included from the software update configuration.")
  includedKbNumbers?: string[];

  @doc("Reboot setting for the software update configuration.")
  rebootSetting?: string;
}

@doc("Linux specific update configuration.")
model LinuxProperties {
  @doc("Update classifications included in the software update configuration.")
  includedPackageClassifications?: LinuxUpdateClasses;

  @doc("packages excluded from the software update configuration.")
  excludedPackageNameMasks?: string[];

  @doc("packages included from the software update configuration.")
  includedPackageNameMasks?: string[];

  @doc("Reboot setting for the software update configuration.")
  rebootSetting?: string;
}

@doc("Group specific to the update configuration.")
model TargetProperties {
  @doc("List of Azure queries in the software update configuration.")
  azureQueries?: AzureQueryProperties[];

  @doc("List of non Azure queries in the software update configuration.")
  nonAzureQueries?: NonAzureQueryProperties[];
}

@doc("Azure query for the update configuration.")
model AzureQueryProperties {
  @doc("List of Subscription or Resource Group ARM Ids.")
  scope?: string[];

  @doc("List of locations to scope the query to.")
  locations?: string[];

  @doc("Tag settings for the VM.")
  tagSettings?: TagSettingsProperties;
}

@doc("Tag filter information for the VM.")
model TagSettingsProperties {
  @doc("Dictionary of tags with its list of values.")
  tags?: Record<string[]>;

  @doc("Filter VMs by Any or All specified tags.")
  filterOperator?: TagOperators;
}

@doc("Non Azure query for the update configuration.")
model NonAzureQueryProperties {
  @doc("Log Analytics Saved Search name.")
  functionAlias?: string;

  @doc("Workspace Id for Log Analytics in which the saved Search is resided.")
  workspaceId?: string;
}

@doc("Definition of schedule parameters.")
model SUCScheduleProperties {
  @doc("Gets or sets the start time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets the start time's offset in minutes.")
  @visibility("read")
  startTimeOffsetMinutes?: float32;

  @doc("Gets or sets the end time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("Gets or sets the expiry time's offset in minutes.")
  expiryTimeOffsetMinutes?: float32;

  @doc("Gets or sets a value indicating whether this schedule is enabled.")
  isEnabled?: boolean;

  @doc("Gets or sets the next run time of the schedule.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRun?: utcDateTime;

  @doc("Gets or sets the next run time's offset in minutes.")
  nextRunOffsetMinutes?: float32;

  @doc("Gets or sets the interval of the schedule.")
  interval?: int32;

  @doc("Gets or sets the frequency of the schedule.")
  frequency?: ScheduleFrequency;

  @doc("Gets or sets the time zone of the schedule.")
  timeZone?: string;

  @doc("Gets or sets the advanced schedule.")
  advancedSchedule?: AdvancedSchedule;

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("Task properties of the software update configuration.")
model SoftwareUpdateConfigurationTasks {
  @doc("Pre task properties.")
  preTask?: TaskProperties;

  @doc("Post task properties.")
  postTask?: TaskProperties;
}

@doc("Task properties of the software update configuration.")
model TaskProperties {
  @doc("Gets or sets the parameters of the task.")
  parameters?: Record<string>;

  @doc("Gets or sets the name of the runbook.")
  source?: string;
}

@doc("Software update configuration collection item properties.")
model SoftwareUpdateConfigurationCollectionItem {
  @doc("Name of the software update configuration.")
  @visibility("read")
  name?: string;

  @doc("Resource Id of the software update configuration")
  @visibility("read")
  id?: string;

  @doc("Software update configuration properties.")
  properties: SoftwareUpdateConfigurationCollectionItemProperties;
}

@doc("Software update configuration collection item properties.")
model SoftwareUpdateConfigurationCollectionItemProperties {
  @doc("Update specific properties of the software update configuration.")
  updateConfiguration?: UpdateConfiguration;

  @doc("Pre and Post Tasks defined")
  tasks?: SoftwareUpdateConfigurationTasks;

  @doc("execution frequency of the schedule associated with the software update configuration")
  frequency?: ScheduleFrequency;

  @doc("the start time of the update.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Creation time of the software update configuration, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Last time software update configuration was modified, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Provisioning state for the software update configuration, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("ext run time of the update.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRun?: utcDateTime;
}

@doc("Software update configuration Run properties.")
model SoftwareUpdateConfigurationRun {
  @doc("Name of the software update configuration run.")
  @visibility("read")
  name?: string;

  @doc("Resource Id of the software update configuration run")
  @visibility("read")
  id?: string;

  @doc("Software update configuration Run properties.")
  properties?: SoftwareUpdateConfigurationRunProperties;
}

@doc("Software update configuration properties.")
model SoftwareUpdateConfigurationRunProperties {
  @doc("software update configuration triggered this run")
  softwareUpdateConfiguration?: UpdateConfigurationNavigation;

  @doc("Status of the software update configuration run.")
  @visibility("read")
  status?: string;

  @doc("Configured duration for the software update configuration run.")
  @visibility("read")
  configuredDuration?: duration;

  @doc("Operating system target of the software update configuration triggered this run")
  @visibility("read")
  osType?: string;

  @doc("Start time of the software update configuration run.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the software update configuration run.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Number of computers in the software update configuration run.")
  @visibility("read")
  computerCount?: int32;

  @doc("Number of computers with failed status.")
  @visibility("read")
  failedCount?: int32;

  @doc("Creation time of the resource, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("CreatedBy property, which only appears in the response.")
  @visibility("read")
  createdBy?: string;

  @doc("Last time resource was modified, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("LastModifiedBy property, which only appears in the response.")
  @visibility("read")
  lastModifiedBy?: string;

  @doc("Software update configuration tasks triggered in this run")
  tasks?: SoftwareUpdateConfigurationRunTasks;
}

@doc("Software update configuration Run Navigation model.")
model UpdateConfigurationNavigation {
  @doc("Name of the software update configuration triggered the software update configuration run")
  @visibility("read")
  name?: string;
}

@doc("Software update configuration run tasks model.")
model SoftwareUpdateConfigurationRunTasks {
  @doc("Pre task properties.")
  preTask?: SoftwareUpdateConfigurationRunTaskProperties;

  @doc("Post task properties.")
  postTask?: SoftwareUpdateConfigurationRunTaskProperties;
}

@doc("Task properties of the software update configuration.")
model SoftwareUpdateConfigurationRunTaskProperties {
  @doc("The status of the task.")
  status?: string;

  @doc("The name of the source of the task.")
  source?: string;

  @doc("The job id of the task.")
  jobId?: string;
}

@doc("result of listing all software update configuration runs")
model SoftwareUpdateConfigurationRunListResult {
  @doc("outer object returned when listing all software update configuration runs")
  value?: SoftwareUpdateConfigurationRun[];

  @doc("link to next page of results.")
  nextLink?: string;
}

@doc("Software update configuration machine run model.")
model SoftwareUpdateConfigurationMachineRun {
  @doc("Name of the software update configuration machine run")
  @visibility("read")
  name?: string;

  @doc("Resource Id of the software update configuration machine run")
  @visibility("read")
  id?: string;

  @doc("Software update configuration machine run properties.")
  properties?: UpdateConfigurationMachineRunProperties;
}

@doc("Software update configuration machine run properties.")
model UpdateConfigurationMachineRunProperties {
  @doc("name of the updated computer")
  @visibility("read")
  targetComputer?: string;

  @doc("type of the updated computer.")
  @visibility("read")
  targetComputerType?: string;

  @doc("software update configuration triggered this run")
  softwareUpdateConfiguration?: UpdateConfigurationNavigation;

  @doc("Status of the software update configuration machine run.")
  @visibility("read")
  status?: string;

  @doc("Operating system target of the software update configuration triggered this run")
  @visibility("read")
  osType?: string;

  @doc("correlation id of the software update configuration machine run")
  @visibility("read")
  correlationId?: string;

  @doc("source computer id of the software update configuration machine run")
  @visibility("read")
  sourceComputerId?: string;

  @doc("Start time of the software update configuration machine run.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time of the software update configuration machine run.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("configured duration for the software update configuration run.")
  @visibility("read")
  configuredDuration?: duration;

  @doc("Job associated with the software update configuration machine run")
  job?: JobNavigation;

  @doc("Creation time of the resource, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("createdBy property, which only appears in the response.")
  @visibility("read")
  createdBy?: string;

  @doc("Last time resource was modified, which only appears in the response.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("lastModifiedBy property, which only appears in the response.")
  @visibility("read")
  lastModifiedBy?: string;

  @doc("Details of provisioning error")
  error?: ErrorResponse;
}

@doc("Software update configuration machine run job navigation properties.")
model JobNavigation {
  @doc("Id of the job associated with the software update configuration run")
  @visibility("read")
  id?: string;
}

@doc("result of listing all software update configuration machine runs")
model SoftwareUpdateConfigurationMachineRunListResult {
  @doc("outer object returned when listing all software update configuration machine runs")
  value?: SoftwareUpdateConfigurationMachineRun[];

  @doc("link to next page of results.")
  nextLink?: string;
}

model RunbookDraft {
  @doc("Gets or sets whether runbook is in edit mode.")
  inEdit?: boolean;

  @doc("Gets or sets the draft runbook content link.")
  draftContentLink?: ContentLink;

  @doc("Gets or sets the creation time of the runbook draft.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time of the runbook draft.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the runbook draft parameters.")
  parameters?: Record<RunbookParameter>;

  @doc("Gets or sets the runbook output types.")
  outputTypes?: string[];
}

@doc("Definition of the runbook parameter type.")
model RunbookParameter {
  @doc("Gets or sets the type of the parameter.")
  type?: string;

  @doc("Gets or sets a Boolean value to indicate whether the parameter is mandatory or not.")
  isMandatory?: boolean;

  @doc("Get or sets the position of the parameter.")
  position?: int32;

  @doc("Gets or sets the default value of parameter.")
  defaultValue?: string;
}

@doc("The response model for the undo edit runbook operation.")
model RunbookDraftUndoEditResult {
  statusCode?: HttpStatusCode;
  requestId?: string;
}

@doc("Definition of the runbook property type.")
model RunbookProperties {
  @doc("Gets or sets the type of the runbook.")
  runbookType?: RunbookTypeEnum;

  @doc("Gets or sets the published runbook content link.")
  publishContentLink?: ContentLink;

  @doc("Gets or sets the state of the runbook.")
  state?: RunbookState;

  @doc("Gets or sets verbose log option.")
  logVerbose?: boolean;

  @doc("Gets or sets progress log option.")
  logProgress?: boolean;

  @doc("Gets or sets the option to log activity trace of the runbook.")
  logActivityTrace?: int32;

  @doc("Gets or sets the job count of the runbook.")
  jobCount?: int32;

  @doc("Gets or sets the runbook parameters.")
  parameters?: Record<RunbookParameter>;

  @doc("Gets or sets the runbook output types.")
  outputTypes?: string[];

  @doc("Gets or sets the draft runbook properties.")
  draft?: RunbookDraft;

  @doc("Gets or sets the provisioning state of the runbook.")
  provisioningState?: "Succeeded";

  @doc("Gets or sets the last modified by.")
  lastModifiedBy?: string;

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("The parameters supplied to the create or update runbook operation.")
model RunbookCreateOrUpdateParameters {
  @doc("Gets or sets runbook create or update properties.")
  properties: RunbookCreateOrUpdateProperties;

  @doc("Gets or sets the name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the create or update runbook properties.")
model RunbookCreateOrUpdateProperties {
  @doc("Gets or sets verbose log option.")
  logVerbose?: boolean;

  @doc("Gets or sets progress log option.")
  logProgress?: boolean;

  @doc("Gets or sets the type of the runbook.")
  runbookType: RunbookTypeEnum;

  @doc("Gets or sets the draft runbook properties.")
  draft?: RunbookDraft;

  @doc("Gets or sets the published runbook content link.")
  publishContentLink?: ContentLink;

  @doc("Gets or sets the description of the runbook.")
  description?: string;

  @doc("Gets or sets the activity-level tracing options of the runbook.")
  logActivityTrace?: int32;
}

@doc("The parameters supplied to the update runbook operation.")
model RunbookUpdateParameters {
  @doc("Gets or sets the runbook update properties.")
  properties?: RunbookUpdateProperties;

  @doc("Gets or sets the name of the resource.")
  name?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets or sets the tags attached to the resource.")
  tags?: Record<string>;
}

@doc("The parameters supplied to the update runbook properties.")
model RunbookUpdateProperties {
  @doc("Gets or sets the description of the runbook.")
  description?: string;

  @doc("Gets or sets verbose log option.")
  logVerbose?: boolean;

  @doc("Gets or sets progress log option.")
  logProgress?: boolean;

  @doc("Gets or sets the activity-level tracing options of the runbook.")
  logActivityTrace?: int32;
}

@doc("The parameters supplied to the create test job operation.")
model TestJobCreateParameters {
  @doc("Gets or sets the parameters of the test job.")
  parameters?: Record<string>;

  @doc("Gets or sets the runOn which specifies the group name where the job is to be executed.")
  runOn?: string;
}

@doc("Definition of the test job.")
model TestJob {
  @doc("Gets or sets the creation time of the test job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the status of the test job.")
  status?: string;

  @doc("Gets or sets the status details of the test job.")
  statusDetails?: string;

  @doc("Gets or sets the runOn which specifies the group name where the job is to be executed.")
  runOn?: string;

  @doc("Gets or sets the start time of the test job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Gets or sets the end time of the test job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Gets or sets the exception of the test job.")
  exception?: string;

  @doc("Gets or sets the last modified time of the test job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Gets or sets the last status modified time of the test job.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusModifiedTime?: utcDateTime;

  @doc("Gets or sets the parameters of the test job.")
  parameters?: Record<string>;

  @doc("The activity-level tracing options of the runbook.")
  logActivityTrace?: int32;
}

@doc("Definition of the webhook properties")
model WebhookProperties {
  @doc("Gets or sets the value of the enabled flag of the webhook.")
  isEnabled?: boolean;

  @doc("Gets or sets the webhook uri.")
  uri?: string;

  @doc("Gets or sets the expiry time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("Gets or sets the last invoked time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastInvokedTime?: utcDateTime;

  @doc("Gets or sets the parameters of the job that is created when the webhook calls the runbook it is associated with.")
  parameters?: Record<string>;

  @doc("Gets or sets the runbook the webhook is associated with.")
  runbook?: RunbookAssociationProperty;

  @doc("Gets or sets the name of the hybrid worker group the webhook job will run on.")
  runOn?: string;

  @doc("Gets or sets the creation time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  @doc("Gets or sets the last modified time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  @doc("Details of the user who last modified the Webhook")
  lastModifiedBy?: string;

  @doc("Gets or sets the description.")
  description?: string;
}

@doc("The parameters supplied to the create or update webhook operation.")
model WebhookCreateOrUpdateParameters {
  @doc("Gets or sets the name of the webhook.")
  name: string;

  @doc("Gets or sets the properties of the webhook.")
  properties: WebhookCreateOrUpdateProperties;
}

@doc("The properties of the create webhook operation.")
model WebhookCreateOrUpdateProperties {
  @doc("Gets or sets the value of the enabled flag of webhook.")
  isEnabled?: boolean;

  @doc("Gets or sets the uri.")
  uri?: string;

  @doc("Gets or sets the expiry time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  @doc("Gets or sets the parameters of the job.")
  parameters?: Record<string>;

  @doc("Gets or sets the runbook.")
  runbook?: RunbookAssociationProperty;

  @doc("Gets or sets the name of the hybrid worker group the webhook job will run on.")
  runOn?: string;
}

@doc("The parameters supplied to the update webhook operation.")
model WebhookUpdateParameters {
  @doc("Gets or sets the name of the webhook.")
  name?: string;

  @doc("Gets or sets the value of the webhook.")
  properties?: WebhookUpdateProperties;
}

@doc("The properties of the update webhook.")
model WebhookUpdateProperties {
  @doc("Gets or sets the value of the enabled flag of webhook.")
  isEnabled?: boolean;

  @doc("Gets or sets the name of the hybrid worker group the webhook job will run on.")
  runOn?: string;

  @doc("Gets or sets the parameters of the job.")
  parameters?: Record<string>;

  @doc("Gets or sets the description of the webhook.")
  description?: string;
}

@doc("Definition of hybrid runbook worker property.")
model HybridRunbookWorkerProperties {
  @doc("Gets or sets the assigned machine IP address.")
  ip?: string;

  @doc("Gets or sets the registration time of the worker machine.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registeredDateTime?: utcDateTime;

  @doc("Last Heartbeat from the Worker")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSeenDateTime?: utcDateTime;

  @doc("Azure Resource Manager Id for a virtual machine.")
  vmResourceId?: string;

  @doc("Type of the HybridWorker.")
  workerType?: WorkerType;

  @doc("Name of the HybridWorker.")
  workerName?: string;
}

@doc("The parameters supplied to the create hybrid runbook worker operation.")
model HybridRunbookWorkerCreateParameters {
  @doc("Gets or sets hybrid runbook worker group create or update properties.")
  properties: HybridRunbookWorkerCreateOrUpdateParameters;

  @doc("Gets or sets the name of the resource.")
  name?: string;
}

@doc("The parameters supplied to the create or update hybrid runbook worker operation.")
model HybridRunbookWorkerCreateOrUpdateParameters {
  @doc("Azure Resource Manager Id for a virtual machine.")
  vmResourceId?: string;
}

@doc("Parameters supplied to move hybrid worker operation.")
model HybridRunbookWorkerMoveParameters {
  @doc("Gets or sets the target hybrid runbook worker group.")
  hybridRunbookWorkerGroupName?: string;
}

@doc("The response model for the list deleted automation account.")
model DeletedAutomationAccountListResult {
  @doc("Gets or sets the list of deleted automation accounts.")
  value?: DeletedAutomationAccount[];
}

@doc("Definition of the deleted automation account type.")
model DeletedAutomationAccount {
  @doc("Gets or sets the automation account properties.")
  properties?: DeletedAutomationAccountProperties;

  @doc("The resource id.")
  id?: string;

  @doc("Gets or sets name of the resource.")
  name?: string;

  @doc("The resource type.")
  type?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;
}

@doc("Definition of the deleted automation account properties.")
model DeletedAutomationAccountProperties {
  @doc("Gets or sets the Automation Account Resource Id.")
  automationAccountResourceId?: string;

  @doc("Gets or sets the Automation Account Id.")
  automationAccountId?: string;

  @doc("Gets or sets the location of the resource.")
  location?: string;

  @doc("Gets the deletion time.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;
}

@doc("Definition of hybrid runbook worker group property.")
model HybridRunbookWorkerGroupProperties {
  @doc("Type of the HybridWorkerGroup.")
  groupType?: GroupTypeEnum;

  @doc("Sets the credential of a worker group.")
  credential?: RunAsCredentialAssociationProperty;
}

@doc("Definition of RunAs credential to use for hybrid worker.")
model RunAsCredentialAssociationProperty {
  @doc("Gets or sets the name of the credential.")
  name?: string;
}

@doc("The parameters supplied to the create hybrid runbook worker group operation.")
model HybridRunbookWorkerGroupCreateOrUpdateParameters {
  @doc("Gets or sets hybrid runbook worker group create or update properties.")
  properties?: HybridRunbookWorkerGroupCreateOrUpdateProperties;

  @doc("Gets or sets the name of the resource.")
  name?: string;
}

@doc("The hybrid runbook worker group properties.")
model HybridRunbookWorkerGroupCreateOrUpdateProperties {
  @doc("Sets the credential of a worker group.")
  credential?: RunAsCredentialAssociationProperty;
}

@doc("The parameters supplied to the create or update draft runbook properties.")
model RunbookCreateOrUpdateDraftProperties {
  @doc("Gets or sets verbose log option.")
  logVerbose?: boolean;

  @doc("Gets or sets progress log option.")
  logProgress?: boolean;

  @doc("Gets or sets the type of the runbook.")
  runbookType: RunbookTypeEnum;

  @doc("Gets or sets the draft runbook properties.")
  draft: RunbookDraft;

  @doc("Gets or sets the description of the runbook.")
  description?: string;

  @doc("Gets or sets the activity-level tracing options of the runbook.")
  logActivityTrace?: int32;
}

@doc("The parameters supplied to the create or update runbook operation.")
model RunbookCreateOrUpdateDraftParameters {
  @doc("Content of the Runbook.")
  runbookContent: string;
}
