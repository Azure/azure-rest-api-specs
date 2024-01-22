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

/**
 * Provisioning state of the resource.
 */
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

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

/**
 * Health check status values
 */
enum HealthCheckStatus {
  Unknown,
  Pending,
  Running,
  Passed,
  Warning,
  Failed,
}

/**
 * Active Directory join type
 */
enum DomainJoinType {
  HybridAzureADJoin,
  AzureADJoin,
}

/**
 * Indicates whether hibernate is enabled/disabled.
 */
enum HibernateSupport {
  Disabled,
  Enabled,
}

/**
 * The synchronization state of the catalog.
 */
enum CatalogSyncState {
  Succeeded,
  InProgress,
  Failed,
  Canceled,
}

/**
 * Indicates whether the environment type is either enabled or disabled.
 */
enum EnvironmentTypeEnableStatus {
  Enabled,
  Disabled,
}

/**
 * Image validation status
 */
enum ImageValidationStatus {
  Unknown,
  Pending,
  Succeeded,
  Failed,
  TimedOut,
}

/**
 * The unit details.
 */
enum UsageUnit {
  Count,
}

/**
 * Health status indicating whether a pool is available to create Dev Boxes.
 */
enum HealthStatus {
  Unknown,
  Pending,
  Healthy,
  Warning,
  Unhealthy,
}

/**
 * License Types
 */
enum LicenseType {
  Windows_Client,
}

enum LocalAdminStatus {
  Disabled,
  Enabled,
}

/**
 * Stop on disconnect enable or disable status. Indicates whether stop on disconnect to is either enabled or disabled.
 */
enum StopOnDisconnectEnableStatus {
  Enabled,
  Disabled,
}

/**
 * The supported types for a scheduled task.
 */
enum ScheduledType {
  StopDevBox,
}

/**
 * The frequency of task execution.
 */
enum ScheduledFrequency {
  Daily,
}

/**
 * Schedule enable or disable status. Indicates whether the schedule applied to is either enabled or disabled.
 */
enum ScheduleEnableStatus {
  Enabled,
  Disabled,
}

/**
 * Properties of the devcenter.
 */
model DevCenterProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The URI of the Dev Center.
   */
  @visibility("read")
  devCenterUri?: string;
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
 * An error response from the DevCenter service.
 */
@error
model CloudError {
  /**
   * Error body
   */
  error: CloudErrorBody;
}

/**
 * An error response from the DevCenter service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message: string;

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
 * The devcenter resource for partial updates. Properties not provided in the update request will not be changed.
 */
model DevCenterUpdate extends TrackedResourceUpdate {
  /**
   * Managed identity properties
   */
  identity?: ManagedServiceIdentity;
}

/**
 * Base tracked resource type for PATCH updates
 */
model TrackedResourceUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * The geo-location where the resource lives
   */
  @visibility("read", "create")
  location?: string;
}

/**
 * Properties of a project.
 */
model ProjectProperties extends ProjectUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The URI of the Dev Center resource this project is associated with.
   */
  @visibility("read")
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
}

/**
 * The project properties for partial update. Properties not provided in the update request will not be changed.
 */
model ProjectUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a project to be updated.
   */
  properties?: ProjectUpdateProperties;
}

/**
 * Properties of an attached NetworkConnection.
 */
model AttachedNetworkConnectionProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the NetworkConnection you want to attach.
   */
  @visibility("read", "create")
  networkConnectionId: string;

  /**
   * The geo-location where the NetworkConnection resource specified in 'networkConnectionResourceId' property lives.
   */
  @visibility("read")
  networkConnectionLocation?: string;

  /**
   * Health check status values
   */
  @visibility("read")
  healthCheckStatus?: HealthCheckStatus;

  /**
   * AAD Join type of the network. This is populated based on the referenced Network Connection.
   */
  @visibility("read")
  domainJoinType?: DomainJoinType;
}

/**
 * Properties of a gallery.
 */
model GalleryProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The resource ID of the backing Azure Compute Gallery.
   */
  @visibility("read", "create")
  galleryResourceId: string;
}

/**
 * Properties of an image.
 */
model ImageProperties {
  /**
   * The description of the image.
   */
  @visibility("read")
  description?: string;

  /**
   * The publisher of the image.
   */
  @visibility("read")
  publisher?: string;

  /**
   * The name of the image offer.
   */
  @visibility("read")
  offer?: string;

  /**
   * The SKU name for the image.
   */
  @visibility("read")
  sku?: string;

  /**
   * The recommended machine configuration to use with the image.
   */
  @visibility("read")
  recommendedMachineConfiguration?: RecommendedMachineConfiguration;

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Indicates whether this image has hibernate enabled. Not all images are capable of supporting hibernation. To find out more see https://aka.ms/devbox/hibernate
   */
  @visibility("read")
  hibernateSupport?: HibernateSupport;
}

/**
 * Properties for a recommended machine configuration.
 */
model RecommendedMachineConfiguration {
  /**
   * Recommended memory range.
   */
  @visibility("read")
  memory?: ResourceRange;

  /**
   * Recommended vCPU range.
   */
  @visibility("read")
  vCPUs?: ResourceRange;
}

/**
 * Properties for a range of values.
 */
model ResourceRange {
  /**
   * Minimum value.
   */
  @visibility("read")
  min?: int32;

  /**
   * Maximum value.
   */
  @visibility("read")
  max?: int32;
}

/**
 * Properties of an image version.
 */
model ImageVersionProperties {
  /**
   * The semantic version string.
   */
  @visibility("read")
  name?: string;

  /**
   * The datetime that the backing image version was published.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  publishedDate?: utcDateTime;

  /**
   * If the version should be excluded from being treated as the latest version.
   */
  @visibility("read")
  excludeFromLatest?: boolean;

  /**
   * The size of the OS disk image, in GB.
   */
  @visibility("read")
  osDiskImageSizeInGb?: int32;

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Properties of a catalog.
 */
model CatalogProperties extends CatalogUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The synchronization state of the catalog.
   */
  @visibility("read")
  syncState?: CatalogSyncState;

  /**
   * When the catalog was last synced.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTime?: utcDateTime;
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
  properties?: CatalogUpdateProperties;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * Properties of an environment type.
 */
model EnvironmentTypeProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The environment type for partial update. Properties not provided in the update request will not be changed.
 */
model EnvironmentTypeUpdate {
  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * Properties of an allowed environment type.
 */
model AllowedEnvironmentTypeProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Properties of a project environment type.
 */
model ProjectEnvironmentTypeProperties
  extends ProjectEnvironmentTypeUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
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
  userRoleAssignments?: Record<UserRoleAssignmentValue>;
}

/**
 * The role definition assigned to the environment creator on backing resources.
 */
model ProjectEnvironmentTypeUpdatePropertiesCreatorRoleAssignment {
  /**
   * A map of roles to assign to the environment creator.
   */
  roles?: Record<EnvironmentRole>;
}

/**
 * A role that can be assigned to a user.
 */
model EnvironmentRole {
  /**
   * The common name of the Role Assignment. This is a descriptive name such as 'AcrPush'.
   */
  @visibility("read")
  roleName?: string;

  /**
   * This is a description of the Role Assignment.
   */
  @visibility("read")
  description?: string;
}

/**
 * Mapping of user object ID to role assignments.
 */
model UserRoleAssignmentValue {
  /**
   * A map of roles to assign to the parent user.
   */
  roles?: Record<EnvironmentRole>;
}

/**
 * The project environment type for partial update. Properties not provided in the update request will not be changed.
 */
model ProjectEnvironmentTypeUpdate {
  /**
   * Properties to configure an environment type.
   */
  properties?: ProjectEnvironmentTypeUpdateProperties;

  /**
   * Resource tags.
   */
  tags?: Record<string>;

  /**
   * Managed identity properties
   */
  identity?: ManagedServiceIdentity;
}

/**
 * Properties of a Dev Box definition.
 */
model DevBoxDefinitionProperties extends DevBoxDefinitionUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Validation status of the configured image.
   */
  @visibility("read")
  imageValidationStatus?: ImageValidationStatus;

  /**
   * Details for image validator error. Populated when the image validation is not successful.
   */
  @visibility("read")
  imageValidationErrorDetails?: ImageValidationErrorDetails;

  /**
   * Image reference information for the currently active image (only populated during updates).
   */
  @visibility("read")
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
  @visibility("read")
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
  sku?: Sku;

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
 * The resource model definition representing SKU
 */
model Sku {
  /**
   * The name of the SKU. Ex - P3. It is typically a letter+number code
   */
  name: string;

  /**
   * This field is required to be implemented by the Resource Provider if the service has more than one tier, but is not required on a PUT.
   */
  tier?: SkuTier;

  /**
   * The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code.
   */
  size?: string;

  /**
   * If the service has different generations of hardware, for the same SKU, then that can be captured here.
   */
  family?: string;

  /**
   * If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted.
   */
  capacity?: int32;
}

/**
 * Partial update of a Dev Box definition resource.
 */
model DevBoxDefinitionUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a Dev Box definition to be updated.
   */
  properties?: DevBoxDefinitionUpdateProperties;
}

/**
 * The current status of an async operation
 */
model OperationStatus extends OperationStatusResult {
  /**
   * The id of the resource.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * Custom operation properties, populated only for a successful operation.
   */
  @visibility("read")
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
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

/**
 * Results of the Microsoft.DevCenter SKU list operation.
 */
model SkuListResult is Azure.Core.Page<DevCenterSku>;

/**
 * The resource model definition representing SKU for DevCenter resources
 */
model DevCenterSku extends Sku {
  /**
   * The name of the resource type
   */
  @visibility("read")
  resourceType?: string;

  /**
   * SKU supported locations.
   */
  @visibility("read")
  locations?: string[];

  /**
   * Collection of name/value pairs to describe the SKU capabilities.
   */
  @visibility("read")
  capabilities?: Capability[];
}

/**
 * A name/value pair to describe a capability.
 */
model Capability {
  /**
   * Name of the capability.
   */
  @visibility("read")
  name?: string;

  /**
   * Value of the capability.
   */
  @visibility("read")
  value?: string;
}

/**
 * Properties of a Pool
 */
model PoolProperties extends PoolUpdateProperties {
  /**
   * Overall health status of the Pool. Indicates whether or not the Pool is available to create Dev Boxes.
   */
  @visibility("read")
  healthStatus?: HealthStatus;

  /**
   * Details on the Pool health status to help diagnose issues. This is only populated when the pool status indicates the pool is in a non-healthy state
   */
  @visibility("read")
  healthStatusDetails?: HealthStatusDetail[];

  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Pool health status detail.
 */
model HealthStatusDetail {
  /**
   * An identifier for the issue.
   */
  @visibility("read")
  code?: string;

  /**
   * A message describing the issue, intended to be suitable for display in a user interface
   */
  @visibility("read")
  message?: string;
}

/**
 * Properties of a Pool. These properties can be updated after the resource has been created.
 */
model PoolUpdateProperties {
  /**
   * Name of a Dev Box definition in parent Project of this Pool
   */
  devBoxDefinitionName?: string;

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
 * The pool properties for partial update. Properties not provided in the update request will not be changed.
 */
model PoolUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a pool to be updated.
   */
  properties?: PoolUpdateProperties;
}

/**
 * The Schedule properties defining when and what to execute.
 */
model ScheduleProperties extends ScheduleUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Updatable properties of a Schedule.
 */
model ScheduleUpdateProperties {
  /**
   * Supported type this scheduled task represents.
   */
  @projectedName("json", "type")
  scheduledType?: ScheduledType;

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
model ScheduleUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a schedule resource to be updated.
   */
  properties?: ScheduleUpdateProperties;
}

/**
 * Network properties
 */
model NetworkProperties extends NetworkConnectionUpdateProperties {
  /**
   * The provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Overall health status of the network connection. Health checks are run on creation, update, and periodically to validate the network connection.
   */
  @visibility("read")
  healthCheckStatus?: HealthCheckStatus;

  /**
   * The name for resource group where NICs will be placed.
   */
  @visibility("read", "create")
  networkingResourceGroupName?: string;

  /**
   * AAD Join type.
   */
  @visibility("read", "create")
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

  /**
   * The username of an Active Directory account (user or service account) that has permissions to create computer objects in Active Directory. Required format: admin@contoso.com.
   */
  domainUsername?: string;

  /**
   * The password for the account used to join domain
   */
  domainPassword?: string;
}

/**
 * The network connection properties for partial update. Properties not provided in the update request will not be changed.
 */
model NetworkConnectionUpdate extends TrackedResourceUpdate {
  /**
   * Properties of a network connection resource to be updated.
   */
  properties?: NetworkConnectionUpdateProperties;
}

/**
 * Health Check properties.
 */
model HealthCheckStatusDetailsProperties {
  /**
   * Start time of last execution of the health checks.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * End time of last execution of the health checks.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * Details for each health check item.
   */
  @visibility("read")
  healthChecks?: HealthCheck[];
}

/**
 * An individual health check item
 */
model HealthCheck {
  /**
   * The status of the health check item.
   */
  @visibility("read")
  status?: HealthCheckStatus;

  /**
   * The display name of this health check item.
   */
  @visibility("read")
  displayName?: string;

  /**
   * Start time of health check item.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startDateTime?: utcDateTime;

  /**
   * End time of the health check item.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endDateTime?: utcDateTime;

  /**
   * The type of error that occurred during this health check.
   */
  @visibility("read")
  errorType?: string;

  /**
   * The recommended action to fix the corresponding error.
   */
  @visibility("read")
  recommendedAction?: string;

  /**
   * Additional details about the health check or the recommended action.
   */
  @visibility("read")
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
  @visibility("read")
  category?: string;

  /**
   * The endpoints for this service for which the agent requires outbound access.
   */
  @visibility("read")
  endpoints?: EndpointDependency[];
}

/**
 * A domain name and connection details used to access a dependency.
 */
model EndpointDependency {
  /**
   * The domain name of the dependency. Domain names may be fully qualified or may contain a * wildcard.
   */
  @visibility("read")
  domainName?: string;

  /**
   * Human-readable supplemental information about the dependency and when it is applicable.
   */
  @visibility("read")
  description?: string;

  /**
   * The list of connection details for this endpoint.
   */
  @visibility("read")
  endpointDetails?: EndpointDetail[];
}

/**
 * Details about the connection between the Batch service and the endpoint.
 */
model EndpointDetail {
  /**
   * The port an endpoint is connected to.
   */
  @visibility("read")
  port?: int32;
}
