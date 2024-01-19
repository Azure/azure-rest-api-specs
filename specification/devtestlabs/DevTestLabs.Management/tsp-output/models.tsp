import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DevTestLab;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The storage type for the disk (i.e. Standard, Premium).")
enum StorageType {
  Standard,
  Premium,
  StandardSSD,
}

@doc("""
The setting to enable usage of premium data disks.
When its value is 'Enabled', creation of standard or premium data disks is allowed.
When its value is 'Disabled', only creation of standard data disks is allowed.
""")
enum PremiumDataDisk {
  Disabled,
  Enabled,
}

@doc("The access rights to be granted to the user when provisioning an environment")
enum EnvironmentPermission {
  Reader,
  Contributor,
}

@doc("Indicates if the artifact source is enabled (values: Enabled, Disabled).")
enum EnableStatus {
  Enabled,
  Disabled,
}

@doc("The status code for the operation.")
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

@doc("The artifact source's type.")
enum SourceControlType {
  VsoGit,
  GitHub,
  StorageAccount,
}

@doc("Options for uploading the files for the artifact. UploadFilesAndGenerateSasTokens is the default value.")
enum FileUploadOptions {
  UploadFilesAndGenerateSasTokens,
  None,
}

@doc("Target cost status")
enum TargetCostStatus {
  Enabled,
  Disabled,
}

@doc("Indicates whether this threshold will be displayed on cost charts.")
enum CostThresholdStatus {
  Enabled,
  Disabled,
}

@doc("Reporting cycle type.")
enum ReportingCycleType {
  CalendarMonth,
  Custom,
}

@doc("The type of the cost.")
enum CostType {
  Unavailable,
  Reported,
  Projected,
}

@doc("The state of the Windows OS (i.e. NonSysprepped, SysprepRequested, SysprepApplied).")
enum WindowsOsState {
  NonSysprepped,
  SysprepRequested,
  SysprepApplied,
}

@doc("The state of the Linux OS (i.e. NonDeprovisioned, DeprovisionRequested, DeprovisionApplied).")
enum LinuxOsState {
  NonDeprovisioned,
  DeprovisionRequested,
  DeprovisionApplied,
}

@doc("The OS type of the custom image (i.e. Windows, Linux)")
enum CustomImageOsType {
  Windows,
  Linux,
  None,
}

@doc("The transport protocol for the endpoint.")
enum TransportProtocol {
  Tcp,
  Udp,
}

@doc("Caching option for a data disk (i.e. None, ReadOnly, ReadWrite).")
enum HostCachingOptions {
  None,
  ReadOnly,
  ReadWrite,
}

@doc("The event type for which this notification is enabled (i.e. AutoShutdown, Cost)")
enum NotificationChannelEventType {
  AutoShutdown,
  Cost,
}

@doc("The status of the policy.")
enum PolicyStatus {
  Enabled,
  Disabled,
}

@doc("The fact name of the policy (e.g. LabVmCount, LabVmSize, MaxVmsAllowedPerLab, etc.")
enum PolicyFactName {
  UserOwnedLabVmCount,
  UserOwnedLabPremiumVmCount,
  LabVmCount,
  LabPremiumVmCount,
  LabVmSize,
  GalleryImage,
  UserOwnedLabVmCountInSubnet,
  LabTargetCost,
  EnvironmentTemplate,
  ScheduleEditPermission,
}

@doc("The evaluator type of the policy (i.e. AllowedValuesPolicy, MaxValuePolicy).")
enum PolicyEvaluatorType {
  AllowedValuesPolicy,
  MaxValuePolicy,
}

@doc("Tells source of creation of lab virtual machine. Output property only.")
enum VirtualMachineCreationSource {
  FromCustomImage,
  FromGalleryImage,
  FromSharedGalleryImage,
}

@doc("The permission policy of the subnet for allowing public IP addresses (i.e. Allow, Deny)).")
enum UsagePermissionType {
  Default,
  Deny,
  Allow,
}

@doc("Properties of a lab.")
model LabProperties {
  @doc("The lab's default storage account.")
  @visibility("read")
  defaultStorageAccount?: string;

  @doc("The lab's default premium storage account.")
  @visibility("read")
  defaultPremiumStorageAccount?: string;

  @doc("The lab's artifact storage account.")
  @visibility("read")
  artifactsStorageAccount?: string;

  @doc("The lab's premium data disk storage account.")
  @visibility("read")
  premiumDataDiskStorageAccount?: string;

  @doc("The lab's Key vault.")
  @visibility("read")
  vaultName?: string;

  @doc("Type of storage used by the lab. It can be either Premium or Standard. Default is Premium.")
  labStorageType?: StorageType;

  @doc("The ordered list of artifact resource IDs that should be applied on all Linux VM creations by default, prior to the artifacts specified by the user.")
  mandatoryArtifactsResourceIdsLinux?: string[];

  @doc("The ordered list of artifact resource IDs that should be applied on all Windows VM creations by default, prior to the artifacts specified by the user.")
  mandatoryArtifactsResourceIdsWindows?: string[];

  @doc("The creation date of the lab.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("""
The setting to enable usage of premium data disks.
When its value is 'Enabled', creation of standard or premium data disks is allowed.
When its value is 'Disabled', only creation of standard data disks is allowed.
""")
  premiumDataDisks?: PremiumDataDisk;

  @doc("The access rights to be granted to the user when provisioning an environment")
  environmentPermission?: EnvironmentPermission;

  @doc("The properties of any lab announcement associated with this lab")
  announcement?: LabAnnouncementProperties;

  @doc("The properties of any lab support message associated with this lab")
  support?: LabSupportProperties;

  @doc("The resource group in which all new lab virtual machines will be created. To let DevTest Labs manage resource group creation, set this value to null.")
  @visibility("read")
  vmCreationResourceGroup?: string;

  @doc("The public IP address for the lab's load balancer.")
  @visibility("read")
  publicIpId?: string;

  @doc("The load balancer used to for lab VMs that use shared IP address.")
  @visibility("read")
  loadBalancerId?: string;

  @doc("The Network Security Group attached to the lab VMs Network interfaces to restrict open ports.")
  @visibility("read")
  networkSecurityGroupId?: string;

  @doc("Extended properties of the lab used for experimental features")
  extendedProperties?: Record<string>;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties of a lab's announcement banner")
model LabAnnouncementProperties {
  @doc("The plain text title for the lab announcement")
  title?: string;

  @doc("The markdown text (if any) that this lab displays in the UI. If left empty/null, nothing will be shown.")
  markdown?: string;

  @doc("Is the lab announcement active/enabled at this time?")
  enabled?: EnableStatus;

  @doc("The time at which the announcement expires (null for never)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Has this announcement expired?")
  expired?: boolean;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties of a lab's support banner")
model LabSupportProperties {
  @doc("Is the lab support banner active/enabled at this time?")
  enabled?: EnableStatus;

  @doc("The markdown text (if any) that this lab displays in the UI. If left empty/null, nothing will be shown.")
  markdown?: string;
}

@doc("An Azure resource.")
model Resource {
  @doc("The identifier of the resource.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("The location of the resource.")
  location?: string;

  @doc("The tags of the resource.")
  tags?: Record<string>;
}

@doc("Error from a REST request.")
@error
model CloudError {
  @doc("The cloud error that occurred")
  error?: CloudErrorBody;
}

@doc("Body of an error from a REST request.")
model CloudErrorBody {
  @doc("The error code.")
  code?: string;

  @doc("The error message.")
  message?: string;

  @doc("The error target.")
  target?: string;

  @doc("Inner errors.")
  details?: CloudErrorBody[];
}

@doc("An Operation Result")
model OperationResult {
  @doc("The operation status.")
  status?: string;

  @doc("The status code for the operation.")
  statusCode?: HttpStatusCode;

  @doc("Error details for the operation in case of a failure.")
  error?: OperationError;
}

@doc("Error details for the operation in case of a failure.")
model OperationError {
  @doc("The error code of the operation error.")
  code?: string;

  @doc("The error message of the operation error.")
  message?: string;
}

@doc("Properties of a schedule.")
model ScheduleProperties {
  @doc("The status of the schedule (i.e. Enabled, Disabled)")
  status?: EnableStatus;

  @doc("The task type of the schedule (e.g. LabVmsShutdownTask, LabVmAutoStart).")
  taskType?: string;

  @doc("If the schedule will occur only some days of the week, specify the weekly recurrence.")
  weeklyRecurrence?: WeekDetails;

  @doc("If the schedule will occur once each day of the week, specify the daily recurrence.")
  dailyRecurrence?: DayDetails;

  @doc("If the schedule will occur multiple times a day, specify the hourly recurrence.")
  hourlyRecurrence?: HourDetails;

  @doc("The time zone ID (e.g. Pacific Standard time).")
  timeZoneId?: string;

  @doc("Notification settings.")
  notificationSettings?: NotificationSettings;

  @doc("The creation date of the schedule.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The resource ID to which the schedule belongs")
  targetResourceId?: string;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties of a weekly schedule.")
model WeekDetails {
  @doc("The days of the week for which the schedule is set (e.g. Sunday, Monday, Tuesday, etc.).")
  weekdays?: string[];

  @doc("The time of the day the schedule will occur.")
  time?: string;
}

@doc("Properties of a daily schedule.")
model DayDetails {
  @doc("The time of day the schedule will occur.")
  time?: string;
}

@doc("Properties of an hourly schedule.")
model HourDetails {
  @doc("Minutes of the hour the schedule will run.")
  minute?: int32;
}

@doc("Notification settings for a schedule.")
model NotificationSettings {
  @doc("If notifications are enabled for this schedule (i.e. Enabled, Disabled).")
  status?: EnableStatus;

  @doc("Time in minutes before event at which notification will be sent.")
  timeInMinutes?: int32;

  @doc("The webhook URL to which the notification will be sent.")
  webhookUrl?: string;

  @doc("The email recipient to send notifications to (can be a list of semi-colon separated email addresses).")
  emailRecipient?: string;

  @doc("The locale to use when sending a notification (fallback for unsupported languages is EN).")
  notificationLocale?: string;
}

@doc("Properties of an artifact source.")
model ArtifactSourceProperties {
  @doc("The artifact source's display name.")
  displayName?: string;

  @doc("The artifact source's URI.")
  uri?: string;

  @doc("The artifact source's type.")
  sourceType?: SourceControlType;

  @doc("The folder containing artifacts.")
  folderPath?: string;

  @doc("The folder containing Azure Resource Manager templates.")
  armTemplateFolderPath?: string;

  @doc("The artifact source's branch reference.")
  branchRef?: string;

  @doc("The security token to authenticate to the artifact source.")
  securityToken?: string;

  @doc("Indicates if the artifact source is enabled (values: Enabled, Disabled).")
  status?: EnableStatus;

  @doc("The artifact source's creation date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties of an Azure Resource Manager template.")
model ArmTemplateProperties {
  @doc("The display name of the ARM template.")
  @visibility("read")
  displayName?: string;

  @doc("The description of the ARM template.")
  @visibility("read")
  description?: string;

  @doc("The publisher of the ARM template.")
  @visibility("read")
  publisher?: string;

  @doc("The URI to the icon of the ARM template.")
  @visibility("read")
  icon?: string;

  @doc("The contents of the ARM template.")
  @visibility("read")
  contents?: Record<unknown>;

  @doc("The creation date of the armTemplate.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("File name and parameter values information from all azuredeploy.*.parameters.json for the ARM template.")
  @visibility("read")
  parametersValueFilesInfo?: ParametersValueFileInfo[];

  @doc("Whether or not ARM template is enabled for use by lab user.")
  @visibility("read")
  enabled?: boolean;
}

@doc("A file containing a set of parameter values for an ARM template.")
model ParametersValueFileInfo {
  @doc("File name.")
  fileName?: string;

  @doc("Contents of the file.")
  parametersValueInfo?: Record<unknown>;
}

@doc("Properties of an artifact.")
model ArtifactProperties {
  @doc("The artifact's title.")
  @visibility("read")
  title?: string;

  @doc("The artifact's description.")
  @visibility("read")
  description?: string;

  @doc("The artifact's publisher.")
  @visibility("read")
  publisher?: string;

  @doc("The file path to the artifact.")
  @visibility("read")
  filePath?: string;

  @doc("The URI to the artifact icon.")
  @visibility("read")
  icon?: string;

  @doc("The artifact's target OS.")
  @visibility("read")
  targetOsType?: string;

  @doc("The artifact's parameters.")
  @visibility("read")
  parameters?: Record<unknown>;

  @doc("The artifact's creation date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;
}

@doc("Parameters for generating an ARM template for deploying artifacts.")
model GenerateArmTemplateRequest {
  @doc("The resource name of the virtual machine.")
  virtualMachineName?: string;

  @doc("The parameters of the ARM template.")
  parameters?: ParameterInfo[];

  @doc("The location of the virtual machine.")
  location?: string;

  @doc("Options for uploading the files for the artifact. UploadFilesAndGenerateSasTokens is the default value.")
  fileUploadOptions?: FileUploadOptions;
}

@doc("Information about an artifact's parameter.")
model ParameterInfo {
  @doc("The name of the artifact parameter.")
  name?: string;

  @doc("The value of the artifact parameter.")
  value?: string;
}

@doc("Information about a generated ARM template.")
model ArmTemplateInfo {
  @doc("The template's contents.")
  template?: Record<unknown>;

  @doc("The parameters of the ARM template.")
  parameters?: Record<unknown>;
}

@doc("Properties of an artifact source.")
model ArtifactSourceFragment extends UpdateResource {}

@doc("Represents an update resource")
model UpdateResource {
  @doc("The tags of the resource.")
  tags?: Record<string>;
}

@doc("Properties of a cost item.")
model LabCostProperties {
  @doc("The target cost properties")
  targetCost?: TargetCostProperties;

  @doc("The lab cost summary component of the cost data.")
  @visibility("read")
  labCostSummary?: LabCostSummaryProperties;

  @doc("The lab cost details component of the cost data.")
  @visibility("read")
  labCostDetails?: LabCostDetailsProperties[];

  @doc("The resource cost component of the cost data.")
  @visibility("read")
  resourceCosts?: LabResourceCostProperties[];

  @doc("The currency code of the cost.")
  currencyCode?: string;

  @doc("The start time of the cost data.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  @doc("The end time of the cost data.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  @doc("The creation date of the cost.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties of a cost target.")
model TargetCostProperties {
  @doc("Target cost status")
  status?: TargetCostStatus;

  @doc("Lab target cost")
  target?: int32;

  @doc("Cost thresholds.")
  costThresholds?: CostThresholdProperties[];

  @doc("Reporting cycle start date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cycleStartDateTime?: utcDateTime;

  @doc("Reporting cycle end date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cycleEndDateTime?: utcDateTime;

  @doc("Reporting cycle type.")
  cycleType?: ReportingCycleType;
}

@doc("Properties of a cost threshold item.")
model CostThresholdProperties {
  @doc("The ID of the cost threshold item.")
  thresholdId?: string;

  @doc("The value of the percentage cost threshold.")
  percentageThreshold?: PercentageCostThresholdProperties;

  @doc("Indicates whether this threshold will be displayed on cost charts.")
  displayOnChart?: CostThresholdStatus;

  @doc("Indicates whether notifications will be sent when this threshold is exceeded.")
  sendNotificationWhenExceeded?: CostThresholdStatus;

  @doc("Indicates the datetime when notifications were last sent for this threshold.")
  notificationSent?: string;
}

@doc("Properties of a percentage cost threshold.")
model PercentageCostThresholdProperties {
  @doc("The cost threshold value.")
  thresholdValue?: float32;
}

@doc("The properties of the cost summary.")
model LabCostSummaryProperties {
  @doc("The cost component of the cost item.")
  estimatedLabCost?: float32;
}

@doc("The properties of a lab cost item.")
model LabCostDetailsProperties {
  @doc("The date of the cost item.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  @doc("The cost component of the cost item.")
  cost?: float32;

  @doc("The type of the cost.")
  costType?: CostType;
}

@doc("The properties of a resource cost item.")
model LabResourceCostProperties {
  @doc("The name of the resource.")
  resourcename?: string;

  @doc("The unique identifier of the resource.")
  resourceUId?: string;

  @doc("The cost component of the resource cost item.")
  resourceCost?: float32;

  @doc("The logical resource type (ex. virtualmachine, storageaccount)")
  resourceType?: string;

  @doc("The owner of the resource (ex. janedoe@microsoft.com)")
  resourceOwner?: string;

  @doc("The category of the resource (ex. Premium_LRS, Standard_DS1)")
  resourcePricingTier?: string;

  @doc("The status of the resource (ex. Active)")
  resourceStatus?: string;

  @doc("The ID of the resource")
  resourceId?: string;

  @doc("The ID of the external resource")
  externalResourceId?: string;
}

@doc("Properties of a custom image.")
model CustomImageProperties {
  @doc("The virtual machine from which the image is to be created.")
  vm?: CustomImagePropertiesFromVm;

  @doc("The VHD from which the image is to be created.")
  vhd?: CustomImagePropertiesCustom;

  @doc("The description of the custom image.")
  description?: string;

  @doc("The author of the custom image.")
  author?: string;

  @doc("The creation date of the custom image.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The Managed Image Id backing the custom image.")
  managedImageId?: string;

  @doc("The Managed Snapshot Id backing the custom image.")
  managedSnapshotId?: string;

  @doc("Storage information about the data disks present in the custom image")
  dataDiskStorageInfo?: DataDiskStorageTypeInfo[];

  @doc("Storage information about the plan related to this custom image")
  customImagePlan?: CustomImagePropertiesFromPlan;

  @doc("Whether or not the custom images underlying offer/plan has been enabled for programmatic deployment")
  isPlanAuthorized?: boolean;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties for creating a custom image from a virtual machine.")
model CustomImagePropertiesFromVm {
  @doc("The source vm identifier.")
  sourceVmId?: string;

  @doc("The Windows OS information of the VM.")
  windowsOsInfo?: WindowsOsInfo;

  @doc("The Linux OS information of the VM.")
  linuxOsInfo?: LinuxOsInfo;
}

@doc("Information about a Windows OS.")
model WindowsOsInfo {
  @doc("The state of the Windows OS (i.e. NonSysprepped, SysprepRequested, SysprepApplied).")
  windowsOsState?: WindowsOsState;
}

@doc("Information about a Linux OS.")
model LinuxOsInfo {
  @doc("The state of the Linux OS (i.e. NonDeprovisioned, DeprovisionRequested, DeprovisionApplied).")
  linuxOsState?: LinuxOsState;
}

@doc("Properties for creating a custom image from a VHD.")
model CustomImagePropertiesCustom {
  @doc("The image name.")
  imageName?: string;

  @doc("Indicates whether sysprep has been run on the VHD.")
  sysPrep?: boolean;

  @doc("The OS type of the custom image (i.e. Windows, Linux)")
  osType: CustomImageOsType;
}

@doc("Storage information about the data disks present in the custom image")
model DataDiskStorageTypeInfo {
  @doc("Disk Lun")
  lun?: string;

  @doc("Disk Storage Type")
  storageType?: StorageType;
}

@doc("Properties for plan on a custom image.")
model CustomImagePropertiesFromPlan {
  @doc("The id of the plan, equivalent to name of the plan")
  id?: string;

  @doc("The publisher for the plan from the marketplace image the custom image is derived from")
  publisher?: string;

  @doc("The offer for the plan from the marketplace image the custom image is derived from")
  offer?: string;
}

@doc("A custom image.")
model CustomImageFragment extends UpdateResource {}

@doc("Properties of a formula.")
model FormulaProperties {
  @doc("The description of the formula.")
  description?: string;

  @doc("The author of the formula.")
  @visibility("read")
  author?: string;

  @doc("The OS type of the formula.")
  osType?: string;

  @doc("The creation date of the formula.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("The content of the formula.")
  formulaContent?: LabVirtualMachineCreationParameter;

  @doc("Information about a VM from which a formula is to be created.")
  vm?: FormulaPropertiesFromVm;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties for creating a virtual machine.")
model LabVirtualMachineCreationParameter {
  @doc("The properties of the resource.")
  properties?: LabVirtualMachineCreationParameterProperties;

  @doc("The name of the virtual machine or environment")
  name?: string;

  @doc("The location of the new virtual machine or environment")
  location?: string;

  @doc("The tags of the resource.")
  tags?: Record<string>;
}

@doc("Properties for virtual machine creation.")
model LabVirtualMachineCreationParameterProperties {
  @doc("The number of virtual machine instances to create.")
  bulkCreationParameters?: BulkCreationParameters;

  @doc("The notes of the virtual machine.")
  notes?: string;

  @doc("The object identifier of the owner of the virtual machine.")
  ownerObjectId?: string;

  @doc("The user principal name of the virtual machine owner.")
  ownerUserPrincipalName?: string;

  @doc("The creation date of the virtual machine.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The custom image identifier of the virtual machine.")
  customImageId?: string;

  @doc("The size of the virtual machine.")
  size?: string;

  @doc("The user name of the virtual machine.")
  userName?: string;

  @doc("The password of the virtual machine administrator.")
  password?: string;

  @doc("The SSH key of the virtual machine administrator.")
  sshKey?: string;

  @doc("Indicates whether this virtual machine uses an SSH key for authentication.")
  isAuthenticationWithSshKey?: boolean;

  @doc("The lab subnet name of the virtual machine.")
  labSubnetName?: string;

  @doc("The lab virtual network identifier of the virtual machine.")
  labVirtualNetworkId?: string;

  @doc("Indicates whether the virtual machine is to be created without a public IP address.")
  disallowPublicIpAddress?: boolean;

  @doc("The artifacts to be installed on the virtual machine.")
  artifacts?: ArtifactInstallProperties[];

  @doc("The Microsoft Azure Marketplace image reference of the virtual machine.")
  galleryImageReference?: GalleryImageReference;

  @doc("The id of the plan associated with the virtual machine image")
  planId?: string;

  @doc("The network interface properties.")
  networkInterface?: NetworkInterfaceProperties;

  @doc("The expiration date for VM.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Indicates whether another user can take ownership of the virtual machine")
  allowClaim?: boolean;

  @doc("Storage type to use for virtual machine (i.e. Standard, Premium).")
  storageType?: string;

  @doc("The resource ID of the environment that contains this virtual machine, if any.")
  environmentId?: string;

  @doc("New or existing data disks to attach to the virtual machine after creation")
  dataDiskParameters?: DataDiskProperties[];

  @doc("Virtual Machine schedules to be created")
  scheduleParameters?: ScheduleCreationParameter[];
}

@doc("Parameters for creating multiple virtual machines as a single action.")
model BulkCreationParameters {
  @doc("The number of virtual machine instances to create.")
  instanceCount?: int32;
}

@doc("Properties of an artifact.")
model ArtifactInstallProperties {
  @doc("The artifact's identifier.")
  artifactId?: string;

  @doc("The artifact's title.")
  artifactTitle?: string;

  @doc("The parameters of the artifact.")
  parameters?: ArtifactParameterProperties[];

  @doc("The status of the artifact.")
  status?: string;

  @doc("The status message from the deployment.")
  deploymentStatusMessage?: string;

  @doc("The status message from the virtual machine extension.")
  vmExtensionStatusMessage?: string;

  @doc("The time that the artifact starts to install on the virtual machine.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installTime?: utcDateTime;
}

@doc("Properties of an artifact parameter.")
model ArtifactParameterProperties {
  @doc("The name of the artifact parameter.")
  name?: string;

  @doc("The value of the artifact parameter.")
  value?: string;
}

@doc("The reference information for an Azure Marketplace image.")
model GalleryImageReference {
  @doc("The offer of the gallery image.")
  offer?: string;

  @doc("The publisher of the gallery image.")
  publisher?: string;

  @doc("The SKU of the gallery image.")
  sku?: string;

  @doc("The OS type of the gallery image.")
  osType?: string;

  @doc("The version of the gallery image.")
  version?: string;
}

@doc("Properties of a network interface.")
model NetworkInterfaceProperties {
  @doc("The resource ID of the virtual network.")
  virtualNetworkId?: string;

  @doc("The resource ID of the sub net.")
  subnetId?: string;

  @doc("The resource ID of the public IP address.")
  publicIpAddressId?: string;

  @doc("The public IP address.")
  publicIpAddress?: string;

  @doc("The private IP address.")
  privateIpAddress?: string;

  @doc("The DNS name.")
  dnsName?: string;

  @doc("The RdpAuthority property is a server DNS host name or IP address followed by the service port number for RDP (Remote Desktop Protocol).")
  rdpAuthority?: string;

  @doc("The SshAuthority property is a server DNS host name or IP address followed by the service port number for SSH.")
  sshAuthority?: string;

  @doc("The configuration for sharing a public IP address across multiple virtual machines.")
  sharedPublicIpAddressConfiguration?: SharedPublicIpAddressConfiguration;
}

@doc("Properties of a virtual machine that determine how it is connected to a load balancer.")
model SharedPublicIpAddressConfiguration {
  @doc("The incoming NAT rules")
  inboundNatRules?: InboundNatRule[];
}

@doc("A rule for NAT - exposing a VM's port (backendPort) on the public IP address using a load balancer.")
model InboundNatRule {
  @doc("The transport protocol for the endpoint.")
  transportProtocol?: TransportProtocol;

  @doc("The external endpoint port of the inbound connection. Possible values range between 1 and 65535, inclusive. If unspecified, a value will be allocated automatically.")
  frontendPort?: int32;

  @doc("The port to which the external traffic will be redirected.")
  backendPort?: int32;
}

@doc("Request body for adding a new or existing data disk to a virtual machine.")
model DataDiskProperties {
  @doc("Specifies options to attach a new disk to the virtual machine.")
  attachNewDataDiskOptions?: AttachNewDataDiskOptions;

  @doc("Specifies the existing lab disk id to attach to virtual machine.")
  existingLabDiskId?: string;

  @doc("Caching option for a data disk (i.e. None, ReadOnly, ReadWrite).")
  hostCaching?: HostCachingOptions;
}

@doc("Properties to attach new disk to the Virtual Machine.")
model AttachNewDataDiskOptions {
  @doc("Size of the disk to be attached in Gibibytes.")
  diskSizeGiB?: int32;

  @doc("The name of the disk to be attached.")
  diskName?: string;

  @doc("The storage type for the disk (i.e. Standard, Premium).")
  diskType?: StorageType;
}

@doc("Properties for creating a schedule.")
model ScheduleCreationParameter {
  @doc("The properties of the schedule.")
  properties?: ScheduleCreationParameterProperties;

  @doc("The name of the virtual machine or environment")
  name?: string;

  @doc("The location of the new virtual machine or environment")
  @visibility("read")
  location?: string;

  @doc("The tags of the resource.")
  tags?: Record<string>;
}

@doc("Properties for schedule creation.")
model ScheduleCreationParameterProperties {
  @doc("The status of the schedule (i.e. Enabled, Disabled)")
  status?: EnableStatus;

  @doc("The task type of the schedule (e.g. LabVmsShutdownTask, LabVmAutoStart).")
  taskType?: string;

  @doc("If the schedule will occur only some days of the week, specify the weekly recurrence.")
  weeklyRecurrence?: WeekDetails;

  @doc("If the schedule will occur once each day of the week, specify the daily recurrence.")
  dailyRecurrence?: DayDetails;

  @doc("If the schedule will occur multiple times a day, specify the hourly recurrence.")
  hourlyRecurrence?: HourDetails;

  @doc("The time zone ID (e.g. Pacific Standard time).")
  timeZoneId?: string;

  @doc("Notification settings.")
  notificationSettings?: NotificationSettings;

  @doc("The resource ID to which the schedule belongs")
  targetResourceId?: string;
}

@doc("Information about a VM from which a formula is to be created.")
model FormulaPropertiesFromVm {
  @doc("The identifier of the VM from which a formula is to be created.")
  labVmId?: string;
}

@doc("A formula for creating a VM, specifying an image base and other parameters")
model FormulaFragment extends UpdateResource {}

@doc("The response of a list operation.")
model GalleryImageList is Azure.Core.Page<GalleryImage>;

@doc("A gallery image.")
model GalleryImage extends Resource {
  @doc("The properties of the resource.")
  properties: GalleryImageProperties;
}

@doc("Properties of a gallery image.")
model GalleryImageProperties {
  @doc("The author of the gallery image.")
  author?: string;

  @doc("The creation date of the gallery image.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The description of the gallery image.")
  description?: string;

  @doc("The image reference of the gallery image.")
  imageReference?: GalleryImageReference;

  @doc("The icon of the gallery image.")
  icon?: string;

  @doc("Indicates whether this gallery image is enabled.")
  enabled?: boolean;

  @doc("The third party plan that applies to this image")
  planId?: string;

  @doc("Indicates if the plan has been authorized for programmatic deployment.")
  isPlanAuthorized?: boolean;
}

@doc("Properties of a schedule.")
model NotificationChannelProperties {
  @doc("The webhook URL to send notifications to.")
  webHookUrl?: string;

  @doc("The email recipient to send notifications to (can be a list of semi-colon separated email addresses).")
  emailRecipient?: string;

  @doc("The locale to use when sending a notification (fallback for unsupported languages is EN).")
  notificationLocale?: string;

  @doc("Description of notification.")
  description?: string;

  @doc("The list of event for which this notification is enabled.")
  events?: Event[];

  @doc("The creation date of the notification channel.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("An event to be notified for.")
model Event {
  @doc("The event type for which this notification is enabled (i.e. AutoShutdown, Cost)")
  eventName?: NotificationChannelEventType;
}

@doc("A notification.")
model NotificationChannelFragment extends UpdateResource {}

@doc("Properties for generating a Notification.")
model NotifyParameters {
  @doc("The type of event (i.e. AutoShutdown, Cost)")
  eventName?: NotificationChannelEventType;

  @doc("Properties for the notification in json format.")
  jsonPayload?: string;
}

@doc("Request body for evaluating a policy set.")
model EvaluatePoliciesRequest {
  @doc("Policies to evaluate.")
  policies?: EvaluatePoliciesProperties[];
}

@doc("Properties for evaluating a policy set.")
model EvaluatePoliciesProperties {
  @doc("The fact name.")
  factName?: string;

  @doc("The fact data.")
  factData?: string;

  @doc("The value offset.")
  valueOffset?: string;

  @doc("The user for which policies will be evaluated")
  userObjectId?: string;
}

@doc("Response body for evaluating a policy set.")
model EvaluatePoliciesResponse {
  @doc("Results of evaluating a policy set.")
  results?: PolicySetResult[];
}

@doc("Result of a policy set evaluation.")
model PolicySetResult {
  @doc("A value indicating whether this policy set evaluation has discovered violations.")
  hasError?: boolean;

  @doc("The list of policy violations.")
  policyViolations?: PolicyViolation[];
}

@doc("Policy violation.")
model PolicyViolation {
  @doc("The code of the policy violation.")
  code?: string;

  @doc("The message of the policy violation.")
  message?: string;
}

@doc("Properties of a Policy.")
model PolicyProperties {
  @doc("The description of the policy.")
  description?: string;

  @doc("The status of the policy.")
  status?: PolicyStatus;

  @doc("The fact name of the policy (e.g. LabVmCount, LabVmSize, MaxVmsAllowedPerLab, etc.")
  factName?: PolicyFactName;

  @doc("The fact data of the policy.")
  factData?: string;

  @doc("The threshold of the policy (i.e. a number for MaxValuePolicy, and a JSON array of values for AllowedValuesPolicy).")
  threshold?: string;

  @doc("The evaluator type of the policy (i.e. AllowedValuesPolicy, MaxValuePolicy).")
  evaluatorType?: PolicyEvaluatorType;

  @doc("The creation date of the policy.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("A Policy.")
model PolicyFragment extends UpdateResource {}

@doc("A schedule.")
model ScheduleFragment extends UpdateResource {}

@doc("Properties of a managed identity")
model IdentityProperties {
  @doc("Managed identity.")
  type?: ManagedIdentityType;

  @doc("The principal id of resource identity.")
  principalId?: string;

  @doc("The tenant identifier of resource.")
  tenantId?: string;

  @doc("The client secret URL of the identity.")
  clientSecretUrl?: string;
}

@doc("Properties of a lab user profile.")
model UserProperties {
  @doc("The identity of the user.")
  identity?: UserIdentity;

  @doc("The secret store of the user.")
  secretStore?: UserSecretStore;

  @doc("The creation date of the user profile.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Identity attributes of a lab user.")
model UserIdentity {
  @doc("Set to the principal name / UPN of the client JWT making the request.")
  principalName?: string;

  @doc("Set to the principal Id of the client JWT making the request. Service principal will not have the principal Id.")
  principalId?: string;

  @doc("Set to the tenant ID of the client JWT making the request.")
  tenantId?: string;

  @doc("Set to the object Id of the client JWT making the request. Not all users have object Id. For CSP (reseller) scenarios for example, object Id is not available.")
  objectId?: string;

  @doc("Set to the app Id of the client JWT making the request.")
  appId?: string;
}

@doc("Properties of a user's secret store.")
model UserSecretStore {
  @doc("The URI of the user's Key vault.")
  keyVaultUri?: string;

  @doc("The ID of the user's Key vault.")
  keyVaultId?: string;
}

@doc("Profile of a lab user.")
model UserFragment extends UpdateResource {}

@doc("Properties of a disk.")
model DiskProperties {
  @doc("The storage type for the disk (i.e. Standard, Premium).")
  diskType?: StorageType;

  @doc("The size of the disk in Gibibytes.")
  diskSizeGiB?: int32;

  @doc("The resource ID of the VM to which this disk is leased.")
  leasedByLabVmId?: string;

  @doc("When backed by a blob, the name of the VHD blob without extension.")
  diskBlobName?: string;

  @doc("When backed by a blob, the URI of underlying blob.")
  diskUri?: string;

  @doc("When backed by a blob, the storage account where the blob is.")
  storageAccountId?: string;

  @doc("The creation date of the disk.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The host caching policy of the disk (i.e. None, ReadOnly, ReadWrite).")
  hostCaching?: string;

  @doc("When backed by managed disk, this is the ID of the compute disk resource.")
  managedDiskId?: string;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("A Disk.")
model DiskFragment extends UpdateResource {}

@doc("Properties of the disk to attach.")
model AttachDiskProperties {
  @doc("The resource ID of the Lab virtual machine to which the disk is attached.")
  leasedByLabVmId?: string;
}

@doc("Properties of the disk to detach.")
model DetachDiskProperties {
  @doc("The resource ID of the Lab VM to which the disk is attached.")
  leasedByLabVmId?: string;
}

@doc("Properties of an environment.")
model EnvironmentProperties {
  @doc("The deployment properties of the environment.")
  deploymentProperties?: EnvironmentDeploymentProperties;

  @doc("The display name of the Azure Resource Manager template that produced the environment.")
  armTemplateDisplayName?: string;

  @doc("The identifier of the resource group containing the environment's resources.")
  @visibility("read")
  resourceGroupId?: string;

  @doc("The creator of the environment.")
  @visibility("read")
  createdByUser?: string;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties of an environment deployment.")
model EnvironmentDeploymentProperties {
  @doc("The Azure Resource Manager template's identifier.")
  armTemplateId?: string;

  @doc("The parameters of the Azure Resource Manager template.")
  parameters?: ArmTemplateParameterProperties[];
}

@doc("Properties of an Azure Resource Manager template parameter.")
model ArmTemplateParameterProperties {
  @doc("The name of the template parameter.")
  name?: string;

  @doc("The value of the template parameter.")
  value?: string;
}

@doc("An environment, which is essentially an ARM template deployment.")
model DtlEnvironmentFragment extends UpdateResource {}

@doc("Properties of a secret.")
model SecretProperties {
  @doc("The value of the secret for secret creation.")
  value?: string;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("A secret.")
model SecretFragment extends UpdateResource {}

@doc("Properties of a service fabric.")
model ServiceFabricProperties {
  @doc("The backing service fabric resource's id")
  externalServiceFabricId?: string;

  @doc("The resource id of the environment under which the service fabric resource is present")
  environmentId?: string;

  @doc("The applicable schedule for the virtual machine.")
  @visibility("read")
  applicableSchedule?: ApplicableSchedule;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Schedules applicable to a virtual machine. The schedules may have been defined on a VM or on lab level.")
model ApplicableSchedule extends Resource {
  @doc("The properties of the resource.")
  properties: ApplicableScheduleProperties;
}

@doc("Properties of a schedules applicable to a virtual machine.")
model ApplicableScheduleProperties {
  @doc("The auto-shutdown schedule, if one has been set at the lab or lab resource level.")
  labVmsShutdown?: Schedule;

  @doc("The auto-startup schedule, if one has been set at the lab or lab resource level.")
  labVmsStartup?: Schedule;
}

@doc("A Service Fabric.")
model ServiceFabricFragment extends UpdateResource {}

@doc("Properties of a virtual machine.")
model LabVirtualMachineProperties {
  @doc("The notes of the virtual machine.")
  notes?: string;

  @doc("The object identifier of the owner of the virtual machine.")
  ownerObjectId?: string;

  @doc("The user principal name of the virtual machine owner.")
  ownerUserPrincipalName?: string;

  @doc("The object identifier of the creator of the virtual machine.")
  @visibility("read")
  createdByUserId?: string;

  @doc("The email address of creator of the virtual machine.")
  @visibility("read")
  createdByUser?: string;

  @doc("The creation date of the virtual machine.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The resource identifier (Microsoft.Compute) of the virtual machine.")
  @visibility("read")
  computeId?: string;

  @doc("The custom image identifier of the virtual machine.")
  customImageId?: string;

  @doc("The OS type of the virtual machine.")
  @visibility("read")
  osType?: string;

  @doc("The size of the virtual machine.")
  size?: string;

  @doc("The user name of the virtual machine.")
  userName?: string;

  @doc("The password of the virtual machine administrator.")
  password?: string;

  @doc("The SSH key of the virtual machine administrator.")
  sshKey?: string;

  @doc("Indicates whether this virtual machine uses an SSH key for authentication.")
  isAuthenticationWithSshKey?: boolean;

  @doc("The fully-qualified domain name of the virtual machine.")
  @visibility("read")
  fqdn?: string;

  @doc("The lab subnet name of the virtual machine.")
  labSubnetName?: string;

  @doc("The lab virtual network identifier of the virtual machine.")
  labVirtualNetworkId?: string;

  @doc("Indicates whether the virtual machine is to be created without a public IP address.")
  disallowPublicIpAddress?: boolean;

  @doc("The artifacts to be installed on the virtual machine.")
  artifacts?: ArtifactInstallProperties[];

  @doc("The artifact deployment status for the virtual machine.")
  @visibility("read")
  artifactDeploymentStatus?: ArtifactDeploymentStatusProperties;

  @doc("The Microsoft Azure Marketplace image reference of the virtual machine.")
  galleryImageReference?: GalleryImageReference;

  @doc("The id of the plan associated with the virtual machine image")
  planId?: string;

  @doc("The compute virtual machine properties.")
  @visibility("read")
  computeVm?: ComputeVmProperties;

  @doc("The network interface properties.")
  networkInterface?: NetworkInterfaceProperties;

  @doc("The applicable schedule for the virtual machine.")
  @visibility("read")
  applicableSchedule?: ApplicableSchedule;

  @doc("The expiration date for VM.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Indicates whether another user can take ownership of the virtual machine")
  allowClaim?: boolean;

  @doc("Storage type to use for virtual machine (i.e. Standard, Premium).")
  storageType?: string;

  @doc("Tells source of creation of lab virtual machine. Output property only.")
  @visibility("read")
  virtualMachineCreationSource?: VirtualMachineCreationSource;

  @doc("The resource ID of the environment that contains this virtual machine, if any.")
  environmentId?: string;

  @doc("New or existing data disks to attach to the virtual machine after creation")
  dataDiskParameters?: DataDiskProperties[];

  @doc("Virtual Machine schedules to be created")
  scheduleParameters?: ScheduleCreationParameter[];

  @doc("Last known compute power state captured in DTL")
  @visibility("read")
  lastKnownPowerState?: string;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Properties of an artifact deployment.")
model ArtifactDeploymentStatusProperties {
  @doc("The deployment status of the artifact.")
  deploymentStatus?: string;

  @doc("The total count of the artifacts that were successfully applied.")
  artifactsApplied?: int32;

  @doc("The total count of the artifacts that were tentatively applied.")
  totalArtifacts?: int32;
}

@doc("Properties of a virtual machine returned by the Microsoft.Compute API.")
model ComputeVmProperties {
  @doc("Gets the statuses of the virtual machine.")
  statuses?: ComputeVmInstanceViewStatus[];

  @doc("Gets the OS type of the virtual machine.")
  osType?: string;

  @doc("Gets the size of the virtual machine.")
  vmSize?: string;

  @doc("Gets the network interface ID of the virtual machine.")
  networkInterfaceId?: string;

  @doc("Gets OS disk blob uri for the virtual machine.")
  osDiskId?: string;

  @doc("Gets data disks blob uri for the virtual machine.")
  dataDiskIds?: string[];

  @doc("Gets all data disks attached to the virtual machine.")
  dataDisks?: ComputeDataDisk[];
}

@doc("Status information about a virtual machine.")
model ComputeVmInstanceViewStatus {
  @doc("Gets the status Code.")
  code?: string;

  @doc("Gets the short localizable label for the status.")
  displayStatus?: string;

  @doc("Gets the message associated with the status.")
  message?: string;
}

@doc("A data disks attached to a virtual machine.")
model ComputeDataDisk {
  @doc("Gets data disk name.")
  name?: string;

  @doc("When backed by a blob, the URI of underlying blob.")
  diskUri?: string;

  @doc("When backed by managed disk, this is the ID of the compute disk resource.")
  managedDiskId?: string;

  @doc("Gets data disk size in GiB.")
  diskSizeGiB?: int32;
}

@doc("A virtual machine.")
model LabVirtualMachineFragment extends UpdateResource {}

@doc("Request body for applying artifacts to a virtual machine.")
model ApplyArtifactsRequest {
  @doc("The list of artifacts to apply.")
  artifacts?: ArtifactInstallProperties[];
}

@doc("Request body for detaching data disk from a virtual machine.")
model DetachDataDiskProperties {
  @doc("Specifies the disk resource ID to detach from virtual machine.")
  existingLabDiskId?: string;
}

@doc("Represents a .rdp file")
model RdpConnection {
  @doc("The contents of the .rdp file")
  contents?: string;
}

@doc("Request body for resizing a virtual machine.")
model ResizeLabVirtualMachineProperties {
  @doc("Specifies the size of the virtual machine.")
  size?: string;
}

@doc("Properties of a virtual network.")
model VirtualNetworkProperties {
  @doc("The allowed subnets of the virtual network.")
  allowedSubnets?: Subnet[];

  @doc("The description of the virtual network.")
  description?: string;

  @doc("The Microsoft.Network resource identifier of the virtual network.")
  externalProviderResourceId?: string;

  @doc("The external subnet properties.")
  @visibility("read")
  externalSubnets?: ExternalSubnet[];

  @doc("The subnet overrides of the virtual network.")
  subnetOverrides?: SubnetOverride[];

  @doc("The creation date of the virtual network.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  @doc("The provisioning status of the resource.")
  @visibility("read")
  provisioningState?: string;

  @doc("The unique immutable identifier of a resource (Guid).")
  @visibility("read")
  uniqueIdentifier?: string;
}

@doc("Subnet information.")
model Subnet {
  @doc("The resource ID of the subnet.")
  resourceId?: string;

  @doc("The name of the subnet as seen in the lab.")
  labSubnetName?: string;

  @doc("The permission policy of the subnet for allowing public IP addresses (i.e. Allow, Deny)).")
  allowPublicIp?: UsagePermissionType;
}

@doc("Subnet information as returned by the Microsoft.Network API.")
model ExternalSubnet {
  @doc("Gets or sets the identifier.")
  id?: string;

  @doc("Gets or sets the name.")
  name?: string;
}

@doc("Property overrides on a subnet of a virtual network.")
model SubnetOverride {
  @doc("The resource ID of the subnet.")
  resourceId?: string;

  @doc("The name given to the subnet within the lab.")
  labSubnetName?: string;

  @doc("Indicates whether this subnet can be used during virtual machine creation (i.e. Allow, Deny).")
  useInVmCreationPermission?: UsagePermissionType;

  @doc("Indicates whether public IP addresses can be assigned to virtual machines on this subnet (i.e. Allow, Deny).")
  usePublicIpAddressPermission?: UsagePermissionType;

  @doc("Properties that virtual machines on this subnet will share.")
  sharedPublicIpAddressConfiguration?: SubnetSharedPublicIpAddressConfiguration;

  @doc("The virtual network pool associated with this subnet.")
  virtualNetworkPoolName?: string;
}

@doc("Configuration for public IP address sharing.")
model SubnetSharedPublicIpAddressConfiguration {
  @doc("Backend ports that virtual machines on this subnet are allowed to expose")
  allowedPorts?: Port[];
}

@doc("Properties of a network port.")
model Port {
  @doc("Protocol type of the port.")
  transportProtocol?: TransportProtocol;

  @doc("Backend port of the target virtual machine.")
  backendPort?: int32;
}

@doc("A virtual network.")
model VirtualNetworkFragment extends UpdateResource {}

@doc("A lab.")
model LabFragment extends UpdateResource {}

@doc("The parameters of the export operation.")
model ExportResourceUsageParameters {
  @doc("The blob storage absolute sas uri with write permission to the container which the usage data needs to be uploaded to.")
  blobStorageAbsoluteSasUri?: string;

  @doc("The start time of the usage. If not provided, usage will be reported since the beginning of data collection.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStartDate?: utcDateTime;
}

@doc("Properties for generating an upload URI.")
model GenerateUploadUriParameter {
  @doc("The blob name of the upload URI.")
  blobName?: string;
}

@doc("Response body for generating an upload URI.")
model GenerateUploadUriResponse {
  @doc("The upload URI for the VHD.")
  uploadUri?: string;
}

@doc("This represents the payload required to import a virtual machine from a different lab into the current one")
model ImportLabVirtualMachineRequest {
  @doc("The full resource ID of the virtual machine to be imported.")
  sourceVirtualMachineResourceId?: string;

  @doc("The name of the virtual machine in the destination lab")
  destinationVirtualMachineName?: string;
}

@doc("The response of a list operation.")
model LabVhdList is Azure.Core.Page<LabVhd>;

@doc("Properties of a VHD in the lab.")
model LabVhd {
  @doc("The URI to the VHD.")
  id?: string;
}

@doc("Properties for retargeting a virtual machine schedule.")
model RetargetScheduleProperties {
  @doc("The resource Id of the virtual machine on which the schedule operates")
  currentResourceId?: string;

  @doc("The resource Id of the virtual machine that the schedule should be retargeted to")
  targetResourceId?: string;
}

@doc("Schedules applicable to a virtual machine. The schedules may have been defined on a VM or on lab level.")
model ApplicableScheduleFragment extends UpdateResource {}

@doc("The REST API operation supported by DevTestLab ResourceProvider.")
model OperationMetadata {
  @doc("Operation name: {provider}/{resource}/{operation}")
  name?: string;

  @doc("The object that describes the operations")
  display?: OperationMetadataDisplay;
}

@doc("The object that describes the operations")
model OperationMetadataDisplay {
  @doc("Friendly name of the resource provider")
  provider?: string;

  @doc("Resource type on which the operation is performed.")
  resource?: string;

  @doc("Operation type: read, write, delete, listKeys/action, etc.")
  operation?: string;

  @doc("Friendly name of the operation")
  description?: string;
}

@doc("Result of the request to list REST API operations")
model ProviderOperationResult {
  @doc("List of operations supported by the resource provider.")
  value?: OperationMetadata[];

  @doc("URL to get the next set of operation list results if there are any.")
  @visibility("read")
  nextLink?: string;
}

@doc("The response of a list operation.")
model ServiceRunnerList {
  @doc("Results of the list operation.")
  value?: ServiceRunner[];

  @doc("Link for next set of results.")
  nextLink?: string;
}

@doc("The contents of a shutdown notification. Webhooks can use this type to deserialize the request body when they get notified of an imminent shutdown.")
model ShutdownNotificationContent {
  @doc("The URL to skip auto-shutdown.")
  skipUrl?: string;

  @doc("The URL to delay shutdown by 60 minutes.")
  delayUrl60?: string;

  @doc("The URL to delay shutdown by 2 hours.")
  delayUrl120?: string;

  @doc("The virtual machine to be shut down.")
  vmName?: string;

  @doc("The GUID for the virtual machine to be shut down.")
  guid?: string;

  @doc("The owner of the virtual machine.")
  owner?: string;

  @doc("The URL of the virtual machine.")
  vmUrl?: string;

  @doc("Minutes remaining until shutdown")
  minutesUntilShutdown?: string;

  @doc("The event for which a notification will be sent.")
  eventType?: string;

  @doc("The text for the notification.")
  text?: string;

  @doc("The subscription ID for the schedule.")
  subscriptionId?: string;

  @doc("The resource group name for the schedule.")
  resourceGroupName?: string;

  @doc("The lab for the schedule.")
  labName?: string;
}
