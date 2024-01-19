import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridCompute;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Indicates which kind of Arc machine placement on-premises, such as HCI, SCVMM or VMware etc.")
enum ArcKindEnum {
  AVS,
  HCI,
  SCVMM,
  VMware,
  EPS,
  GCP,
  AWS,
}

@doc("Specifies the assessment mode.")
enum AssessmentModeTypes {
  ImageDefault,
  AutomaticByPlatform,
}

@doc("Specifies the patch mode.")
enum PatchModeTypes {
  ImageDefault,
  AutomaticByPlatform,
  AutomaticByOS,
  Manual,
}

@doc("Specifies the status of Agent Upgrade.")
enum LastAttemptStatusEnum {
  Success,
  Failed,
}

@doc("Name of configuration mode to use. Modes are pre-defined configurations of security controls, extension allowlists and guest configuration, maintained by Microsoft.")
enum AgentConfigurationMode {
  full,
  monitor,
}

@doc("The license status.")
enum LicenseStatus {
  Unlicensed,
  Licensed,
  OOBGrace,
  OOTGrace,
  NonGenuineGrace,
  Notification,
  ExtendedGrace,
}

@doc("The provisioning state, which only appears in the response.")
enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
  Accepted,
  Canceled,
  Deleted,
}

@doc("The type of the license resource.")
enum LicenseType {
  ESU,
}

@doc("Describes the state of the license.")
enum LicenseState {
  Activated,
  Deactivated,
}

@doc("Describes the license target server.")
enum LicenseTarget {
  `Windows Server 2012`,
  `Windows Server 2012 R2`,
}

@doc("Describes the edition of the license. The values are either Standard or Datacenter.")
enum LicenseEdition {
  Standard,
  Datacenter,
}

@doc("Describes the license core type (pCore or vCore).")
enum LicenseCoreType {
  pCore,
  vCore,
}

@doc("Describes the license assignment state (Assigned or NotAssigned).")
enum LicenseAssignmentState {
  Assigned,
  NotAssigned,
}

@doc("The server types for Esu.")
enum EsuServerType {
  Standard,
  Datacenter,
}

@doc("The ESU eligibility.")
enum EsuEligibility {
  Eligible,
  Ineligible,
  Unknown,
}

@doc("The ESU key state.")
enum EsuKeyState {
  Inactive,
  Active,
}

@doc("Subscription status of the OS or Product feature.")
enum LicenseProfileSubscriptionStatus {
  Unknown,
  Enabling,
  Enabled,
  Disabled,
}

@doc("The product type of the license.")
enum LicenseProfileProductType {
  WindowsServer,
  WindowsIoTEnterprise,
}

@doc("The status of the hybrid machine agent.")
enum StatusTypes {
  Connected,
  Disconnected,
  Error,
}

@doc("The level code.")
enum StatusLevelTypes {
  Info,
  Warning,
  Error,
}

@doc("The overall success or failure status of the operation. It remains \"InProgress\" until the operation completes. At that point it will become \"Unknown\", \"Failed\", \"Succeeded\", or \"CompletedWithWarnings.\"")
enum PatchOperationStatus {
  Unknown,
  InProgress,
  Failed,
  Succeeded,
  CompletedWithWarnings,
}

@doc("Indicates if operation was triggered by user or by platform.")
enum PatchOperationStartedBy {
  User,
  Platform,
}

@doc("Specifies the patch service used for the operation.")
enum PatchServiceUsed {
  Unknown,
  WU,
  WU_WSUS,
  YUM,
  APT,
  Zypper,
}

@doc("The operating system type of the machine.")
enum OsType {
  Windows,
  Linux,
}

@doc("Defines when it is acceptable to reboot a VM during a software update operation.")
enum VMGuestPatchRebootSetting {
  IfRequired,
  Never,
  Always,
}

enum VMGuestPatchClassificationWindows {
  Critical,
  Security,
  UpdateRollUp,
  FeaturePack,
  ServicePack,
  Definition,
  Tools,
  Updates,
}

enum VMGuestPatchClassificationLinux {
  Critical,
  Security,
  Other,
}

@doc("The reboot state of the VM following completion of the operation.")
enum VMGuestPatchRebootStatus {
  Unknown,
  NotNeeded,
  Required,
  Started,
  Failed,
  Completed,
}

@doc("Script execution status.")
enum ExecutionState {
  Unknown,
  Pending,
  Running,
  Failed,
  Succeeded,
  TimedOut,
  Canceled,
}

@doc("The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).")
enum PublicNetworkAccessType {
  @doc("Allows Azure Arc agents to communicate with Azure Arc services over both public (internet) and private endpoints.")
  Enabled,
  @doc("Does not allow Azure Arc agents to communicate with Azure Arc services over public (internet) endpoints. The agents must use the private link.")
  Disabled,
}

@doc("Indicates the new subscription status of the OS or Product Features.")
enum LicenseProfileSubscriptionStatusUpdate {
  Enable,
  Disable,
}

@doc("Type of provisioning issue.")
enum ProvisioningIssueType {
  @doc("Perimeter configuration is missing.") MissingPerimeterConfiguration,
  @doc("Identity configuration is missing.") MissingIdentityConfiguration,
  @doc("Configuration failed to propagate.") ConfigurationPropagationFailure,
  @doc("Other failure.") Other,
}

@doc("Severity of the provisioning issue.")
enum ProvisioningIssueSeverity {
  @doc("Warnings can cause connectivity issues after provisioning succeeds.")
  Warning,
  @doc("Errors will cause association provisioning to fail.") Error,
}

@doc("Indicates direction of an access rule.")
enum AccessRuleDirection {
  @doc("Traffic originates outside of network.") Inbound,
  @doc("Traffic originates inside the network") Outbound,
}

@doc("Property that impacts a resource's logging behavior and its connectivity with other resources and public networks.")
enum AccessMode {
  @doc("Indicates that resource access is controlled by the NSP definition.")
  enforced,
  @doc("Dry run mode, where traffic is evaluated against NSP Rules, logged but not enforced.")
  audit,
  @doc("Enables traffic evaluation to fall back to resource-specific firewall configurations.")
  learning,
}

@doc("The level code.")
@fixed
enum ExtensionsStatusLevelTypes {
  Info,
  Warning,
  Error,
}

@doc("Describes a hybrid machine Update.")
model MachineUpdate extends ResourceUpdate {
  @doc("Identity for the resource.")
  identity?: Identity;

  @doc("Indicates which kind of Arc machine placement on-premises, such as HCI, SCVMM or VMware etc.")
  kind?: ArcKindEnum;

  @doc("Hybrid Compute Machine properties")
  properties?: MachineUpdateProperties;
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

@doc("Describes the ARM updatable properties of a hybrid machine.")
model MachineUpdateProperties {
  @doc("Metadata pertaining to the geographic location of the resource.")
  locationData?: LocationData;

  @doc("Specifies the operating system settings for the hybrid machine.")
  osProfile?: OSProfile;

  @doc("The metadata of the cloud environment (Azure/GCP/AWS/OCI...).")
  cloudMetadata?: CloudMetadata;

  @doc("The info of the machine w.r.t Agent Upgrade")
  agentUpgrade?: AgentUpgrade;

  @doc("The resource id of the parent cluster (Azure HCI) this machine is assigned to, if any.")
  parentClusterResourceId?: ResourceIdentifier;

  @doc("The resource id of the private link scope this machine is assigned to, if any.")
  privateLinkScopeResourceId?: ResourceIdentifier;
}

@doc("Metadata pertaining to the geographic location of the resource.")
model LocationData {
  @doc("A canonical name for the geographic or physical location.")
  @maxLength(256)
  name: string;

  @doc("The city or locality where the resource is located.")
  city?: string;

  @doc("The district, state, or province where the resource is located.")
  district?: string;

  @doc("The country or region where the resource is located")
  countryOrRegion?: string;
}

@doc("Specifies the operating system settings for the hybrid machine.")
model OSProfile {
  @doc("Specifies the host OS name of the hybrid machine.")
  @visibility("read")
  computerName?: string;

  @doc("Specifies the windows configuration for update management.")
  windowsConfiguration?: OSProfileWindowsConfiguration;

  @doc("Specifies the linux configuration for update management.")
  linuxConfiguration?: OSProfileLinuxConfiguration;
}

@doc("Specifies the windows configuration for update management.")
model OSProfileWindowsConfiguration {
  @doc("Specifies the patch settings.")
  patchSettings?: PatchSettings;
}

@doc("Specifies the patch settings.")
model PatchSettings {
  @doc("Specifies the assessment mode.")
  assessmentMode?: AssessmentModeTypes;

  @doc("Specifies the patch mode.")
  patchMode?: PatchModeTypes;
}

@doc("Specifies the linux configuration for update management.")
model OSProfileLinuxConfiguration {
  @doc("Specifies the patch settings.")
  patchSettings?: PatchSettings;
}

@doc("The metadata of the cloud environment (Azure/GCP/AWS/OCI...).")
model CloudMetadata {
  @doc("Specifies the cloud provider (Azure/AWS/GCP...).")
  @visibility("read")
  provider?: string;
}

@doc("The info w.r.t Agent Upgrade.")
model AgentUpgrade {
  @doc("Specifies the version info w.r.t AgentUpgrade for the machine.")
  desiredVersion?: string;

  @doc("The correlation ID passed in from RSM per upgrade.")
  correlationId?: string;

  @doc("Specifies if RSM should try to upgrade this machine")
  enableAutomaticUpgrade?: boolean;

  @doc("Specifies the version of the last attempt")
  @visibility("read")
  lastAttemptDesiredVersion?: string;

  @doc("Timestamp of last upgrade attempt")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAttemptTimestamp?: utcDateTime;

  @doc("Specifies the status of Agent Upgrade.")
  @visibility("read")
  lastAttemptStatus?: LastAttemptStatusEnum;

  @doc("Failure message of last upgrade attempt if any.")
  @visibility("read")
  lastAttemptMessage?: string;
}

@doc("The Update Resource model definition.")
model ResourceUpdate {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Describes the properties of a hybrid machine.")
model MachineProperties {
  @doc("Metadata pertaining to the geographic location of the resource.")
  locationData?: LocationData;

  @doc("Configurable properties that the user can set locally via the azcmagent config command, or remotely via ARM.")
  @visibility("read")
  agentConfiguration?: AgentConfiguration;

  @doc("Statuses of dependent services that are reported back to ARM.")
  serviceStatuses?: ServiceStatuses;

  @doc("The metadata of the cloud environment (Azure/GCP/AWS/OCI...).")
  cloudMetadata?: CloudMetadata;

  @doc("The info of the machine w.r.t Agent Upgrade")
  agentUpgrade?: AgentUpgrade;

  @doc("Specifies the operating system settings for the hybrid machine.")
  osProfile?: OSProfile;

  @doc("Specifies the License related properties for a machine.")
  licenseProfile?: LicenseProfileMachineInstanceView;

  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("The status of the hybrid machine agent.")
  @visibility("read")
  status?: StatusTypes;

  @doc("The time of the last status change.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusChange?: utcDateTime;

  @doc("Details about the error state.")
  @visibility("read")
  errorDetails?: ErrorDetail[];

  @doc("The hybrid machine agent full version.")
  @visibility("read")
  agentVersion?: string;

  @doc("Specifies the hybrid machine unique ID.")
  @visibility("read", "create")
  vmId?: string;

  @doc("Specifies the hybrid machine display name.")
  @visibility("read")
  displayName?: string;

  @doc("Specifies the hybrid machine FQDN.")
  @visibility("read")
  machineFqdn?: string;

  @doc("Public Key that the client provides to be used during initial resource onboarding")
  clientPublicKey?: string;

  @doc("The Operating System running on the hybrid machine.")
  @visibility("read")
  osName?: string;

  @doc("The version of Operating System running on the hybrid machine.")
  @visibility("read")
  osVersion?: string;

  @doc("The type of Operating System (windows/linux).")
  osType?: string;

  @doc("Specifies the Arc Machine's unique SMBIOS ID")
  @visibility("read")
  vmUuid?: string;

  @doc("Machine Extensions information (deprecated field)")
  extensions?: MachineExtensionInstanceView[];

  @doc("Specifies the Operating System product SKU.")
  @visibility("read")
  osSku?: string;

  @doc("The edition of the Operating System.")
  @visibility("read")
  osEdition?: string;

  @doc("Specifies the Windows domain name.")
  @visibility("read")
  domainName?: string;

  @doc("Specifies the AD fully qualified display name.")
  @visibility("read")
  adFqdn?: string;

  @doc("Specifies the DNS fully qualified display name.")
  @visibility("read")
  dnsFqdn?: string;

  @doc("The resource id of the private link scope this machine is assigned to, if any.")
  privateLinkScopeResourceId?: ResourceIdentifier;

  @doc("The resource id of the parent cluster (Azure HCI) this machine is assigned to, if any.")
  parentClusterResourceId?: ResourceIdentifier;

  @doc("Specifies whether any MS SQL instance is discovered on the machine.")
  mssqlDiscovered?: string;

  @doc("Detected properties from the machine.")
  @visibility("read")
  detectedProperties?: Record<string>;

  @doc("Information about the network the machine is on.")
  @visibility("read")
  networkProfile?: NetworkProfile;
}

@doc("Configurable properties that the user can set locally via the azcmagent config command, or remotely via ARM.")
model AgentConfiguration {
  @doc("Specifies the URL of the proxy to be used.")
  @visibility("read")
  proxyUrl?: string;

  @doc("Specifies the list of ports that the agent will be able to listen on.")
  @visibility("read")
  incomingConnectionsPorts?: string[];

  @doc("Array of extensions that are allowed to be installed or updated.")
  @visibility("read")
  extensionsAllowList?: ConfigurationExtension[];

  @doc("Array of extensions that are blocked (cannot be installed or updated)")
  @visibility("read")
  extensionsBlockList?: ConfigurationExtension[];

  @doc("List of service names which should not use the specified proxy server.")
  @visibility("read")
  proxyBypass?: string[];

  @doc("Specifies whether the extension service is enabled or disabled.")
  @visibility("read")
  extensionsEnabled?: string;

  @doc("Specified whether the guest configuration service is enabled or disabled.")
  @visibility("read")
  guestConfigurationEnabled?: string;

  @doc("Name of configuration mode to use. Modes are pre-defined configurations of security controls, extension allowlists and guest configuration, maintained by Microsoft.")
  @visibility("read")
  configMode?: AgentConfigurationMode;
}

@doc("Describes properties that can identify extensions.")
model ConfigurationExtension {
  @doc("Publisher of the extension.")
  @visibility("read")
  publisher?: string;

  @doc("Type of the extension.")
  @visibility("read")
  type?: string;
}

@doc("Reports the state and behavior of dependent services.")
model ServiceStatuses {
  @doc("The state of the extension service on the Arc-enabled machine.")
  extensionService?: ServiceStatus;

  @doc("The state of the guest configuration service on the Arc-enabled machine.")
  guestConfigurationService?: ServiceStatus;
}

@doc("Describes the status and behavior of a service.")
model ServiceStatus {
  @doc("The current status of the service.")
  status?: string;

  @doc("The behavior of the service when the Arc-enabled machine starts up.")
  startupType?: string;
}

@doc("License Profile Instance View in Machine Properties.")
model LicenseProfileMachineInstanceView {
  @doc("Indicates the license status of the OS.")
  @visibility("read")
  licenseStatus?: LicenseStatus;

  @doc("Indicates the license channel.")
  @visibility("read")
  licenseChannel?: string;

  @visibility("read")
  softwareAssurance?: LicenseProfileMachineInstanceViewSoftwareAssurance;

  @doc("Properties for the Machine ESU profile.")
  esuProfile?: LicenseProfileMachineInstanceViewEsuProperties;

  @doc("Hybrid Compute Product Profile properties")
  @visibility("read")
  productProfile?: LicenseProfileArmProductProfileProperties;
}

model LicenseProfileMachineInstanceViewSoftwareAssurance {
  @doc("Specifies if this machine is licensed as part of a Software Assurance agreement.")
  softwareAssuranceCustomer?: boolean;
}

@doc("Properties for the Machine ESU profile.")
model LicenseProfileMachineInstanceViewEsuProperties
  extends LicenseProfileArmEsuPropertiesWithoutAssignedLicense {
  @doc("The assigned license resource.")
  assignedLicense?: License;

  @doc("Describes the license assignment state (Assigned or NotAssigned).")
  licenseAssignmentState?: LicenseAssignmentState;
}

@doc("Describes a license in a hybrid machine.")
model License extends TrackedResource {
  @doc("Hybrid Compute License properties")
  properties?: LicenseProperties;
}

@doc("Describes the properties of a License Profile.")
model LicenseProperties {
  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Describes the tenant id.")
  tenantId?: string;

  @doc("The type of the license resource.")
  licenseType?: LicenseType;

  @doc("Describes the properties of a License.")
  licenseDetails?: LicenseDetails;
}

@doc("Describes the properties of a License.")
model LicenseDetails {
  @doc("Describes the state of the license.")
  state?: LicenseState;

  @doc("Describes the license target server.")
  target?: LicenseTarget;

  @doc("Describes the edition of the license. The values are either Standard or Datacenter.")
  edition?: LicenseEdition;

  @doc("Describes the license core type (pCore or vCore).")
  type?: LicenseCoreType;

  @doc("Describes the number of processors.")
  processors?: int32;

  @doc("Describes the number of assigned licenses.")
  @visibility("read")
  assignedLicenses?: int32;

  @doc("Describes the immutable id.")
  @visibility("read")
  immutableId?: string;
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

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Describes the properties of a License Profile ARM model.")
model LicenseProfileArmEsuPropertiesWithoutAssignedLicense
  extends LicenseProfileStorageModelEsuProperties {
  @doc("The type of the Esu servers.")
  @visibility("read")
  serverType?: EsuServerType;

  @doc("Indicates the eligibility state of Esu.")
  @visibility("read")
  esuEligibility?: EsuEligibility;

  @doc("Indicates whether there is an ESU Key currently active for the machine.")
  @visibility("read")
  esuKeyState?: EsuKeyState;
}

@doc("License profile storage model for ESU properties.")
model LicenseProfileStorageModelEsuProperties {
  @doc("The guid id of the license.")
  @visibility("read")
  assignedLicenseImmutableId?: string;

  @doc("The list of ESU keys.")
  @visibility("read")
  esuKeys?: EsuKey[];
}

@doc("ESU key")
model EsuKey {
  @doc("SKU number.")
  sku?: string;

  @doc("The current status of the license profile key.")
  licenseStatus?: string;
}

@doc("Describes the properties of a Product License Profile ARM model.")
model LicenseProfileArmProductProfileProperties {
  @doc("Indicates the subscription status of the product.")
  subscriptionStatus?: LicenseProfileSubscriptionStatus;

  @doc("Indicates the product type of the license.")
  productType?: LicenseProfileProductType;

  @doc("The timestamp in UTC when the billing starts.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingStartDate?: utcDateTime;

  @doc("The timestamp in UTC when the user enrolls the feature.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentDate?: utcDateTime;

  @doc("The timestamp in UTC when the user disenrolled the feature.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  disenrollmentDate?: utcDateTime;

  @doc("The list of product features.")
  productFeatures?: ProductFeature[];
}

@doc("Product Feature")
model ProductFeature {
  @doc("Product feature name.")
  name?: string;

  @doc("Indicates the current status of the product features.")
  subscriptionStatus?: LicenseProfileSubscriptionStatus;

  @doc("The timestamp in UTC when the billing starts.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingStartDate?: utcDateTime;

  @doc("The timestamp in UTC when the user enrolls the feature.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentDate?: utcDateTime;

  @doc("The timestamp in UTC when the user disenrolled the feature.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  disenrollmentDate?: utcDateTime;
}

@doc("Describes the Machine Extension Instance View.")
model MachineExtensionInstanceView {
  @doc("The machine extension name.")
  name?: string;

  @doc("Specifies the type of the extension; an example is \"CustomScriptExtension\".")
  type?: string;

  @doc("Specifies the version of the script handler.")
  typeHandlerVersion?: string;

  @doc("Instance view status.")
  status?: MachineExtensionInstanceViewStatus;
}

@doc("Instance view status.")
model MachineExtensionInstanceViewStatus {
  @doc("The status code.")
  code?: string;

  @doc("The level code.")
  level?: StatusLevelTypes;

  @doc("The short localizable label for the status.")
  displayStatus?: string;

  @doc("The detailed status message, including for alerts and error messages.")
  message?: string;

  @doc("The time of the status.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

@doc("Describes the network information on this machine.")
model NetworkProfile {
  @doc("The list of network interfaces.")
  networkInterfaces?: NetworkInterface[];
}

@doc("Describes a network interface.")
model NetworkInterface {
  @doc("The list of IP addresses in this interface.")
  ipAddresses?: IpAddress[];
}

@doc("Describes properties of the IP address.")
model IpAddress {
  @doc("Represents the IP Address.")
  address?: string;

  @doc("Represents the Ip Address Version.")
  ipAddressVersion?: string;

  @doc("The subnet to which this IP address belongs.")
  @visibility("read")
  subnet?: Subnet;
}

@doc("Describes the subnet.")
model Subnet {
  @doc("Represents address prefix.")
  addressPrefix?: string;
}

@doc("Describes the properties of a Machine Extension.")
model MachineExtensionProperties {
  @doc("How the extension handler should be forced to update even if the extension configuration has not changed.")
  forceUpdateTag?: string;

  @doc("The name of the extension handler publisher.")
  publisher?: string;

  @doc("Specifies the type of the extension; an example is \"CustomScriptExtension\".")
  type?: string;

  @doc("Specifies the version of the script handler.")
  typeHandlerVersion?: string;

  @doc("Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.")
  enableAutomaticUpgrade?: boolean;

  @doc("Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.")
  autoUpgradeMinorVersion?: boolean;

  @doc("Json formatted public settings for the extension.")
  settings?: Record<unknown>;

  @doc("The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.")
  protectedSettings?: Record<unknown>;

  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("The machine extension instance view.")
  instanceView?: MachineExtensionInstanceView;
}

@doc("Describes the properties of an AssessPatches result.")
model MachineAssessPatchesResult {
  @doc("The overall success or failure status of the operation. It remains \"InProgress\" until the operation completes. At that point it will become \"Unknown\", \"Failed\", \"Succeeded\", or \"CompletedWithWarnings.\"")
  @visibility("read")
  status?: PatchOperationStatus;

  @doc("The activity ID of the operation that produced this result.")
  @visibility("read")
  assessmentActivityId?: string;

  @doc("The overall reboot status of the VM. It will be true when partially installed patches require a reboot to complete installation but the reboot has not yet occurred.")
  @visibility("read")
  rebootPending?: boolean;

  @doc("Summarization of patches available for installation on the machine by classification.")
  availablePatchCountByClassification?: AvailablePatchCountByClassification;

  @doc("The UTC timestamp when the operation began.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  @doc("The UTC timestamp when the operation finished.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  @doc("Indicates if operation was triggered by user or by platform.")
  @visibility("read")
  startedBy?: PatchOperationStartedBy;

  @doc("Specifies the patch service used for the operation.")
  @visibility("read")
  patchServiceUsed?: PatchServiceUsed;

  @doc("The operating system type of the machine.")
  @visibility("read")
  osType?: OsType;

  @doc("The errors that were encountered during execution of the operation. The details array contains the list of them.")
  @visibility("read")
  errorDetails?: ErrorDetail;
}

@doc("Summarization of patches available for installation on the machine by classification.")
model AvailablePatchCountByClassification {
  @doc("Number of security patches available for installation.")
  @visibility("read")
  security?: int32;

  @doc("Number of critical patches available for installation.")
  @visibility("read")
  critical?: int32;

  @doc("Number of definition patches available for installation.")
  @visibility("read")
  definition?: int32;

  @doc("Number of update Rollup patches available for installation.")
  @visibility("read")
  updateRollup?: int32;

  @doc("Number of feature pack patches available for installation.")
  @visibility("read")
  featurePack?: int32;

  @doc("Number of service pack patches available for installation.")
  @visibility("read")
  servicePack?: int32;

  @doc("Number of tools patches available for installation.")
  @visibility("read")
  tools?: int32;

  @doc("Number of updates category patches available for installation.")
  @visibility("read")
  updates?: int32;

  @doc("Number of other patches available for installation.")
  @visibility("read")
  other?: int32;
}

@doc("Input for InstallPatches as directly received by the API")
model MachineInstallPatchesParameters {
  @doc("Specifies the maximum amount of time that the operation will run. It must be an ISO 8601-compliant duration string such as PT4H (4 hours)")
  maximumDuration: duration;

  @doc("Defines when it is acceptable to reboot a VM during a software update operation.")
  rebootSetting: VMGuestPatchRebootSetting;

  @doc("Input for InstallPatches on a Windows VM, as directly received by the API")
  windowsParameters?: WindowsParameters;

  @doc("Input for InstallPatches on a Linux VM, as directly received by the API")
  linuxParameters?: LinuxParameters;
}

@doc("Input for InstallPatches on a Windows VM, as directly received by the API")
model WindowsParameters {
  @doc("The update classifications to select when installing patches for Windows.")
  classificationsToInclude?: VMGuestPatchClassificationWindows[];

  @doc("Kbs to include in the patch operation")
  kbNumbersToInclude?: string[];

  @doc("Kbs to exclude in the patch operation")
  kbNumbersToExclude?: string[];

  @doc("Filters out Kbs that don't have an InstallationRebootBehavior of 'NeverReboots' when this is set to true.")
  excludeKbsRequiringReboot?: boolean;

  @doc("This is used to install patches that were published on or before this given max published date.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maxPatchPublishDate?: utcDateTime;
}

@doc("Input for InstallPatches on a Linux VM, as directly received by the API")
model LinuxParameters {
  @doc("The update classifications to select when installing patches for Linux.")
  classificationsToInclude?: VMGuestPatchClassificationLinux[];

  @doc("packages to include in the patch operation. Format: packageName_packageVersion")
  packageNameMasksToInclude?: string[];

  @doc("packages to exclude in the patch operation. Format: packageName_packageVersion")
  packageNameMasksToExclude?: string[];
}

@doc("The result summary of an installation operation.")
model MachineInstallPatchesResult {
  @doc("The overall success or failure status of the operation. It remains \"InProgress\" until the operation completes. At that point it will become \"Failed\", \"Succeeded\", \"Unknown\" or \"CompletedWithWarnings.\"")
  @visibility("read")
  status?: PatchOperationStatus;

  @doc("The activity ID of the operation that produced this result.")
  @visibility("read")
  installationActivityId?: string;

  @doc("The reboot state of the VM following completion of the operation.")
  @visibility("read")
  rebootStatus?: VMGuestPatchRebootStatus;

  @doc("Whether the operation ran out of time before it completed all its intended actions.")
  @visibility("read")
  maintenanceWindowExceeded?: boolean;

  @doc("The number of patches that were not installed due to the user blocking their installation.")
  @visibility("read")
  excludedPatchCount?: int32;

  @doc("The number of patches that were detected as available for install, but did not meet the operation's criteria.")
  @visibility("read")
  notSelectedPatchCount?: int32;

  @doc("The number of patches that were identified as meeting the installation criteria, but were not able to be installed. Typically this happens when maintenanceWindowExceeded == true.")
  @visibility("read")
  pendingPatchCount?: int32;

  @doc("The number of patches successfully installed.")
  @visibility("read")
  installedPatchCount?: int32;

  @doc("The number of patches that could not be installed due to some issue. See errors for details.")
  @visibility("read")
  failedPatchCount?: int32;

  @doc("The UTC timestamp when the operation began.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  @doc("The UTC timestamp when the operation finished.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  @doc("Indicates if operation was triggered by user or by platform.")
  @visibility("read")
  startedBy?: PatchOperationStartedBy;

  @doc("Specifies the patch service used for the operation.")
  @visibility("read")
  patchServiceUsed?: PatchServiceUsed;

  @doc("The operating system type of the machine.")
  @visibility("read")
  osType?: OsType;

  @doc("The errors that were encountered during execution of the operation. The details array contains the list of them.")
  @visibility("read")
  errorDetails?: ErrorDetail;
}

@doc("Describes a Machine Extension Update.")
model MachineExtensionUpdate extends ResourceUpdate {
  @doc("Describes Machine Extension Update Properties.")
  properties?: MachineExtensionUpdateProperties;
}

@doc("Describes the properties of a Machine Extension.")
model MachineExtensionUpdateProperties {
  @doc("How the extension handler should be forced to update even if the extension configuration has not changed.")
  forceUpdateTag?: string;

  @doc("The name of the extension handler publisher.")
  publisher?: string;

  @doc("Specifies the type of the extension; an example is \"CustomScriptExtension\".")
  type?: string;

  @doc("Specifies the version of the script handler.")
  typeHandlerVersion?: string;

  @doc("Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.")
  enableAutomaticUpgrade?: boolean;

  @doc("Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.")
  autoUpgradeMinorVersion?: boolean;

  @doc("Json formatted public settings for the extension.")
  settings?: Record<unknown>;

  @doc("The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.")
  protectedSettings?: Record<unknown>;
}

@doc("Describes the Machine Extension Upgrade Properties.")
model MachineExtensionUpgrade {
  @doc("Describes the Extension Target Properties.")
  extensionTargets?: Record<ExtensionTargetProperties>;
}

@doc("Describes the Machine Extension Target Version Properties")
model ExtensionTargetProperties {
  @doc("Properties for the specified Extension to Upgrade.")
  targetVersion?: string;
}

@doc("Describes Extension Metadata properties")
model ExtensionValueProperties {
  @doc("The version of the Extension being received.")
  @visibility("read")
  version?: string;

  @doc("The type of the Extension being received.")
  @visibility("read")
  extensionType?: string;

  @doc("The publisher of the Extension being received.")
  @visibility("read")
  publisher?: string;
}

@doc("Describes the properties of a Compute Operation value.")
model OperationValue {
  @doc("The origin of the compute operation.")
  @visibility("read")
  origin?: string;

  @doc("The name of the compute operation.")
  @visibility("read")
  name?: string;

  @doc("Display properties")
  display?: OperationValueDisplay;

  @doc("This property indicates if the operation is an action or a data action")
  @visibility("read")
  isDataAction?: boolean;
}

@doc("Describes the properties of a Hybrid Compute Operation Value Display.")
model OperationValueDisplay {
  @doc("The display name of the compute operation.")
  @visibility("read")
  operation?: string;

  @doc("The display name of the resource the operation applies to.")
  @visibility("read")
  resource?: string;

  @doc("The description of the operation.")
  @visibility("read")
  description?: string;

  @doc("The resource provider for the operation.")
  @visibility("read")
  provider?: string;
}

@doc("Describes the properties of a run command.")
model MachineRunCommandProperties {
  @doc("The source of the run command script.")
  source?: MachineRunCommandScriptSource;

  @doc("The parameters used by the script.")
  parameters?: RunCommandInputParameter[];

  @doc("The parameters used by the script.")
  protectedParameters?: RunCommandInputParameter[];

  @doc("Optional. If set to true, provisioning will complete as soon as script starts and will not wait for script to complete.")
  asyncExecution?: boolean;

  @doc("Specifies the user account on the machine when executing the run command.")
  runAsUser?: string;

  @doc("Specifies the user account password on the machine when executing the run command.")
  runAsPassword?: string;

  @doc("The timeout in seconds to execute the run command.")
  timeoutInSeconds?: int32;

  @doc("Specifies the Azure storage blob where script output stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer outputBlobManagedIdentity parameter. ")
  outputBlobUri?: string;

  @doc("Specifies the Azure storage blob where script error stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer errorBlobManagedIdentity parameter.")
  errorBlobUri?: string;

  @doc("User-assigned managed identity that has access to outputBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged ")
  outputBlobManagedIdentity?: RunCommandManagedIdentity;

  @doc("User-assigned managed identity that has access to errorBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged ")
  errorBlobManagedIdentity?: RunCommandManagedIdentity;

  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("The machine run command instance view.")
  @visibility("read")
  instanceView?: MachineRunCommandInstanceView;
}

@doc("Describes the script sources for run command. Use only one of script, scriptUri, commandId.")
model MachineRunCommandScriptSource {
  @doc("Specifies the script content to be executed on the machine.")
  script?: string;

  @doc("Specifies the script download location. It can be either SAS URI of an Azure storage blob with read access or public URI.")
  scriptUri?: string;

  @doc("Specifies the commandId of predefined built-in script.")
  commandId?: string;

  @doc("User-assigned managed identity that has access to scriptUri in case of Azure storage blob. Use an empty object in case of system-assigned identity. Make sure the Azure storage blob exists, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.")
  scriptUriManagedIdentity?: RunCommandManagedIdentity;
}

@doc(" Contains clientId or objectId (use only one, not both) of a user-assigned managed identity that has access to storage blob used in Run Command. Use an empty RunCommandManagedIdentity object in case of system-assigned identity. Make sure the Azure storage blob exists in case of scriptUri, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment with scriptUri blob and 'Storage Blob Data Contributor' for Append blobs(outputBlobUri, errorBlobUri). In case of user assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.")
model RunCommandManagedIdentity {
  @doc("Client Id (GUID value) of the user-assigned managed identity. ObjectId should not be used if this is provided.")
  clientId?: string;

  @doc("Object Id (GUID value) of the user-assigned managed identity. ClientId should not be used if this is provided.")
  objectId?: string;
}

@doc("Describes the properties of a run command parameter.")
model RunCommandInputParameter {
  @doc("The run command parameter name.")
  name: string;

  @doc("The run command parameter value.")
  value: string;
}

@doc("The instance view of a machine run command.")
model MachineRunCommandInstanceView {
  @doc("Script execution status.")
  executionState?: ExecutionState;

  @doc("Communicate script configuration errors or execution messages.")
  executionMessage?: string;

  @doc("Exit code returned from script execution.")
  exitCode?: int32;

  @doc("Script output stream.")
  output?: string;

  @doc("Script error stream.")
  error?: string;

  @doc("Script start time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  @doc("Script end time.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  @doc("The  status information.")
  statuses?: ExtensionsResourceStatus[];
}

@doc("Instance view status.")
model ExtensionsResourceStatus {
  @doc("The status code.")
  code?: string;

  @doc("The level code.")
  level?: ExtensionsStatusLevelTypes;

  @doc("The short localizable label for the status.")
  displayStatus?: string;

  @doc("The detailed status message, including for alerts and error messages.")
  message?: string;

  @doc("The time of the status.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

@doc("Properties that define a Azure Arc PrivateLinkScope resource.")
model HybridComputePrivateLinkScopeProperties {
  @doc("Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints.")
  publicNetworkAccess?: PublicNetworkAccessType;

  @doc("Current state of this PrivateLinkScope: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.")
  @visibility("read")
  provisioningState?: string;

  @doc("The Guid id of the private link scope.")
  @visibility("read")
  privateLinkScopeId?: string;

  @doc("The collection of associated Private Endpoint Connections.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDataModel[];
}

@doc("The Data Model for a Private Endpoint Connection associated with a Private Link Scope")
model PrivateEndpointConnectionDataModel {
  @doc("The ARM Resource Id of the Private Endpoint.")
  @visibility("read")
  id?: string;

  @doc("The Name of the Private Endpoint.")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("The Private Endpoint Connection properties.")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of a private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("Private endpoint which the connection belongs to.")
  privateEndpoint?: PrivateEndpointProperty;

  @doc("Connection state of the private endpoint connection.")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionStateProperty;

  @doc("State of the private endpoint connection.")
  @visibility("read")
  provisioningState?: string;

  @doc("List of group IDs.")
  @visibility("read")
  groupIds?: string[];
}

@doc("Private endpoint which the connection belongs to.")
model PrivateEndpointProperty {
  @doc("Resource id of the private endpoint.")
  id?: string;
}

@doc("State of the private endpoint connection.")
model PrivateLinkServiceConnectionStateProperty {
  @doc("The private link service connection status.")
  status: string;

  @doc("The private link service connection description.")
  description: string;

  @doc("The actions required for private link service connection.")
  @visibility("read")
  actionsRequired?: string;
}

@doc("An azure resource object")
model PrivateLinkScopesResource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location: string;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("A container holding only the Tags for a resource, allowing the user to update the tags on a PrivateLinkScope instance.")
model TagsResource {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("Required DNS zone names of the the private link resource.")
  @visibility("read")
  requiredZoneNames?: string[];
}

model PrivateLinkScopeValidationDetails {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints.")
  publicNetworkAccess?: PublicNetworkAccessType;

  @doc("List of Private Endpoint Connection details.")
  connectionDetails?: ConnectionDetail[];
}

model ConnectionDetail {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("The private endpoint connection private ip address")
  @visibility("read")
  privateIpAddress?: string;

  @doc("The private endpoint connection link identifier")
  @visibility("read")
  linkIdentifier?: string;

  @doc("The private endpoint connection group id")
  @visibility("read")
  groupId?: string;

  @doc("The private endpoint connection member name")
  @visibility("read")
  memberName?: string;
}

@doc("Describes a License Update.")
model LicenseUpdate extends ResourceUpdate {
  @doc("License Update properties")
  properties?: LicenseUpdateProperties;
}

@doc("Describes the Update properties of a License Profile.")
model LicenseUpdateProperties {
  @doc("The type of the license resource.")
  licenseType?: LicenseType;

  licenseDetails?: LicenseUpdatePropertiesLicenseDetails;
}

model LicenseUpdatePropertiesLicenseDetails {
  @doc("Describes the state of the license.")
  state?: LicenseState;

  @doc("Describes the license target server.")
  target?: LicenseTarget;

  @doc("Describes the edition of the license. The values are either Standard or Datacenter.")
  edition?: LicenseEdition;

  @doc("Describes the license core type (pCore or vCore).")
  type?: LicenseCoreType;

  @doc("Describes the number of processors.")
  processors?: int32;
}

@doc("The List license operation response.")
model LicensesListResult {
  @doc("The list of licenses.")
  value: License[];

  @doc("The URI to fetch the next page of Machines. Call ListNext() with this URI to fetch the next page of license profile.")
  nextLink?: string;
}

@doc("Describes a license profile in a hybrid machine.")
model LicenseProfile extends TrackedResource {
  @doc("Describe the properties of a license profile.")
  properties?: LicenseProfileProperties;
}

@doc("Describe the properties of a license profile.")
model LicenseProfileProperties {
  softwareAssurance?: LicenseProfilePropertiesSoftwareAssurance;

  @doc("Hybrid Compute ESU Profile properties")
  esuProfile?: LicenseProfileArmEsuProperties;

  @doc("Hybrid Compute Product Profile properties")
  productProfile?: LicenseProfileArmProductProfileProperties;

  @doc("The provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model LicenseProfilePropertiesSoftwareAssurance {
  @doc("Specifies if this machine is licensed as part of a Software Assurance agreement.")
  softwareAssuranceCustomer?: boolean;
}

@doc("Describes the properties of a License Profile ARM model.")
model LicenseProfileArmEsuProperties
  extends LicenseProfileArmEsuPropertiesWithoutAssignedLicense {
  @doc("The resource id of the license.")
  assignedLicense?: string;
}

@doc("Describes a License Profile Update.")
model LicenseProfileUpdate extends ResourceUpdate {
  @doc("Describe the Update properties of a license profile.")
  properties?: LicenseProfileUpdateProperties;
}

@doc("Describe the Update properties of a license profile.")
model LicenseProfileUpdateProperties {
  softwareAssurance?: LicenseProfileUpdatePropertiesSoftwareAssurance;

  @doc("Hybrid Compute ESU Profile Update properties")
  esuProfile?: EsuProfileUpdateProperties;

  @doc("Hybrid Compute Product Profile Update properties")
  productProfile?: ProductProfileUpdateProperties;
}

model LicenseProfileUpdatePropertiesSoftwareAssurance {
  @doc("Specifies if this machine is licensed as part of a Software Assurance agreement.")
  softwareAssuranceCustomer?: boolean;
}

@doc("Describes the Update properties of a ESU License Profile.")
model EsuProfileUpdateProperties {
  @doc("The resource id of the license.")
  assignedLicense?: string;
}

@doc("Describes the Update properties of a Product Profile.")
model ProductProfileUpdateProperties {
  @doc("Indicates the subscription status of the product.")
  subscriptionStatus?: LicenseProfileSubscriptionStatusUpdate;

  @doc("Indicates the product type of the license.")
  productType?: LicenseProfileProductType;

  @doc("The list of product feature updates.")
  productFeatures?: ProductFeatureUpdate[];
}

@doc("Product Feature")
model ProductFeatureUpdate {
  @doc("Product feature name.")
  name?: string;

  @doc("Indicates the new status of the product feature.")
  subscriptionStatus?: LicenseProfileSubscriptionStatusUpdate;
}

@doc("The List hybrid machine license profile operation response.")
model LicenseProfilesListResult {
  @doc("The list of license profiles.")
  value: LicenseProfile[];

  @doc("The URI to fetch the next page of Machines. Call ListNext() with this URI to fetch the next page of license profile.")
  nextLink?: string;
}

@doc("List of HybridIdentityMetadata.")
model HybridIdentityMetadataList {
  @doc("Url to follow for getting next page of HybridIdentityMetadata.")
  nextLink?: string;

  @doc("Array of HybridIdentityMetadata")
  value: HybridIdentityMetadata[];
}

@doc("Defines the HybridIdentityMetadata.")
model HybridIdentityMetadata extends ProxyResource {
  @doc("Resource properties.")
  properties: HybridIdentityMetadataProperties;
}

@doc("Defines the resource properties.")
model HybridIdentityMetadataProperties {
  @doc("The unique identifier for the resource.")
  vmId?: string;

  @doc("The Public Key.")
  publicKey?: string;

  @doc("Identity for the resource.")
  @visibility("read")
  identity?: Identity;
}

@doc("Describes AgentVersions List.")
model AgentVersionsList {
  @doc("The list of available Agent Versions.")
  value?: AgentVersion[];

  @doc("The URI to fetch the next 10 available Agent Versions.")
  nextLink?: string;
}

@doc("Describes properties of Agent Version.")
model AgentVersion {
  @doc("Represents the agent version.")
  agentVersion?: string;

  @doc("Represents the download link of specific agent version.")
  downloadLink?: string;

  @doc("Defines the os type.")
  osType?: string;
}

@doc("Describes a Machine Extension Update.")
model MachineRunCommandUpdate extends ResourceUpdate {}

model NetworkConfiguration extends ProxyResource {
  @doc("Network configuration properties")
  properties?: NetworkConfigurationProperties;
}

@doc("Network configuration properties")
model NetworkConfigurationProperties {
  @doc("Resource location")
  @visibility("read", "create")
  location?: string;

  @doc("Azure resource tenant Id")
  @visibility("read")
  tenantId?: string;

  @doc("Associated Network Configuration Scope Id (GUID)")
  networkConfigurationScopeId?: string;

  @doc("Associated Network Configuration Scope Resource Id")
  networkConfigurationScopeResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/privateLinkScopes";
    }
  ]>;

  @doc("Public key information for client authentication")
  @visibility("read")
  keyProperties?: KeyProperties;
}

@doc("Public key information for client authentication")
model KeyProperties {
  @doc("Current public key details")
  @visibility("read")
  clientPublicKey?: KeyDetails;

  @doc("Candidate public key details")
  @visibility("read")
  candidatePublicKey?: KeyDetails;
}

@doc("Public key details")
model KeyDetails {
  @doc("Public key")
  @visibility("read")
  publicKey?: string;

  @doc("Key expiration date")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  @doc("Recommended key renewal date")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  renewAfter?: utcDateTime;
}

@doc("Properties that define a Network Security Perimeter resource.")
model NetworkSecurityPerimeterConfiguration {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Properties that define a Network Security Perimeter resource.")
  properties?: NetworkSecurityPerimeterConfigurationProperties;
}

@doc("Properties that define a Network Security Perimeter resource.")
model NetworkSecurityPerimeterConfigurationProperties {
  @doc("Current state of this NetworkSecurityPerimeter: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.")
  @visibility("read")
  provisioningState?: string;

  @doc("Provisioning issues.")
  @visibility("read")
  provisioningIssues?: ProvisioningIssue[];

  @doc("The Network Security Perimeter associated with this configuration.")
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  @doc("The Resource Association.")
  resourceAssociation?: ResourceAssociation;

  @doc("Network Security Perimeter profile")
  profile?: NetworkSecurityPerimeterProfile;
}

@doc("Details on issues that occurred during provisioning.")
model ProvisioningIssue {
  @doc("Name of the provisioning issue.")
  @visibility("read")
  name?: string;

  @doc("Provisioning issue properties")
  @visibility("read")
  properties?: ProvisioningIssueProperties;
}

@doc("Properties of a provisioning issue.")
model ProvisioningIssueProperties {
  @doc("Issue type")
  @visibility("read")
  issueType?: ProvisioningIssueType;

  @doc("Severity of the provisioning issue.")
  @visibility("read")
  severity?: ProvisioningIssueSeverity;

  @doc("Description of the provisioning issue.")
  @visibility("read")
  description?: string;

  @doc("ARM Ids of the resources that can be associated to the same perimeter to remediate the issue")
  @visibility("read")
  suggestedResourceIds?: string[];

  @doc("Access rules that can be added to the perimeter to remediate the issue")
  @visibility("read")
  suggestedAccessRules?: AccessRule[];
}

@doc("Access rule.")
model AccessRule {
  @doc("Name of the access rule.")
  @visibility("read")
  name?: string;

  @doc("Access rule properties")
  @visibility("read")
  properties?: AccessRuleProperties;
}

@doc("Properties of an access rule.")
model AccessRuleProperties {
  @doc("Direction of the access rule.")
  @visibility("read")
  direction?: AccessRuleDirection;

  @doc("Address prefixes that are allowed access.")
  @visibility("read")
  addressPrefixes?: string[];
}

@doc("Properties that define a Network Security Perimeter resource.")
model NetworkSecurityPerimeter {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Guid of the Network Security Perimeter")
  @visibility("read")
  perimeterGuid?: string;

  @doc("Regional location of the perimeter")
  @visibility("read")
  location?: string;
}

@doc("Properties that define a Resource Association.")
model ResourceAssociation {
  @doc("Name of the Resource Association")
  @visibility("read")
  name?: string;

  @doc("The access mode")
  @visibility("read")
  accessMode?: AccessMode;
}

@doc("Network Security Perimeter profile")
model NetworkSecurityPerimeterProfile {
  @doc("Name of the resource")
  @visibility("read")
  name?: string;

  @doc("Access rules version number")
  @visibility("read")
  accessRulesVersion?: string;

  @doc("Collection of access rules for the profile")
  @visibility("read")
  accessRules?: AccessRule[];

  @doc("Diagnostic settings version number")
  @visibility("read")
  diagnosticSettingsVersion?: string;

  @doc("Collection of enabled log categories for the profile")
  @visibility("read")
  enabledLogCategories?: string[];
}

@doc("A list of network security perimeter configurations.")
model NetworkSecurityPerimeterConfigurationListResult {
  @doc("Array of results.")
  @visibility("read")
  value?: NetworkSecurityPerimeterConfiguration[];

  @doc("Link to retrieve next page of results.")
  @visibility("read")
  nextLink?: string;
}
