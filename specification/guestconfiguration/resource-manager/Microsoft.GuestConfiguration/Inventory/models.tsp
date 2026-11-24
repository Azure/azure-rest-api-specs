import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.GuestConfiguration;

// ============================================================================
// Applications
// ============================================================================

/**
 * Properties of an installed application inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model ApplicationProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * Installed version string.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * Vendor or publisher of the application.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * CPU architecture of the installed package.
   */
  @visibility(Lifecycle.Read)
  architecture?: string;

  /**
   * Application type classification.
   */
  @visibility(Lifecycle.Read)
  applicationType?: string;

  /**
   * Human-readable display name of the application.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Product code that identifies the installed application.
   */
  @visibility(Lifecycle.Read)
  productCode?: string;

  /**
   * Package code that identifies the installed package.
   */
  @visibility(Lifecycle.Read)
  packageCode?: string;

  /**
   * Free-text description of the application.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Date and time the application was installed.
   */
  @visibility(Lifecycle.Read)
  installDate?: utcDateTime;

  /**
   * Filesystem path where the application is installed.
   */
  @visibility(Lifecycle.Read)
  installLocation?: string;

  /**
   * Original media path or URL the installer was run from.
   */
  @visibility(Lifecycle.Read)
  installSource?: string;

  /**
   * Source from which the application package was installed.
   */
  @visibility(Lifecycle.Read)
  packageSource?: string;

  /**
   * URL associated with the installed application.
   */
  @visibility(Lifecycle.Read)
  url?: url;

  /**
   * Registry-derived command to remove the application.
   */
  @visibility(Lifecycle.Read)
  uninstallString?: string;
}

// ============================================================================
// Certificates
// ============================================================================

/**
 * Properties of a certificate inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model CertificateProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * Subject distinguished name of the certificate.
   */
  @visibility(Lifecycle.Read)
  subject?: string;

  /**
   * Distinguished name of the certificate authority that issued the certificate.
   */
  @visibility(Lifecycle.Read)
  issuer?: string;

  /**
   * Start date of the certificate validity period.
   */
  @visibility(Lifecycle.Read)
  notBefore?: utcDateTime;

  /**
   * Expiration date of the certificate.
   */
  @visibility(Lifecycle.Read)
  notAfter?: utcDateTime;

  /**
   * SHA-1 hash of the certificate (legacy thumbprint).
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Serial number assigned to the certificate by its issuer.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Whether the certificate has an associated private key.
   */
  @visibility(Lifecycle.Read)
  hasPrivateKey?: boolean;

  /**
   * Public key algorithm type.
   */
  @visibility(Lifecycle.Read)
  keyAlgorithm?: string;

  /**
   * Length of the public key in bits.
   */
  @visibility(Lifecycle.Read)
  keySize?: int32;

  /**
   * Key usage flags defining permitted cryptographic operations.
   */
  @visibility(Lifecycle.Read)
  keyUsage?: string[];

  /**
   * Extended key usage purposes (Server Auth, Client Auth, Code Signing, etc.).
   */
  @visibility(Lifecycle.Read)
  eku?: string[];

  /**
   * Subject alternative names (SANs) from the certificate.
   */
  @visibility(Lifecycle.Read)
  san?: string[];
}

// ============================================================================
// Server Roles
// ============================================================================

/**
 * Properties of a device info inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model DeviceInfoProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * The BIOS version reported by the system.
   */
  @visibility(Lifecycle.Read)
  biosVersion?: string;

  /**
   * The BIOS release date reported by the system.
   */
  @visibility(Lifecycle.Read)
  biosReleaseDate?: utcDateTime;

  /**
   * The system manufacturer name.
   */
  @visibility(Lifecycle.Read)
  systemManufacturer?: string;

  /**
   * The system product name.
   */
  @visibility(Lifecycle.Read)
  systemProductName?: string;
}

/**
 * Properties of a firmware inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model FirmwareResourceProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * The list of firmware class identifiers (typically GUIDs).
   */
  @visibility(Lifecycle.Read)
  firmwareClass?: string[];
}

// ============================================================================
// Windows Roles
// ============================================================================

/**
 * Properties of a windows role inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model WindowsRoleProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * Human-readable display name of the feature.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Free-text description of the feature's purpose.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Current installation state of the feature on this machine.
   */
  @visibility(Lifecycle.Read)
  installedState?: string;

  /**
   * Installation path of the Windows role.
   */
  @visibility(Lifecycle.Read)
  path?: string;

  /**
   * Parent role of this Windows role.
   */
  @visibility(Lifecycle.Read)
  parentRole?: string;

  /**
   * Roles or features that this Windows role depends on.
   */
  @visibility(Lifecycle.Read)
  dependsOn?: string[];

  /**
   * Child features included in this Windows role.
   */
  @visibility(Lifecycle.Read)
  subFeatures?: string[];
}

// ============================================================================
// Users
// ============================================================================

/**
 * Properties of a user account inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model UserProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * The full display name of the user.
   */
  @visibility(Lifecycle.Read)
  fullName?: string;

  /**
   * Free-text description of the account's purpose.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The Security Identifier — unique, immutable ID.
   */
  @visibility(Lifecycle.Read)
  sid?: string;

  /**
   * The domain or machine name the account belongs to.
   */
  @visibility(Lifecycle.Read)
  domain?: string;

  /**
   * Whether the account is currently active and can log in.
   */
  @visibility(Lifecycle.Read)
  enabled?: boolean;

  /**
   * Whether the account is currently locked out.
   */
  @visibility(Lifecycle.Read)
  lockout?: boolean;

  /**
   * Whether the user is allowed to change their own password.
   */
  @visibility(Lifecycle.Read)
  userPasswordChangePermission?: boolean;

  /**
   * Whether the account's password has an expiration date set.
   */
  @visibility(Lifecycle.Read)
  passwordExpires?: boolean;

  /**
   * Password expiration time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserve the collector's passwordExpiresInUTC field name."
  @visibility(Lifecycle.Read)
  passwordExpiresInUTC?: utcDateTime;

  /**
   * The date and time when the password was last changed.
   */
  @visibility(Lifecycle.Read)
  passwordLastSet?: utcDateTime;

  /**
   * Whether a password is required to log in.
   */
  @visibility(Lifecycle.Read)
  passwordRequired?: boolean;

  /**
   * The date when the entire account expires.
   */
  @visibility(Lifecycle.Read)
  accountExpires?: utcDateTime;
}

// ============================================================================
// Services
// ============================================================================

/**
 * Properties of a service inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model ServiceProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * Human-readable name shown in the Services console.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Classification of the service (own process, shared, kernel driver, etc.).
   */
  @visibility(Lifecycle.Read)
  serviceType?: string;

  /**
   * Free-text summary of what the service does.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Current runtime state: Running, Stopped, Paused.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Detailed runtime state including transitional states.
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * The OS process ID (PID) of the running service instance.
   */
  @visibility(Lifecycle.Read)
  processId?: int32;

  /**
   * How the service is configured to launch (Auto, Manual, Disabled).
   */
  @visibility(Lifecycle.Read)
  startType?: string;

  /**
   * Fully qualified path to the service binary.
   */
  @visibility(Lifecycle.Read)
  pathName?: string;

  /**
   * The account name under which the service runs.
   */
  @visibility(Lifecycle.Read)
  userName?: string;

  /**
   * Whether the service can be paused and resumed.
   */
  @visibility(Lifecycle.Read)
  acceptPause?: boolean;

  /**
   * Whether the service can be stopped.
   */
  @visibility(Lifecycle.Read)
  acceptStop?: boolean;

  /**
   * Whether automatic startup is delayed.
   */
  @visibility(Lifecycle.Read)
  delayedAutoStart?: boolean;

  /**
   * Whether the service has started.
   */
  @visibility(Lifecycle.Read)
  started?: boolean;

  /**
   * The exit code from the last service termination.
   */
  @visibility(Lifecycle.Read)
  exitCode?: int32;

  /**
   * Severity of the error if this service fails to start during startup.
   */
  @visibility(Lifecycle.Read)
  errorControl?: string;

  /**
   * The checkpoint value from the last service state update.
   */
  @visibility(Lifecycle.Read)
  checkPoint?: int32;

  /**
   * Whether the service can interact with the desktop.
   */
  @visibility(Lifecycle.Read)
  desktopInteract?: boolean;
}

// ============================================================================
// Groups
// ============================================================================

/**
 * Properties of a group inventory item.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Inventory resources are read-only reflections of guest OS state observed by the GuestConfiguration agent. They only expose GET and LIST -- no create, update, or delete -- so a provisioningState field would be a constant 'Succeeded' carrying zero semantic information."
model GroupProperties {
  /**
   * The date and time when the inventory item was last observed on the machine.
   */
  @visibility(Lifecycle.Read)
  lastObservedAt?: utcDateTime;

  /**
   * Unique identifier for the group.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * Whether this group is a local account.
   */
  @visibility(Lifecycle.Read)
  localAccount?: boolean;

  /**
   * Free-text comment describing the group's purpose.
   */
  @visibility(Lifecycle.Read)
  comment?: string;

  /**
   * List of user accounts and/or nested groups that are members of this group.
   */
  @visibility(Lifecycle.Read)
  members?: string[];
}

// ============================================================================
// ARM extension resource models
// ============================================================================

/**
 * An application inventory resource.
 */
model Application
  is Azure.ResourceManager.ExtensionResource<ApplicationProperties> {
  /**
   * Name of the application inventory item.
   */
  @key("applicationName")
  @segment("applications")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * A certificate inventory resource.
 */
model Certificate
  is Azure.ResourceManager.ExtensionResource<CertificateProperties> {
  /**
   * Thumbprint of the certificate.
   */
  @key("certificateName")
  @segment("certificates")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * A device info inventory resource.
 */
model DeviceInfo
  is Azure.ResourceManager.ExtensionResource<DeviceInfoProperties> {
  /**
   * The system product name, used as the unique identifier for the device info inventory item.
   */
  @key("deviceInfoName")
  @segment("deviceInfos")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * A firmware inventory resource.
 */
model FirmwareResource
  is Azure.ResourceManager.ExtensionResource<FirmwareResourceProperties> {
  /**
   * The firmware class, used as the unique identifier for the firmware inventory item.
   */
  @key("firmwareResourceName")
  @segment("firmwareResources")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * A windows role inventory resource.
 */
model WindowsRole
  is Azure.ResourceManager.ExtensionResource<WindowsRoleProperties> {
  /**
   * Name of the windows role.
   */
  @key("windowsRoleName")
  @segment("windowsRoles")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * A user account inventory resource.
 */
model User is Azure.ResourceManager.ExtensionResource<UserProperties> {
  /**
   * Login name of the user account.
   */
  @key("userName")
  @segment("users")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * A service inventory resource.
 */
model Service is Azure.ResourceManager.ExtensionResource<ServiceProperties> {
  /**
   * Name of the service.
   */
  @key("serviceName")
  @segment("services")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * A group inventory resource.
 */
model Group is Azure.ResourceManager.ExtensionResource<GroupProperties> {
  /**
   * Name of the group.
   */
  @key("groupName")
  @segment("groups")
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  @maxLength(128)
  @visibility(Lifecycle.Read)
  name: string;
}

// ============================================================================
// List response models
// ============================================================================

/**
 * The response of the list applications operation.
 */
model ApplicationList {
  /**
   * List of application inventory items.
   */
  @pageItems
  value?: Application[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The response of the list certificates operation.
 */
model CertificateList {
  /**
   * List of certificate inventory items.
   */
  @pageItems
  value?: Certificate[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The response of the list device info operation.
 */
model DeviceInfoList {
  /**
   * List of device info inventory items.
   */
  @pageItems
  value?: DeviceInfo[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The response of the list firmware resources operation.
 */
model FirmwareResourceList {
  /**
   * List of firmware inventory items.
   */
  @pageItems
  value?: FirmwareResource[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The response of the list windows roles operation.
 */
model WindowsRoleList {
  /**
   * List of windows role inventory items.
   */
  @pageItems
  value?: WindowsRole[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The response of the list users operation.
 */
model UserList {
  /**
   * List of user inventory items.
   */
  @pageItems
  value?: User[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The response of the list services operation.
 */
model ServiceList {
  /**
   * List of service inventory items.
   */
  @pageItems
  value?: Service[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}

/**
 * The response of the list groups operation.
 */
model GroupList {
  /**
   * List of group inventory items.
   */
  @pageItems
  value?: Group[];

  /** The link to the next page of items. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}
