import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

namespace Microsoft.DevTestLab;

/**
 * The storage type for the disk (i.e. Standard, Premium).
 */
union StorageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StandardSSD: "StandardSSD",
}

/**
 * The setting to enable usage of premium data disks.
 * When its value is 'Enabled', creation of standard or premium data disks is allowed.
 * When its value is 'Disabled', only creation of standard data disks is allowed.
 */
union PremiumDataDisk {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * The access rights to be granted to the user when provisioning an environment
 */
union EnvironmentPermission {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reader: "Reader",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Contributor: "Contributor",
}

/**
 * Indicates if the artifact source is enabled (values: Enabled, Disabled).
 */
union EnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Gets or sets the type of key used to encrypt the data of the disk. Possible values include: 'EncryptionAtRestWithPlatformKey', 'EncryptionAtRestWithCustomerKey'
 */
union EncryptionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EncryptionAtRestWithPlatformKey: "EncryptionAtRestWithPlatformKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EncryptionAtRestWithCustomerKey: "EncryptionAtRestWithCustomerKey",
}

/**
 * Type of identity (SystemAssigned, UserAssigned, None)
 */
union ManagedIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * The status code for the operation.
 */
union HttpStatusCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Continue: "Continue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SwitchingProtocols: "SwitchingProtocols",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Processing: "Processing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EarlyHints: "EarlyHints",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  OK: "OK",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NonAuthoritativeInformation: "NonAuthoritativeInformation",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NoContent: "NoContent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ResetContent: "ResetContent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PartialContent: "PartialContent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MultiStatus: "MultiStatus",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyReported: "AlreadyReported",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  IMUsed: "IMUsed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MultipleChoices: "MultipleChoices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Ambiguous: "Ambiguous",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MovedPermanently: "MovedPermanently",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moved: "Moved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Found: "Found",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Redirect: "Redirect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SeeOther: "SeeOther",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RedirectMethod: "RedirectMethod",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotModified: "NotModified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UseProxy: "UseProxy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unused: "Unused",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TemporaryRedirect: "TemporaryRedirect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RedirectKeepVerb: "RedirectKeepVerb",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PermanentRedirect: "PermanentRedirect",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BadRequest: "BadRequest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unauthorized: "Unauthorized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PaymentRequired: "PaymentRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Forbidden: "Forbidden",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotFound: "NotFound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MethodNotAllowed: "MethodNotAllowed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotAcceptable: "NotAcceptable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ProxyAuthenticationRequired: "ProxyAuthenticationRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestTimeout: "RequestTimeout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Conflict: "Conflict",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Gone: "Gone",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LengthRequired: "LengthRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreconditionFailed: "PreconditionFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestEntityTooLarge: "RequestEntityTooLarge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestUriTooLong: "RequestUriTooLong",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnsupportedMediaType: "UnsupportedMediaType",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestedRangeNotSatisfiable: "RequestedRangeNotSatisfiable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ExpectationFailed: "ExpectationFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MisdirectedRequest: "MisdirectedRequest",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnprocessableEntity: "UnprocessableEntity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Locked: "Locked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FailedDependency: "FailedDependency",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpgradeRequired: "UpgradeRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreconditionRequired: "PreconditionRequired",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TooManyRequests: "TooManyRequests",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RequestHeaderFieldsTooLarge: "RequestHeaderFieldsTooLarge",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UnavailableForLegalReasons: "UnavailableForLegalReasons",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InternalServerError: "InternalServerError",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotImplemented: "NotImplemented",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  BadGateway: "BadGateway",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ServiceUnavailable: "ServiceUnavailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GatewayTimeout: "GatewayTimeout",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HttpVersionNotSupported: "HttpVersionNotSupported",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VariantAlsoNegotiates: "VariantAlsoNegotiates",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InsufficientStorage: "InsufficientStorage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LoopDetected: "LoopDetected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotExtended: "NotExtended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NetworkAuthenticationRequired: "NetworkAuthenticationRequired",
}

/**
 * The artifact source's type.
 */
union SourceControlType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VsoGit: "VsoGit",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GitHub: "GitHub",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StorageAccount: "StorageAccount",
}

/**
 * Options for uploading the files for the artifact. UploadFilesAndGenerateSasTokens is the default value.
 */
union FileUploadOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UploadFilesAndGenerateSasTokens: "UploadFilesAndGenerateSasTokens",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Target cost status
 */
union TargetCostStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Indicates whether this threshold will be displayed on cost charts.
 */
union CostThresholdStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Reporting cycle type.
 */
union ReportingCycleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CalendarMonth: "CalendarMonth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Custom: "Custom",
}

/**
 * The type of the cost.
 */
union CostType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unavailable: "Unavailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reported: "Reported",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Projected: "Projected",
}

/**
 * The state of the Windows OS (i.e. NonSysprepped, SysprepRequested, SysprepApplied).
 */
union WindowsOsState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NonSysprepped: "NonSysprepped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SysprepRequested: "SysprepRequested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SysprepApplied: "SysprepApplied",
}

/**
 * The state of the Linux OS (i.e. NonDeprovisioned, DeprovisionRequested, DeprovisionApplied).
 */
union LinuxOsState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NonDeprovisioned: "NonDeprovisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeprovisionRequested: "DeprovisionRequested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  DeprovisionApplied: "DeprovisionApplied",
}

/**
 * The OS type of the custom image (i.e. Windows, Linux)
 */
union CustomImageOsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Linux: "Linux",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The transport protocol for the endpoint.
 */
union TransportProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Tcp: "Tcp",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Udp: "Udp",
}

/**
 * Tells source of creation of lab virtual machine. Output property only.
 */
union VirtualMachineCreationSource {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FromCustomImage: "FromCustomImage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FromGalleryImage: "FromGalleryImage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  FromSharedGalleryImage: "FromSharedGalleryImage",
}

/**
 * Caching option for a data disk (i.e. None, ReadOnly, ReadWrite).
 */
union HostCachingOption {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadOnly: "ReadOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ReadWrite: "ReadWrite",
}

/**
 * The event type for which this notification is enabled (i.e. AutoShutdown, Cost)
 */
union NotificationChannelEventType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AutoShutdown: "AutoShutdown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cost: "Cost",
}

/**
 * The status of the policy.
 */
union PolicyStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The fact name of the policy (e.g. LabVmCount, LabVmSize, MaxVmsAllowedPerLab, etc.
 */
union PolicyFactName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserOwnedLabVmCount: "UserOwnedLabVmCount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserOwnedLabPremiumVmCount: "UserOwnedLabPremiumVmCount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LabVmCount: "LabVmCount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LabPremiumVmCount: "LabPremiumVmCount",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LabVmSize: "LabVmSize",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GalleryImage: "GalleryImage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserOwnedLabVmCountInSubnet: "UserOwnedLabVmCountInSubnet",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LabTargetCost: "LabTargetCost",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EnvironmentTemplate: "EnvironmentTemplate",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScheduleEditPermission: "ScheduleEditPermission",
}

/**
 * The evaluator type of the policy (i.e. AllowedValuesPolicy, MaxValuePolicy).
 */
union PolicyEvaluatorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AllowedValuesPolicy: "AllowedValuesPolicy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MaxValuePolicy: "MaxValuePolicy",
}

/**
 * Enables all images in the gallery to be available in the lab for VM creation. This will override the EnableState on shared images
 */
union EnableState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * The operating system of the image
 */
union OsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Windows: "Windows",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Linux: "Linux",
}

/**
 * The type of image in the gallery (generalized or specialized)
 */
union ImageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Generalized: "Generalized",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Specialized: "Specialized",
}

/**
 * Storage type to use for virtual machine (i.e. Standard, Premium, StandardSSD).
 */
union StorageTypes {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Premium: "Premium",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StandardSSD: "StandardSSD",
}

/**
 * The permission policy of the subnet for allowing public IP addresses (i.e. Allow, Deny)).
 */
union UsagePermissionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
}

/**
 * The REST API operation supported by DevTestLab ResourceProvider.
 */
model OperationMetadata {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * The object that describes the operations
   */
  display?: OperationMetadataDisplay;
}

/**
 * The object that describes the operations
 */
model OperationMetadataDisplay {
  /**
   * Friendly name of the resource provider
   */
  provider?: string;

  /**
   * Resource type on which the operation is performed.
   */
  resource?: string;

  /**
   * Operation type: read, write, delete, listKeys/action, etc.
   */
  operation?: string;

  /**
   * Friendly name of the operation
   */
  description?: string;
}

/**
 * Error from a REST request.
 */
@error
model CloudError {
  /**
   * The cloud error that occurred
   */
  error?: CloudErrorBody;
}

/**
 * Body of an error from a REST request.
 */
model CloudErrorBody {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;

  /**
   * The error target.
   */
  target?: string;

  /**
   * Inner errors.
   */
  @OpenAPI.extension("x-ms-identifiers", #["code", "message", "target"])
  details?: CloudErrorBody[];
}

/**
 * Contains a list of labs and their properties
 */
model LabList is Azure.Core.Page<Lab>;

/**
 * Properties of a lab.
 */
model LabProperties {
  /**
   * The lab's default storage account.
   */
  @visibility(Lifecycle.Read)
  defaultStorageAccount?: string;

  /**
   * The lab's default premium storage account.
   */
  @visibility(Lifecycle.Read)
  defaultPremiumStorageAccount?: string;

  /**
   * The lab's artifact storage account.
   */
  @visibility(Lifecycle.Read)
  artifactsStorageAccount?: string;

  /**
   * The lab's premium data disk storage account.
   */
  @visibility(Lifecycle.Read)
  premiumDataDiskStorageAccount?: string;

  /**
   * The lab's Key vault.
   */
  @visibility(Lifecycle.Read)
  vaultName?: string;

  /**
   * Type of storage used by the lab. It can be either Premium or Standard. Default is Premium.
   */
  labStorageType?: StorageType;

  /**
   * The ordered list of artifact resource IDs that should be applied on all Linux VM creations by default, prior to the artifacts specified by the user.
   */
  mandatoryArtifactsResourceIdsLinux?: string[];

  /**
   * The ordered list of artifact resource IDs that should be applied on all Windows VM creations by default, prior to the artifacts specified by the user.
   */
  mandatoryArtifactsResourceIdsWindows?: string[];

  /**
   * The creation date of the lab.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The setting to enable usage of premium data disks.
   * When its value is 'Enabled', creation of standard or premium data disks is allowed.
   * When its value is 'Disabled', only creation of standard data disks is allowed.
   */
  premiumDataDisks?: PremiumDataDisk;

  /**
   * The access rights to be granted to the user when provisioning an environment
   */
  environmentPermission?: EnvironmentPermission;

  /**
   * The properties of any lab announcement associated with this lab
   */
  announcement?: LabAnnouncementProperties;

  /**
   * The properties of any lab support message associated with this lab
   */
  support?: LabSupportProperties;

  /**
   * The resource group ID in which all new lab virtual machines will be created. Ex: /subscriptions/subId/resourceGroups/rgName To let DevTest Labs manage resource group creation, set this value to null.
   */
  vmCreationResourceGroupId?: string;

  /**
   * The public IP address for the lab's load balancer.
   */
  @visibility(Lifecycle.Read)
  publicIpId?: string;

  /**
   * The load balancer used to for lab VMs that use shared IP address.
   */
  @visibility(Lifecycle.Read)
  loadBalancerId?: string;

  /**
   * The Network Security Group attached to the lab VMs Network interfaces to restrict open ports.
   */
  @visibility(Lifecycle.Read)
  networkSecurityGroupId?: string;

  /**
   * Extended properties of the lab used for experimental features
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  extendedProperties?: Record<string>;

  /**
   * Is browser connect enabled for the lab
   */
  browserConnect?: EnableStatus;

  /**
   * Is auto upgrade of CSE disabled for the lab?
   */
  disableAutoUpgradeCseMinorVersion?: boolean;

  /**
   * List of identities which can be used for management of resources.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  managementIdentities?: Record<Record<unknown>>;

  /**
   * Indicates whether to create Lab resources (e.g. Storage accounts and Key Vaults) in network isolation.
   */
  isolateLabResources?: EnableStatus;

  /**
   * Mechanism used for encryption of resources in a lab (such as virtual machines).
   */
  encryption?: Encryption;

  /**
   * Default secret for creating virtual machines.
   */
  defaultSecretName?: string;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;

  /**
   * Managed identity resource id for Lab VM storage account access, or 'SAS' for SAS token access.
   */
  storageAccountAccess?: string;
}

/**
 * Properties of a lab's announcement banner
 */
model LabAnnouncementProperties {
  /**
   * The plain text title for the lab announcement
   */
  title?: string;

  /**
   * The markdown text (if any) that this lab displays in the UI. If left empty/null, nothing will be shown.
   */
  markdown?: string;

  /**
   * Is the lab announcement active/enabled at this time?
   */
  enabled?: EnableStatus;

  /**
   * The time at which the announcement expires (null for never)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Has this announcement expired?
   */
  expired?: boolean;

  /**
   * The provisioning status of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Properties of a lab's support banner
 */
model LabSupportProperties {
  /**
   * Is the lab support banner active/enabled at this time?
   */
  enabled?: EnableStatus;

  /**
   * The markdown text (if any) that this lab displays in the UI. If left empty/null, nothing will be shown.
   */
  markdown?: string;
}

/**
 * Encryption settings
 */
model Encryption {
  /**
   * Gets or sets resourceId of the disk encryption set to use for enabling encryption at rest.
   */
  diskEncryptionSetId?: string;

  /**
   * Gets or sets the type of key used to encrypt the data of the disk. Possible values include: 'EncryptionAtRestWithPlatformKey', 'EncryptionAtRestWithCustomerKey'
   */
  type?: EncryptionType;
}

/**
 * Properties of a managed identity
 */
model IdentityProperties {
  /**
   * Type of identity (SystemAssigned, UserAssigned, None)
   */
  type?: ManagedIdentityType;

  /**
   * The principal id of resource identity.
   */
  principalId?: string;

  /**
   * The tenant identifier of resource.
   */
  tenantId?: string;

  /**
   * The client secret URL of the identity.
   */
  clientSecretUrl?: string;

  /**
   * If Type is 'UserAssigned': List of user assigned identities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<Record<unknown>>;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: CreatedByType;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: CreatedByType;

  /**
   * The timestamp of resource last modification (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
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

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * An Operation Result
 */
model OperationResult {
  /**
   * The operation status.
   */
  status?: string;

  /**
   * The status code for the operation.
   */
  statusCode?: HttpStatusCode;

  /**
   * Error details for the operation in case of a failure.
   */
  error?: OperationError;
}

/**
 * Error details for the operation in case of a failure.
 */
model OperationError {
  /**
   * The error code of the operation error.
   */
  code?: string;

  /**
   * The error message of the operation error.
   */
  message?: string;
}

/**
 * Contains a list of schedules and their properties
 */
model ScheduleList is Azure.Core.Page<Schedule>;

/**
 * Properties of a schedule.
 */
model ScheduleProperties {
  /**
   * The status of the schedule (i.e. Enabled, Disabled)
   */
  status?: EnableStatus;

  /**
   * The task type of the schedule (e.g. LabVmsShutdownTask, LabVmAutoStart).
   */
  taskType?: string;

  /**
   * If the schedule will occur only some days of the week, specify the weekly recurrence.
   */
  weeklyRecurrence?: WeekDetails;

  /**
   * If the schedule will occur once each day of the week, specify the daily recurrence.
   */
  dailyRecurrence?: DayDetails;

  /**
   * If the schedule will occur multiple times a day, specify the hourly recurrence.
   */
  hourlyRecurrence?: HourDetails;

  /**
   * The time zone ID (e.g. China Standard Time, Greenland Standard Time, Pacific Standard time, etc.). The possible values for this property can be found in `IReadOnlyCollection<string> TimeZoneConverter.TZConvert.KnownWindowsTimeZoneIds` (https://github.com/mattjohnsonpint/TimeZoneConverter/blob/main/README.md)
   */
  timeZoneId?: string;

  /**
   * Notification settings.
   */
  notificationSettings?: NotificationSettings;

  /**
   * The creation date of the schedule.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The resource ID to which the schedule belongs
   */
  targetResourceId?: string;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Properties of a weekly schedule.
 */
model WeekDetails {
  /**
   * The days of the week for which the schedule is set (e.g. Sunday, Monday, Tuesday, etc.).
   */
  weekdays?: string[];

  /**
   * The time of the day the schedule will occur.
   */
  time?: string;
}

/**
 * Properties of a daily schedule.
 */
model DayDetails {
  /**
   * The time of day the schedule will occur.
   */
  time?: string;
}

/**
 * Properties of an hourly schedule.
 */
model HourDetails {
  /**
   * Minutes of the hour the schedule will run.
   */
  minute?: int32;
}

/**
 * Notification settings for a schedule.
 */
model NotificationSettings {
  /**
   * If notifications are enabled for this schedule (i.e. Enabled, Disabled).
   */
  status?: EnableStatus;

  /**
   * Time in minutes before event at which notification will be sent.
   */
  timeInMinutes?: int32;

  /**
   * The webhook URL to which the notification will be sent.
   */
  webhookUrl?: string;

  /**
   * The email recipient to send notifications to (can be a list of semi-colon separated email addresses).
   */
  emailRecipient?: string;

  /**
   * The locale to use when sending a notification (fallback for unsupported languages is EN).
   */
  notificationLocale?: string;
}

/**
 * Contains a list of artifactSources and their properties
 */
model ArtifactSourceList is Azure.Core.Page<ArtifactSource>;

/**
 * Properties of an artifact source.
 */
model ArtifactSourceProperties {
  /**
   * The artifact source's display name.
   */
  displayName?: string;

  /**
   * The artifact source's URI.
   */
  uri?: string;

  /**
   * The artifact source's type.
   */
  sourceType?: SourceControlType;

  /**
   * The folder containing artifacts.
   */
  folderPath?: string;

  /**
   * The folder containing Azure Resource Manager templates.
   */
  armTemplateFolderPath?: string;

  /**
   * The artifact source's branch reference.
   */
  branchRef?: string;

  /**
   * The security token to authenticate to the artifact source.
   */
  securityToken?: string;

  /**
   * Indicates if the artifact source is enabled (values: Enabled, Disabled).
   */
  status?: EnableStatus;

  /**
   * The artifact source's creation date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Contains a list of armTemplates and their properties
 */
model ArmTemplateList is Azure.Core.Page<ArmTemplate>;

/**
 * Properties of an Azure Resource Manager template.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ArmTemplateProperties {
  /**
   * The display name of the ARM template.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The description of the ARM template.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The publisher of the ARM template.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * The URI to the icon of the ARM template.
   */
  @visibility(Lifecycle.Read)
  icon?: string;

  /**
   * The contents of the ARM template.
   */
  @visibility(Lifecycle.Read)
  contents?: string;

  /**
   * The creation date of the armTemplate.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * File name and parameter values information from all azuredeploy.*.parameters.json for the ARM template.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["fileName"])
  parametersValueFilesInfo?: ParametersValueFileInfo[];

  /**
   * Whether or not ARM template is enabled for use by lab user.
   */
  @visibility(Lifecycle.Read)
  enabled?: boolean;
}

/**
 * A file containing a set of parameter values for an ARM template.
 */
model ParametersValueFileInfo {
  /**
   * File name.
   */
  fileName?: string;

  /**
   * Contents of the file.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parametersValueInfo?: Record<unknown>;
}

/**
 * Contains a list of artifacts and their properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ArtifactList is Azure.Core.Page<Artifact>;

/**
 * Properties of an artifact.
 */
model ArtifactProperties {
  /**
   * The artifact's title.
   */
  @visibility(Lifecycle.Read)
  title?: string;

  /**
   * The artifact's description.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The artifact's publisher.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * The file path to the artifact.
   */
  @visibility(Lifecycle.Read)
  filePath?: string;

  /**
   * The URI to the artifact icon.
   */
  @visibility(Lifecycle.Read)
  icon?: string;

  /**
   * The artifact's target OS.
   */
  @visibility(Lifecycle.Read)
  targetOsType?: string;

  /**
   * The artifact's parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  parameters?: Record<unknown>;

  /**
   * The artifact's creation date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The provisioning status of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ArtifactProvisioningState;
}

/**
 * The provisioning state of the artifact resource.
 */
union ArtifactProvisioningState {

  /**
   * The operation completed successfully.
   */
  Succeeded: "Succeeded",
  /**
   * The operation failed.
   */
  Failed: "Failed",
  /**
   * The operation was canceled before completion.
   */
  Canceled: "Canceled",
  string
}

/**
 * Parameters for generating an ARM template for deploying artifacts.
 */
model GenerateArmTemplateRequest {
  /**
   * The resource name of the virtual machine.
   */
  virtualMachineName?: string;

  /**
   * The parameters of the ARM template.
   */
  parameters?: ParameterInfo[];

  /**
   * The location of the virtual machine.
   */
  location?: string;

  /**
   * Options for uploading the files for the artifact. UploadFilesAndGenerateSasTokens is the default value.
   */
  fileUploadOptions?: FileUploadOption;
}

/**
 * Information about an artifact's parameter.
 */
model ParameterInfo {
  /**
   * The name of the artifact parameter.
   */
  name?: string;

  /**
   * The value of the artifact parameter.
   */
  value?: string;
}

/**
 * Information about a generated ARM template.
 */
model ArmTemplateInfo {
  /**
   * The template's contents.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  template?: Record<unknown>;

  /**
   * The parameters of the ARM template.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  parameters?: Record<unknown>;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model ArtifactSourceFragment extends UpdateResource {}

/**
 * Represents an update resource
 */
model UpdateResource {
  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
  
  /**
   * The identity of the resource.
   */
  identity?: IdentityProperties;
}

/**
 * Properties of a cost item.
 */
model LabCostProperties {
  /**
   * The target cost properties
   */
  targetCost?: TargetCostProperties;

  /**
   * The lab cost summary component of the cost data.
   */
  @visibility(Lifecycle.Read)
  labCostSummary?: LabCostSummaryProperties;

  /**
   * The lab cost details component of the cost data.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["date", "costType", "cost"])
  labCostDetails?: LabCostDetailsProperties[];

  /**
   * The resource cost component of the cost data.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["resourceUid", "resourceType", "resourcePricingTier", "resourceStatus", "resourceId"])
  resourceCosts?: LabResourceCostProperties[];

  /**
   * The currency code of the cost.
   */
  currencyCode?: string;

  /**
   * The start time of the cost data.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * The end time of the cost data.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * The creation date of the cost.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Properties of a cost target.
 */
model TargetCostProperties {
  /**
   * Target cost status
   */
  status?: TargetCostStatus;

  /**
   * Lab target cost
   */
  target?: int32;

  /**
   * Cost thresholds.
   */
  @OpenAPI.extension("x-ms-identifiers", #["thresholdId"])
  costThresholds?: CostThresholdProperties[];

  /**
   * Reporting cycle start date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cycleStartDateTime?: utcDateTime;

  /**
   * Reporting cycle end date.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  cycleEndDateTime?: utcDateTime;

  /**
   * Reporting cycle type.
   */
  cycleType?: ReportingCycleType;
}

/**
 * Properties of a cost threshold item.
 */
model CostThresholdProperties {
  /**
   * The ID of the cost threshold item.
   */
  thresholdId?: string;

  /**
   * The value of the percentage cost threshold.
   */
  percentageThreshold?: PercentageCostThresholdProperties;

  /**
   * Indicates whether this threshold will be displayed on cost charts.
   */
  displayOnChart?: CostThresholdStatus;

  /**
   * Indicates whether notifications will be sent when this threshold is exceeded.
   */
  sendNotificationWhenExceeded?: CostThresholdStatus;

  /**
   * Indicates the datetime when notifications were last sent for this threshold.
   */
  notificationSent?: string;
}

/**
 * Properties of a percentage cost threshold.
 */
model PercentageCostThresholdProperties {
  /**
   * The cost threshold value.
   */
  thresholdValue?: float64;
}

/**
 * The properties of the cost summary.
 */
model LabCostSummaryProperties {
  /**
   * The cost component of the cost item.
   */
  estimatedLabCost?: float64;
}

/**
 * The properties of a lab cost item.
 */
model LabCostDetailsProperties {
  /**
   * The date of the cost item.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  date?: utcDateTime;

  /**
   * The cost component of the cost item.
   */
  cost?: float64;

  /**
   * The type of the cost.
   */
  costType?: CostType;
}

/**
 * The properties of a resource cost item.
 */
model LabResourceCostProperties {
  /**
   * The name of the resource.
   */
  resourcename?: string;

  /**
   * The unique identifier of the resource.
   */
  resourceUid?: string;

  /**
   * The cost component of the resource cost item.
   */
  resourceCost?: float64;

  /**
   * The logical resource type (ex. virtualmachine, storageaccount)
   */
  resourceType?: string;

  @doc("The owner of the resource (ex. janedoe@microsoft.com)")
  resourceOwner?: string;

  /**
   * The category of the resource (ex. Premium_LRS, Standard_DS1)
   */
  resourcePricingTier?: string;

  /**
   * The status of the resource (ex. Active)
   */
  resourceStatus?: string;

  /**
   * The ID of the resource
   */
  resourceId?: string;

  /**
   * The ID of the external resource
   */
  externalResourceId?: string;
}

/**
 * Contains a list of customImages and their properties
 */
model CustomImageList is Azure.Core.Page<CustomImage>;

/**
 * Properties of a custom image.
 */
model CustomImageProperties {
  /**
   * The virtual machine from which the image is to be created.
   */
  vm?: CustomImagePropertiesFromVm;

  /**
   * The VHD from which the image is to be created.
   */
  vhd?: CustomImagePropertiesCustom;

  /**
   * The description of the custom image.
   */
  description?: string;

  /**
   * The author of the custom image.
   */
  author?: string;

  /**
   * The creation date of the custom image.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The Managed Image Id backing the custom image.
   */
  managedImageId?: string;

  /**
   * The Managed Snapshot Id backing the custom image.
   */
  managedSnapshotId?: string;

  /**
   * Storage information about the data disks present in the custom image
   */
  @OpenAPI.extension("x-ms-identifiers", #["lun","storageType"])
  dataDiskStorageInfo?: DataDiskStorageTypeInfo[];

  /**
   * Storage information about the plan related to this custom image
   */
  customImagePlan?: CustomImagePropertiesFromPlan;

  /**
   * Whether or not the custom images underlying offer/plan has been enabled for programmatic deployment
   */
  isPlanAuthorized?: boolean;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Properties for creating a custom image from a virtual machine.
 */
model CustomImagePropertiesFromVm {
  /**
   * The source vm identifier.
   */
  sourceVmId?: string;

  /**
   * The Windows OS information of the VM.
   */
  windowsOsInfo?: WindowsOsInfo;

  /**
   * The Linux OS information of the VM.
   */
  linuxOsInfo?: LinuxOsInfo;
}

/**
 * Information about a Windows OS.
 */
model WindowsOsInfo {
  /**
   * The state of the Windows OS (i.e. NonSysprepped, SysprepRequested, SysprepApplied).
   */
  windowsOsState?: WindowsOsState;
}

/**
 * Information about a Linux OS.
 */
model LinuxOsInfo {
  /**
   * The state of the Linux OS (i.e. NonDeprovisioned, DeprovisionRequested, DeprovisionApplied).
   */
  linuxOsState?: LinuxOsState;
}

/**
 * Properties for creating a custom image from a VHD.
 */
model CustomImagePropertiesCustom {
  /**
   * The image name.
   */
  imageName?: string;

  /**
   * Indicates whether sysprep has been run on the VHD.
   */
  sysPrep?: boolean;

  /**
   * The OS type of the custom image (i.e. Windows, Linux)
   */
  osType: CustomImageOsType;
}

/**
 * Storage information about the data disks present in the custom image
 */
model DataDiskStorageTypeInfo {
  /**
   * Disk Lun
   */
  lun?: string;

  /**
   * Disk Storage Type
   */
  storageType?: StorageType;
}

/**
 * Properties for plan on a custom image.
 */
model CustomImagePropertiesFromPlan {
  /**
   * The id of the plan, equivalent to name of the plan
   */
  id?: string;

  /**
   * The publisher for the plan from the marketplace image the custom image is derived from
   */
  publisher?: string;

  /**
   * The offer for the plan from the marketplace image the custom image is derived from
   */
  offer?: string;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model CustomImageFragment extends UpdateResource {}

/**
 * Contains a list of formulas and their properties
 */
model FormulaList is Azure.Core.Page<Formula>;

/**
 * Properties of a formula.
 */
model FormulaProperties {
  /**
   * The description of the formula.
   */
  description?: string;

  /**
   * The author of the formula.
   */
  @visibility(Lifecycle.Read)
  author?: string;

  /**
   * The OS type of the formula.
   */
  osType?: string;

  /**
   * The creation date of the formula.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The content of the formula.
   */
  formulaContent?: LabVirtualMachineCreationParameter;

  /**
   * Information about a VM from which a formula is to be created.
   */
  vm?: FormulaPropertiesFromVm;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Properties for creating a virtual machine.
 */
model LabVirtualMachineCreationParameter {
  /**
   * The properties of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: LabVirtualMachineCreationParameterProperties;

  /**
   * The name of the virtual machine or environment
   */
  name?: string;

  /**
   * The location of the new virtual machine or environment
   */
  location?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties for virtual machine creation.
 */
model LabVirtualMachineCreationParameterProperties {
  /**
   * The number of virtual machine instances to create.
   */
  bulkCreationParameters?: BulkCreationParameters;

  /**
   * The notes of the virtual machine.
   */
  notes?: string;

  /**
   * The object identifier of the owner of the virtual machine.
   */
  ownerObjectId?: string = "dynamicValue";

  /**
   * The user principal name of the virtual machine owner.
   */
  ownerUserPrincipalName?: string;

  /**
   * The object identifier of the creator of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  createdByUserId?: string;

  /**
   * The email address of creator of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  createdByUser?: string;

  /**
   * The creation date of the virtual machine.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The resource identifier (Microsoft.Compute) of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  computeId?: string;

  /**
   * The custom image identifier of the virtual machine.
   */
  customImageId?: string;

  /**
   * The shared gallery image version resource identifier of the virtual machine.
   */
  galleryImageVersionId?: string;

  /**
   * The shared image resource identifier of the virtual machine.
   */
  sharedImageId?: string;

  /**
   * The shared image version for the specified shared image Id. Will use latest if not specified.
   */
  sharedImageVersion?: string;

  /**
   * The OS type of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * The size of the virtual machine.
   */
  size?: string;

  /**
   * The user name of the virtual machine.
   */
  userName?: string;

  /**
   * The password of the virtual machine administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password?: string;

  /**
   * The SSH key of the virtual machine administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  sshKey?: string;

  /**
   * Indicates whether this virtual machine uses an SSH key for authentication.
   */
  isAuthenticationWithSshKey?: boolean;

  /**
   * The fully-qualified domain name of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The lab subnet name of the virtual machine.
   */
  labSubnetName?: string;

  /**
   * The lab virtual network identifier of the virtual machine.
   */
  labVirtualNetworkId?: string;

  /**
   * Indicates whether the virtual machine is to be created without a public IP address.
   */
  disallowPublicIpAddress?: boolean;

  /**
   * The artifacts to be installed on the virtual machine.
   */
  @OpenAPI.extension("x-ms-identifiers", #["artifactId"])
  artifacts?: ArtifactInstallProperties[];

  /**
   * The artifact deployment status for the virtual machine.
   */
  @visibility(Lifecycle.Read)
  artifactDeploymentStatus?: ArtifactDeploymentStatusProperties;

  /**
   * The Microsoft Azure Marketplace image reference of the virtual machine.
   */
  galleryImageReference?: GalleryImageReference;

  /**
   * The id of the plan associated with the virtual machine image
   */
  planId?: string;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image.
   */
  osDiskSizeGb?: int32;

  /**
   * The compute virtual machine properties.
   */
  @visibility(Lifecycle.Read)
  computeVm?: ComputeVmProperties;

  /**
   * The network interface properties.
   */
  networkInterface?: NetworkInterfaceProperties;

  /**
   * The applicable schedule for the virtual machine.
   */
  @visibility(Lifecycle.Read)
  applicableSchedule?: ApplicableSchedule;

  /**
   * The expiration date for VM.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Indicates whether another user can take ownership of the virtual machine
   */
  allowClaim?: boolean;

  /**
   * Storage type to use for virtual machine (i.e. Standard, Premium, StandardSSD).
   */
  storageType?: StorageType;

  /**
   * Tells source of creation of lab virtual machine. Output property only.
   */
  @visibility(Lifecycle.Read)
  virtualMachineCreationSource?: VirtualMachineCreationSource;

  /**
   * The resource ID of the environment that contains this virtual machine, if any.
   */
  environmentId?: string;

  /**
   * New or existing data disks to attach to the virtual machine after creation
   */
  @OpenAPI.extension("x-ms-identifiers", #["attachNewDataDiskOptions"])
  dataDiskParameters?: DataDiskProperties[];

  /**
   * Virtual Machine schedules to be created
   */
  scheduleParameters?: ScheduleCreationParameter[];

  /**
   * Last known compute power state captured in DTL
   */
  @visibility(Lifecycle.Read)
  lastKnownPowerState?: string;

  /**
   * Flag to determine if apply artifacts can be triggered at the time of fetching the document.
   */
  @visibility(Lifecycle.Read)
  canApplyArtifacts?: boolean;

  /**
   * The provisioning status of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;

  /**
   * Option to apply more security protection for VMs.
   */
  securityProfile?: SecurityProfile;
}

/**
 * Parameters for creating multiple virtual machines as a single action.
 */
model BulkCreationParameters {
  /**
   * The number of virtual machine instances to create.
   */
  instanceCount?: int32;
}

/**
 * Properties of an artifact.
 */
model ArtifactInstallProperties {
  /**
   * The artifact's identifier.
   */
  artifactId?: string;

  /**
   * The artifact's title.
   */
  artifactTitle?: string;

  /**
   * The parameters of the artifact.
   */
  parameters?: ArtifactParameterProperties[];

  /**
   * The status of the artifact.
   */
  status?: string;

  /**
   * The status message from the deployment.
   */
  deploymentStatusMessage?: string;

  /**
   * The status message from the virtual machine extension.
   */
  vmExtensionStatusMessage?: string;

  /**
   * The time that the artifact starts to install on the virtual machine.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  installTime?: utcDateTime;
}

/**
 * Properties of an artifact parameter.
 */
model ArtifactParameterProperties {
  /**
   * The name of the artifact parameter.
   */
  name?: string;

  /**
   * The value of the artifact parameter.
   */
  value?: string;
}

/**
 * Properties of an artifact deployment.
 */
model ArtifactDeploymentStatusProperties {
  /**
   * The deployment status of the artifact.
   */
  deploymentStatus?: string;

  /**
   * The total count of the artifacts that were successfully applied.
   */
  artifactsApplied?: int32;

  /**
   * The total count of the artifacts that were tentatively applied.
   */
  totalArtifacts?: int32;
}

/**
 * The reference information for an Azure Marketplace image.
 */
model GalleryImageReference {
  /**
   * The offer of the gallery image.
   */
  offer?: string;

  /**
   * The publisher of the gallery image.
   */
  publisher?: string;

  /**
   * The SKU of the gallery image.
   */
  sku?: string;

  /**
   * The OS type of the gallery image.
   */
  osType?: string;

  /**
   * The version of the gallery image.
   */
  version?: string;
}

/**
 * Properties of a virtual machine returned by the Microsoft.Compute API.
 */
model ComputeVmProperties {
  /**
   * Gets the statuses of the virtual machine.
   */
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  statuses?: ComputeVmInstanceViewStatus[];

  /**
   * Gets the OS type of the virtual machine.
   */
  osType?: string;

  /**
   * Gets the size of the virtual machine.
   */
  vmSize?: string;

  /**
   * Gets the network interface ID of the virtual machine.
   */
  networkInterfaceId?: string;

  /**
   * Gets OS disk blob uri for the virtual machine.
   */
  osDiskId?: string;

  /**
   * Gets data disks blob uri for the virtual machine.
   */
  dataDiskIds?: string[];

  /**
   * Gets all data disks attached to the virtual machine.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  dataDisks?: ComputeDataDisk[];
}

/**
 * Status information about a virtual machine.
 */
model ComputeVmInstanceViewStatus {
  /**
   * Gets the status Code.
   */
  code?: string;

  /**
   * Gets the short localizable label for the status.
   */
  displayStatus?: string;

  /**
   * Gets the message associated with the status.
   */
  message?: string;
}

/**
 * A data disks attached to a virtual machine.
 */
model ComputeDataDisk {
  /**
   * Gets data disk name.
   */
  name?: string;

  /**
   * When backed by a blob, the URI of underlying blob.
   */
  diskUri?: string;

  /**
   * When backed by managed disk, this is the ID of the compute disk resource.
   */
  managedDiskId?: string;

  /**
   * Gets data disk size in GiB.
   */
  diskSizeGiB?: int32;
}

/**
 * Properties of a network interface.
 */
model NetworkInterfaceProperties {
  /**
   * The resource ID of the virtual network.
   */
  virtualNetworkId?: string;

  /**
   * The resource ID of the sub net.
   */
  subnetId?: string;

  /**
   * The resource ID of the public IP address.
   */
  publicIpAddressId?: string;

  /**
   * The public IP address.
   */
  publicIpAddress?: string;

  /**
   * The private IP address.
   */
  privateIpAddress?: string;

  /**
   * The DNS name.
   */
  dnsName?: string;

  /**
   * The RdpAuthority property is a server DNS host name or IP address followed by the service port number for RDP (Remote Desktop Protocol).
   */
  rdpAuthority?: string;

  /**
   * The SshAuthority property is a server DNS host name or IP address followed by the service port number for SSH.
   */
  sshAuthority?: string;

  /**
   * The configuration for sharing a public IP address across multiple virtual machines.
   */
  sharedPublicIpAddressConfiguration?: SharedPublicIpAddressConfiguration;
}

/**
 * Properties of a virtual machine that determine how it is connected to a load balancer.
 */
model SharedPublicIpAddressConfiguration {
  /**
   * The incoming NAT rules
   */
  @OpenAPI.extension("x-ms-identifiers", #["frontendPort"])
  inboundNatRules?: InboundNatRule[];
}

/**
 * A rule for NAT - exposing a VM's port (backendPort) on the public IP address using a load balancer.
 */
model InboundNatRule {
  /**
   * The transport protocol for the endpoint.
   */
  transportProtocol?: TransportProtocol;

  /**
   * The external endpoint port of the inbound connection. Possible values range between 1 and 65535, inclusive. If unspecified, a value will be allocated automatically.
   */
  frontendPort?: int32;

  /**
   * The port to which the external traffic will be redirected.
   */
  backendPort?: int32;
}

/**
 * Schedules applicable to a virtual machine. The schedules may have been defined on a VM or on lab level.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ApplicableSchedule extends Resource {
  /**
   * The properties of the resource.
   */
  properties: ApplicableScheduleProperties;

  /**
   * The system metadata relating to this resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties of a schedules applicable to a virtual machine.
 */
model ApplicableScheduleProperties {
  /**
   * The auto-shutdown schedule, if one has been set at the lab or lab resource level.
   */
  labVmsShutdown?: Schedule;

  /**
   * The auto-startup schedule, if one has been set at the lab or lab resource level.
   */
  labVmsStartup?: Schedule;
}

/**
 * Request body for adding a new or existing data disk to a virtual machine.
 */
model DataDiskProperties {
  /**
   * Specifies options to attach a new disk to the virtual machine.
   */
  attachNewDataDiskOptions?: AttachNewDataDiskOptions;

  /**
   * Specifies the existing lab disk id to attach to virtual machine.
   */
  existingLabDiskId?: string;

  /**
   * Caching option for a data disk (i.e. None, ReadOnly, ReadWrite).
   */
  hostCaching?: HostCachingOption;
}

/**
 * Properties to attach new disk to the Virtual Machine.
 */
model AttachNewDataDiskOptions {
  /**
   * Size of the disk to be attached in Gibibytes.
   */
  diskSizeGiB?: int32;

  /**
   * The name of the disk to be attached.
   */
  diskName?: string;

  /**
   * The storage type for the disk (i.e. Standard, Premium).
   */
  diskType?: StorageType;
}

/**
 * Properties for creating a schedule.
 */
model ScheduleCreationParameter {
  /**
   * The properties of the schedule.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ScheduleCreationParameterProperties;

  /**
   * The name of the virtual machine or environment
   */
  name?: string;

  /**
   * The location of the new virtual machine or environment
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties for schedule creation.
 */
model ScheduleCreationParameterProperties {
  /**
   * The status of the schedule (i.e. Enabled, Disabled)
   */
  status?: EnableStatus;

  /**
   * The task type of the schedule (e.g. LabVmsShutdownTask, LabVmAutoStart).
   */
  taskType?: string;

  /**
   * If the schedule will occur only some days of the week, specify the weekly recurrence.
   */
  weeklyRecurrence?: WeekDetails;

  /**
   * If the schedule will occur once each day of the week, specify the daily recurrence.
   */
  dailyRecurrence?: DayDetails;

  /**
   * If the schedule will occur multiple times a day, specify the hourly recurrence.
   */
  hourlyRecurrence?: HourDetails;

  /**
   * The time zone ID (e.g. China Standard Time, Greenland Standard Time, Pacific Standard time, etc.). The possible values for this property can be found in `IReadOnlyCollection<string> TimeZoneConverter.TZConvert.KnownWindowsTimeZoneIds` (https://github.com/mattjohnsonpint/TimeZoneConverter/blob/main/README.md)
   */
  timeZoneId?: string;

  /**
   * Notification settings.
   */
  notificationSettings?: NotificationSettings;

  /**
   * The creation date of the schedule.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The resource ID to which the schedule belongs
   */
  targetResourceId?: string;

  /**
   * The provisioning status of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * The security profile settings for a virtual machine.
 */
model SecurityProfile {
  /**
   * The security type of a virtual machine.
   */
  securityType?: string;

  /**
   * Security settings like secure boot and vTPM. Structure must be null if SecurityType string is null.
   */
  uefiSettings?: UefiSettings;

  /**
   * Integrity monitoring enables cryptographic attestation and verification of VM boot integrity along with monitoring alerts if the VM didn't boot because attestation failed with the defined baseline.
   */
  integrityMonitoring?: boolean;
}

/**
 * Security settings like secure boot and vTPM.
 */
model UefiSettings {
  /**
   * Flag to enable or disable secure boot.
   */
  secureBootEnabled?: boolean;

  /**
   * Flag to enable or disable vTPM (virtual Trusted Platform Module).
   */
  vTpmEnabled?: boolean;
}

/**
 * Information about a VM from which a formula is to be created.
 */
model FormulaPropertiesFromVm {
  /**
   * The identifier of the VM from which a formula is to be created.
   */
  labVmId?: string;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model FormulaFragment extends UpdateResource {}

/**
 * Contains a list of galleryImages and their properties
 */
model GalleryImageList is Azure.Core.Page<GalleryImage>;

/**
 * Properties of a gallery image.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model GalleryImageProperties {
  /**
   * The author of the gallery image.
   */
  author?: string;

  /**
   * The creation date of the gallery image.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The description of the gallery image.
   */
  description?: string;

  /**
   * The image reference of the gallery image.
   */
  imageReference?: GalleryImageReference;

  /**
   * The icon of the gallery image.
   */
  icon?: string;

  /**
   * Indicates whether this gallery image is enabled.
   */
  enabled?: boolean;

  /**
   * The third party plan that applies to this image
   */
  planId?: string;

  /**
   * Indicates if the plan has been authorized for programmatic deployment.
   */
  isPlanAuthorized?: boolean;

  /**
   * Generation of the gallery image.
   */
  imageGeneration?: string;

  /**
   * Security type of the gallery image, e.g. 'TrustedLaunch'.
   */
  vmSecurityType?: string;

  /**
   * Architecture type of the gallery image, e.g. 'x64'.
   */
  architectureType?: string;
}

/**
 * Contains a list of notificationChannels and their properties
 */
model NotificationChannelList is Azure.Core.Page<NotificationChannel>;

/**
 * Properties of a schedule.
 */
model NotificationChannelProperties {
  /**
   * The webhook URL to send notifications to.
   */
  webHookUrl?: string;

  /**
   * The email recipient to send notifications to (can be a list of semi-colon separated email addresses).
   */
  emailRecipient?: string;

  /**
   * The locale to use when sending a notification (fallback for unsupported languages is EN).
   */
  notificationLocale?: string;

  /**
   * Description of notification.
   */
  description?: string;

  /**
   * The list of event for which this notification is enabled.
   */
  @OpenAPI.extension("x-ms-identifiers", #["eventName"])
  events?: Event[];

  /**
   * The creation date of the notification channel.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * An event to be notified for.
 */
model Event {
  /**
   * The event type for which this notification is enabled (i.e. AutoShutdown, Cost)
   */
  eventName?: NotificationChannelEventType;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model NotificationChannelFragment extends UpdateResource {}

/**
 * Properties for generating a Notification.
 */
model NotifyParameters {
  /**
   * The type of event (i.e. AutoShutdown, Cost)
   */
  eventName?: NotificationChannelEventType;

  /**
   * Properties for the notification in json format.
   */
  jsonPayload?: string;
}

/**
 * Contains a list of policySets and their properties
 */
model PolicySetList is Azure.Core.Page<PolicySet>;

/**
 * A PolicySet.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PolicySet extends Resource {
  /**
   * The properties of the resource.
   */
  properties?: PolicySetProperties;

  /**
   * The system metadata relating to this resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties of a PolicySet.
 */
model PolicySetProperties {
  /**
   * The provisioning status of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Request body for evaluating a policy set.
 */
model EvaluatePoliciesRequest {
  /**
   * Policies to evaluate.
   */
  @OpenAPI.extension("x-ms-identifiers", #["factName"])
  policies?: EvaluatePoliciesProperties[];
}

/**
 * Properties for evaluating a policy set.
 */
model EvaluatePoliciesProperties {
  /**
   * The fact name.
   */
  factName?: string;

  /**
   * The fact data.
   */
  factData?: string;

  /**
   * The value offset.
   */
  valueOffset?: string;

  /**
   * The user for which policies will be evaluated
   */
  userObjectId?: string;
}

/**
 * Response body for evaluating a policy set.
 */
model EvaluatePoliciesResponse {
  /**
   * Results of evaluating a policy set.
   */
  @OpenAPI.extension("x-ms-identifiers", #["policyViolations"])
  results?: PolicySetResult[];
}

/**
 * Result of a policy set evaluation.
 */
model PolicySetResult {
  /**
   * A value indicating whether this policy set evaluation has discovered violations.
   */
  hasError?: boolean;

  /**
   * The list of policy violations.
   */
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  policyViolations?: PolicyViolation[];
}

/**
 * Policy violation.
 */
model PolicyViolation {
  /**
   * The code of the policy violation.
   */
  code?: string;

  /**
   * The message of the policy violation.
   */
  message?: string;
}

/**
 * Contains a list of policies and their properties
 */
model PolicyList is Azure.Core.Page<Policy>;

/**
 * Properties of a Policy.
 */
model PolicyProperties {
  /**
   * The description of the policy.
   */
  description?: string;

  /**
   * The status of the policy.
   */
  status?: PolicyStatus;

  /**
   * The fact name of the policy (e.g. LabVmCount, LabVmSize, MaxVmsAllowedPerLab, etc.
   */
  factName?: PolicyFactName;

  /**
   * The fact data of the policy.
   */
  factData?: string;

  /**
   * The threshold of the policy (i.e. a number for MaxValuePolicy, and a JSON array of values for AllowedValuesPolicy).
   */
  threshold?: string;

  /**
   * The evaluator type of the policy (i.e. AllowedValuesPolicy, MaxValuePolicy).
   */
  evaluatorType?: PolicyEvaluatorType;

  /**
   * The creation date of the policy.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Contains a list of secrets and their properties
 */
model LabSecretList is Azure.Core.Page<LabSecret>;

/**
 * The properties of labs secrets
 */
model LabSecretProperties {
  /**
   * The value of the secret for secret creation.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;

  /**
   * Is the secret enabled for use with artifacts?
   */
  enabledForArtifacts?: boolean;

  /**
   * Is the secret enabled for use with creation of VMs?
   */
  enabledForVmCreation?: boolean;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model SecretFragment extends UpdateResource {}

/**
 * Contains a list of serviceRunners and their properties
 */
model ServiceRunnerList is Azure.Core.Page<ServiceRunner>;

/**
 * Properties of a virtual machine.
 */
model ServiceRunnerProperties {
  /**
   * The purpose of bringing the identity to the lab. Ex: To use during Environment creation or to deploy on the VMs.
   */
  identityUsageType?: string;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Contains a list of sharedGalleries and their properties
 */
model SharedGalleryList is Azure.Core.Page<SharedGallery>;

/**
 * Properties of a shared gallery
 */
model SharedGalleryProperties {
  /**
   * The shared image gallery resource Id
   */
  galleryId?: string;

  /**
   * Enables all images in the gallery to be available in the lab for VM creation. This will override the EnableState on shared images
   */
  allowAllImages?: EnableState;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model SharedGalleryFragment extends UpdateResource {}

/**
 * Contains a list of sharedImages and their properties
 */
model SharedImageList is Azure.Core.Page<SharedImage>;

/**
 * Properties of a shared image
 */
model SharedImageProperties {
  /**
   * Shared Image definition name in shared image gallery
   */
  definitionName?: string;

  /**
   * The operating system of the image
   */
  osType?: OsType;

  /**
   * The type of image in the gallery (generalized or specialized)
   */
  imageType?: ImageType;

  /**
   * Whether or not the image is enabled.
   */
  enableState?: EnableState;

  /**
   * Display name of the image
   */
  displayName?: string;

  /**
   * List of image versions in definition
   */
  versions?: ImageVersionProperties[];

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Properties for a shared image version.
 */
model ImageVersionProperties {
  /**
   * Image version name
   */
  name?: string;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model SharedImageFragment extends UpdateResource {}

/**
 * Contains a list of users and their properties
 */
model UserList is Azure.Core.Page<LabUser>;

/**
 * Properties of a lab user profile.
 */
model UserProperties {
  /**
   * The identity of the user.
   */
  identity?: UserIdentity;

  /**
   * The secret store of the user.
   */
  secretStore?: UserSecretStore;

  /**
   * The creation date of the user profile.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Identity attributes of a lab user.
 */
model UserIdentity {
  /**
   * Set to the principal name / UPN of the client JWT making the request.
   */
  principalName?: string;

  /**
   * Set to the principal Id of the client JWT making the request. Service principal will not have the principal Id.
   */
  principalId?: string;

  /**
   * Set to the tenant ID of the client JWT making the request.
   */
  tenantId?: string;

  /**
   * Set to the object Id of the client JWT making the request. Not all users have object Id. For CSP (reseller) scenarios for example, object Id is not available.
   */
  objectId?: string;

  /**
   * Set to the app Id of the client JWT making the request.
   */
  appId?: string;
}

/**
 * Properties of a user's secret store.
 */
model UserSecretStore {
  /**
   * The URI of the user's Key vault.
   */
  keyVaultUri?: string;

  /**
   * The ID of the user's Key vault.
   */
  keyVaultId?: string;
}

/**
 * Contains a list of disks and their properties
 */
model DiskList is Azure.Core.Page<Disk>;

/**
 * Properties of a disk.
 */
model DiskProperties {
  /**
   * The storage type for the disk (i.e. Standard, Premium).
   */
  diskType?: StorageType;

  /**
   * The size of the disk in Gibibytes.
   */
  diskSizeGiB?: int32;

  /**
   * The resource ID of the VM to which this disk is leased.
   */
  leasedByLabVmId?: string;

  /**
   * When backed by a blob, the name of the VHD blob without extension.
   */
  diskBlobName?: string;

  /**
   * When backed by a blob, the URI of underlying blob.
   */
  diskUri?: string;

  /**
   * When backed by a blob, the storage account where the blob is.
   */
  storageAccountId?: string;

  /**
   * The creation date of the disk.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The host caching policy of the disk (i.e. None, ReadOnly, ReadWrite).
   */
  hostCaching?: string;

  /**
   * When backed by managed disk, this is the ID of the compute disk resource.
   */
  managedDiskId?: string;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model DiskFragment extends UpdateResource {}

/**
 * Properties of the disk to attach.
 */
model AttachDiskProperties {
  /**
   * The resource ID of the Lab virtual machine to which the disk is attached.
   */
  leasedByLabVmId?: string;
}

/**
 * Properties of the disk to detach.
 */
model DetachDiskProperties {
  /**
   * The resource ID of the Lab VM to which the disk is attached.
   */
  leasedByLabVmId?: string;
}

/**
 * Contains a list of environments and their properties
 */
model DtlEnvironmentList is Azure.Core.Page<DtlEnvironment>;

/**
 * Properties of an environment.
 */
model EnvironmentProperties {
  /**
   * The deployment properties of the environment.
   */
  deploymentProperties?: EnvironmentDeploymentProperties;

  /**
   * The display name of the Azure Resource Manager template that produced the environment.
   */
  armTemplateDisplayName?: string;

  /**
   * The identifier of the resource group containing the environment's resources.
   */
  @visibility(Lifecycle.Read)
  resourceGroupId?: string;

  /**
   * The creator of the environment.
   */
  @visibility(Lifecycle.Read)
  createdByUser?: string;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Properties of an environment deployment.
 */
model EnvironmentDeploymentProperties {
  /**
   * The Azure Resource Manager template's identifier.
   */
  armTemplateId?: string;

  /**
   * The parameters of the Azure Resource Manager template.
   */
  parameters?: ArmTemplateParameterProperties[];
}

/**
 * Properties of an Azure Resource Manager template parameter.
 */
model ArmTemplateParameterProperties {
  /**
   * The name of the template parameter.
   */
  name?: string;

  /**
   * The value of the template parameter.
   */
  value?: string;
}

/**
 * Contains a list of secrets and their properties
 */
model SecretList is Azure.Core.Page<Secret>;

/**
 * Properties of a secret.
 */
model SecretProperties {
  /**
   * The value of the secret for secret creation.
   */
  value?: string;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Contains a list of serviceFabrics and their properties
 */
model ServiceFabricList is Azure.Core.Page<ServiceFabric>;

/**
 * Properties of a service fabric.
 */
model ServiceFabricProperties {
  /**
   * The backing service fabric resource's id
   */
  externalServiceFabricId?: string;

  /**
   * The resource id of the environment under which the service fabric resource is present
   */
  environmentId?: string;

  /**
   * The applicable schedule for the virtual machine.
   */
  @visibility(Lifecycle.Read)
  applicableSchedule?: ApplicableSchedule;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Patch
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "For backward compatibility"
model ServiceFabricFragment extends UpdateResource {}

/**
 * Contains a list of virtualMachines and their properties
 */
model LabVirtualMachineList is Azure.Core.Page<LabVirtualMachine>;

/**
 * Properties of a virtual machine.
 */
model LabVirtualMachineProperties {
  /**
   * The notes of the virtual machine.
   */
  notes?: string;

  /**
   * The object identifier of the owner of the virtual machine.
   */
  ownerObjectId?: string = "dynamicValue";

  /**
   * The user principal name of the virtual machine owner.
   */
  ownerUserPrincipalName?: string;

  /**
   * The object identifier of the creator of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  createdByUserId?: string;

  /**
   * The email address of creator of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  createdByUser?: string;

  /**
   * The creation date of the virtual machine.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The resource identifier (Microsoft.Compute) of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  computeId?: string;

  /**
   * The custom image identifier of the virtual machine.
   */
  customImageId?: string;

  /**
   * The shared gallery image version resource identifier of the virtual machine.
   */
  galleryImageVersionId?: string;

  /**
   * The shared image resource identifier of the virtual machine.
   */
  sharedImageId?: string;

  /**
   * The shared image version for the specified shared image Id. Will use latest if not specified.
   */
  sharedImageVersion?: string;

  /**
   * The OS type of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  osType?: string;

  /**
   * The size of the virtual machine.
   */
  size?: string;

  /**
   * The user name of the virtual machine.
   */
  userName?: string;

  /**
   * The password of the virtual machine administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password?: string;

  /**
   * The SSH key of the virtual machine administrator.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  sshKey?: string;

  /**
   * Indicates whether this virtual machine uses an SSH key for authentication.
   */
  isAuthenticationWithSshKey?: boolean;

  /**
   * The fully-qualified domain name of the virtual machine.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The lab subnet name of the virtual machine.
   */
  labSubnetName?: string;

  /**
   * The lab virtual network identifier of the virtual machine.
   */
  labVirtualNetworkId?: string;

  /**
   * Indicates whether the virtual machine is to be created without a public IP address.
   */
  disallowPublicIpAddress?: boolean;

  /**
   * The artifacts to be installed on the virtual machine.
   */
  @OpenAPI.extension("x-ms-identifiers", #["artifactId"])
  artifacts?: ArtifactInstallProperties[];

  /**
   * The artifact deployment status for the virtual machine.
   */
  @visibility(Lifecycle.Read)
  artifactDeploymentStatus?: ArtifactDeploymentStatusProperties;

  /**
   * The Microsoft Azure Marketplace image reference of the virtual machine.
   */
  galleryImageReference?: GalleryImageReference;

  /**
   * The id of the plan associated with the virtual machine image
   */
  planId?: string;

  /**
   * Specifies the size of an empty data disk in gigabytes. This element can be used to overwrite the size of the disk in a virtual machine image.
   */
  osDiskSizeGb?: int32;

  /**
   * The compute virtual machine properties.
   */
  @visibility(Lifecycle.Read)
  computeVm?: ComputeVmProperties;

  /**
   * The network interface properties.
   */
  networkInterface?: NetworkInterfaceProperties;

  /**
   * The applicable schedule for the virtual machine.
   */
  @visibility(Lifecycle.Read)
  applicableSchedule?: ApplicableSchedule;

  /**
   * The expiration date for VM.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Indicates whether another user can take ownership of the virtual machine
   */
  allowClaim?: boolean;

  /**
   * Storage type to use for virtual machine (i.e. Standard, Premium, StandardSSD).
   */
  storageType?: StorageTypes = StorageTypes.Standard;

  /**
   * Tells source of creation of lab virtual machine. Output property only.
   */
  @visibility(Lifecycle.Read)
  virtualMachineCreationSource?: VirtualMachineCreationSource;

  /**
   * The resource ID of the environment that contains this virtual machine, if any.
   */
  environmentId?: string;

  /**
   * New or existing data disks to attach to the virtual machine after creation
   */
  @OpenAPI.extension("x-ms-identifiers", #["attachNewDataDiskOptions"])
  dataDiskParameters?: DataDiskProperties[];

  /**
   * Virtual Machine schedules to be created
   */
  scheduleParameters?: ScheduleCreationParameter[];

  /**
   * Last known compute power state captured in DTL
   */
  @visibility(Lifecycle.Read)
  lastKnownPowerState?: string;

  /**
   * Flag to determine if apply artifacts can be triggered at the time of fetching the document.
   */
  @visibility(Lifecycle.Read)
  canApplyArtifacts?: boolean;

  /**
   * Option to apply more security protection for VMs.
   */
  securityProfile?: SecurityProfile;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Request body for applying artifacts to a virtual machine.
 */
model ApplyArtifactsRequest {
  /**
   * The list of artifacts to apply.
   */
  @OpenAPI.extension("x-ms-identifiers", #["artifactId"])
  artifacts?: ArtifactInstallProperties[];
}

/**
 * Properties for changing security profile of a virtual machine.
 */
model ChangeSecurityProfileProperties {
  /**
   * Option to apply more security protection for VMs.
   */
  securityProfile?: SecurityProfile;
}

/**
 * Request body for detaching data disk from a virtual machine.
 */
model DetachDataDiskProperties {
  /**
   * Specifies the disk resource ID to detach from virtual machine.
   */
  existingLabDiskId?: string;
}

/**
 * Represents a .rdp file
 */
model RdpConnection {
  /**
   * The contents of the .rdp file
   */
  contents?: string;
}

/**
 * Request body for resizing a virtual machine.
 */
model ResizeLabVirtualMachineProperties {
  /**
   * Specifies the size of the virtual machine.
   */
  size?: string;
}

/**
 * Contains a list of virtualNetworks and their properties
 */
model VirtualNetworkList is Azure.Core.Page<VirtualNetwork>;

/**
 * Properties of a virtual network.
 */
model VirtualNetworkProperties {
  /**
   * The allowed subnets of the virtual network.
   */
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  allowedSubnets?: Subnet[];

  /**
   * The description of the virtual network.
   */
  description?: string;

  /**
   * The Microsoft.Network resource identifier of the virtual network.
   */
  externalProviderResourceId?: string;

  /**
   * The external subnet properties.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  externalSubnets?: ExternalSubnet[];

  /**
   * The subnet overrides of the virtual network.
   */
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  subnetOverrides?: SubnetOverride[];

  /**
   * The creation date of the virtual network.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdDate?: utcDateTime;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * Subnet information.
 */
model Subnet {
  /**
   * The resource ID of the subnet.
   */
  resourceId?: string;

  /**
   * The name of the subnet as seen in the lab.
   */
  labSubnetName?: string;

  /**
   * The permission policy of the subnet for allowing public IP addresses (i.e. Allow, Deny)).
   */
  allowPublicIp?: UsagePermissionType;
}

/**
 * Subnet information as returned by the Microsoft.Network API.
 */
model ExternalSubnet {
  /**
   * Gets or sets the identifier.
   */
  id?: string;

  /**
   * Gets or sets the name.
   */
  name?: string;
}

/**
 * Property overrides on a subnet of a virtual network.
 */
model SubnetOverride {
  /**
   * The resource ID of the subnet.
   */
  resourceId?: string;

  /**
   * The name given to the subnet within the lab.
   */
  labSubnetName?: string;

  /**
   * Indicates whether this subnet can be used during virtual machine creation (i.e. Allow, Deny).
   */
  useInVmCreationPermission?: UsagePermissionType;

  /**
   * Indicates whether public IP addresses can be assigned to virtual machines on this subnet (i.e. Allow, Deny).
   */
  usePublicIpAddressPermission?: UsagePermissionType;

  /**
   * Properties that virtual machines on this subnet will share.
   */
  sharedPublicIpAddressConfiguration?: SubnetSharedPublicIpAddressConfiguration;

  /**
   * The virtual network pool associated with this subnet.
   */
  virtualNetworkPoolName?: string;
}

/**
 * Configuration for public IP address sharing.
 */
model SubnetSharedPublicIpAddressConfiguration {
  /**
   * Backend ports that virtual machines on this subnet are allowed to expose
   */
  @OpenAPI.extension("x-ms-identifiers", #["backendPort"])
  allowedPorts?: Port[];
}

/**
 * Properties of a network port.
 */
model Port {
  /**
   * Protocol type of the port.
   */
  transportProtocol?: TransportProtocol;

  /**
   * Backend port of the target virtual machine.
   */
  backendPort?: int32;
}


/**
 * Contains a list of bastionHosts and their properties
 */
model BastionHostList is Azure.Core.Page<BastionHost>;

/**
 * Properties of a BastionHost profile.
 */
model BastionHostProperties {
  /**
   * The ID of the external BastionHost resource that corresponds to this DTL BastionHost
   */
  @visibility(Lifecycle.Read)
  externalBastionHostId?: string;

  /**
   * The ID of the PublicIpAddress resource that is created by and paired with this BastionHost
   */
  @visibility(Lifecycle.Read)
  ipAddressId?: string;

  /**
   * The provisioning status of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * The unique immutable identifier of a resource (Guid).
   */
  @visibility(Lifecycle.Read)
  uniqueIdentifier?: string;
}

/**
 * The parameters of the export operation.
 */
model ExportResourceUsageParameters {
  /**
   * The blob storage absolute sas uri with write permission to the container which the usage data needs to be uploaded to.
   */
  blobStorageAbsoluteSasUri?: string;

  /**
   * The start time of the usage. If not provided, usage will be reported since the beginning of data collection.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  usageStartDate?: utcDateTime;
}

/**
 * Properties for generating an upload URI.
 */
model GenerateUploadUriParameter {
  /**
   * The blob name of the upload URI.
   */
  blobName?: string;
}

/**
 * Response body for generating an upload URI.
 */
model GenerateUploadUriResponse {
  /**
   * The upload URI for the VHD.
   */
  uploadUri?: string;
}

/**
 * This represents the payload required to import a virtual machine from a different lab into the current one
 */
model ImportLabVirtualMachineRequest {
  /**
   * The full resource ID of the virtual machine to be imported.
   */
  sourceVirtualMachineResourceId?: string;

  /**
   * The name of the virtual machine in the destination lab
   */
  destinationVirtualMachineName?: string;
}

/**
 * Contains a list of Lab Vhd and their properties
 */
model LabVhdList is Azure.Core.Page<LabVhd>;

/**
 * Properties of a VHD in the lab.
 */
model LabVhd {
  /**
   * The URI to the VHD.
   */
  id?: string;
}

/**
 * Properties for retargeting a virtual machine schedule.
 */
model RetargetScheduleProperties {
  /**
   * The resource Id of the virtual machine on which the schedule operates
   */
  currentResourceId?: string;

  /**
   * The resource Id of the virtual machine that the schedule should be retargeted to
   */
  targetResourceId?: string;
}

/**
 * A cost item.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Cost extends Resource {
  /**
   * The properties of the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties: LabCostProperties;

  /**
   * The system metadata relating to this resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties for plan on a custom image.
 */
model CustomImagePropertiesFromPlanFragment {
  /**
   * The id of the plan, equivalent to name of the plan
   */
  id?: string;

  /**
   * The publisher for the plan from the marketplace image the custom image is derived from
   */
  publisher?: string;

  /**
   * The offer for the plan from the marketplace image the custom image is derived from
   */
  offer?: string;
}

/**
 * Contains a list of costs and their properties
 */
model LabCostList {
  /**
   * List of costs and their properties
   */
  value?: LabCost[];

  /**
   * URL to get the next set of operation list results if there are any
   */
  nextLink?: string;
}


/**
 * Properties of a weekly schedule.
 */
model WeekDetailsFragment {
  /**
   * The days of the week for which the schedule is set (e.g. Sunday, Monday, Tuesday, etc.).
   */
  weekdays?: string[];

  /**
   * The time of the day the schedule will occur.
   */
  time?: string;
}
