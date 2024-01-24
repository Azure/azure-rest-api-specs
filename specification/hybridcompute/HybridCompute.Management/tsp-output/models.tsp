import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridCompute;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Indicates which kind of Arc machine placement on-premises, such as HCI, SCVMM or VMware etc.
 */
enum ArcKindEnum {
  AVS,
  HCI,
  SCVMM,
  VMware,
  EPS,
  GCP,
  AWS,
}

/**
 * Specifies the assessment mode.
 */
enum AssessmentModeTypes {
  ImageDefault,
  AutomaticByPlatform,
}

/**
 * Specifies the patch mode.
 */
enum PatchModeTypes {
  ImageDefault,
  AutomaticByPlatform,
  AutomaticByOS,
  Manual,
}

/**
 * Specifies the status of Agent Upgrade.
 */
enum LastAttemptStatusEnum {
  Success,
  Failed,
}

/**
 * Name of configuration mode to use. Modes are pre-defined configurations of security controls, extension allowlists and guest configuration, maintained by Microsoft.
 */
enum AgentConfigurationMode {
  full,
  monitor,
}

/**
 * The license status.
 */
enum LicenseStatus {
  Unlicensed,
  Licensed,
  OOBGrace,
  OOTGrace,
  NonGenuineGrace,
  Notification,
  ExtendedGrace,
}

/**
 * The provisioning state, which only appears in the response.
 */
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

/**
 * The type of the license resource.
 */
enum LicenseType {
  ESU,
}

/**
 * Describes the state of the license.
 */
enum LicenseState {
  Activated,
  Deactivated,
}

/**
 * Describes the license target server.
 */
enum LicenseTarget {
  `Windows Server 2012`,
  `Windows Server 2012 R2`,
}

/**
 * Describes the edition of the license. The values are either Standard or Datacenter.
 */
enum LicenseEdition {
  Standard,
  Datacenter,
}

/**
 * Describes the license core type (pCore or vCore).
 */
enum LicenseCoreType {
  pCore,
  vCore,
}

/**
 * Describes the license assignment state (Assigned or NotAssigned).
 */
enum LicenseAssignmentState {
  Assigned,
  NotAssigned,
}

/**
 * The server types for Esu.
 */
enum EsuServerType {
  Standard,
  Datacenter,
}

/**
 * The ESU eligibility.
 */
enum EsuEligibility {
  Eligible,
  Ineligible,
  Unknown,
}

/**
 * The ESU key state.
 */
enum EsuKeyState {
  Inactive,
  Active,
}

/**
 * Subscription status of the OS or Product feature.
 */
enum LicenseProfileSubscriptionStatus {
  Unknown,
  Enabling,
  Enabled,
  Disabled,
}

/**
 * The product type of the license.
 */
enum LicenseProfileProductType {
  WindowsServer,
  WindowsIoTEnterprise,
}

/**
 * The status of the hybrid machine agent.
 */
enum StatusTypes {
  Connected,
  Disconnected,
  Error,
}

/**
 * The level code.
 */
enum StatusLevelTypes {
  Info,
  Warning,
  Error,
}

/**
 * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
 */
enum PatchOperationStatus {
  Unknown,
  InProgress,
  Failed,
  Succeeded,
  CompletedWithWarnings,
}

/**
 * Indicates if operation was triggered by user or by platform.
 */
enum PatchOperationStartedBy {
  User,
  Platform,
}

/**
 * Specifies the patch service used for the operation.
 */
enum PatchServiceUsed {
  Unknown,
  WU,
  WU_WSUS,
  YUM,
  APT,
  Zypper,
}

/**
 * The operating system type of the machine.
 */
enum OsType {
  Windows,
  Linux,
}

/**
 * Defines when it is acceptable to reboot a VM during a software update operation.
 */
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

/**
 * The reboot state of the VM following completion of the operation.
 */
enum VMGuestPatchRebootStatus {
  Unknown,
  NotNeeded,
  Required,
  Started,
  Failed,
  Completed,
}

/**
 * Script execution status.
 */
enum ExecutionState {
  Unknown,
  Pending,
  Running,
  Failed,
  Succeeded,
  TimedOut,
  Canceled,
}

/**
 * The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).
 */
enum PublicNetworkAccessType {
  /**
   * Allows Azure Arc agents to communicate with Azure Arc services over both public (internet) and private endpoints.
   */
  Enabled,

  /**
   * Does not allow Azure Arc agents to communicate with Azure Arc services over public (internet) endpoints. The agents must use the private link.
   */
  Disabled,
}

/**
 * Indicates the new subscription status of the OS or Product Features.
 */
enum LicenseProfileSubscriptionStatusUpdate {
  Enable,
  Disable,
}

/**
 * Type of provisioning issue.
 */
enum ProvisioningIssueType {
  /**
   * Perimeter configuration is missing.
   */
  MissingPerimeterConfiguration,

  /**
   * Identity configuration is missing.
   */
  MissingIdentityConfiguration,

  /**
   * Configuration failed to propagate.
   */
  ConfigurationPropagationFailure,

  /**
   * Other failure.
   */
  Other,
}

/**
 * Severity of the provisioning issue.
 */
enum ProvisioningIssueSeverity {
  /**
   * Warnings can cause connectivity issues after provisioning succeeds.
   */
  Warning,

  /**
   * Errors will cause association provisioning to fail.
   */
  Error,
}

/**
 * Indicates direction of an access rule.
 */
enum AccessRuleDirection {
  /**
   * Traffic originates outside of network.
   */
  Inbound,

  /**
   * Traffic originates inside the network
   */
  Outbound,
}

/**
 * Property that impacts a resource's logging behavior and its connectivity with other resources and public networks.
 */
enum AccessMode {
  /**
   * Indicates that resource access is controlled by the NSP definition.
   */
  enforced,

  /**
   * Dry run mode, where traffic is evaluated against NSP Rules, logged but not enforced.
   */
  audit,

  /**
   * Enables traffic evaluation to fall back to resource-specific firewall configurations.
   */
  learning,
}

/**
 * The level code.
 */
@fixed
enum ExtensionsStatusLevelTypes {
  Info,
  Warning,
  Error,
}

/**
 * Describes a hybrid machine Update.
 */
model MachineUpdate extends ResourceUpdate {
  /**
   * Identity for the resource.
   */
  identity?: Identity;

  /**
   * Indicates which kind of Arc machine placement on-premises, such as HCI, SCVMM or VMware etc.
   */
  kind?: ArcKindEnum;

  /**
   * Hybrid Compute Machine properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: MachineUpdateProperties;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * Describes the ARM updatable properties of a hybrid machine.
 */
model MachineUpdateProperties {
  /**
   * Metadata pertaining to the geographic location of the resource.
   */
  locationData?: LocationData;

  /**
   * Specifies the operating system settings for the hybrid machine.
   */
  osProfile?: OSProfile;

  /**
   * The metadata of the cloud environment (Azure/GCP/AWS/OCI...).
   */
  cloudMetadata?: CloudMetadata;

  /**
   * The info of the machine w.r.t Agent Upgrade
   */
  agentUpgrade?: AgentUpgrade;

  /**
   * The resource id of the parent cluster (Azure HCI) this machine is assigned to, if any.
   */
  parentClusterResourceId?: ResourceIdentifier;

  /**
   * The resource id of the private link scope this machine is assigned to, if any.
   */
  privateLinkScopeResourceId?: ResourceIdentifier;
}

/**
 * Metadata pertaining to the geographic location of the resource.
 */
model LocationData {
  /**
   * A canonical name for the geographic or physical location.
   */
  @maxLength(256)
  name: string;

  /**
   * The city or locality where the resource is located.
   */
  city?: string;

  /**
   * The district, state, or province where the resource is located.
   */
  district?: string;

  /**
   * The country or region where the resource is located
   */
  countryOrRegion?: string;
}

/**
 * Specifies the operating system settings for the hybrid machine.
 */
model OSProfile {
  /**
   * Specifies the host OS name of the hybrid machine.
   */
  @visibility("read")
  computerName?: string;

  /**
   * Specifies the windows configuration for update management.
   */
  windowsConfiguration?: OSProfileWindowsConfiguration;

  /**
   * Specifies the linux configuration for update management.
   */
  linuxConfiguration?: OSProfileLinuxConfiguration;
}

/**
 * Specifies the windows configuration for update management.
 */
model OSProfileWindowsConfiguration {
  /**
   * Specifies the patch settings.
   */
  @extension("x-ms-client-flatten", true)
  patchSettings?: PatchSettings;
}

/**
 * Specifies the patch settings.
 */
model PatchSettings {
  /**
   * Specifies the assessment mode.
   */
  assessmentMode?: AssessmentModeTypes;

  /**
   * Specifies the patch mode.
   */
  patchMode?: PatchModeTypes;
}

/**
 * Specifies the linux configuration for update management.
 */
model OSProfileLinuxConfiguration {
  /**
   * Specifies the patch settings.
   */
  @extension("x-ms-client-flatten", true)
  patchSettings?: PatchSettings;
}

/**
 * The metadata of the cloud environment (Azure/GCP/AWS/OCI...).
 */
model CloudMetadata {
  /**
   * Specifies the cloud provider (Azure/AWS/GCP...).
   */
  @visibility("read")
  provider?: string;
}

/**
 * The info w.r.t Agent Upgrade.
 */
model AgentUpgrade {
  /**
   * Specifies the version info w.r.t AgentUpgrade for the machine.
   */
  desiredVersion?: string;

  /**
   * The correlation ID passed in from RSM per upgrade.
   */
  correlationId?: string;

  /**
   * Specifies if RSM should try to upgrade this machine
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Specifies the version of the last attempt
   */
  @visibility("read")
  lastAttemptDesiredVersion?: string;

  /**
   * Timestamp of last upgrade attempt
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAttemptTimestamp?: utcDateTime;

  /**
   * Specifies the status of Agent Upgrade.
   */
  @visibility("read")
  lastAttemptStatus?: LastAttemptStatusEnum;

  /**
   * Failure message of last upgrade attempt if any.
   */
  @visibility("read")
  lastAttemptMessage?: string;
}

/**
 * The Update Resource model definition.
 */
model ResourceUpdate {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Describes the properties of a hybrid machine.
 */
model MachineProperties {
  /**
   * Metadata pertaining to the geographic location of the resource.
   */
  locationData?: LocationData;

  /**
   * Configurable properties that the user can set locally via the azcmagent config command, or remotely via ARM.
   */
  @visibility("read")
  agentConfiguration?: AgentConfiguration;

  /**
   * Statuses of dependent services that are reported back to ARM.
   */
  serviceStatuses?: ServiceStatuses;

  /**
   * The metadata of the cloud environment (Azure/GCP/AWS/OCI...).
   */
  cloudMetadata?: CloudMetadata;

  /**
   * The info of the machine w.r.t Agent Upgrade
   */
  agentUpgrade?: AgentUpgrade;

  /**
   * Specifies the operating system settings for the hybrid machine.
   */
  osProfile?: OSProfile;

  /**
   * Specifies the License related properties for a machine.
   */
  licenseProfile?: LicenseProfileMachineInstanceView;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The status of the hybrid machine agent.
   */
  @visibility("read")
  status?: StatusTypes;

  /**
   * The time of the last status change.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusChange?: utcDateTime;

  /**
   * Details about the error state.
   */
  @visibility("read")
  errorDetails?: ErrorDetail[];

  /**
   * The hybrid machine agent full version.
   */
  @visibility("read")
  agentVersion?: string;

  /**
   * Specifies the hybrid machine unique ID.
   */
  @visibility("read", "create")
  vmId?: string;

  /**
   * Specifies the hybrid machine display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Specifies the hybrid machine FQDN.
   */
  @visibility("read")
  machineFqdn?: string;

  /**
   * Public Key that the client provides to be used during initial resource onboarding
   */
  clientPublicKey?: string;

  /**
   * The Operating System running on the hybrid machine.
   */
  @visibility("read")
  osName?: string;

  /**
   * The version of Operating System running on the hybrid machine.
   */
  @visibility("read")
  osVersion?: string;

  /**
   * The type of Operating System (windows/linux).
   */
  osType?: string;

  /**
   * Specifies the Arc Machine's unique SMBIOS ID
   */
  @visibility("read")
  vmUuid?: string;

  /**
   * Machine Extensions information (deprecated field)
   */
  extensions?: MachineExtensionInstanceView[];

  /**
   * Specifies the Operating System product SKU.
   */
  @visibility("read")
  osSku?: string;

  /**
   * The edition of the Operating System.
   */
  @visibility("read")
  osEdition?: string;

  /**
   * Specifies the Windows domain name.
   */
  @visibility("read")
  domainName?: string;

  /**
   * Specifies the AD fully qualified display name.
   */
  @visibility("read")
  adFqdn?: string;

  /**
   * Specifies the DNS fully qualified display name.
   */
  @visibility("read")
  dnsFqdn?: string;

  /**
   * The resource id of the private link scope this machine is assigned to, if any.
   */
  privateLinkScopeResourceId?: ResourceIdentifier;

  /**
   * The resource id of the parent cluster (Azure HCI) this machine is assigned to, if any.
   */
  parentClusterResourceId?: ResourceIdentifier;

  /**
   * Specifies whether any MS SQL instance is discovered on the machine.
   */
  mssqlDiscovered?: string;

  /**
   * Detected properties from the machine.
   */
  @visibility("read")
  detectedProperties?: Record<string>;

  /**
   * Information about the network the machine is on.
   */
  @visibility("read")
  networkProfile?: NetworkProfile;
}

/**
 * Configurable properties that the user can set locally via the azcmagent config command, or remotely via ARM.
 */
model AgentConfiguration {
  /**
   * Specifies the URL of the proxy to be used.
   */
  @visibility("read")
  proxyUrl?: string;

  /**
   * Specifies the list of ports that the agent will be able to listen on.
   */
  @visibility("read")
  incomingConnectionsPorts?: string[];

  /**
   * Array of extensions that are allowed to be installed or updated.
   */
  @visibility("read")
  extensionsAllowList?: ConfigurationExtension[];

  /**
   * Array of extensions that are blocked (cannot be installed or updated)
   */
  @visibility("read")
  extensionsBlockList?: ConfigurationExtension[];

  /**
   * List of service names which should not use the specified proxy server.
   */
  @visibility("read")
  proxyBypass?: string[];

  /**
   * Specifies whether the extension service is enabled or disabled.
   */
  @visibility("read")
  extensionsEnabled?: string;

  /**
   * Specified whether the guest configuration service is enabled or disabled.
   */
  @visibility("read")
  guestConfigurationEnabled?: string;

  /**
   * Name of configuration mode to use. Modes are pre-defined configurations of security controls, extension allowlists and guest configuration, maintained by Microsoft.
   */
  @visibility("read")
  configMode?: AgentConfigurationMode;
}

/**
 * Describes properties that can identify extensions.
 */
model ConfigurationExtension {
  /**
   * Publisher of the extension.
   */
  @visibility("read")
  publisher?: string;

  /**
   * Type of the extension.
   */
  @visibility("read")
  type?: string;
}

/**
 * Reports the state and behavior of dependent services.
 */
model ServiceStatuses {
  /**
   * The state of the extension service on the Arc-enabled machine.
   */
  extensionService?: ServiceStatus;

  /**
   * The state of the guest configuration service on the Arc-enabled machine.
   */
  guestConfigurationService?: ServiceStatus;
}

/**
 * Describes the status and behavior of a service.
 */
model ServiceStatus {
  /**
   * The current status of the service.
   */
  status?: string;

  /**
   * The behavior of the service when the Arc-enabled machine starts up.
   */
  startupType?: string;
}

/**
 * License Profile Instance View in Machine Properties.
 */
model LicenseProfileMachineInstanceView {
  /**
   * Indicates the license status of the OS.
   */
  @visibility("read")
  licenseStatus?: LicenseStatus;

  /**
   * Indicates the license channel.
   */
  @visibility("read")
  licenseChannel?: string;

  @visibility("read")
  @extension("x-ms-client-flatten", true)
  softwareAssurance?: LicenseProfileMachineInstanceViewSoftwareAssurance;

  /**
   * Properties for the Machine ESU profile.
   */
  esuProfile?: LicenseProfileMachineInstanceViewEsuProperties;

  /**
   * Hybrid Compute Product Profile properties
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  productProfile?: LicenseProfileArmProductProfileProperties;
}

model LicenseProfileMachineInstanceViewSoftwareAssurance {
  /**
   * Specifies if this machine is licensed as part of a Software Assurance agreement.
   */
  softwareAssuranceCustomer?: boolean;
}

/**
 * Properties for the Machine ESU profile.
 */
model LicenseProfileMachineInstanceViewEsuProperties
  extends LicenseProfileArmEsuPropertiesWithoutAssignedLicense {
  /**
   * The assigned license resource.
   */
  assignedLicense?: License;

  /**
   * Describes the license assignment state (Assigned or NotAssigned).
   */
  licenseAssignmentState?: LicenseAssignmentState;
}

/**
 * Describes a license in a hybrid machine.
 */
model License extends TrackedResource {
  /**
   * Hybrid Compute License properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: LicenseProperties;
}

/**
 * Describes the properties of a License Profile.
 */
model LicenseProperties {
  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Describes the tenant id.
   */
  tenantId?: string;

  /**
   * The type of the license resource.
   */
  licenseType?: LicenseType;

  /**
   * Describes the properties of a License.
   */
  licenseDetails?: LicenseDetails;
}

/**
 * Describes the properties of a License.
 */
model LicenseDetails {
  /**
   * Describes the state of the license.
   */
  state?: LicenseState;

  /**
   * Describes the license target server.
   */
  target?: LicenseTarget;

  /**
   * Describes the edition of the license. The values are either Standard or Datacenter.
   */
  edition?: LicenseEdition;

  /**
   * Describes the license core type (pCore or vCore).
   */
  type?: LicenseCoreType;

  /**
   * Describes the number of processors.
   */
  processors?: int32;

  /**
   * Describes the number of assigned licenses.
   */
  @visibility("read")
  assignedLicenses?: int32;

  /**
   * Describes the immutable id.
   */
  @visibility("read")
  immutableId?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Describes the properties of a License Profile ARM model.
 */
model LicenseProfileArmEsuPropertiesWithoutAssignedLicense
  extends LicenseProfileStorageModelEsuProperties {
  /**
   * The type of the Esu servers.
   */
  @visibility("read")
  serverType?: EsuServerType;

  /**
   * Indicates the eligibility state of Esu.
   */
  @visibility("read")
  esuEligibility?: EsuEligibility;

  /**
   * Indicates whether there is an ESU Key currently active for the machine.
   */
  @visibility("read")
  esuKeyState?: EsuKeyState;
}

/**
 * License profile storage model for ESU properties.
 */
model LicenseProfileStorageModelEsuProperties {
  /**
   * The guid id of the license.
   */
  @visibility("read")
  assignedLicenseImmutableId?: string;

  /**
   * The list of ESU keys.
   */
  @visibility("read")
  esuKeys?: EsuKey[];
}

/**
 * ESU key
 */
model EsuKey {
  /**
   * SKU number.
   */
  sku?: string;

  /**
   * The current status of the license profile key.
   */
  licenseStatus?: string;
}

/**
 * Describes the properties of a Product License Profile ARM model.
 */
model LicenseProfileArmProductProfileProperties {
  /**
   * Indicates the subscription status of the product.
   */
  subscriptionStatus?: LicenseProfileSubscriptionStatus;

  /**
   * Indicates the product type of the license.
   */
  productType?: LicenseProfileProductType;

  /**
   * The timestamp in UTC when the billing starts.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingStartDate?: utcDateTime;

  /**
   * The timestamp in UTC when the user enrolls the feature.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentDate?: utcDateTime;

  /**
   * The timestamp in UTC when the user disenrolled the feature.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  disenrollmentDate?: utcDateTime;

  /**
   * The list of product features.
   */
  productFeatures?: ProductFeature[];
}

/**
 * Product Feature
 */
model ProductFeature {
  /**
   * Product feature name.
   */
  name?: string;

  /**
   * Indicates the current status of the product features.
   */
  subscriptionStatus?: LicenseProfileSubscriptionStatus;

  /**
   * The timestamp in UTC when the billing starts.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingStartDate?: utcDateTime;

  /**
   * The timestamp in UTC when the user enrolls the feature.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentDate?: utcDateTime;

  /**
   * The timestamp in UTC when the user disenrolled the feature.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  disenrollmentDate?: utcDateTime;
}

/**
 * Describes the Machine Extension Instance View.
 */
model MachineExtensionInstanceView {
  /**
   * The machine extension name.
   */
  name?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Instance view status.
   */
  status?: MachineExtensionInstanceViewStatus;
}

/**
 * Instance view status.
 */
model MachineExtensionInstanceViewStatus {
  /**
   * The status code.
   */
  code?: string;

  /**
   * The level code.
   */
  level?: StatusLevelTypes;

  /**
   * The short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  message?: string;

  /**
   * The time of the status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * Describes the network information on this machine.
 */
model NetworkProfile {
  /**
   * The list of network interfaces.
   */
  networkInterfaces?: NetworkInterface[];
}

/**
 * Describes a network interface.
 */
model NetworkInterface {
  /**
   * The list of IP addresses in this interface.
   */
  ipAddresses?: IpAddress[];
}

/**
 * Describes properties of the IP address.
 */
model IpAddress {
  /**
   * Represents the IP Address.
   */
  address?: string;

  /**
   * Represents the Ip Address Version.
   */
  ipAddressVersion?: string;

  /**
   * The subnet to which this IP address belongs.
   */
  @visibility("read")
  subnet?: Subnet;
}

/**
 * Describes the subnet.
 */
model Subnet {
  /**
   * Represents address prefix.
   */
  addressPrefix?: string;
}

/**
 * Describes the properties of a Machine Extension.
 */
model MachineExtensionProperties {
  /**
   * How the extension handler should be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  protectedSettings?: Record<unknown>;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The machine extension instance view.
   */
  instanceView?: MachineExtensionInstanceView;
}

/**
 * Describes the properties of an AssessPatches result.
 */
model MachineAssessPatchesResult {
  /**
   * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
   */
  @visibility("read")
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result.
   */
  @visibility("read")
  assessmentActivityId?: string;

  /**
   * The overall reboot status of the VM. It will be true when partially installed patches require a reboot to complete installation but the reboot has not yet occurred.
   */
  @visibility("read")
  rebootPending?: boolean;

  /**
   * Summarization of patches available for installation on the machine by classification.
   */
  availablePatchCountByClassification?: AvailablePatchCountByClassification;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The UTC timestamp when the operation finished.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * Indicates if operation was triggered by user or by platform.
   */
  @visibility("read")
  startedBy?: PatchOperationStartedBy;

  /**
   * Specifies the patch service used for the operation.
   */
  @visibility("read")
  patchServiceUsed?: PatchServiceUsed;

  /**
   * The operating system type of the machine.
   */
  @visibility("read")
  osType?: OsType;

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility("read")
  errorDetails?: ErrorDetail;
}

/**
 * Summarization of patches available for installation on the machine by classification.
 */
model AvailablePatchCountByClassification {
  /**
   * Number of security patches available for installation.
   */
  @visibility("read")
  security?: int32;

  /**
   * Number of critical patches available for installation.
   */
  @visibility("read")
  critical?: int32;

  /**
   * Number of definition patches available for installation.
   */
  @visibility("read")
  definition?: int32;

  /**
   * Number of update Rollup patches available for installation.
   */
  @visibility("read")
  updateRollup?: int32;

  /**
   * Number of feature pack patches available for installation.
   */
  @visibility("read")
  featurePack?: int32;

  /**
   * Number of service pack patches available for installation.
   */
  @visibility("read")
  servicePack?: int32;

  /**
   * Number of tools patches available for installation.
   */
  @visibility("read")
  tools?: int32;

  /**
   * Number of updates category patches available for installation.
   */
  @visibility("read")
  updates?: int32;

  /**
   * Number of other patches available for installation.
   */
  @visibility("read")
  other?: int32;
}

/**
 * Input for InstallPatches as directly received by the API
 */
model MachineInstallPatchesParameters {
  /**
   * Specifies the maximum amount of time that the operation will run. It must be an ISO 8601-compliant duration string such as PT4H (4 hours)
   */
  maximumDuration: duration;

  /**
   * Defines when it is acceptable to reboot a VM during a software update operation.
   */
  rebootSetting: VMGuestPatchRebootSetting;

  /**
   * Input for InstallPatches on a Windows VM, as directly received by the API
   */
  windowsParameters?: WindowsParameters;

  /**
   * Input for InstallPatches on a Linux VM, as directly received by the API
   */
  linuxParameters?: LinuxParameters;
}

/**
 * Input for InstallPatches on a Windows VM, as directly received by the API
 */
model WindowsParameters {
  /**
   * The update classifications to select when installing patches for Windows.
   */
  classificationsToInclude?: VMGuestPatchClassificationWindows[];

  /**
   * Kbs to include in the patch operation
   */
  kbNumbersToInclude?: string[];

  /**
   * Kbs to exclude in the patch operation
   */
  kbNumbersToExclude?: string[];

  /**
   * Filters out Kbs that don't have an InstallationRebootBehavior of 'NeverReboots' when this is set to true.
   */
  excludeKbsRequiringReboot?: boolean;

  /**
   * This is used to install patches that were published on or before this given max published date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  maxPatchPublishDate?: utcDateTime;
}

/**
 * Input for InstallPatches on a Linux VM, as directly received by the API
 */
model LinuxParameters {
  /**
   * The update classifications to select when installing patches for Linux.
   */
  classificationsToInclude?: VMGuestPatchClassificationLinux[];

  /**
   * packages to include in the patch operation. Format: packageName_packageVersion
   */
  packageNameMasksToInclude?: string[];

  /**
   * packages to exclude in the patch operation. Format: packageName_packageVersion
   */
  packageNameMasksToExclude?: string[];
}

/**
 * The result summary of an installation operation.
 */
model MachineInstallPatchesResult {
  /**
   * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Failed", "Succeeded", "Unknown" or "CompletedWithWarnings."
   */
  @visibility("read")
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result.
   */
  @visibility("read")
  installationActivityId?: string;

  /**
   * The reboot state of the VM following completion of the operation.
   */
  @visibility("read")
  rebootStatus?: VMGuestPatchRebootStatus;

  /**
   * Whether the operation ran out of time before it completed all its intended actions.
   */
  @visibility("read")
  maintenanceWindowExceeded?: boolean;

  /**
   * The number of patches that were not installed due to the user blocking their installation.
   */
  @visibility("read")
  excludedPatchCount?: int32;

  /**
   * The number of patches that were detected as available for install, but did not meet the operation's criteria.
   */
  @visibility("read")
  notSelectedPatchCount?: int32;

  /**
   * The number of patches that were identified as meeting the installation criteria, but were not able to be installed. Typically this happens when maintenanceWindowExceeded == true.
   */
  @visibility("read")
  pendingPatchCount?: int32;

  /**
   * The number of patches successfully installed.
   */
  @visibility("read")
  installedPatchCount?: int32;

  /**
   * The number of patches that could not be installed due to some issue. See errors for details.
   */
  @visibility("read")
  failedPatchCount?: int32;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The UTC timestamp when the operation finished.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * Indicates if operation was triggered by user or by platform.
   */
  @visibility("read")
  startedBy?: PatchOperationStartedBy;

  /**
   * Specifies the patch service used for the operation.
   */
  @visibility("read")
  patchServiceUsed?: PatchServiceUsed;

  /**
   * The operating system type of the machine.
   */
  @visibility("read")
  osType?: OsType;

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility("read")
  errorDetails?: ErrorDetail;
}

/**
 * Describes a Machine Extension Update.
 */
model MachineExtensionUpdate extends ResourceUpdate {
  /**
   * Describes Machine Extension Update Properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MachineExtensionUpdateProperties;
}

/**
 * Describes the properties of a Machine Extension.
 */
model MachineExtensionUpdateProperties {
  /**
   * How the extension handler should be forced to update even if the extension configuration has not changed.
   */
  forceUpdateTag?: string;

  /**
   * The name of the extension handler publisher.
   */
  publisher?: string;

  /**
   * Specifies the type of the extension; an example is "CustomScriptExtension".
   */
  type?: string;

  /**
   * Specifies the version of the script handler.
   */
  typeHandlerVersion?: string;

  /**
   * Indicates whether the extension should be automatically upgraded by the platform if there is a newer version available.
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Indicates whether the extension should use a newer minor version if one is available at deployment time. Once deployed, however, the extension will not upgrade minor versions unless redeployed, even with this property set to true.
   */
  autoUpgradeMinorVersion?: boolean;

  /**
   * Json formatted public settings for the extension.
   */
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  protectedSettings?: Record<unknown>;
}

/**
 * Describes the Machine Extension Upgrade Properties.
 */
model MachineExtensionUpgrade {
  /**
   * Describes the Extension Target Properties.
   */
  extensionTargets?: Record<ExtensionTargetProperties>;
}

/**
 * Describes the Machine Extension Target Version Properties
 */
model ExtensionTargetProperties {
  /**
   * Properties for the specified Extension to Upgrade.
   */
  targetVersion?: string;
}

/**
 * Describes Extension Metadata properties
 */
model ExtensionValueProperties {
  /**
   * The version of the Extension being received.
   */
  @visibility("read")
  version?: string;

  /**
   * The type of the Extension being received.
   */
  @visibility("read")
  extensionType?: string;

  /**
   * The publisher of the Extension being received.
   */
  @visibility("read")
  publisher?: string;
}

/**
 * Describes the properties of a Compute Operation value.
 */
model OperationValue {
  /**
   * The origin of the compute operation.
   */
  @visibility("read")
  origin?: string;

  /**
   * The name of the compute operation.
   */
  @visibility("read")
  name?: string;

  /**
   * Display properties
   */
  display?: OperationValueDisplay;

  /**
   * This property indicates if the operation is an action or a data action
   */
  @visibility("read")
  isDataAction?: boolean;
}

/**
 * Describes the properties of a Hybrid Compute Operation Value Display.
 */
model OperationValueDisplay {
  /**
   * The display name of the compute operation.
   */
  @visibility("read")
  operation?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility("read")
  resource?: string;

  /**
   * The description of the operation.
   */
  @visibility("read")
  description?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility("read")
  provider?: string;
}

/**
 * Describes the properties of a run command.
 */
model MachineRunCommandProperties {
  /**
   * The source of the run command script.
   */
  source?: MachineRunCommandScriptSource;

  /**
   * The parameters used by the script.
   */
  parameters?: RunCommandInputParameter[];

  /**
   * The parameters used by the script.
   */
  protectedParameters?: RunCommandInputParameter[];

  /**
   * Optional. If set to true, provisioning will complete as soon as script starts and will not wait for script to complete.
   */
  asyncExecution?: boolean;

  /**
   * Specifies the user account on the machine when executing the run command.
   */
  runAsUser?: string;

  /**
   * Specifies the user account password on the machine when executing the run command.
   */
  runAsPassword?: string;

  /**
   * The timeout in seconds to execute the run command.
   */
  timeoutInSeconds?: int32;

  /**
   * Specifies the Azure storage blob where script output stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer outputBlobManagedIdentity parameter.
   */
  outputBlobUri?: string;

  /**
   * Specifies the Azure storage blob where script error stream will be uploaded. Use a SAS URI with read, append, create, write access OR use managed identity to provide the VM access to the blob. Refer errorBlobManagedIdentity parameter.
   */
  errorBlobUri?: string;

  /**
   * User-assigned managed identity that has access to outputBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged
   */
  outputBlobManagedIdentity?: RunCommandManagedIdentity;

  /**
   * User-assigned managed identity that has access to errorBlobUri storage blob. Use an empty object in case of system-assigned identity. Make sure managed identity has been given access to blob's container with 'Storage Blob Data Contributor' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged
   */
  errorBlobManagedIdentity?: RunCommandManagedIdentity;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The machine run command instance view.
   */
  @visibility("read")
  instanceView?: MachineRunCommandInstanceView;
}

/**
 * Describes the script sources for run command. Use only one of script, scriptUri, commandId.
 */
model MachineRunCommandScriptSource {
  /**
   * Specifies the script content to be executed on the machine.
   */
  script?: string;

  /**
   * Specifies the script download location. It can be either SAS URI of an Azure storage blob with read access or public URI.
   */
  scriptUri?: string;

  /**
   * Specifies the commandId of predefined built-in script.
   */
  commandId?: string;

  /**
   * User-assigned managed identity that has access to scriptUri in case of Azure storage blob. Use an empty object in case of system-assigned identity. Make sure the Azure storage blob exists, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment. In case of user-assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.
   */
  scriptUriManagedIdentity?: RunCommandManagedIdentity;
}

/**
 *  Contains clientId or objectId (use only one, not both) of a user-assigned managed identity that has access to storage blob used in Run Command. Use an empty RunCommandManagedIdentity object in case of system-assigned identity. Make sure the Azure storage blob exists in case of scriptUri, and managed identity has been given access to blob's container with 'Storage Blob Data Reader' role assignment with scriptUri blob and 'Storage Blob Data Contributor' for Append blobs(outputBlobUri, errorBlobUri). In case of user assigned identity, make sure you add it under VM's identity. For more info on managed identity and Run Command, refer https://aka.ms/ManagedIdentity and https://aka.ms/RunCommandManaged.
 */
model RunCommandManagedIdentity {
  /**
   * Client Id (GUID value) of the user-assigned managed identity. ObjectId should not be used if this is provided.
   */
  clientId?: string;

  /**
   * Object Id (GUID value) of the user-assigned managed identity. ClientId should not be used if this is provided.
   */
  objectId?: string;
}

/**
 * Describes the properties of a run command parameter.
 */
model RunCommandInputParameter {
  /**
   * The run command parameter name.
   */
  name: string;

  /**
   * The run command parameter value.
   */
  value: string;
}

/**
 * The instance view of a machine run command.
 */
model MachineRunCommandInstanceView {
  /**
   * Script execution status.
   */
  executionState?: ExecutionState;

  /**
   * Communicate script configuration errors or execution messages.
   */
  executionMessage?: string;

  /**
   * Exit code returned from script execution.
   */
  exitCode?: int32;

  /**
   * Script output stream.
   */
  output?: string;

  /**
   * Script error stream.
   */
  error?: string;

  /**
   * Script start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Script end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The  status information.
   */
  statuses?: ExtensionsResourceStatus[];
}

/**
 * Instance view status.
 */
model ExtensionsResourceStatus {
  /**
   * The status code.
   */
  code?: string;

  /**
   * The level code.
   */
  level?: ExtensionsStatusLevelTypes;

  /**
   * The short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * The detailed status message, including for alerts and error messages.
   */
  message?: string;

  /**
   * The time of the status.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * Properties that define a Azure Arc PrivateLinkScope resource.
 */
model HybridComputePrivateLinkScopeProperties {
  /**
   * Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints.
   */
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Disabled;

  /**
   * Current state of this PrivateLinkScope: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The Guid id of the private link scope.
   */
  @visibility("read")
  privateLinkScopeId?: string;

  /**
   * The collection of associated Private Endpoint Connections.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDataModel[];
}

/**
 * The Data Model for a Private Endpoint Connection associated with a Private Link Scope
 */
model PrivateEndpointConnectionDataModel {
  /**
   * The ARM Resource Id of the Private Endpoint.
   */
  @visibility("read")
  id?: string;

  /**
   * The Name of the Private Endpoint.
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * The Private Endpoint Connection properties.
   */
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * Private endpoint which the connection belongs to.
   */
  privateEndpoint?: PrivateEndpointProperty;

  /**
   * Connection state of the private endpoint connection.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionStateProperty;

  /**
   * State of the private endpoint connection.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * List of group IDs.
   */
  @visibility("read")
  groupIds?: string[];
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
 * State of the private endpoint connection.
 */
model PrivateLinkServiceConnectionStateProperty {
  /**
   * The private link service connection status.
   */
  status: string;

  /**
   * The private link service connection description.
   */
  description: string;

  /**
   * The actions required for private link service connection.
   */
  @visibility("read")
  actionsRequired?: string;
}

/**
 * An azure resource object
 */
model PrivateLinkScopesResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a PrivateLinkScope instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * Required DNS zone names of the the private link resource.
   */
  @visibility("read")
  requiredZoneNames?: string[];
}

model PrivateLinkScopeValidationDetails {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Indicates whether machines associated with the private link scope can also use public Azure Arc service endpoints.
   */
  publicNetworkAccess?: PublicNetworkAccessType = PublicNetworkAccessType.Disabled;

  /**
   * List of Private Endpoint Connection details.
   */
  connectionDetails?: ConnectionDetail[];
}

model ConnectionDetail {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * The private endpoint connection private ip address
   */
  @visibility("read")
  privateIpAddress?: string;

  /**
   * The private endpoint connection link identifier
   */
  @visibility("read")
  linkIdentifier?: string;

  /**
   * The private endpoint connection group id
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private endpoint connection member name
   */
  @visibility("read")
  memberName?: string;
}

/**
 * Describes a License Update.
 */
model LicenseUpdate extends ResourceUpdate {
  /**
   * License Update properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: LicenseUpdateProperties;
}

/**
 * Describes the Update properties of a License Profile.
 */
model LicenseUpdateProperties {
  /**
   * The type of the license resource.
   */
  licenseType?: LicenseType;

  @extension("x-ms-client-flatten", true)
  licenseDetails?: LicenseUpdatePropertiesLicenseDetails;
}

model LicenseUpdatePropertiesLicenseDetails {
  /**
   * Describes the state of the license.
   */
  state?: LicenseState;

  /**
   * Describes the license target server.
   */
  target?: LicenseTarget;

  /**
   * Describes the edition of the license. The values are either Standard or Datacenter.
   */
  edition?: LicenseEdition;

  /**
   * Describes the license core type (pCore or vCore).
   */
  type?: LicenseCoreType;

  /**
   * Describes the number of processors.
   */
  processors?: int32;
}

/**
 * The List license operation response.
 */
model LicensesListResult {
  /**
   * The list of licenses.
   */
  value: License[];

  /**
   * The URI to fetch the next page of Machines. Call ListNext() with this URI to fetch the next page of license profile.
   */
  nextLink?: string;
}

/**
 * Describes a license profile in a hybrid machine.
 */
model LicenseProfile extends TrackedResource {
  /**
   * Describe the properties of a license profile.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LicenseProfileProperties;
}

/**
 * Describe the properties of a license profile.
 */
model LicenseProfileProperties {
  @extension("x-ms-client-flatten", true)
  softwareAssurance?: LicenseProfilePropertiesSoftwareAssurance;

  /**
   * Hybrid Compute ESU Profile properties
   */
  @extension("x-ms-client-flatten", true)
  esuProfile?: LicenseProfileArmEsuProperties;

  /**
   * Hybrid Compute Product Profile properties
   */
  @extension("x-ms-client-flatten", true)
  productProfile?: LicenseProfileArmProductProfileProperties;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

model LicenseProfilePropertiesSoftwareAssurance {
  /**
   * Specifies if this machine is licensed as part of a Software Assurance agreement.
   */
  softwareAssuranceCustomer?: boolean;
}

/**
 * Describes the properties of a License Profile ARM model.
 */
model LicenseProfileArmEsuProperties
  extends LicenseProfileArmEsuPropertiesWithoutAssignedLicense {
  /**
   * The resource id of the license.
   */
  assignedLicense?: string;
}

/**
 * Describes a License Profile Update.
 */
model LicenseProfileUpdate extends ResourceUpdate {
  /**
   * Describe the Update properties of a license profile.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LicenseProfileUpdateProperties;
}

/**
 * Describe the Update properties of a license profile.
 */
model LicenseProfileUpdateProperties {
  @extension("x-ms-client-flatten", true)
  softwareAssurance?: LicenseProfileUpdatePropertiesSoftwareAssurance;

  /**
   * Hybrid Compute ESU Profile Update properties
   */
  @extension("x-ms-client-flatten", true)
  esuProfile?: EsuProfileUpdateProperties;

  /**
   * Hybrid Compute Product Profile Update properties
   */
  @extension("x-ms-client-flatten", true)
  productProfile?: ProductProfileUpdateProperties;
}

model LicenseProfileUpdatePropertiesSoftwareAssurance {
  /**
   * Specifies if this machine is licensed as part of a Software Assurance agreement.
   */
  softwareAssuranceCustomer?: boolean;
}

/**
 * Describes the Update properties of a ESU License Profile.
 */
model EsuProfileUpdateProperties {
  /**
   * The resource id of the license.
   */
  assignedLicense?: string;
}

/**
 * Describes the Update properties of a Product Profile.
 */
model ProductProfileUpdateProperties {
  /**
   * Indicates the subscription status of the product.
   */
  subscriptionStatus?: LicenseProfileSubscriptionStatusUpdate;

  /**
   * Indicates the product type of the license.
   */
  productType?: LicenseProfileProductType;

  /**
   * The list of product feature updates.
   */
  productFeatures?: ProductFeatureUpdate[];
}

/**
 * Product Feature
 */
model ProductFeatureUpdate {
  /**
   * Product feature name.
   */
  name?: string;

  /**
   * Indicates the new status of the product feature.
   */
  subscriptionStatus?: LicenseProfileSubscriptionStatusUpdate;
}

/**
 * The List hybrid machine license profile operation response.
 */
model LicenseProfilesListResult {
  /**
   * The list of license profiles.
   */
  value: LicenseProfile[];

  /**
   * The URI to fetch the next page of Machines. Call ListNext() with this URI to fetch the next page of license profile.
   */
  nextLink?: string;
}

/**
 * List of HybridIdentityMetadata.
 */
model HybridIdentityMetadataList {
  /**
   * Url to follow for getting next page of HybridIdentityMetadata.
   */
  nextLink?: string;

  /**
   * Array of HybridIdentityMetadata
   */
  value: HybridIdentityMetadata[];
}

/**
 * Defines the HybridIdentityMetadata.
 */
model HybridIdentityMetadata extends ProxyResource {
  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: HybridIdentityMetadataProperties;
}

/**
 * Defines the resource properties.
 */
model HybridIdentityMetadataProperties {
  /**
   * The unique identifier for the resource.
   */
  vmId?: string;

  /**
   * The Public Key.
   */
  publicKey?: string;

  /**
   * Identity for the resource.
   */
  @visibility("read")
  identity?: Identity;
}

/**
 * Describes AgentVersions List.
 */
model AgentVersionsList {
  /**
   * The list of available Agent Versions.
   */
  value?: AgentVersion[];

  /**
   * The URI to fetch the next 10 available Agent Versions.
   */
  nextLink?: string;
}

/**
 * Describes properties of Agent Version.
 */
model AgentVersion {
  /**
   * Represents the agent version.
   */
  agentVersion?: string;

  /**
   * Represents the download link of specific agent version.
   */
  downloadLink?: string;

  /**
   * Defines the os type.
   */
  osType?: string;
}

/**
 * Describes a Machine Extension Update.
 */
model MachineRunCommandUpdate extends ResourceUpdate {}

model NetworkConfiguration extends ProxyResource {
  /**
   * Network configuration properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkConfigurationProperties;
}

/**
 * Network configuration properties
 */
model NetworkConfigurationProperties {
  /**
   * Resource location
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Azure resource tenant Id
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Associated Network Configuration Scope Id (GUID)
   */
  networkConfigurationScopeId?: string;

  /**
   * Associated Network Configuration Scope Resource Id
   */
  networkConfigurationScopeResourceId: ResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/privateLinkScopes";
    }
  ]>;

  /**
   * Public key information for client authentication
   */
  @visibility("read")
  keyProperties?: KeyProperties;
}

/**
 * Public key information for client authentication
 */
model KeyProperties {
  /**
   * Current public key details
   */
  @visibility("read")
  clientPublicKey?: KeyDetails;

  /**
   * Candidate public key details
   */
  @visibility("read")
  candidatePublicKey?: KeyDetails;
}

/**
 * Public key details
 */
model KeyDetails {
  /**
   * Public key
   */
  @visibility("read")
  publicKey?: string;

  /**
   * Key expiration date
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  /**
   * Recommended key renewal date
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  renewAfter?: utcDateTime;
}

/**
 * Properties that define a Network Security Perimeter resource.
 */
model NetworkSecurityPerimeterConfiguration {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Properties that define a Network Security Perimeter resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkSecurityPerimeterConfigurationProperties;
}

/**
 * Properties that define a Network Security Perimeter resource.
 */
model NetworkSecurityPerimeterConfigurationProperties {
  /**
   * Current state of this NetworkSecurityPerimeter: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Provisioning issues.
   */
  @visibility("read")
  provisioningIssues?: ProvisioningIssue[];

  /**
   * The Network Security Perimeter associated with this configuration.
   */
  networkSecurityPerimeter?: NetworkSecurityPerimeter;

  /**
   * The Resource Association.
   */
  resourceAssociation?: ResourceAssociation;

  /**
   * Network Security Perimeter profile
   */
  profile?: NetworkSecurityPerimeterProfile;
}

/**
 * Details on issues that occurred during provisioning.
 */
model ProvisioningIssue {
  /**
   * Name of the provisioning issue.
   */
  @visibility("read")
  name?: string;

  /**
   * Provisioning issue properties
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  properties?: ProvisioningIssueProperties;
}

/**
 * Properties of a provisioning issue.
 */
model ProvisioningIssueProperties {
  /**
   * Issue type
   */
  @visibility("read")
  issueType?: ProvisioningIssueType;

  /**
   * Severity of the provisioning issue.
   */
  @visibility("read")
  severity?: ProvisioningIssueSeverity;

  /**
   * Description of the provisioning issue.
   */
  @visibility("read")
  description?: string;

  /**
   * ARM Ids of the resources that can be associated to the same perimeter to remediate the issue
   */
  @visibility("read")
  suggestedResourceIds?: string[];

  /**
   * Access rules that can be added to the perimeter to remediate the issue
   */
  @visibility("read")
  suggestedAccessRules?: AccessRule[];
}

/**
 * Access rule.
 */
model AccessRule {
  /**
   * Name of the access rule.
   */
  @visibility("read")
  name?: string;

  /**
   * Access rule properties
   */
  @visibility("read")
  @extension("x-ms-client-flatten", true)
  properties?: AccessRuleProperties;
}

/**
 * Properties of an access rule.
 */
model AccessRuleProperties {
  /**
   * Direction of the access rule.
   */
  @visibility("read")
  direction?: AccessRuleDirection;

  /**
   * Address prefixes that are allowed access.
   */
  @visibility("read")
  addressPrefixes?: string[];
}

/**
 * Properties that define a Network Security Perimeter resource.
 */
model NetworkSecurityPerimeter {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Guid of the Network Security Perimeter
   */
  @visibility("read")
  perimeterGuid?: string;

  /**
   * Regional location of the perimeter
   */
  @visibility("read")
  location?: string;
}

/**
 * Properties that define a Resource Association.
 */
model ResourceAssociation {
  /**
   * Name of the Resource Association
   */
  @visibility("read")
  name?: string;

  /**
   * The access mode
   */
  @visibility("read")
  accessMode?: AccessMode;
}

/**
 * Network Security Perimeter profile
 */
model NetworkSecurityPerimeterProfile {
  /**
   * Name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * Access rules version number
   */
  @visibility("read")
  accessRulesVersion?: string;

  /**
   * Collection of access rules for the profile
   */
  @visibility("read")
  accessRules?: AccessRule[];

  /**
   * Diagnostic settings version number
   */
  @visibility("read")
  diagnosticSettingsVersion?: string;

  /**
   * Collection of enabled log categories for the profile
   */
  @visibility("read")
  enabledLogCategories?: string[];
}

/**
 * A list of network security perimeter configurations.
 */
model NetworkSecurityPerimeterConfigurationListResult {
  /**
   * Array of results.
   */
  @visibility("read")
  value?: NetworkSecurityPerimeterConfiguration[];

  /**
   * Link to retrieve next page of results.
   */
  @visibility("read")
  nextLink?: string;
}
