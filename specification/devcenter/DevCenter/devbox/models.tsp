import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "../shared/models.tsp";

using TypeSpec.Versioning;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenter;

enum OsType {
  @doc("The Windows operating system.") Windows,
}

enum HibernateSupport {
  @doc("Hibernate is enabled.") Enabled,
  @doc("Hibernate is not enabled.") Disabled,
  @doc("Hibernate is not supported by the operating system.") OsUnsupported,
}

enum LocalAdminStatus {
  @doc("Owners of Dev Boxes in the pool are local administrators on the Dev Boxes.")
  Enabled,
  @doc("Owners of Dev Boxes in the pool are not local administrators on the Dev Boxes.")
  Disabled,
}

enum StopOnDisconnectEnableStatus {
  @doc("Stop on disconnect is enabled on the Dev Box.") Enabled,
  @doc("Stop on disconnect is not enabled on the Dev Box.") Disabled,
}

enum PoolHealthStatus {
  @doc("The pool health status is not known.") Unknown,
  @doc("The pool health status waiting for health checks to run.") Pending,
  @doc("The pool health status is healthy.") Healthy,
  @doc("The pool health status has one or more warnings.") Warning,
  @doc("The pool health status is not healthy.") Unhealthy,
}

enum ScheduledType {
  @doc("The scheduled task will stop impacted Dev Boxes.") StopDevBox,
}

enum ScheduledFrequency {
  @doc("The scheduled task will run every day.") Daily,
}

enum PowerState {
  @doc("The Dev Box power state is not known.") Unknown,
  @doc("The Dev Box is running.") Running,
  @doc("The Dev Box is deallocated.") Deallocated,
  @doc("The Dev Box is powered off.") PoweredOff,
  @doc("The Dev Box is hibernated.") Hibernated,
}

@added(APIVersions.v2023_09_01_preview)
enum DevBoxOperationKind {
  @doc("The operation represents a Dev Box start.") Start,
  @doc("The operation represents a Dev Box stop.") Stop,
  @doc("The operation represents a Dev Box restart.") Restart,
  @doc("The operation represents a Dev Box repair.") Repair,
}

@added(APIVersions.v2023_09_01_preview)
enum DevBoxOperationStatus {
  @doc("The operation has not started.") NotStarted,
  @doc("The operation is running.") Running,
  @doc("The operation succeeded.") Succeeded,
  @doc("The operation was canceled.") Canceled,
  @doc("The operation failed.") Failed,
}

enum DevBoxActionType {
  @doc("The action will stop the Dev Box.") Stop,
}

enum DevBoxActionDelayResultStatus {
  @doc("The delay operation succeeded.") Succeeded,
  @doc("The delay operation failed.") Failed,
}

@doc("The Pool list result")
model PoolListResult is Azure.Core.Page<Pool>;

@doc("Project user")
@resource("users")
@parentResource(Project)
model User {
  @key("userName")
  @visibility("read")
  @doc("User name")
  name: string;
}

@doc("A pool of Dev Boxes.")
@resource("pools")
@parentResource(Project)
model Pool {
  @key("poolName")
  @visibility("read")
  @doc("Pool name")
  name: string;

  @doc("Azure region where Dev Boxes in the pool are located")
  location: string;

  @doc("The operating system type of Dev Boxes in this pool")
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
  localAdministrator?: LocalAdminStatus;

  @doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
  stopOnDisconnect?: StopOnDisconnectConfiguration;

  @doc("""
Overall health status of the Pool. Indicates whether or not the Pool is
available to create Dev Boxes.
""")
  healthStatus: PoolHealthStatus;
}

@doc("Hardware specifications for the Dev Box.")
model HardwareProfile {
  @doc("The name of the SKU")
  @visibility("read")
  skuName?: string;

  @doc("The number of vCPUs available for the Dev Box.")
  @visibility("read")
  vCPUs?: int32;

  @doc("The amount of memory available for the Dev Box.")
  @visibility("read")
  memoryGB?: int32;
}

@doc("Storage settings for the Dev Box's disks")
model StorageProfile {
  @doc("Settings for the operating system disk.")
  osDisk?: OSDisk;
}

@doc("Settings for the operating system disk.")
model OSDisk {
  @doc("The size of the OS Disk in gigabytes.")
  @visibility("read")
  diskSizeGB?: int32;
}

@doc("Specifies information about the image used")
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
  osBuildNumber?: string;

  @doc("The datetime that the backing image version was published.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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

@doc("The Schedule list result")
model ScheduleListResult is Azure.Core.Page<Schedule>;

@doc("A Schedule to execute action.")
@resource("schedules")
@parentResource(Pool)
model Schedule {
  @key("scheduleName")
  @visibility("read")
  @doc("Display name for the Schedule")
  name: string;

  @doc("Supported type this scheduled task represents.")
  type: ScheduledType;

  @doc("The frequency of this scheduled task.")
  frequency: ScheduledFrequency;

  @doc("The target time to trigger the action. The format is HH:MM.")
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
  name: string; // TODO: (devBoxName) Please double check that this is the correct type for your scenario.

  @doc("Name of the project this Dev Box belongs to")
  @visibility("read")
  projectName?: string;

  @doc("The name of the Dev Box pool this machine belongs to.")
  poolName: string;

  @doc("Indicates whether hibernate is enabled/disabled or unknown.")
  @visibility("read")
  hibernateSupport?: HibernateSupport;

  @doc("The current provisioning state of the Dev Box.")
  @visibility("read")
  provisioningState?: string;

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
  uniqueId?: string;

  @doc("Provisioning or action error details. Populated only for error states.")
  @visibility("read")
  error?: CloudErrorBody;

  @doc("""
Azure region where this Dev Box is located. This will be the same region as the
Virtual Network it is attached to.
""")
  @visibility("read")
  location?: string;

  @doc("The operating system type of this Dev Box.")
  @visibility("read")
  osType?: OsType;

  @doc("The AAD object id of the user this Dev Box is assigned to.")
  @visibility("read")
  user?: string;

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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Indicates whether the owner of the Dev Box is a local administrator.")
  localAdministrator?: LocalAdminStatus;
}

@doc("Provides remote connection information for a Dev Box.")
model RemoteConnection {
  @doc("URL to open a browser based RDP session.")
  webUrl?: string;

  @doc("Link to open a Remote Desktop session.")
  rdpConnectionUrl?: string;
}

@doc("The actions list result")
model DevBoxActionsListResult is Azure.Core.Page<DevBoxAction>;

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
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  suspendedUntil?: utcDateTime;

  @doc("Details about the next run of this action.")
  next?: DevBoxNextAction;
}

@doc("Details about the next run of an action.")
model DevBoxNextAction {
  @doc("The time the action will be triggered (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledTime: utcDateTime;
}

@doc("The actions list result")
model DevBoxActionsDelayMultipleResult
  is Azure.Core.Page<DevBoxActionDelayResult>;

@doc("The action delay result")
model DevBoxActionDelayResult {
  @doc("The name of the action.")
  name: string;

  @doc("The result of the delay operation on this action.")
  result: DevBoxActionDelayResultStatus;

  @doc("The delayed action")
  action?: DevBoxAction;

  @doc("Information about the error that occurred. Only populated on error.")
  error?: CloudErrorBody;
}

@added(APIVersions.v2023_09_01_preview)
@doc("The action results list result.")
model DevBoxOperationListResult is Azure.Core.Page<DevBoxOperation>;

@added(APIVersions.v2023_09_01_preview)
@doc("Information about an operation on a Dev Box.")
@discriminator("kind")
model DevBoxOperation {
  @doc("The kind of operation that occurred.")
  kind: DevBoxOperationKind;

  @doc("The unique URI for the environment operation.")
  uri: string;

  @doc("Unique identifier for the environment operation.")
  operationId: string;

  @doc("The operation status.")
  status: DevBoxOperationStatus;

  @doc("The object ID of the actor which initiated the operation.")
  createdByObjectId?: string;

  @doc("The time the operation started.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("The time the operation finished.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Provisioning or operation error details. Populated only for error states.")
  error?: CloudErrorBody;
}
