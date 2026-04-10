import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HybridCompute;

/**
 * The provisioning state, which only appears in the response.
 */
union ProvisioningState {
  string,

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Accepted
   */
  Accepted: "Accepted",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleted
   */
  Deleted: "Deleted",
}

/**
 * The type of the license resource.
 */
union LicenseType {
  string,

  /**
   * ESU
   */
  ESU: "ESU",
}

/**
 * Describes the state of the license.
 */
union LicenseState {
  string,

  /**
   * Activated
   */
  Activated: "Activated",

  /**
   * Deactivated
   */
  Deactivated: "Deactivated",
}

/**
 * Describes the license target server.
 */
union LicenseTarget {
  string,

  /**
   * Windows Server 2012
   */
  `Windows Server 2012`: "Windows Server 2012",

  /**
   * Windows Server 2012 R2
   */
  `Windows Server 2012 R2`: "Windows Server 2012 R2",
}

/**
 * Describes the edition of the license. The values are either Standard or Datacenter.
 */
union LicenseEdition {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Datacenter
   */
  Datacenter: "Datacenter",
}

/**
 * Describes the license core type (pCore or vCore).
 */
union LicenseCoreType {
  string,

  /**
   * pCore
   */
  pCore: "pCore",

  /**
   * vCore
   */
  vCore: "vCore",
}

/**
 * Describes the program year the volume license is for.
 */
union ProgramYear {
  string,

  /**
   * Year 1
   */
  `Year 1`: "Year 1",

  /**
   * Year 2
   */
  `Year 2`: "Year 2",

  /**
   * Year 3
   */
  `Year 3`: "Year 3",
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
 * Name of configuration mode to use. Modes are pre-defined configurations of security controls, extension allowlists and guest configuration, maintained by Microsoft.
 */
union AgentConfigurationMode {
  string,

  /**
   * full
   */
  full: "full",

  /**
   * monitor
   */
  monitor: "monitor",
}

/**
 * Specifies the status of Agent Upgrade.
 */
union LastAttemptStatusEnum {
  string,

  /**
   * Success
   */
  Success: "Success",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Specifies the assessment mode.
 */
union AssessmentModeTypes {
  string,

  /**
   * ImageDefault
   */
  ImageDefault: "ImageDefault",

  /**
   * AutomaticByPlatform
   */
  AutomaticByPlatform: "AutomaticByPlatform",
}

/**
 * Specifies the patch mode.
 */
union PatchModeTypes {
  string,

  /**
   * ImageDefault
   */
  ImageDefault: "ImageDefault",

  /**
   * AutomaticByPlatform
   */
  AutomaticByPlatform: "AutomaticByPlatform",

  /**
   * AutomaticByOS
   */
  AutomaticByOS: "AutomaticByOS",

  /**
   * Manual
   */
  Manual: "Manual",
}

/**
 * Status of hotpatch enablement or disablement.
 */
union HotpatchEnablementStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * PendingEvaluation
   */
  PendingEvaluation: "PendingEvaluation",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * ActionRequired
   */
  ActionRequired: "ActionRequired",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The license status.
 */
union LicenseStatus {
  string,

  /**
   * Unlicensed
   */
  Unlicensed: "Unlicensed",

  /**
   * Licensed
   */
  Licensed: "Licensed",

  /**
   * OOBGrace
   */
  OOBGrace: "OOBGrace",

  /**
   * OOTGrace
   */
  OOTGrace: "OOTGrace",

  /**
   * NonGenuineGrace
   */
  NonGenuineGrace: "NonGenuineGrace",

  /**
   * Notification
   */
  Notification: "Notification",

  /**
   * ExtendedGrace
   */
  ExtendedGrace: "ExtendedGrace",
}

/**
 * Describes the license assignment state (Assigned or NotAssigned).
 */
union LicenseAssignmentState {
  string,

  /**
   * Assigned
   */
  Assigned: "Assigned",

  /**
   * NotAssigned
   */
  NotAssigned: "NotAssigned",
}

/**
 * The server types for Esu.
 */
union EsuServerType {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Datacenter
   */
  Datacenter: "Datacenter",
}

/**
 * The ESU eligibility.
 */
union EsuEligibility {
  string,

  /**
   * Eligible
   */
  Eligible: "Eligible",

  /**
   * Ineligible
   */
  Ineligible: "Ineligible",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * The ESU key state.
 */
union EsuKeyState {
  string,

  /**
   * Inactive
   */
  Inactive: "Inactive",

  /**
   * Active
   */
  Active: "Active",
}

/**
 * Subscription status of the OS or Product feature.
 */
union LicenseProfileSubscriptionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Enabling
   */
  Enabling: "Enabling",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Disabling
   */
  Disabling: "Disabling",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The product type of the license.
 */
union LicenseProfileProductType {
  string,

  /**
   * WindowsServer
   */
  WindowsServer: "WindowsServer",

  /**
   * WindowsIoTEnterprise
   */
  WindowsIoTEnterprise: "WindowsIoTEnterprise",
}

/**
 * The status of the hybrid machine agent.
 */
union StatusTypes {
  string,

  /**
   * Connected
   */
  Connected: "Connected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",

  /**
   * Error
   */
  Error: "Error",

  /**
   * AwaitingConnection
   */
  AwaitingConnection: "AwaitingConnection",
}

/**
 * Specifies the identity key store a machine is using.
 */
union IdentityKeyStore {
  string,

  /**
   * TPM
   */
  TPM: "TPM",

  /**
   * Default
   */
  Default: "Default",
}

/**
 * The level code.
 */
union StatusLevelTypes {
  string,

  /**
   * Info
   */
  Info: "Info",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Error
   */
  Error: "Error",
}

/**
 * Indicates which kind of Arc machine placement on-premises, such as HCI, SCVMM or VMware etc.
 */
union ArcKindEnum {
  string,

  /**
   * AVS
   */
  AVS: "AVS",

  /**
   * HCI
   */
  HCI: "HCI",

  /**
   * SCVMM
   */
  SCVMM: "SCVMM",

  /**
   * VMware
   */
  VMware: "VMware",

  /**
   * EPS
   */
  EPS: "EPS",

  /**
   * GCP
   */
  GCP: "GCP",

  /**
   * AWS
   */
  AWS: "AWS",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union InstanceViewTypes {
  string,

  /**
   * instanceView
   */
  instanceView: "instanceView",
}

/**
 * Indicates the new subscription status of the OS or Product Features.
 */
union LicenseProfileSubscriptionStatusUpdate {
  string,

  /**
   * Enable
   */
  Enable: "Enable",

  /**
   * Disable
   */
  Disable: "Disable",
}

/**
 * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
 */
union PatchOperationStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * CompletedWithWarnings
   */
  CompletedWithWarnings: "CompletedWithWarnings",
}

/**
 * Indicates if operation was triggered by user or by platform.
 */
union PatchOperationStartedBy {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Platform
   */
  Platform: "Platform",
}

/**
 * Specifies the patch service used for the operation.
 */
union PatchServiceUsed {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * WU
   */
  WU: "WU",

  /**
   * WU_WSUS
   */
  WU_WSUS: "WU_WSUS",

  /**
   * YUM
   */
  YUM: "YUM",

  /**
   * APT
   */
  APT: "APT",

  /**
   * Zypper
   */
  Zypper: "Zypper",
}

/**
 * The operating system type of the machine.
 */
union OsType {
  string,

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * Linux
   */
  Linux: "Linux",
}

/**
 * Defines when it is acceptable to reboot a VM during a software update operation.
 */
union VMGuestPatchRebootSetting {
  string,

  /**
   * IfRequired
   */
  IfRequired: "IfRequired",

  /**
   * Never
   */
  Never: "Never",

  /**
   * Always
   */
  Always: "Always",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union VMGuestPatchClassification_Windows {
  string,

  /**
   * Critical
   */
  Critical: "Critical",

  /**
   * Security
   */
  Security: "Security",

  /**
   * UpdateRollUp
   */
  UpdateRollUp: "UpdateRollUp",

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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union VMGuestPatchClassification_Linux {
  string,

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
 * The reboot state of the VM following completion of the operation.
 */
union VMGuestPatchRebootStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * NotNeeded
   */
  NotNeeded: "NotNeeded",

  /**
   * Required
   */
  Required: "Required",

  /**
   * Started
   */
  Started: "Started",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Completed
   */
  Completed: "Completed",
}

/**
 * Script execution status.
 */
union ExecutionState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Running
   */
  Running: "Running",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * TimedOut
   */
  TimedOut: "TimedOut",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The type of the Gateway resource.
 */
union GatewayType {
  string,

  /**
   * Public
   */
  Public: "Public",
}

/**
 * The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).
 */
union PublicNetworkAccessType {
  string,

  /**
   * Allows Azure Arc agents to communicate with Azure Arc services over both public (internet) and private endpoints.
   */
  Enabled: "Enabled",

  /**
   * Does not allow Azure Arc agents to communicate with Azure Arc services over public (internet) endpoints. The agents must use the private link.
   */
  Disabled: "Disabled",
}

/**
 * The name of the Azure Arc Extension.
 */
union ServiceExtensionType {
  string,
}

/**
 * The network access policy to determine if the specified Azure Arc Extension can use public Azure Arc Extension service endpoints.
 */
union ServiceExtensionPublicNetworkAccess {
  string,

  /**
   * Allows Azure Arc Extension agents to communicate with Azure Arc services over both public (internet) and private endpoints.
   */
  Enabled: "Enabled",

  /**
   * Does not allow Azure Arc Extension agents to communicate with Azure Arc services over public (internet) endpoints. The agents must use the private link.
   */
  Disabled: "Disabled",
}

/**
 * Type of provisioning issue.
 */
union ProvisioningIssueType {
  string,

  /**
   * Perimeter configuration is missing.
   */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /**
   * Identity configuration is missing.
   */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",

  /**
   * Configuration failed to propagate.
   */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /**
   * Other failure.
   */
  Other: "Other",
}

/**
 * Severity of the provisioning issue.
 */
union ProvisioningIssueSeverity {
  string,

  /**
   * Warnings can cause connectivity issues after provisioning succeeds.
   */
  Warning: "Warning",

  /**
   * Errors will cause association provisioning to fail.
   */
  Error: "Error",
}

/**
 * Indicates direction of an access rule.
 */
union AccessRuleDirection {
  string,

  /**
   * Traffic originates outside of network.
   */
  Inbound: "Inbound",

  /**
   * Traffic originates inside the network
   */
  Outbound: "Outbound",
}

/**
 * Property that impacts a resource's logging behavior and its connectivity with other resources and public networks.
 */
union AccessMode {
  string,

  /**
   * Indicates that resource access is controlled by the NSP definition.
   */
  enforced: "enforced",

  /**
   * Dry run mode, where traffic is evaluated against NSP Rules, logged but not enforced.
   */
  audit: "audit",

  /**
   * Enables traffic evaluation to fall back to resource-specific firewall configurations.
   */
  learning: "learning",
}

/**
 * The level code.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ExtensionsStatusLevelTypes {
  /**
   * Info
   */
  Info,

  /**
   * Warning
   */
  Warning,

  /**
   * Error
   */
  Error,
}

/**
 * Describes the properties of a License Profile.
 */
model LicenseProperties {
  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  assignedLicenses?: int32;

  /**
   * Describes the immutable id.
   */
  @visibility(Lifecycle.Read)
  immutableId?: string;

  /**
   * A list of volume license details.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  volumeLicenseDetails?: VolumeLicenseDetails[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model VolumeLicenseDetails {
  /**
   * Describes the program year the volume license is for.
   */
  programYear?: ProgramYear;

  /**
   * The invoice id for the volume license.
   */
  invoiceId?: string;
}

/**
 * Describes a License Update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LicenseUpdate extends ResourceUpdate {
  /**
   * License Update properties
   */
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  licenseDetails?: LicenseUpdatePropertiesLicenseDetails;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
 * The Update Resource model definition.
 */
model ResourceUpdate {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Describes the properties of a hybrid machine.
 */
model MachineProperties {
  /**
   * Metadata pertaining to the geographic location of the resource.
   */
  locationData?: CommonTypes.LocationData;

  /**
   * Configurable properties that the user can set locally via the azcmagent config command, or remotely via ARM.
   */
  @visibility(Lifecycle.Read)
  agentConfiguration?: AgentConfiguration;

  /**
   * Statuses of dependent services that are reported back to ARM.
   */
  serviceStatuses?: ServiceStatuses;

  /**
   * Information about the machine's hardware
   */
  @visibility(Lifecycle.Read)
  hardwareProfile?: HardwareProfile;

  /**
   * Information about the machine's storage
   */
  @visibility(Lifecycle.Read)
  storageProfile?: StorageProfile;

  /**
   * Information about the machine's firmware
   */
  @visibility(Lifecycle.Read)
  firmwareProfile?: FirmwareProfile;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The status of the hybrid machine agent.
   */
  @visibility(Lifecycle.Read)
  status?: StatusTypes;

  /**
   * The time of the last status change.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastStatusChange?: utcDateTime;

  /**
   * Details about the error state.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errorDetails?: ErrorDetail[];

  /**
   * The hybrid machine agent full version.
   */
  @visibility(Lifecycle.Read)
  agentVersion?: string;

  /**
   * Specifies the hybrid machine unique ID.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @format("uuid")
  vmId?: string;

  /**
   * Specifies the hybrid machine display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Specifies the hybrid machine FQDN.
   */
  @visibility(Lifecycle.Read)
  machineFqdn?: string;

  /**
   * Public Key that the client provides to be used during initial resource onboarding
   */
  clientPublicKey?: string;

  /**
   * Specifies the identity key store a machine is using.
   */
  identityKeyStore?: IdentityKeyStore;

  /**
   * Endorsement Key Certificate of the Trusted Platform Module (TPM) that the client provides to be used during initial resource onboarding.
   */
  tpmEkCertificate?: string;

  /**
   * The Operating System running on the hybrid machine.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * The version of Operating System running on the hybrid machine.
   */
  @visibility(Lifecycle.Read)
  osVersion?: string;

  /**
   * The type of Operating System (windows/linux).
   */
  osType?: string;

  /**
   * Specifies the Arc Machine's unique SMBIOS ID
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  vmUuid?: string;

  /**
   * Machine Extensions information (deprecated field)
   */
  @identifiers(#[])
  extensions?: MachineExtensionInstanceView[];

  /**
   * Specifies the Operating System product SKU.
   */
  @visibility(Lifecycle.Read)
  osSku?: string;

  /**
   * The edition of the Operating System.
   */
  @visibility(Lifecycle.Read)
  osEdition?: string;

  /**
   * Specifies the Windows domain name.
   */
  @visibility(Lifecycle.Read)
  domainName?: string;

  /**
   * Specifies the AD fully qualified display name.
   */
  @visibility(Lifecycle.Read)
  adFqdn?: string;

  /**
   * Specifies the DNS fully qualified display name.
   */
  @visibility(Lifecycle.Read)
  dnsFqdn?: string;

  /**
   * The resource id of the private link scope this machine is assigned to, if any.
   */
  privateLinkScopeResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource id of the parent cluster (Azure HCI) this machine is assigned to, if any.
   */
  parentClusterResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Specifies the resource ID of the associated hardware device. Only settable by HCI RP.
   */
  hardwareResourceId?: string;

  /**
   * Specifies whether any MS SQL instance is discovered on the machine.
   */
  mssqlDiscovered?: string;

  /**
   * Detected properties from the machine.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  detectedProperties?: Record<string>;

  /**
   * Information about the network the machine is on.
   */
  @visibility(Lifecycle.Read)
  networkProfile?: NetworkProfile;
}

/**
 * Configurable properties that the user can set locally via the azcmagent config command, or remotely via ARM.
 */
model AgentConfiguration {
  /**
   * Specifies the URL of the proxy to be used.
   */
  @visibility(Lifecycle.Read)
  proxyUrl?: string;

  /**
   * Specifies the list of ports that the agent will be able to listen on.
   */
  @visibility(Lifecycle.Read)
  incomingConnectionsPorts?: string[];

  /**
   * Array of extensions that are allowed to be installed or updated.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  extensionsAllowList?: ConfigurationExtension[];

  /**
   * Array of extensions that are blocked (cannot be installed or updated)
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  extensionsBlockList?: ConfigurationExtension[];

  /**
   * List of service names which should not use the specified proxy server.
   */
  @visibility(Lifecycle.Read)
  proxyBypass?: string[];

  /**
   * Specifies whether the extension service is enabled or disabled.
   */
  @visibility(Lifecycle.Read)
  extensionsEnabled?: string;

  /**
   * Specified whether the guest configuration service is enabled or disabled.
   */
  @visibility(Lifecycle.Read)
  guestConfigurationEnabled?: string;

  /**
   * Name of configuration mode to use. Modes are pre-defined configurations of security controls, extension allowlists and guest configuration, maintained by Microsoft.
   */
  @visibility(Lifecycle.Read)
  configMode?: AgentConfigurationMode;
}

/**
 * Describes properties that can identify extensions.
 */
model ConfigurationExtension {
  /**
   * Publisher of the extension.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * Type of the extension.
   */
  @visibility(Lifecycle.Read)
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
 * Describes the hardware of the machine
 */
model HardwareProfile {
  /**
   * The total physical memory on the machine
   */
  @visibility(Lifecycle.Read)
  totalPhysicalMemoryInBytes?: int64;

  /**
   * The total number of CPU sockets available on the machine
   */
  @visibility(Lifecycle.Read)
  numberOfCpuSockets?: int32;

  /**
   * The physical processors of the machine.
   */
  @visibility(Lifecycle.Read)
  processors?: Processor[];
}

/**
 * Describes the firmware of the machine
 */
model Processor {
  /**
   * The name of the processor.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The total number of physical cores on the processor.
   */
  @visibility(Lifecycle.Read)
  numberOfCores?: int32;
}

/**
 * Describes the storage configuration of the machine
 */
model StorageProfile {
  /**
   * The disks on the machine.
   */
  @visibility(Lifecycle.Read)
  disks?: Disk[];
}

/**
 * Describes a disk on the machine
 */
model Disk {
  /**
   * The path of the disk.
   */
  path?: string;

  /**
   * The type of the disk.
   */
  diskType?: string;

  /**
   * The generated ID of the disk.
   */
  generatedId?: string;

  /**
   * The ID of the disk.
   */
  id?: string;

  /**
   * The name of the disk.
   */
  name?: string;

  /**
   * The size of the disk, in bytes
   */
  maxSizeInBytes?: int64;

  /**
   * The amount of space used on the disk, in bytes
   */
  usedSpaceInBytes?: int64;
}

/**
 * Describes the firmware of the machine
 */
model FirmwareProfile {
  /**
   * The serial number of the firmware
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * The type of the firmware
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * The metadata of the cloud environment (Azure/GCP/AWS/OCI...).
 */
model CloudMetadata {
  /**
   * Specifies the cloud provider (Azure/AWS/GCP...).
   */
  @visibility(Lifecycle.Read)
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
   * The correlation ID associated with an agent upgrade operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  correlationId?: string;

  /**
   * Specifies if the machine's agent should be upgraded
   */
  enableAutomaticUpgrade?: boolean;

  /**
   * Specifies the version of the last attempt
   */
  @visibility(Lifecycle.Read)
  lastAttemptDesiredVersion?: string;

  /**
   * Timestamp of last upgrade attempt
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastAttemptTimestamp?: utcDateTime;

  /**
   * Specifies the status of Agent Upgrade.
   */
  @visibility(Lifecycle.Read)
  lastAttemptStatus?: LastAttemptStatusEnum;

  /**
   * Failure message of last upgrade attempt if any.
   */
  @visibility(Lifecycle.Read)
  lastAttemptMessage?: string;
}

/**
 * Specifies the operating system settings for the hybrid machine.
 */
model OSProfile {
  /**
   * Specifies the host OS name of the hybrid machine.
   */
  @visibility(Lifecycle.Read)
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OSProfileWindowsConfiguration {
  /**
   * Specifies the patch settings.
   */
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

  /**
   * Captures the hotpatch capability enrollment intent of the customers, which enables customers to patch their Windows machines without requiring a reboot.
   */
  enableHotpatching?: boolean;

  /**
   * Status of the hotpatch capability enrollment or disenrollment.
   */
  @visibility(Lifecycle.Read)
  status?: PatchSettingsStatus;
}

/**
 * Status of the hotpatch capability enrollment or disenrollment.
 */
model PatchSettingsStatus {
  /**
   * Indicates the current status of the hotpatch being enabled or disabled.
   */
  hotpatchEnablementStatus?: HotpatchEnablementStatus;

  /**
   * The errors that were encountered during the hotpatch capability enrollment or disenrollment.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Specifies the linux configuration for update management.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OSProfileLinuxConfiguration {
  /**
   * Specifies the patch settings.
   */
  patchSettings?: PatchSettings;
}

/**
 * License Profile Instance View in Machine Properties.
 */
model LicenseProfileMachineInstanceView {
  /**
   * Indicates the license status of the OS.
   */
  @visibility(Lifecycle.Read)
  licenseStatus?: LicenseStatus;

  /**
   * Indicates the license channel.
   */
  @visibility(Lifecycle.Read)
  licenseChannel?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  softwareAssurance?: LicenseProfileMachineInstanceViewSoftwareAssurance;

  /**
   * Properties for the Machine ESU profile.
   */
  esuProfile?: LicenseProfileMachineInstanceViewEsuProperties;

  /**
   * Hybrid Compute Product Profile properties
   */
  @visibility(Lifecycle.Read)
  productProfile?: LicenseProfileArmProductProfileProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LicenseProfileMachineInstanceViewSoftwareAssurance {
  /**
   * Specifies if this machine is licensed as part of a Software Assurance agreement.
   */
  softwareAssuranceCustomer?: boolean;
}

/**
 * Properties for the Machine ESU profile.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
 * Describes the properties of a License Profile ARM model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LicenseProfileArmEsuPropertiesWithoutAssignedLicense
  extends LicenseProfileStorageModelEsuProperties {
  /**
   * The type of the Esu servers.
   */
  @visibility(Lifecycle.Read)
  serverType?: EsuServerType;

  /**
   * Indicates the eligibility state of Esu.
   */
  @visibility(Lifecycle.Read)
  esuEligibility?: EsuEligibility;

  /**
   * Indicates whether there is an ESU Key currently active for the machine.
   */
  @visibility(Lifecycle.Read)
  esuKeyState?: EsuKeyState;
}

/**
 * License profile storage model for ESU properties.
 */
model LicenseProfileStorageModelEsuProperties {
  /**
   * The guid id of the license.
   */
  @visibility(Lifecycle.Read)
  assignedLicenseImmutableId?: string;

  /**
   * The list of ESU keys.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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
   * The current status of the license profile key. Represented by the same integer value that is presented on the machine itself when querying the license key status.
   */
  licenseStatus?: int32;
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
   * The timestamp in UTC when the user enrolls the feature.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentDate?: utcDateTime;

  /**
   * The timestamp in UTC when the billing starts.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingStartDate?: utcDateTime;

  /**
   * The timestamp in UTC when the user disenrolled the feature.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  disenrollmentDate?: utcDateTime;

  /**
   * The timestamp in UTC when the billing ends.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingEndDate?: utcDateTime;

  /**
   * The errors that were encountered during the feature enrollment or disenrollment.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;

  /**
   * The list of product features.
   */
  @identifiers(#[])
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
   * The timestamp in UTC when the user enrolls the feature.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  enrollmentDate?: utcDateTime;

  /**
   * The timestamp in UTC when the billing starts.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingStartDate?: utcDateTime;

  /**
   * The timestamp in UTC when the user disenrolled the feature.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  disenrollmentDate?: utcDateTime;

  /**
   * The timestamp in UTC when the billing ends.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  billingEndDate?: utcDateTime;

  /**
   * The errors that were encountered during the feature enrollment or disenrollment.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.CommonTypes.ErrorDetail;
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
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  networkInterfaces?: NetworkInterface[];
}

/**
 * Describes a network interface.
 */
model NetworkInterface {
  /**
   * Represents MAC address of the network interface.
   */
  macAddress?: string;

  /**
   * Represents the ID of the network interface.
   */
  id?: string;

  /**
   * Represents the name of the network interface.
   */
  name?: string;

  /**
   * The list of IP addresses in this interface.
   */
  @identifiers(#[])
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  protectedSettings?: Record<unknown>;

  /**
   * The provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The machine extension instance view.
   */
  instanceView?: MachineExtensionInstanceView;
}

/**
 * Describes a hybrid machine Update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MachineUpdate extends ResourceUpdate {
  /**
   * Identity for the resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.Identity;

  /**
   * Indicates which kind of Arc machine placement on-premises, such as HCI, SCVMM or VMware etc.
   */
  kind?: ArcKindEnum;

  /**
   * Hybrid Compute Machine properties
   */
  properties?: MachineUpdateProperties;
}

/**
 * Describes the ARM updatable properties of a hybrid machine.
 */
model MachineUpdateProperties {
  /**
   * Metadata pertaining to the geographic location of the resource.
   */
  locationData?: CommonTypes.LocationData;

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
  parentClusterResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * The resource id of the private link scope this machine is assigned to, if any.
   */
  privateLinkScopeResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * Identity key store type of the machine
   */
  identityKeyStore?: string;

  /**
   * Endorsement Key Certificate of the Trusted Platform Module (TPM) that the client provides to be used during initial resource onboarding.
   */
  tpmEkCertificate?: string;
}

/**
 * Describe the properties of a license profile.
 */
model LicenseProfileProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  softwareAssurance?: LicenseProfilePropertiesSoftwareAssurance;

  /**
   * Hybrid Compute ESU Profile properties
   */
  esuProfile?: LicenseProfileArmEsuProperties;

  /**
   * Hybrid Compute Product Profile properties
   */
  productProfile?: LicenseProfileArmProductProfileProperties;

  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model LicenseProfilePropertiesSoftwareAssurance {
  /**
   * Specifies if this machine is licensed as part of a Software Assurance agreement.
   */
  softwareAssuranceCustomer?: boolean;
}

/**
 * Describes the properties of a License Profile ARM model.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LicenseProfileUpdate extends ResourceUpdate {
  /**
   * Describe the Update properties of a license profile.
   */
  properties?: LicenseProfileUpdateProperties;
}

/**
 * Describe the Update properties of a license profile.
 */
model LicenseProfileUpdateProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  softwareAssurance?: LicenseProfileUpdatePropertiesSoftwareAssurance;

  /**
   * Hybrid Compute ESU Profile Update properties
   */
  esuProfile?: EsuProfileUpdateProperties;

  /**
   * Hybrid Compute Product Profile Update properties
   */
  productProfile?: ProductProfileUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
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
  @identifiers(#[])
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
 * Describes the properties of an AssessPatches result.
 */
model MachineAssessPatchesResult {
  /**
   * The overall success or failure status of the operation. It remains "InProgress" until the operation completes. At that point it will become "Unknown", "Failed", "Succeeded", or "CompletedWithWarnings."
   */
  @visibility(Lifecycle.Read)
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  assessmentActivityId?: string;

  /**
   * The overall reboot status of the VM. It will be true when partially installed patches require a reboot to complete installation but the reboot has not yet occurred.
   */
  @visibility(Lifecycle.Read)
  rebootPending?: boolean;

  /**
   * Summarization of patches available for installation on the machine by classification.
   */
  availablePatchCountByClassification?: AvailablePatchCountByClassification;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The UTC timestamp when the operation finished.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * Indicates if operation was triggered by user or by platform.
   */
  @visibility(Lifecycle.Read)
  startedBy?: PatchOperationStartedBy;

  /**
   * Specifies the patch service used for the operation.
   */
  @visibility(Lifecycle.Read)
  patchServiceUsed?: PatchServiceUsed;

  /**
   * The operating system type of the machine.
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Summarization of patches available for installation on the machine by classification.
 */
model AvailablePatchCountByClassification {
  /**
   * Number of security patches available for installation.
   */
  @visibility(Lifecycle.Read)
  security?: int32;

  /**
   * Number of critical patches available for installation.
   */
  @visibility(Lifecycle.Read)
  critical?: int32;

  /**
   * Number of definition patches available for installation.
   */
  @visibility(Lifecycle.Read)
  definition?: int32;

  /**
   * Number of update Rollup patches available for installation.
   */
  @visibility(Lifecycle.Read)
  updateRollup?: int32;

  /**
   * Number of feature pack patches available for installation.
   */
  @visibility(Lifecycle.Read)
  featurePack?: int32;

  /**
   * Number of service pack patches available for installation.
   */
  @visibility(Lifecycle.Read)
  servicePack?: int32;

  /**
   * Number of tools patches available for installation.
   */
  @visibility(Lifecycle.Read)
  tools?: int32;

  /**
   * Number of updates category patches available for installation.
   */
  @visibility(Lifecycle.Read)
  updates?: int32;

  /**
   * Number of other patches available for installation.
   */
  @visibility(Lifecycle.Read)
  other?: int32;
}

/**
 * Input for InstallPatches as directly received by the API
 */
model MachineInstallPatchesParameters {
  /**
   * Specifies the maximum amount of time that the operation will run. It must be an ISO 8601-compliant duration string such as PT4H (4 hours)
   */
  maximumDuration: string;

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
  classificationsToInclude?: VMGuestPatchClassification_Windows[];

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

  /**
   * This is used to include patches that match the given patch name masks. Alphanumeric strings and wildcard expressions consisting of * and ? are only supported as input values in the list. Null, empty and only whitespaces strings as inputs values are not supported.
   */
  patchNameMasksToInclude?: string[];

  /**
   * This is used to exclude patches that match the given patch name masks. Alphanumeric strings and wildcard expressions consisting of * and ? are only supported as input values in the list. Null, empty and only whitespaces strings as inputs values are not supported.
   */
  patchNameMasksToExclude?: string[];
}

/**
 * Input for InstallPatches on a Linux VM, as directly received by the API
 */
model LinuxParameters {
  /**
   * The update classifications to select when installing patches for Linux.
   */
  classificationsToInclude?: VMGuestPatchClassification_Linux[];

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
  @visibility(Lifecycle.Read)
  status?: PatchOperationStatus;

  /**
   * The activity ID of the operation that produced this result.
   */
  @visibility(Lifecycle.Read)
  installationActivityId?: string;

  /**
   * The reboot state of the VM following completion of the operation.
   */
  @visibility(Lifecycle.Read)
  rebootStatus?: VMGuestPatchRebootStatus;

  /**
   * Whether the operation ran out of time before it completed all its intended actions.
   */
  @visibility(Lifecycle.Read)
  maintenanceWindowExceeded?: boolean;

  /**
   * The number of patches that were not installed due to the user blocking their installation.
   */
  @visibility(Lifecycle.Read)
  excludedPatchCount?: int32;

  /**
   * The number of patches that were detected as available for install, but did not meet the operation's criteria.
   */
  @visibility(Lifecycle.Read)
  notSelectedPatchCount?: int32;

  /**
   * The number of patches that were identified as meeting the installation criteria, but were not able to be installed. Typically this happens when maintenanceWindowExceeded == true.
   */
  @visibility(Lifecycle.Read)
  pendingPatchCount?: int32;

  /**
   * The number of patches successfully installed.
   */
  @visibility(Lifecycle.Read)
  installedPatchCount?: int32;

  /**
   * The number of patches that could not be installed due to some issue. See errors for details.
   */
  @visibility(Lifecycle.Read)
  failedPatchCount?: int32;

  /**
   * The UTC timestamp when the operation began.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The UTC timestamp when the operation finished.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedDateTime?: utcDateTime;

  /**
   * Indicates if operation was triggered by user or by platform.
   */
  @visibility(Lifecycle.Read)
  startedBy?: PatchOperationStartedBy;

  /**
   * Specifies the patch service used for the operation.
   */
  @visibility(Lifecycle.Read)
  patchServiceUsed?: PatchServiceUsed;

  /**
   * The operating system type of the machine.
   */
  @visibility(Lifecycle.Read)
  osType?: OsType;

  /**
   * The errors that were encountered during execution of the operation. The details array contains the list of them.
   */
  @visibility(Lifecycle.Read)
  errorDetails?: Azure.ResourceManager.CommonTypes.ErrorDetail;
}

/**
 * Describes a Machine Extension Update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model MachineExtensionUpdate extends ResourceUpdate {
  /**
   * Describes Machine Extension Update Properties.
   */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  settings?: Record<unknown>;

  /**
   * The extension can contain either protectedSettings or protectedSettingsFromKeyVault or no protected settings at all.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  protectedSettings?: Record<unknown>;
}

/**
 * Describes the Machine Extension Upgrade Properties.
 */
model MachineExtensionUpgrade {
  /**
   * Describes the Extension Target Properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ExtensionValueProperties {
  /**
   * The version of the Extension being received.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The type of the Extension being received.
   */
  @visibility(Lifecycle.Read)
  extensionType?: string;

  /**
   * The publisher of the Extension being received.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;
}

/**
 * The List Extension Metadata response.
 */
model ExtensionValueListResult {
  /**
   * The list of extension metadata
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#[])
  value?: ExtensionValue[];

  /**
   * The URL to get the next set of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/**
 * Describes Extension Metadata properties.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ExtensionValueV2Properties extends ExtensionValueProperties {
  /**
   * A list of locations where the extension packages can be found.
   */
  @visibility(Lifecycle.Read)
  extensionUris?: url[];

  /**
   * Location of the signature files for the extension.
   */
  @visibility(Lifecycle.Read)
  extensionSignatureUri?: url;

  /**
   * The operating system (Windows, Linux, etc.) this extension supports.
   */
  @visibility(Lifecycle.Read)
  operatingSystem?: string;

  /**
   * Architectures (x64, arms64, etc.) that this extension supports.
   */
  @visibility(Lifecycle.Read)
  architecture?: string[];
}

/**
 * The List Extension Metadata response.
 */
model ExtensionValueListResultV2 is Azure.Core.Page<ExtensionValueV2>;

/**
 * The List of Extension Types.
 */
model ExtensionTypeListResult is Azure.Core.Page<ExtensionType>;

/**
 * Describes an Extension Type.
 */
model ExtensionType {
  /**
   * The ID of the extension type.
   */
  id?: string;

  /**
   * The name of the extension type.
   */
  name?: string;
}

/**
 * The List of Extension Publishers.
 */
model ExtensionPublisherListResult is Azure.Core.Page<ExtensionPublisher>;

/**
 * Describes an Extension Publisher.
 */
model ExtensionPublisher {
  /**
   * The ID of the extension publisher.
   */
  id?: string;

  /**
   * The name of the extension publisher.
   */
  name?: string;
}

/**
 * The List of Operations.
 */
model OperationListResult {
  /**
   * The list of operations.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: OperationValue[];

  /**
   * The URL to get the next set of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: url;
}

/**
 * Describes the properties of a Compute Operation value.
 */
model OperationValue {
  /**
   * The origin of the compute operation.
   */
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * The name of the compute operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Display properties
   */
  display?: OperationValueDisplay;

  /**
   * This property indicates if the operation is an action or a data action
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;
}

/**
 * Describes the properties of a Hybrid Compute Operation Value Display.
 */
model OperationValueDisplay {
  /**
   * The display name of the compute operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["name"])
  parameters?: RunCommandInputParameter[];

  /**
   * The parameters used by the script.
   */
  @identifiers(#["name"])
  protectedParameters?: RunCommandInputParameter[];

  /**
   * Optional. If set to true, provisioning will complete as soon as script starts and will not wait for script to complete.
   */
  asyncExecution?: boolean = false;

  /**
   * Specifies the user account on the machine when executing the run command.
   */
  runAsUser?: string;

  /**
   * Specifies the user account password on the machine when executing the run command.
   */
  @secret
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The machine run command instance view.
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#[])
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
 * Describes the properties of a Gateway Profile.
 */
model GatewayProperties {
  /**
   * The provisioning state, which only appears in the response.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * A unique, immutable, identifier for the Gateway.
   */
  @visibility(Lifecycle.Read)
  gatewayId?: string;

  /**
   * The type of the Gateway resource.
   */
  gatewayType?: GatewayType;

  /**
   * The endpoint fqdn for the Gateway.
   */
  @visibility(Lifecycle.Read)
  gatewayEndpoint?: string;

  /**
   * Specifies the list of features that are enabled for this Gateway.
   */
  allowedFeatures?: string[];
}

/**
 * Describes a License Update.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model GatewayUpdate extends ResourceUpdate {
  /**
   * Gateway Update properties
   */
  properties?: GatewayUpdateProperties;
}

/**
 * Describes the Update properties of a Gateway Profile.
 */
model GatewayUpdateProperties {
  /**
   * Specifies the list of features that are enabled for this Gateway.
   */
  allowedFeatures?: string[];
}

/**
 * Settings properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SettingsProperties {
  /**
   * Azure resource tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Settings Gateway properties
   */
  gatewayProperties?: SettingsGatewayProperties;
}

/**
 * Settings Gateway properties
 */
model SettingsGatewayProperties {
  /**
   * Associated Gateway Resource Id
   */
  gatewayResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/gateways";
    }
  ]>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model SetupExtensionRequest {
  /**
   * The list of extensions
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extensions?: MachineExtensionProperties[];
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The Guid id of the private link scope.
   */
  @visibility(Lifecycle.Read)
  privateLinkScopeId?: string;

  /**
   * The collection of associated Private Endpoint Connections.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnectionDataModel[];

  /**
   * Enable private link validation for an Azure Arc Extension.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  serviceExtensions?: ServiceExtension[];
}

/**
 * The Data Model for a Private Endpoint Connection associated with a Private Link Scope
 */
model PrivateEndpointConnectionDataModel {
  /**
   * The ARM Resource Id of the Private Endpoint.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The Name of the Private Endpoint.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * List of group IDs.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  actionsRequired?: string;
}

/**
 * Enable private link validation for an Azure Arc Extension
 */
model ServiceExtension {
  /**
   * The name of the Azure Arc Extension.
   */
  serviceExtensionType?: ServiceExtensionType;

  /**
   * The network access policy to determine if the specified Azure Arc Extension can use public Azure Arc Extension service endpoints.
   */
  serviceExtensionPublicNetworkAccess?: ServiceExtensionPublicNetworkAccess;
}

/**
 * An azure resource object
 */
model PrivateLinkScopesResource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a PrivateLinkScope instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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

  /**
   * Required DNS zone names of the the private link resource.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PrivateLinkScopeValidationDetails {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ConnectionDetail {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The private endpoint connection private ip address
   */
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  /**
   * The private endpoint connection link identifier
   */
  @visibility(Lifecycle.Read)
  linkIdentifier?: string;

  /**
   * The private endpoint connection group id
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private endpoint connection member name
   */
  @visibility(Lifecycle.Read)
  memberName?: string;
}

/**
 * Properties that define a Network Security Perimeter resource.
 */
model NetworkSecurityPerimeterConfigurationProperties {
  /**
   * Current state of this NetworkSecurityPerimeter: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Provisioning ,Succeeded, Canceled and Failed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Provisioning issues.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Provisioning issue properties
   */
  @visibility(Lifecycle.Read)
  properties?: ProvisioningIssueProperties;
}

/**
 * Properties of a provisioning issue.
 */
model ProvisioningIssueProperties {
  /**
   * Issue type
   */
  @visibility(Lifecycle.Read)
  issueType?: ProvisioningIssueType;

  /**
   * Severity of the provisioning issue.
   */
  @visibility(Lifecycle.Read)
  severity?: ProvisioningIssueSeverity;

  /**
   * Description of the provisioning issue.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * ARM Ids of the resources that can be associated to the same perimeter to remediate the issue
   */
  @visibility(Lifecycle.Read)
  suggestedResourceIds?: string[];

  /**
   * Access rules that can be added to the perimeter to remediate the issue
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  suggestedAccessRules?: AccessRule[];
}

/**
 * Access rule.
 */
model AccessRule {
  /**
   * Name of the access rule.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Access rule properties
   */
  @visibility(Lifecycle.Read)
  properties?: AccessRuleProperties;
}

/**
 * Properties of an access rule.
 */
model AccessRuleProperties {
  /**
   * Direction of the access rule.
   */
  @visibility(Lifecycle.Read)
  direction?: AccessRuleDirection;

  /**
   * Address prefixes that are allowed access.
   */
  @visibility(Lifecycle.Read)
  addressPrefixes?: string[];
}

/**
 * Properties that define a Network Security Perimeter resource.
 */
model NetworkSecurityPerimeter {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Guid of the Network Security Perimeter
   */
  @visibility(Lifecycle.Read)
  perimeterGuid?: string;

  /**
   * Regional location of the perimeter
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * Properties that define a Resource Association.
 */
model ResourceAssociation {
  /**
   * Name of the Resource Association
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The access mode
   */
  @visibility(Lifecycle.Read)
  accessMode?: AccessMode;
}

/**
 * Network Security Perimeter profile
 */
model NetworkSecurityPerimeterProfile {
  /**
   * Name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Access rules version number
   */
  @visibility(Lifecycle.Read)
  accessRulesVersion?: int32;

  /**
   * Collection of access rules for the profile
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  accessRules?: AccessRule[];

  /**
   * Diagnostic settings version number
   */
  @visibility(Lifecycle.Read)
  diagnosticSettingsVersion?: int32;

  /**
   * Collection of enabled log categories for the profile
   */
  @visibility(Lifecycle.Read)
  enabledLogCategories?: string[];
}

/**
 * Result of network security perimeter configurations.
 */
model NetworkSecurityPerimeterConfigurationReconcileResult {
  /**
   * The URL of the resource used to check the status of the asynchronous operation.
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * List of HybridIdentityMetadata.
 */
model HybridIdentityMetadataList is Azure.Core.Page<HybridIdentityMetadata>;

/**
 * Defines the HybridIdentityMetadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model HybridIdentityMetadata
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Resource properties.
   */
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
  @visibility(Lifecycle.Read)
  identity?: Azure.ResourceManager.CommonTypes.Identity;
}

/**
 * Describes AgentVersions List.
 */
model AgentVersionsList is Azure.Core.Page<AgentVersion>;

/**
 * Describes properties of Agent Version.
 */
model AgentVersion {
  /**
   * Represents the agent version.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MachineRunCommandUpdate extends ResourceUpdate {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model NetworkConfiguration
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * Network configuration properties
   */
  properties?: NetworkConfigurationProperties;
}

/**
 * Network configuration properties
 */
model NetworkConfigurationProperties {
  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Azure resource tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Associated Network Configuration Scope Id (GUID)
   */
  networkConfigurationScopeId?: string;

  /**
   * Associated Network Configuration Scope Resource Id
   */
  networkConfigurationScopeResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.HybridCompute/privateLinkScopes";
    }
  ]>;

  /**
   * Public key information for client authentication
   */
  @visibility(Lifecycle.Read)
  keyProperties?: KeyProperties;
}

/**
 * Public key information for client authentication
 */
model KeyProperties {
  /**
   * Current public key details
   */
  @visibility(Lifecycle.Read)
  clientPublicKey?: KeyDetails;

  /**
   * Candidate public key details
   */
  @visibility(Lifecycle.Read)
  candidatePublicKey?: KeyDetails;
}

/**
 * Public key details
 */
model KeyDetails {
  /**
   * Public key
   */
  @visibility(Lifecycle.Read)
  publicKey?: string;

  /**
   * Key expiration date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  notAfter?: utcDateTime;

  /**
   * Recommended key renewal date
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  renewAfter?: utcDateTime;
}

model GatewaysListResult is Azure.Core.Page<Gateway>;

model MachineExtensionsListResult is Azure.Core.Page<MachineExtension>;

model MachineRunCommandsListResult is Azure.Core.Page<MachineRunCommand>;

model LicensesListResult is Azure.Core.Page<License>;

model LicenseProfilesListResult is Azure.Core.Page<LicenseProfile>;

@@visibility(AgentVersionsList.value, Lifecycle.Read);
@@identifiers(AgentVersionsList.value, #["agentVersion"]);
@@visibility(ExtensionPublisherListResult.value, Lifecycle.Read);
@@visibility(ExtensionTypeListResult.value, Lifecycle.Read);
@@visibility(ExtensionValueListResultV2.value, Lifecycle.Read);
