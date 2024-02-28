import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace DevCenterService;

@doc("Indicates whether operation status is running, completed, canceled or failed.")
@lroStatus
enum OperationStatusValue {
  @doc("Operation is in progress")
  Running,

  @doc("Operation is completed with success")
  @lroSucceeded
  Completed,

  @doc("Operation was canceled")
  Canceled,

  @doc("Operation failed")
  Failed,
}

@doc("The current status of an async operation")
@resource("operationstatuses")
@parentResource(Project)
model OperationStatus {
  @doc("Fully qualified ID for the operation status.")
  @key("operationId")
  @visibility("read")
  id: string;

  @doc("The operation id name")
  name?: string;

  @doc("Provisioning state of the resource.")
  status: OperationStatusValue;

  @doc("The id of the resource.")
  resourceId?: string;

  @doc("The start time of the operation")
  startTime?: utcDateTime;

  @doc("The end time of the operation")
  endTime?: utcDateTime;

  @doc("Percent of the operation that is complete")
  @minValue(0.0)
  @maxValue(100.0)
  percentComplete?: float64;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "there is no build in type to describe object"
  @doc("Custom operation properties, populated only for a successful operation.")
  properties?: unknown;

  @doc("Operation Error message")
  error?: Azure.Core.Foundations.Error;
}

@doc("Project details.")
@resource("projects")
model Project {
  @key("projectName")
  @doc("Name of the project")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Description of the project.")
  description?: string;

  @doc("""
When specified, indicates the maximum number of Dev Boxes a single user can
create across all pools in the project.
""")
  @minValue(0)
  maxDevBoxesPerUser?: int32;
}

@doc("Project user")
@resource("users")
@parentResource(Project)
model User {
  @key("userId")
  @doc("The AAD object id of the user. If value is 'me', the identity is taken from the authentication context")
  @minLength(2)
  @maxLength(36)
  @pattern("^[a-zA-Z0-9]{8}-([a-zA-Z0-9]{4}-){3}[a-zA-Z0-9]{12}$|^me$")
  @visibility("read")
  userId: string;
}

@doc("The operating system type.")
enum OsType {
  @doc("The Windows operating system.") Windows,
}

@doc("Indicates whether hibernate is supported and enabled, disabled, or unsupported by the operating system. Unknown hibernate support is represented as null.")
enum HibernateSupport {
  @doc("Hibernate is enabled.") Enabled,
  @doc("Hibernate is not enabled.") Disabled,
  @doc("Hibernate is not supported by the operating system.") OsUnsupported,
}

@doc("Indicates whether owners of Dev Boxes in a pool are local administrators on the Dev Boxes.")
enum LocalAdminStatus {
  @doc("Owners of Dev Boxes in the pool are local administrators on the Dev Boxes.")
  Enabled,

  @doc("Owners of Dev Boxes in the pool are not local administrators on the Dev Boxes.")
  Disabled,
}

@doc("Indicates the provisioning state of the Dev Box.")
enum DevBoxProvisioningState {
  @doc("Dev Box was successfully provisioned") Succeeded,
  @doc("Dev Box failed to provision") Failed,
  @doc("Dev Box provision was canceled") Canceled,
  @doc("Dev Box is being created") Creating,
  @doc("Dev Box is being deleted") Deleting,
  @doc("Dev Box is updating") Updating,
  @doc("Dev Box is starting") Starting,
  @doc("Dev Box is stopping") Stopping,
  @doc("Dev Box is provisioning") Provisioning,
  @doc("Dev Box was provisioned with warning") ProvisionedWithWarning,
  @doc("Dev Box is in grace period") InGracePeriod,
  @doc("Dev Box is not provisioned") NotProvisioned,
}

@doc("Indicates the Dev Box compute.")
enum SkuName {
  @doc("Intel, 8 vCPU, 32 GB RAM, 256 GB Storage")
  general_i_8c32gb256ssd_v2,

  @doc("Intel, 8 vCPU, 32 GB RAM, 512 GB Storage")
  general_i_8c32gb512ssd_v2,

  @doc("Intel, 8 vCPU, 32 GB RAM, 1024 GB Storage")
  general_i_8c32gb1024ssd_v2,

  @doc("Intel, 8 vCPU, 32 GB RAM, 2048 GB Storage")
  general_i_8c32gb2048ssd_v2,

  @doc("Intel, 16 vCPU, 64 GB RAM, 256 GB Storage")
  general_i_16c64gb256ssd_v2,

  @doc("Intel, 16 vCPU, 64 GB RAM, 512 GB Storage")
  general_i_16c64gb512ssd_v2,

  @doc("Intel, 16 vCPU, 64 GB RAM, 1024 GB Storage")
  general_i_16c64gb1024ssd_v2,

  @doc("Intel, 16 vCPU, 64 GB RAM, 2048 GB Storage")
  general_i_16c64gb2048ssd_v2,

  @doc("Intel, 32 vCPU, 128 GB RAM, 512 GB Storage")
  general_i_32c128gb512ssd_v2,

  @doc("Intel, 32 vCPU, 128 GB RAM, 1024 GB Storage")
  general_i_32c128gb1024ssd_v2,

  @doc("Intel, 32 vCPU, 128 GB RAM, 2048 GB Storage")
  general_i_32c128gb2048ssd_v2,

  @doc("AMD, 8 vCPU, 32 GB RAM, 256 GB Storage")
  general_a_8c32gb256ssd_v2,

  @doc("AMD, 8 vCPU, 32 GB RAM, 512 GB Storage")
  general_a_8c32gb512ssd_v2,

  @doc("AMD, 8 vCPU, 32 GB RAM, 1024 GB Storage")
  general_a_8c32gb1024ssd_v2,

  @doc("AMD, 8 vCPU, 32 GB RAM, 2048 GB Storage")
  general_a_8c32gb2048ssd_v2,

  @doc("AMD, 16 vCPU, 64 GB RAM, 256 GB Storage")
  general_a_16c64gb256ssd_v2,

  @doc("AMD, 16 vCPU, 64 GB RAM, 512 GB Storage")
  general_a_16c64gb512ssd_v2,

  @doc("AMD, 16 vCPU, 64 GB RAM, 1024 GB Storage")
  general_a_16c64gb1024ssd_v2,

  @doc("AMD, 16 vCPU, 64 GB RAM, 2048 GB Storage")
  general_a_16c64gb2048ssd_v2,

  @doc("AMD, 32 vCPU, 128 GB RAM, 512 GB Storage")
  general_a_32c128gb512ssd_v2,

  @doc("AMD, 32 vCPU, 128 GB RAM, 1024 GB Storage")
  general_a_32c128gb1024ssd_v2,

  @doc("AMD, 32 vCPU, 128 GB RAM, 2048 GB Storage")
  general_a_32c128gb2048ssd_v2,
}

@doc("Indicates whether the feature to stop the devbox on disconnect once the grace period has lapsed is enabled.")
enum StopOnDisconnectEnableStatus {
  @doc("Stop on disconnect is enabled on the Dev Box.") Enabled,
  @doc("Stop on disconnect is not enabled on the Dev Box.") Disabled,
}

@doc("Pool status indicating whether a pool is available to create Dev Boxes.")
enum PoolHealthStatus {
  @doc("The pool health status is not known.") Unknown,
  @doc("The pool health status waiting for health checks to run.") Pending,
  @doc("The pool health status is healthy.") Healthy,
  @doc("The pool health status has one or more warnings.") Warning,
  @doc("The pool health status is not healthy.") Unhealthy,
}

@doc("The supported types for a scheduled task.")
enum ScheduledType {
  @doc("The scheduled task will stop impacted Dev Boxes.") StopDevBox,
}

@doc("The frequency of task execution.")
enum ScheduledFrequency {
  @doc("The scheduled task will run every day.") Daily,
}

@doc("The power states of a Dev Box.")
enum PowerState {
  @doc("The Dev Box power state is not known.") Unknown,
  @doc("The Dev Box is running.") Running,
  @doc("The Dev Box is deallocated.") Deallocated,
  @doc("The Dev Box is powered off.") PoweredOff,
  @doc("The Dev Box is hibernated.") Hibernated,
}

@doc("The type of action which will take place on a Dev Box.")
enum DevBoxActionType {
  @doc("The action will stop the Dev Box.") Stop,
}

@doc("The result of the delay operation on this action.")
enum DevBoxActionDelayResultStatus {
  @doc("The delay operation succeeded.") Succeeded,
  @doc("The delay operation failed.") Failed,
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
  skuName?: SkuName;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The number of vCPUs available for the Dev Box.")
  @visibility("read")
  vCPUs?: int32;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The amount of memory available for the Dev Box.")
  @visibility("read")
  memoryGB?: int32;
}

@doc("Storage settings for the Dev Box's disks")
model StorageProfile {
  @doc("Settings for the operating system disk.")
  osDisk?: OsDisk;
}

@doc("Settings for the operating system disk.")
model OsDisk {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
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
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
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
  powerState?: PowerState = PowerState.Unknown;

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
  osType?: OsType;

  @doc("The AAD object id of the user this Dev Box is assigned to.")
  @visibility("read")
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
  localAdministrator?: LocalAdminStatus;
}

@doc("Provides remote connection information for a Dev Box.")
model RemoteConnection {
  @doc("URL to open a browser based RDP session.")
  webUrl?: url;

  @doc("Link to open a Remote Desktop session.")
  rdpConnectionUrl?: url;
}

@doc("An action which will take place on a Dev Box.")
@resource("actions")
@parentResource(DevBox)
model DevBoxAction {
  @key("actionName")
  @doc("The name of the action.")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("The action that will be taken.")
  actionType: DevBoxActionType;

  @doc("The id of the resource which triggered this action")
  sourceId: string;

  @doc("The earliest time that the action could occur (UTC).")
  suspendedUntil?: utcDateTime;

  @doc("Details about the next run of this action.")
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
  name: string;

  @doc("The result of the delay operation on this action.")
  result: DevBoxActionDelayResultStatus;

  @doc("The delayed action")
  action?: DevBoxAction;

  @doc("Information about the error that occurred. Only populated on error.")
  error?: Azure.Core.Foundations.Error;
}

@doc("The type of data a parameter accepts.")
enum ParameterType {
  @doc("The parameter accepts an array of values.") array,
  @doc("The parameter accepts a boolean value.") boolean,
  @doc("The parameter accepts an integer value.") integer,
  @doc("The parameter accepts a number value.") number,
  @doc("The parameter accepts an object value.") object,
  @doc("The parameter accepts a string value.") string,
}

@doc("Indicates whether an environment type is enabled for use in a project.")
enum EnvironmentTypeEnableStatus {
  @doc("The environment type is enabled for use in the project.") Enabled,
  @doc("The environment type is not enabled for use in the project.") Disabled,
}

@doc("The provisioning state of the environment.")
enum EnvironmentProvisioningState {
  @doc("The environment was successfully provisioned.")
  Succeeded,

  @doc("The environment failed to provision.")
  Failed,

  @doc("The environment provisioning was canceled.")
  Canceled,

  @doc("The environment is creating.")
  Creating,

  @doc("The environment was accepted.")
  Accepted,

  @doc("The environment is deleting.")
  Deleting,

  @doc("The environment is updating.")
  Updating,

  @doc("The environment is preparing.")
  Preparing,

  @doc("The environment is running.")
  Running,

  @doc("The environment is Syncing.")
  Syncing,

  @doc("The environment is moving resources.")
  MovingResources,

  @doc("The environment has a transient failure.")
  TransientFailure,

  @doc("The environment storage provisioning failed.")
  StorageProvisioningFailed,
}

@doc("Results of the environment list operation.")
model EnvironmentListResult is Azure.Core.Page<Environment>;

@doc("Properties of an environment.")
@resource("environments")
@parentResource(User)
model Environment {
  ...EnvironmentUpdateProperties;

  @doc("Environment name.")
  @key("environmentName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Environment type.")
  @visibility("read", "create")
  environmentType: string;

  @doc("The AAD object id of the owner of this Environment.")
  @visibility("read")
  user?: Azure.Core.uuid;

  @doc("The provisioning state of the environment.")
  @visibility("read")
  provisioningState?: EnvironmentProvisioningState;

  @doc("The identifier of the resource group containing the environment's resources.")
  @visibility("read")
  resourceGroupId?: string;

  @doc("Name of the catalog.")
  @visibility("read", "create")
  catalogName: string;

  @doc("Name of the environment definition.")
  @visibility("read", "create")
  environmentDefinitionName: string;

  @doc("Provisioning error details. Populated only for error states.")
  @visibility("read")
  error?: Azure.Core.Foundations.Error;
}

@doc("""
Properties of an environment. These properties can be updated after the
resource has been created.
""")
model EnvironmentUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "there is no build in type to describe object"
  @doc("Parameters object for the environment.")
  parameters?: Record<unknown>;
}

@doc("A catalog.")
@resource("catalogs")
@parentResource(Project)
model Catalog {
  @doc("Name of the catalog.")
  @key("catalogName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;
}

@doc("Results of the environment definition list operation.")
model EnvironmentDefinitionListResult is Azure.Core.Page<EnvironmentDefinition>;

@doc("An environment definition.")
@resource("environmentDefinitions")
@parentResource(Catalog)
model EnvironmentDefinition {
  @doc("The ID of the environment definition.")
  id: string;

  @doc("Name of the environment definition.")
  @key("definitionName")
  @minLength(3)
  @maxLength(63)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_.]{2,62}$")
  @visibility("read")
  name: string;

  @doc("Name of the catalog.")
  catalogName: string;

  @doc("A short description of the environment definition.")
  description?: string;

  @doc("Input parameters passed to an environment.")
  parameters?: EnvironmentDefinitionParameter[];

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "there is no build in type to describe json"
  //using unkown here is better than string since it generates BinaryData in the SDK
  @doc("JSON schema defining the parameters object passed to an environment.")
  parametersSchema?: unknown;

  @doc("Path to the Environment Definition entrypoint file.")
  templatePath?: string;
}

@doc("Properties of an Environment Definition parameter")
model EnvironmentDefinitionParameter {
  @doc("Unique ID of the parameter")
  id: string;

  @doc("Display name of the parameter")
  name?: string;

  @doc("Description of the parameter")
  description?: string;

  @doc("Default value of the parameter")
  default?: string;

  @doc("""
A string of one of the basic JSON types (number, integer, array, object,
boolean, string)
""")
  type: ParameterType;

  @doc("""
Whether or not this parameter is read-only.  If true, default should have a
value.
""")
  readOnly?: boolean;

  @doc("Whether or not this parameter is required")
  required: boolean;

  @doc("An array of allowed values")
  @minItems(1)
  allowed?: string[];
}

@doc("Result of the environment type list operation.")
model EnvironmentTypeListResult is Azure.Core.Page<EnvironmentType>;

@doc("Properties of an environment type.")
model EnvironmentType {
  @doc("Name of the environment type")
  name: string;

  @doc("""
Id of a subscription or management group that the environment type will be
mapped to. The environment's resources will be deployed into this subscription
or management group.
""")
  deploymentTargetId: string;

  @doc("Indicates whether this environment type is enabled for use in this project.")
  status: EnvironmentTypeEnableStatus;
}
