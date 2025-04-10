import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Purview;

/**
 * Gets the account status code.
 */
union AccountProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SoftDeleting: "SoftDeleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SoftDeleted: "SoftDeleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Gets or sets the public network access for managed resources.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Gets or sets the state of managed eventhub. If enabled managed eventhub will be created, if disabled the managed eventhub will be removed.
 */
union ManagedEventHubState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * The status of the merge operation.
 */
union MergeStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InProgress: "InProgress",
}

/**
 * The account's type for the merge operation.
 */
union MergeAccountType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Secondary: "Secondary",
}

/**
 * The status.
 */
union PrivateEndpointConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * The type of identity that last modified the resource.
 */
union LastModifiedByType {
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
 * Gets or sets the state of the provisioning.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SoftDeleting: "SoftDeleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SoftDeleted: "SoftDeleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Gets or sets the state of tenant endpoint.
 */
union TenantEndpointState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Gets or sets the sku name.
 */
union AccountSkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Free: "Free",
}

/**
 * The scope where the default account is set.
 */
union ScopeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Tenant: "Tenant",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Subscription: "Subscription",
}

/**
 * Identity Type.
 */
union KafkaConfigurationIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
}

/**
 * The event hub type.
 */
union EventHubType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Notification: "Notification",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Hook: "Hook",
}

/**
 * The state of the event streaming service
 */
union EventStreamingState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * The event streaming service type
 */
union EventStreamingType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Managed: "Managed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Azure: "Azure",
}

/**
 * The reason the name is not available.
 */
union Reason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Invalid: "Invalid",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AlreadyExists: "AlreadyExists",
}

/**
 * Gets or sets the consent kind.
 */
union ConsentKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Metadata: "Metadata",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Governance: "Governance",
}

/**
 * Defines consent scope type.
 */
union ConsentScopeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Azure: "Azure",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Fabric: "Fabric",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Databricks: "Databricks",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Snowflake: "Snowflake",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  S3: "S3",
}

/**
 * Defines consent status.
 */
union ConsentStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotSpecified: "NotSpecified",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Paged list of Account resources
 */
model AccountList is Azure.Core.Page<Account>;

/**
 * The account properties
 */
model AccountProperties {
  /**
   * Gets or sets the status of the account.
   */
  @visibility(Lifecycle.Read)
  accountStatus?: AccountPropertiesAccountStatus;

  /**
   * External Cloud Service connectors
   */
  cloudConnectors?: CloudConnectors;

  /**
   * Gets the time at which the entity was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Gets the creator of the entity.
   */
  @visibility(Lifecycle.Read)
  createdBy?: string;

  /**
   * Gets the creators of the entity's object id.
   */
  @visibility(Lifecycle.Read)
  createdByObjectId?: string;

  /**
   * Gets the default domain in the account.
   */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /**
   * The URIs that are the public endpoints of the account.
   */
  @visibility(Lifecycle.Read)
  endpoints?: AccountPropertiesEndpoints;

  /**
   * Gets or sets the friendly name.
   */
  @visibility(Lifecycle.Read)
  friendlyName?: string;

  /**
   * Ingestion Storage Account Info
   */
  ingestionStorage?: IngestionStorage;

  /**
   * Gets or sets the state of managed eventhub. If enabled managed eventhub will be created, if disabled the managed eventhub will be removed.
   */
  managedEventHubState?: ManagedEventHubState = ManagedEventHubState.NotSpecified;

  /**
   * Gets or sets the managed resource group name
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedResourceGroupName?: string;

  /**
   * Gets the resource identifiers of the managed resources.
   */
  @visibility(Lifecycle.Read)
  managedResources?: AccountPropertiesManagedResources;

  /**
   * Gets or sets the public network access for managed resources.
   */
  managedResourcesPublicNetworkAccess?: PublicNetworkAccess;

  /**
   * Gets or sets the Merge Info.
   */
  mergeInfo?: AccountMergeInfo;

  /**
   * Gets the private endpoint connections information.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Gets or sets the state of the provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the public network access.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Gets or sets the state of tenant endpoint.
   */
  tenantEndpointState?: TenantEndpointState;
}

/**
 * Gets or sets the status of the account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccountPropertiesAccountStatus extends AccountStatus {}

/**
 * The account status.
 */
model AccountStatus {
  /**
   * Gets the account status code.
   */
  @visibility(Lifecycle.Read)
  accountProvisioningState?: AccountProvisioningState;

  /**
   * Gets the account error details.
   */
  @visibility(Lifecycle.Read)
  errorDetails?: AccountStatusErrorDetails;
}

/**
 * Gets the account error details.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccountStatusErrorDetails extends ErrorModel {}

/**
 * Default error model
 */
model ErrorModel {
  /**
   * Gets or sets the code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Gets or sets the details.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: ErrorModel[];

  /**
   * Gets or sets the messages.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Gets or sets the target.
   */
  @visibility(Lifecycle.Read)
  target?: string;
}

/**
 * External Cloud Service connectors
 */
model CloudConnectors {
  /**
   * AWS external identifier.
   * Configured in AWS to allow use of the role arn used for scanning
   */
  @visibility(Lifecycle.Read)
  awsExternalId?: string;
}

/**
 * The URIs that are the public endpoints of the account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccountPropertiesEndpoints extends AccountEndpoints {}

/**
 * The account endpoints
 */
model AccountEndpoints {
  /**
   * Gets the catalog endpoint.
   */
  @visibility(Lifecycle.Read)
  catalog?: string;

  /**
   * Gets the scan endpoint.
   */
  @visibility(Lifecycle.Read)
  scan?: string;
}

/**
 * Ingestion Storage Account Info
 */
model IngestionStorage {
  /**
   * Gets or sets the Id.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Gets or sets the primary endpoint.
   */
  @visibility(Lifecycle.Read)
  primaryEndpoint?: string;

  /**
   * Gets or sets the public network access setting
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Gets the resource identifiers of the managed resources.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccountPropertiesManagedResources extends ManagedResources {}

/**
 * The managed resources in customer subscription.
 */
model ManagedResources {
  /**
   * Gets the managed event hub namespace resource identifier.
   */
  @visibility(Lifecycle.Read)
  eventHubNamespace?: string;

  /**
   * Gets the managed resource group resource identifier. This resource group will host resource dependencies for the account.
   */
  @visibility(Lifecycle.Read)
  resourceGroup?: string;

  /**
   * Gets the managed storage account resource identifier.
   */
  @visibility(Lifecycle.Read)
  storageAccount?: string;
}

/**
 * The public Account Merge Info model.
 */
model AccountMergeInfo {
  /**
   * The account location of the *other* account in the merge operation.
   */
  @visibility(Lifecycle.Read)
  accountLocation?: string;

  /**
   * The account name of the *other* account in the merge operation.
   */
  @visibility(Lifecycle.Read)
  accountName?: string;

  /**
   * The resource group name of the *other* account in the merge operation.
   */
  @visibility(Lifecycle.Read)
  accountResourceGroupName?: string;

  /**
   * The subscription id of the *other* account in the merge operation.
   */
  @visibility(Lifecycle.Read)
  accountSubscriptionId?: string;

  /**
   * The deprovisioned status of the account.
   * Only applicable for the secondary account.
   */
  @visibility(Lifecycle.Read)
  deprovisioned?: boolean;

  /**
   * The status of the merge operation.
   */
  @visibility(Lifecycle.Read)
  mergeStatus?: MergeStatus;

  /**
   * The account's type for the merge operation.
   */
  @visibility(Lifecycle.Read)
  typeOfAccount?: MergeAccountType;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
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
  status?: PrivateEndpointConnectionStatus;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ProxyResourceSystemData extends SystemData {}

/**
 * Gets or sets the Sku.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AccountSku extends AccountSku {}

/**
 * The Sku
 */
model AccountSku {
  /**
   * Gets or sets the sku capacity.
   */
  capacity?: int32;

  /**
   * Gets or sets the sku name.
   */
  name?: AccountSkuName;
}

/**
 * The Managed Identity of the resource
 */
model Identity {
  /**
   * Service principal object Id
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Tenant Id
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * Identity Type
   */
  type?: ManagedIdentityType;

  /**
   * User Assigned Identities
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TrackedResourceSystemData extends SystemData {}

/**
 * Default error response model
 */
@error
model ErrorResponseModel {
  /**
   * Gets or sets the error.
   */
  @visibility(Lifecycle.Read)
  error?: ErrorResponseModelError;
}

/**
 * Gets or sets the error.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ErrorResponseModelError extends ErrorModel {}

/**
 * The account update properties.
 */
model AccountUpdateParameters {
  /**
   * The Managed Identity of the resource
   */
  identity?: Identity;

  /**
   * The account properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: AccountProperties;

  /**
   * Tags on the azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
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
 * The Purview Account access keys.
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
 * Feature request model
 */
model BatchFeatureRequest {
  /**
   * Set of features
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  features?: string[];
}

/**
 * List of features with enabled status
 */
model BatchFeatureStatus {
  /**
   * Features with enabled status
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  features?: Record<boolean>;
}

/**
 * Paged list of private endpoint connections
 */
model PrivateEndpointConnectionList
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * A private endpoint connection status update request class.
 */
model PrivateEndpointConnectionStatusUpdateRequest {
  /**
   * The private endpoint resource identifier.
   */
  privateEndpointId?: string;

  /**
   * The private endpoint connection status.
   */
  status?: string;
}

/**
 * A private endpoint connection status update response class.
 */
model PrivateEndpointConnectionStatusUpdateResponse {
  /**
   * The private endpoint resource identifier.
   */
  privateEndpointId?: string;

  /**
   * The private endpoint connection status.
   */
  status?: string;
}

/**
 * Paged list of kafka configuration resources
 */
model KafkaConfigurationList is Azure.Core.Page<KafkaConfiguration>;

/**
 * The kafka configuration properties of the event streaming service attached to the Purview account for kafka notifications.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model KafkaConfigurationProperties {
  /**
   * Consumer group for hook event hub.
   */
  consumerGroup?: string;

  /**
   * Credentials to access the event streaming service attached to the purview account.
   */
  credentials?: Credentials;

  /**
   * Optional partition Id for notification event hub. If not set, all partitions will be leveraged.
   */
  eventHubPartitionId?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  eventHubResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EventHub/namespaces/eventHubs";
    }
  ]>;

  /**
   * The event hub type.
   */
  eventHubType?: EventHubType;

  /**
   * The state of the event streaming service
   */
  eventStreamingState?: EventStreamingState = EventStreamingState.Enabled;

  /**
   * The event streaming service type
   */
  eventStreamingType?: EventStreamingType = EventStreamingType.None;
}

/**
 * Credentials to access the event streaming service attached to the purview account.
 */
model Credentials {
  /**
   * Identity identifier for UserAssign type.
   */
  identityId?: string;

  /**
   * Identity Type.
   */
  type?: KafkaConfigurationIdentityType;
}

/**
 * properties on meta info
 */
model OperationProperties {
  /**
   * The operation meta service specification
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  logSpecifications?: OperationMetaLogSpecification[];

  /**
   * metric specifications for the operation
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedAggregationTypes?: string[];

  /**
   * supported time grain types
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
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
 * Paged list of private link resources
 */
model PrivateLinkResourceList is Azure.Core.Page<PrivateLinkResource>;

/**
 * A privately linkable resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group identifier.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * This translates to how many Private IPs should be created for each privately linkable resource.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The required zone names for private link resource.
   */
  @visibility(Lifecycle.Read)
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

/**
 * List of usage information
 */
model UsageList {
  /**
   * The Url of next link.
   */
  nextLink?: string;

  /**
   * Collection of usage values.
   */
  @visibility(Lifecycle.Read)
  value?: Usage[];
}

/**
 * Response for usage information
 */
model Usage {
  /**
   * Current usage quota value
   */
  @visibility(Lifecycle.Read)
  currentValue?: int32;

  /**
   * Fully qualified resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Usage quota limit
   */
  @visibility(Lifecycle.Read)
  limit?: int32;

  /**
   * Quota name
   */
  @visibility(Lifecycle.Read)
  name?: UsageName;

  /**
   * Quota usage unit.
   */
  @visibility(Lifecycle.Read)
  unit?: string;
}

/**
 * Quota name
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model UsageName extends QuotaName {}

/**
 * Quota name
 */
model QuotaName {
  /**
   * Gets or sets the localized name value.
   */
  localizedValue?: string;

  /**
   * Gets or sets the name value.
   */
  value?: string;
}

/**
 * Consent extension resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Consent extends ProxyResource {
  /**
   * Gets or sets the consent kind.
   */
  kind?: ConsentKind;

  /**
   * The consent properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: ConsentProperties;
}

/**
 * The consent properties
 */
model ConsentProperties {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  scope?: string;

  /**
   * Defines consent scope type.
   */
  @visibility(Lifecycle.Read)
  scopeType?: ConsentScopeType;

  /**
   * Defines consent status.
   */
  @visibility(Lifecycle.Read)
  status?: ConsentStatus;
}
