import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.LabServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The tier of the SKU.")
enum AvailableLabServicesSkuTier {
  Standard,
  Premium,
}

@doc("The localized name of the resource.")
enum ScaleType {
  @doc("The capacity is not adjustable in any way.") None,
  @doc("The user must manually scale this SKU in and out.") Manual,
  @doc("The user is permitted to scale this SKU in and out.") Automatic,
}

@doc("The type of restriction.")
enum RestrictionType {
  Location,
}

@doc("The reason for the restriction.")
enum RestrictionReasonCode {
  QuotaId,
  NotAvailableForSubscription,
}

@doc("The unit details.")
enum UsageUnit {
  Count,
}

@doc("Resource provisioning state.")
@fixed
enum ProvisioningState {
  @doc("Resource is in the process of being created.") Creating,
  @doc("New property values are being applied to the resource.") Updating,
  @doc("Resource is in the process of being deleted.") Deleting,
  @doc("Resource is in healthy state after creation or update operation.")
  Succeeded,
  @doc("Previous operation on the resource has failed leaving resource in unhealthy state.")
  Failed,
  @doc("The resource is locked and changes are currently blocked. This could be due to maintenance or a scheduled operation. The state will go back to succeeded once the locking operation has finished.")
  Locked,
}

@doc("The operating system type.")
@fixed
enum OsType {
  Windows,
  Linux,
}

@doc("Property enabled state.")
@fixed
enum EnableState {
  Enabled,
  Disabled,
}

@doc("The operating system state.")
@fixed
enum OsState {
  @doc("Image does not contain any machine and user specific information.")
  Generalized,
  @doc("Image contains machine and user specific information.") Specialized,
}

@doc("A connection type for access labs and VMs (Public, Private or None).")
@fixed
enum ConnectionType {
  Public,
  Private,
  None,
}

@doc("Defines whether to shut down VM on idle and the criteria for idle detection.")
@fixed
enum ShutdownOnIdleMode {
  @doc("The VM won't be shut down when it is idle.") None,
  @doc("The VM will be considered as idle when there is no keyboard or mouse input.")
  UserAbsence,
  @doc("The VM will be considered as idle when user is absent and the resource (CPU and disk) consumption is low.")
  LowUsage,
}

@doc("The state of a virtual machine.")
@fixed
enum LabState {
  @doc("The lab is currently in draft (has not been published).") Draft,
  @doc("The lab is publishing.") Publishing,
  @doc("The lab is scaling.") Scaling,
  @doc("The lab is syncing users.") Syncing,
  @doc("The lab has been published.") Published,
}

@doc("Indicates what lab virtual machines are created from.")
@fixed
enum CreateOption {
  @doc("An image is used to create all lab user virtual machines. When this option is set, no template VM will be created.")
  Image,
  @doc("A template VM will be used to create all lab user virtual machines.")
  TemplateVM,
}

@doc("Schedule recurrence frequencies.")
@fixed
enum RecurrenceFrequency {
  @doc("Schedule will run every days.") Daily,
  @doc("Schedule will run every week on days specified in weekDays.") Weekly,
}

@doc("Days of the week.")
@fixed
enum WeekDay {
  @doc("Schedule will run on Sunday") Sunday,
  @doc("Schedule will run on Monday") Monday,
  @doc("Schedule will run on Tuesday") Tuesday,
  @doc("Schedule will run on Wednesday") Wednesday,
  @doc("Schedule will run on Thursday") Thursday,
  @doc("Schedule will run on Friday") Friday,
  @doc("Schedule will run on Saturday") Saturday,
}

@doc("The user lab registration state.")
@fixed
enum RegistrationState {
  @doc("User has not yet registered with the lab.") Registered,
  @doc("User has registered with the lab.") NotRegistered,
}

@doc("The lab user invitation state.")
@fixed
enum InvitationState {
  @doc("The invitation has not been sent.") NotSent,
  @doc("Currently sending the invitation.") Sending,
  @doc("The invitation has been successfully sent.") Sent,
  @doc("There was an error while sending the invitation.") Failed,
}

@doc("The state of a virtual machine.")
@fixed
enum VirtualMachineState {
  @doc("The VM is currently stopped.") Stopped,
  @doc("The VM is starting.") Starting,
  @doc("The VM is running.") Running,
  @doc("The VM is stopping.") Stopping,
  @doc("The VM password is being reset.") ResettingPassword,
  @doc("The VM is being reimaged.") Reimaging,
  @doc("The VM is being redeployed.") Redeploying,
}

@doc("The type of the lab virtual machine.")
@fixed
enum VirtualMachineType {
  @doc("A user VM") User,
  @doc("A template VM") Template,
}

@doc("The operation status")
@fixed
enum OperationStatus {
  @doc("The operation has been accepted but hasn't started.") NotStarted,
  @doc("The operation is running") InProgress,
  @doc("The operation Succeeded") Succeeded,
  @doc("The operation failed") Failed,
  @doc("Not supported yet") Canceled,
}

@doc("Properties of an image resource.")
model ImageProperties extends ImageUpdateProperties {
  @doc("Current provisioning state of the image.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The image display name.")
  @visibility("read")
  displayName?: string;

  @doc("A description of the image.")
  @visibility("read")
  description?: string;

  @doc("URL of the image icon.")
  @visibility("read")
  iconUrl?: string;

  @doc("The image author.")
  @visibility("read")
  author?: string;

  @doc("The OS Type of the image.")
  @visibility("read")
  osType?: OsType;

  @doc("The ID of marketplace plan associated with the image (optional).")
  @visibility("read")
  plan?: string;

  @doc("The status of image terms of use (enabled = accepted, disabled = not accepted).")
  @visibility("read")
  termsStatus?: EnableState;

  @doc("The ID of an offer associated with the image.")
  @visibility("read")
  offer?: string;

  @doc("The ID of the publisher of the image.")
  @visibility("read")
  publisher?: string;

  @doc("The image SKU.")
  @visibility("read")
  sku?: string;

  @doc("The image version.")
  @visibility("read")
  version?: string;

  @doc("The ID for the image in the shared gallery.")
  @visibility("read")
  sharedGalleryId?: string;

  @doc("The available regions of the image in the shared gallery.")
  availableRegions?: string[];

  @doc("The OS State of the image.")
  @visibility("read")
  osState?: OsState;
}

@doc("Properties of an image resource update")
model ImageUpdateProperties {
  @doc("Is the image enabled")
  enabledState?: EnableState;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Lab services virtual machine image for updates.")
model ImageUpdate {
  @doc("Image resource properties")
  properties?: ImageUpdateProperties;
}

@doc("Lab plan resource properties")
model LabPlanProperties extends LabPlanUpdateProperties {
  @doc("Current provisioning state of the lab plan.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Lab plan resource properties for updates")
model LabPlanUpdateProperties {
  @doc("The default lab connection profile. This can be changed on a lab resource and only provides a default profile.")
  defaultConnectionProfile?: ConnectionProfile;

  @doc("The default lab shutdown profile. This can be changed on a lab resource and only provides a default profile.")
  defaultAutoShutdownProfile?: AutoShutdownProfile;

  @doc("The lab plan network profile. To enforce lab network policies they must be defined here and cannot be changed when there are existing labs associated with this lab plan.")
  defaultNetworkProfile?: LabPlanNetworkProfile;

  @doc("The allowed regions for the lab creator to use when creating labs using this lab plan.")
  allowedRegions?: string[];

  @doc("Resource ID of the Shared Image Gallery attached to this lab plan. When saving a lab template virtual machine image it will be persisted in this gallery. Shared images from the gallery can be made available to use when creating new labs.")
  sharedGalleryId?: string;

  @doc("Support contact information and instructions for users of the lab plan. This information is displayed to lab owners and virtual machine users for all labs in the lab plan.")
  supportInfo?: SupportInfo;

  @doc("Base Url of the lms instance this lab plan can link lab rosters against.")
  linkedLmsInstance?: string;
}

@doc("Connection profile for how users connect to lab virtual machines.")
model ConnectionProfile {
  @doc("The enabled access level for Web Access over SSH.")
  webSshAccess?: ConnectionType;

  @doc("The enabled access level for Web Access over RDP.")
  webRdpAccess?: ConnectionType;

  @doc("The enabled access level for Client Access over SSH.")
  clientSshAccess?: ConnectionType;

  @doc("The enabled access level for Client Access over RDP.")
  clientRdpAccess?: ConnectionType;
}

@doc("Profile for how to handle shutting down virtual machines.")
model AutoShutdownProfile {
  @doc("Whether shutdown on disconnect is enabled")
  shutdownOnDisconnect?: EnableState;

  @doc("Whether a VM will get shutdown when it hasn't been connected to after a period of time.")
  shutdownWhenNotConnected?: EnableState;

  @doc("Whether a VM will get shutdown when it has idled for a period of time.")
  shutdownOnIdle?: ShutdownOnIdleMode;

  @doc("The amount of time a VM will stay running after a user disconnects if this behavior is enabled.")
  disconnectDelay?: duration;

  @doc("The amount of time a VM will stay running before it is shutdown if no connection is made and this behavior is enabled.")
  noConnectDelay?: duration;

  @doc("The amount of time a VM will idle before it is shutdown if this behavior is enabled.")
  idleDelay?: duration;
}

@doc("Profile for how to handle networking for Lab Plans.")
model LabPlanNetworkProfile {
  @doc("The external subnet resource id")
  subnetId?: string;
}

@doc("Support contact information and instructions.")
model SupportInfo {
  @doc("Support web address.")
  url?: string;

  @doc("Support contact email address.")
  @maxLength(254)
  @minLength(6)
  email?: string;

  @doc("Support contact phone number.")
  @maxLength(31)
  @minLength(1)
  phone?: string;

  @doc("Support instructions.")
  instructions?: string;
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
  type?: "SystemAssigned";
}

@doc("Contains lab configuration and default settings. This variant is used for PATCH.")
model LabPlanUpdate extends TrackedResourceUpdate {
  @doc("Lab plan resource update properties")
  properties?: LabPlanUpdateProperties;

  @doc("Managed Identity Information")
  identity?: Identity;
}

@doc("Base tracked resource type for all PATCH updates.")
model TrackedResourceUpdate {
  @doc("Resource tags.")
  tags?: string[];
}

@doc("Body for the save image POST")
model SaveImageBody {
  @doc("The name for the image we create.")
  name?: string;

  @doc("The ID of the lab virtual machine you want to save an image from.")
  labVirtualMachineId?: string;
}

@doc("Properties of a lab resource.")
model LabProperties extends LabUpdateProperties {
  @doc("Current provisioning state of the lab.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The network profile for the lab, typically applied via a lab plan. This profile cannot be modified once a lab has been created.")
  @visibility("read", "create")
  networkProfile?: LabNetworkProfile;

  @doc("The lab state.")
  @visibility("read")
  state?: LabState;
}

@doc("Profile for how to handle networking for Labs.")
model LabNetworkProfile {
  @doc("The external subnet resource id")
  subnetId?: string;

  @doc("The external load balancer resource id")
  loadBalancerId?: string;

  @doc("The external public IP resource id")
  publicIpId?: string;
}

@doc("Properties of a lab resource used for updates.")
model LabUpdateProperties {
  @doc("The resource auto shutdown configuration for the lab. This controls whether actions are taken on resources that are sitting idle.")
  autoShutdownProfile?: AutoShutdownProfile;

  @doc("The connection profile for the lab. This controls settings such as web access to lab resources or whether RDP or SSH ports are open.")
  connectionProfile?: ConnectionProfile;

  @doc("The profile used for creating lab virtual machines.")
  virtualMachineProfile?: VirtualMachineProfile;

  @doc("The lab security profile.")
  securityProfile?: SecurityProfile;

  @doc("The lab user list management profile.")
  rosterProfile?: RosterProfile;

  @doc("The ID of the lab plan. Used during resource creation to provide defaults and acts as a permission container when creating a lab via labs.azure.com. Setting a labPlanId on an existing lab provides organization..")
  labPlanId?: string;

  @doc("The title of the lab.")
  @maxLength(120)
  @minLength(1)
  title?: string;

  @doc("The description of the lab.")
  description?: string;
}

@doc("The base virtual machine configuration for a lab.")
model VirtualMachineProfile {
  @doc("Indicates what lab virtual machines are created from.")
  @visibility("read", "create")
  createOption: CreateOption;

  @doc("The image configuration for lab virtual machines.")
  @visibility("read", "create")
  imageReference: ImageReference;

  @doc("The OS type of the image")
  @visibility("read")
  osType?: OsType;

  @doc("The SKU for the lab. Defines the type of virtual machines used in the lab.")
  @visibility("read", "create")
  sku: Sku;

  @doc("Additional VM capabilities.")
  @visibility("read", "create")
  additionalCapabilities?: VirtualMachineAdditionalCapabilities;

  @doc("The initial quota alloted to each lab user. Must be a time span between 0 and 9999 hours.")
  usageQuota: duration;

  @doc("Enabling this option will use the same password for all user VMs.")
  @visibility("read", "create")
  useSharedPassword?: EnableState;

  @doc("Credentials for the admin user on the VM.")
  adminUser: Credentials;

  @doc("Credentials for the non-admin user on the VM, if one exists.")
  nonAdminUser?: Credentials;
}

@doc("Image reference information. Used in the virtual machine profile.")
model ImageReference {
  @doc("Image resource ID")
  id?: string;

  @doc("The image offer if applicable.")
  offer?: string;

  @doc("The image publisher")
  publisher?: string;

  @doc("The image SKU")
  sku?: string;

  @doc("The image version specified on creation.")
  version?: string;

  @doc("The actual version of the image after use.")
  @visibility("read")
  exactVersion?: string;
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the SKU. Ex - P3. It is typically a letter+number code")
  name: string;

  @doc("This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.")
  tier?: SkuTier;

  @doc("The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. ")
  size?: string;

  @doc("If the service has different generations of hardware, for the same SKU, then that can be captured here.")
  family?: string;

  @doc("If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.")
  capacity?: int32;
}

@doc("The additional capabilities for a lab VM.")
model VirtualMachineAdditionalCapabilities {
  @doc("Flag to pre-install dedicated GPU drivers.")
  installGpuDrivers?: EnableState;
}

@doc("Credentials for a user on a lab VM.")
model Credentials {
  @doc("The username to use when signing in to lab VMs.")
  @visibility("read", "create")
  username: string;

  @doc("The password for the user. This is required for the TemplateVM createOption.")
  @visibility("create")
  password?: string;
}

@doc("The lab security profile.")
model SecurityProfile {
  @doc("The registration code for the lab.")
  @visibility("read")
  registrationCode?: string;

  @doc("Whether any user or only specified users can register to a lab.")
  openAccess?: EnableState;
}

@doc("The lab user list management profile.")
model RosterProfile {
  @doc("The AAD group ID which this lab roster is populated from. Having this set enables AAD sync mode.")
  activeDirectoryGroupId?: string;

  @doc("The unique context identifier for the lab in the lms.")
  ltiContextId?: string;

  @doc("The base URI identifying the lms instance.")
  lmsInstance?: string;

  @doc("The unique id of the azure lab services tool in the lms.")
  ltiClientId?: string;

  @doc("The uri of the names and roles service endpoint on the lms for the class attached to this lab.")
  ltiRosterEndpoint?: string;
}

@doc("The lab resource for updates.")
model LabUpdate extends TrackedResourceUpdate {
  @doc("Lab resource properties")
  properties?: LabUpdateProperties;
}

@doc("Schedule resource properties")
model ScheduleProperties extends ScheduleUpdateProperties {
  @doc("Current provisioning state of the schedule.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Schedule resource properties used for updates.")
model ScheduleUpdateProperties {
  @doc("When lab user virtual machines will be started. Timestamp offsets will be ignored and timeZoneId is used instead.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startAt?: utcDateTime;

  @doc("When lab user virtual machines will be stopped. Timestamp offsets will be ignored and timeZoneId is used instead.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stopAt?: utcDateTime;

  @doc("The recurrence pattern of the scheduled actions.")
  recurrencePattern?: RecurrencePattern;

  @doc("The IANA timezone id for the schedule.")
  @maxLength(50)
  timeZoneId?: string;

  @doc("Notes for this schedule.")
  @maxLength(1000)
  notes?: string;
}

@doc("Recurrence pattern of a lab schedule.")
model RecurrencePattern {
  @doc("The frequency of the recurrence.")
  frequency: RecurrenceFrequency;

  @doc("The week days the schedule runs. Used for when the Frequency is set to Weekly.")
  weekDays?: WeekDay[];

  @doc("The interval to invoke the schedule on. For example, interval = 2 and RecurrenceFrequency.Daily will run every 2 days. When no interval is supplied, an interval of 1 is used.")
  @maxValue(365)
  @minValue(1)
  interval?: int32;

  @doc("When the recurrence will expire. This date is inclusive.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate: utcDateTime;
}

@doc("Schedule for automatically turning virtual machines in a lab on and off at specified times. Used for updates.")
model ScheduleUpdate {
  @doc("Schedule resource properties")
  properties?: ScheduleUpdateProperties;
}

@doc("Paged list of lab services skus.")
model PagedLabServicesSkus is Azure.Core.Page<AvailableLabServicesSku>;

@doc("Azure Lab Services resource SKUs")
model AvailableLabServicesSku {
  @doc("The lab services resource type.")
  @visibility("read")
  resourceType?: string;

  @doc("The name of the SKU.")
  @visibility("read")
  name?: string;

  @doc("The tier of the SKU.")
  @visibility("read")
  tier?: AvailableLabServicesSkuTier;

  @doc("The SKU size.")
  @visibility("read")
  size?: string;

  @doc("The family of the SKU.")
  @visibility("read")
  family?: string;

  @doc("The scale out/in options of the SKU.")
  capacity?: LabServicesSkuCapacity;

  @doc("The capabilities of the SKU.")
  @visibility("read")
  capabilities?: LabServicesSkuCapabilities[];

  @doc("List of locations that are available for a size.")
  @visibility("read")
  locations?: string[];

  @doc("Metadata for retrieving price info of a lab services SKUs.")
  @visibility("read")
  costs?: LabServicesSkuCost[];

  @doc("Restrictions of a lab services SKUs.")
  @visibility("read")
  restrictions?: LabServicesSkuRestrictions[];
}

@doc("The scale out/in options of the SKU.")
model LabServicesSkuCapacity {
  @doc("The default capacity for this resource.")
  @visibility("read")
  default?: int32;

  @doc("The lowest permitted capacity for this resource.")
  @visibility("read")
  minimum?: int32;

  @doc("The highest permitted capacity for this resource.")
  @visibility("read")
  maximum?: int32;

  @doc("The localized name of the resource.")
  @visibility("read")
  scaleType?: ScaleType;
}

@doc("The array of capabilities of a lab services SKU.")
model LabServicesSkuCapabilities {
  @doc("The name of the capability for a SKU.")
  @visibility("read")
  name?: string;

  @doc("The value of the capability for a SKU.")
  @visibility("read")
  value?: string;
}

@doc("The array of costs of a lab services SKU.")
model LabServicesSkuCost {
  @doc("The meter id.")
  @visibility("read")
  meterId?: string;

  @doc("The quantity of units charged.")
  @visibility("read")
  quantity?: float32;

  @doc("The extended unit.")
  @visibility("read")
  extendedUnit?: string;
}

@doc("The restriction details.")
model LabServicesSkuRestrictions {
  @doc("The type of restriction.")
  @visibility("read")
  type?: RestrictionType;

  @doc("The values of the restriction.")
  @visibility("read")
  values?: string[];

  @doc("The reason for the restriction.")
  @visibility("read")
  reasonCode?: RestrictionReasonCode;
}

@doc("List of Core Usages.")
model ListUsagesResult is Azure.Core.Page<Usage>;

@doc("The core usage details.")
model Usage {
  @doc("The current usage.")
  currentValue?: int32;

  @doc("The limit integer.")
  limit?: int32;

  @doc("The unit details.")
  unit?: UsageUnit;

  @doc("The name.")
  name?: UsageName;

  @doc("The fully qualified arm resource id.")
  id?: string;
}

@doc("The Usage Names.")
model UsageName {
  @doc("The localized name of the resource.")
  localizedValue?: string;

  @doc("The instances of the resource.")
  skuInstances?: string[];

  @doc("The name of the resource.")
  value?: string;
}

@doc("User resource properties")
model UserProperties extends UserUpdateProperties {
  @doc("Current provisioning state of the user resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Display name of the user, for example user's full name.")
  @visibility("read")
  displayName?: string;

  @doc("Email address of the user.")
  @visibility("read", "create")
  @maxLength(254)
  @minLength(6)
  email: string;

  @doc("State of the user's registration within the lab.")
  @visibility("read")
  registrationState?: RegistrationState;

  @doc("State of the invitation message for the user.")
  @visibility("read")
  invitationState?: InvitationState;

  @doc("Date and time when the invitation message was sent to the user.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  invitationSent?: utcDateTime;

  @doc("How long the user has used their virtual machines in this lab.")
  @visibility("read")
  totalUsage?: duration;
}

@doc("User resource properties used for updates.")
model UserUpdateProperties {
  @doc("The amount of usage quota time the user gets in addition to the lab usage quota.")
  additionalUsageQuota?: duration;
}

@doc("User of a lab that can register for and use virtual machines within the lab. Used for updates.")
model UserUpdate {
  @doc("User resource properties")
  properties?: UserUpdateProperties;
}

@doc("Body for a user invite request")
model InviteBody {
  @doc("Custom text for the invite email.")
  text?: string;
}

@doc("Virtual machine resource properties")
model VirtualMachineProperties {
  @doc("Current provisioning state of the virtual machine.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The current state of the virtual machine")
  @visibility("read")
  state?: VirtualMachineState;

  @doc("Profile for information about connecting to the virtual machine.")
  @visibility("read")
  connectionProfile?: VirtualMachineConnectionProfile;

  @doc("The lab user ID (not the PUID!) of who claimed the virtual machine.")
  @visibility("read")
  claimedByUserId?: string;

  @doc("The type of this VM resource")
  @visibility("read")
  vmType?: VirtualMachineType;
}

@doc("The connection information for the virtual machine")
model VirtualMachineConnectionProfile {
  @doc("The private IP address of the virtual machine.")
  @visibility("read")
  privateIpAddress?: string;

  @doc("Port and host name separated by semicolon for connecting via SSH protocol to the virtual machine.")
  @visibility("read")
  sshAuthority?: string;

  @doc("URL for connecting via SSH protocol to the virtual machine in browser.")
  @visibility("read")
  sshInBrowserUrl?: string;

  @doc("Port and host name separated by semicolon for connecting via RDP protocol to the virtual machine.")
  @visibility("read")
  rdpAuthority?: string;

  @doc("URL for connecting via RDP protocol to the virtual machine in browser.")
  @visibility("read")
  rdpInBrowserUrl?: string;

  @doc("The username used to log on to the virtual machine as admin.")
  @visibility("read")
  adminUsername?: string;

  @doc("The username used to log on to the virtual machine as non-admin, if one exists.")
  @visibility("read")
  nonAdminUsername?: string;
}

@doc("Body of a reset password request.")
model ResetPasswordBody {
  @doc("The user whose password is being reset")
  @visibility("read", "create")
  username: string;

  @doc("The password")
  @visibility("create")
  password: string;
}

@doc("A long running operation result")
model OperationResult {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The operation status")
  status: OperationStatus;

  @doc("Start time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("End time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("Percent completion")
  percentComplete?: float32;

  @doc("The error for a failure if the operation failed.")
  error?: ErrorDetail;
}
