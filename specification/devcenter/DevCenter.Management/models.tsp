import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DevCenter;

@doc("Provisioning state of the resource.")
union ProvisioningState {
  string,

  @doc("Not specified provisioning state.")
  NotSpecified: "NotSpecified",

  @doc("Accepted provisioning state.")
  Accepted: "Accepted",

  @doc("Running provisioning state.")
  Running: "Running",

  @doc("Creating provisioning state.")
  Creating: "Creating",

  @doc("Created provisioning state.")
  Created: "Created",

  @doc("Updating provisioning state.")
  Updating: "Updating",

  @doc("Updated provisioning state.")
  Updated: "Updated",

  @doc("Deleting provisioning state.")
  Deleting: "Deleting",

  @doc("Deleted provisioning state.")
  Deleted: "Deleted",

  @doc("Succeeded provisioning state.")
  Succeeded: "Succeeded",

  @doc("Failed provisioning state.")
  Failed: "Failed",

  @doc("Canceled provisioning state.")
  Canceled: "Canceled",

  @doc("Moving resources provisioning state.")
  MovingResources: "MovingResources",

  @doc("Transient failure provisioning state.")
  TransientFailure: "TransientFailure",

  @doc("Rollout in progress provisioning state.")
  RolloutInProgress: "RolloutInProgress",

  @doc("Storage provisioning failed provisioning state.")
  StorageProvisioningFailed: "StorageProvisioningFailed",
}

@doc("Catalog item sync types enable or disable status. Indicates whether project catalogs are allowed to sync catalog items under projects associated to this dev center.")
union CatalogItemSyncEnableStatus {
  string,

  @doc("Catalog item sync is enabled.")
  Enabled: "Enabled",

  @doc("Catalog item sync is disabled.")
  Disabled: "Disabled",
}

@doc("Indicates whether pools in this Dev Center can use Microsoft Hosted Networks. Defaults to Enabled if not set.")
union MicrosoftHostedNetworkEnableStatus {
  string,

  @doc("Microsoft Hosted Networks are enabled for this Dev Center.")
  Enabled: "Enabled",

  @doc("Microsoft Hosted Networks are disabled for this Dev Center.")
  Disabled: "Disabled",
}

@doc("Setting to be used when determining whether to install the Azure Monitor Agent service on Dev Boxes that belong to this dev center.")
union InstallAzureMonitorAgentEnableStatus {
  string,

  @doc("Azure Monitor Agent service is enabled.")
  Enabled: "Enabled",

  @doc("Azure Monitor Agent service is disabled.")
  Disabled: "Disabled",
}

@doc("Devbox disk encryption enable or disable status. Indicates if Devbox disks encryption is enabled or not.")
union DevboxDisksEncryptionEnableStatus {
  string,

  @doc("Devbox disks encryption is enabled.")
  Enabled: "Enabled",

  @doc("Devbox disks encryption is disabled.")
  Disabled: "Disabled",
}

@doc("The type of identity used to access the key vault key.")
union CmkIdentityType {
  string,

  @doc("System assigned identity type.")
  SystemAssigned: "SystemAssigned",

  @doc("User assigned identity type.")
  UserAssigned: "UserAssigned",
}

@doc("Indicates what action to perform for the policy.")
union PolicyAction {
  string,

  @doc("Allow action for the policy.")
  Allow: "Allow",

  @doc("Deny action for the policy.")
  Deny: "Deny",
}

@doc("Indicates dev center resource types.")
union DevCenterResourceType {
  string,

  @doc("Images resource type.")
  Images: "Images",

  @doc("Attached networks resource type.")
  AttachedNetworks: "AttachedNetworks",

  @doc("Skus resource type.")
  Skus: "Skus",
}

@doc("Indicates catalog item types.")
union CatalogItemType {
  string,

  @doc("Environment definition catalog item type.")
  EnvironmentDefinition: "EnvironmentDefinition",

  @doc("Image definition catalog item type.")
  ImageDefinition: "ImageDefinition",
}

@doc("Values can be systemAssignedIdentity or userAssignedIdentity")
union ProjectCustomizationIdentityType {
  string,

  @doc("System assigned identity type.")
  systemAssignedIdentity: "systemAssignedIdentity",

  @doc("User assigned identity type.")
  userAssignedIdentity: "userAssignedIdentity",
}

@doc("Indicates whether user customizations are enabled.")
union UserCustomizationsEnableStatus {
  string,

  @doc("User customizations are disabled.")
  Disabled: "Disabled",

  @doc("User customizations are enabled.")
  Enabled: "Enabled",
}

@doc("Indicates possible values for Dev Box delete mode.")
union DevBoxDeleteMode {
  string,

  @doc("Dev Boxes will not be deleted automatically, and user must manually delete. This is the default.")
  Manual: "Manual",

  @doc("Dev Boxes will be deleted automatically according to configured settings.")
  Auto: "Auto",
}

@doc("Indicates whether Azure AI services are enabled for a project.")
union AzureAiServicesMode {
  string,

  @doc("Azure AI services are disabled for this project.")
  Disabled: "Disabled",

  @doc("Azure AI services are enabled for this project and necessary resources will be automatically setup.")
  AutoDeploy: "AutoDeploy",
}

@doc("Indicates whether serverless GPU session access is enabled.")
union ServerlessGpuSessionsMode {
  string,

  @doc("Serverless GPU session access is disabled.")
  Disabled: "Disabled",

  @doc("Serverless GPU session access is enabled and necessary resources will be automatically setup.")
  AutoDeploy: "AutoDeploy",
}

@doc("Indicates whether workspace storage is enabled.")
union WorkspaceStorageMode {
  string,

  @doc("Workspace storage is disabled.")
  Disabled: "Disabled",

  @doc("Workspace storage is enabled and necessary resources will be automatically setup.")
  AutoDeploy: "AutoDeploy",
}

@doc("Health check status values.")
union HealthCheckStatus {
  string,

  @doc("Unknown health check status.")
  Unknown: "Unknown",

  @doc("Pending health check status.")
  Pending: "Pending",

  @doc("Running health check status.")
  Running: "Running",

  @doc("Passed health check status.")
  Passed: "Passed",

  @doc("Warning health check status.")
  Warning: "Warning",

  @doc("Failed health check status.")
  Failed: "Failed",

  @doc("Informational health check status.")
  Informational: "Informational",
}

@doc("Active Directory join type.")
union DomainJoinType {
  string,

  @doc("Hybrid Azure AD Join type.")
  HybridAzureADJoin: "HybridAzureADJoin",

  @doc("Azure AD Join type.")
  AzureADJoin: "AzureADJoin",

  @doc("No Active Directory join type.")
  None: "None",
}

@doc("The synchronization state of the catalog.")
union CatalogSyncState {
  string,

  @doc("Succeeded synchronization state.")
  Succeeded: "Succeeded",

  @doc("In progress synchronization state.")
  InProgress: "InProgress",

  @doc("Failed synchronization state.")
  Failed: "Failed",

  @doc("Canceled synchronization state.")
  Canceled: "Canceled",
}

@doc("The connection state of the catalog.")
union CatalogConnectionState {
  string,

  @doc("Connected state.")
  Connected: "Connected",

  @doc("Disconnected state.")
  Disconnected: "Disconnected",
}

@doc("Indicates the type of sync that is configured for the catalog.")
union CatalogSyncType {
  string,

  @doc("Manual sync type.")
  Manual: "Manual",

  @doc("Scheduled sync type.")
  Scheduled: "Scheduled",
}

@doc("The type of data a parameter accepts.")
union ParameterType {
  string,

  @doc("The parameter accepts an array of values.")
  array: "array",

  @doc("The parameter accepts a boolean value.")
  boolean: "boolean",

  @doc("The parameter accepts an integer value.")
  integer: "integer",

  @doc("The parameter accepts a number value.")
  number: "number",

  @doc("The parameter accepts an object value.")
  object: "object",

  @doc("The parameter accepts a string value.")
  string: "string",
}

@doc("Catalog resource validation status.")
union CatalogResourceValidationStatus {
  string,

  @doc("Unknown validation status.")
  Unknown: "Unknown",

  @doc("Pending validation status.")
  Pending: "Pending",

  @doc("Succeeded validation status.")
  Succeeded: "Succeeded",

  @doc("Failed validation status.")
  Failed: "Failed",
}

@doc("Indicates whether hibernate is enabled/disabled.")
union HibernateSupport {
  string,

  @doc("Hibernate is disabled.")
  Disabled: "Disabled",

  @doc("Hibernate is enabled.")
  Enabled: "Enabled",
}

@doc("Indicates whether the environment type is either enabled or disabled.")
union EnvironmentTypeEnableStatus {
  string,

  @doc("Environment type is enabled.")
  Enabled: "Enabled",

  @doc("Environment type is disabled.")
  Disabled: "Disabled",
}

@doc("Image validation status.")
union ImageValidationStatus {
  string,

  @doc("Unknown image validation status.")
  Unknown: "Unknown",

  @doc("Pending image validation status.")
  Pending: "Pending",

  @doc("Succeeded image validation status.")
  Succeeded: "Succeeded",

  @doc("Failed image validation status.")
  Failed: "Failed",

  @doc("Timed out image validation status.")
  TimedOut: "TimedOut",
}

@doc("The unit details.")
union UsageUnit {
  string,

  @doc("Count.")
  Count: "Count",
}

@doc("Type of the input.")
union CustomizationTaskInputType {
  string,

  @doc("The parameter accepts a string value.")
  string: "string",

  @doc("The parameter accepts a number value.")
  number: "number",

  @doc("The parameter accepts a boolean value.")
  boolean: "boolean",
}

@doc("The state of an Image Definition Build.")
union ImageDefinitionBuildStatus {
  string,

  @doc("The image build has succeeded.")
  Succeeded: "Succeeded",

  @doc("The image build is running.")
  Running: "Running",

  @doc("The built image has failed validation.")
  ValidationFailed: "ValidationFailed",

  @doc("The image build has failed.")
  Failed: "Failed",

  @doc("The image build has been cancelled.")
  Cancelled: "Cancelled",

  @doc("The image build has timed out.")
  TimedOut: "TimedOut",
}

@doc("Indicates whether auto image build is enabled/disabled.")
union AutoImageBuildStatus {
  string,

  /** Auto image build is disabled. */
  Disabled: "Disabled",

  /** Auto image build is enabled. */
  Enabled: "Enabled",
}

/** Indicates whether auto image build is enabled/disabled for image definitions in the catalog. */
@added(Versions.v2025_10_01_preview)
union CatalogAutoImageBuildEnableStatus {
  string,

  @doc("Auto image build is disabled.")
  Disabled: "Disabled",

  @doc("Auto image build is enabled.")
  Enabled: "Enabled",
}

@doc("Health status indicating whether a pool is available to create Dev Boxes.")
union HealthStatus {
  string,

  @doc("Unknown health status.")
  Unknown: "Unknown",

  @doc("Pending health status.")
  Pending: "Pending",

  @doc("Healthy health status.")
  Healthy: "Healthy",

  @doc("Warning health status.")
  Warning: "Warning",

  @doc("Unhealthy health status.")
  Unhealthy: "Unhealthy",
}

@doc("Indicates if the pool is created from an existing Dev Box Definition or if one is provided directly.")
union PoolDevBoxDefinitionType {
  string,

  @doc("Indicates the pool is created from an existing Dev Box definition.")
  Reference: "Reference",

  @doc("Indicates the pool is created from a Dev Box definition that's created from an image reference and a SKU directly. This is used for creating an image definition pool or an image pool.")
  Value: "Value",
}

@doc("License Types")
union LicenseType {
  string,

  @doc("Windows Client license type.")
  Windows_Client: "Windows_Client",
}

@doc("Local Administrator enable or disable status. Indicates whether owners of Dev Boxes are added as local administrators on the Dev Box.")
union LocalAdminStatus {
  string,

  @doc("Local administrator is disabled.")
  Disabled: "Disabled",

  @doc("Local administrator is enabled.")
  Enabled: "Enabled",
}

@doc("Stop on disconnect enable or disable status. Indicates whether stop on disconnect to is either enabled or disabled.")
union StopOnDisconnectEnableStatus {
  string,

  @doc("Stop on disconnect is enabled.")
  Enabled: "Enabled",

  @doc("Stop on disconnect is disabled.")
  Disabled: "Disabled",
}

@doc("Stop on no connect enable or disable status.")
union StopOnNoConnectEnableStatus {
  string,

  @doc("Stop on no connect is enabled.")
  Enabled: "Enabled",

  @doc("Stop on no connect is disabled.")
  Disabled: "Disabled",
}

@doc("SingleSignOn (SSO) enable or disable status. Indicates whether Dev Boxes in the Pool will have SSO enabled or disabled.")
union SingleSignOnStatus {
  string,

  @doc("Single Sign On is disabled.")
  Disabled: "Disabled",

  @doc("Single Sign On is enabled.")
  Enabled: "Enabled",
}

@doc("Indicates a pool uses a Virtual Network managed by Microsoft (Managed), or a customer provided Network (Unmanaged).")
union VirtualNetworkType {
  string,

  @doc("Virtual Network is managed by Microsoft.")
  Managed: "Managed",

  @doc("Virtual Network is managed by user.")
  Unmanaged: "Unmanaged",
}

@doc("Enables or disables whether Dev Boxes should be kept awake during active hours.")
union KeepAwakeEnableStatus {
  string,

  @doc("Keep awake is enabled.")
  Enabled: "Enabled",

  @doc("Keep awake is disabled.")
  Disabled: "Disabled",
}

@doc("Enables or disables whether Dev Boxes should be automatically started at commencement of active hours.")
union AutoStartEnableStatus {
  string,

  @doc("Auto start is enabled.")
  Enabled: "Enabled",

  @doc("Auto start is disabled.")
  Disabled: "Disabled",
}

@doc("Indicates whether Dev Box Tunnel is enabled.")
union DevBoxTunnelEnableStatus {
  string,

  @doc("Dev Box Tunnel is enabled.")
  Disabled: "Disabled",

  @doc("Dev Box Tunnel is disabled.")
  Enabled: "Enabled",
}

@doc("The supported types for a scheduled task.")
union ScheduledType {
  string,

  @doc("Stop Dev Box task type.")
  StopDevBox: "StopDevBox",
}

@doc("The frequency of task execution.")
union ScheduledFrequency {
  string,

  @doc("The scheduled task will run daily.")
  Daily: "Daily",
}

@doc("Schedule enable or disable status. Indicates whether the schedule applied to is either enabled or disabled.")
union ScheduleEnableStatus {
  string,

  @doc("Schedule is enabled.")
  Enabled: "Enabled",

  @doc("Schedule is disabled.")
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Days of week will never change."
@doc("The days of the week.")
union DayOfWeek {
  @doc("Monday")
  Monday: "Monday",

  @doc("Tuesday")
  Tuesday: "Tuesday",

  @doc("Wednesday")
  Wednesday: "Wednesday",

  @doc("Thursday")
  Thursday: "Thursday",

  @doc("Friday")
  Friday: "Friday",

  @doc("Saturday")
  Saturday: "Saturday",

  @doc("Sunday")
  Sunday: "Sunday",
}

/** The scope of an assignment. */
@added(Versions.v2025_10_01_preview)
union AssignedGroupScope {
  string,

  /** Assignment entitles group members to Dev Boxes in the Project. */
  DevBox: "DevBox",
}

/** Indicates whether cancel on connect is enabled. */
@added(Versions.v2025_10_01_preview)
union CancelOnConnectEnableStatus {
  string,

  /** Cancel on connect is enabled. */
  Enabled: "Enabled",

  /** Cancel on connect is disabled. */
  Disabled: "Disabled",
}

model DevCenterListResult is Azure.Core.Page<DevCenter>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of the devcenter.")
model DevCenterProperties extends DevCenterUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The URI of the Dev Center.")
  @visibility(Lifecycle.Read)
  devCenterUri?: string;
}

@doc("Properties of the devcenter. These properties can be updated after the resource has been created.")
model DevCenterUpdateProperties {
  @doc("Encryption settings to be used for server-side encryption for proprietary content (such as catalogs, logs, customizations).")
  encryption?: Encryption;

  @doc("The display name of the devcenter.")
  displayName?: string;

  @doc("Dev Center settings to be used when associating a project with a catalog.")
  projectCatalogSettings?: DevCenterProjectCatalogSettings;

  @doc("Network settings that will be enforced on network resources associated with the Dev Center.")
  networkSettings?: DevCenterNetworkSettings;

  @doc("Settings to be used in the provisioning of all Dev Boxes that belong to this dev center.")
  devBoxProvisioningSettings?: DevBoxProvisioningSettings;
}

@doc("Encryption properties.")
model Encryption {
  @doc("All Customer-managed key encryption properties for the resource.")
  customerManagedKeyEncryption?: CustomerManagedKeyEncryption;
}

@doc("Project catalog settings for project catalogs under a project associated to this dev center.")
model DevCenterProjectCatalogSettings {
  @doc("Whether project catalogs associated with projects in this dev center can be configured to sync catalog items.")
  catalogItemSyncEnableStatus?: CatalogItemSyncEnableStatus;
}

/** Inherited project catalog settings that combine project policy settings with dev center catalog settings. */
@added(Versions.v2025_10_01_preview)
model InheritedProjectCatalogSettings {
  /** Indicates whether the feature's status, Enabled or Disabled, is configurable at the Project scope. */
  @added(Versions.v2025_10_01_preview)
  statusModifiable?: FeatureState.statusModifiable;

  /** Indicates whether the feature values are configurable at the Project scope. */
  @added(Versions.v2025_10_01_preview)
  valuesModifiable?: FeatureState.valuesModifiable;

  /** Indicates the default status of the feature. */
  @added(Versions.v2025_10_01_preview)
  defaultStatus?: FeatureState.defaultStatus;

  /** The default values of the feature. */
  @added(Versions.v2025_10_01_preview)
  defaultValues?: FeatureState.defaultValues;

  ...DevCenterProjectCatalogSettings;
}

@doc("Network settings for the Dev Center.")
model DevCenterNetworkSettings {
  @doc("Indicates whether pools in this Dev Center can use Microsoft Hosted Networks. Defaults to Enabled if not set.")
  microsoftHostedNetworkEnableStatus?: MicrosoftHostedNetworkEnableStatus;
}

@doc("Provisioning settings that apply to all Dev Boxes created in this dev center.")
model DevBoxProvisioningSettings {
  @doc("Indicates whether to install the Azure Monitor Agent service on Dev Boxes that belong to this dev center")
  installAzureMonitorAgentEnableStatus?: InstallAzureMonitorAgentEnableStatus;
}

@doc("The devcenter resource for partial updates. Properties not provided in the update request will not be changed.")
model DevCenterUpdate is TrackedResourceUpdate {
  @doc("Managed identity properties.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of a Dev Center to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: DevCenterUpdateProperties;
}

@doc("Base tracked resource type for PATCH updates.")
model TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("Resource tags.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  @doc("The geo-location where the resource lives.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of the devcenter encryption set.")
model DevCenterEncryptionSetProperties
  extends DevCenterEncryptionSetUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

model EncryptionSetListResult is Azure.Core.Page<DevCenterEncryptionSet>;

@doc("Properties of the devcenter encryption set. These properties can be updated after the resource has been created.")
model DevCenterEncryptionSetUpdateProperties {
  @doc("Devbox disk encryption enable or disable status. Indicates if Devbox disks encryption using DevCenter CMK is enabled or not.")
  devboxDisksEncryptionEnableStatus?: DevboxDisksEncryptionEnableStatus;

  @doc("Key encryption key Url, versioned or non-versioned. Ex: https://contosovault.vault.azure.net/keys/contosokek/562a4bb76b524a1493a6afe8e536ee78 or https://contosovault.vault.azure.net/keys/contosokek.")
  keyEncryptionKeyUrl?: url;

  @doc("The managed identity configuration used for key vault access.")
  keyEncryptionKeyIdentity?: KeyEncryptionKeyIdentity;
}

@doc("The managed identity configuration used for key vault access.")
model KeyEncryptionKeyIdentity {
  @doc("The type of managed identity to use for key vault access.")
  type?: CmkIdentityType;

  @doc("For system assigned identity, this will be null. For user assigned identity, this should be the resource ID of the identity.")
  userAssignedIdentityResourceId?: string;
}

@doc("The devcenter encryption set resource for partial updates. Properties not provided in the update request will not be changed.")
model EncryptionSetUpdate is TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of a Dev Center encryption set to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: DevCenterEncryptionSetUpdateProperties;

  @doc("Managed identity properties")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of an project policy.")
model ProjectPolicyProperties extends ProjectPolicyUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of an project policy. These properties can be updated after the resource has been created.")
model ProjectPolicyUpdateProperties {
  @doc("Resource policies that are a part of this project policy.")
  @identifiers(#[])
  resourcePolicies?: ResourcePolicy[];

  @doc("Resources that have access to the shared resources that are a part of this project policy.")
  scopes?: string[];

  /** Configuration Policies part of this project policy. */
  @added(Versions.v2025_10_01_preview)
  configurationPolicies?: ConfigurationPolicies;
}

@doc("A resource policy.")
model ResourcePolicy {
  @doc("Resources that are included and shared as a part of a project policy.")
  resources?: string;

  @doc("Optional. When specified, this expression is used to filter the resources.")
  filter?: string;

  @doc("Policy action to be taken on the resources. This is optional, and defaults to allow")
  action?: PolicyAction;

  @doc("Optional. The resource type being restricted or allowed by a project policy. Used with a given action to restrict or allow access to a resource type.")
  resourceType?: DevCenterResourceType;
}

@doc("The project policy properties for partial update. Properties not provided in the update request will not be changed.")
model ProjectPolicyUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of an project policy to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ProjectPolicyUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of a project.")
model ProjectProperties extends ProjectUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The URI of the Dev Center resource this project is associated with.")
  @visibility(Lifecycle.Read)
  devCenterUri?: string;
}

@doc("Properties of a project. These properties can be updated after the resource has been created.")
model ProjectUpdateProperties {
  @doc("Resource Id of an associated DevCenter.")
  devCenterId?: string;

  @doc("Description of the project.")
  description?: string;

  @doc("When specified, limits the maximum number of Dev Boxes a single user can create across all pools in the project. This will have no effect on existing Dev Boxes when reduced.")
  @minValue(0)
  maxDevBoxesPerUser?: int32;

  @doc("The display name of the project.")
  displayName?: string;

  @doc("Settings to be used when associating a project with a catalog.")
  catalogSettings?: ProjectCatalogSettings;

  @doc("Settings to be used for customizations.")
  customizationSettings?: ProjectCustomizationSettings;

  @doc("Dev Box Auto Delete settings.")
  @removed(Versions.v2025_10_01_preview)
  devBoxAutoDeleteSettings?: DevBoxAutoDeleteSettings;

  /** Dev Box Schedule Delete settings. */
  @added(Versions.v2025_10_01_preview)
  devBoxScheduleDeleteSettings?: DevBoxScheduleDeleteSettings;

  @doc("Indicates whether Azure AI services are enabled for a project.")
  azureAiServicesSettings?: AzureAiServicesSettings;

  @doc("Settings to be used for serverless GPU.")
  serverlessGpuSessionsSettings?: ServerlessGpuSessionsSettings;

  @doc("Settings to be used for workspace storage.")
  workspaceStorageSettings?: WorkspaceStorageSettings;

  /** List of Entra ID group assignments associated with this project. */
  @added(Versions.v2025_10_01_preview)
  @identifiers(#[])
  assignedGroups?: AssignedGroup[];
}

@doc("Settings to be used when associating a project with a catalog.")
model ProjectCatalogSettings {
  @doc("Indicates catalog item types that can be synced.")
  catalogItemSyncTypes?: CatalogItemType[];
}

@doc("Settings to be used for customizations.")
model ProjectCustomizationSettings {
  @doc("The identities that can to be used in customization scenarios; e.g., to clone a repository.")
  @identifiers(#[])
  identities?: ProjectCustomizationManagedIdentity[];

  @doc("Indicates whether user customizations are enabled.")
  userCustomizationsEnableStatus?: UserCustomizationsEnableStatus;
}

@doc("A reference to a Managed Identity that is attached to the Project.")
model ProjectCustomizationManagedIdentity {
  @doc("Values can be systemAssignedIdentity or userAssignedIdentity.")
  identityType?: ProjectCustomizationIdentityType;

  @doc("Ex: /subscriptions/fa5fc227-a624-475e-b696-cdd604c735bc/resourceGroups/<resource group>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/myId. Mutually exclusive with identityType systemAssignedIdentity.")
  identityResourceId?: Azure.Core.armResourceIdentifier;
}

@doc("Settings controlling the auto deletion of inactive dev boxes.")
@removed(Versions.v2025_10_01_preview)
model DevBoxAutoDeleteSettings {
  @doc("Indicates the delete mode for Dev Boxes within this project.")
  deleteMode?: DevBoxDeleteMode;

  @doc("ISO8601 duration required for the dev box to not be inactive prior to it being scheduled for deletion.  ISO8601 format PT[n]H[n]M[n]S.")
  inactiveThreshold?: string;

  @doc("ISO8601 duration required for the dev box to be marked for deletion prior to it being deleted. ISO8601 format PT[n]H[n]M[n]S.")
  gracePeriod?: string;
}

/** Settings controlling the auto deletion of inactive dev boxes. */
@added(Versions.v2025_10_01_preview)
model DevBoxScheduleDeleteSettings {
  /** Indicates the delete mode for Dev Boxes within this project. */
  deleteMode?: DevBoxDeleteMode;

  /** ISO8601 duration required for the dev box to not be inactive prior to it being scheduled for deletion.  ISO8601 format PT[n]H[n]M[n]S. */
  inactiveThreshold?: duration;

  /** ISO8601 duration required for the dev box to be marked for deletion prior to it being deleted. ISO8601 format PT[n]H[n]M[n]S. */
  gracePeriod?: duration;

  /** Indicates whether scheduled deletion should be canceled when a user connects to the dev box. */
  cancelOnConnectEnableStatus?: CancelOnConnectEnableStatus;
}

@doc("Configures Azure AI related services for the project.")
model AzureAiServicesSettings {
  @doc("The property indicates whether Azure AI services is enabled.")
  azureAiServicesMode?: AzureAiServicesMode;
}

@doc("Represents settings for serverless GPU access.")
model ServerlessGpuSessionsSettings {
  @doc("The property indicates whether serverless GPU access is enabled on the project.")
  serverlessGpuSessionsMode?: ServerlessGpuSessionsMode;

  @doc("When specified, limits the maximum number of concurrent sessions across all pools in the project.")
  @minValue(1)
  maxConcurrentSessionsPerProject?: int32;
}

@doc("Settings to be used for workspace storage.")
model WorkspaceStorageSettings {
  @doc("Indicates whether workspace storage is enabled.")
  workspaceStorageMode?: WorkspaceStorageMode;
}

/** Represents an Entra group assigned to this Project, entitling all members to resources for the given scope. */
@added(Versions.v2025_10_01_preview)
model AssignedGroup {
  /** The Entra group object ID (GUID). */
  objectId?: Azure.Core.uuid;

  /** The scope of the assignment. */
  scope?: AssignedGroupScope;
}

@doc("The project properties for partial update. Properties not provided in the update request will not be changed.")
model ProjectUpdate is TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of a project to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ProjectUpdateProperties;

  @doc("Managed identity properties.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@doc("Applicable inherited settings for a project.")
model InheritedSettingsForProject {
  @doc("Dev Center settings to be used when associating a project with a catalog.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(
    Versions.v2025_10_01_preview,
    DevCenterProjectCatalogSettings
  )
  projectCatalogSettings?: InheritedProjectCatalogSettings;

  @doc("Network settings that will be enforced on this project.")
  @visibility(Lifecycle.Read)
  networkSettings?: ProjectNetworkSettings;

  /** Azure AI project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  azureAiServicesSettings?: FeatureState;

  /** Dev box schedule delete project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  devBoxScheduleDeleteSettings?: FeatureState;

  /** Dev box limits project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  devBoxLimitsSettings?: FeatureState;

  /** Display name project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  displayNameSettings?: FeatureState;

  /** Dev box tunnel project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  devBoxTunnelSettings?: FeatureState;

  /** Serverless GPU sessions project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  serverlessGpuSessionsSettings?: FeatureState;

  /** User customizations project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  userCustomizationsSettings?: FeatureState;

  /** Workspace storage project policy settings that will be enforced on this project. */
  @added(Versions.v2025_10_01_preview)
  @visibility(Lifecycle.Read)
  workspaceStorageSettings?: FeatureState;
}

/** Represents policies to enforce configuration settings on a project. */
@added(Versions.v2025_10_01_preview)
model ConfigurationPolicies {
  /** The property indicates the Azure AI services settings on a project. */
  azureAiServicesFeatureStatus?: FeatureState;

  /** Indicates whether the setting is configurable at Project scope. */
  devBoxScheduleDeleteFeatureStatus?: FeatureState;

  /** Indicates whether DevBox limits are configurable at Project scope. */
  devBoxLimitsFeatureStatus?: FeatureState;

  /** Indicates whether project display name is configurable at Project scope. */
  displayNameFeatureStatus?: FeatureState;

  /** Indicates whether DevBox tunnel settings are configurable at Pool scope. */
  devBoxTunnelFeatureStatus?: FeatureState;

  /** Indicates whether project catalogs are configurable at Project scope. */
  projectCatalogFeatureStatus?: FeatureState;

  /** Indicates whether serverless GPU sessions are configurable at Project scope. */
  serverlessGpuSessionsFeatureStatus?: FeatureState;

  /** Indicates whether user customizations is configurable at Project scope. */
  userCustomizationsFeatureStatus?: FeatureState;

  /** Indicates whether workspace storage is configurable at Project scope. */
  workspaceStorageFeatureStatus?: FeatureState;
}

/** Feature state. */
@added(Versions.v2025_10_01_preview)
model FeatureState {
  /** Indicates whether the feature's status, Enabled or Disabled, is configurable at the Project scope. */
  statusModifiable?: FeatureStateModifiable;

  /** Indicates whether the feature values are configurable at the Project scope. */
  valuesModifiable?: FeatureStateModifiable;

  /** Indicates the default status of the feature. */
  defaultStatus?: FeatureStatus;

  /** The default values of the feature. */
  defaultValues?: DefaultValue[];
}

/** A default value that can be provided for a feature property. */
@added(Versions.v2025_10_01_preview)
model DefaultValue {
  /** The name of the feature property. */
  name?: string;

  /** The default value to be applied for the given property. */
  value?: string;
}

/** Feature status. */
@added(Versions.v2025_10_01_preview)
union FeatureStatus {
  string,

  @doc("Feature is enabled.")
  Enabled: "Enabled",

  @doc("Feature is disabled.")
  Disabled: "Disabled",

  @doc("Auto Deploy feature status.")
  AutoDeploy: "AutoDeploy",
}

/** Feature enablement status. */
@added(Versions.v2025_10_01_preview)
union FeatureStateModifiable {
  string,

  /** Feature is not modifiable. */
  NotModifiable: "NotModifiable",

  /** Feature is modifiable. */
  Modifiable: "Modifiable",
}

@doc("Network settings for the project.")
model ProjectNetworkSettings {
  @doc("Indicates whether pools in this Dev Center can use Microsoft Hosted Networks. Defaults to Enabled if not set.")
  @visibility(Lifecycle.Read)
  microsoftHostedNetworkEnableStatus?: MicrosoftHostedNetworkEnableStatus;
}

@doc("Properties of an attached NetworkConnection.")
model AttachedNetworkConnectionProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The resource ID of the NetworkConnection you want to attach.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkConnectionId?: string;

  @doc("The geo-location where the NetworkConnection resource specified in 'networkConnectionResourceId' property lives.")
  @visibility(Lifecycle.Read)
  networkConnectionLocation?: string;

  @doc("Health check status values.")
  @visibility(Lifecycle.Read)
  healthCheckStatus?: HealthCheckStatus;

  @doc("AAD Join type of the network. This is populated based on the referenced Network Connection.")
  @visibility(Lifecycle.Read)
  domainJoinType?: DomainJoinType;
}

model AttachedNetworkListResult is Azure.Core.Page<AttachedNetworkConnection>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of a catalog.")
model CatalogProperties extends CatalogUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The synchronization state of the catalog.")
  @visibility(Lifecycle.Read)
  syncState?: CatalogSyncState;

  @doc("Stats of the latest synchronization.")
  @visibility(Lifecycle.Read)
  lastSyncStats?: SyncStats;

  @doc("The connection state of the catalog.")
  @visibility(Lifecycle.Read)
  connectionState?: CatalogConnectionState;

  @doc("When the catalog was last connected.")
  @visibility(Lifecycle.Read)
  lastConnectionTime?: utcDateTime;

  @doc("When the catalog was last synced.")
  @visibility(Lifecycle.Read)
  lastSyncTime?: utcDateTime;
}

@doc("Stats of the synchronization.")
model SyncStats {
  @doc("Count of catalog items added during synchronization.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  added?: int32;

  @doc("Count of catalog items updated during synchronization.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  updated?: int32;

  @doc("Count of catalog items that were unchanged during synchronization.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  unchanged?: int32;

  @doc("Count of catalog items removed during synchronization.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  removed?: int32;

  @doc("Count of catalog items that had validation errors during synchronization.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  validationErrors?: int32;

  @doc("Count of synchronization errors that occured during synchronization.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  synchronizationErrors?: int32;

  @doc("Indicates catalog item types that were synced.")
  syncedCatalogItemTypes?: CatalogItemType[];
}

@doc("Properties of a catalog. These properties can be updated after the resource has been created.")
model CatalogUpdateProperties {
  @doc("Properties for a GitHub catalog type.")
  gitHub?: GitCatalog;

  @doc("Properties for an Azure DevOps catalog type.")
  adoGit?: GitCatalog;

  @doc("Indicates the type of sync that is configured for the catalog.")
  syncType?: CatalogSyncType;

  /** Indicates whether the catalog is configured to automatically build image definitions. Defaults to enabled. */
  @added(Versions.v2025_10_01_preview)
  autoImageBuildEnableStatus?: CatalogAutoImageBuildEnableStatus;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("Resource tags.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@doc("Properties for a Git repository catalog.")
model GitCatalog {
  @doc("Git URI.")
  uri?: string;

  @doc("Git branch.")
  branch?: string;

  @doc("A reference to the Key Vault secret containing a security token to authenticate to a Git repository.")
  secretIdentifier?: string;

  @doc("The folder where the catalog items can be found inside the repository.")
  path?: string;
}

@doc("The catalog's properties for partial update. Properties not provided in the update request will not be changed.")
model CatalogUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Catalog properties for update.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: CatalogUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read only proxy resource without a PUT."
@doc("Properties of an environment definition.")
model EnvironmentDefinitionProperties {
  @doc("A short description of the environment definition.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Input parameters passed to an environment.")
  @visibility(Lifecycle.Read)
  parameters?: EnvironmentDefinitionParameter[];

  @doc("Path to the Environment Definition entrypoint file.")
  @visibility(Lifecycle.Read)
  templatePath?: string;

  @doc("Validation status for the environment definition.")
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;
}

@doc("Properties of an Environment Definition parameter.")
model EnvironmentDefinitionParameter {
  @doc("Unique ID of the parameter.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("Display name of the parameter.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Description of the parameter.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("A string of one of the basic JSON types (number, integer, array, object, boolean, string).")
  @visibility(Lifecycle.Read)
  type?: ParameterType;

  @doc("Whether or not this parameter is read-only.  If true, default should have a value.")
  @visibility(Lifecycle.Read)
  readOnly?: boolean;

  @doc("Whether or not this parameter is required.")
  @visibility(Lifecycle.Read)
  required?: boolean;
}

@doc("List of validator error details. Populated when changes are made to the resource or its dependent resources that impact the validity of the Catalog resource.")
model CatalogResourceValidationErrorDetails {
  @doc("Errors associated with resources synchronized from the catalog.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: CatalogErrorDetails[];
}

@doc("Catalog error details")
model CatalogErrorDetails {
  @doc("An identifier for the error.")
  code?: string;

  @doc("A message describing the error.")
  message?: string;
}

@doc("Synchronization error details.")
model SyncErrorDetails {
  @doc("Error information for the overall synchronization operation.")
  @visibility(Lifecycle.Read)
  operationError?: CatalogErrorDetails;

  @doc("Catalog items that have conflicting names.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  conflicts?: CatalogConflictError[];

  @doc("Errors that occured during synchronization.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errors?: CatalogSyncError[];
}

@doc("An individual conflict error.")
model CatalogConflictError {
  @doc("The path of the file that has a conflicting name.")
  @visibility(Lifecycle.Read)
  path?: string;

  @doc("Name of the conflicting catalog item.")
  @visibility(Lifecycle.Read)
  name?: string;
}

@doc("An individual synchronization error.")
model CatalogSyncError {
  @doc("The path of the file the error is associated with.")
  @visibility(Lifecycle.Read)
  path?: string;

  @doc("Errors associated with the file.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  errorDetails?: CatalogErrorDetails[];
}

@doc("Properties of a gallery.")
model GalleryProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The resource ID of the backing Azure Compute Gallery.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  galleryResourceId: string;
}

@doc("Properties of an image.")
model ImageProperties {
  @doc("The description of the image.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("The publisher of the image.")
  @visibility(Lifecycle.Read)
  publisher?: string;

  @doc("The name of the image offer.")
  @visibility(Lifecycle.Read)
  offer?: string;

  @doc("The SKU name for the image.")
  @visibility(Lifecycle.Read)
  sku?: string;

  @doc("The recommended machine configuration to use with the image.")
  @visibility(Lifecycle.Read)
  recommendedMachineConfiguration?: RecommendedMachineConfiguration;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Indicates whether this image has hibernate enabled. Not all images are capable of supporting hibernation. To find out more see https://aka.ms/devbox/hibernate")
  @visibility(Lifecycle.Read)
  hibernateSupport?: HibernateSupport;

  /** The architecture type of the image. */
  @added(Versions.v2026_01_01_preview)
  @visibility(Lifecycle.Read)
  architecture?: ArchitectureType;
}

/** Architecture Types. */
union ArchitectureType {
  string,

  /** x64 architecture */
  x64: "x64",

  /** ARM64 architecture */
  Arm64: "Arm64",
}

@doc("Properties for a recommended machine configuration.")
model RecommendedMachineConfiguration {
  @doc("Recommended memory range.")
  @visibility(Lifecycle.Read)
  memory?: ResourceRange;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Legacy, cannot change existing name."
  @doc("Recommended vCPU range.")
  @visibility(Lifecycle.Read)
  vCPUs?: ResourceRange;
}

@doc("Properties for a range of values.")
model ResourceRange {
  @doc("Minimum value.")
  @visibility(Lifecycle.Read)
  min?: int32;

  @doc("Maximum value.")
  @visibility(Lifecycle.Read)
  max?: int32;
}

@doc("Properties of an image version.")
model ImageVersionProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Safe to suppress for an existing API during TypeSpec conversion."
  @doc("The semantic version string.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The datetime that the backing image version was published.")
  @visibility(Lifecycle.Read)
  publishedDate?: utcDateTime;

  @doc("If the version should be excluded from being treated as the latest version.")
  @visibility(Lifecycle.Read)
  excludeFromLatest?: boolean;

  @doc("The size of the OS disk image, in GB.")
  @visibility(Lifecycle.Read)
  osDiskImageSizeInGb?: int32;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Results of the Microsoft.DevCenter SKU list operation.")
model SkuListResult is Azure.Core.Page<DevCenterSku>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("The resource model definition representing SKU for DevCenter resources.")
model DevCenterSku extends Azure.ResourceManager.CommonTypes.Sku {
  @doc("The name of the resource type.")
  @visibility(Lifecycle.Read)
  resourceType?: string;

  @doc("SKU supported locations.")
  @visibility(Lifecycle.Read)
  locations?: string[];

  @doc("Collection of name/value pairs to describe the SKU capabilities.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  capabilities?: Capability[];
}

@doc("A name/value pair to describe a capability.")
model Capability {
  @doc("Name of the capability.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Value of the capability.")
  @visibility(Lifecycle.Read)
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of an environment type.")
model EnvironmentTypeProperties extends EnvironmentTypeUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of an environment type. These properties can be updated after the resource has been created.")
model EnvironmentTypeUpdateProperties {
  @doc("The display name of the environment type.")
  displayName?: string;
}

@doc("The environment type for partial update. Properties not provided in the update request will not be changed.")
model EnvironmentTypeUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of an environment type to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: EnvironmentTypeUpdateProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("Resource tags.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@doc("Properties of an allowed environment type.")
model AllowedEnvironmentTypeProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The display name of the allowed environment type.")
  @visibility(Lifecycle.Read)
  displayName?: string;
}

model AllowedEnvironmentTypeListResult
  is Azure.Core.Page<AllowedEnvironmentType>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of a project environment type.")
model ProjectEnvironmentTypeProperties
  extends ProjectEnvironmentTypeUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The number of environments of this type.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  environmentCount?: int32;
}

@doc("Properties of a project environment type. These properties can be updated after the resource has been created.")
model ProjectEnvironmentTypeUpdateProperties {
  @doc("Id of a subscription that the environment type will be mapped to. The environment's resources will be deployed into this subscription.")
  deploymentTargetId?: string;

  @doc("The display name of the project environment type.")
  displayName?: string;

  @doc("Defines whether this Environment Type can be used in this Project.")
  status?: EnvironmentTypeEnableStatus;

  @doc("The role definition assigned to the environment creator on backing resources.")
  creatorRoleAssignment?: ProjectEnvironmentTypeUpdatePropertiesCreatorRoleAssignment;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("Role Assignments created on environment backing resources. This is a mapping from a user object ID to an object of role definition IDs.")
  userRoleAssignments?: Record<UserRoleAssignment>;
}

@doc("The role definition assigned to the environment creator on backing resources.")
model ProjectEnvironmentTypeUpdatePropertiesCreatorRoleAssignment {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("A map of roles to assign to the environment creator.")
  roles?: Record<EnvironmentRole>;
}

@doc("A role that can be assigned to a user.")
model EnvironmentRole {
  @doc("The common name of the Role Assignment. This is a descriptive name such as 'AcrPush'.")
  @visibility(Lifecycle.Read)
  roleName?: string;

  @doc("This is a description of the Role Assignment.")
  @visibility(Lifecycle.Read)
  description?: string;
}

@doc("Mapping of user object ID to role assignments.")
model UserRoleAssignment {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("A map of roles to assign to the parent user.")
  roles?: Record<EnvironmentRole>;
}

@doc("The project environment type for partial update. Properties not provided in the update request will not be changed.")
model ProjectEnvironmentTypeUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties to configure an environment type.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ProjectEnvironmentTypeUpdateProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("Resource tags.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  @doc("Managed identity properties.")
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

model DevBoxDefinitionListResult is Azure.Core.Page<DevBoxDefinition>;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of a Dev Box definition.")
model DevBoxDefinitionProperties extends DevBoxDefinitionUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Validation status of the configured image.")
  @visibility(Lifecycle.Read)
  imageValidationStatus?: ImageValidationStatus;

  @doc("Details for image validator error. Populated when the image validation is not successful.")
  @visibility(Lifecycle.Read)
  imageValidationErrorDetails?: ImageValidationErrorDetails;

  @doc("Validation status for the Dev Box Definition.")
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;

  @doc("Image reference information for the currently active image (only populated during updates).")
  @visibility(Lifecycle.Read)
  activeImageReference?: ImageReference;
}

@doc("Image validation error details.")
model ImageValidationErrorDetails {
  @doc("An identifier for the error.")
  code?: string;

  @doc("A message describing the error.")
  message?: string;
}

@doc("Image reference information.")
model ImageReference {
  @doc("Image ID, or Image version ID. When Image ID is provided, its latest version will be used.")
  id?: string;

  @doc("The actual version of the image after use. When id references a gallery image latest version, this will indicate the actual version in use.")
  @visibility(Lifecycle.Read)
  exactVersion?: string;
}

@doc("Properties of a Dev Box definition. These properties can be updated after the resource has been created.")
model DevBoxDefinitionUpdateProperties {
  @doc("Image reference information.")
  imageReference?: ImageReference;

  @doc("The SKU for Dev Boxes created using this definition.")
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  @doc("The storage type used for the Operating System disk of Dev Boxes created using this definition.")
  osStorageType?: string;

  @doc("Indicates whether Dev Boxes created with this definition are capable of hibernation. Not all images are capable of supporting hibernation. To find out more see https://aka.ms/devbox/hibernate")
  hibernateSupport?: HibernateSupport;
}

@doc("Partial update of a Dev Box definition resource.")
model DevBoxDefinitionUpdate is TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of a Dev Box definition to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: DevBoxDefinitionUpdateProperties;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("The localized friendly form of the resource provider name, e.g. 'Microsoft Monitoring Insights' or 'Microsoft Compute'.")
  @visibility(Lifecycle.Read)
  provider?: string;

  @doc("The localized friendly name of the resource type related to this operation. E.g. 'Virtual Machines' or 'Job Schedule Collections'.")
  @visibility(Lifecycle.Read)
  resource?: string;

  @doc("The concise, localized friendly name for the operation; suitable for dropdowns. E.g. 'Create or Update Virtual Machine', 'Restart Virtual Machine'.")
  @visibility(Lifecycle.Read)
  operation?: string;

  @doc("The short, localized friendly description of the operation; suitable for tool tips and detailed views.")
  @visibility(Lifecycle.Read)
  description?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("The current status of an async operation")
model OperationStatus
  extends Azure.ResourceManager.CommonTypes.OperationStatusResult {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Legacy API. Closest type we can get to describe object."
  @doc("Custom operation properties, populated only for a successful operation.")
  @visibility(Lifecycle.Read)
  properties?: Record<unknown>;
}

@doc("List of Core Usages.")
model ListUsagesResult is Azure.Core.Page<Usage>;

@doc("The core usage details.")
model Usage {
  @doc("The current usage.")
  currentValue?: int64;

  @doc("The limit integer.")
  limit?: int64;

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

  @doc("The name of the resource.")
  value?: string;
}

@doc("The scoped name check availability request body.")
model CheckScopedNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;

  @doc("The resource id to scope the name check.")
  scope?: string;
}

model CustomizationTaskListResult is Azure.Core.Page<CustomizationTask>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read only proxy resource without a PUT."
@doc("Properties of a Task.")
model CustomizationTaskProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Correct representation for resource tags."
  @doc("Inputs to the task.")
  @visibility(Lifecycle.Read)
  inputs?: Record<CustomizationTaskInput>;

  @doc("The default timeout for the task.")
  @visibility(Lifecycle.Read)
  timeout?: int32;

  @doc("Validation status for the Task.")
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;
}

@doc("Input for a Task.")
model CustomizationTaskInput {
  @doc("Description of the input.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Type of the input.")
  @visibility(Lifecycle.Read)
  type?: CustomizationTaskInputType;

  @doc("Whether or not the input is required.")
  @visibility(Lifecycle.Read)
  required?: boolean;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read only proxy resource without a PUT."
@doc("Properties of an Image Definition.")
model ImageDefinitionProperties {
  @doc("Image reference information.")
  imageReference?: ImageReference;

  @doc("The URL to the repository file containing the image definition.")
  @visibility(Lifecycle.Read)
  fileUrl?: string;

  @doc("Details about the latest build.")
  latestBuild?: LatestImageBuild;

  @doc("Validation status of the configured image.")
  @visibility(Lifecycle.Read)
  imageValidationStatus?: ImageValidationStatus;

  @doc("Details for image validator error. Populated when the image validation is not successful.")
  @visibility(Lifecycle.Read)
  imageValidationErrorDetails?: ImageValidationErrorDetails;

  @doc("Validation status for the Image Definition.")
  @visibility(Lifecycle.Read)
  validationStatus?: CatalogResourceValidationStatus;

  @doc("Image reference information for the currently active image (only populated during updates).")
  @visibility(Lifecycle.Read)
  activeImageReference?: ImageReference;

  @doc("Indicates if automatic image builds will be triggered for image definition updates")
  @visibility(Lifecycle.Read)
  autoImageBuild?: AutoImageBuildStatus;

  @doc("Tasks to run at Dev Box provisioning time.")
  tasks?: CustomizationTaskInstance[];

  @doc("Tasks to run when a user first logs into a Dev Box.")
  userTasks?: CustomizationTaskInstance[];

  @doc("Another Image Definition that this one extends.")
  `extends`?: ImageDefinitionReference;
}

@doc("Details about the latest build.")
model LatestImageBuild {
  @doc("Identifier of a build.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Start time of the task group.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of the task group.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The state of an Image Definition Build.")
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;
}

@doc("A customization task to run.")
model CustomizationTaskInstance {
  @doc("Name of the task.")
  name: string;

  @doc("Parameters for the task.")
  parameters?: DefinitionParametersItem[];

  @doc("Display name to help differentiate multiple instances of the same task.")
  displayName?: string;

  @doc("Timeout, in seconds. Overrides any timeout provided on the task definition.")
  timeoutInSeconds?: int32;

  @doc("An expression that must evaluate to true in order for the task to run.")
  condition?: string;
}

@doc("Parameters for the task.")
model DefinitionParametersItem {
  @doc("Name of the parameter.")
  name: string;

  @doc("value of the parameter.")
  value: string;
}

@doc("A reference to an Image Definition.")
model ImageDefinitionReference {
  @doc("Name of the referenced Image Definition.")
  imageDefinition: string;

  @doc("Parameters for the referenced Image Definition.")
  parameters?: DefinitionParametersItem[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read only proxy resource without a PUT."
@doc("Properties of an Image Definition Build.")
model ImageDefinitionBuildProperties {
  @doc("The specific image version used by the build.")
  @visibility(Lifecycle.Read)
  imageReference?: ImageReference;

  @doc("The status of the build.")
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  @doc("Start time of the task group.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of the task group.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("Details for image creation error. Populated when the image creation is not successful.")
  @visibility(Lifecycle.Read)
  errorDetails?: ImageCreationErrorDetails;
}

@doc("Image creation error details.")
model ImageCreationErrorDetails {
  @doc("An identifier for the error.")
  code?: string;

  @doc("A message describing the error.")
  message?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Represents a specific build of an Image Definition.")
model ImageDefinitionBuildDetails
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
  @doc("The specific image version used by the build.")
  @visibility(Lifecycle.Read)
  imageReference?: ImageReference;

  @doc("The status of the build.")
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  @doc("Start time of the task group.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of the task group.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("Details for image creation error. Populated when the image creation is not successful.")
  @visibility(Lifecycle.Read)
  errorDetails?: ImageCreationErrorDetails;

  @doc("The list of task groups executed during the image definition build.")
  @visibility(Lifecycle.Read)
  taskGroups?: ImageDefinitionBuildTaskGroup[];
}

@doc("A task group executed during the image definition build.")
model ImageDefinitionBuildTaskGroup {
  @doc("The name of the task group.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("The status of the task group.")
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  @doc("Start time of the task group.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of the task group.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The list of tasks executed during the task group.")
  @visibility(Lifecycle.Read)
  tasks?: ImageDefinitionBuildTask[];
}

@doc("A task executed during the image definition build.")
model ImageDefinitionBuildTask {
  @doc("The name of the task.")
  name?: string;

  @doc("Parameters for the task.")
  @identifiers(#[])
  parameters?: ImageDefinitionBuildTaskParametersItem[];

  @doc("Display name to help differentiate multiple instances of the same task.")
  displayName?: string;

  @doc("ID of the task instance.")
  @visibility(Lifecycle.Read)
  id?: string;

  @doc("Start time of the task.")
  @visibility(Lifecycle.Read)
  startTime?: utcDateTime;

  @doc("End time of the task.")
  @visibility(Lifecycle.Read)
  endTime?: utcDateTime;

  @doc("The status of the task.")
  @visibility(Lifecycle.Read)
  status?: ImageDefinitionBuildStatus;

  @doc("The URI for retrieving logs for the task execution.")
  @visibility(Lifecycle.Read)
  logUri?: string;
}

@doc("Parameters for an image definition build task.")
model ImageDefinitionBuildTaskParametersItem {
  @doc("Key of the parameter.")
  key: string;

  @doc("Value of the parameter.")
  value: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Properties of a Pool.")
model PoolProperties extends PoolUpdateProperties {
  @doc("Overall health status of the Pool. Indicates whether or not the Pool is available to create Dev Boxes.")
  @visibility(Lifecycle.Read)
  healthStatus?: HealthStatus;

  @doc("Details on the Pool health status to help diagnose issues. This is only populated when the pool status indicates the pool is in a non-healthy state")
  @visibility(Lifecycle.Read)
  @identifiers(#["code"])
  healthStatusDetails?: HealthStatusDetail[];

  @doc("Indicates the number of provisioned Dev Boxes in this pool.")
  @visibility(Lifecycle.Read)
  devBoxCount?: int32;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Pool health status detail.")
model HealthStatusDetail {
  @doc("An identifier for the issue.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("A message describing the issue, intended to be suitable for display in a user interface")
  @visibility(Lifecycle.Read)
  message?: string;
}

@doc("Properties of a Pool. These properties can be updated after the resource has been created.")
model PoolUpdateProperties {
  @doc("Indicates if the pool is created from an existing Dev Box Definition or if one is provided directly.")
  devBoxDefinitionType?: PoolDevBoxDefinitionType;

  @doc("Name of a Dev Box definition in parent Project of this Pool. Will be ignored if devBoxDefinitionType is Value.")
  devBoxDefinitionName?: string;

  @doc("A definition of the machines that are created from this Pool. Will be ignored if devBoxDefinitionType is Reference or not provided.")
  devBoxDefinition?: PoolDevBoxDefinition;

  @doc("Name of a Network Connection in parent Project of this Pool.")
  networkConnectionName?: string;

  @doc("Specifies the license type indicating the caller has already acquired licenses for the Dev Boxes that will be created.")
  licenseType?: LicenseType;

  @doc("Indicates whether owners of Dev Boxes in this pool are added as local administrators on the Dev Box.")
  localAdministrator?: LocalAdminStatus;

  @doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
  stopOnDisconnect?: StopOnDisconnectConfiguration;

  @doc("Stop on no connect configuration settings for Dev Boxes created in this pool.")
  stopOnNoConnect?: StopOnNoConnectConfiguration;

  @doc("Indicates whether Dev Boxes in this pool are created with single sign on enabled. The also requires that single sign on be enabled on the tenant.")
  singleSignOnStatus?: SingleSignOnStatus;

  @doc("The display name of the pool.")
  displayName?: string;

  @doc("Indicates whether the pool uses a Virtual Network managed by Microsoft or a customer provided network.")
  virtualNetworkType?: VirtualNetworkType;

  @doc("The regions of the managed virtual network (required when managedNetworkType is Managed).")
  managedVirtualNetworkRegions?: string[];

  @doc("Active hours configuration settings for Dev Boxes created in this pool.")
  activeHoursConfiguration?: ActiveHoursConfiguration;

  @doc("Indicates whether Dev Box Tunnel is enabled for a the pool.")
  devBoxTunnelEnableStatus?: DevBoxTunnelEnableStatus;
}

@doc("Represents a definition for a Developer Machine.")
model PoolDevBoxDefinition {
  @doc("Image reference information.")
  imageReference?: ImageReference;

  @doc("The SKU for Dev Boxes created from the Pool.")
  sku?: Azure.ResourceManager.CommonTypes.Sku;

  @doc("Image reference information for the currently active image (only populated during updates).")
  @visibility(Lifecycle.Read)
  activeImageReference?: ImageReference;
}

@doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
model StopOnDisconnectConfiguration {
  @doc("Whether the feature to stop the Dev Box on disconnect once the grace period has lapsed is enabled.")
  status?: StopOnDisconnectEnableStatus;

  @doc("The specified time in minutes to wait before stopping a Dev Box once disconnect is detected.")
  gracePeriodMinutes?: int32;
}

@doc("Stop on no connect configuration settings for Dev Boxes created in this pool.")
model StopOnNoConnectConfiguration {
  @doc("Enables the feature to stop a started Dev Box when it has not been connected to, once the grace period has lapsed.")
  status?: StopOnNoConnectEnableStatus;

  @doc("The specified time in minutes to wait before stopping a Dev Box if no connection is made.")
  gracePeriodMinutes?: int32;
}

@doc("Active hours configuration.")
model ActiveHoursConfiguration {
  @doc("Enables or disables whether the Dev Box should be kept awake during active hours.")
  keepAwakeEnableStatus?: KeepAwakeEnableStatus;

  @doc("Enables or disables whether the Dev Box should be automatically started at commencement of active hours.")
  autoStartEnableStatus?: AutoStartEnableStatus;

  @doc("The default IANA timezone id of the active hours.")
  defaultTimeZone?: string;

  @doc("The default start time of the active hours.")
  defaultStartTimeHour?: int32;

  @doc("The default end time of the active hours.")
  defaultEndTimeHour?: int32;

  @doc("The days of the week that active hours features will be enabled. This serves as a default that can be updated by each individual user.")
  defaultDaysOfWeek?: DayOfWeek[];

  @doc("The maximum amount of days per week that a user can enable active hours related features.")
  daysOfWeekLimit?: int32;
}

@doc("The pool properties for partial update. Properties not provided in the update request will not be changed.")
model PoolUpdate is TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of a pool to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: PoolUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("The Schedule properties defining when and what to execute.")
model ScheduleProperties extends ScheduleUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Updatable properties of a Schedule.")
model ScheduleUpdateProperties is TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Safe to suppress for an existing API during TypeSpec conversion."
  @doc("Supported type this scheduled task represents.")
  type?: ScheduledType;

  @doc("The frequency of this scheduled task.")
  frequency?: ScheduledFrequency;

  @doc("The target time to trigger the action. The format is HH:MM.")
  time?: string;

  @doc("The IANA timezone id at which the schedule should execute.")
  timeZone?: string;

  @doc("Indicates whether or not this scheduled task is enabled.")
  state?: ScheduleEnableStatus;
}

@doc("The schedule properties for partial update. Properties not provided in the update request will not be changed.")
model ScheduleUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of a schedule resource to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: ScheduleUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Legacy. Maintain compatibility with existing models."
@doc("Network properties")
model NetworkProperties extends NetworkConnectionUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Overall health status of the network connection. Health checks are run on creation, update, and periodically to validate the network connection.")
  @visibility(Lifecycle.Read)
  healthCheckStatus?: HealthCheckStatus;

  @doc("The name for resource group where NICs will be placed.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  networkingResourceGroupName?: string;

  @doc("AAD Join type.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  domainJoinType: DomainJoinType;
}

@doc("Properties of network connection. These properties can be updated after the resource has been created.")
model NetworkConnectionUpdateProperties {
  @doc("The subnet to attach Virtual Machines to.")
  subnetId?: string;

  @doc("Active Directory domain name.")
  domainName?: string;

  @doc("Active Directory domain Organization Unit (OU).")
  organizationUnit?: string;

  @doc("The username of an Active Directory account (user or service account) that has permissions to create computer objects in Active Directory. Required format: admin@contoso.com.")
  domainUsername?: string;

  @doc("The password for the account used to join domain.")
  @secret
  domainPassword?: string;
}

@doc("The network connection properties for partial update. Properties not provided in the update request will not be changed.")
model NetworkConnectionUpdate is TrackedResourceUpdate {
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy"
  @doc("Properties of a network connection resource to be updated.")
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties?: NetworkConnectionUpdateProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read only proxy resource without a PUT."
@doc("Health Check properties.")
model HealthCheckStatusDetailsProperties {
  @doc("Start time of last execution of the health checks.")
  @visibility(Lifecycle.Read)
  startDateTime?: utcDateTime;

  @doc("End time of last execution of the health checks.")
  @visibility(Lifecycle.Read)
  endDateTime?: utcDateTime;

  @doc("Details for each health check item.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  healthChecks?: HealthCheck[];
}

@doc("An individual health check item.")
model HealthCheck {
  @doc("The status of the health check item.")
  @visibility(Lifecycle.Read)
  status?: HealthCheckStatus;

  @doc("The display name of this health check item.")
  @visibility(Lifecycle.Read)
  displayName?: string;

  @doc("Start time of health check item.")
  @visibility(Lifecycle.Read)
  startDateTime?: utcDateTime;

  @doc("End time of the health check item.")
  @visibility(Lifecycle.Read)
  endDateTime?: utcDateTime;

  @doc("The type of error that occurred during this health check.")
  @visibility(Lifecycle.Read)
  errorType?: string;

  @doc("The recommended action to fix the corresponding error.")
  @visibility(Lifecycle.Read)
  recommendedAction?: string;

  @doc("Additional details about the health check or the recommended action.")
  @visibility(Lifecycle.Read)
  additionalDetails?: string;
}

@doc("Values returned by the List operation.")
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("A collection of related endpoints from the same service for which the agent requires outbound access.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service that the agent connects to.")
  @visibility(Lifecycle.Read)
  category?: string;

  @doc("The endpoints for this service for which the agent requires outbound access.")
  @visibility(Lifecycle.Read)
  @identifiers(#["domainName"])
  endpoints?: EndpointDependency[];
}

@doc("A domain name and connection details used to access a dependency.")
model EndpointDependency {
  @doc("The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.")
  @visibility(Lifecycle.Read)
  domainName?: string;

  @doc("Human-readable supplemental information about the dependency and when it is applicable.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("The list of connection details for this endpoint.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  endpointDetails?: EndpointDetail[];
}

@doc("Details about the connection between the Batch service and the endpoint.")
model EndpointDetail {
  @doc("The port an endpoint is connected to.")
  @visibility(Lifecycle.Read)
  port?: int32;
}

model EnvironmentDefinitionListResult is Azure.Core.Page<EnvironmentDefinition>;

model EnvironmentTypeListResult is Azure.Core.Page<EnvironmentType>;

model GalleryListResult is Azure.Core.Page<Gallery>;

model HealthCheckStatusDetailsListResult
  is Azure.Core.Page<HealthCheckStatusDetails>;

model ImageDefinitionBuildListResult is Azure.Core.Page<ImageDefinitionBuild>;

model ImageDefinitionListResult is Azure.Core.Page<ImageDefinition>;

model ImageListResult is Azure.Core.Page<Image>;

model ImageVersionListResult is Azure.Core.Page<ImageVersion>;

model NetworkConnectionListResult is Azure.Core.Page<NetworkConnection>;

model PoolListResult is Azure.Core.Page<Pool>;

model ProjectEnvironmentTypeListResult
  is Azure.Core.Page<ProjectEnvironmentType>;

model ProjectListResult is Azure.Core.Page<Project>;

model ProjectPolicyListResult is Azure.Core.Page<ProjectPolicy>;

model ScheduleListResult is Azure.Core.Page<Schedule>;

model CatalogListResult is Azure.Core.Page<Catalog>;

@@visibility(AllowedEnvironmentTypeListResult.value, Lifecycle.Read);
@@visibility(AttachedNetworkListResult.value, Lifecycle.Read);
@@visibility(CustomizationTaskListResult.value, Lifecycle.Read);
@@visibility(DevBoxDefinitionListResult.value, Lifecycle.Read);
@@visibility(DevCenterListResult.value, Lifecycle.Read);
@@visibility(EncryptionSetListResult.value, Lifecycle.Read);
@@identifiers(OutboundEnvironmentEndpointCollection.value, #["category"]);
@@visibility(EnvironmentDefinitionListResult.value, Lifecycle.Read);
@@visibility(EnvironmentTypeListResult.value, Lifecycle.Read);
@@visibility(GalleryListResult.value, Lifecycle.Read);
@@visibility(HealthCheckStatusDetailsListResult.value, Lifecycle.Read);
@@visibility(ImageDefinitionBuildListResult.value, Lifecycle.Read);
@@visibility(ImageDefinitionListResult.value, Lifecycle.Read);
@@visibility(ImageListResult.value, Lifecycle.Read);
@@visibility(ImageVersionListResult.value, Lifecycle.Read);
@@visibility(ListUsagesResult.value, Lifecycle.Read);
@@visibility(NetworkConnectionListResult.value, Lifecycle.Read);
@@visibility(OutboundEnvironmentEndpointCollection.value, Lifecycle.Read);
@@visibility(PoolListResult.value, Lifecycle.Read);
@@visibility(ProjectEnvironmentTypeListResult.value, Lifecycle.Read);
@@visibility(ProjectListResult.value, Lifecycle.Read);
@@visibility(ProjectPolicyListResult.value, Lifecycle.Read);
@@visibility(ScheduleListResult.value, Lifecycle.Read);
@@visibility(SkuListResult.value, Lifecycle.Read);
@@visibility(CatalogListResult.value, Lifecycle.Read);
