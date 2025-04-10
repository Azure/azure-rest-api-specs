import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LabServices;

/**
 * The tier of the SKU.
 */
union LabServicesSkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium: "Premium",
}

/**
 * The localized name of the resource.
 */
union ScaleType {
  string,

  /**
   * The capacity is not adjustable in any way.
   */
  None: "None",

  /**
   * The user must manually scale this SKU in and out.
   */
  Manual: "Manual",

  /**
   * The user is permitted to scale this SKU in and out.
   */
  Automatic: "Automatic",
}

/**
 * The type of restriction.
 */
union RestrictionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Location: "Location",
}

/**
 * The reason for the restriction.
 */
union RestrictionReasonCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QuotaId: "QuotaId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * The unit details.
 */
union UsageUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Count: "Count",
}

/**
 * Resource provisioning state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
enum ProvisioningState {
  /**
   * Resource is in the process of being created.
   */
  Creating,

  /**
   * New property values are being applied to the resource.
   */
  Updating,

  /**
   * Resource is in the process of being deleted.
   */
  Deleting,

  /**
   * Resource is in healthy state after creation or update operation.
   */
  Succeeded,

  /**
   * Previous operation on the resource has failed leaving resource in unhealthy state.
   */
  Failed,

  /**
   * The resource is locked and changes are currently blocked. This could be due to maintenance or a scheduled operation. The state will go back to succeeded once the locking operation has finished.
   */
  Locked,
}

/**
 * The operating system type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OsType {
  Windows,
  Linux,
}

/**
 * Property enabled state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum EnableState {
  Enabled,
  Disabled,
}

/**
 * The operating system state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OsState {
  /**
   * Image does not contain any machine and user specific information.
   */
  Generalized,

  /**
   * Image contains machine and user specific information.
   */
  Specialized,
}

/**
 * A connection type for access labs and VMs (Public, Private or None).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ConnectionType {
  Public,
  Private,
  None,
}

/**
 * Defines whether to shut down VM on idle and the criteria for idle detection.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ShutdownOnIdleMode {
  /**
   * The VM won't be shut down when it is idle.
   */
  None,

  /**
   * The VM will be considered as idle when there is no keyboard or mouse input.
   */
  UserAbsence,

  /**
   * The VM will be considered as idle when user is absent and the resource (CPU and disk) consumption is low.
   */
  LowUsage,
}

/**
 * The state of a virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum LabState {
  /**
   * The lab is currently in draft (has not been published).
   */
  Draft,

  /**
   * The lab is publishing.
   */
  Publishing,

  /**
   * The lab is scaling.
   */
  Scaling,

  /**
   * The lab is syncing users.
   */
  Syncing,

  /**
   * The lab has been published.
   */
  Published,
}

/**
 * Indicates what lab virtual machines are created from.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum CreateOption {
  /**
   * An image is used to create all lab user virtual machines. When this option is set, no template VM will be created.
   */
  Image,

  /**
   * A template VM will be used to create all lab user virtual machines.
   */
  TemplateVM,
}

/**
 * The operation status
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum OperationStatus {
  /**
   * The operation has been accepted but hasn't started.
   */
  NotStarted,

  /**
   * The operation is running
   */
  InProgress,

  /**
   * The operation Succeeded
   */
  Succeeded,

  /**
   * The operation failed
   */
  Failed,

  /**
   * Not supported yet
   */
  Canceled,
}

/**
 * Schedule recurrence frequencies.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RecurrenceFrequency {
  /**
   * Schedule will run every days.
   */
  Daily,

  /**
   * Schedule will run every week on days specified in weekDays.
   */
  Weekly,
}

/**
 * Days of the week.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum WeekDay {
  /**
   * Schedule will run on Sunday
   */
  Sunday,

  /**
   * Schedule will run on Monday
   */
  Monday,

  /**
   * Schedule will run on Tuesday
   */
  Tuesday,

  /**
   * Schedule will run on Wednesday
   */
  Wednesday,

  /**
   * Schedule will run on Thursday
   */
  Thursday,

  /**
   * Schedule will run on Friday
   */
  Friday,

  /**
   * Schedule will run on Saturday
   */
  Saturday,
}

/**
 * The user lab registration state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum RegistrationState {
  /**
   * User has not yet registered with the lab.
   */
  Registered,

  /**
   * User has registered with the lab.
   */
  NotRegistered,
}

/**
 * The lab user invitation state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum InvitationState {
  /**
   * The invitation has not been sent.
   */
  NotSent,

  /**
   * Currently sending the invitation.
   */
  Sending,

  /**
   * The invitation has been successfully sent.
   */
  Sent,

  /**
   * There was an error while sending the invitation.
   */
  Failed,
}

/**
 * The state of a virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum VirtualMachineState {
  /**
   * The VM is currently stopped.
   */
  Stopped,

  /**
   * The VM is starting.
   */
  Starting,

  /**
   * The VM is running.
   */
  Running,

  /**
   * The VM is stopping.
   */
  Stopping,

  /**
   * The VM password is being reset.
   */
  ResettingPassword,

  /**
   * The VM is being reimaged.
   */
  Reimaging,

  /**
   * The VM is being redeployed.
   */
  Redeploying,
}

/**
 * The type of the lab virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum VirtualMachineType {
  /**
   * A user VM
   */
  User,

  /**
   * A template VM
   */
  Template,
}

/**
 * Paged list of Lab services virtual machine images.
 */
model PagedImages is Azure.Core.Page<Image>;

/**
 * Properties of an image resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageProperties extends ImageUpdateProperties {
  /**
   * Current provisioning state of the image.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The image display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * A description of the image.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * URL of the image icon.
   */
  @visibility(Lifecycle.Read)
  iconUrl?: string;

  /**
   * The image author.
   */
  @visibility(Lifecycle.Read)
  author?: string;

  /**
   * The OS Type of the image.
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /**
   * The ID of marketplace plan associated with the image (optional).
   */
  @visibility(Lifecycle.Read)
  plan?: string;

  /**
   * The status of image terms of use (enabled = accepted, disabled = not accepted).
   */
  @visibility(Lifecycle.Read)
  termsStatus?: EnableState;

  /**
   * The ID of an offer associated with the image.
   */
  @visibility(Lifecycle.Read)
  offer?: string;

  /**
   * The ID of the publisher of the image.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * The image SKU.
   */
  @visibility(Lifecycle.Read)
  sku?: string;

  /**
   * The image version.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The ID for the image in the shared gallery.
   */
  @visibility(Lifecycle.Read)
  @maxLength(2000)
  @minLength(3)
  sharedGalleryId?: string;

  /**
   * The available regions of the image in the shared gallery.
   */
  availableRegions?: string[];

  /**
   * The OS State of the image.
   */
  @visibility(Lifecycle.Read)
  osState?: OsState;
}

/**
 * Properties of an image resource update
 */
model ImageUpdateProperties {
  /**
   * Is the image enabled
   */
  enabledState?: EnableState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Lab services virtual machine image for updates.
 */
model ImageUpdate {
  /**
   * Image resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ImageUpdateProperties;
}

/**
 * Paged list of lab plans.
 */
model PagedLabPlans is Azure.Core.Page<LabPlan>;

/**
 * Lab plan resource properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LabPlanProperties extends LabPlanUpdateProperties {
  /**
   * Current provisioning state of the lab plan.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Error details of last operation done on lab plan.
   */
  @visibility(Lifecycle.Read)
  resourceOperationError?: ResourceOperationError;
}

/**
 * Error details of the latest operation failure on this resource
 */
model ResourceOperationError {
  /**
   * The datetime of when the error occured
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The code that corresponds to the type of operation failure
   */
  code?: string;

  /**
   * The operation failure message
   */
  message?: string;

  /**
   * The operation action that failed
   */
  action?: string;
}

/**
 * Lab plan resource properties for updates
 */
model LabPlanUpdateProperties {
  /**
   * The default lab connection profile. This can be changed on a lab resource and only provides a default profile.
   */
  defaultConnectionProfile?: ConnectionProfile;

  /**
   * The default lab shutdown profile. This can be changed on a lab resource and only provides a default profile.
   */
  defaultAutoShutdownProfile?: AutoShutdownProfile;

  /**
   * The lab plan network profile. To enforce lab network policies they must be defined here and cannot be changed when there are existing labs associated with this lab plan.
   */
  defaultNetworkProfile?: LabPlanNetworkProfile;

  /**
   * The allowed regions for the lab creator to use when creating labs using this lab plan.
   */
  allowedRegions?: string[];

  /**
   * Resource ID of the Shared Image Gallery attached to this lab plan. When saving a lab template virtual machine image it will be persisted in this gallery. Shared images from the gallery can be made available to use when creating new labs.
   */
  @maxLength(2000)
  @minLength(3)
  sharedGalleryId?: string;

  /**
   * Support contact information and instructions for users of the lab plan. This information is displayed to lab owners and virtual machine users for all labs in the lab plan.
   */
  supportInfo?: SupportInfo;

  /**
   * Base Url of the lms instance this lab plan can link lab rosters against.
   */
  @maxLength(2000)
  @minLength(3)
  linkedLmsInstance?: string;
}

/**
 * Connection profile for how users connect to lab virtual machines.
 */
model ConnectionProfile {
  /**
   * The enabled access level for Web Access over SSH.
   */
  webSshAccess?: ConnectionType;

  /**
   * The enabled access level for Web Access over RDP.
   */
  webRdpAccess?: ConnectionType;

  /**
   * The enabled access level for Client Access over SSH.
   */
  clientSshAccess?: ConnectionType;

  /**
   * The enabled access level for Client Access over RDP.
   */
  clientRdpAccess?: ConnectionType;
}

/**
 * Profile for how to handle shutting down virtual machines.
 */
model AutoShutdownProfile {
  /**
   * Whether shutdown on disconnect is enabled
   */
  shutdownOnDisconnect?: EnableState;

  /**
   * Whether a VM will get shutdown when it hasn't been connected to after a period of time.
   */
  shutdownWhenNotConnected?: EnableState;

  /**
   * Whether a VM will get shutdown when it has idled for a period of time.
   */
  shutdownOnIdle?: ShutdownOnIdleMode;

  /**
   * The amount of time a VM will stay running after a user disconnects if this behavior is enabled.
   */
  disconnectDelay?: duration;

  /**
   * The amount of time a VM will stay running before it is shutdown if no connection is made and this behavior is enabled.
   */
  noConnectDelay?: duration;

  /**
   * The amount of time a VM will idle before it is shutdown if this behavior is enabled.
   */
  idleDelay?: duration;
}

/**
 * Profile for how to handle networking for Lab Plans.
 */
model LabPlanNetworkProfile {
  /**
   * The external subnet resource id
   */
  @maxLength(2000)
  @minLength(3)
  subnetId?: string;
}

/**
 * Support contact information and instructions.
 */
model SupportInfo {
  /**
   * Support web address.
   */
  @maxLength(2000)
  @minLength(3)
  url?: string;

  /**
   * Support contact email address.
   */
  @maxLength(254)
  @minLength(6)
  email?: string;

  /**
   * Support contact phone number.
   */
  @maxLength(31)
  @minLength(1)
  phone?: string;

  /**
   * Support instructions.
   */
  instructions?: string;
}

/**
 * Identity for the resource.
 */
model Identity {
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
  type?: "SystemAssigned";
}

/**
 * Contains lab configuration and default settings. This variant is used for PATCH.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LabPlanUpdate extends TrackedResourceUpdate {
  /**
   * Lab plan resource update properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LabPlanUpdateProperties;

  /**
   * Managed Identity Information
   */
  identity?: Identity;
}

/**
 * Base tracked resource type for all PATCH updates.
 */
model TrackedResourceUpdate {
  /**
   * Resource tags.
   */
  tags?: string[];
}

/**
 * Body for the save image POST
 */
model SaveImageBody {
  /**
   * The name for the image we create.
   */
  name?: string;

  /**
   * The ID of the lab virtual machine you want to save an image from.
   */
  @maxLength(2000)
  @minLength(3)
  labVirtualMachineId?: string;
}

/**
 * Paged list of labs.
 */
model PagedLabs is Azure.Core.Page<Lab>;

/**
 * Properties of a lab resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LabProperties extends LabUpdateProperties {
  /**
   * Current provisioning state of the lab.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The network profile for the lab, typically applied via a lab plan. This profile cannot be modified once a lab has been created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkProfile?: LabNetworkProfile;

  /**
   * The lab state.
   */
  @visibility(Lifecycle.Read)
  state?: LabState;

  /**
   * Error details of last operation done on lab.
   */
  @visibility(Lifecycle.Read)
  resourceOperationError?: ResourceOperationError;
}

/**
 * Profile for how to handle networking for Labs.
 */
model LabNetworkProfile {
  /**
   * The external subnet resource id
   */
  @maxLength(2000)
  @minLength(3)
  subnetId?: string;

  /**
   * The external load balancer resource id
   */
  @maxLength(2000)
  @minLength(3)
  loadBalancerId?: string;

  /**
   * The external public IP resource id
   */
  @maxLength(2000)
  @minLength(3)
  publicIpId?: string;
}

/**
 * Properties of a lab resource used for updates.
 */
model LabUpdateProperties {
  /**
   * The resource auto shutdown configuration for the lab. This controls whether actions are taken on resources that are sitting idle.
   */
  autoShutdownProfile?: AutoShutdownProfile;

  /**
   * The connection profile for the lab. This controls settings such as web access to lab resources or whether RDP or SSH ports are open.
   */
  connectionProfile?: ConnectionProfile;

  /**
   * The profile used for creating lab virtual machines.
   */
  virtualMachineProfile?: VirtualMachineProfile;

  /**
   * The lab security profile.
   */
  securityProfile?: SecurityProfile;

  /**
   * The lab user list management profile.
   */
  rosterProfile?: RosterProfile;

  /**
   * The ID of the lab plan. Used during resource creation to provide defaults and acts as a permission container when creating a lab via labs.azure.com. Setting a labPlanId on an existing lab provides organization..
   */
  @maxLength(2000)
  @minLength(3)
  labPlanId?: string;

  /**
   * The title of the lab.
   */
  @maxLength(120)
  @minLength(1)
  title?: string;

  /**
   * The description of the lab.
   */
  description?: string;
}

/**
 * The base virtual machine configuration for a lab.
 */
model VirtualMachineProfile {
  /**
   * Indicates what lab virtual machines are created from.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  createOption: CreateOption;

  /**
   * The image configuration for lab virtual machines.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  imageReference: ImageReference;

  /**
   * The OS type of the image
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /**
   * The SKU for the lab. Defines the type of virtual machines used in the lab.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  sku: Sku;

  /**
   * Additional VM capabilities.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  additionalCapabilities?: VirtualMachineAdditionalCapabilities;

  /**
   * The initial quota alloted to each lab user. Must be a time span between 0 and 9999 hours.
   */
  usageQuota: duration;

  /**
   * Enabling this option will use the same password for all user VMs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  useSharedPassword?: EnableState;

  /**
   * Credentials for the admin user on the VM.
   */
  adminUser: Credentials;

  /**
   * Credentials for the non-admin user on the VM, if one exists.
   */
  nonAdminUser?: Credentials;
}

/**
 * Image reference information. Used in the virtual machine profile.
 */
model ImageReference {
  /**
   * Image resource ID
   */
  @maxLength(2000)
  @minLength(3)
  id?: string;

  /**
   * The image offer if applicable.
   */
  offer?: string;

  /**
   * The image publisher
   */
  publisher?: string;

  /**
   * The image SKU
   */
  sku?: string;

  /**
   * The image version specified on creation.
   */
  version?: string;

  /**
   * The actual version of the image after use.
   */
  @visibility(Lifecycle.Read)
  exactVersion?: string;
}

/**
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

/**
 * The additional capabilities for a lab VM.
 */
model VirtualMachineAdditionalCapabilities {
  /**
   * Flag to pre-install dedicated GPU drivers.
   */
  installGpuDrivers?: EnableState;
}

/**
 * Credentials for a user on a lab VM.
 */
model Credentials {
  /**
   * The username to use when signing in to lab VMs.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  username: string;

  /**
   * The password for the user. This is required for the TemplateVM createOption.
   */
  @visibility(Lifecycle.Create)
  password?: string;
}

/**
 * The lab security profile.
 */
model SecurityProfile {
  /**
   * The registration code for the lab.
   */
  @visibility(Lifecycle.Read)
  registrationCode?: string;

  /**
   * Whether any user or only specified users can register to a lab.
   */
  openAccess?: EnableState;
}

/**
 * The lab user list management profile.
 */
model RosterProfile {
  /**
   * The AAD group ID which this lab roster is populated from. Having this set enables AAD sync mode.
   */
  activeDirectoryGroupId?: string;

  /**
   * The unique context identifier for the lab in the lms.
   */
  ltiContextId?: string;

  /**
   * The base URI identifying the lms instance.
   */
  lmsInstance?: string;

  /**
   * The unique id of the azure lab services tool in the lms.
   */
  ltiClientId?: string;

  /**
   * The uri of the names and roles service endpoint on the lms for the class attached to this lab.
   */
  ltiRosterEndpoint?: string;
}

/**
 * The lab resource for updates.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LabUpdate extends TrackedResourceUpdate {
  /**
   * Lab resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LabUpdateProperties;
}

/**
 * A long running operation result
 */
model OperationResult {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The operation status
   */
  status: OperationStatus;

  /**
   * Start time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Percent completion
   */
  percentComplete?: float32;

  /**
   * The error for a failure if the operation failed.
   */
  error?: ErrorDetail;
}

/**
 * Paged list of schedules.
 */
model PagedSchedules is Azure.Core.Page<Schedule>;

/**
 * Schedule resource properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ScheduleProperties extends ScheduleUpdateProperties {
  /**
   * Current provisioning state of the schedule.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Error details of last operation done on schedule.
   */
  @visibility(Lifecycle.Read)
  resourceOperationError?: ResourceOperationError;
}

/**
 * Schedule resource properties used for updates.
 */
model ScheduleUpdateProperties {
  /**
   * When lab user virtual machines will be started. Timestamp offsets will be ignored and timeZoneId is used instead.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  /**
   * When lab user virtual machines will be stopped. Timestamp offsets will be ignored and timeZoneId is used instead.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stopAt?: utcDateTime;

  /**
   * The recurrence pattern of the scheduled actions.
   */
  recurrencePattern?: RecurrencePattern;

  /**
   * The IANA timezone id for the schedule.
   */
  @maxLength(50)
  timeZoneId?: string;

  /**
   * Notes for this schedule.
   */
  @maxLength(1000)
  notes?: string;
}

/**
 * Recurrence pattern of a lab schedule.
 */
model RecurrencePattern {
  /**
   * The frequency of the recurrence.
   */
  frequency: RecurrenceFrequency;

  /**
   * The week days the schedule runs. Used for when the Frequency is set to Weekly.
   */
  weekDays?: WeekDay[];

  /**
   * The interval to invoke the schedule on. For example, interval = 2 and RecurrenceFrequency.Daily will run every 2 days. When no interval is supplied, an interval of 1 is used.
   */
  @maxValue(365)
  @minValue(1)
  interval?: int32;

  /**
   * When the recurrence will expire. This date is inclusive.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate: utcDateTime;
}

/**
 * Schedule for automatically turning virtual machines in a lab on and off at specified times. Used for updates.
 */
model ScheduleUpdate {
  /**
   * Schedule resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ScheduleUpdateProperties;
}

/**
 * Paged list of lab services skus.
 */
model PagedLabServicesSkus is Azure.Core.Page<LabServicesSku>;

/**
 * Azure Lab Services resource SKUs
 */
model LabServicesSku {
  /**
   * The lab services resource type.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The name of the SKU.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The tier of the SKU.
   */
  @visibility(Lifecycle.Read)
  tier?: LabServicesSkuTier;

  /**
   * The SKU size.
   */
  @visibility(Lifecycle.Read)
  size?: string;

  /**
   * The family of the SKU.
   */
  @visibility(Lifecycle.Read)
  family?: string;

  /**
   * The scale out/in options of the SKU.
   */
  capacity?: LabServicesSkuCapacity;

  /**
   * The capabilities of the SKU.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  capabilities?: LabServicesSkuCapabilities[];

  /**
   * List of locations that are available for a size.
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * Metadata for retrieving price info of a lab services SKUs.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  costs?: LabServicesSkuCost[];

  /**
   * Restrictions of a lab services SKUs.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  restrictions?: LabServicesSkuRestrictions[];
}

/**
 * The scale out/in options of the SKU.
 */
model LabServicesSkuCapacity {
  /**
   * The default capacity for this resource.
   */
  @visibility(Lifecycle.Read)
  default?: int64;

  /**
   * The lowest permitted capacity for this resource.
   */
  @visibility(Lifecycle.Read)
  minimum?: int64;

  /**
   * The highest permitted capacity for this resource.
   */
  @visibility(Lifecycle.Read)
  maximum?: int64;

  /**
   * The localized name of the resource.
   */
  @visibility(Lifecycle.Read)
  scaleType?: ScaleType;
}

/**
 * The array of capabilities of a lab services SKU.
 */
model LabServicesSkuCapabilities {
  /**
   * The name of the capability for a SKU.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The value of the capability for a SKU.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The array of costs of a lab services SKU.
 */
model LabServicesSkuCost {
  /**
   * The meter id.
   */
  @visibility(Lifecycle.Read)
  meterId?: string;

  /**
   * The quantity of units charged.
   */
  @visibility(Lifecycle.Read)
  quantity?: float32;

  /**
   * The extended unit.
   */
  @visibility(Lifecycle.Read)
  extendedUnit?: string;
}

/**
 * The restriction details.
 */
model LabServicesSkuRestrictions {
  /**
   * The type of restriction.
   */
  @visibility(Lifecycle.Read)
  type?: RestrictionType;

  /**
   * The values of the restriction.
   */
  @visibility(Lifecycle.Read)
  values?: string[];

  /**
   * The reason for the restriction.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: RestrictionReasonCode;
}

/**
 * List of Core Usages.
 */
model ListUsagesResult is Azure.Core.Page<Usage>;

/**
 * The core usage details.
 */
model Usage {
  /**
   * The current usage.
   */
  currentValue?: int64;

  /**
   * The limit integer.
   */
  limit?: int64;

  /**
   * The unit details.
   */
  unit?: UsageUnit;

  /**
   * The name.
   */
  name?: UsageName;

  /**
   * The fully qualified arm resource id.
   */
  id?: string;
}

/**
 * The Usage Names.
 */
model UsageName {
  /**
   * The localized name of the resource.
   */
  localizedValue?: string;

  /**
   * The instances of the resource.
   */
  skuInstances?: string[];

  /**
   * The name of the resource.
   */
  value?: string;
}

/**
 * Paged list of users.
 */
model PagedUsers is Azure.Core.Page<User>;

/**
 * User resource properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UserProperties extends UserUpdateProperties {
  /**
   * Current provisioning state of the user resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Error details of last operation done on lab plan.
   */
  @visibility(Lifecycle.Read)
  resourceOperationError?: ResourceOperationError;

  /**
   * Display name of the user, for example user's full name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Email address of the user.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(254)
  @minLength(6)
  email: string;

  /**
   * State of the user's registration within the lab.
   */
  @visibility(Lifecycle.Read)
  registrationState?: RegistrationState;

  /**
   * State of the invitation message for the user.
   */
  @visibility(Lifecycle.Read)
  invitationState?: InvitationState;

  /**
   * Date and time when the invitation message was sent to the user.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  invitationSent?: utcDateTime;

  /**
   * How long the user has used their virtual machines in this lab.
   */
  @visibility(Lifecycle.Read)
  totalUsage?: duration;
}

/**
 * User resource properties used for updates.
 */
model UserUpdateProperties {
  /**
   * The amount of usage quota time the user gets in addition to the lab usage quota.
   */
  additionalUsageQuota?: duration;
}

/**
 * User of a lab that can register for and use virtual machines within the lab. Used for updates.
 */
model UserUpdate {
  /**
   * User resource properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: UserUpdateProperties;
}

/**
 * Body for a user invite request
 */
model InviteBody {
  /**
   * Custom text for the invite email.
   */
  text?: string;
}

/**
 * Paged list of lab services virtual machines.
 */
model PagedVirtualMachines is Azure.Core.Page<VirtualMachine>;

/**
 * Virtual machine resource properties
 */
model VirtualMachineProperties {
  /**
   * Current provisioning state of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The current state of the virtual machine
   */
  @visibility(Lifecycle.Read)
  state?: VirtualMachineState;

  /**
   * Error details of last operation done on lab plan.
   */
  @visibility(Lifecycle.Read)
  resourceOperationError?: ResourceOperationError;

  /**
   * Profile for information about connecting to the virtual machine.
   */
  @visibility(Lifecycle.Read)
  connectionProfile?: VirtualMachineConnectionProfile;

  /**
   * The lab user ID (not the PUID!) of who claimed the virtual machine.
   */
  @visibility(Lifecycle.Read)
  claimedByUserId?: string;

  /**
   * The type of this VM resource
   */
  @visibility(Lifecycle.Read)
  vmType?: VirtualMachineType;
}

/**
 * The connection information for the virtual machine
 */
model VirtualMachineConnectionProfile {
  /**
   * The private IP address of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  /**
   * Port and host name separated by semicolon for connecting via SSH protocol to the virtual machine.
   */
  @visibility(Lifecycle.Read)
  sshAuthority?: string;

  /**
   * URL for connecting via SSH protocol to the virtual machine in browser.
   */
  @visibility(Lifecycle.Read)
  @maxLength(2000)
  @minLength(3)
  sshInBrowserUrl?: string;

  /**
   * Port and host name separated by semicolon for connecting via RDP protocol to the virtual machine.
   */
  @visibility(Lifecycle.Read)
  rdpAuthority?: string;

  /**
   * URL for connecting via RDP protocol to the virtual machine in browser.
   */
  @visibility(Lifecycle.Read)
  @maxLength(2000)
  @minLength(3)
  rdpInBrowserUrl?: string;

  /**
   * The username used to log on to the virtual machine as admin.
   */
  @visibility(Lifecycle.Read)
  adminUsername?: string;

  /**
   * The username used to log on to the virtual machine as non-admin, if one exists.
   */
  @visibility(Lifecycle.Read)
  nonAdminUsername?: string;
}

/**
 * Body of a reset password request.
 */
model ResetPasswordBody {
  /**
   * The user whose password is being reset
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  username: string;

  /**
   * The password
   */
  @visibility(Lifecycle.Create)
  password: string;
}
