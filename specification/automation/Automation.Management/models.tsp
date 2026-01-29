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
/**
 * The response model for the list dsc nodes operation.
 */
model DscNodeListResult {
  /**
   * Gets or sets a list of dsc nodes.
   */
  @pageItems
  value?: DscNode[];

  /**
   * Gets or sets the next link.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the total number of nodes matching filter criteria.
   */
  totalCount?: int32;
}
/**
 * The response model for the list configuration operation.
 */
model DscConfigurationListResult {
  /**
   * Gets or sets a list of configurations.
   */
  @pageItems
  value?: DscConfiguration[];

  /**
   * Gets or sets the next link.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets the total number of configurations matching filter criteria.
   */
  totalCount?: int32;
}

/**
 * The response model for the list job operation.
 */
model DscNodeConfigurationListResult {
  /**
   * Gets or sets a list of Dsc node configurations.
   */
  @pageItems
  value?: DscNodeConfiguration[];

  /**
   * Gets or sets the next link.
   */
  @nextLink
  nextLink?: string;

  /**
   * Gets or sets the total rows in query.
   */
  totalCount?: int32;
}

model HybridRunbookWorkersListResult is ResourceListResult<HybridRunbookWorker>;
model HybridRunbookWorkerGroupsListResult
  is ResourceListResult<HybridRunbookWorkerGroup>;

/**
 * The response model for the list of Automation operations
 */
model OperationListResult {
  /**
   * List of Automation operations supported by the Automation resource provider.
   */
  @pageItems
  @identifiers(#["name"])
  value: Operation[];

  /**
   * The URL to get the next set of results, if any.
   */
  @nextLink
  nextLink?: string;
}

@mediaTypeHint("text/powershell")
scalar stringTextPowershell extends string;

@mediaTypeHint("text/plain")
scalar stringTextPlain extends string;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union CountType {
  string,

  /**
   * status
   */
  status: "status",

  /**
   * nodeconfiguration
   */
  nodeconfiguration: "nodeconfiguration",
}

/**
 * Update classification included in the software update configuration. A comma separated string with required values
 */
union WindowsUpdateClasses {
  string,

  /**
   * Unclassified
   */
  Unclassified: "Unclassified",

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Security
   */
  Security: "Security",

  /**
   * UpdateRollup
   */
  UpdateRollup: "UpdateRollup",

  /**
   * FeaturePack
   */
  FeaturePack: "FeaturePack",

  /**
   * ServicePack
   */
  ServicePack: "ServicePack",

  /**
   * Definition
   */
  Definition: "Definition",

  /**
   * Tools
   */
  Tools: "Tools",

  /**
   * Updates
   */
  Updates: "Updates",
}

/**
 * Update classifications included in the software update configuration.
 */
union LinuxUpdateClasses {
  string,

  /**
   * Unclassified
   */
  Unclassified: "Unclassified",

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Security
   */
  Security: "Security",

  /**
   * Other
   */
  Other: "Other",
}

/**
 * Gets or sets the frequency of the schedule.
 */
union ScheduleFrequency {
  string,

  /**
   * OneTime
   */
  OneTime: "OneTime",

  /**
   * Day
   */
  Day: "Day",

  /**
   * Hour
   */
  Hour: "Hour",

  /**
   * Week
   */
  Week: "Week",

  /**
   * Month
   */
  Month: "Month",

  /**
   * The minimum allowed interval for Minute schedules is 15 minutes.
   */
  Minute: "Minute",
}

/**
 * Day of the occurrence. Must be one of monday, tuesday, wednesday, thursday, friday, saturday, sunday.
 */
union ScheduleDay {
  string,

  /**
   * Monday
   */
  Monday: "Monday",

  /**
   * Tuesday
   */
  Tuesday: "Tuesday",

  /**
   * Wednesday
   */
  Wednesday: "Wednesday",

  /**
   * Thursday
   */
  Thursday: "Thursday",

  /**
   * Friday
   */
  Friday: "Friday",

  /**
   * Saturday
   */
  Saturday: "Saturday",

  /**
   * Sunday
   */
  Sunday: "Sunday",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Gets or sets the agent registration key name - primary or secondary.
 */
union AgentRegistrationKeyName {
  string,

  /**
   * primary
   */
  primary: "primary",

  /**
   * secondary
   */
  secondary: "secondary",
}

/**
 * Gets or sets the SKU name of the account.
 */
union SkuNameEnum {
  string,

  /**
   * Free
   */
  Free: "Free",

  /**
   * Basic
   */
  Basic: "Basic",
}

/**
 * Gets status of account.
 */
union AutomationAccountState {
  string,

  /**
   * Ok
   */
  Ok: "Ok",

  /**
   * Unavailable
   */
  Unavailable: "Unavailable",

  /**
   * Suspended
   */
  Suspended: "Suspended",
}

/**
 * Automation key name.
 */
union AutomationKeyName {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * Automation key permissions.
 */
union AutomationKeyPermissions {
  string,

  /**
   * Read
   */
  Read: "Read",

  /**
   * Full
   */
  Full: "Full",
}

/**
 * Gets or sets the content source type.
 */
union ContentSourceType {
  string,

  /**
   * embeddedContent
   */
  embeddedContent: "embeddedContent",

  /**
   * uri
   */
  uri: "uri",
}

/**
 * Gets or sets the state of the configuration.
 */
union DscConfigurationState {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * Edit
   */
  Edit: "Edit",

  /**
   * Published
   */
  Published: "Published",
}

/**
 * Type of the HybridWorker.
 */
union WorkerType {
  string,

  /**
   * HybridV1
   */
  HybridV1: "HybridV1",

  /**
   * HybridV2
   */
  HybridV2: "HybridV2",
}

/**
 * Type of the HybridWorkerGroup.
 */
union GroupTypeEnum {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * System
   */
  System: "System",
}

/**
 * Gets or sets the status of the job.
 */
union JobStatus {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * Activating
   */
  Activating: "Activating",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Blocked
   */
  Blocked: "Blocked",

  /**
   * Suspended
   */
  Suspended: "Suspended",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Suspending
   */
  Suspending: "Suspending",

  /**
   * Stopping
   */
  Stopping: "Stopping",

  /**
   * Resuming
   */
  Resuming: "Resuming",

  /**
   * Removing
   */
  Removing: "Removing",
}

/**
 * The provisioning state of the resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union JobProvisioningState {
  string,

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Suspended
   */
  Suspended: "Suspended",

  /**
   * Processing
   */
  Processing: "Processing",
}

/**
 * Gets or sets the stream type.
 */
union JobStreamType {
  string,

  /**
   * Progress
   */
  Progress: "Progress",

  /**
   * Output
   */
  Output: "Output",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",

  /**
   * Debug
   */
  Debug: "Debug",

  /**
   * Verbose
   */
  Verbose: "Verbose",

  /**
   * Any
   */
  Any: "Any",
}

/**
 * Gets or sets the provisioning state of the module.
 */
union ModuleProvisioningState {
  string,

  /**
   * Created
   */
  Created: "Created",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * StartingImportModuleRunbook
   */
  StartingImportModuleRunbook: "StartingImportModuleRunbook",

  /**
   * RunningImportModuleRunbook
   */
  RunningImportModuleRunbook: "RunningImportModuleRunbook",

  /**
   * ContentRetrieved
   */
  ContentRetrieved: "ContentRetrieved",

  /**
   * ContentDownloaded
   */
  ContentDownloaded: "ContentDownloaded",

  /**
   * ContentValidated
   */
  ContentValidated: "ContentValidated",

  /**
   * ConnectionTypeImported
   */
  ConnectionTypeImported: "ConnectionTypeImported",

  /**
   * ContentStored
   */
  ContentStored: "ContentStored",

  /**
   * ModuleDataStored
   */
  ModuleDataStored: "ModuleDataStored",

  /**
   * ActivitiesStored
   */
  ActivitiesStored: "ActivitiesStored",

  /**
   * ModuleImportRunbookComplete
   */
  ModuleImportRunbookComplete: "ModuleImportRunbookComplete",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Updating
   */
  Updating: "Updating",
}

/**
 * Runbook Type
 */
union GraphRunbookType {
  string,

  /**
   * GraphPowerShell
   */
  GraphPowerShell: "GraphPowerShell",

  /**
   * GraphPowerShellWorkflow
   */
  GraphPowerShellWorkflow: "GraphPowerShellWorkflow",
}

/**
 * Gets or sets the provisioning state of the Package.
 */
union PackageProvisioningState {
  string,

  /**
   * Created
   */
  Created: "Created",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * StartingImportModuleRunbook
   */
  StartingImportModuleRunbook: "StartingImportModuleRunbook",

  /**
   * RunningImportModuleRunbook
   */
  RunningImportModuleRunbook: "RunningImportModuleRunbook",

  /**
   * ContentRetrieved
   */
  ContentRetrieved: "ContentRetrieved",

  /**
   * ContentDownloaded
   */
  ContentDownloaded: "ContentDownloaded",

  /**
   * ContentValidated
   */
  ContentValidated: "ContentValidated",

  /**
   * ConnectionTypeImported
   */
  ConnectionTypeImported: "ConnectionTypeImported",

  /**
   * ContentStored
   */
  ContentStored: "ContentStored",

  /**
   * ModuleDataStored
   */
  ModuleDataStored: "ModuleDataStored",

  /**
   * ActivitiesStored
   */
  ActivitiesStored: "ActivitiesStored",

  /**
   * ModuleImportRunbookComplete
   */
  ModuleImportRunbookComplete: "ModuleImportRunbookComplete",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Updating
   */
  Updating: "Updating",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union HttpStatusCode {
  string,

  /**
   * Continue
   */
  Continue: "Continue",

  /**
   * SwitchingProtocols
   */
  SwitchingProtocols: "SwitchingProtocols",

  /**
   * OK
   */
  OK: "OK",

  /**
   * Created
   */
  Created: "Created",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * NonAuthoritativeInformation
   */
  NonAuthoritativeInformation: "NonAuthoritativeInformation",

  /**
   * NoContent
   */
  NoContent: "NoContent",

  /**
   * ResetContent
   */
  ResetContent: "ResetContent",

  /**
   * PartialContent
   */
  PartialContent: "PartialContent",

  /**
   * MultipleChoices
   */
  MultipleChoices: "MultipleChoices",

  /**
   * Ambiguous
   */
  Ambiguous: "Ambiguous",

  /**
   * MovedPermanently
   */
  MovedPermanently: "MovedPermanently",

  /**
   * Moved
   */
  Moved: "Moved",

  /**
   * Found
   */
  Found: "Found",

  /**
   * Redirect
   */
  Redirect: "Redirect",

  /**
   * SeeOther
   */
  SeeOther: "SeeOther",

  /**
   * RedirectMethod
   */
  RedirectMethod: "RedirectMethod",

  /**
   * NotModified
   */
  NotModified: "NotModified",

  /**
   * UseProxy
   */
  UseProxy: "UseProxy",

  /**
   * Unused
   */
  Unused: "Unused",

  /**
   * TemporaryRedirect
   */
  TemporaryRedirect: "TemporaryRedirect",

  /**
   * RedirectKeepVerb
   */
  RedirectKeepVerb: "RedirectKeepVerb",

  /**
   * BadRequest
   */
  BadRequest: "BadRequest",

  /**
   * Unauthorized
   */
  Unauthorized: "Unauthorized",

  /**
   * PaymentRequired
   */
  PaymentRequired: "PaymentRequired",

  /**
   * Forbidden
   */
  Forbidden: "Forbidden",

  /**
   * NotFound
   */
  NotFound: "NotFound",

  /**
   * MethodNotAllowed
   */
  MethodNotAllowed: "MethodNotAllowed",

  /**
   * NotAcceptable
   */
  NotAcceptable: "NotAcceptable",

  /**
   * ProxyAuthenticationRequired
   */
  ProxyAuthenticationRequired: "ProxyAuthenticationRequired",

  /**
   * RequestTimeout
   */
  RequestTimeout: "RequestTimeout",

  /**
   * Conflict
   */
  Conflict: "Conflict",

  /**
   * Gone
   */
  Gone: "Gone",

  /**
   * LengthRequired
   */
  LengthRequired: "LengthRequired",

  /**
   * PreconditionFailed
   */
  PreconditionFailed: "PreconditionFailed",

  /**
   * RequestEntityTooLarge
   */
  RequestEntityTooLarge: "RequestEntityTooLarge",

  /**
   * RequestUriTooLong
   */
  RequestUriTooLong: "RequestUriTooLong",

  /**
   * UnsupportedMediaType
   */
  UnsupportedMediaType: "UnsupportedMediaType",

  /**
   * RequestedRangeNotSatisfiable
   */
  RequestedRangeNotSatisfiable: "RequestedRangeNotSatisfiable",

  /**
   * ExpectationFailed
   */
  ExpectationFailed: "ExpectationFailed",

  /**
   * UpgradeRequired
   */
  UpgradeRequired: "UpgradeRequired",

  /**
   * InternalServerError
   */
  InternalServerError: "InternalServerError",

  /**
   * NotImplemented
   */
  NotImplemented: "NotImplemented",

  /**
   * BadGateway
   */
  BadGateway: "BadGateway",

  /**
   * ServiceUnavailable
   */
  ServiceUnavailable: "ServiceUnavailable",

  /**
   * GatewayTimeout
   */
  GatewayTimeout: "GatewayTimeout",

  /**
   * HttpVersionNotSupported
   */
  HttpVersionNotSupported: "HttpVersionNotSupported",
}

/**
 * Gets or sets the type of the runbook.
 */
union RunbookTypeEnum {
  string,

  /**
   * Script
   */
  Script: "Script",

  /**
   * Graph
   */
  Graph: "Graph",

  /**
   * PowerShellWorkflow
   */
  PowerShellWorkflow: "PowerShellWorkflow",

  /**
   * PowerShell
   */
  PowerShell: "PowerShell",

  /**
   * GraphPowerShellWorkflow
   */
  GraphPowerShellWorkflow: "GraphPowerShellWorkflow",

  /**
   * GraphPowerShell
   */
  GraphPowerShell: "GraphPowerShell",

  /**
   * Python2
   */
  Python2: "Python2",

  /**
   * Python3
   */
  Python3: "Python3",

  /**
   * Python
   */
  Python: "Python",

  /**
   * PowerShell72
   */
  PowerShell72: "PowerShell72",
}

/**
 * Gets or sets the state of the runbook.
 */
union RunbookState {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * Edit
   */
  Edit: "Edit",

  /**
   * Published
   */
  Published: "Published",
}

/**
 * The source type. Must be one of VsoGit, VsoTfvc, GitHub.
 */
union SourceType {
  string,

  /**
   * VsoGit
   */
  VsoGit: "VsoGit",

  /**
   * VsoTfvc
   */
  VsoTfvc: "VsoTfvc",

  /**
   * GitHub
   */
  GitHub: "GitHub",
}

/**
 * The token type. Must be either PersonalAccessToken or Oauth.
 */
union TokenType {
  string,

  /**
   * PersonalAccessToken
   */
  PersonalAccessToken: "PersonalAccessToken",

  /**
   * Oauth
   */
  Oauth: "Oauth",
}

/**
 * The provisioning state of the job.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Running
   */
  Running: "Running",
}

/**
 * The sync type.
 */
union SyncType {
  string,

  /**
   * PartialSync
   */
  PartialSync: "PartialSync",

  /**
   * FullSync
   */
  FullSync: "FullSync",
}

/**
 * The type of the sync job stream.
 */
union StreamType {
  string,

  /**
   * Error
   */
  Error: "Error",

  /**
   * Output
   */
  Output: "Output",
}

/**
 * Target operating system for the software update configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperatingSystemType {
  /**
   * Windows
   */
  Windows,

  /**
   * Linux
   */
  Linux,
}

/**
 * Filter VMs by Any or All specified tags.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum TagOperators {
  /**
   * All
   */
  All,

  /**
   * Any
   */
  Any,
}

/**
 * Encryption Key Source
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum EncryptionKeySourceType {
  /**
   * Microsoft.Automation
   */
  `Microsoft.Automation`,

  /**
   * Microsoft.Keyvault
   */
  `Microsoft.Keyvault`,
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResourceIdentityType {
  /**
   * SystemAssigned
   */
  SystemAssigned,

  /**
   * UserAssigned
   */
  UserAssigned,

  /**
   * SystemAssigned, UserAssigned
   */
  `SystemAssigned, UserAssigned`,

  /**
   * None
   */
  None,
}

/**
 * Gets the count of nodes by count type
 */
model NodeCounts {
  /**
   * Gets an array of counts
   */
  @pageItems
  @identifiers(#["name"])
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: NodeCountProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NodeCountProperties {
  /**
   * Gets the count for the name
   */
  count?: int32;
}

/**
 * Error response of an operation failure
 */
@error
model ErrorResponse {
  /**
   * Error code
   */
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  message?: string;
}

/**
 * Software update configuration properties.
 */
model softwareUpdateConfigurationProperties {
  /**
   * update specific properties for the Software update configuration
   */
  updateConfiguration: updateConfiguration;

  /**
   * Schedule information for the Software update configuration
   */
  scheduleInfo: SUCScheduleProperties;

  /**
   * Provisioning state for the software update configuration, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Details of provisioning error
   */
  error?: ErrorResponse;

  /**
   * Creation time of the resource, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * CreatedBy property, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * Last time resource was modified, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * LastModifiedBy property, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  /**
   * Tasks information for the Software update configuration.
   */
  tasks?: softwareUpdateConfigurationTasks;
}

/**
 * Update specific properties of the software update configuration.
 */
model updateConfiguration {
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
  @identifiers(#[])
  azureQueries?: AzureQueryProperties[];

  /**
   * List of non Azure queries in the software update configuration.
   */
  @identifiers(#["workspaceId"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  startTimeOffsetMinutes?: float64;

  /**
   * Gets or sets the end time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime | null;

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
  nextRun?: utcDateTime | null;

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
  @identifiers(#[])
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
 * Task properties of the software update configuration.
 */
model softwareUpdateConfigurationTasks {
  /**
   * Pre task properties.
   */
  preTask?: taskProperties;

  /**
   * Post task properties.
   */
  postTask?: taskProperties;
}

/**
 * Task properties of the software update configuration.
 */
model taskProperties {
  /**
   * Gets or sets the parameters of the task.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<string>;

  /**
   * Gets or sets the name of the runbook.
   */
  source?: string;
}

/**
 * result of listing all software update configuration
 */
model softwareUpdateConfigurationListResult {
  /**
   * outer object returned when listing all software update configurations
   */
  @pageItems
  value?: softwareUpdateConfigurationCollectionItem[];
}

/**
 * Software update configuration collection item properties.
 */
model softwareUpdateConfigurationCollectionItem {
  /**
   * Name of the software update configuration.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource Id of the software update configuration
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Software update configuration properties.
   */
  properties: softwareUpdateConfigurationCollectionItemProperties;
}

/**
 * Software update configuration collection item properties.
 */
model softwareUpdateConfigurationCollectionItemProperties {
  /**
   * Update specific properties of the software update configuration.
   */
  updateConfiguration?: updateConfiguration;

  /**
   * Pre and Post Tasks defined
   */
  tasks?: softwareUpdateConfigurationTasks;

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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Last time software update configuration was modified, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Provisioning state for the software update configuration, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * ext run time of the update.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  nextRun?: utcDateTime | null;
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;
}

/**
 * A list of private link resources
 */
model PrivateLinkResourceListResult {
  /**
   * Array of private link resources
   */
  @pageItems
  value?: PrivateLinkResource[];

  @nextLink
  nextLink?: string;
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
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
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  nodeConfiguration?: DscNodeConfigurationAssociationProperty | null;

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
  @identifiers(#["name"])
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: DscNodeUpdateParametersProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  endTime?: utcDateTime | null;

  /**
   * Gets or sets the lastModifiedTime of the node report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Gets or sets the start time of the node report.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime | null;

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
  @identifiers(#["errorMessage", "resourceId"])
  errors?: DscReportError[];

  /**
   * Gets or sets the resource for the node report.
   */
  @identifiers(#["resourceId"])
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
  @identifiers(#["resourceId"])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  userAssignedIdentity?: unknown;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity. The value must be an UUID.
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
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentitiesProperties>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model UserAssignedIdentitiesProperties {
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
 * Definition of the account property.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  state?: AutomationAccountState;

  /**
   * Gets the creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility(Lifecycle.Read)
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
 * Properties of a private endpoint connection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
model StatisticsListResult {
  /**
   * Gets or sets a list of statistics.
   */
  @pageItems
  value?: Statistics[];

  @nextLink
  nextLink?: string;
}

/**
 * Definition of the statistic.
 */
model Statistics {
  /**
   * Gets the property value of the statistic.
   */
  @visibility(Lifecycle.Read)
  counterProperty?: string;

  /**
   * Gets the value of the statistic.
   */
  @visibility(Lifecycle.Read)
  counterValue?: int64;

  /**
   * Gets the startTime of the statistic.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the endTime of the statistic.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

  /**
   * Gets the id.
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * The response model for the get usage operation.
 */
model UsageListResult {
  /**
   * Gets or sets usage.
   */
  @pageItems
  value?: Usage[];

  @nextLink
  nextLink?: string;
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model KeyListResult {
  /**
   * Lists the automation keys.
   */
  @identifiers(#["KeyName"])
  keys?: Key[];
}

/**
 * Automation key which is used to register a DSC Node
 */
model Key {
  /**
   * Automation key name.
   */
  @visibility(Lifecycle.Read)
  KeyName?: AutomationKeyName;

  /**
   * Automation key permissions.
   */
  @visibility(Lifecycle.Read)
  Permissions?: AutomationKeyPermissions;

  /**
   * Value of the Automation Key used for registration.
   */
  @visibility(Lifecycle.Read)
  Value?: string;
}

/**
 * The response model for the list deleted runbook.
 */
model DeletedRunbookListResult is Azure.Core.Page<DeletedRunbook>;

/**
 * Definition of deleted runbook.
 */
model DeletedRunbook {
  /**
   * Gets or sets the runbook properties.
   */
  properties?: DeletedRunbookProperties;

  /**
   * The resource id.
   */
  id?: string;

  /**
   * Gets or sets name of the resource.
   */
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  location?: string;
}

/**
 * Definition of the deleted runbook property.
 */
model DeletedRunbookProperties {
  /**
   * Gets or sets the Runbook Id.
   */
  runbookId?: string;

  /**
   * Type of the runbook.
   */
  runbookType?: string;

  /**
   * Gets or sets runtime of the runbook.
   */
  runtime?: string;

  /**
   * Environment of the runbook.
   */
  runtimeEnvironment?: string | null;

  /**
   * Gets or sets the creation time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  deletionTime?: utcDateTime;
}

/**
 * Properties of the certificate.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CertificateProperties {
  /**
   * Gets the thumbprint of the certificate.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Gets the expiry time of the certificate.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime;

  /**
   * Gets the is exportable flag of the certificate.
   */
  @visibility(Lifecycle.Read)
  isExportable?: boolean;

  /**
   * Gets the creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ConnectionProperties {
  /**
   * Gets or sets the connectionType of the connection.
   */
  connectionType?: ConnectionTypeAssociationProperty;

  /**
   * Gets the field definition values of the connection.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  fieldDefinitionValues?: Record<string>;

  /**
   * Gets the creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  fieldDefinitionValues?: Record<string>;
}

/**
 * Properties of the connection type.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ConnectionTypeProperties {
  /**
   * Gets or sets a Boolean value to indicate if the connection type is global.
   */
  isGlobal?: boolean;

  /**
   * Gets the field definitions of the connection type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  fieldDefinitions?: Record<FieldDefinition>;

  /**
   * Gets the creation time.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  fieldDefinitions: Record<FieldDefinition>;
}

/**
 * Definition of the credential properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CredentialProperties {
  /**
   * Gets the user name of the credential.
   */
  @visibility(Lifecycle.Read)
  userName?: string;

  /**
   * Gets the creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets the last modified time.
   */
  @visibility(Lifecycle.Read)
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
 * Definition of the configuration property type.
 */
model DscConfigurationProperties {
  /**
   * Gets or sets the provisioning state of the configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  provisioningState?: "Succeeded";

  /**
   * Gets or sets the job count of the configuration.
   */
  jobCount?: int32;

  /**
   * Gets or sets the configuration parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties for the DscNodeConfiguration
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
 * Definition of hybrid runbook worker property.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  properties?: HybridRunbookWorkerCreateOrUpdateParameters;

  /**
   * Gets or sets the name of the resource.
   */
  @visibility(Lifecycle.Read)
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
 * Definition of hybrid runbook worker group property.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
   * Runtime Environment Property
   */
  jobRuntimeEnvironment?: JobRuntimeEnvironment;

  /**
   * Gets or sets the id of the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
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
  startTime?: utcDateTime | null;

  /**
   * Gets or sets the end time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

  /**
   * Gets or sets the exception of the job.
   */
  exception?: string;

  /**
   * Gets or sets the last modified time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime | null;

  /**
   * Gets or sets the last status modified time of the job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusModifiedTime?: utcDateTime | null;

  /**
   * Gets or sets the parameters of the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<string>;

  /**
   * The current provisioning state of the job.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: JobProvisioningState;
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
 * The runbook property associated with the entity.
 */
model JobRuntimeEnvironment {
  /**
   * Name of Runtime Environment.
   */
  runtimeEnvironmentName?: string;
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model JobCreateProperties {
  /**
   * Gets or sets the runbook.
   */
  runbook?: RunbookAssociationProperty;

  /**
   * Gets or sets the parameters of the job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<string>;

  /**
   * Gets or sets the runOn which specifies the group name where the job is to be executed.
   */
  runOn?: string;
}

/**
 * The response model for the list job operation.
 */
model JobListResultV2 is Azure.Core.Page<JobCollectionItem>;

/**
 * Job collection item properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model JobCollectionItem
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
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
  @visibility(Lifecycle.Read)
  runbook?: RunbookAssociationProperty;

  /**
   * The id of the job.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  jobId?: string;

  /**
   * Gets or sets the job started by.
   */
  @visibility(Lifecycle.Read)
  startedBy?: string | null;

  /**
   * The creation time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The status of the job.
   */
  @visibility(Lifecycle.Read)
  status?: JobStatus;

  /**
   * The start time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime | null;

  /**
   * The end time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

  /**
   * The last modified time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime | null;

  /**
   * The provisioning state of a resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Runtime Environment Property
   */
  jobRuntimeEnvironment?: JobRuntimeEnvironment;

  /**
   * Specifies the runOn group name where the job was executed.
   */
  runOn?: string;
}

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
  summary?: string | null;

  /**
   * Gets or sets the values of the job stream.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  value?: Record<unknown>;
}

/**
 * The response model for the list job stream operation.
 */
model JobStreamListResult is Azure.Core.Page<JobStream>;

/**
 * Definition of job schedule parameters.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<string>;
}

/**
 * Definition of the linked workspace.
 */
model LinkedWorkspace {
  /**
   * Gets the id of the linked workspace.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name"])
  parameterSets?: ActivityParameterSet[];

  /**
   * Gets or sets the output types of the activity.
   */
  @identifiers(#["name"])
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
  @identifiers(#[])
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
  @identifiers(#[])
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
   * Gets or sets the uri of content.
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Gets or sets the location of the resource.
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Gets or sets the tags attached to the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
model TypeFieldListResult {
  /**
   * Gets or sets a list of fields.
   */
  @pageItems
  @identifiers(#[])
  value?: TypeField[];

  @nextLink
  nextLink?: string;
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
 * Automation REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Provider, Resource and Operation values
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation.
   */
  origin?: string;

  /**
   * Operation properties format.
   */
  properties?: OperationPropertiesFormat;
}

/**
 * Provider, Resource and Operation values
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft.Automation
   */
  provider?: string;

  /**
   * Resource on which the operation is performed: Runbooks, Jobs etc.
   */
  resource?: string;

  /**
   * Operation type: Read, write, delete, etc.
   */
  operation?: string;

  /**
   * Description of the operation.
   */
  description?: string;
}

/**
 * Description of operation properties format.
 */
model OperationPropertiesFormat {
  /**
   * Specification of the service.
   */
  serviceSpecification?: OperationPropertiesFormatServiceSpecification;
}

/**
 * Specification of the service.
 */
model OperationPropertiesFormatServiceSpecification {
  /**
   * Operation service specification.
   */
  @identifiers(#[])
  metricSpecifications?: MetricSpecification[];

  /**
   * Operation log specification.
   */
  @identifiers(#[])
  logSpecifications?: LogSpecification[];
}

/**
 * Description of metrics specification.
 */
model MetricSpecification {
  /**
   * The name of the metric.
   */
  name?: string;

  /**
   * The display name of the metric.
   */
  displayName?: string;

  /**
   * The description of the metric.
   */
  displayDescription?: string;

  /**
   * Units the metric to be displayed in.
   */
  unit?: string;

  /**
   * The aggregation type.
   */
  aggregationType?: string;

  /**
   * List of dimensions.
   */
  @identifiers(#[])
  dimensions?: Dimension[];
}

/**
 * Dimension of the metric.
 */
model Dimension {
  /**
   * The name of the dimension.
   */
  name?: string;

  /**
   * The display name of the dimension.
   */
  displayName?: string;
}

/**
 * Description of logging specification.
 */
model LogSpecification {
  /**
   * The name of the specification.
   */
  name?: string;

  /**
   * The display name of the specification.
   */
  displayName?: string;

  /**
   * Duration of the blob.
   */
  blobDuration?: string;
}

/**
 * Graphical Runbook Content
 */
model GraphicalRunbookContent {
  /**
   * Raw graphical Runbook content.
   */
  rawContent?: RawGraphicalRunbookContent | null;

  /**
   * Graphical Runbook content as JSON
   */
  graphRunbookJson?: string | null;
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
 * Definition of the package property type.
 */
model PackageProperties {
  /**
   * Gets or sets the isGlobal flag of the package.
   */
  default?: boolean;

  /**
   * Gets or sets the version of the Package.
   */
  version?: string;

  /**
   * Gets or sets the size in bytes of the Package.
   */
  sizeInBytes?: int64;

  /**
   * Gets or sets the provisioning state of the Package.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PackageProvisioningState;

  /**
   * Gets or sets the contentLink of the Package.
   */
  contentLink?: ContentLink;

  /**
   * Gets or sets the error info of the Package.
   */
  error?: PackageErrorInfo;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  allOf?: SystemData;
}

/**
 * Definition of the package error info type.
 */
model PackageErrorInfo {
  /**
   * Package import error code.
   */
  code?: string;

  /**
   * Package import error message.
   */
  message?: string;
}

/**
 * The parameters supplied to the create or update package operation.
 */
model PackageCreateOrUpdateParameters {
  /**
   * Gets or sets the package create properties.
   */
  properties: PackageCreateOrUpdateProperties;

  /**
   * The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'
   */
  allOf?: Azure.ResourceManager.CommonTypes.TrackedResource;
}

/**
 * The parameters supplied to the create or update package properties.
 */
model PackageCreateOrUpdateProperties {
  /**
   * Gets or sets the package content link.
   */
  contentLink: ContentLink;
}

/**
 * The parameters supplied to the update package operation.
 */
model PackageUpdateParameters {
  /**
   * Gets or sets the package update properties.
   */
  properties?: PackageUpdateProperties;

  /**
   * The resource model definition for an Azure Resource Manager tracked top level resource which has 'tags' and a 'location'
   */
  allOf?: Azure.ResourceManager.CommonTypes.TrackedResource;
}

/**
 * The parameters supplied to the update properties.
 */
model PackageUpdateProperties {
  /**
   * Gets or sets the package content link.
   */
  contentLink?: ContentLink;
}

/**
 * A list of private endpoint connections
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  @pageItems
  value?: PrivateEndpointConnection[];

  @nextLink
  nextLink?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  statusCode?: HttpStatusCode;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  requestId?: string;
}

/**
 * Definition of the runbook property type.
 */
model RunbookProperties {
  /**
   * Runtime Environment of the runbook execution.
   */
  runtimeEnvironment?: string;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
   * Environment of the runbook.
   */
  runtimeEnvironment?: string;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<string>;

  /**
   * Gets or sets the runOn which specifies the group name where the job is to be executed.
   */
  runOn?: string;

  /**
   * The runtime Environment Name on which job needs to be tested
   */
  runtimeEnvironment?: string;
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
  startTime?: utcDateTime | null;

  /**
   * Gets or sets the end time of the test job.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

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
  lastStatusModifiedTime?: utcDateTime | null;

  /**
   * Gets or sets the parameters of the test job.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<string>;

  /**
   * The activity-level tracing options of the runbook.
   */
  logActivityTrace?: int32;
}

/**
 * The parameters supplied to the update automation account operation.
 */
model RuntimeEnvironmentUpdateParameters {
  /**
   * Gets or sets Runtime update properties.
   */
  properties?: RuntimeEnvironmentUpdateProperties;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Gets or sets Runtime update properties.
 */
model RuntimeEnvironmentUpdateProperties {
  /**
   * List of Default packages for Environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  defaultPackages?: Record<string>;
}

/**
 * Runtime Environment properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model RuntimeEnvironmentProperties {
  /**
   *  Runtime properties.
   */
  runtime?: RuntimeProperties;

  /**
   * List of Default packages for Environment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  defaultPackages?: Record<string>;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

/**
 * Runtime properties.
 */
model RuntimeProperties {
  /**
   * Language of Runtime Environment
   */
  language?: string;

  /**
   * Version of Language
   */
  version?: string;
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
  expiryTime?: utcDateTime | null;

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
 * Definition of schedule parameters.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ScheduleProperties {
  /**
   * Gets or sets the start time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Gets the start time's offset in minutes.
   */
  @visibility(Lifecycle.Read)
  startTimeOffsetMinutes?: float64;

  /**
   * Gets or sets the end time of the schedule.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiryTime?: utcDateTime | null;

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
  nextRun?: utcDateTime | null;

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
 * Software update configuration machine run model.
 */
model softwareUpdateConfigurationMachineRun {
  /**
   * Name of the software update configuration machine run
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource Id of the software update configuration machine run
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Software update configuration machine run properties.
   */
  properties?: updateConfigurationMachineRunProperties;
}

/**
 * Software update configuration machine run properties.
 */
model updateConfigurationMachineRunProperties {
  /**
   * name of the updated computer
   */
  @visibility(Lifecycle.Read)
  targetComputer?: string;

  /**
   * type of the updated computer.
   */
  @visibility(Lifecycle.Read)
  targetComputerType?: string;

  /**
   * software update configuration triggered this run
   */
  softwareUpdateConfiguration?: updateConfigurationNavigation;

  /**
   * Status of the software update configuration machine run.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Operating system target of the software update configuration triggered this run
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * correlation id of the software update configuration machine run
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  correlationId?: string;

  /**
   * source computer id of the software update configuration machine run
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  sourceComputerId?: string;

  /**
   * Start time of the software update configuration machine run.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the software update configuration machine run.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

  /**
   * configured duration for the software update configuration run.
   */
  @visibility(Lifecycle.Read)
  configuredDuration?: string;

  /**
   * Job associated with the software update configuration machine run
   */
  job?: jobNavigation;

  /**
   * Creation time of the resource, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * createdBy property, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * Last time resource was modified, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * lastModifiedBy property, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  /**
   * Details of provisioning error
   */
  error?: ErrorResponse;
}

/**
 * Software update configuration Run Navigation model.
 */
model updateConfigurationNavigation {
  /**
   * Name of the software update configuration triggered the software update configuration run
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * Software update configuration machine run job navigation properties.
 */
model jobNavigation {
  /**
   * Id of the job associated with the software update configuration run
   */
  @visibility(Lifecycle.Read)
  id?: string;
}

/**
 * result of listing all software update configuration machine runs
 */
model softwareUpdateConfigurationMachineRunListResult
  is Azure.Core.Page<softwareUpdateConfigurationMachineRun>;

/**
 * Software update configuration Run properties.
 */
model softwareUpdateConfigurationRun {
  /**
   * Name of the software update configuration run.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource Id of the software update configuration run
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Software update configuration Run properties.
   */
  properties?: softwareUpdateConfigurationRunProperties;
}

/**
 * Software update configuration properties.
 */
model softwareUpdateConfigurationRunProperties {
  /**
   * software update configuration triggered this run
   */
  softwareUpdateConfiguration?: updateConfigurationNavigation;

  /**
   * Status of the software update configuration run.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Configured duration for the software update configuration run.
   */
  @visibility(Lifecycle.Read)
  configuredDuration?: string;

  /**
   * Operating system target of the software update configuration triggered this run
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * Start time of the software update configuration run.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the software update configuration run.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

  /**
   * Number of computers in the software update configuration run.
   */
  @visibility(Lifecycle.Read)
  computerCount?: int32;

  /**
   * Number of computers with failed status.
   */
  @visibility(Lifecycle.Read)
  failedCount?: int32;

  /**
   * Creation time of the resource, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * CreatedBy property, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * Last time resource was modified, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * LastModifiedBy property, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  /**
   * Software update configuration tasks triggered in this run
   */
  tasks?: softwareUpdateConfigurationRunTasks;
}

/**
 * Software update configuration run tasks model.
 */
model softwareUpdateConfigurationRunTasks {
  /**
   * Pre task properties.
   */
  preTask?: softwareUpdateConfigurationRunTaskProperties;

  /**
   * Post task properties.
   */
  postTask?: softwareUpdateConfigurationRunTaskProperties;
}

/**
 * Task properties of the software update configuration.
 */
model softwareUpdateConfigurationRunTaskProperties {
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
model softwareUpdateConfigurationRunListResult
  is Azure.Core.Page<softwareUpdateConfigurationRun>;

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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  @minLength(0)
  commitId: string;
}

/**
 * Definition of the source control sync job.
 */
model SourceControlSyncJob {
  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource id.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The provisioning state of the job.
   */
  provisioningState?: ProvisioningState;

  /**
   * The start time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime | null;

  /**
   * The end time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The provisioning state of the job.
   */
  provisioningState?: ProvisioningState;

  /**
   * The start time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime | null;

  /**
   * The end time of the job.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime | null;

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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime | null;

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
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime | null;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  value?: Record<unknown>;
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model VariableProperties {
  /**
   * Gets or sets the value of the variable.
   */
  value?: string;

  /**
   * Gets or sets the encrypted flag of the variable.
   */
  isEncrypted?: boolean | null;

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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  scriptParameters?: Record<string>;

  /**
   * Gets or sets the name of the hybrid worker group the watcher will run on.
   */
  scriptRunOn?: string;

  /**
   * Gets the current status of the watcher.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Gets or sets the creation time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * Gets or sets the last modified time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedTime?: utcDateTime;

  /**
   * Details of the user who last modified the watcher.
   */
  @visibility(Lifecycle.Read)
  lastModifiedBy?: string;

  /**
   * Gets or sets the description.
   */
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
 * Definition of the webhook properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  lastInvokedTime?: utcDateTime | null;

  /**
   * Gets or sets the parameters of the job that is created when the webhook calls the runbook it is associated with.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<string>;

  /**
   * Gets or sets the description of the webhook.
   */
  description?: string;
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
   * Environment of the runbook.
   */
  runtimeEnvironment?: string;

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
