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

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Moving
   */
  Moving: "Moving",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * SoftDeleting
   */
  SoftDeleting: "SoftDeleting",

  /**
   * SoftDeleted
   */
  SoftDeleted: "SoftDeleted",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Gets or sets the public network access for managed resources.
 */
union PublicNetworkAccess {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

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
 * Gets or sets the state of managed eventhub. If enabled managed eventhub will be created, if disabled the managed eventhub will be removed.
 */
union ManagedEventHubState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The status of the merge operation.
 */
union MergeStatus {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

/**
 * The account's type for the merge operation.
 */
union MergeAccountType {
  string,

  /**
   * Primary
   */
  Primary: "Primary",

  /**
   * Secondary
   */
  Secondary: "Secondary",
}

/**
 * The status.
 */
union PrivateEndpointConnectionStatus {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * Gets or sets the state of the provisioning.
 */
union ProvisioningState {
  string,

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Moving
   */
  Moving: "Moving",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * SoftDeleting
   */
  SoftDeleting: "SoftDeleting",

  /**
   * SoftDeleted
   */
  SoftDeleted: "SoftDeleted",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * Gets or sets the state of tenant endpoint.
 */
union TenantEndpointState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * Gets or sets the sku name.
 */
union AccountSkuName {
  string,

  /**
   * Standard
   */
  Standard: "Standard",

  /**
   * Free
   */
  Free: "Free",
}

/**
 * Identity Type
 */
union ManagedIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * The scope where the default account is set.
 */
union ScopeType {
  string,

  /**
   * Tenant
   */
  Tenant: "Tenant",

  /**
   * Subscription
   */
  Subscription: "Subscription",
}

/**
 * Identity Type.
 */
union KafkaConfigurationIdentityType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * SystemAssigned
   */
  SystemAssigned: "SystemAssigned",

  /**
   * UserAssigned
   */
  UserAssigned: "UserAssigned",
}

/**
 * The event hub type.
 */
union EventHubType {
  string,

  /**
   * Notification
   */
  Notification: "Notification",

  /**
   * Hook
   */
  Hook: "Hook",
}

/**
 * The state of the event streaming service
 */
union EventStreamingState {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Enabled
   */
  Enabled: "Enabled",
}

/**
 * The event streaming service type
 */
union EventStreamingType {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Managed
   */
  Managed: "Managed",

  /**
   * Azure
   */
  Azure: "Azure",
}

/**
 * The reason the name is not available.
 */
union Reason {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * AlreadyExists
   */
  AlreadyExists: "AlreadyExists",
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
  managedResourcesPublicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.NotSpecified;

  /**
   * Gets or sets the Merge Info.
   */
  mergeInfo?: AccountMergeInfo;

  /**
   * Gets the private endpoint connections information.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Gets or sets the state of the provisioning.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Gets or sets the public network access.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * Gets or sets the state of tenant endpoint.
   */
  tenantEndpointState?: TenantEndpointState;
}

/**
 * Gets or sets the status of the account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Uses client ID and Principal ID
 */
model UserAssignedIdentity {
  /**
   * Gets or Sets Client ID
   */
  @visibility(Lifecycle.Read)
  clientId?: string;

  /**
   * Gets or Sets Principal ID
   */
  @visibility(Lifecycle.Read)
  principalId?: string;
}

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ErrorResponseModelError extends ErrorModel {}

/**
 * The account update properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AccountUpdateParameters {
  /**
   * The Managed Identity of the resource
   */
  identity?: Identity;

  /**
   * The account properties
   */
  properties?: AccountProperties;

  /**
   * Tags on the azure resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  features?: string[];
}

/**
 * List of features with enabled status
 */
model BatchFeatureStatus {
  /**
   * Features with enabled status
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Paged list of private link resources
 */
model PrivateLinkResourceList is Azure.Core.Page<PrivateLinkResource>;

/**
 * A privately linkable resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
model UsageList is Azure.Core.Page<Usage>;

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
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
