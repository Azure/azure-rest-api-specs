import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";
import "../client.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

@doc("The operating system type.")
@projectedName("csharp", "DevBoxOSType")
@projectedName("java", "DevBoxOsType")
@projectedName("python", "OSType")
union OsType {
  @doc("The Windows operating system.") Windows: "Windows",
  string,
}

@doc("Indicates whether hibernate is supported and enabled, disabled, or unsupported by the operating system. Unknown hibernate support is represented as null.")
union HibernateSupport {
  @doc("Hibernate is enabled.") Enabled: "Enabled",
  @doc("Hibernate is not enabled.") Disabled: "Disabled",
  @doc("Hibernate is not supported by the operating system.") OsUnsupported: "OsUnsupported",
  string,
}

@doc("Indicates whether owners of Dev Boxes in a pool are local administrators on the Dev Boxes.")
@projectedName("csharp", "LocalAdministratorStatus")
@projectedName("java", "LocalAdministratorStatus")
@projectedName("python", "LocalAdministratorStatus")
union LocalAdminStatus {
  @doc("Owners of Dev Boxes in the pool are local administrators on the Dev Boxes.")
  Enabled: "Enabled",

  @doc("Owners of Dev Boxes in the pool are not local administrators on the Dev Boxes.")
  Disabled: "Disabled",
  string,
}

@doc("Indicates the provisioning state of the Dev Box.")
union DevBoxProvisioningState {
  @doc("Dev Box was successfully provisioned") Succeeded: "Succeeded",
  @doc("Dev Box failed to provision") Failed: "Failed",
  @doc("Dev Box provision was canceled") Canceled: "Canceled",
  @doc("Dev Box is being created") Creating: "Creating",
  @doc("Dev Box is being deleted") Deleting: "Deleting",
  @doc("Dev Box is updating") Updating: "Updating",
  @doc("Dev Box is starting") Starting: "Starting",
  @doc("Dev Box is stopping") Stopping: "Stopping",
  @doc("Dev Box is provisioning") Provisioning: "Provisioning",
  @doc("Dev Box was provisioned with warning") ProvisionedWithWarning : "ProvisionedWithWarning",
  @doc("Dev Box is in grace period") InGracePeriod: "InGracePeriod" ,
  @doc("Dev Box is not provisioned") NotProvisioned: "NotProvisioned",
  string,
}

@doc("Indicates the Dev Box compute.")
union SkuName {
  @doc("Intel, 8 vCPU, 32 GB RAM, 256 GB Storage")
  general_i_8c32gb256ssd_v2: "general_i_8c32gb256ssd_v2",

  @doc("Intel, 8 vCPU, 32 GB RAM, 512 GB Storage")
  general_i_8c32gb512ssd_v2: "general_i_8c32gb512ssd_v2",

  @doc("Intel, 8 vCPU, 32 GB RAM, 1024 GB Storage")
  general_i_8c32gb1024ssd_v2: "general_i_8c32gb1024ssd_v2",

  @doc("Intel, 8 vCPU, 32 GB RAM, 2048 GB Storage")
  general_i_8c32gb2048ssd_v2: "general_i_8c32gb2048ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 256 GB Storage")
  general_i_16c64gb256ssd_v2: "general_i_16c64gb256ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 512 GB Storage")
  general_i_16c64gb512ssd_v2: "general_i_16c64gb512ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 1024 GB Storage")
  general_i_16c64gb1024ssd_v2: "general_i_16c64gb1024ssd_v2",

  @doc("Intel, 16 vCPU, 64 GB RAM, 2048 GB Storage")
  general_i_16c64gb2048ssd_v2: "general_i_16c64gb2048ssd_v2",

  @doc("Intel, 32 vCPU, 128 GB RAM, 512 GB Storage")
  general_i_32c128gb512ssd_v2: "general_i_32c128gb512ssd_v2",

  @doc("Intel, 32 vCPU, 128 GB RAM, 1024 GB Storage")
  general_i_32c128gb1024ssd_v2: "general_i_32c128gb1024ssd_v2",

  @doc("Intel, 32 vCPU, 128 GB RAM, 2048 GB Storage")
  general_i_32c128gb2048ssd_v2: "general_i_32c128gb2048ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 256 GB Storage")
  general_a_8c32gb256ssd_v2: "general_a_8c32gb256ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 512 GB Storage")
  general_a_8c32gb512ssd_v2: "general_a_8c32gb512ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 1024 GB Storage")
  general_a_8c32gb1024ssd_v2: "general_a_8c32gb1024ssd_v2",

  @doc("AMD, 8 vCPU, 32 GB RAM, 2048 GB Storage")
  general_a_8c32gb2048ssd_v2: "general_a_8c32gb2048ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 256 GB Storage")
  general_a_16c64gb256ssd_v2: "general_a_16c64gb256ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 512 GB Storage")
  general_a_16c64gb512ssd_v2: "general_a_16c64gb512ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 1024 GB Storage")
  general_a_16c64gb1024ssd_v2: "general_a_16c64gb1024ssd_v2",

  @doc("AMD, 16 vCPU, 64 GB RAM, 2048 GB Storage")
  general_a_16c64gb2048ssd_v2: "general_a_16c64gb2048ssd_v2",

  @doc("AMD, 32 vCPU, 128 GB RAM, 512 GB Storage")
  general_a_32c128gb512ssd_v2: "general_a_32c128gb512ssd_v2",

  @doc("AMD, 32 vCPU, 128 GB RAM, 1024 GB Storage")
  general_a_32c128gb1024ssd_v2: "general_a_32c128gb1024ssd_v2",

  @doc("AMD, 32 vCPU, 128 GB RAM, 2048 GB Storage")
  general_a_32c128gb2048ssd_v2: "general_a_32c128gb2048ssd_v2",
  string,
}

@doc("Indicates whether the feature to stop the devbox on disconnect once the grace period has lapsed is enabled.")
@projectedName("csharp", "StopOnDisconnectStatus")
@projectedName("java", "StopOnDisconnectStatus")
@projectedName("python", "StopOnDisconnectStatus")
union StopOnDisconnectEnableStatus {
  @doc("Stop on disconnect is enabled on the Dev Box.") Enabled: "Enabled",
  @doc("Stop on disconnect is not enabled on the Dev Box.") Disabled: "Disabled",
  string,
}

@doc("Pool status indicating whether a pool is available to create Dev Boxes.")
union PoolHealthStatus {
  @doc("The pool health status is not known.") Unknown: "Unknown",
  @doc("The pool health status waiting for health checks to run.") Pending: "Pending",
  @doc("The pool health status is healthy.") Healthy: "Healthy",
  @doc("The pool health status has one or more warnings.") Warning: "Warning",
  @doc("The pool health status is not healthy.") Unhealthy: "Unhealthy",
  string,
}

@doc("The supported types for a scheduled task.")
union ScheduledType {
  @doc("The scheduled task will stop impacted Dev Boxes.") StopDevBox: "StopDevBox",
  string,
}

@doc("The frequency of task execution.")
@projectedName("csharp", "ScheduleFrequency")
@projectedName("java", "ScheduleFrequency")
union ScheduledFrequency {
  @doc("The scheduled task will run every day.") Daily: "Daily",
  string,
}

@doc("The power states of a Dev Box.")
union PowerState {
  @doc("The Dev Box power state is not known.") Unknown: "Unknown",
  @doc("The Dev Box is running.") Running: "Running",
  @doc("The Dev Box is deallocated.") Deallocated: "Deallocated",
  @doc("The Dev Box is powered off.") PoweredOff: "PoweredOff",
  @doc("The Dev Box is hibernated.") Hibernated: "Hibernated",
  string,
}

@doc("The type of action which will take place on a Dev Box.")
union DevBoxActionType {
  @doc("The action will stop the Dev Box.") Stop: "Stop",
  string,
}

@doc("The result of the delay operation on this action.")
@projectedName("csharp", "DevBoxActionDelayStatus")
@projectedName("java", "DevBoxActionDelayStatus")
union DevBoxActionDelayResultStatus {
  @doc("The delay operation succeeded.") Succeeded: "Succeeded",
  @doc("The delay operation failed.") Failed: "Failed",
  string,
}

@doc("A pool of Dev Boxes.")
@resource("pools")
@parentResource(Project)
@projectedName("csharp", "DevBoxPool")
@projectedName("java", "DevBoxPool")
model Pool {
  @key("poolName")
  @visibility("read")
  @doc("Pool name")
  name: string;

  @doc("Azure region where Dev Boxes in the pool are located")
  location: string;

  @doc("The operating system type of Dev Boxes in this pool")
  @projectedName("csharp", "OSType")
  osType?: OsType;

  @doc("Hardware settings for the Dev Boxes created in this pool")
  hardwareProfile?: HardwareProfile;

  @doc("Indicates whether hibernate is enabled/disabled or unknown.")
  hibernateSupport?: HibernateSupport;

  @doc("Storage settings for Dev Box created in this pool")
  storageProfile?: StorageProfile;

  @doc("Image settings for Dev Boxes create in this pool")
  imageReference?: ImageReference;

  @doc("""
Indicates whether owners of Dev Boxes in this pool are local administrators on
the Dev Boxes.
""")
  @projectedName("csharp", "LocalAdministratorStatus")
  @projectedName("java", "LocalAdministratorStatus")
  localAdministrator?: LocalAdminStatus;

  @doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
  stopOnDisconnect?: StopOnDisconnectConfiguration;

  @doc("""
Overall health status of the Pool. Indicates whether or not the Pool is
available to create Dev Boxes.
""")
  healthStatus: PoolHealthStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@doc("Hardware specifications for the Dev Box.")
@projectedName("csharp", "DevBoxHardwareProfile")
@projectedName("java", "DevBoxHardwareProfile")
model HardwareProfile {
  @doc("The name of the SKU")
  @visibility("read")
  skuName?: SkuName;

  @doc("The number of vCPUs available for the Dev Box.")
  @visibility("read")
  @projectedName("java", "vcpus")
  @projectedName("python", "vcpus")
  vCPUs?: int32;

  @doc("The amount of memory available for the Dev Box.")
  @visibility("read")
  @projectedName("python", "memoryGb")
  memoryGB?: int32;
}

@doc("Storage settings for the Dev Box's disks")
@projectedName("csharp", "DevBoxStorageProfile")
@projectedName("java", "DevBoxStorageProfile")
model StorageProfile {
  @doc("Settings for the operating system disk.")
  @projectedName("csharp", "OSDisk")
  osDisk?: OsDisk;
}

@doc("Settings for the operating system disk.")
@projectedName("csharp", "OSDisk")
@projectedName("python", "OSDisk")
@projectedName("javascript", "OSDisk")
model OsDisk {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The size of the OS Disk in gigabytes.")
  @visibility("read")
  @projectedName("python", "diskSizeGb")
  diskSizeGB?: int32;
}

@doc("Specifies information about the image used")
@projectedName("csharp", "DevBoxImageReference")
@projectedName("java", "DevBoxImageReference")
model ImageReference {
  @doc("The name of the image used.")
  @visibility("read")
  name?: string;

  @doc("The version of the image.")
  @visibility("read")
  version?: string;

  @doc("The operating system of the image.")
  @visibility("read")
  operatingSystem?: string;

  @doc("The operating system build number of the image.")
  @visibility("read")
  @projectedName("csharp", "OSBuildNumber")
  osBuildNumber?: string;

  @doc("The datetime that the backing image version was published.")
  @visibility("read")
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

@doc("A Schedule to execute action.")
@resource("schedules")
@parentResource(Pool)
@projectedName("csharp", "DevBoxSchedule")
@projectedName("java", "DevBoxSchedule")
model Schedule {
  @key("scheduleName")
  @visibility("read")
  @doc("Display name for the Schedule")
  name: string;

  @doc("Supported type this scheduled task represents.")
  @projectedName("csharp", "scheduledType")
  @projectedName("java", "scheduledType")
  type: ScheduledType;

  @doc("The frequency of this scheduled task.")
  frequency: ScheduledFrequency;

  @doc("The target time to trigger the action. The format is HH:MM.")
  //no build in time type matches HH:MM time format
  time: string;

  @doc("The IANA timezone id at which the schedule should execute.")
  timeZone: string;
}

@doc("The Dev Box list result")
model DevBoxListResult is Azure.Core.Page<DevBox>;

@doc("A Dev Box")
@resource("devboxes")
@parentResource(User)
model DevBox {
  @key("devBoxName")
  @doc("Display name for the Dev Box")
  @visibility("read")
  name: string;

  @doc("Name of the project this Dev Box belongs to")
  @visibility("read")
  projectName?: string;

  @doc("The name of the Dev Box pool this machine belongs to.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read", "create")
  poolName: string;

  @doc("Indicates whether hibernate is enabled/disabled or unknown.")
  @visibility("read")
  hibernateSupport?: HibernateSupport;

  @doc("The current provisioning state of the Dev Box.")
  @visibility("read")
  provisioningState?: DevBoxProvisioningState;

  @doc("""
The current action state of the Dev Box. This is state is based on previous
action performed by user.
""")
  @visibility("read")
  actionState?: string;

  @doc("The current power state of the Dev Box.")
  @visibility("read")
  powerState?: PowerState;

  @doc("""
A unique identifier for the Dev Box. This is a GUID-formatted string (e.g.
00000000-0000-0000-0000-000000000000).
""")
  @visibility("read")
  uniqueId?: Azure.Core.uuid;

  @doc("Provisioning or action error details. Populated only for error states.")
  @visibility("read")
  error?: Azure.Core.Foundations.Error;

  @doc("""
Azure region where this Dev Box is located. This will be the same region as the
Virtual Network it is attached to.
""")
  @visibility("read")
  location?: string;

  @doc("The operating system type of this Dev Box.")
  @visibility("read")
  @projectedName("csharp", "OSType")
  osType?: OsType;

  @doc("The AAD object id of the user this Dev Box is assigned to.")
  @visibility("read")
  @projectedName("csharp", "userId")
  @projectedName("java", "userId")
  user?: Azure.Core.uuid;

  @doc("Information about the Dev Box's hardware resources")
  @visibility("read")
  hardwareProfile?: HardwareProfile;

  @doc("Storage settings for this Dev Box")
  @visibility("read")
  storageProfile?: StorageProfile;

  @doc("Information about the image used for this Dev Box")
  @visibility("read")
  imageReference?: ImageReference;

  @doc("Creation time of this Dev Box")
  @visibility("read")
  createdTime?: utcDateTime;

  @doc("Indicates whether the owner of the Dev Box is a local administrator.")
  @visibility("read", "create")
  @projectedName("csharp", "LocalAdministratorStatus")
  @projectedName("java", "LocalAdministratorStatus")
  localAdministrator?: LocalAdminStatus;
}

@doc("Provides remote connection information for a Dev Box.")
model RemoteConnection {
  @doc("URL to open a browser based RDP session.")
  @projectedName("csharp", "webUri")
  webUrl?: url;

  @doc("Link to open a Remote Desktop session.")
  @projectedName("csharp", "rdpConnectionUri")
  rdpConnectionUrl?: url;
}

@doc("An action which will take place on a Dev Box.")
@resource("actions")
@parentResource(DevBox)
model DevBoxAction {
  @key("actionName")
  @visibility("read")
  @doc("The name of the action.")
  name: string;

  @doc("The action that will be taken.")
  actionType: DevBoxActionType;

  @doc("The id of the resource which triggered this action")
  sourceId: string;

  @doc("The earliest time that the action could occur (UTC).")
  suspendedUntil?: utcDateTime;

  @doc("Details about the next run of this action.")
  @projectedName("csharp", "nextAction")
  @projectedName("java", "nextAction")
  next?: DevBoxNextAction;
}

@doc("Details about the next run of an action.")
model DevBoxNextAction {
  @doc("The time the action will be triggered (UTC).")
  scheduledTime: utcDateTime;
}

@doc("The actions list result")
model DevBoxActionsDelayMultipleResult
  is Azure.Core.Page<DevBoxActionDelayResult>;

@doc("The action delay result")
model DevBoxActionDelayResult {
  @doc("The name of the action.")
  @projectedName("csharp", "actionName")
  name: string;

  @doc("The result of the delay operation on this action.")
  result: DevBoxActionDelayResultStatus;

  @doc("The delayed action")
  action?: DevBoxAction;

  @doc("Information about the error that occurred. Only populated on error.")
  error?: Azure.Core.Foundations.Error;
}
