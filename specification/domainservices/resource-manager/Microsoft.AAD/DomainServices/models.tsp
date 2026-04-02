import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AAD;

/**
 * A flag to determine whether or not Secure LDAP is enabled or disabled.
 */
union Ldaps {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not Secure LDAP access over the internet is enabled or disabled.
 */
union ExternalAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not NtlmV1 is enabled or disabled.
 */
union NtlmV1 {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not TlsV1 is enabled or disabled.
 */
union TlsV1 {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not SyncNtlmPasswords is enabled or disabled.
 */
union SyncNtlmPasswords {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not SyncKerberosPasswords is enabled or disabled.
 */
union SyncKerberosPasswords {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not SyncOnPremPasswords is enabled or disabled.
 */
union SyncOnPremPasswords {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not KerberosRc4Encryption is enabled or disabled.
 */
union KerberosRc4Encryption {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not KerberosArmoring is enabled or disabled.
 */
union KerberosArmoring {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not LdapSigning is enabled or disabled.
 */
union LdapSigning {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether or not ChannelBinding is enabled or disabled.
 */
union ChannelBinding {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * A flag to determine whether the SyncOnPremSamAccountName feature is active. When enabled, the samAccountName attribute in Entra Domain Services is synchronized from the onPremisesSamAccountName attribute in Entra ID
 */
union SyncOnPremSamAccountName {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Enabled or Disabled flag to turn on Group-based filtered sync
 */
union FilteredSync {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * All or CloudOnly, All users in AAD are synced to AAD DS domain or only users actively syncing in the cloud
 */
union SyncScope {
  string,

  /**
   * All
   */
  All: "All",

  /**
   * CloudOnly
   */
  CloudOnly: "CloudOnly",
}

/**
 * Should global admins be notified
 */
union NotifyGlobalAdmins {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Should domain controller admins be notified
 */
union NotifyDcAdmins {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Status for individual validator after running diagnostics.
 */
union Status {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Running
   */
  Running: "Running",

  /**
   * OK
   */
  OK: "OK",

  /**
   * Failure
   */
  Failure: "Failure",

  /**
   * Warning
   */
  Warning: "Warning",

  /**
   * Skipped
   */
  Skipped: "Skipped",
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
 * Response for successful unsuspend of a domain service.
 */
model UnsuspendDomainServiceResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  message?: string;
}

/**
 * An error response from the Domain Services.
 */
@error
model CloudError {
  /**
   * An error response from the Domain Services.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the Domain Services.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  details?: CloudErrorBody[];
}

/**
 * The operation supported by Domain Services.
 */
model OperationEntity {
  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The operation supported by Domain Services.
   */
  display?: OperationDisplayInfo;

  /**
   * The origin of the operation.
   */
  origin?: string;
}

/**
 * The operation supported by Domain Services.
 */
model OperationDisplayInfo {
  /**
   * The description of the operation.
   */
  description?: string;

  /**
   * The action that users can perform, based on their permission level.
   */
  operation?: string;

  /**
   * Service provider: Domain Services.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed.
   */
  resource?: string;
}

/**
 * Properties of the Domain Service.
 */
model DomainServiceProperties {
  /**
   * Data Model Version
   */
  @visibility(Lifecycle.Read)
  version?: int32;

  /**
   * Azure Active Directory Tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The name of the Azure domain that the user would like to deploy Domain Services to.
   */
  domainName?: string;

  /**
   * Deployment Id
   */
  @visibility(Lifecycle.Read)
  deploymentId?: string;

  /**
   * SyncOwner ReplicaSet Id
   */
  @visibility(Lifecycle.Read)
  syncOwner?: string;

  /**
   * The unique sync application id of the Azure AD Domain Services deployment.
   */
  @visibility(Lifecycle.Read)
  syncApplicationId?: string;

  /**
   * List of ReplicaSets
   */
  replicaSets?: ReplicaSet[];

  /**
   * Secure LDAP Settings
   */
  ldapsSettings?: LdapsSettings;

  /**
   * Resource Forest Settings
   */
  resourceForestSettings?: ResourceForestSettings;

  /**
   * DomainSecurity Settings
   */
  domainSecuritySettings?: DomainSecuritySettings;

  /**
   * Domain Configuration Type
   */
  domainConfigurationType?: string;

  /**
   * Sku Type
   */
  sku?: string;

  /**
   * Enabled or Disabled flag to turn on Group-based filtered sync
   */
  filteredSync?: FilteredSync;

  /**
   * All or CloudOnly, All users in AAD are synced to AAD DS domain or only users actively syncing in the cloud
   */
  syncScope?: SyncScope = SyncScope.All;

  /**
   * Notification Settings
   */
  notificationSettings?: NotificationSettings;

  /**
   * Migration Properties
   */
  @visibility(Lifecycle.Read)
  migrationProperties?: MigrationProperties;

  /**
   * the current deployment or provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Configuration diagnostics data containing latest execution from client.
   */
  configDiagnostics?: ConfigDiagnostics;
}

/**
 * Replica Set Definition
 */
model ReplicaSet {
  /**
   * ReplicaSet Id
   */
  @visibility(Lifecycle.Read)
  replicaSetId?: string;

  /**
   * Virtual network location
   */
  location?: string;

  /**
   * Virtual network site id
   */
  @visibility(Lifecycle.Read)
  vnetSiteId?: string;

  /**
   * The name of the virtual network that Domain Services will be deployed on. The id of the subnet that Domain Services will be deployed on. /virtualNetwork/vnetName/subnets/subnetName.
   */
  subnetId?: string;

  /**
   * List of Domain Controller IP Address
   */
  @visibility(Lifecycle.Read)
  domainControllerIpAddress?: string[];

  /**
   * External access ip address.
   */
  @visibility(Lifecycle.Read)
  externalAccessIpAddress?: string;

  /**
   * Status of Domain Service instance
   */
  @visibility(Lifecycle.Read)
  serviceStatus?: string;

  /**
   * Number of times the customer has self-resumed the domain service. Valid values range from 0 to 5, where 5 is the maximum allowed count before further self-resume is denied and support intervention is required.
   */
  @visibility(Lifecycle.Read)
  @maxValue(5)
  selfUnsuspendCounter?: int32;

  /**
   * Last domain evaluation run DateTime
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  healthLastEvaluated?: utcDateTime;

  /**
   * List of Domain Health Monitors
   */
  @visibility(Lifecycle.Read)
  healthMonitors?: HealthMonitor[];

  /**
   * List of Domain Health Alerts
   */
  @visibility(Lifecycle.Read)
  healthAlerts?: HealthAlert[];
}

/**
 * Health Monitor Description
 */
model HealthMonitor {
  /**
   * Health Monitor Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Health Monitor Name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Health Monitor Details
   */
  @visibility(Lifecycle.Read)
  details?: string;
}

/**
 * Health Alert Description
 */
model HealthAlert {
  /**
   * Health Alert Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Health Alert Name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Health Alert Issue
   */
  @visibility(Lifecycle.Read)
  issue?: string;

  /**
   * Health Alert Severity
   */
  @visibility(Lifecycle.Read)
  severity?: string;

  /**
   * Health Alert Raised DateTime
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  raised?: utcDateTime;

  /**
   * Health Alert Last Detected DateTime
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDetected?: utcDateTime;

  /**
   * Health Alert TSG Link
   */
  @visibility(Lifecycle.Read)
  resolutionUri?: string;
}

/**
 * Secure LDAP Settings
 */
model LdapsSettings {
  /**
   * A flag to determine whether or not Secure LDAP is enabled or disabled.
   */
  ldaps?: Ldaps = Ldaps.Disabled;

  /**
   * The certificate required to configure Secure LDAP. The parameter passed here should be a base64encoded representation of the certificate pfx file.
   */
  pfxCertificate?: string;

  /**
   * The password to decrypt the provided Secure LDAP certificate pfx file.
   */
  pfxCertificatePassword?: string;

  /**
   * Public certificate used to configure secure ldap.
   */
  @visibility(Lifecycle.Read)
  publicCertificate?: string;

  /**
   * Thumbprint of configure ldaps certificate.
   */
  @visibility(Lifecycle.Read)
  certificateThumbprint?: string;

  /**
   * NotAfter DateTime of configure ldaps certificate.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  certificateNotAfter?: utcDateTime;

  /**
   * A flag to determine whether or not Secure LDAP access over the internet is enabled or disabled.
   */
  externalAccess?: ExternalAccess = ExternalAccess.Disabled;
}

/**
 * Settings for Resource Forest
 */
model ResourceForestSettings {
  /**
   * List of settings for Resource Forest
   */
  settings?: ForestTrust[];

  /**
   * Resource Forest
   */
  resourceForest?: string;
}

/**
 * Forest Trust Setting
 */
model ForestTrust {
  /**
   * Trusted Domain FQDN
   */
  trustedDomainFqdn?: string;

  /**
   * Trust Direction
   */
  trustDirection?: string;

  /**
   * Friendly Name
   */
  friendlyName?: string;

  /**
   * Remote Dns ips
   */
  remoteDnsIps?: string;

  /**
   * Trust Password
   */
  trustPassword?: string;
}

/**
 * Domain Security Settings
 */
model DomainSecuritySettings {
  /**
   * A flag to determine whether or not NtlmV1 is enabled or disabled.
   */
  ntlmV1?: NtlmV1 = NtlmV1.Enabled;

  /**
   * A flag to determine whether or not TlsV1 is enabled or disabled.
   */
  tlsV1?: TlsV1 = TlsV1.Enabled;

  /**
   * A flag to determine whether or not SyncNtlmPasswords is enabled or disabled.
   */
  syncNtlmPasswords?: SyncNtlmPasswords = SyncNtlmPasswords.Enabled;

  /**
   * A flag to determine whether or not SyncKerberosPasswords is enabled or disabled.
   */
  syncKerberosPasswords?: SyncKerberosPasswords = SyncKerberosPasswords.Enabled;

  /**
   * A flag to determine whether or not SyncOnPremPasswords is enabled or disabled.
   */
  syncOnPremPasswords?: SyncOnPremPasswords = SyncOnPremPasswords.Enabled;

  /**
   * A flag to determine whether or not KerberosRc4Encryption is enabled or disabled.
   */
  kerberosRc4Encryption?: KerberosRc4Encryption = KerberosRc4Encryption.Enabled;

  /**
   * A flag to determine whether or not KerberosArmoring is enabled or disabled.
   */
  kerberosArmoring?: KerberosArmoring = KerberosArmoring.Disabled;

  /**
   * A flag to determine whether or not LdapSigning is enabled or disabled.
   */
  ldapSigning?: LdapSigning = LdapSigning.Disabled;

  /**
   * A flag to determine whether or not ChannelBinding is enabled or disabled.
   */
  channelBinding?: ChannelBinding = ChannelBinding.Disabled;

  /**
   * A flag to determine whether the SyncOnPremSamAccountName feature is active. When enabled, the samAccountName attribute in Entra Domain Services is synchronized from the onPremisesSamAccountName attribute in Entra ID
   */
  syncOnPremSamAccountName?: SyncOnPremSamAccountName = SyncOnPremSamAccountName.Disabled;
}

/**
 * Settings for notification
 */
model NotificationSettings {
  /**
   * Should global admins be notified
   */
  notifyGlobalAdmins?: NotifyGlobalAdmins;

  /**
   * Should domain controller admins be notified
   */
  notifyDcAdmins?: NotifyDcAdmins;

  /**
   * The list of additional recipients
   */
  additionalRecipients?: string[];
}

/**
 * Migration Properties
 */
model MigrationProperties {
  /**
   * Old Subnet Id
   */
  @visibility(Lifecycle.Read)
  oldSubnetId?: string;

  /**
   * Old Vnet Site Id
   */
  @visibility(Lifecycle.Read)
  oldVnetSiteId?: string;

  /**
   * Migration Progress
   */
  @visibility(Lifecycle.Read)
  migrationProgress?: MigrationProgress;
}

/**
 * Migration Progress
 */
model MigrationProgress {
  /**
   * Completion Percentage
   */
  completionPercentage?: float64;

  /**
   * Progress Message
   */
  progressMessage?: string;
}

/**
 * Configuration Diagnostics
 */
model ConfigDiagnostics {
  /**
   * Last domain configuration diagnostics DateTime
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastExecuted?: utcDateTime;

  /**
   * List of Configuration Diagnostics validator results.
   */
  validatorResults?: ConfigDiagnosticsValidatorResult[];
}

/**
 * Config Diagnostics validator result data
 */
model ConfigDiagnosticsValidatorResult {
  /**
   * Validator identifier
   */
  validatorId?: string;

  /**
   * Replica set location and subnet name
   */
  replicaSetSubnetDisplayName?: string;

  /**
   * Status for individual validator after running diagnostics.
   */
  status?: Status = Status.None;

  /**
   * List of resource config validation issues.
   */
  issues?: ConfigDiagnosticsValidatorResultIssue[];
}

/**
 * Specific issue for a particular config diagnostics validator
 */
model ConfigDiagnosticsValidatorResultIssue {
  /**
   * Validation issue identifier.
   */
  id?: string;

  /**
   * List of domain resource property name or values used to compose a rich description.
   */
  descriptionParams?: string[];
}

/**
 * The Resource model definition.
 */
model Resource {
  /**
   * Resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Resource location
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Resource etag
   */
  etag?: string;

  /**
   * The system meta data relating to this resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Properties of the OuContainer.
 */
model OuContainerProperties {
  /**
   * Azure Active Directory tenant id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The domain name of Domain Services.
   */
  @visibility(Lifecycle.Read)
  domainName?: string;

  /**
   * The Deployment id
   */
  @visibility(Lifecycle.Read)
  deploymentId?: string;

  /**
   * The OuContainer name
   */
  @visibility(Lifecycle.Read)
  containerId?: string;

  /**
   * The list of container accounts
   */
  accounts?: ContainerAccount[];

  /**
   * Status of OuContainer instance
   */
  @visibility(Lifecycle.Read)
  serviceStatus?: string;

  /**
   * Distinguished Name of OuContainer instance
   */
  @visibility(Lifecycle.Read)
  distinguishedName?: string;

  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;
}

/**
 * Container Account Description
 */
model ContainerAccount {
  /**
   * The account name
   */
  accountName?: string;

  /**
   * The account spn
   */
  spn?: string;

  /**
   * The account password
   */
  password?: string;
}
