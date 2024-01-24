import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Purview;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The status.
 */
enum Status {
  Unknown,
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * Gets or sets the state of the provisioning.
 */
enum ProvisioningState {
  Unknown,
  Creating,
  Moving,
  Deleting,
  SoftDeleting,
  SoftDeleted,
  Failed,
  Succeeded,
  Canceled,
}

/**
 * Gets or sets the public network access.
 */
enum PublicNetworkAccess {
  NotSpecified,
  Enabled,
  Disabled,
}

/**
 * Gets or sets the sku name.
 */
enum Name {
  Standard,
}

/**
 * Identity Type
 */
enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

/**
 * The type of identity that last modified the resource.
 */
enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * The scope where the default account is set.
 */
enum ScopeType {
  Tenant,
  Subscription,
}

/**
 * The reason the name is not available.
 */
enum Reason {
  Invalid,
  AlreadyExists,
}

/**
 * The account properties
 */
model AccountProperties {
  /**
   * Cloud connectors.
   * External cloud identifier used as part of scanning configuration.
   */
  cloudConnectors?: CloudConnectors;

  /**
   * Gets the time at which the entity was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Gets the creator of the entity.
   */
  @visibility("read")
  createdBy?: string;

  /**
   * Gets the creators of the entity's object id.
   */
  @visibility("read")
  createdByObjectId?: string;

  /**
   * The URIs that are the public endpoints of the account.
   */
  @visibility("read")
  endpoints?: AccountEndpoints;

  /**
   * Gets or sets the friendly name.
   */
  @visibility("read")
  friendlyName?: string;

  /**
   * Gets or sets the managed resource group name
   */
  @visibility("read", "create")
  managedResourceGroupName?: string;

  /**
   * Gets the resource identifiers of the managed resources.
   */
  @visibility("read")
  managedResources?: ManagedResources;

  /**
   * Gets the private endpoint connections information.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Gets or sets the state of the provisioning.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the public network access.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;
}

/**
 * External Cloud Service connectors
 */
model CloudConnectors {
  /**
   * AWS external identifier.
   * Configured in AWS to allow use of the role arn used for scanning
   */
  @visibility("read")
  awsExternalId?: string;
}

/**
 * The account endpoints
 */
model AccountEndpoints {
  /**
   * Gets the catalog endpoint.
   */
  @visibility("read")
  catalog?: string;

  /**
   * Gets the guardian endpoint.
   */
  @visibility("read")
  guardian?: string;

  /**
   * Gets the scan endpoint.
   */
  @visibility("read")
  scan?: string;
}

/**
 * The managed resources in customer subscription.
 */
model ManagedResources {
  /**
   * Gets the managed event hub namespace resource identifier.
   */
  @visibility("read")
  eventHubNamespace?: string;

  /**
   * Gets the managed resource group resource identifier. This resource group will host resource dependencies for the account.
   */
  @visibility("read")
  resourceGroup?: string;

  /**
   * Gets the managed storage account resource identifier.
   */
  @visibility("read")
  storageAccount?: string;
}

/**
 * A private endpoint connection properties class.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint information.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * The private link service connection state.
   */
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: string;
}

/**
 * A private endpoint class.
 */
model PrivateEndpoint {
  /**
   * The private endpoint identifier.
   */
  id?: string;
}

/**
 * The private link service connection state.
 */
model PrivateLinkServiceConnectionState {
  /**
   * The required actions.
   */
  actionsRequired?: string;

  /**
   * The description.
   */
  description?: string;

  /**
   * The status.
   */
  status?: Status;
}

/**
 * The Sku
 */
model PurviewAccountSku {
  /**
   * Gets or sets the sku capacity.
   */
  capacity?: int32;

  /**
   * Gets or sets the sku name.
   */
  name?: Name;
}

/**
 * The Managed Identity of the resource
 */
model Identity {
  /**
   * Service principal object Id
   */
  @visibility("read")
  principalId?: string;

  /**
   * Tenant Id
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Identity Type
   */
  type?: IdentityType;

  /**
   * User Assigned Identities
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Uses client ID and Principal ID
 */
model UserAssignedIdentity {
  /**
   * Gets or Sets Client ID
   */
  @visibility("read")
  clientId?: string;

  /**
   * Gets or Sets Principal ID
   */
  @visibility("read")
  principalId?: string;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model TrackedResourceSystemData extends SystemData {}

/**
 * Default error response model
 */
@error
model ErrorResponseModel {
  /**
   * Gets or sets the error.
   */
  @visibility("read")
  error?: ErrorResponseModelError;
}

/**
 * Gets or sets the error.
 */
model ErrorResponseModelError extends ErrorModel {}

/**
 * Default error model
 */
model ErrorModel {
  /**
   * Gets or sets the code.
   */
  @visibility("read")
  code?: string;

  /**
   * Gets or sets the details.
   */
  @visibility("read")
  details?: ErrorModel[];

  /**
   * Gets or sets the messages.
   */
  @visibility("read")
  message?: string;

  /**
   * Gets or sets the target.
   */
  @visibility("read")
  target?: string;
}

/**
 * The account update properties.
 */
model AccountUpdateParameters {
  /**
   * Identity related info to add/remove userAssignedIdentities.
   */
  identity?: Identity;

  /**
   * The account properties.
   */
  properties?: AccountProperties;

  /**
   * Tags on the azure resource.
   */
  tags?: Record<string>;
}

/**
 * The Account access keys.
 */
model AccessKeys {
  /**
   * Gets or sets the primary connection string.
   */
  atlasKafkaPrimaryEndpoint?: string;

  /**
   * Gets or sets the secondary connection string.
   */
  atlasKafkaSecondaryEndpoint?: string;
}

/**
 * Collection administrator update.
 */
model CollectionAdminUpdate {
  /**
   * Gets or sets the object identifier of the admin.
   */
  objectId?: string;
}

/**
 * Payload to get and set the default account in the given scope
 */
model DefaultAccountPayload {
  /**
   * The name of the account that is set as the default.
   */
  accountName?: string;

  /**
   * The resource group name of the account that is set as the default.
   */
  resourceGroupName?: string;

  /**
   * The scope object ID. For example, sub ID or tenant ID.
   */
  scope?: string;

  /**
   * The scope tenant in which the default account is set.
   */
  scopeTenantId?: string;

  /**
   * The scope where the default account is set.
   */
  scopeType?: ScopeType;

  /**
   * The subscription ID of the account that is set as the default.
   */
  subscriptionId?: string;
}

/**
 * properties on meta info
 */
model OperationProperties {
  /**
   * meta service specification
   */
  serviceSpecification?: OperationMetaServiceSpecification;
}

/**
 * The operation meta service specification
 */
model OperationMetaServiceSpecification {
  /**
   * log specifications for the operation
   */
  logSpecifications?: OperationMetaLogSpecification[];

  /**
   * metric specifications for the operation
   */
  metricSpecifications?: OperationMetaMetricSpecification[];
}

/**
 * log specifications for operation api
 */
model OperationMetaLogSpecification {
  /**
   * blob duration of the log
   */
  blobDuration?: string;

  /**
   * localized name of the log category
   */
  displayName?: string;

  /**
   * name of the log category
   */
  name?: string;
}

/**
 * metric specifications for the operation
 */
model OperationMetaMetricSpecification {
  /**
   * aggregation type of metric
   */
  aggregationType?: string;

  /**
   * properties for dimension
   */
  dimensions?: DimensionProperties[];

  /**
   * description of the metric
   */
  displayDescription?: string;

  /**
   * localized name of the metric
   */
  displayName?: string;

  /**
   * enable regional mdm account
   */
  enableRegionalMdmAccount?: string;

  /**
   * internal metric name
   */
  internalMetricName?: string;

  /**
   * name of the metric
   */
  name?: string;

  /**
   * dimension name use to replace resource id if specified
   */
  resourceIdDimensionNameOverride?: string;

  /**
   * Metric namespace.
   * Only set the namespace if different from the default value,
   * leaving it empty makes it use the value from the ARM manifest.
   */
  sourceMdmNamespace?: string;

  /**
   * supported aggregation types
   */
  supportedAggregationTypes?: string[];

  /**
   * supported time grain types
   */
  supportedTimeGrainTypes?: string[];

  /**
   * units for the metric
   */
  unit?: string;
}

/**
 * properties for dimension
 */
model DimensionProperties {
  /**
   * localized display name of the dimension to customer
   */
  displayName?: string;

  /**
   * dimension name
   */
  name?: string;

  /**
   * flag indicating whether this dimension should be included to the customer in Azure Monitor logs (aka Shoebox)
   */
  toBeExportedForCustomer?: boolean;
}

/**
 * A privately linkable resource properties.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group identifier.
   */
  @visibility("read")
  groupId?: string;

  /**
   * This translates to how many Private IPs should be created for each privately linkable resource.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The required zone names for private link resource.
   */
  @visibility("read")
  requiredZoneNames?: string[];
}

/**
 * The request payload for CheckNameAvailability API
 */
model CheckNameAvailabilityRequest {
  /**
   * Resource name to verify for availability
   */
  name?: string;

  /**
   * Fully qualified resource type which includes provider namespace
   */
  type?: string;
}

/**
 * The response payload for CheckNameAvailability API
 */
model CheckNameAvailabilityResult {
  /**
   * Error message
   */
  message?: string;

  /**
   * Indicates if name is valid and available.
   */
  nameAvailable?: boolean;

  /**
   * The reason the name is not available.
   */
  reason?: Reason;
}
