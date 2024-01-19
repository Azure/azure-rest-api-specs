import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DevCenter;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state of the resource.")
enum ProvisioningState {
  NotSpecified,
  Accepted,
  Running,
  Creating,
  Created,
  Updating,
  Updated,
  Deleting,
  Deleted,
  Succeeded,
  Failed,
  Canceled,
  MovingResources,
  TransientFailure,
  RolloutInProgress,
  StorageProvisioningFailed,
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

@doc("Health check status values")
enum HealthCheckStatus {
  Unknown,
  Pending,
  Running,
  Passed,
  Warning,
  Failed,
}

@doc("Active Directory join type")
enum DomainJoinType {
  HybridAzureADJoin,
  AzureADJoin,
}

@doc("Indicates whether hibernate is enabled/disabled.")
enum HibernateSupport {
  Disabled,
  Enabled,
}

@doc("The synchronization state of the catalog.")
enum CatalogSyncState {
  Succeeded,
  InProgress,
  Failed,
  Canceled,
}

@doc("Indicates whether the environment type is either enabled or disabled.")
enum EnvironmentTypeEnableStatus {
  Enabled,
  Disabled,
}

@doc("Image validation status")
enum ImageValidationStatus {
  Unknown,
  Pending,
  Succeeded,
  Failed,
  TimedOut,
}

@doc("The unit details.")
enum UsageUnit {
  Count,
}

@doc("Health status indicating whether a pool is available to create Dev Boxes.")
enum HealthStatus {
  Unknown,
  Pending,
  Healthy,
  Warning,
  Unhealthy,
}

@doc("License Types")
enum LicenseType {
  Windows_Client,
}

enum LocalAdminStatus {
  Disabled,
  Enabled,
}

@doc("Stop on disconnect enable or disable status. Indicates whether stop on disconnect to is either enabled or disabled.")
enum StopOnDisconnectEnableStatus {
  Enabled,
  Disabled,
}

@doc("The supported types for a scheduled task.")
enum ScheduledType {
  StopDevBox,
}

@doc("The frequency of task execution.")
enum ScheduledFrequency {
  Daily,
}

@doc("Schedule enable or disable status. Indicates whether the schedule applied to is either enabled or disabled.")
enum ScheduleEnableStatus {
  Enabled,
  Disabled,
}

@doc("Properties of the devcenter.")
model DevCenterProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The URI of the Dev Center.")
  @visibility("read")
  devCenterUri?: string;
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

@doc("An error response from the DevCenter service.")
@error
model CloudError {
  @doc("Error body")
  error: CloudErrorBody;
}

@doc("An error response from the DevCenter service.")
model CloudErrorBody {
  @doc("An identifier for the error. Codes are invariant and are intended to be consumed programmatically.")
  code: string;

  @doc("A message describing the error, intended to be suitable for display in a user interface.")
  message: string;

  @doc("The target of the particular error. For example, the name of the property in error.")
  target?: string;

  @doc("A list of additional details about the error.")
  details?: CloudErrorBody[];
}

@doc("The devcenter resource for partial updates. Properties not provided in the update request will not be changed.")
model DevCenterUpdate extends TrackedResourceUpdate {
  @doc("Managed identity properties")
  identity?: ManagedServiceIdentity;
}

@doc("Base tracked resource type for PATCH updates")
model TrackedResourceUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  @visibility("read", "create")
  location?: string;
}

@doc("Properties of a project.")
model ProjectProperties extends ProjectUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The URI of the Dev Center resource this project is associated with.")
  @visibility("read")
  devCenterUri?: string;
}

@doc("Properties of a project. These properties can be updated after the resource has been created.")
model ProjectUpdateProperties {
  @doc("Resource Id of an associated DevCenter")
  devCenterId?: string;

  @doc("Description of the project.")
  description?: string;

  @doc("When specified, limits the maximum number of Dev Boxes a single user can create across all pools in the project. This will have no effect on existing Dev Boxes when reduced.")
  maxDevBoxesPerUser?: int32;
}

@doc("The project properties for partial update. Properties not provided in the update request will not be changed.")
model ProjectUpdate extends TrackedResourceUpdate {
  @doc("Properties of a project to be updated.")
  properties?: ProjectUpdateProperties;
}

@doc("Properties of an attached NetworkConnection.")
model AttachedNetworkConnectionProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resource ID of the NetworkConnection you want to attach.")
  @visibility("read", "create")
  networkConnectionId: string;

  @doc("The geo-location where the NetworkConnection resource specified in 'networkConnectionResourceId' property lives.")
  @visibility("read")
  networkConnectionLocation?: string;

  @doc("Health check status values")
  @visibility("read")
  healthCheckStatus?: HealthCheckStatus;

  @doc("AAD Join type of the network. This is populated based on the referenced Network Connection.")
  @visibility("read")
  domainJoinType?: DomainJoinType;
}

@doc("Properties of a gallery.")
model GalleryProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The resource ID of the backing Azure Compute Gallery.")
  @visibility("read", "create")
  galleryResourceId: string;
}

@doc("Properties of an image.")
model ImageProperties {
  @doc("The description of the image.")
  @visibility("read")
  description?: string;

  @doc("The publisher of the image.")
  @visibility("read")
  publisher?: string;

  @doc("The name of the image offer.")
  @visibility("read")
  offer?: string;

  @doc("The SKU name for the image.")
  @visibility("read")
  sku?: string;

  @doc("The recommended machine configuration to use with the image.")
  @visibility("read")
  recommendedMachineConfiguration?: RecommendedMachineConfiguration;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Indicates whether this image has hibernate enabled. Not all images are capable of supporting hibernation. To find out more see https://aka.ms/devbox/hibernate")
  @visibility("read")
  hibernateSupport?: HibernateSupport;
}

@doc("Properties for a recommended machine configuration.")
model RecommendedMachineConfiguration {
  @doc("Recommended memory range.")
  @visibility("read")
  memory?: ResourceRange;

  @doc("Recommended vCPU range.")
  @visibility("read")
  vCPUs?: ResourceRange;
}

@doc("Properties for a range of values.")
model ResourceRange {
  @doc("Minimum value.")
  @visibility("read")
  min?: int32;

  @doc("Maximum value.")
  @visibility("read")
  max?: int32;
}

@doc("Properties of an image version.")
model ImageVersionProperties {
  @doc("The semantic version string.")
  @visibility("read")
  name?: string;

  @doc("The datetime that the backing image version was published.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDate?: utcDateTime;

  @doc("If the version should be excluded from being treated as the latest version.")
  @visibility("read")
  excludeFromLatest?: boolean;

  @doc("The size of the OS disk image, in GB.")
  @visibility("read")
  osDiskImageSizeInGb?: int32;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties of a catalog.")
model CatalogProperties extends CatalogUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The synchronization state of the catalog.")
  @visibility("read")
  syncState?: CatalogSyncState;

  @doc("When the catalog was last synced.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;
}

@doc("Properties of a catalog. These properties can be updated after the resource has been created.")
model CatalogUpdateProperties {
  @doc("Properties for a GitHub catalog type.")
  gitHub?: GitCatalog;

  @doc("Properties for an Azure DevOps catalog type.")
  adoGit?: GitCatalog;
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
  @doc("Catalog properties for update.")
  properties?: CatalogUpdateProperties;

  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

@doc("Properties of an environment type.")
model EnvironmentTypeProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("The environment type for partial update. Properties not provided in the update request will not be changed.")
model EnvironmentTypeUpdate {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Properties of an allowed environment type.")
model AllowedEnvironmentTypeProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties of a project environment type.")
model ProjectEnvironmentTypeProperties
  extends ProjectEnvironmentTypeUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Properties of a project environment type. These properties can be updated after the resource has been created.")
model ProjectEnvironmentTypeUpdateProperties {
  @doc("Id of a subscription that the environment type will be mapped to. The environment's resources will be deployed into this subscription.")
  deploymentTargetId?: string;

  @doc("Defines whether this Environment Type can be used in this Project.")
  status?: EnvironmentTypeEnableStatus;

  @doc("The role definition assigned to the environment creator on backing resources.")
  creatorRoleAssignment?: ProjectEnvironmentTypeUpdatePropertiesCreatorRoleAssignment;

  @doc("Role Assignments created on environment backing resources. This is a mapping from a user object ID to an object of role definition IDs.")
  userRoleAssignments?: Record<UserRoleAssignmentValue>;
}

@doc("The role definition assigned to the environment creator on backing resources.")
model ProjectEnvironmentTypeUpdatePropertiesCreatorRoleAssignment {
  @doc("A map of roles to assign to the environment creator.")
  roles?: Record<EnvironmentRole>;
}

@doc("A role that can be assigned to a user.")
model EnvironmentRole {
  @doc("The common name of the Role Assignment. This is a descriptive name such as 'AcrPush'.")
  @visibility("read")
  roleName?: string;

  @doc("This is a description of the Role Assignment.")
  @visibility("read")
  description?: string;
}

@doc("Mapping of user object ID to role assignments.")
model UserRoleAssignmentValue {
  @doc("A map of roles to assign to the parent user.")
  roles?: Record<EnvironmentRole>;
}

@doc("The project environment type for partial update. Properties not provided in the update request will not be changed.")
model ProjectEnvironmentTypeUpdate {
  @doc("Properties to configure an environment type.")
  properties?: ProjectEnvironmentTypeUpdateProperties;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Managed identity properties")
  identity?: ManagedServiceIdentity;
}

@doc("Properties of a Dev Box definition.")
model DevBoxDefinitionProperties extends DevBoxDefinitionUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Validation status of the configured image.")
  @visibility("read")
  imageValidationStatus?: ImageValidationStatus;

  @doc("Details for image validator error. Populated when the image validation is not successful.")
  @visibility("read")
  imageValidationErrorDetails?: ImageValidationErrorDetails;

  @doc("Image reference information for the currently active image (only populated during updates).")
  @visibility("read")
  activeImageReference?: ImageReference;
}

@doc("Image validation error details")
model ImageValidationErrorDetails {
  @doc("An identifier for the error.")
  code?: string;

  @doc("A message describing the error.")
  message?: string;
}

@doc("Image reference information")
model ImageReference {
  @doc("Image ID, or Image version ID. When Image ID is provided, its latest version will be used.")
  id?: string;

  @doc("The actual version of the image after use. When id references a gallery image latest version, this will indicate the actual version in use.")
  @visibility("read")
  exactVersion?: string;
}

@doc("Properties of a Dev Box definition. These properties can be updated after the resource has been created.")
model DevBoxDefinitionUpdateProperties {
  @doc("Image reference information.")
  imageReference?: ImageReference;

  @doc("The SKU for Dev Boxes created using this definition.")
  sku?: Sku;

  @doc("The storage type used for the Operating System disk of Dev Boxes created using this definition.")
  osStorageType?: string;

  @doc("Indicates whether Dev Boxes created with this definition are capable of hibernation. Not all images are capable of supporting hibernation. To find out more see https://aka.ms/devbox/hibernate")
  hibernateSupport?: HibernateSupport;
}

@doc("The resource model definition representing SKU")
model Sku {
  @doc("The name of the SKU. Ex - P3. It is typically a letter+number code")
  name: string;

  @doc("This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.")
  tier?: SkuTier;

  @doc("The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. ")
  size?: string;

  @doc("If the service has different generations of hardware, for the same SKU, then that can be captured here.")
  family?: string;

  @doc("If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.")
  capacity?: int32;
}

@doc("Partial update of a Dev Box definition resource.")
model DevBoxDefinitionUpdate extends TrackedResourceUpdate {
  @doc("Properties of a Dev Box definition to be updated.")
  properties?: DevBoxDefinitionUpdateProperties;
}

@doc("The current status of an async operation")
model OperationStatus extends OperationStatusResult {
  @doc("The id of the resource.")
  @visibility("read")
  resourceId?: string;

  @doc("Custom operation properties, populated only for a successful operation.")
  @visibility("read")
  properties?: Record<unknown>;
}

@doc("List of Core Usages.")
model ListUsagesResult is Azure.Core.Page<Usage>;

@doc("The core usage details.")
model Usage {
  @doc("The current usage.")
  currentValue?: int32;

  @doc("The limit integer.")
  limit?: int32;

  @doc("The unit details.")
  unit?: UsageUnit;

  @doc("The name.")
  name?: UsageName;
}

@doc("The Usage Names.")
model UsageName {
  @doc("The localized name of the resource.")
  localizedValue?: string;

  @doc("The name of the resource.")
  value?: string;
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("Results of the Microsoft.DevCenter SKU list operation.")
model SkuListResult is Azure.Core.Page<DevCenterSku>;

@doc("The resource model definition representing SKU for DevCenter resources")
model DevCenterSku extends Sku {
  @doc("The name of the resource type")
  @visibility("read")
  resourceType?: string;

  @doc("SKU supported locations.")
  @visibility("read")
  locations?: string[];

  @doc("Collection of name/value pairs to describe the SKU capabilities.")
  @visibility("read")
  capabilities?: Capability[];
}

@doc("A name/value pair to describe a capability.")
model Capability {
  @doc("Name of the capability.")
  @visibility("read")
  name?: string;

  @doc("Value of the capability.")
  @visibility("read")
  value?: string;
}

@doc("Properties of a Pool")
model PoolProperties extends PoolUpdateProperties {
  @doc("Overall health status of the Pool. Indicates whether or not the Pool is available to create Dev Boxes.")
  @visibility("read")
  healthStatus?: HealthStatus;

  @doc("Details on the Pool health status to help diagnose issues. This is only populated when the pool status indicates the pool is in a non-healthy state")
  @visibility("read")
  healthStatusDetails?: HealthStatusDetail[];

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Pool health status detail.")
model HealthStatusDetail {
  @doc("An identifier for the issue.")
  @visibility("read")
  code?: string;

  @doc("A message describing the issue, intended to be suitable for display in a user interface")
  @visibility("read")
  message?: string;
}

@doc("Properties of a Pool. These properties can be updated after the resource has been created.")
model PoolUpdateProperties {
  @doc("Name of a Dev Box definition in parent Project of this Pool")
  devBoxDefinitionName?: string;

  @doc("Name of a Network Connection in parent Project of this Pool")
  networkConnectionName?: string;

  @doc("Specifies the license type indicating the caller has already acquired licenses for the Dev Boxes that will be created.")
  licenseType?: LicenseType;

  @doc("Indicates whether owners of Dev Boxes in this pool are added as local administrators on the Dev Box.")
  localAdministrator?: LocalAdminStatus;

  @doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
  stopOnDisconnect?: StopOnDisconnectConfiguration;
}

@doc("Stop on disconnect configuration settings for Dev Boxes created in this pool.")
model StopOnDisconnectConfiguration {
  @doc("Whether the feature to stop the Dev Box on disconnect once the grace period has lapsed is enabled.")
  status?: StopOnDisconnectEnableStatus;

  @doc("The specified time in minutes to wait before stopping a Dev Box once disconnect is detected.")
  gracePeriodMinutes?: int32;
}

@doc("The pool properties for partial update. Properties not provided in the update request will not be changed.")
model PoolUpdate extends TrackedResourceUpdate {
  @doc("Properties of a pool to be updated.")
  properties?: PoolUpdateProperties;
}

@doc("The Schedule properties defining when and what to execute.")
model ScheduleProperties extends ScheduleUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Updatable properties of a Schedule.")
model ScheduleUpdateProperties {
  @doc("Supported type this scheduled task represents.")
  @projectedName("json", "type")
  scheduledType?: ScheduledType;

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
model ScheduleUpdate extends TrackedResourceUpdate {
  @doc("Properties of a schedule resource to be updated.")
  properties?: ScheduleUpdateProperties;
}

@doc("Network properties")
model NetworkProperties extends NetworkConnectionUpdateProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Overall health status of the network connection. Health checks are run on creation, update, and periodically to validate the network connection.")
  @visibility("read")
  healthCheckStatus?: HealthCheckStatus;

  @doc("The name for resource group where NICs will be placed.")
  @visibility("read", "create")
  networkingResourceGroupName?: string;

  @doc("AAD Join type.")
  @visibility("read", "create")
  domainJoinType: DomainJoinType;
}

@doc("Properties of network connection. These properties can be updated after the resource has been created.")
model NetworkConnectionUpdateProperties {
  @doc("The subnet to attach Virtual Machines to")
  subnetId?: string;

  @doc("Active Directory domain name")
  domainName?: string;

  @doc("Active Directory domain Organization Unit (OU)")
  organizationUnit?: string;

  @doc("The username of an Active Directory account (user or service account) that has permissions to create computer objects in Active Directory. Required format: admin@contoso.com.")
  domainUsername?: string;

  @doc("The password for the account used to join domain")
  domainPassword?: string;
}

@doc("The network connection properties for partial update. Properties not provided in the update request will not be changed.")
model NetworkConnectionUpdate extends TrackedResourceUpdate {
  @doc("Properties of a network connection resource to be updated.")
  properties?: NetworkConnectionUpdateProperties;
}

@doc("Health Check properties.")
model HealthCheckStatusDetailsProperties {
  @doc("Start time of last execution of the health checks.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  @doc("End time of last execution of the health checks.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  @doc("Details for each health check item.")
  @visibility("read")
  healthChecks?: HealthCheck[];
}

@doc("An individual health check item")
model HealthCheck {
  @doc("The status of the health check item.")
  @visibility("read")
  status?: HealthCheckStatus;

  @doc("The display name of this health check item.")
  @visibility("read")
  displayName?: string;

  @doc("Start time of health check item.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  @doc("End time of the health check item.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  @doc("The type of error that occurred during this health check.")
  @visibility("read")
  errorType?: string;

  @doc("The recommended action to fix the corresponding error.")
  @visibility("read")
  recommendedAction?: string;

  @doc("Additional details about the health check or the recommended action.")
  @visibility("read")
  additionalDetails?: string;
}

@doc("Values returned by the List operation.")
model OutboundEnvironmentEndpointCollection
  is Azure.Core.Page<OutboundEnvironmentEndpoint>;

@doc("A collection of related endpoints from the same service for which the agent requires outbound access.")
model OutboundEnvironmentEndpoint {
  @doc("The type of service that the agent connects to.")
  @visibility("read")
  category?: string;

  @doc("The endpoints for this service for which the agent requires outbound access.")
  @visibility("read")
  endpoints?: EndpointDependency[];
}

@doc("A domain name and connection details used to access a dependency.")
model EndpointDependency {
  @doc("The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.")
  @visibility("read")
  domainName?: string;

  @doc("Human-readable supplemental information about the dependency and when it is applicable.")
  @visibility("read")
  description?: string;

  @doc("The list of connection details for this endpoint.")
  @visibility("read")
  endpointDetails?: EndpointDetail[];
}

@doc("Details about the connection between the Batch service and the endpoint.")
model EndpointDetail {
  @doc("The port an endpoint is connected to.")
  @visibility("read")
  port?: int32;
}
