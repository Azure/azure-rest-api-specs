import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace DevCenterService;

@doc("The operating system type.")
union OsType {
  @doc("The Windows operating system.") Windows: "Windows",
  string,
}

@doc("Indicates whether hibernate is supported and enabled, disabled, or unsupported by the operating system. Unknown hibernate support is represented as null.")
union HibernateSupport {
  @doc("Hibernate is enabled.")
  Enabled: "Enabled",

  @doc("Hibernate is not enabled.")
  Disabled: "Disabled",

  @doc("Hibernate is not supported by the operating system.")
  OsUnsupported: "OsUnsupported",

  string,
}

@doc("Indicates whether single sign on is enabled or disabled on the dev box.")
union SingleSignOnStatus {
  @doc("The dev box is configured for single sign on.")
  Enabled: "Enabled",

  @doc("The dev box is not configured for single sign on.")
  Disabled: "Disabled",

  string,
}

@doc("Indicates whether owners of Dev Boxes in a pool are local administrators on the Dev Boxes.")
union LocalAdminStatus {
  @doc("Owners of Dev Boxes in the pool are local administrators on the Dev Boxes.")
  Enabled: "Enabled",

  @doc("Owners of Dev Boxes in the pool are not local administrators on the Dev Boxes.")
  Disabled: "Disabled",

  string,
}

@doc("Indicates the provisioning state of the Dev Box.")
union DevBoxProvisioningState {
  @doc("Dev Box was successfully provisioned.") Succeeded: "Succeeded",
  @doc("Dev Box failed to provision.") Failed: "Failed",
  @doc("Dev Box provision was canceled.") Canceled: "Canceled",
  @doc("Dev Box is being created.") Creating: "Creating",
  @doc("Dev Box is being deleted.") Deleting: "Deleting",
  @doc("Dev Box is updating.") Updating: "Updating",
  @doc("Dev Box is starting.") Starting: "Starting",
  @doc("Dev Box is stopping.") Stopping: "Stopping",
  @doc("Dev Box is provisioning.") Provisioning: "Provisioning",

  @added(APIVersions.v2025_04_01_preview)
  @doc("Dev Box is pending approval.")
  PendingApproval: "PendingApproval",

  @doc("Dev Box was provisioned with warning.")
  ProvisionedWithWarning: "ProvisionedWithWarning",

  @doc("Dev Box is in grace period.") InGracePeriod: "InGracePeriod",
  @doc("Dev Box is not provisioned.") NotProvisioned: "NotProvisioned",
  string,
}

@doc("Indicates the general provisioning state.")
@added(APIVersions.v2025_04_01_preview)
union ProvisioningState {
  @doc("Resource is creating.") Creating: "Creating",
  @doc("Resource is being updated.") Updating: "Updating",
  @doc("Resource is being deleted.") Deleting: "Deleting",
  @doc("Resource was successfully provisioned.") Succeeded: "Succeeded",
  @doc("Resource failed to provision.") Failed: "Failed",
  string,
}

@doc("Indicates the Dev Box compute.")
union SkuName {
  @doc("Intel, 8 vCPU, 32 GB RAM, 256 GB Storage.")
  general_i_8c32gb256ssd_v2: "general_i_8c32gb256ssd_v2",

  @doc("Intel, 8 vCPU, 32 GB RAM, 512 GB Storage.")
  general_i_8c32gb512ssd_v2: "general_i_8c32gb512ssd_v2",

  @doc("Intel, 8 vCPU, 32 GB RAM, 1024 GB Storage.")
  general_i_8c32gb1024ssd_v2: "general_i_8c32gb1024ssd_v2",

  @doc("Intel, 8 vCPU, 32 GB RAM, 2048 GB Storage.")
  general_i_8c32gb2048ssd_v2: "general_i_8c32gb2048ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 256 GB Storage.")
  general_i_16c64gb256ssd_v2: "general_i_16c64gb256ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 512 GB Storage.")
  general_i_16c64gb512ssd_v2: "general_i_16c64gb512ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 1024 GB Storage.")
  general_i_16c64gb1024ssd_v2: "general_i_16c64gb1024ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 2048 GB Storage.")
  general_i_16c64gb2048ssd_v2: "general_i_16c64gb2048ssd_v2",

  @doc("Intel, 32 vCPU, 128 GB RAM, 512 GB Storage.")
  general_i_32c128gb512ssd_v2: "general_i_32c128gb512ssd_v2",

  @doc("Intel, 32 vCPU, 128 GB RAM, 1024 GB Storage.")
  general_i_32c128gb1024ssd_v2: "general_i_32c128gb1024ssd_v2",

  @doc("Intel, 32 vCPU, 128 GB RAM, 2048 GB Storage.")
  general_i_32c128gb2048ssd_v2: "general_i_32c128gb2048ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 256 GB Storage.")
  general_a_8c32gb256ssd_v2: "general_a_8c32gb256ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 512 GB Storage.")
  general_a_8c32gb512ssd_v2: "general_a_8c32gb512ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 1024 GB Storage.")
  general_a_8c32gb1024ssd_v2: "general_a_8c32gb1024ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 2048 GB Storage.")
  general_a_8c32gb2048ssd_v2: "general_a_8c32gb2048ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 256 GB Storage.")
  general_a_16c64gb256ssd_v2: "general_a_16c64gb256ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 512 GB Storage.")
  general_a_16c64gb512ssd_v2: "general_a_16c64gb512ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 1024 GB Storage.")
  general_a_16c64gb1024ssd_v2: "general_a_16c64gb1024ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 2048 GB Storage.")
  general_a_16c64gb2048ssd_v2: "general_a_16c64gb2048ssd_v2",

  @doc("AMD, 32 vCPU, 128 GB RAM, 512 GB Storage.")
  general_a_32c128gb512ssd_v2: "general_a_32c128gb512ssd_v2",

  @doc("AMD, 32 vCPU, 128 GB RAM, 1024 GB Storage.")
  general_a_32c128gb1024ssd_v2: "general_a_32c128gb1024ssd_v2",

  @doc("AMD, 32 vCPU, 128 GB RAM, 2048 GB Storage.")
  general_a_32c128gb2048ssd_v2: "general_a_32c128gb2048ssd_v2",

  string,
}

@doc("Indicates whether the feature to stop the devbox on disconnect once the grace period has lapsed is enabled.")
union StopOnDisconnectEnableStatus {
  @doc("Stop on disconnect is enabled on the Dev Box.")
  Enabled: "Enabled",

  @doc("Stop on disconnect is not enabled on the Dev Box.")
  Disabled: "Disabled",

  string,
}

@doc("Stop on no connect enable or disable status.")
@added(APIVersions.v2024_10_01_preview)
union StopOnNoConnectEnableStatus {
  @doc("Stop on no connect is enabled on the Dev Box.")
  Enabled: "Enabled",

  @doc("Stop on no connect is not enabled on the Dev Box.")
  Disabled: "Disabled",

  string,
}

@doc("Pool status indicating whether a pool is available to create Dev Boxes.")
union PoolHealthStatus {
  @doc("The pool health status is not known.")
  Unknown: "Unknown",

  @doc("The pool health status waiting for health checks to run.")
  Pending: "Pending",

  @doc("The pool health status is healthy.")
  Healthy: "Healthy",

  @doc("The pool health status has one or more warnings.")
  Warning: "Warning",

  @doc("The pool health status is not healthy.")
  Unhealthy: "Unhealthy",

  string,
}

@doc("Possible values for the pool align target.")
@added(APIVersions.v2025_04_01_preview)
union PoolAlignTarget {
  @doc("Network properties.")
  NetworkProperties: "NetworkProperties",

  @added(APIVersions.v2025_07_01_preview)
  @doc("Hibernate support.")
  HibernateSupport: "HibernateSupport",

  @added(APIVersions.v2025_07_01_preview)
  @doc("Single sign on status.")
  SingleSignOnStatus: "SingleSignOnStatus",

  string,
}

@doc("Indicates which pool properties to align on.")
@added(APIVersions.v2025_04_01_preview)
model PoolAlignBody {
  @doc("The targets to align on.")
  targets: Array<PoolAlignTarget>;
}

@doc("The type of the resource that this schedule belongs to.")
@added(APIVersions.v2024_02_01)
union ScheduleSourceType {
  @doc("The schedule source is a Dev Box pool.")
  Pool: "Pool",

  string,
}

@doc("The supported types for a scheduled task.")
union ScheduledType {
  @doc("The scheduled task will stop impacted Dev Boxes.")
  StopDevBox: "StopDevBox",

  string,
}

@doc("The frequency of task execution.")
union ScheduledFrequency {
  @doc("The scheduled task will run every day.")
  Daily: "Daily",

  string,
}

@doc("Type of the parameter.")
@added(APIVersions.v2024_05_01_preview)
union CustomizationTaskDefinitionParameterType {
  @doc("The parameter accepts a string value.")
  string: "string",

  @doc("The parameter accepts a number value.")
  number: "number",

  @doc("The parameter accepts a boolean value.")
  boolean: "boolean",

  string,
}

@doc("What account to run the task as.")
@added(APIVersions.v2024_05_01_preview)
union CustomizationTaskExecutionAccount {
  @doc("The SYSTEM account.")
  System: "System",

  @doc("The account of the signed in user.")
  User: "User",

  string,
}

@doc("Status of a customization task.")
@added(APIVersions.v2024_05_01_preview)
union CustomizationTaskStatus {
  @doc("The task has not yet started.")
  NotStarted: "NotStarted",

  @doc("The task is currently executing.")
  Running: "Running",

  @doc("The task successfully executed.")
  Succeeded: "Succeeded",

  @doc("The task reference is not valid.")
  FailedValidation: "FailedValidation",

  @doc("he task was skipped.")
  Skipped: "Skipped",

  @doc("The task timed out.")
  TimedOut: "TimedOut",

  @doc("The task failed to execute.")
  Failed: "Failed",

  @doc("The task is awaiting the User Account Control (UAC) prompt to be approved. (See more at: https://learn.microsoft.com/windows/security/application-security/application-control/user-account-control/)")
  WaitingForUserInputUac: "WaitingForUserInputUac",

  @doc("The task is awaiting the user to connect to the Dev Box to execute.")
  WaitingForUserSession: "WaitingForUserSession",

  string,
}

@doc("Status of validating a list of customization tasks.")
@added(APIVersions.v2024_05_01_preview)
union CustomizationTaskListValidationStatus {
  @doc("Validation succeeded.")
  Succeeded: "Succeeded",

  @doc("Validation failed.")
  Failed: "Failed",

  string,
}

@doc("The power states of a Dev Box.")
union PowerState {
  @doc("The Dev Box power state is not known.")
  Unknown: "Unknown",

  @doc("The Dev Box is running.")
  Running: "Running",

  @doc("The Dev Box is deallocated.")
  Deallocated: "Deallocated",

  @doc("The Dev Box is powered off.")
  PoweredOff: "PoweredOff",

  @doc("The Dev Box is hibernated.")
  Hibernated: "Hibernated",

  string,
}

@doc("Status of validating a list of customization tasks.")
@added(APIVersions.v2024_05_01_preview)
union ListCustomizationGroupsIncludeProperty {
  @doc("Include list of tasks in the response.")
  tasks: "tasks",

  string,
}

@doc("Status of a customization group.")
@added(APIVersions.v2024_05_01_preview)
union CustomizationGroupStatus {
  @doc("The customization group has not yet started.")
  NotStarted: "NotStarted",

  @doc("The customization group is currently executing.")
  Running: "Running",

  @doc("All tasks in the customization group successfully executed.")
  Succeeded: "Succeeded",

  @doc("At least one task in the customization group failed.")
  Failed: "Failed",

  @doc("At least one task in the customization group failed validation.")
  ValidationFailed: "ValidationFailed",

  string,
}

@doc("The type of action which will take place on a Dev Box.")
union DevBoxActionType {
  @doc("The action will stop the Dev Box.")
  Stop: "Stop",

  string,
}

@doc("The type of the resource which triggered the action.")
@added(APIVersions.v2024_02_01)
union DevBoxActionSourceType {
  @doc("The action was triggered by a Dev Box pool.")
  Pool: "Pool",

  @doc("The action was triggered by a Dev Box schedule.")
  Schedule: "Schedule",

  string,
}

@doc("The result of the delay operation on this action.")
union DevBoxActionDelayResultStatus {
  @doc("The delay operation succeeded.")
  Succeeded: "Succeeded",

  @doc("The delay operation failed.")
  Failed: "Failed",

  string,
}

@doc("The type of Dev Box operation.")
@added(APIVersions.v2024_02_01)
union DevBoxOperationKind {
  @doc("The operation represents a Dev Box start.")
  Start: "Start",

  @doc("The operation represents a Dev Box stop.")
  Stop: "Stop",

  @doc("The operation represents a Dev Box restart.")
  Restart: "Restart",

  @doc("The operation represents a Dev Box repair.")
  Repair: "Repair",

  @doc("The operation represents a Dev Box restore from snapshot.")
  @added(APIVersions.v2024_09_01_preview)
  RestoreSnapshot: "RestoreSnapshot",

  @doc("The operation represents a Dev Box manual snapshot creation.")
  @added(APIVersions.v2024_10_01_preview)
  CaptureSnapshot: "CaptureSnapshot",

  @doc("The operation represents a Dev Box align to the current network connection.")
  @added(APIVersions.v2025_04_01_preview)
  Align: "Align",

  string,
}

@doc("The action taken during a repair operation.")
@added(APIVersions.v2024_02_01)
union DevBoxRepairOutcome {
  @doc("A fix for an issue was automatically applied to the Dev Box.")
  FixApplied: "FixApplied",

  @doc("One or more issues was detected on the Dev Box, but they could not be fixed automatically.")
  IssuesDetected: "IssuesDetected",

  @doc("The service did not identify any issues on the Dev Box.")
  NoIssuesDetected: "NoIssuesDetected",

  string,
}

@doc("The type of snapshot.")
@added(APIVersions.v2024_10_01_preview)
union SnapshotType {
  @doc("The snapshot type indicates that this is a manually taken snapshot.")
  Manual: "Manual",

  @doc("The snapshot type indicates that this is an automatically taken snapshot.")
  Automatic: "Automatic",

  string,
}

@doc("A pool of Dev Boxes.")
@resource("pools")
@parentResource(Project)
model Pool {
  @doc("The unique URI of the pool.")
  @added(APIVersions.v2024_02_01)
  uri: url;

  @key("poolName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility(Lifecycle.Read)
  @doc("Pool name.")
  name: string;

  @doc("Azure region where Dev Boxes in the pool are located.")
  location: Azure.Core.azureLocation;

  @doc("The operating system type of Dev Boxes in this pool.")
  osType?: OsType;

  @doc("Hardware settings for the Dev Boxes created in this pool.")
  hardwareProfile?: HardwareProfile;

  @doc("Indicates whether hibernate is enabled/disabled or unknown.")
  hibernateSupport?: HibernateSupport;

  @doc("Storage settings for Dev Box created in this pool.")
  storageProfile?: StorageProfile;

  @doc("Image settings for Dev Boxes create in this pool.")
  imageReference?: ImageReference;

  @doc("""
    Indicates whether owners of Dev Boxes in this pool are local administrators on
    the Dev Boxes.
    """)
  localAdministrator?: LocalAdminStatus;

  @doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
  stopOnDisconnect?: StopOnDisconnectConfiguration;

  @doc("Stop on no connect configuration settings for Dev Boxes created in this pool.")
  @added(APIVersions.v2024_10_01_preview)
  stopOnNoConnect?: StopOnNoConnectConfiguration;

  @doc("""
    Overall health status of the Pool. Indicates whether or not the Pool is
    available to create Dev Boxes.
    """)
  healthStatus: PoolHealthStatus;

  @doc("Display name of the pool.")
  @added(APIVersions.v2024_02_01)
  displayName?: string;

  @doc("The default active hours configuration for Dev Boxes created in this pool.")
  @added(APIVersions.v2025_04_01_preview)
  activeHoursConfiguration?: PoolActiveHoursConfiguration;

  @doc("Indicates whether single sign on is enabled/disabled or unknown.")
  @added(APIVersions.v2025_07_01_preview)
  singleSignOnStatus?: SingleSignOnStatus;
}

@doc("Hardware specifications for the Dev Box.")
model HardwareProfile {
  @doc("The name of the SKU.")
  @visibility(Lifecycle.Read)
  skuName?: SkuName;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The number of vCPUs available for the Dev Box.")
  @visibility(Lifecycle.Read)
  vCPUs?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The amount of memory available for the Dev Box.")
  @visibility(Lifecycle.Read)
  memoryGB?: int32;
}

@doc("Storage settings for the Dev Box's disks.")
model StorageProfile {
  @doc("Settings for the operating system disk.")
  osDisk?: OsDisk;
}

@doc("Settings for the operating system disk.")
model OsDisk {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The size of the OS Disk in gigabytes.")
  @visibility(Lifecycle.Read)
  diskSizeGB?: int32;
}

@doc("Specifies information about the image used.")
model ImageReference {
  @doc("The name of the image used.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The version of the image.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("The operating system of the image.")
  @visibility(Lifecycle.Read)
  operatingSystem?: string;

  @doc("The operating system build number of the image.")
  @visibility(Lifecycle.Read)
  osBuildNumber?: string;

  @doc("The datetime that the backing image version was published, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  publishedDate?: utcDateTime;
}

@doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
model StopOnDisconnectConfiguration {
  @doc("""
    Indicates whether the feature to stop the devbox on disconnect once the grace
    period has lapsed is enabled.
    """)
  status: StopOnDisconnectEnableStatus;

  @doc("""
    The specified time in minutes to wait before stopping a Dev Box once disconnect
    is detected.
    """)
  gracePeriodMinutes?: int32;
}

@doc("Stop on no connect configuration settings for Dev Boxes created in this pool.")
@added(APIVersions.v2024_10_01_preview)
model StopOnNoConnectConfiguration {
  @doc("""
    Enables the feature to stop a started Dev Box when it has not been connected to, once the grace period has lapsed.
    """)
  status: StopOnNoConnectEnableStatus;

  @doc("The specified time in minutes to wait before stopping a Dev Box if no connection is made. This will only be present if stop on no connect is enabled.")
  gracePeriodMinutes?: int32;
}

@doc("The default active hours configuration settings.")
@added(APIVersions.v2025_04_01_preview)
model PoolActiveHoursConfiguration {
  @doc("Enables or disables whether the Dev Box should be kept awake during active hours.")
  keepAwakeEnableStatus: KeepAwakeEnableStatus;

  @doc("Enables or disables whether the Dev Box should be automatically started at commencement of active hours.")
  autoStartEnableStatus: AutoStartEnableStatus;

  @doc("The default IANA timezone id of the active hours.")
  defaultTimeZone?: string;

  @doc("The default start time of the active hours.")
  defaultStartTimeHour?: int32;

  @doc("The default end time of the active hours.")
  defaultEndTimeHour?: int32;

  @doc("The days of the week that active hours features will be enabled.")
  @added(APIVersions.v2025_07_01_preview)
  defaultDaysOfWeek?: DayOfWeek[];

  @doc("The maximum amount of days per week that a user can enable active hours related features.")
  @added(APIVersions.v2025_07_01_preview)
  daysOfWeekLimit?: int32;
}

@doc("The active hours configuration for a Dev Box.")
@added(APIVersions.v2025_04_01_preview)
model ActiveHoursConfiguration {
  @doc("Enables or disables whether the Dev Box should be kept awake during active hours.")
  keepAwakeEnableStatus: KeepAwakeEnableStatus;

  @doc("Enables or disables whether the Dev Box should be automatically started at commencement of active hours.")
  autoStartEnableStatus: AutoStartEnableStatus;

  ...UserActiveHoursConfiguration;
}

@doc("Enables or disables whether the Dev Box should be kept awake during active hours.")
@added(APIVersions.v2025_04_01_preview)
union KeepAwakeEnableStatus {
  @doc("Keep awake is enabled.")
  Enabled: "Enabled",

  @doc("Keep awake is disabled.")
  Disabled: "Disabled",

  string,
}

@doc("Enables or disables whether the Dev Box should be automatically started at commencement of active hours.")
@added(APIVersions.v2025_04_01_preview)
union AutoStartEnableStatus {
  @doc("Auto start is enabled.")
  Enabled: "Enabled",

  @doc("Auto start is disabled.")
  Disabled: "Disabled",

  string,
}

@doc("Manual user set active hours configuration.")
@added(APIVersions.v2025_04_01_preview)
model UserActiveHoursConfiguration {
  @doc("The timezone of the active hours.")
  timeZone?: string;

  @doc("The start time of the active hours.")
  startTimeHour?: int32;

  @doc("The end time of the active hours.")
  endTimeHour?: int32;

  @doc("The days of the week.")
  @added(APIVersions.v2025_07_01_preview)
  daysOfWeek?: DayOfWeek[];
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Days of week will never change."
@doc("Days of the week.")
@added(APIVersions.v2025_07_01_preview)
union DayOfWeek {
  @doc("Monday")
  Monday: "Monday",

  @doc("Tuesday")
  Tuesday: "Tuesday",

  @doc("Wednesday")
  Wednesday: "Wednesday",

  @doc("Thursday")
  Thursday: "Thursday",

  @doc("Friday")
  Friday: "Friday",

  @doc("Saturday")
  Saturday: "Saturday",

  @doc("Sunday")
  Sunday: "Sunday",
}

alias ScheduleListResult = Azure.Core.Page<Schedule>;

@doc("A Schedule to execute action.")
@resource("schedules")
@parentResource(Pool)
model Schedule {
  @doc("The unique URI of the schedule.")
  @added(APIVersions.v2024_02_01)
  uri: url;

  @key("scheduleName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility(Lifecycle.Read)
  @doc("Display name for the Schedule.")
  name: string;

  @doc("The URI of the resource that this schedule belongs to.")
  @added(APIVersions.v2024_02_01)
  sourceUri: url;

  @doc("The type of the resource that this schedule belongs to.")
  @added(APIVersions.v2024_02_01)
  sourceType: ScheduleSourceType;

  @doc("Supported type this scheduled task represents.")
  type: ScheduledType;

  @doc("The frequency of this scheduled task.")
  frequency: ScheduledFrequency;

  @doc("The target time to trigger the action. The format is HH:MM.")
  //no build in time type matches HH:MM time format
  time: string;

  @doc("The IANA timezone id at which the schedule should execute.")
  timeZone: string;
}

alias DevBoxListResult = Azure.Core.Page<DevBox>;

@doc("A Dev Box.")
@resource("devboxes")
@parentResource(User)
model DevBox {
  @doc("The unique URI of the dev box.")
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2024_02_01)
  uri: url;

  @key("devBoxName")
  @doc("Display name for the Dev Box.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Name of the project this Dev Box belongs to.")
  @visibility(Lifecycle.Read)
  projectName?: string;

  @doc("The name of the Dev Box pool this machine belongs to.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  poolName: string;

  @doc("Indicates whether hibernate is enabled/disabled or unknown.")
  @visibility(Lifecycle.Read)
  hibernateSupport?: HibernateSupport;

  @doc("The current provisioning state of the Dev Box.")
  @visibility(Lifecycle.Read)
  provisioningState?: DevBoxProvisioningState;

  @doc("""
    The current action state of the Dev Box. This is state is based on previous
    action performed by user.
    """)
  @visibility(Lifecycle.Read)
  actionState?: string;

  @doc("The current power state of the Dev Box.")
  @visibility(Lifecycle.Read)
  powerState?: PowerState;

  @doc("""
    A unique identifier for the Dev Box. This is a GUID-formatted string (e.g.
    00000000-0000-0000-0000-000000000000).
    """)
  @visibility(Lifecycle.Read)
  uniqueId?: Azure.Core.uuid;

  @doc("Provisioning or action error details. Populated only for error states.")
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;

  @doc("""
    Azure region where this Dev Box is located. This will be the same region as the
    Virtual Network it is attached to.
    """)
  @visibility(Lifecycle.Read)
  location?: Azure.Core.azureLocation;

  @doc("The operating system type of this Dev Box.")
  @visibility(Lifecycle.Read)
  osType?: OsType;

  @doc("The AAD object id of the user this Dev Box is assigned to.")
  @visibility(Lifecycle.Read)
  user?: Azure.Core.uuid;

  @doc("Information about the Dev Box's hardware resources.")
  @visibility(Lifecycle.Read)
  hardwareProfile?: HardwareProfile;

  @doc("Storage settings for this Dev Box.")
  @visibility(Lifecycle.Read)
  storageProfile?: StorageProfile;

  @doc("Information about the image used for this Dev Box.")
  @visibility(Lifecycle.Read)
  imageReference?: ImageReference;

  @doc("Creation time of this Dev Box, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  createdTime?: utcDateTime;

  @doc("Last time a user connected to this Dev Box, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2024_10_01_preview)
  lastConnectedTime?: utcDateTime;

  @doc("Indicates whether the owner of the Dev Box is a local administrator.")
  @visibility(Lifecycle.Read)
  localAdministrator?: LocalAdminStatus;

  @doc("The active hours configuration for this Dev Box, if enabled.")
  @added(APIVersions.v2025_04_01_preview)
  @visibility(Lifecycle.Read)
  activeHoursConfiguration?: ActiveHoursConfiguration;

  @doc("Indicates whether single sign on is enabled/disabled or unknown.")
  @added(APIVersions.v2025_07_01_preview)
  @visibility(Lifecycle.Read)
  singleSignOnStatus?: SingleSignOnStatus;
}

@doc("Provides remote connection information for a Dev Box.")
model RemoteConnection {
  @doc("URL to open a browser based RDP session.")
  webUrl?: url;

  @doc("Link to open a Remote Desktop session.")
  rdpConnectionUrl?: url;

  @added(APIVersions.v2024_05_01_preview)
  @doc("Link to open a remote desktop session via a dev box's underlying Cloud PC (This will default to Windows App).")
  cloudPcConnectionUrl?: url;
}

@doc("An action which will take place on a Dev Box.")
@resource("actions")
@parentResource(DevBox)
model DevBoxAction {
  @doc("The unique URI for the Dev Box action.")
  @added(APIVersions.v2024_02_01)
  uri: url;

  @key("actionName")
  @doc("The name of the action.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The action that will be taken.")
  actionType: DevBoxActionType;

  @doc("The id of the resource which triggered this action.")
  sourceId: string;

  @doc("The URI of the resource which triggered this action.")
  @added(APIVersions.v2024_02_01)
  sourceUri: url;

  @doc("The type of the resource which triggered this action.")
  @added(APIVersions.v2024_02_01)
  sourceType: DevBoxActionSourceType;

  @doc("The earliest time that the action could occur (UTC), in RFC3339 format.")
  suspendedUntil?: utcDateTime;

  @doc("Details about the next run of this action.")
  next?: DevBoxNextAction;
}

@doc("Details about the next run of an action.")
model DevBoxNextAction {
  @doc("The time the action will be triggered (UTC), in RFC3339 format.")
  scheduledTime: utcDateTime;
}

alias DevBoxActionsDelayMultipleResult = Azure.Core.Page<DevBoxActionDelayResult>;

@doc("The action delay result.")
model DevBoxActionDelayResult {
  @doc("The unique URI of the action.")
  @added(APIVersions.v2024_02_01)
  uri: url;

  @doc("The name of the action.")
  name: string;

  @doc("The result of the delay operation on this action.")
  result: DevBoxActionDelayResultStatus;

  @doc("The delayed action.")
  action?: DevBoxAction;

  @doc("Information about the error that occurred. Only populated on error.")
  error?: Azure.Core.Foundations.Error;
}

@doc("Information about an operation on a Dev Box.")
@resource("operations")
@parentResource(DevBox)
@added(APIVersions.v2024_02_01)
@discriminator("kind")
model DevBoxOperation {
  @doc("The unique URI for the Dev Box operation.")
  uri: url;

  @doc("Unique identifier for the Dev Box operation.")
  @minLength(36)
  @maxLength(36)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$")
  @visibility(Lifecycle.Read)
  @key("operationId")
  operationId: Azure.Core.uuid;

  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind;

  @doc("The operation status.")
  status: Azure.Core.Foundations.OperationState;

  @doc("The object ID of the actor which initiated the operation.")
  createdByObjectId?: Azure.Core.uuid;

  @doc("he time the operation started, in RFC3339 format.")
  startTime?: utcDateTime;

  @doc("The time the operation finished, in RFC3339 format.")
  endTime?: utcDateTime;

  @doc("Provisioning or operation error details. Populated only for error states.")
  error?: Azure.Core.Foundations.Error;
}

@doc("Information about a start operation on a Dev Box.")
@added(APIVersions.v2024_02_01)
model DevBoxStartOperation extends DevBoxOperation {
  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind.Start;
}

@doc("Information about an align operation on a Dev Box.")
@added(APIVersions.v2025_04_01_preview)
model DevBoxAlignOperation extends DevBoxOperation {
  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind.Align;
}

@doc("Information about a stop operation on a Dev Box.")
@added(APIVersions.v2024_02_01)
model DevBoxStopOperation extends DevBoxOperation {
  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind.Stop;
}

@doc("Information about a restart operation on a Dev Box.")
@added(APIVersions.v2024_02_01)
model DevBoxRestartOperation extends DevBoxOperation {
  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind.Restart;
}

@doc("Information about a start operation on a Dev Box.")
@added(APIVersions.v2024_02_01)
model DevBoxRepairOperation extends DevBoxOperation {
  @doc("The result of the repair operation.")
  result?: DevBoxRepairOperationResult;

  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind.Repair;
}

@doc("Information about the result of a repair operation on a Dev Box.")
@added(APIVersions.v2024_02_01)
model DevBoxRepairOperationResult {
  @doc("The outcome of the repair operation.")
  repairOutcome?: DevBoxRepairOutcome;

  @doc("The result code associated with the repair operation.")
  code?: string;

  @doc("The result message associated with the repair operation.")
  message?: string;
}

@doc("Information about a restore from snapshot operation on a Dev Box.")
@added(APIVersions.v2024_09_01_preview)
model DevBoxRestoreSnapshotOperation extends DevBoxOperation {
  @doc("Specifies the snapshot id that was used for the restore operation.")
  snapshotId: string;

  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind.RestoreSnapshot;
}

@doc("Information about a snapshot creation operation on a Dev Box.")
@added(APIVersions.v2024_10_01_preview)
model DevBoxCaptureSnapshotOperation extends DevBoxOperation {
  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind.CaptureSnapshot;
}

@doc("The Customization Task list result.")
model PagedCustomizationTaskDefinition
  is Azure.Core.Page<CustomizationTaskDefinition>;

@doc("Represents a task to be used in customizing a Dev Box.")
@added(APIVersions.v2024_05_01_preview)
@resource("customizationTasks")
@parentResource(Catalog)
model CustomizationTaskDefinition {
  @doc("Full name of the task: {catalogName}/{taskName}.")
  @key("taskName")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Name of the catalog that the task belongs to.")
  @visibility(Lifecycle.Read)
  catalogName: string;

  @doc("The unique URI of the customization task.")
  @visibility(Lifecycle.Read)
  uri?: url;

  @doc("Description of the task.")
  description?: string;

  @doc("Parameters for the task.")
  parameters?: Record<CustomizationTaskDefinitionParameter>;
}

@doc("Parameters for a customization task.")
@added(APIVersions.v2024_05_01_preview)
model CustomizationTaskDefinitionParameter {
  @doc("Description of the parameter.")
  description?: string;

  @doc("Type of the parameter.")
  type: CustomizationTaskDefinitionParameterType;

  @doc("Whether or not the parameter is required.")
  @visibility(Lifecycle.Read)
  required?: boolean;

  @doc("Default value for the parameter.")
  default?: string;

  @doc("Allowed values for the parameter.")
  allowed?: string[];
}

@doc("Represents a list of tasks to apply to a Dev Box")
@added(APIVersions.v2024_05_01_preview)
model CustomizationTaskList {
  @doc("Tasks to apply.")
  tasks?: CustomizationTask[];
}

@doc("A customization task to run on a Dev Box.")
@resource("customizationTasks")
@parentResource(Catalog)
@added(APIVersions.v2024_05_01_preview)
model CustomizationTask {
  @doc("Name of the task.")
  @key("taskName")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("Parameters for the task.")
  parameters?: Record<string>;

  @doc("Display name to help differentiate multiple instances of the same task.")
  displayName?: string;

  @doc("Timeout, in seconds. Overrides any timeout provided on the task definition.")
  timeoutInSeconds?: int32;

  @doc("What account to run the task as.")
  runAs?: CustomizationTaskExecutionAccount;

  @doc("ID of the task instance.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("The unique URI for retrieving the task logs.")
  @visibility(Lifecycle.Read)
  logUri?: string;

  @doc("Status of the task.")
  @visibility(Lifecycle.Read)
  status?: CustomizationTaskStatus;

  @doc("Start time of the task, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of the task, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;
}

@doc("The operation result of validating a list of customization tasks.")
@added(APIVersions.v2024_05_01_preview)
model CustomizationTaskListValidationOperationResult {
  ...OperationStatus;

  @doc("Outcome of validation.")
  result?: CustomizationTaskListValidationResult;
}

@doc("The result of validating a list of customization tasks.")
@added(APIVersions.v2024_05_01_preview)
model CustomizationTaskListValidationResult {
  @doc("Outcome of validation.")
  validationResult: CustomizationTaskListValidationStatus;

  @doc("List of validation errors. Absent if no errors.")
  errors?: CustomizationTaskListValidationError[];
}

@doc("All of the validation errors for a customization task.")
@added(APIVersions.v2024_05_01_preview)
model CustomizationTaskListValidationError {
  @doc("The customization task that the error is about.")
  target: CustomizationTask;

  @doc("List of validation errors for the task.")
  details: Azure.Core.Foundations.Error[];
}

@doc("Represents a list of tasks to apply to a Dev Box.")
@resource("customizationGroups")
@parentResource(DevBox)
@added(APIVersions.v2024_05_01_preview)
model CustomizationGroup {
  @doc("""
    Tasks to apply. Note by default tasks are excluded from the response when
    listing customization groups. To include them, use the `include=tasks` query
    parameter.
    """)
  tasks?: CustomizationTask[];

  @doc("The unique URI of the customization group.")
  @visibility(Lifecycle.Read)
  uri?: string;

  @doc("Name of the customization group.")
  @key("customizationGroupName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("Status of the customization group.")
  @visibility(Lifecycle.Read)
  status?: CustomizationGroupStatus;

  @doc("Start time of the customization group, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of the customization group, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;
}

@added(APIVersions.v2024_09_01_preview)
@doc("A DevBox snapshot")
@resource("snapshots")
@parentResource(DevBox)
model DevBoxSnapshot {
  @key("snapshotId")
  @doc("The id of the snapshot. Should be treated as opaque string.")
  @visibility(Lifecycle.Read)
  snapshotId: string;

  @doc("The datetime that the snapshot was created, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  createdTime: utcDateTime;

  @doc("The datetime when the snapshot expires, will only be shown for a manual snapshot, in RFC3339 format.")
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2024_10_01_preview)
  expirationTime?: utcDateTime;

  @doc("The type of the snapshot indicates whether it is manual or automatic.")
  @visibility(Lifecycle.Read)
  @added(APIVersions.v2024_10_01_preview)
  snapshotType: SnapshotType;
}

@doc("A Dev Box addon.")
@resource("addons")
@parentResource(DevBox)
@discriminator("kind")
@added(APIVersions.v2025_04_01_preview)
model DevBoxAddOn {
  @key("addOnName")
  @doc("Name of the dev box addon.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The type of the Dev Box addon.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DevBoxAddOnKind;

  @doc("""
    The current action state of the Dev Box addon. This state is based on previous
    action performed by user.
    """)
  @visibility(Lifecycle.Read)
  actionState?: string;

  @doc("Provisioning state of this addon.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Creation, deletion or action error details. Populated only for error states.")
  @visibility(Lifecycle.Read)
  error?: Azure.Core.Foundations.Error;
}

@doc("The kind of Dev Box addon.")
@added(APIVersions.v2025_04_01_preview)
union DevBoxAddOnKind {
  @doc("The Dev Box Tunnel addon.")
  DevBoxTunnel: "DevBoxTunnel",

  string,
}

@doc("The Dev Box Tunnel addon.")
@added(APIVersions.v2025_04_01_preview)
model DevBoxTunnel extends DevBoxAddOn {
  @doc("The kind of Dev Box addon.")
  kind: DevBoxAddOnKind.DevBoxTunnel;

  @doc("The tunnel status.")
  @visibility(Lifecycle.Read)
  status: DevBoxTunnelStatus;

  @doc("The code tunnel name.")
  @visibility(Lifecycle.Read)
  codeTunnelName: string;

  @doc("The code tunnel's url.")
  @visibility(Lifecycle.Read)
  codeTunnelUrl: url;

  @doc("""
    The hosting resource name, either a DevBox or HyperV.
    Leaving it empty or `Default` if it's for DevBox.
    """)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  hostingResourceName?: string;
}

@doc("The detailed status of Dev Box Tunnel addon.")
@added(APIVersions.v2025_04_01_preview)
union DevBoxTunnelStatus {
  @doc("The tunnel is active and can be connected.")
  Enabled: "Enabled",

  @doc("The tunnel is inactive and can't be connected.")
  Disabled: "Disabled",

  @doc("The tunnel is suspended due to hibernation or other reasons.")
  Suspended: "Suspended",

  string,
}
