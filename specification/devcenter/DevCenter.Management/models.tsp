import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DevCenter;

/**
 * Provisioning state of the resource.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Created: "Created",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updated: "Updated",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MovingResources: "MovingResources",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TransientFailure: "TransientFailure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  RolloutInProgress: "RolloutInProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StorageProvisioningFailed: "StorageProvisioningFailed",
}

/**
 * Values can be systemAssignedIdentity or userAssignedIdentity
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  systemAssignedIdentity: "systemAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  userAssignedIdentity: "userAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  delegatedResourceIdentity: "delegatedResourceIdentity",
}

/**
 * Catalog item sync types enable or disable status. Indicates whether project catalogs are allowed to sync catalog items under projects associated to this dev center.
 */
union CatalogItemSyncEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Indicates whether pools in this Dev Center can use Microsoft Hosted Networks. Defaults to Enabled if not set.
 */
union MicrosoftHostedNetworkEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Setting to be used when determining whether to install the Azure Monitor Agent service on Dev Boxes that belong to this dev center.
 */
union InstallAzureMonitorAgentEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
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
 * Devbox disk encryption enable or disable status. Indicates if Devbox disks encryption is enabled or not.
 */
union DevboxDisksEncryptionEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The type of identity used to access the key vault key.
 */
union CmkIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
}

/**
 * Indicates what action to perform for the policy.
 */
union PolicyAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
}

/**
 * Indicates dev center resource types.
 */
union DevCenterResourceType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Images: "Images",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AttachedNetworks: "AttachedNetworks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Skus: "Skus",
}

/**
 * Indicates catalog item types.
 */
union CatalogItemType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  EnvironmentDefinition: "EnvironmentDefinition",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageDefinition: "ImageDefinition",
}

/**
 * Values can be systemAssignedIdentity or userAssignedIdentity
 */
union ProjectCustomizationIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  systemAssignedIdentity: "systemAssignedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  userAssignedIdentity: "userAssignedIdentity",
}

/**
 * Indicates whether user customizations are enabled.
 */
union UserCustomizationsEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Indicates possible values for Dev Box delete mode.
 */
union DevBoxDeleteMode {
  string,

  /**
   * Dev Boxes will not be deleted automatically, and user must manually delete. This is the default.
   */
  Manual: "Manual",

  /**
   * Dev Boxes will be deleted automatically according to configured settings.
   */
  Auto: "Auto",
}

/**
 * Indicates whether Azure AI services are enabled for a project.
 */
union AzureAiServicesMode {
  string,

  /**
   * Azure AI services are disabled for this project.
   */
  Disabled: "Disabled",

  /**
   * Azure AI services are enabled for this project and necessary resources will be automatically setup.
   */
  AutoDeploy: "AutoDeploy",
}

/**
 * Indicates whether serverless GPU session access is enabled.
 */
union ServerlessGpuSessionsMode {
  string,

  /**
   * Serverless GPU session access is disabled.
   */
  Disabled: "Disabled",

  /**
   * Serverless GPU session access is enabled and necessary resources will be automatically setup.
   */
  AutoDeploy: "AutoDeploy",
}

/**
 * Indicates whether workspace storage is enabled.
 */
union WorkspaceStorageMode {
  string,

  /**
   * Workspace storage is disabled.
   */
  Disabled: "Disabled",

  /**
   * Workspace storage is enabled and necessary resources will be automatically setup.
   */
  AutoDeploy: "AutoDeploy",
}

/**
 * Health check status values
 */
union HealthCheckStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Passed: "Passed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Informational: "Informational",
}

/**
 * Active Directory join type
 */
union DomainJoinType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HybridAzureADJoin: "HybridAzureADJoin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureADJoin: "AzureADJoin",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The synchronization state of the catalog.
 */
union CatalogSyncState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * The connection state of the catalog.
 */
union CatalogConnectionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * Indicates the type of sync that is configured for the catalog.
 */
union CatalogSyncType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Scheduled: "Scheduled",
}

/**
 * The type of data a parameter accepts.
 */
union ParameterType {
  string,

  /**
   * The parameter accepts an array of values.
   */
  array: "array",

  /**
   * The parameter accepts a boolean value.
   */
  boolean: "boolean",

  /**
   * The parameter accepts an integer value.
   */
  integer: "integer",

  /**
   * The parameter accepts a number value.
   */
  number: "number",

  /**
   * The parameter accepts an object value.
   */
  object: "object",

  /**
   * The parameter accepts a string value.
   */
  string: "string",
}

/**
 * Catalog resource validation status
 */
union CatalogResourceValidationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Indicates whether hibernate is enabled/disabled.
 */
union HibernateSupport {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Indicates whether the environment type is either enabled or disabled.
 */
union EnvironmentTypeEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Image validation status
 */
union ImageValidationStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TimedOut: "TimedOut",
}

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Internal: "Internal",
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
 * The reason why the given name is not available.
 */
union CheckNameAvailabilityReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * Type of the input.
 */
union CustomizationTaskInputType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  string: "string",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  number: "number",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  boolean: "boolean",
}

/**
 * The state of an Image Definition Build.
 */
union ImageDefinitionBuildStatus {
  string,

  /**
   * The image build has succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * The image build is running.
   */
  Running: "Running",

  /**
   * The built image has failed validation.
   */
  ValidationFailed: "ValidationFailed",

  /**
   * The image build has failed.
   */
  Failed: "Failed",

  /**
   * The image build has been cancelled.
   */
  Cancelled: "Cancelled",

  /**
   * The image build has timed out.
   */
  TimedOut: "TimedOut",
}

/**
 * Indicates whether auto image build is enabled/disabled.
 */
union AutoImageBuildStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Health status indicating whether a pool is available to create Dev Boxes.
 */
union HealthStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Healthy: "Healthy",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unhealthy: "Unhealthy",
}

/**
 * Indicates if the pool is created from an existing Dev Box Definition or if one is provided directly.
 */
union PoolDevBoxDefinitionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Reference: "Reference",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Value: "Value",
}

/**
 * License Types
 */
union LicenseType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Windows_Client: "Windows_Client",
}

/**
 * Local Administrator enable or disable status. Indicates whether owners of Dev Boxes are added as local administrators on the Dev Box.
 */
union LocalAdminStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Stop on disconnect enable or disable status. Indicates whether stop on disconnect to is either enabled or disabled.
 */
union StopOnDisconnectEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Stop on no connect enable or disable status.
 */
union StopOnNoConnectEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * SingleSignOn (SSO) enable or disable status. Indicates whether Dev Boxes in the Pool will have SSO enabled or disabled.
 */
union SingleSignOnStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Indicates a pool uses a Virtual Network managed by Microsoft (Managed), or a customer provided Network (Unmanaged).
 */
union VirtualNetworkType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Managed: "Managed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unmanaged: "Unmanaged",
}

/**
 * Enables or disables whether Dev Boxes should be kept awake during active hours.
 */
union KeepAwakeEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Enables or disables whether Dev Boxes should be automatically started at commencement of active hours.
 */
union AutoStartEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Indicates whether Dev Box Tunnel is enabled.
 */
union DevBoxTunnelEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * The supported types for a scheduled task.
 */
union ScheduledType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StopDevBox: "StopDevBox",
}

/**
 * The frequency of task execution.
 */
union ScheduledFrequency {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Daily: "Daily",
}

/**
 * Schedule enable or disable status. Indicates whether the schedule applied to is either enabled or disabled.
 */
union ScheduleEnableStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The days of the week.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DaysOfWeek {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday,
}

/**
 * Properties of the devcenter.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DevCenterProperties extends DevCenterUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The URI of the Dev Center.
   */
  @visibility(Lifecycle.Read)
  devCenterUri?: string;
}

/**
 * Properties of the devcenter. These properties can be updated after the resource has been created.
 */
model DevCenterUpdateProperties {
  /**
   * Encryption settings to be used for server-side encryption for proprietary content (such as catalogs, logs, customizations).
   */
  encryption?: Encryption;

  /**
   * The display name of the devcenter.
   */
  displayName?: string;

  /**
   * Dev Center settings to be used when associating a project with a catalog.
   */
  projectCatalogSettings?: DevCenterProjectCatalogSettings;

  /**
   * Network settings that will be enforced on network resources associated with the Dev Center.
   */
  networkSettings?: DevCenterNetworkSettings;

  /**
   * Settings to be used in the provisioning of all Dev Boxes that belong to this dev center.
   */
  devBoxProvisioningSettings?: DevBoxProvisioningSettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model Encryption {
  /**
   * All Customer-managed key encryption properties for the resource.
   */
  customerManagedKeyEncryption?: CustomerManagedKeyEncryption;
}

/**
 * All identity configuration for Customer-managed key settings defining which identity should be used to auth to Key Vault.
 */
model CustomerManagedKeyEncryptionKeyEncryptionKeyIdentity {
  /**
   * Values can be systemAssignedIdentity or userAssignedIdentity
   */
  identityType?: IdentityType;

  /**
   * user assigned identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity and delegatedResourceIdentity.
   */
  userAssignedIdentityResourceId?: Azure.Core.armResourceIdentifier;

  /**
   * delegated identity to use for accessing key encryption key Url. Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity and userAssignedIdentity - internal use only.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @format("uuid")
  delegatedIdentityClientId?: string;
}

/**
 * Project catalog settings for project catalogs under a project associated to this dev center.
 */
model DevCenterProjectCatalogSettings {
  /**
   * Whether project catalogs associated with projects in this dev center can be configured to sync catalog items.
   */
  catalogItemSyncEnableStatus?: CatalogItemSyncEnableStatus;
}

/**
 * Network settings for the Dev Center.
 */
model DevCenterNetworkSettings {
  /**
   * Indicates whether pools in this Dev Center can use Microsoft Hosted Networks. Defaults to Enabled if not set.
   */
  microsoftHostedNetworkEnableStatus?: MicrosoftHostedNetworkEnableStatus;
}

/**
 * Provisioning settings that apply to all Dev Boxes created in this dev center
 */
model DevBoxProvisioningSettings {
  /**
   * Whether project catalogs associated with projects in this dev center can be configured to sync catalog items.
   */
  installAzureMonitorAgentEnableStatus?: InstallAzureMonitorAgentEnableStatus;
}

/**
 * The devcenter resource for partial updates. Properties not provided in the update request will not be changed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DevCenterUpdate extends TrackedResourceUpdate {
  /**
   * Managed identity properties
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Properties of a Dev Center to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DevCenterUpdateProperties;
}

/**
 * Base tracked resource type for PATCH updates
 */
model TrackedResourceUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * Properties of the devcenter encryption set.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DevCenterEncryptionSetProperties
  extends DevCenterEncryptionSetUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

model EncryptionSetListResult is Azure.Core.Page<DevCenterEncryptionSet>;

/**
 * Properties of the devcenter encryption set. These properties can be updated after the resource has been created.
 */
model DevCenterEncryptionSetUpdateProperties {
  /**
   * Devbox disk encryption enable or disable status. Indicates if Devbox disks encryption using DevCenter CMK is enabled or not.
   */
  devboxDisksEncryptionEnableStatus?: DevboxDisksEncryptionEnableStatus;

  /**
   * Key encryption key Url, versioned or non-versioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek.
   */
  keyEncryptionKeyUrl?: url;

  /**
   * The managed identity configuration used for key vault access.
   */
  keyEncryptionKeyIdentity?: DevCenterEncryptionSetUpdatePropertiesKeyEncryptionKeyIdentity;
}

/**
 * The managed identity configuration used for key vault access.
 */
model DevCenterEncryptionSetUpdatePropertiesKeyEncryptionKeyIdentity {
  /**
   * The type of managed identity to use for key vault access.
   */
  type?: CmkIdentityType;

  /**
   * For system assigned identity, this will be null. For user assigned identity, this should be the resource ID of the identity.
   */
  userAssignedIdentityResourceId?: string;
}

/**
 * The devcenter encryption set resource for partial updates. Properties not provided in the update request will not be changed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model EncryptionSetUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a Dev Center encryption set to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DevCenterEncryptionSetUpdateProperties;

  /**
   * Managed identity properties
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Properties of an project policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProjectPolicyProperties extends ProjectPolicyUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Properties of an project policy. These properties can be updated after the resource has been created.
 */
model ProjectPolicyUpdateProperties {
  /**
   * Resource policies that are a part of this project policy.
   */
  resourcePolicies?: ResourcePolicy[];

  /**
   * Resources that have access to the shared resources that are a part of this project policy.
   */
  scopes?: string[];
}

/**
 * A resource policy.
 */
model ResourcePolicy {
  /**
   * Resources that are included and shared as a part of a project policy.
   */
  resources?: string;

  /**
   * Optional. When specified, this expression is used to filter the resources.
   */
  filter?: string;

  /**
   * Policy action to be taken on the resources. This is optional, and defaults to allow
   */
  action?: PolicyAction;

  /**
   * Optional. The resource type being restricted or allowed by a project policy. Used with a given action to restrict or allow access to a resource type.
   */
  resourceType?: DevCenterResourceType;
}

/**
 * The project policy properties for partial update. Properties not provided in the update request will not be changed.
 */
model ProjectPolicyUpdate {
  /**
   * Properties of an project policy to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ProjectPolicyUpdateProperties;
}

/**
 * Properties of a project.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProjectProperties extends ProjectUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The URI of the Dev Center resource this project is associated with.
   */
  @visibility(Lifecycle.Read)
  devCenterUri?: string;
}

/**
 * Properties of a project. These properties can be updated after the resource has been created.
 */
model ProjectUpdateProperties {
  /**
   * Resource Id of an associated DevCenter
   */
  devCenterId?: string;

  /**
   * Description of the project.
   */
  description?: string;

  /**
   * When specified, limits the maximum number of Dev Boxes a single user can create across all pools in the project. This will have no effect on existing Dev Boxes when reduced.
   */
  maxDevBoxesPerUser?: int32;

  /**
   * The display name of the project.
   */
  displayName?: string;

  /**
   * Settings to be used when associating a project with a catalog.
   */
  catalogSettings?: ProjectCatalogSettings;

  /**
   * Settings to be used for customizations.
   */
  customizationSettings?: ProjectCustomizationSettings;

  /**
   * Dev Box Auto Delete settings.
   */
  devBoxAutoDeleteSettings?: DevBoxAutoDeleteSettings;

  /**
   * Indicates whether Azure AI services are enabled for a project.
   */
  azureAiServicesSettings?: AzureAiServicesSettings;

  /**
   * Settings to be used for serverless GPU.
   */
  serverlessGpuSessionsSettings?: ServerlessGpuSessionsSettings;

  /**
   * Settings to be used for workspace storage.
   */
  workspaceStorageSettings?: WorkspaceStorageSettings;
}

/**
 * Settings to be used when associating a project with a catalog.
 */
model ProjectCatalogSettings {
  /**
   * Indicates catalog item types that can be synced.
   */
  catalogItemSyncTypes?: CatalogItemType[];
}

/**
 * Settings to be used for customizations.
 */
model ProjectCustomizationSettings {
  /**
   * The identities that can to be used in customization scenarios; e.g., to clone a repository.
   */
  identities?: ProjectCustomizationManagedIdentity[];

  /**
   * Indicates whether user customizations are enabled.
   */
  userCustomizationsEnableStatus?: UserCustomizationsEnableStatus;
}

/**
 * A reference to a Managed Identity that is attached to the Project.
 */
model ProjectCustomizationManagedIdentity {
  /**
   * Values can be systemAssignedIdentity or userAssignedIdentity
   */
  identityType?: ProjectCustomizationIdentityType;

  /**
   * Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity.
   */
  identityResourceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Settings controlling the auto deletion of inactive dev boxes.
 */
model DevBoxAutoDeleteSettings {
  /**
   * Indicates the delete mode for Dev Boxes within this project.
   */
  deleteMode?: DevBoxDeleteMode;

  /**
   * ISO8601 duration required for the dev box to not be inactive prior to it being scheduled for deletion.  ISO8601 format PT[n]H[n]M[n]S.
   */
  inactiveThreshold?: string;

  /**
   * ISO8601 duration required for the dev box to be marked for deletion prior to it being deleted. ISO8601 format PT[n]H[n]M[n]S.
   */
  gracePeriod?: string;
}

/**
 * Configures Azure AI related services for the project.
 */
model AzureAiServicesSettings {
  /**
   * The property indicates whether Azure AI services is enabled.
   */
  azureAiServicesMode?: AzureAiServicesMode;
}

/**
 * Represents settings for serverless GPU access.
 */
model ServerlessGpuSessionsSettings {
  /**
   * The property indicates whether serverless GPU access is enabled on the project.
   */
  serverlessGpuSessionsMode?: ServerlessGpuSessionsMode;

  /**
   * When specified, limits the maximum number of concurrent sessions across all pools in the project.
   */
  @minValue(1)
  maxConcurrentSessionsPerProject?: int32;
}

/**
 * Settings to be used for workspace storage.
 */
model WorkspaceStorageSettings {
  /**
   * Indicates whether workspace storage is enabled.
   */
  workspaceStorageMode?: WorkspaceStorageMode;
}

/**
 * The project properties for partial update. Properties not provided in the update request will not be changed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProjectUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a project to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ProjectUpdateProperties;

  /**
   * Managed identity properties
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Applicable inherited settings for a project.
 */
model InheritedSettingsForProject {
  /**
   * Dev Center settings to be used when associating a project with a catalog.
   */
  @visibility(Lifecycle.Read)
  projectCatalogSettings?: DevCenterProjectCatalogSettings;

  /**
   * Network settings that will be enforced on this project.
   */
  @visibility(Lifecycle.Read)
  networkSettings?: ProjectNetworkSettings;
}

/**
 * Network settings for the project.
 */
model ProjectNetworkSettings {
  /**
   * Indicates whether pools in this Dev Center can use Microsoft Hosted Networks. Defaults to Enabled if not set.
   */
  @visibility(Lifecycle.Read)
  microsoftHostedNetworkEnableStatus?: MicrosoftHostedNetworkEnableStatus;
}

/**
 * Properties of an attached NetworkConnection.
 */
model AttachedNetworkConnectionProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the NetworkConnection you want to attach.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkConnectionId: string;

  /**
   * The geo-location where the NetworkConnection resource specified in 'networkConnectionResourceId' property lives.
   */
  @visibility(Lifecycle.Read)
  networkConnectionLocation?: string;

  /**
   * Health check status values
   */
  @visibility(Lifecycle.Read)
  healthCheckStatus?: HealthCheckStatus;

  /**
   * AAD Join type of the network. This is populated based on the referenced Network Connection.
   */
  @visibility(Lifecycle.Read)
  domainJoinType?: DomainJoinType;
}

model AttachedNetworkListResult is Azure.Core.Page<AttachedNetworkConnection>;

/**
 * Properties of a catalog.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model CatalogProperties extends CatalogUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The synchronization state of the catalog.
   */
  @visibility(Lifecycle.Read)
  syncState?: CatalogSyncState;

  /**
   * Stats of the latest synchronization.
   */
  @visibility(Lifecycle.Read)
  lastSyncStats?: SyncStats;

  /**
   * The connection state of the catalog.
   */
  @visibility(Lifecycle.Read)
  connectionState?: CatalogConnectionState;

  /**
   * When the catalog was last connected.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastConnectionTime?: utcDateTime;

  /**
   * When the catalog was last synced.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;
}

/**
 * Stats of the synchronization.
 */
model SyncStats {
  /**
   * Count of catalog items added during synchronization.
   */
  @visibility(Lifecycle.Read)
  added?: int32;

  /**
   * Count of catalog items updated during synchronization.
   */
  @visibility(Lifecycle.Read)
  updated?: int32;

  /**
   * Count of catalog items that were unchanged during synchronization.
   */
  @visibility(Lifecycle.Read)
  unchanged?: int32;

  /**
   * Count of catalog items removed during synchronization.
   */
  @visibility(Lifecycle.Read)
  removed?: int32;

  /**
   * Count of catalog items that had validation errors during synchronization.
   */
  @visibility(Lifecycle.Read)
  validationErrors?: int32;

  /**
   * Count of synchronization errors that occured during synchronization.
   */
  @visibility(Lifecycle.Read)
  synchronizationErrors?: int32;

  /**
   * Indicates catalog item types that were synced.
   */
  syncedCatalogItemTypes?: CatalogItemType[];
}

/**
 * Properties of a catalog. These properties can be updated after the resource has been created.
 */
model CatalogUpdateProperties {
  /**
   * Properties for a GitHub catalog type.
   */
  gitHub?: GitCatalog;

  /**
   * Properties for an Azure DevOps catalog type.
   */
  adoGit?: GitCatalog;

  /**
   * Indicates the type of sync that is configured for the catalog.
   */
  syncType?: CatalogSyncType;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Properties for a Git repository catalog.
 */
model GitCatalog {
  /**
   * Git URI.
   */
  uri?: string;

  /**
   * Git branch.
   */
  branch?: string;

  /**
   * A reference to the Key Vault secret containing a security token to authenticate to a Git repository.
   */
  secretIdentifier?: string;

  /**
   * The folder where the catalog items can be found inside the repository.
   */
  path?: string;
}

/**
 * The catalog's properties for partial update. Properties not provided in the update request will not be changed.
 */
model CatalogUpdate {
  /**
   * Catalog properties for update.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: CatalogUpdateProperties;
}

/**
 * Properties of an environment definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model EnvironmentDefinitionProperties {
  /**
   * A short description of the environment definition.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Input parameters passed to an environment.
   */
  @visibility(Lifecycle.Read)
  parameters?: EnvironmentDefinitionParameter[];

  /**
   * Path to the Environment Definition entrypoint file.
   */
  @visibility(Lifecycle.Read)
  templatePath?: string;

  /**
   * Validation status for the environment definition.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;
}

/**
 * Properties of an Environment Definition parameter
 */
model EnvironmentDefinitionParameter {
  /**
   * Unique ID of the parameter
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Display name of the parameter
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Description of the parameter
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * A string of one of the basic JSON types (number, integer, array, object, boolean, string)
   */
  @visibility(Lifecycle.Read)
  type?: ParameterType;

  /**
   * Whether or not this parameter is read-only.  If true, default should have a value.
   */
  @visibility(Lifecycle.Read)
  readOnly?: boolean;

  /**
   * Whether or not this parameter is required
   */
  @visibility(Lifecycle.Read)
  required?: boolean;
}

/**
 * List of validator error details. Populated when changes are made to the resource or its dependent resources that impact the validity of the Catalog resource.
 */
model CatalogResourceValidationErrorDetails {
  /**
   * Errors associated with resources synchronized from the catalog.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  errors?: CatalogErrorDetails[];
}

/**
 * Catalog error details
 */
model CatalogErrorDetails {
  /**
   * An identifier for the error.
   */
  code?: string;

  /**
   * A message describing the error.
   */
  message?: string;
}

/**
 * Synchronization error details.
 */
model SyncErrorDetails {
  /**
   * Error information for the overall synchronization operation.
   */
  @visibility(Lifecycle.Read)
  operationError?: CatalogErrorDetails;

  /**
   * Catalog items that have conflicting names.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  conflicts?: CatalogConflictError[];

  /**
   * Errors that occured during synchronization.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  errors?: CatalogSyncError[];
}

/**
 * An individual conflict error.
 */
model CatalogConflictError {
  /**
   * The path of the file that has a conflicting name.
   */
  @visibility(Lifecycle.Read)
  path?: string;

  /**
   * Name of the conflicting catalog item.
   */
  @visibility(Lifecycle.Read)
  name?: string;
}

/**
 * An individual synchronization error.
 */
model CatalogSyncError {
  /**
   * The path of the file the error is associated with.
   */
  @visibility(Lifecycle.Read)
  path?: string;

  /**
   * Errors associated with the file.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  errorDetails?: CatalogErrorDetails[];
}

/**
 * Properties of a gallery.
 */
model GalleryProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the backing Azure Compute Gallery.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  galleryResourceId: string;
}

/**
 * Properties of an image.
 */
model ImageProperties {
  /**
   * The description of the image.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The publisher of the image.
   */
  @visibility(Lifecycle.Read)
  publisher?: string;

  /**
   * The name of the image offer.
   */
  @visibility(Lifecycle.Read)
  offer?: string;

  /**
   * The SKU name for the image.
   */
  @visibility(Lifecycle.Read)
  sku?: string;

  /**
   * The recommended machine configuration to use with the image.
   */
  @visibility(Lifecycle.Read)
  recommendedMachineConfiguration?: RecommendedMachineConfiguration;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Indicates whether this image has hibernate enabled. Not all images are capable of supporting hibernation. To find out more see https://aka.ms/devbox/hibernate
   */
  @visibility(Lifecycle.Read)
  hibernateSupport?: HibernateSupport;
}

/**
 * Properties for a recommended machine configuration.
 */
model RecommendedMachineConfiguration {
  /**
   * Recommended memory range.
   */
  @visibility(Lifecycle.Read)
  memory?: ResourceRange;

  /**
   * Recommended vCPU range.
   */
  @visibility(Lifecycle.Read)
  vCPUs?: ResourceRange;
}

/**
 * Properties for a range of values.
 */
model ResourceRange {
  /**
   * Minimum value.
   */
  @visibility(Lifecycle.Read)
  min?: int32;

  /**
   * Maximum value.
   */
  @visibility(Lifecycle.Read)
  max?: int32;
}

/**
 * Properties of an image version.
 */
model ImageVersionProperties {
  /**
   * The semantic version string.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The datetime that the backing image version was published.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDate?: utcDateTime;

  /**
   * If the version should be excluded from being treated as the latest version.
   */
  @visibility(Lifecycle.Read)
  excludeFromLatest?: boolean;

  /**
   * The size of the OS disk image, in GB.
   */
  @visibility(Lifecycle.Read)
  osDiskImageSizeInGb?: int32;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Results of the Microsoft.DevCenter SKU list operation.
 */
model SkuListResult is Azure.Core.Page<DevCenterSku>;

/**
 * The resource model definition representing SKU for DevCenter resources
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DevCenterSku extends Azure.ResourceManager.CommonTypes.Sku {
  /**
   * The name of the resource type
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * SKU supported locations.
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * Collection of name/value pairs to describe the SKU capabilities.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  capabilities?: Capability[];
}

/**
 * A name/value pair to describe a capability.
 */
model Capability {
  /**
   * Name of the capability.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Value of the capability.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * Properties of an environment type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model EnvironmentTypeProperties extends EnvironmentTypeUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Properties of an environment type. These properties can be updated after the resource has been created.
 */
model EnvironmentTypeUpdateProperties {
  /**
   * The display name of the environment type.
   */
  displayName?: string;
}

/**
 * The environment type for partial update. Properties not provided in the update request will not be changed.
 */
model EnvironmentTypeUpdate {
  /**
   * Properties of an environment type to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: EnvironmentTypeUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties of an allowed environment type.
 */
model AllowedEnvironmentTypeProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The display name of the allowed environment type.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

model AllowedEnvironmentTypeListResult
  is Azure.Core.Page<AllowedEnvironmentType>;

/**
 * Properties of a project environment type.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProjectEnvironmentTypeProperties
  extends ProjectEnvironmentTypeUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The number of environments of this type.
   */
  @visibility(Lifecycle.Read)
  environmentCount?: int32;
}

/**
 * Properties of a project environment type. These properties can be updated after the resource has been created.
 */
model ProjectEnvironmentTypeUpdateProperties {
  /**
   * Id of a subscription that the environment type will be mapped to. The environment's resources will be deployed into this subscription.
   */
  deploymentTargetId?: string;

  /**
   * The display name of the project environment type.
   */
  displayName?: string;

  /**
   * Defines whether this Environment Type can be used in this Project.
   */
  status?: EnvironmentTypeEnableStatus;

  /**
   * The role definition assigned to the environment creator on backing resources.
   */
  creatorRoleAssignment?: ProjectEnvironmentTypeUpdatePropertiesCreatorRoleAssignment;

  /**
   * Role Assignments created on environment backing resources. This is a mapping from a user object ID to an object of role definition IDs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userRoleAssignments?: Record<UserRoleAssignmentValue>;
}

/**
 * The role definition assigned to the environment creator on backing resources.
 */
model ProjectEnvironmentTypeUpdatePropertiesCreatorRoleAssignment {
  /**
   * A map of roles to assign to the environment creator.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  roles?: Record<EnvironmentRole>;
}

/**
 * A role that can be assigned to a user.
 */
model EnvironmentRole {
  /**
   * The common name of the Role Assignment. This is a descriptive name such as 'AcrPush'.
   */
  @visibility(Lifecycle.Read)
  roleName?: string;

  /**
   * This is a description of the Role Assignment.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Mapping of user object ID to role assignments.
 */
model UserRoleAssignmentValue {
  /**
   * A map of roles to assign to the parent user.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  roles?: Record<EnvironmentRole>;
}

/**
 * The project environment type for partial update. Properties not provided in the update request will not be changed.
 */
model ProjectEnvironmentTypeUpdate {
  /**
   * Properties to configure an environment type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ProjectEnvironmentTypeUpdateProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Managed identity properties
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

/**
 * Properties of a Dev Box definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DevBoxDefinitionProperties extends DevBoxDefinitionUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Validation status of the configured image.
   */
  @visibility(Lifecycle.Read)
  imageValidationStatus?: ImageValidationStatus;

  /**
   * Details for image validator error. Populated when the image validation is not successful.
   */
  @visibility(Lifecycle.Read)
  imageValidationErrorDetails?: ImageValidationErrorDetails;

  /**
   * Validation status for the Dev Box Definition.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;

  /**
   * Image reference information for the currently active image (only populated during updates).
   */
  @visibility(Lifecycle.Read)
  activeImageReference?: ImageReference;
}

/**
 * Image validation error details
 */
model ImageValidationErrorDetails {
  /**
   * An identifier for the error.
   */
  code?: string;

  /**
   * A message describing the error.
   */
  message?: string;
}

/**
 * Image reference information
 */
model ImageReference {
  /**
   * Image ID, or Image version ID. When Image ID is provided, its latest version will be used.
   */
  id?: string;

  /**
   * The actual version of the image after use. When id references a gallery image latest version, this will indicate the actual version in use.
   */
  @visibility(Lifecycle.Read)
  exactVersion?: string;
}

/**
 * Properties of a Dev Box definition. These properties can be updated after the resource has been created.
 */
model DevBoxDefinitionUpdateProperties {
  /**
   * Image reference information.
   */
  imageReference?: ImageReference;

  /**
   * The SKU for Dev Boxes created using this definition.
   */
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  /**
   * The storage type used for the Operating System disk of Dev Boxes created using this definition.
   */
  osStorageType?: string;

  /**
   * Indicates whether Dev Boxes created with this definition are capable of hibernation. Not all images are capable of supporting hibernation. To find out more see https://aka.ms/devbox/hibernate
   */
  hibernateSupport?: HibernateSupport;
}

/**
 * Partial update of a Dev Box definition resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model DevBoxDefinitionUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a Dev Box definition to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: DevBoxDefinitionUpdateProperties;
}

/**
 * Localized display information for this particular operation.
 */
model OperationDisplay {
  /**
   * The localized friendly form of the resource provider name, e.g. "Microsoft Monitoring Insights" or "Microsoft Compute".
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The localized friendly name of the resource type related to this operation. E.g. "Virtual Machines" or "Job Schedule Collections".
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * The concise, localized friendly name for the operation; suitable for dropdowns. E.g. "Create or Update Virtual Machine", "Restart Virtual Machine".
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The short, localized friendly description of the operation; suitable for tool tips and detailed views.
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * The current status of an async operation
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model OperationStatus
  extends Azure.ResourceManager.CommonTypes.OperationStatusResult {
  /**
   * Custom operation properties, populated only for a successful operation.
   */
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;
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
   * The name of the resource.
   */
  value?: string;
}

/**
 * The scoped name check availability request body.
 */
model CheckScopedNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;

  /**
   * The resource id to scope the name check.
   */
  scope?: string;
}

/**
 * Properties of a Task.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model CustomizationTaskProperties {
  /**
   * Inputs to the task.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  inputs?: Record<CustomizationTaskInput>;

  /**
   * The default timeout for the task.
   */
  @visibility(Lifecycle.Read)
  timeout?: int32;

  /**
   * Validation status for the Task.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;
}

/**
 * Input for a Task.
 */
model CustomizationTaskInput {
  /**
   * Description of the input.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Type of the input.
   */
  @visibility(Lifecycle.Read)
  type?: CustomizationTaskInputType;

  /**
   * Whether or not the input is required.
   */
  @visibility(Lifecycle.Read)
  required?: boolean;
}

/**
 * Properties of an Image Definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ImageDefinitionProperties {
  /**
   * Image reference information.
   */
  imageReference?: ImageReference;

  /**
   * The URL to the repository file containing the image definition.
   */
  @visibility(Lifecycle.Read)
  fileUrl?: string;

  /**
   * Details about the latest build.
   */
  latestBuild?: LatestImageBuild;

  /**
   * Validation status of the configured image.
   */
  @visibility(Lifecycle.Read)
  imageValidationStatus?: ImageValidationStatus;

  /**
   * Details for image validator error. Populated when the image validation is not successful.
   */
  @visibility(Lifecycle.Read)
  imageValidationErrorDetails?: ImageValidationErrorDetails;

  /**
   * Validation status for the Image Definition.
   */
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;

  /**
   * Image reference information for the currently active image (only populated during updates).
   */
  @visibility(Lifecycle.Read)
  activeImageReference?: ImageReference;

  /**
   * Indicates if automatic image builds will be triggered for image definition updates
   */
  @visibility(Lifecycle.Read)
  autoImageBuild?: AutoImageBuildStatus;

  /**
   * Tasks to run at Dev Box provisioning time.
   */
  tasks?: CustomizationTaskInstance[];

  /**
   * Tasks to run when a user first logs into a Dev Box.
   */
  userTasks?: CustomizationTaskInstance[];

  /**
   * Another Image Definition that this one extends.
   */
  `extends`?: ImageDefinitionReference;
}

/**
 * Details about the latest build.
 */
model LatestImageBuild {
  /**
   * Identifier of a build.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Start time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The state of an Image Definition Build.
   */
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;
}

/**
 * A customization task to run.
 */
model CustomizationTaskInstance {
  /**
   * Name of the task.
   */
  name: string;

  /**
   * Parameters for the task.
   */
  parameters?: DefinitionParametersItem[];

  /**
   * Display name to help differentiate multiple instances of the same task.
   */
  displayName?: string;

  /**
   * Timeout, in seconds. Overrides any timeout provided on the task definition.
   */
  timeoutInSeconds?: int32;

  /**
   * An expression that must evaluate to true in order for the task to run.
   */
  condition?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DefinitionParametersItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  name: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value: string;
}

/**
 * A reference to an Image Definition.
 */
model ImageDefinitionReference {
  /**
   * Name of the referenced Image Definition.
   */
  imageDefinition: string;

  /**
   * Parameters for the referenced Image Definition.
   */
  parameters?: DefinitionParametersItem[];
}

/**
 * Properties of an Image Definition Build.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ImageDefinitionBuildProperties {
  /**
   * The specific image version used by the build.
   */
  @visibility(Lifecycle.Read)
  imageReference?: ImageReference;

  /**
   * The status of the build.
   */
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  /**
   * Start time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Details for image creation error. Populated when the image creation is not successful.
   */
  @visibility(Lifecycle.Read)
  errorDetails?: ImageCreationErrorDetails;
}

/**
 * Image creation error details
 */
model ImageCreationErrorDetails {
  /**
   * An identifier for the error.
   */
  code?: string;

  /**
   * A message describing the error.
   */
  message?: string;
}

/**
 * Represents a specific build of an Image Definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ImageDefinitionBuildDetails
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  /**
   * The specific image version used by the build.
   */
  @visibility(Lifecycle.Read)
  imageReference?: ImageReference;

  /**
   * The status of the build.
   */
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  /**
   * Start time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Details for image creation error. Populated when the image creation is not successful.
   */
  @visibility(Lifecycle.Read)
  errorDetails?: ImageCreationErrorDetails;

  /**
   * The list of task groups executed during the image definition build.
   */
  @visibility(Lifecycle.Read)
  taskGroups?: ImageDefinitionBuildTaskGroup[];
}

/**
 * A task group executed during the image definition build.
 */
model ImageDefinitionBuildTaskGroup {
  /**
   * The name of the task group.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The status of the task group.
   */
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  /**
   * Start time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the task group.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The list of tasks executed during the task group.
   */
  @visibility(Lifecycle.Read)
  tasks?: ImageDefinitionBuildTask[];
}

/**
 * A task executed during the image definition build.
 */
model ImageDefinitionBuildTask {
  /**
   * The name of the task.
   */
  name?: string;

  /**
   * Parameters for the task.
   */
  parameters?: ImageDefinitionBuildTaskParametersItem[];

  /**
   * Display name to help differentiate multiple instances of the same task.
   */
  displayName?: string;

  /**
   * ID of the task instance.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Start time of the task.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * End time of the task.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The status of the task.
   */
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  /**
   * The URI for retrieving logs for the task execution.
   */
  @visibility(Lifecycle.Read)
  logUri?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ImageDefinitionBuildTaskParametersItem {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  key: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  value: string;
}

/**
 * Properties of a Pool
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PoolProperties extends PoolUpdateProperties {
  /**
   * Overall health status of the Pool. Indicates whether or not the Pool is available to create Dev Boxes.
   */
  @visibility(Lifecycle.Read)
  healthStatus?: HealthStatus;

  /**
   * Details on the Pool health status to help diagnose issues. This is only populated when the pool status indicates the pool is in a non-healthy state
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["code"])
  healthStatusDetails?: HealthStatusDetail[];

  /**
   * Indicates the number of provisioned Dev Boxes in this pool.
   */
  @visibility(Lifecycle.Read)
  devBoxCount?: int32;

  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Pool health status detail.
 */
model HealthStatusDetail {
  /**
   * An identifier for the issue.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * A message describing the issue, intended to be suitable for display in a user interface
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Properties of a Pool. These properties can be updated after the resource has been created.
 */
model PoolUpdateProperties {
  /**
   * Indicates if the pool is created from an existing Dev Box Definition or if one is provided directly.
   */
  devBoxDefinitionType?: PoolDevBoxDefinitionType;

  /**
   * Name of a Dev Box definition in parent Project of this Pool. Will be ignored if devBoxDefinitionType is Value.
   */
  devBoxDefinitionName?: string;

  /**
   * A definition of the machines that are created from this Pool. Will be ignored if devBoxDefinitionType is Reference or not provided.
   */
  devBoxDefinition?: PoolDevBoxDefinition;

  /**
   * Name of a Network Connection in parent Project of this Pool
   */
  networkConnectionName?: string;

  /**
   * Specifies the license type indicating the caller has already acquired licenses for the Dev Boxes that will be created.
   */
  licenseType?: LicenseType;

  /**
   * Indicates whether owners of Dev Boxes in this pool are added as local administrators on the Dev Box.
   */
  localAdministrator?: LocalAdminStatus;

  /**
   * Stop on disconnect configuration settings for Dev Boxes created in this pool.
   */
  stopOnDisconnect?: StopOnDisconnectConfiguration;

  /**
   * Stop on no connect configuration settings for Dev Boxes created in this pool.
   */
  stopOnNoConnect?: StopOnNoConnectConfiguration;

  /**
   * Indicates whether Dev Boxes in this pool are created with single sign on enabled. The also requires that single sign on be enabled on the tenant.
   */
  singleSignOnStatus?: SingleSignOnStatus;

  /**
   * The display name of the pool.
   */
  displayName?: string;

  /**
   * Indicates whether the pool uses a Virtual Network managed by Microsoft or a customer provided network.
   */
  virtualNetworkType?: VirtualNetworkType;

  /**
   * The regions of the managed virtual network (required when managedNetworkType is Managed).
   */
  managedVirtualNetworkRegions?: string[];

  /**
   * Active hours configuration settings for Dev Boxes created in this pool.
   */
  activeHoursConfiguration?: ActiveHoursConfiguration;

  /**
   * Indicates whether Dev Box Tunnel is enabled for a the pool.
   */
  devBoxTunnelEnableStatus?: DevBoxTunnelEnableStatus;
}

/**
 * Represents a definition for a Developer Machine.
 */
model PoolDevBoxDefinition {
  /**
   * Image reference information.
   */
  imageReference?: ImageReference;

  /**
   * The SKU for Dev Boxes created from the Pool.
   */
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  /**
   * Image reference information for the currently active image (only populated during updates).
   */
  @visibility(Lifecycle.Read)
  activeImageReference?: ImageReference;
}

/**
 * Stop on disconnect configuration settings for Dev Boxes created in this pool.
 */
model StopOnDisconnectConfiguration {
  /**
   * Whether the feature to stop the Dev Box on disconnect once the grace period has lapsed is enabled.
   */
  status?: StopOnDisconnectEnableStatus;

  /**
   * The specified time in minutes to wait before stopping a Dev Box once disconnect is detected.
   */
  gracePeriodMinutes?: int32;
}

/**
 * Stop on no connect configuration settings for Dev Boxes created in this pool.
 */
model StopOnNoConnectConfiguration {
  /**
   * Enables the feature to stop a started Dev Box when it has not been connected to, once the grace period has lapsed.
   */
  status?: StopOnNoConnectEnableStatus;

  /**
   * The specified time in minutes to wait before stopping a Dev Box if no connection is made.
   */
  gracePeriodMinutes?: int32;
}

/**
 * Active hours configuration.
 */
model ActiveHoursConfiguration {
  /**
   * Enables or disables whether the Dev Box should be kept awake during active hours.
   */
  keepAwakeEnableStatus?: KeepAwakeEnableStatus;

  /**
   * Enables or disables whether the Dev Box should be automatically started at commencement of active hours.
   */
  autoStartEnableStatus?: AutoStartEnableStatus;

  /**
   * The default IANA timezone id of the active hours.
   */
  defaultTimeZone?: string;

  /**
   * The default start time of the active hours.
   */
  defaultStartTimeHour?: int32;

  /**
   * The default end time of the active hours
   */
  defaultEndTimeHour?: int32;

  /**
   * The days of the week that active hours features will be enabled. This serves as a default that can be updated by each individual user.
   */
  defaultDaysOfWeek?: DaysOfWeek[];

  /**
   * The maximum amount of days per week that a user can enable active hours related features.
   */
  daysOfWeekLimit?: int32;
}

/**
 * The pool properties for partial update. Properties not provided in the update request will not be changed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PoolUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a pool to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PoolUpdateProperties;
}

/**
 * The Schedule properties defining when and what to execute.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ScheduleProperties extends ScheduleUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Updatable properties of a Schedule.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ScheduleUpdateProperties extends TrackedResourceUpdate {
  /**
   * Supported type this scheduled task represents.
   */
  type?: ScheduledType;

  /**
   * The frequency of this scheduled task.
   */
  frequency?: ScheduledFrequency;

  /**
   * The target time to trigger the action. The format is HH:MM.
   */
  time?: string;

  /**
   * The IANA timezone id at which the schedule should execute.
   */
  timeZone?: string;

  /**
   * Indicates whether or not this scheduled task is enabled.
   */
  state?: ScheduleEnableStatus;
}

/**
 * The schedule properties for partial update. Properties not provided in the update request will not be changed.
 */
model ScheduleUpdate {
  /**
   * Properties of a schedule resource to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ScheduleUpdateProperties;
}

/**
 * Network properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkProperties extends NetworkConnectionUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Overall health status of the network connection. Health checks are run on creation, update, and periodically to validate the network connection.
   */
  @visibility(Lifecycle.Read)
  healthCheckStatus?: HealthCheckStatus;

  /**
   * The name for resource group where NICs will be placed.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkingResourceGroupName?: string;

  /**
   * AAD Join type.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  domainJoinType: DomainJoinType;
}

/**
 * Properties of network connection. These properties can be updated after the resource has been created.
 */
model NetworkConnectionUpdateProperties {
  /**
   * The subnet to attach Virtual Machines to
   */
  subnetId?: string;

  /**
   * Active Directory domain name
   */
  domainName?: string;

  /**
   * Active Directory domain Organization Unit (OU)
   */
  organizationUnit?: string;

  @doc("The username of an Active Directory account (user or service account) that has permissions to create computer objects in Active Directory. Required format: admin@contoso.com.")
  domainUsername?: string;

  /**
   * The password for the account used to join domain
   */
  domainPassword?: string;
}

/**
 * The network connection properties for partial update. Properties not provided in the update request will not be changed.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model NetworkConnectionUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a network connection resource to be updated.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: NetworkConnectionUpdateProperties;
}

/**
 * Health Check properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model HealthCheckStatusDetailsProperties {
  /**
   * Start time of last execution of the health checks.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * End time of last execution of the health checks.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * Details for each health check item.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  healthChecks?: HealthCheck[];
}

/**
 * An individual health check item
 */
model HealthCheck {
  /**
   * The status of the health check item.
   */
  @visibility(Lifecycle.Read)
  status?: HealthCheckStatus;

  /**
   * The display name of this health check item.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * Start time of health check item.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * End time of the health check item.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * The type of error that occurred during this health check.
   */
  @visibility(Lifecycle.Read)
  errorType?: string;

  /**
   * The recommended action to fix the corresponding error.
   */
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  /**
   * Additional details about the health check or the recommended action.
   */
  @visibility(Lifecycle.Read)
  additionalDetails?: string;
}

/**
 * Values returned by the List operation.
 */
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

/**
 * A collection of related endpoints from the same service for which the agent requires outbound access.
 */
model OutboundEnvironmentEndpoint {
  /**
   * The type of service that the agent connects to.
   */
  @visibility(Lifecycle.Read)
  category?: string;

  /**
   * The endpoints for this service for which the agent requires outbound access.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["domainName"])
  endpoints?: EndpointDependency[];
}

/**
 * A domain name and connection details used to access a dependency.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.
   */
  @visibility(Lifecycle.Read)
  domainName?: string;

  /**
   * Human-readable supplemental information about the dependency and when it is applicable.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The list of connection details for this endpoint.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  endpointDetails?: EndpointDetail[];
}

/**
 * Details about the connection between the Batch service and the endpoint.
 */
model EndpointDetail {
  /**
   * The port an endpoint is connected to.
   */
  @visibility(Lifecycle.Read)
  port?: int32;
}
@@visibility(AllowedEnvironmentTypeListResult.value, Lifecycle.Read);
@@visibility(AttachedNetworkListResult.value, Lifecycle.Read);
