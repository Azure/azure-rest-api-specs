import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Versioning;

namespace Microsoft.ContainerRegistry;

/**
 * The type of package source for a archive.
 */
union PackageSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  remote: "remote",
}

/**
 * The provisioning state of the archive at the time the operation was called.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The type of identity that last modified the resource.
 */
union LastModifiedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * The mode of the connected registry resource that indicates the permissions of the registry.
 */
union ConnectedRegistryMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadWrite: "ReadWrite",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ReadOnly: "ReadOnly",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Registry: "Registry",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Mirror: "Mirror",
}

/**
 * The current connection state of the connected registry.
 */
union ConnectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Online: "Online",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Syncing: "Syncing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
}

/**
 * The activation status of the connected registry.
 */
union ActivationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Active: "Active",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Inactive: "Inactive",
}

/**
 * Indicates whether HTTPS is enabled for the login server.
 */
union TlsStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The type of certificate location.
 */
union CertificateType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LocalDirectory: "LocalDirectory",
}

/**
 * The verbosity of logs persisted on the connected registry.
 */
union LogLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Debug: "Debug",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Information: "Information",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Indicates whether audit logs are enabled on the connected registry.
 */
union AuditLogStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The name of the credential.
 */
union CredentialName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Credential1: "Credential1",
}

/**
 * The health status of credential.
 */
union CredentialHealthStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unhealthy: "Unhealthy",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@removed(Versions.v2025_11_01)
union PipelineOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OverwriteTags: "OverwriteTags",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  OverwriteBlobs: "OverwriteBlobs",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeleteSourceBlobOnSuccess: "DeleteSourceBlobOnSuccess",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ContinueOnErrors: "ContinueOnErrors",
}

/**
 * When Force, any existing target tags will be overwritten. When NoForce, any existing target tags will fail the operation before any copying begins.
 */
union ImportMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoForce: "NoForce",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Force: "Force",
}

/**
 * The type of source for the import pipeline.
 */
@removed(Versions.v2025_11_01)
union PipelineSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlobContainer: "AzureStorageBlobContainer",
}

/**
 * The current status of the source trigger.
 */
union TriggerStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * The storage access mode used for the customer storage account.
 */
@removed(Versions.v2025_11_01)
union StorageAccessMode {
  string,

  /** Managed Identity access mode */
  ManagedIdentity: "ManagedIdentity",

  /** SAS Token access mode */
  SasToken: "SasToken",
}

/**
 * The auto generated domain name label of the container registry. This value defaults to "Unsecure".
 */
union AutoGeneratedDomainNameLabelScope {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unsecure: "Unsecure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TenantReuse: "TenantReuse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SubscriptionReuse: "SubscriptionReuse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ResourceGroupReuse: "ResourceGroupReuse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NoReuse: "NoReuse",
}

/**
 * The type of the source.
 */
@removed(Versions.v2025_11_01)
union PipelineRunSourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlob: "AzureStorageBlob",
}

/**
 * The type of the target.
 */
@removed(Versions.v2025_11_01)
union PipelineRunTargetType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureStorageBlob: "AzureStorageBlob",
}

/**
 * The private link service connection status.
 */
union ConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disconnected: "Disconnected",
}

/**
 * A message indicating if changes on the service provider require any updates on the consumer.
 */
union ActionsRequired {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Recreate: "Recreate",
}

/**
 * The SKU name of the container registry. Required for registry creation.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Classic: "Classic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
}

/**
 * The SKU tier based on the SKU name.
 */
union SkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Classic: "Classic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Basic: "Basic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Premium: "Premium",
}

/**
 * The default action of allow or deny when no other rules match.
 */
union DefaultAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deny: "Deny",
}

/**
 * The action of IP ACL rule.
 */
union Action {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Allow: "Allow",
}

/**
 * The value that indicates whether the policy is enabled or not.
 */
union PolicyStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * The type of trust policy.
 */
union TrustPolicyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Notary: "Notary",
}

/**
 * The value that indicates whether the policy is enabled or not.
 */
union ExportPolicyStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * The value that indicates whether the policy is enabled or not.
 */
union AzureADAuthenticationAsArmPolicyStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * Indicates whether or not the encryption is enabled for container registry.
 */
union EncryptionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * Whether or not public network access is allowed for the container registry.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Whether to allow trusted Azure services to access a network restricted registry.
 */
union NetworkRuleBypassOptions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AzureServices: "AzureServices",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Whether or not zone redundancy is enabled for this container registry
 */
union ZoneRedundancy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Determines whether registry artifacts are indexed for metadata search.
 */
@removed(Versions.v2025_11_01)
union MetadataSearch {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
}

/**
 * Determines registry role assignment mode.
 */
union RoleAssignmentMode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AbacRepositoryPermissions: "AbacRepositoryPermissions",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LegacyRegistryPermissions: "LegacyRegistryPermissions",
}

/**
 * The unit of measurement.
 */
union RegistryUsageUnit {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Bytes: "Bytes",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union TokenCertificateName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificate1: "certificate1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  certificate2: "certificate2",
}

/**
 * The password name "password1" or "password2"
 */
union TokenPasswordName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password1: "password1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  password2: "password2",
}

/**
 * The status of the token example enabled or disabled.
 */
union TokenStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * The status of the webhook at the time the operation was called.
 */
union WebhookStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union WebhookAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  push: "push",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete: "delete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  quarantine: "quarantine",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  chart_push: "chart_push",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  chart_delete: "chart_delete",
}

/**
 * The identity type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceIdentityType {
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
  None,
}

/**
 * The password name.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum PasswordName {
  password,
  password2,
}

/**
 * The properties of a archive.
 */
@removed(Versions.v2025_11_01)
model ArchiveProperties {
  /**
   * The package source of the archive.
   */
  packageSource?: ArchivePackageSourceProperties;

  /**
   * The published version of the archive.
   */
  publishedVersion?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  repositoryEndpointPrefix?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  repositoryEndpoint?: string;

  /**
   * The provisioning state of the archive at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of the archive package source.
 */
@removed(Versions.v2025_11_01)
model ArchivePackageSourceProperties {
  /**
   * The type of package source for a archive.
   */
  type?: PackageSourceType;

  /**
   * The external repository url.
   */
  url?: string;
}

/**
 * The resource model definition for a ARM proxy resource. It will have everything other than required location and tags.
 */
model ProxyResource {
  /**
   * The resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
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
  lastModifiedByType?: LastModifiedByType;

  /**
   * The timestamp of resource modification (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * The parameters for updating a archive.
 */
@removed(Versions.v2025_11_01)
model ArchiveUpdateParameters {
  /**
   * The properties of the connected registry update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ArchiveUpdateProperties;
}

/**
 * The properties of a archive.
 */
model ArchiveUpdateProperties {
  /**
   * The published version of the archive.
   */
  publishedVersion?: string;
}

/**
 * The properties of an archive version.
 */
@removed(Versions.v2025_11_01)
model ArchiveVersionProperties {
  /**
   * The provisioning state of the archive at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The detailed error message for the archive version in the case of failure.
   */
  archiveVersionErrorMessage?: string;
}

/**
 * The properties of a cache rule.
 */
model CacheRuleProperties {
  /**
   * The ARM resource ID of the credential store which is associated with the cache rule.
   */
  credentialSetResourceId?: string;

  /**
   * Source repository pulled from upstream.
   */
  sourceRepository?: string;

  /**
   * Target repository specified in docker pull command.
   * Eg: docker pull myregistry.azurecr.io/{targetRepository}:{tag}
   */
  targetRepository?: string;

  /**
   * The creation date of the cache rule.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The parameters for updating a cache rule.
 */
model CacheRuleUpdateParameters {
  /**
   * The properties of the cache rule update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CacheRuleUpdateProperties;
}

/**
 * The parameters for updating cache rule properties.
 */
model CacheRuleUpdateProperties {
  /**
   * The ARM resource ID of the credential store which is associated with the Cache rule.
   */
  credentialSetResourceId?: string;
}

/**
 * The result of a request to list cache rules for a container registry.
 */
model CacheRulesListResult {
  /**
   * The list of cache rules. Since this list may be incomplete, the nextLink field should be used to request the next list of cache rules.
   */
  @pageItems
  value?: CacheRule[];

  /**
   * The URI that can be used to request the next list of cache rules.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list archives for a container registry.
 */
@removed(Versions.v2025_11_01)
model ArchiveListResult {
  /**
   * The list of archives. Since this list may be incomplete, the nextLink field should be used to request the next list of archives.
   */
  @pageItems
  value?: Archive[];

  /**
   * The URI that can be used to request the next list of archives.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The properties of a connected registry.
 */
model ConnectedRegistryProperties {
  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The mode of the connected registry resource that indicates the permissions of the registry.
   */
  mode: ConnectedRegistryMode;

  /**
   * The current version of ACR runtime on the connected registry.
   */
  @visibility(Lifecycle.Read)
  version?: string;

  /**
   * The current connection state of the connected registry.
   */
  @visibility(Lifecycle.Read)
  connectionState?: ConnectionState;

  /**
   * The last activity time of the connected registry.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActivityTime?: utcDateTime;

  /**
   * The activation properties of the connected registry.
   */
  @visibility(Lifecycle.Read)
  activation?: ActivationProperties;

  /**
   * The parent of the connected registry.
   */
  parent: ParentProperties;

  /**
   * The list of the ACR token resource IDs used to authenticate clients to the connected registry.
   */
  clientTokenIds?: string[];

  /**
   * The login server properties of the connected registry.
   */
  loginServer?: LoginServerProperties;

  /**
   * The logging properties of the connected registry.
   */
  logging?: LoggingProperties;

  /**
   * The list of current statuses of the connected registry.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["correlationId"])
  statusDetails?: StatusDetailProperties[];

  /**
   * The list of notifications subscription information for the connected registry.
   */
  notificationsList?: string[];

  /**
   * The garbage collection properties of the connected registry.
   */
  garbageCollection?: GarbageCollectionProperties;
}

/**
 * The activation properties of the connected registry.
 */
model ActivationProperties {
  /**
   * The activation status of the connected registry.
   */
  @visibility(Lifecycle.Read)
  status?: ActivationStatus;
}

/**
 * The properties of the connected registry parent.
 */
model ParentProperties {
  /**
   * The resource ID of the parent to which the connected registry will be associated.
   */
  id?: Azure.Core.armResourceIdentifier;

  /**
   * The sync properties of the connected registry with its parent.
   */
  syncProperties: SyncProperties;
}

/**
 * The sync properties of the connected registry with its parent.
 */
model SyncProperties {
  /**
   * The resource ID of the ACR token used to authenticate the connected registry to its parent during sync.
   */
  tokenId: string;

  /**
   * The cron expression indicating the schedule that the connected registry will sync with its parent.
   */
  schedule?: string;

  /**
   * The time window during which sync is enabled for each schedule occurrence. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  syncWindow?: duration;

  /**
   * The period of time for which a message is available to sync before it is expired. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  messageTtl: duration;

  /**
   * The last time a sync occurred between the connected registry and its parent.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;

  /**
   * The gateway endpoint used by the connected registry to communicate with its parent.
   */
  @visibility(Lifecycle.Read)
  gatewayEndpoint?: string;
}

/**
 * The login server properties of the connected registry.
 */
model LoginServerProperties {
  /**
   * The host of the connected registry. Can be FQDN or IP.
   */
  @visibility(Lifecycle.Read)
  host?: string;

  /**
   * The TLS properties of the connected registry login server.
   */
  @visibility(Lifecycle.Read)
  tls?: TlsProperties;
}

/**
 * The TLS properties of the connected registry login server.
 */
model TlsProperties {
  /**
   * Indicates whether HTTPS is enabled for the login server.
   */
  @visibility(Lifecycle.Read)
  status?: TlsStatus;

  /**
   * The certificate used to configure HTTPS for the login server.
   */
  @visibility(Lifecycle.Read)
  certificate?: TlsCertificateProperties;
}

/**
 * The TLS certificate properties of the connected registry login server.
 */
model TlsCertificateProperties {
  /**
   * The type of certificate location.
   */
  @visibility(Lifecycle.Read)
  type?: CertificateType;

  /**
   * Indicates the location of the certificates.
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * The logging properties of the connected registry.
 */
model LoggingProperties {
  /**
   * The verbosity of logs persisted on the connected registry.
   */
  logLevel?: LogLevel = LogLevel.Information;

  /**
   * Indicates whether audit logs are enabled on the connected registry.
   */
  auditLogStatus?: AuditLogStatus = AuditLogStatus.Disabled;
}

/**
 * The status detail properties of the connected registry.
 */
model StatusDetailProperties {
  /**
   * The component of the connected registry corresponding to the status.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The HTTP status code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The description of the status.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The timestamp of the status.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The correlation ID of the status.
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;
}

/**
 * The garbage collection properties of the connected registry.
 */
model GarbageCollectionProperties {
  /**
   * Indicates whether garbage collection is enabled for the connected registry.
   */
  enabled?: boolean;

  /**
   * The cron expression indicating the schedule that the connected registry will run garbage collection.
   */
  schedule?: string;
}

/**
 * The parameters for updating a connected registry.
 */
model ConnectedRegistryUpdateParameters {
  /**
   * The properties of the connected registry update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ConnectedRegistryUpdateProperties;
}

/**
 * The parameters for updating token properties.
 */
model ConnectedRegistryUpdateProperties {
  /**
   * The sync properties of the connected registry with its parent.
   */
  syncProperties?: SyncUpdateProperties;

  /**
   * The logging properties of the connected registry.
   */
  logging?: LoggingProperties;

  /**
   * The list of the ACR token resource IDs used to authenticate clients to the connected registry.
   */
  clientTokenIds?: string[];

  /**
   * The list of notifications subscription information for the connected registry.
   */
  notificationsList?: string[];

  /**
   * The garbage collection properties of the connected registry.
   */
  garbageCollection?: GarbageCollectionProperties;
}

/**
 * The parameters for updating the sync properties of the connected registry with its parent.
 */
model SyncUpdateProperties {
  /**
   * The cron expression indicating the schedule that the connected registry will sync with its parent.
   */
  schedule?: string;

  /**
   * The time window during which sync is enabled for each schedule occurrence. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  syncWindow?: duration;

  /**
   * The period of time for which a message is available to sync before it is expired. Specify the duration using the format P[n]Y[n]M[n]DT[n]H[n]M[n]S as per ISO8601.
   */
  messageTtl?: duration;
}

/**
 * Managed identity for the resource.
 */
model IdentityProperties {
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
  type?: ResourceIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity
   * dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/
   *     providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserIdentityProperties>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model UserIdentityProperties {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * The properties of a credential set resource.
 */
model CredentialSetProperties {
  /**
   * The credentials are stored for this upstream or login server.
   */
  loginServer?: string;

  /**
   * List of authentication credentials stored for an upstream.
   * Usually consists of a primary and an optional secondary credential.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  authCredentials?: AuthCredential[];

  /**
   * The creation date of credential store resource.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Authentication credential stored for an upstream.
 */
model AuthCredential {
  /**
   * The name of the credential.
   */
  name?: CredentialName;

  /**
   * KeyVault Secret URI for accessing the username.
   */
  usernameSecretIdentifier?: string;

  /**
   * KeyVault Secret URI for accessing the password.
   */
  passwordSecretIdentifier?: string;

  /**
   * This provides data pertaining to the health of the auth credential.
   */
  @visibility(Lifecycle.Read)
  credentialHealth?: CredentialHealth;
}

/**
 * The health of the auth credential.
 */
model CredentialHealth {
  /**
   * The health status of credential.
   */
  status?: CredentialHealthStatus;

  /**
   * Error code representing the health check error.
   */
  errorCode?: string;

  /**
   * Descriptive message representing the health check error.
   */
  errorMessage?: string;
}

/**
 * The parameters for updating a credential set
 */
model CredentialSetUpdateParameters {
  /**
   * The properties of the credential set update parameters
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CredentialSetUpdateProperties;

  /**
   * Identities associated with the resource. This is used to access the KeyVault secrets.
   */
  identity?: IdentityProperties;
}

/**
 * The parameters for updating credential set properties.
 */
model CredentialSetUpdateProperties {
  /**
   * List of authentication credentials stored for an upstream.
   * Usually consists of a primary and an optional secondary credential.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  authCredentials?: AuthCredential[];
}

/**
 * The properties of an export pipeline.
 */
@removed(Versions.v2025_11_01)
model ExportPipelineProperties {
  /**
   * The target properties of the export pipeline.
   */
  target: ExportPipelineTargetProperties;

  /**
   * The list of all options configured for the pipeline.
   */
  options?: PipelineOptions[];

  /**
   * The provisioning state of the pipeline at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of the export pipeline target.
 */
@removed(Versions.v2025_11_01)
model ExportPipelineTargetProperties {
  /**
   * The type of target for the export pipeline.
   */
  type?: string;

  /**
   * The target uri of the export pipeline.
   * When 'AzureStorageBlobContainer':  "https://accountName.blob.core.windows.net/containerName"
   */
  uri?: string;

  /**
   * They key vault secret uri to obtain the target storage SAS token.
   */
  keyVaultUri?: string;

  /**
   * The storage access mode used for the customer storage account.
   */
  storageAccessMode?: StorageAccessMode = StorageAccessMode.SasToken;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportImageParameters {
  /**
   * The source of the image.
   */
  source: ImportSource;

  /**
   * List of strings of the form repo[:tag]. When tag is omitted the source will be used (or 'latest' if source tag is also omitted).
   */
  targetTags?: string[];

  /**
   * List of strings of repository names to do a manifest only copy. No tag will be created.
   */
  untaggedTargetRepositories?: string[];

  /**
   * When Force, any existing target tags will be overwritten. When NoForce, any existing target tags will fail the operation before any copying begins.
   */
  mode?: ImportMode = ImportMode.NoForce;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportSource {
  /**
   * The resource identifier of the source Azure Container Registry.
   */
  resourceId?: string;

  /**
   * The address of the source registry (e.g. 'mcr.microsoft.com').
   */
  registryUri?: string;

  /**
   * Credentials used when importing from a registry uri.
   */
  credentials?: ImportSourceCredentials;

  @doc("""
    Repository name of the source image.
    Specify an image by repository ('hello-world'). This will use the 'latest' tag.
    Specify an image by tag ('hello-world:latest').
    Specify an image by sha256-based manifest digest ('hello-world@sha256:abc123').
    """)
  sourceImage: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ImportSourceCredentials {
  /**
   * The username to authenticate with the source registry.
   */
  username?: string;

  /**
   * The password used to authenticate with the source registry.
   */
  password: string;
}

/**
 * The properties of an import pipeline.
 */
@removed(Versions.v2025_11_01)
model ImportPipelineProperties {
  /**
   * The source properties of the import pipeline.
   */
  source: ImportPipelineSourceProperties;

  /**
   * The properties that describe the trigger of the import pipeline.
   */
  trigger?: PipelineTriggerProperties;

  /**
   * The list of all options configured for the pipeline.
   */
  options?: PipelineOptions[];

  /**
   * The provisioning state of the pipeline at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The properties of the import pipeline source.
 */
@removed(Versions.v2025_11_01)
model ImportPipelineSourceProperties {
  /**
   * The type of source for the import pipeline.
   */
  type?: PipelineSourceType = PipelineSourceType.AzureStorageBlobContainer;

  /**
   * The target uri of the export pipeline.
   * When 'AzureStorageBlobContainer':  "https://accountName.blob.core.windows.net/containerName"
   */
  uri?: string;

  /**
   * They key vault secret uri to obtain the source storage SAS token.
   */
  keyVaultUri?: string;

  /**
   * The storage access mode used for the customer storage account.
   */
  storageAccessMode?: StorageAccessMode = StorageAccessMode.SasToken;
}

/**
 * The trigger properties of the import pipeline
 */
model PipelineTriggerProperties {
  /**
   * The source trigger properties of the pipeline.
   */
  sourceTrigger?: PipelineSourceTriggerProperties;
}

/**
 * The source trigger properties of the import pipeline
 */
model PipelineSourceTriggerProperties {
  /**
   * The current status of the source trigger.
   */
  status: TriggerStatus = TriggerStatus.Enabled;
}

/**
 * The definition of a container registry operation.
 */
model OperationDefinition {
  /**
   * The origin information of the container registry operation.
   */
  origin?: string;

  /**
   * Operation name: {provider}/{resource}/{operation}.
   */
  name?: string;

  /**
   * The display information for the container registry operation.
   */
  display?: OperationDisplayDefinition;

  /**
   * The properties information for the container registry operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: OperationPropertiesDefinition;

  /**
   * This property indicates if the operation is an action or a data action
   * ref: https://docs.microsoft.com/en-us/azure/role-based-access-control/role-definitions#management-and-data-operations
   */
  isDataAction?: boolean;
}

/**
 * The display information for a container registry operation.
 */
model OperationDisplayDefinition {
  /**
   * The resource provider name: Microsoft.ContainerRegistry.
   */
  provider?: string;

  /**
   * The resource on which the operation is performed.
   */
  resource?: string;

  /**
   * The operation that users can perform.
   */
  operation?: string;

  /**
   * The description for the operation.
   */
  description?: string;
}

/**
 * The definition of Azure Monitoring properties.
 */
model OperationPropertiesDefinition {
  /**
   * The definition of Azure Monitoring service.
   */
  serviceSpecification?: OperationServiceSpecificationDefinition;
}

/**
 * The definition of Azure Monitoring list.
 */
model OperationServiceSpecificationDefinition {
  /**
   * A list of Azure Monitoring metrics definition.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  metricSpecifications?: OperationMetricSpecificationDefinition[];

  /**
   * A list of Azure Monitoring log definitions.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  logSpecifications?: OperationLogSpecificationDefinition[];
}

/**
 * The definition of Azure Monitoring metric.
 */
model OperationMetricSpecificationDefinition {
  /**
   * Metric name.
   */
  name?: string;

  /**
   * Metric display name.
   */
  displayName?: string;

  /**
   * Metric description.
   */
  displayDescription?: string;

  /**
   * Metric unit.
   */
  unit?: string;

  /**
   * Metric aggregation type.
   */
  aggregationType?: string;

  /**
   * Internal metric name.
   */
  internalMetricName?: string;
}

/**
 * The definition of Azure Monitoring log.
 */
model OperationLogSpecificationDefinition {
  /**
   * Log name.
   */
  name?: string;

  /**
   * Log display name.
   */
  displayName?: string;

  /**
   * Log blob duration.
   */
  blobDuration?: string;
}

/**
 * The result of a request to list container registry operations.
 */
model OperationListResult {
  /**
   * The list of container registry operations. Since this list may be incomplete, the nextLink field should be used to request the next list of operations.
   */
  @pageItems
  value?: OperationDefinition[];

  /**
   * The URI that can be used to request the next list of container registry operations.
   */
  @nextLink
  nextLink?: string;
}

/** The resource type for Container Registry. */
#suppress "@azure-tools/typespec-azure-core/no-enum" ""
enum ContainerRegistryResourceType {
  `Microsoft.ContainerRegistry/registries`,
}

/**
 * A request to check whether a container registry name is available.
 */
model RegistryNameCheckRequest {
  /**
   * The name of the container registry.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9]*$")
  name: string;

  /**
   * The resource type of the container registry. This field must be set to 'Microsoft.ContainerRegistry/registries'.
   */
  type: ContainerRegistryResourceType;

  /**
   * The resource group name of the container registry.
   */
  @maxLength(90)
  @minLength(1)
  resourceGroupName?: string;

  /**
   * The auto generated domain name label of the container registry. This value defaults to "Unsecure".
   */
  autoGeneratedDomainNameLabelScope?: AutoGeneratedDomainNameLabelScope = AutoGeneratedDomainNameLabelScope.Unsecure;
}

/**
 * The result of a request to check the availability of a container registry name.
 */
model RegistryNameStatus {
  /**
   * The complete login server name with domain name label (DNL) hash, if available
   */
  availableLoginServerName?: string;

  /**
   * The value that indicates whether the name is available.
   */
  nameAvailable?: boolean;

  /**
   * If any, the reason that the name is not available.
   */
  reason?: string;

  /**
   * If any, the error message that provides more detail for the reason that the name is not available.
   */
  message?: string;
}

/**
 * The properties of a pipeline run.
 */
@removed(Versions.v2025_11_01)
model PipelineRunProperties {
  /**
   * The provisioning state of a pipeline run.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The request parameters for a pipeline run.
   */
  request?: PipelineRunRequest;

  /**
   * The response of a pipeline run.
   */
  @visibility(Lifecycle.Read)
  response?: PipelineRunResponse;

  /**
   * How the pipeline run should be forced to recreate even if the pipeline run configuration has not changed.
   */
  forceUpdateTag?: string;
}

/**
 * The request properties provided for a pipeline run.
 */
@removed(Versions.v2025_11_01)
model PipelineRunRequest {
  /**
   * The resource ID of the pipeline to run.
   */
  pipelineResourceId?: string;

  @doc("""
    List of source artifacts to be transferred by the pipeline. 
    Specify an image by repository ('hello-world'). This will use the 'latest' tag.
    Specify an image by tag ('hello-world:latest').
    Specify an image by sha256-based manifest digest ('hello-world@sha256:abc123').
    """)
  artifacts?: string[];

  /**
   * The source properties of the pipeline run.
   */
  source?: PipelineRunSourceProperties;

  /**
   * The target properties of the pipeline run.
   */
  target?: PipelineRunTargetProperties;

  /**
   * The digest of the tar used to transfer the artifacts.
   */
  catalogDigest?: string;
}

/**
 * The pipeline run source properties
 */
@removed(Versions.v2025_11_01)
model PipelineRunSourceProperties {
  /**
   * The type of the source.
   */
  type?: PipelineRunSourceType = PipelineRunSourceType.AzureStorageBlob;

  /**
   * The name of the source.
   */
  name?: string;
}

/**
 * The pipeline run target properties
 */
@removed(Versions.v2025_11_01)
model PipelineRunTargetProperties {
  /**
   * The type of the target.
   */
  type?: PipelineRunTargetType = PipelineRunTargetType.AzureStorageBlob;

  /**
   * The name of the target.
   */
  name?: string;
}

/**
 * The response properties returned for a pipeline run.
 */
@removed(Versions.v2025_11_01)
model PipelineRunResponse {
  /**
   * The current status of the pipeline run.
   */
  status?: string;

  /**
   * The artifacts imported in the pipeline run.
   */
  importedArtifacts?: string[];

  /**
   * The current progress of the copy operation.
   */
  progress?: ProgressProperties;

  /**
   * The time the pipeline run started.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * The time the pipeline run finished.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  finishTime?: utcDateTime;

  /**
   * The source of the pipeline run.
   */
  source?: ImportPipelineSourceProperties;

  /**
   * The target of the pipeline run.
   */
  target?: ExportPipelineTargetProperties;

  /**
   * The digest of the tar used to transfer the artifacts.
   */
  catalogDigest?: string;

  /**
   * The trigger that caused the pipeline run.
   */
  trigger?: PipelineTriggerDescriptor;

  /**
   * The detailed error message for the pipeline run in the case of failure.
   */
  pipelineRunErrorMessage?: string;
}

/**
 * The progress properties.
 */
model ProgressProperties {
  /**
   * The percentage complete of the copy operation.
   */
  percentage?: string;
}

/**
 * The pipeline trigger descriptor
 */
model PipelineTriggerDescriptor {
  /**
   * The source trigger that caused the pipeline run.
   */
  sourceTrigger?: PipelineSourceTriggerDescriptor;
}

/**
 * The pipeline source trigger descriptor.
 */
model PipelineSourceTriggerDescriptor {
  /**
   * The timestamp when the source update happened.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

/**
 * The properties of a private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private endpoint.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * This is private endpoint resource created with Microsoft.Network resource provider.
   */
  id?: string;
}

/**
 * The state of a private link service connection.
 */
model PrivateLinkServiceConnectionState {
  /**
   * The private link service connection status.
   */
  status?: ConnectionStatus;

  /**
   * The description for connection status. For example if connection is rejected it can indicate reason for rejection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: ActionsRequired;
}

/**
 * The SKU of a container registry.
 */
model Sku {
  /**
   * The SKU name of the container registry. Required for registry creation.
   */
  name: SkuName;

  /**
   * The SKU tier based on the SKU name.
   */
  @visibility(Lifecycle.Read)
  tier?: SkuTier;
}

/**
 * The properties of a container registry.
 */
model RegistryProperties {
  /**
   * The URL that can be used to log into the container registry.
   */
  @visibility(Lifecycle.Read)
  loginServer?: string;

  /**
   * The creation date of the container registry in ISO8601 format.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * The provisioning state of the container registry at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The status of the container registry at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * The value that indicates whether the admin user is enabled.
   */
  adminUserEnabled?: boolean = false;

  /**
   * The network rule set for a container registry.
   */
  networkRuleSet?: NetworkRuleSet;

  /**
   * The policies for a container registry.
   */
  policies?: Policies;

  /**
   * The encryption settings of container registry.
   */
  encryption?: EncryptionProperty;

  /**
   * Enable a single data endpoint per region for serving data.
   */
  dataEndpointEnabled?: boolean;

  /**
   * List of host names that will serve data when dataEndpointEnabled is true.
   */
  @visibility(Lifecycle.Read)
  dataEndpointHostNames?: string[];

  /**
   * List of private endpoint connections for a container registry.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Whether or not public network access is allowed for the container registry.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * Whether to allow trusted Azure services to access a network restricted registry.
   */
  networkRuleBypassOptions?: NetworkRuleBypassOptions = NetworkRuleBypassOptions.AzureServices;

  /**
   * Whether or not Tasks allowed to bypass the network rules for this container registry.
   */
  networkRuleBypassAllowedForTasks?: boolean = false;

  /**
   * Whether or not zone redundancy is enabled for this container registry
   */
  zoneRedundancy?: ZoneRedundancy = ZoneRedundancy.Disabled;

  /**
   * Enables registry-wide pull from unauthenticated clients.
   */
  anonymousPullEnabled?: boolean = false;

  /**
   * Determines whether registry artifacts are indexed for metadata search.
   */
  @removed(Versions.v2025_11_01)
  metadataSearch?: MetadataSearch = MetadataSearch.Disabled;

  /**
   * Determines the domain name label reuse scope.
   */
  autoGeneratedDomainNameLabelScope?: AutoGeneratedDomainNameLabelScope = AutoGeneratedDomainNameLabelScope.Unsecure;

  /**
   * Determines registry role assignment mode.
   */
  roleAssignmentMode?: RoleAssignmentMode = RoleAssignmentMode.LegacyRegistryPermissions;
}

/**
 * The status of an Azure resource at the time the operation was called.
 */
model Status {
  /**
   * The short label for the status.
   */
  @visibility(Lifecycle.Read)
  displayStatus?: string;

  /**
   * The detailed message for the status, including alerts and error messages.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The timestamp when the status was changed to the current value.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;
}

/**
 * The network rule set for a container registry.
 */
model NetworkRuleSet {
  /**
   * The default action of allow or deny when no other rules match.
   */
  defaultAction: DefaultAction = DefaultAction.Allow;

  /**
   * The IP ACL rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: IPRule[];
}

/**
 * IP rule with specific IP or IP range in CIDR format.
 */
model IPRule {
  /**
   * The action of IP ACL rule.
   */
  action?: Action = Action.Allow;

  /**
   * Specifies the IP or IP range in CIDR format. Only IPV4 address is allowed.
   */
  value: string;
}

/**
 * The policies for a container registry.
 */
model Policies {
  /**
   * The quarantine policy for a container registry.
   */
  quarantinePolicy?: QuarantinePolicy;

  /**
   * The content trust policy for a container registry.
   */
  trustPolicy?: TrustPolicy;

  /**
   * The retention policy for a container registry.
   */
  retentionPolicy?: RetentionPolicy;

  /**
   * The export policy for a container registry.
   */
  exportPolicy?: ExportPolicy;

  /**
   * The policy for using Azure Resource Manager audience token for a container registry.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  azureADAuthenticationAsArmPolicy?: AzureADAuthenticationAsArmPolicy;

  /**
   * The soft delete policy for a container registry.
   */
  @removed(Versions.v2025_11_01)
  softDeletePolicy?: SoftDeletePolicy;
}

/**
 * The quarantine policy for a container registry.
 */
model QuarantinePolicy {
  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: PolicyStatus = PolicyStatus.disabled;
}

/**
 * The content trust policy for a container registry.
 */
model TrustPolicy {
  /**
   * The type of trust policy.
   */
  type?: TrustPolicyType = TrustPolicyType.Notary;

  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: PolicyStatus = PolicyStatus.disabled;
}

/**
 * The retention policy for a container registry.
 */
model RetentionPolicy {
  /**
   * The number of days to retain an untagged manifest after which it gets purged.
   */
  days?: int32 = 7;

  /**
   * The timestamp when the policy was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: PolicyStatus = PolicyStatus.disabled;
}

/**
 * The export policy for a container registry.
 */
model ExportPolicy {
  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: ExportPolicyStatus = ExportPolicyStatus.enabled;
}

/**
 * The policy for using Azure Resource Manager audience token for a container registry.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AzureADAuthenticationAsArmPolicy {
  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: AzureADAuthenticationAsArmPolicyStatus = AzureADAuthenticationAsArmPolicyStatus.enabled;
}

/**
 * The soft delete policy for a container registry
 */
@removed(Versions.v2025_11_01)
model SoftDeletePolicy {
  /**
   * The number of days after which a soft-deleted item is permanently deleted.
   */
  retentionDays?: int32 = 7;

  /**
   * The timestamp when the policy was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdatedTime?: utcDateTime;

  /**
   * The value that indicates whether the policy is enabled or not.
   */
  status?: PolicyStatus = PolicyStatus.disabled;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model EncryptionProperty {
  /**
   * Indicates whether or not the encryption is enabled for container registry.
   */
  status?: EncryptionStatus;

  /**
   * Key vault properties.
   */
  keyVaultProperties?: KeyVaultProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KeyVaultProperties {
  /**
   * Key vault uri to access the encryption key.
   */
  keyIdentifier?: string;

  /**
   * The fully qualified key identifier that includes the version of the key that is actually used for encryption.
   */
  @visibility(Lifecycle.Read)
  versionedKeyIdentifier?: string;

  /**
   * The client id of the identity which will be used to access key vault.
   */
  identity?: string;

  /**
   * Auto key rotation status for a CMK enabled registry.
   */
  @visibility(Lifecycle.Read)
  keyRotationEnabled?: boolean;

  /**
   * Timestamp of the last successful key rotation.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastKeyRotationTimestamp?: utcDateTime;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * The resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The location of the resource. This cannot be changed after the resource is created.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * The tags of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * The parameters for updating a container registry.
 */
model RegistryUpdateParameters {
  /**
   * The identity of the container registry.
   */
  identity?: IdentityProperties;

  /**
   * The tags for the container registry.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The SKU of the container registry.
   */
  sku?: Sku;

  /**
   * The properties that the container registry will be updated with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: RegistryPropertiesUpdateParameters;
}

/**
 * The parameters for updating the properties of a container registry.
 */
model RegistryPropertiesUpdateParameters {
  /**
   * The value that indicates whether the admin user is enabled.
   */
  adminUserEnabled?: boolean;

  /**
   * The network rule set for a container registry.
   */
  networkRuleSet?: NetworkRuleSet;

  /**
   * The policies for a container registry.
   */
  policies?: Policies;

  /**
   * The encryption settings of container registry.
   */
  encryption?: EncryptionProperty;

  /**
   * Enable a single data endpoint per region for serving data.
   */
  dataEndpointEnabled?: boolean;

  /**
   * Whether or not public network access is allowed for the container registry.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Whether to allow trusted Azure services to access a network restricted registry.
   */
  networkRuleBypassOptions?: NetworkRuleBypassOptions = NetworkRuleBypassOptions.AzureServices;

  /**
   * Whether to allow ACR Tasks service to access a network restricted registry.
   */
  networkRuleBypassAllowedForTasks?: boolean;

  /**
   * Enables registry-wide pull from unauthenticated clients.
   */
  anonymousPullEnabled?: boolean;

  /**
   * Determines whether registry artifacts are indexed for metadata search.
   */
  @removed(Versions.v2025_11_01)
  metadataSearch?: MetadataSearch = MetadataSearch.Disabled;

  /**
   * Determines registry role assignment mode.
   */
  roleAssignmentMode?: RoleAssignmentMode;
}

/**
 * The result of a request to get container registry quota usages.
 */
model RegistryUsageListResult {
  /**
   * The list of container registry quota usages.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  value?: RegistryUsage[];
}

/**
 * The quota usage for a container registry.
 */
model RegistryUsage {
  /**
   * The name of the usage.
   */
  name?: string;

  /**
   * The limit of the usage.
   */
  limit?: int64;

  /**
   * The current value of the usage.
   */
  currentValue?: int64;

  /**
   * The unit of measurement.
   */
  unit?: RegistryUsageUnit;
}

/**
 * The properties of a private link resource.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * The response from the ListCredentials operation.
 */
model RegistryListCredentialsResult {
  /**
   * The username for a container registry.
   */
  username?: string;

  /**
   * The list of passwords for a container registry.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  passwords?: RegistryPassword[];
}

/**
 * The login password for the container registry.
 */
model RegistryPassword {
  /**
   * The password name.
   */
  name?: PasswordName;

  /**
   * The password value.
   */
  value?: string;
}

/**
 * The parameters used to regenerate the login credential.
 */
model RegenerateCredentialParameters {
  /**
   * Specifies name of the password which should be regenerated -- password or password2.
   */
  name: PasswordName;
}

/**
 * The properties of a replication.
 */
model ReplicationProperties {
  /**
   * The provisioning state of the replication at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The status of the replication at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.
   */
  regionEndpointEnabled?: boolean = true;

  /**
   * Whether or not zone redundancy is enabled for this container registry replication
   */
  zoneRedundancy?: ZoneRedundancy = ZoneRedundancy.Disabled;
}

/**
 * The parameters for updating a replication.
 */
model ReplicationUpdateParameters {
  /**
   * The tags for the replication.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The parameters for updating a replication's properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ReplicationUpdateParametersProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ReplicationUpdateParametersProperties {
  /**
   * Specifies whether the replication's regional endpoint is enabled. Requests will not be routed to a replication whose regional endpoint is disabled, however its data will continue to be synced with other replications.
   */
  regionEndpointEnabled?: boolean;
}

/**
 * The properties of a scope map.
 */
model ScopeMapProperties {
  /**
   * The user friendly description of the scope map.
   */
  description?: string;

  /**
   * The type of the scope map. E.g. BuildIn scope map.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The creation date of scope map.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The list of scoped permissions for registry artifacts.
   * E.g. repositories/repository-name/content/read,
   * repositories/repository-name/metadata/write
   */
  actions: string[];
}

/**
 * The properties for updating the scope map.
 */
model ScopeMapUpdateParameters {
  /**
   * The update parameters for scope map properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ScopeMapPropertiesUpdateParameters;
}

/**
 * The update parameters for scope map properties.
 */
model ScopeMapPropertiesUpdateParameters {
  /**
   * The user friendly description of the scope map.
   */
  description?: string;

  /**
   * The list of scope permissions for registry artifacts.
   * E.g. repositories/repository-name/pull,
   * repositories/repository-name/delete
   */
  actions?: string[];
}

/**
 * The properties of a token.
 */
model TokenProperties {
  /**
   * The creation date of scope map.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the scope map to which the token will be associated with.
   */
  scopeMapId?: string;

  /**
   * The credentials that can be used for authenticating the token.
   */
  credentials?: TokenCredentialsProperties;

  /**
   * The status of the token example enabled or disabled.
   */
  status?: TokenStatus;
}

/**
 * The properties of the credentials that can be used for authenticating the token.
 */
model TokenCredentialsProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #["thumbprint"])
  certificates?: TokenCertificate[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.extension("x-ms-identifiers", #[])
  passwords?: TokenPassword[];
}

/**
 * The properties of a certificate used for authenticating a token.
 */
model TokenCertificate {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  name?: TokenCertificateName;

  /**
   * The expiry datetime of the certificate.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The thumbprint of the certificate.
   */
  thumbprint?: string;

  /**
   * Base 64 encoded string of the public certificate1 in PEM format that will be used for authenticating the token.
   */
  encodedPemCertificate?: string;
}

/**
 * The password that will be used for authenticating the token of a container registry.
 */
model TokenPassword {
  /**
   * The creation datetime of the password.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationTime?: utcDateTime;

  /**
   * The expiry datetime of the password.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * The password name "password1" or "password2"
   */
  name?: TokenPasswordName;

  /**
   * The password value.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The parameters for updating a token.
 */
model TokenUpdateParameters {
  /**
   * The properties of the token update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: TokenUpdateProperties;
}

/**
 * The parameters for updating token properties.
 */
model TokenUpdateProperties {
  /**
   * The resource ID of the scope map to which the token will be associated with.
   */
  scopeMapId?: string;

  /**
   * The status of the token example enabled or disabled.
   */
  status?: TokenStatus;

  /**
   * The credentials that can be used for authenticating the token.
   */
  credentials?: TokenCredentialsProperties;
}

/**
 * The parameters used to generate credentials for a specified token or user of a container registry.
 */
model GenerateCredentialsParameters {
  /**
   * The resource ID of the token for which credentials have to be generated.
   */
  tokenId?: string;

  /**
   * The expiry date of the generated credentials after which the credentials become invalid.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiry?: utcDateTime;

  /**
   * Specifies name of the password which should be regenerated if any -- password1 or password2.
   */
  name?: TokenPasswordName;
}

/**
 * The response from the GenerateCredentials operation.
 */
model GenerateCredentialsResult {
  /**
   * The username for a container registry.
   */
  username?: string;

  /**
   * The list of passwords for a container registry.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  passwords?: TokenPassword[];
}

/**
 * The properties of a webhook.
 */
model WebhookProperties {
  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions: WebhookAction[];

  /**
   * The provisioning state of the webhook at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * The parameters for creating a webhook.
 */
model WebhookCreateParameters {
  /**
   * The tags for the webhook.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The location of the webhook. This cannot be changed after the resource is created.
   */
  location: string;

  /**
   * The properties that the webhook will be created with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: WebhookPropertiesCreateParameters;
}

/**
 * The parameters for creating the properties of a webhook.
 */
model WebhookPropertiesCreateParameters {
  /**
   * The service URI for the webhook to post notifications.
   */
  @secret
  serviceUri: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  customHeaders?: Record<string>;

  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions: WebhookAction[];
}

/**
 * The parameters for updating a webhook.
 */
model WebhookUpdateParameters {
  /**
   * The tags for the webhook.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * The properties that the webhook will be updated with.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: WebhookPropertiesUpdateParameters;
}

/**
 * The parameters for updating the properties of a webhook.
 */
model WebhookPropertiesUpdateParameters {
  /**
   * The service URI for the webhook to post notifications.
   */
  @secret
  serviceUri?: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @secret
  customHeaders?: Record<string>;

  /**
   * The status of the webhook at the time the operation was called.
   */
  status?: WebhookStatus;

  /**
   * The scope of repositories where the event can be triggered. For example, 'foo:*' means events for all tags under repository 'foo'. 'foo:bar' means events for 'foo:bar' only. 'foo' is equivalent to 'foo:latest'. Empty means all events.
   */
  scope?: string;

  /**
   * The list of actions that trigger the webhook to post notifications.
   */
  actions?: WebhookAction[];
}

/**
 * The basic information of an event.
 */
model EventInfo {
  /**
   * The event ID.
   */
  id?: string;
}

/**
 * The result of a request to list events for a webhook.
 */
model EventListResult {
  /**
   * The list of events. Since this list may be incomplete, the nextLink field should be used to request the next list of events.
   */
  @pageItems
  value?: Event[];

  /**
   * The URI that can be used to request the next list of events.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The event for a webhook.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Event extends EventInfo {
  /**
   * The event request message sent to the service URI.
   */
  eventRequestMessage?: EventRequestMessage;

  /**
   * The event response message received from the service URI.
   */
  eventResponseMessage?: EventResponseMessage;
}

/**
 * The event request message sent to the service URI.
 */
model EventRequestMessage {
  /**
   * The content of the event request message.
   */
  content?: EventContent;

  /**
   * The headers of the event request message.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string>;

  /**
   * The HTTP method used to send the event request message.
   */
  method?: string;

  /**
   * The URI used to send the event request message.
   */
  requestUri?: string;

  /**
   * The HTTP message version.
   */
  version?: string;
}

/**
 * The content of the event request message.
 */
model EventContent {
  /**
   * The event ID.
   */
  id?: string;

  /**
   * The time at which the event occurred.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * The action that encompasses the provided event.
   */
  action?: string;

  /**
   * The target of the event.
   */
  target?: Target;

  /**
   * The request that generated the event.
   */
  request?: Request;

  /**
   * The agent that initiated the event. For most situations, this could be from the authorization context of the request.
   */
  actor?: Actor;

  /**
   * The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.
   */
  source?: Source;
}

/**
 * The target of the event.
 */
model Target {
  /**
   * The MIME type of the referenced object.
   */
  mediaType?: string;

  /**
   * The number of bytes of the content. Same as Length field.
   */
  size?: int64;

  /**
   * The digest of the content, as defined by the Registry V2 HTTP API Specification.
   */
  digest?: string;

  /**
   * The number of bytes of the content. Same as Size field.
   */
  length?: int64;

  /**
   * The repository name.
   */
  repository?: string;

  /**
   * The direct URL to the content.
   */
  url?: string;

  /**
   * The tag name.
   */
  tag?: string;

  /**
   * The name of the artifact.
   */
  name?: string;

  /**
   * The version of the artifact.
   */
  version?: string;
}

/**
 * The request that generated the event.
 */
model Request {
  /**
   * The ID of the request that initiated the event.
   */
  id?: string;

  /**
   * The IP or hostname and possibly port of the client connection that initiated the event. This is the RemoteAddr from the standard http request.
   */
  addr?: string;

  /**
   * The externally accessible hostname of the registry instance, as specified by the http host header on incoming requests.
   */
  host?: string;

  /**
   * The request method that generated the event.
   */
  method?: string;

  /**
   * The user agent header of the request.
   */
  useragent?: string;
}

/**
 * The agent that initiated the event. For most situations, this could be from the authorization context of the request.
 */
model Actor {
  /**
   * The subject or username associated with the request context that generated the event.
   */
  name?: string;
}

/**
 * The registry node that generated the event. Put differently, while the actor initiates the event, the source generates it.
 */
model Source {
  /**
   * The IP or hostname and the port of the registry node that generated the event. Generally, this will be resolved by os.Hostname() along with the running port.
   */
  addr?: string;

  /**
   * The running instance of an application. Changes after each restart.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  instanceID?: string;
}

/**
 * The event response message received from the service URI.
 */
model EventResponseMessage {
  /**
   * The content of the event response message.
   */
  content?: string;

  /**
   * The headers of the event response message.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  headers?: Record<string>;

  /**
   * The reason phrase of the event response message.
   */
  reasonPhrase?: string;

  /**
   * The status code of the event response message.
   */
  statusCode?: string;

  /**
   * The HTTP message version.
   */
  version?: string;
}

/**
 * The configuration of service URI and custom headers for the webhook.
 */
model CallbackConfig {
  /**
   * The service URI for the webhook to post notifications.
   */
  serviceUri: string;

  /**
   * Custom headers that will be added to the webhook notifications.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  customHeaders?: Record<string>;
}

/**
 * The properties of the Debian package Archive.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DebianArchiveProperties extends ArchiveProperties {
  /**
   * Debian distribution Name.
   */
  distributionName?: string;
}

/**
 * The properties of the archive package source.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model DebianArchivePackageSourceProperties
  extends ArchivePackageSourceProperties {
  /**
   * Upstream Debian distribution Name.
   */
  distributionName?: string;
}

/**
 * The properties of a storage account for a container registry. Only applicable to Classic SKU.
 */
model StorageAccountProperties {
  /**
   * The resource ID of the storage account.
   */
  id: string;
}

/**
 * The properties of a package type.
 */
model PackageType {
  /**
   * The name of the package type.
   */
  name?: string;

  /**
   * The endpoint of the package type.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * The Active Directory Object that will be used for authenticating the token of a container registry.
 */
model ActiveDirectoryObject {
  /**
   * The user/group/application object ID for Active Directory Object that will be used for authenticating the token of a container registry.
   */
  objectId?: string;

  /**
   * The tenant ID of user/group/application object Active Directory Object that will be used for authenticating the token of a container registry.
   */
  tenantId?: string;
}

/**
 * The result of a request to list archive versions for a container registry.
 */
@removed(Versions.v2025_11_01)
model ArchiveVersionListResult {
  /**
   * The list of archive versions. Since this list may be incomplete, the nextLink field should be used to request the next list of archive versions.
   */
  @pageItems
  value?: ArchiveVersion[];

  /**
   * The URI that can be used to request the next list of archive versions.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list connected registries for a container registry.
 */
model ConnectedRegistryListResult {
  /**
   * The list of connected registries. Since this list may be incomplete, the nextLink field should be used to request the next list of connected registries.
   */
  @pageItems
  value?: ConnectedRegistry[];

  /**
   * The URI that can be used to request the next list of connected registries.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list credential sets for a container registry.
 */
model CredentialSetListResult {
  /**
   * The list of credential sets. Since this list may be incomplete, the nextLink field should be used to request the next list of credential sets.
   */
  @pageItems
  value?: CredentialSet[];

  /**
   * The URI that can be used to request the next list of credential sets.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list export pipelines for a container registry.
 */
@removed(Versions.v2025_11_01)
model ExportPipelineListResult {
  /**
   * The list of export pipelines. Since this list may be incomplete, the nextLink field should be used to request the next list of export pipelines.
   */
  @pageItems
  value?: ExportPipeline[];

  /**
   * The URI that can be used to request the next list of export pipelines.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list import pipelines for a container registry.
 */
@removed(Versions.v2025_11_01)
model ImportPipelineListResult {
  /**
   * The list of import pipelines. Since this list may be incomplete, the nextLink field should be used to request the next list of import pipelines.
   */
  @pageItems
  value?: ImportPipeline[];

  /**
   * The URI that can be used to request the next list of import pipelines.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list pipeline runs for a container registry.
 */
@removed(Versions.v2025_11_01)
model PipelineRunListResult {
  /**
   * The list of pipeline runs. Since this list may be incomplete, the nextLink field should be used to request the next list of pipeline runs.
   */
  @pageItems
  value?: PipelineRun[];

  /**
   * The URI that can be used to request the next list of pipeline runs.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list private endpoint connections for a container registry.
 */
model PrivateEndpointConnectionListResult {
  /**
   * The list of private endpoint connections. Since this list may be incomplete, the nextLink field should be used to request the next list of private endpoint connections.
   */
  @pageItems
  value?: PrivateEndpointConnection[];

  /**
   * The URI that can be used to request the next list of private endpoint connections.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list private link resources for a container registry.
 */
model PrivateLinkResourceListResult {
  /**
   * The list of private link resources. Since this list may be incomplete, the nextLink field should be used to request the next list of private link resources.
   */
  @pageItems
  value?: PrivateLinkResource[];

  /**
   * The URI that can be used to request the next list of private link resources.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list container registries.
 */
model RegistryListResult {
  /**
   * The list of container registries. Since this list may be incomplete, the nextLink field should be used to request the next list of container registries.
   */
  @pageItems
  value?: Registry[];

  /**
   * The URI that can be used to request the next list of container registries.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list replications for a container registry.
 */
model ReplicationListResult {
  /**
   * The list of replications. Since this list may be incomplete, the nextLink field should be used to request the next list of replications.
   */
  @pageItems
  value?: Replication[];

  /**
   * The URI that can be used to request the next list of replications.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list scope maps for a container registry.
 */
model ScopeMapListResult {
  /**
   * The list of scope maps. Since this list may be incomplete, the nextLink field should be used to request the next list of scope maps.
   */
  @pageItems
  value?: ScopeMap[];

  /**
   * The URI that can be used to request the next list of scope maps.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list tokens for a container registry.
 */
model TokenListResult {
  /**
   * The list of tokens. Since this list may be incomplete, the nextLink field should be used to request the next list of tokens.
   */
  @pageItems
  value?: Token[];

  /**
   * The URI that can be used to request the next list of tokens.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The result of a request to list webhooks for a container registry.
 */
model WebhookListResult {
  /**
   * The list of webhooks. Since this list may be incomplete, the nextLink field should be used to request the next list of webhooks.
   */
  @pageItems
  value?: Webhook[];

  /**
   * The URI that can be used to request the next list of webhooks.
   */
  @nextLink
  nextLink?: string;
}
