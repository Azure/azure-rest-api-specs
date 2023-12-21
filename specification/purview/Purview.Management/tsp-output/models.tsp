import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.Purview;

interface Operations extends Azure.ResourceManager.Operations {}

enum Status {
  Unknown,
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

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

enum PublicNetworkAccess {
  NotSpecified,
  Enabled,
  Disabled,
}

enum Name {
  Standard,
}

enum IdentityType {
  None,
  SystemAssigned,
  UserAssigned,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum LastModifiedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum ScopeType {
  Tenant,
  Subscription,
}

enum Reason {
  Invalid,
  AlreadyExists,
}

@doc("The account properties")
model AccountProperties {
  @doc("""
Cloud connectors.
External cloud identifier used as part of scanning configuration.
""")
  cloudConnectors?: CloudConnectors;

  @doc("Gets the time at which the entity was created.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Gets the creator of the entity.")
  @visibility("read")
  createdBy?: string;

  @doc("Gets the creators of the entity's object id.")
  @visibility("read")
  createdByObjectId?: string;

  @doc("The URIs that are the public endpoints of the account.")
  @visibility("read")
  endpoints?: AccountEndpoints;

  @doc("Gets or sets the friendly name.")
  @visibility("read")
  friendlyName?: string;

  @doc("Gets or sets the managed resource group name")
  @visibility("read", "create")
  managedResourceGroupName?: string;

  @doc("Gets the resource identifiers of the managed resources.")
  @visibility("read")
  managedResources?: ManagedResources;

  @doc("Gets the private endpoint connections information.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Gets or sets the state of the provisioning.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Gets or sets the public network access.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("External Cloud Service connectors")
model CloudConnectors {
  @doc("""
AWS external identifier.
Configured in AWS to allow use of the role arn used for scanning
""")
  @visibility("read")
  awsExternalId?: string;
}

@doc("The account endpoints")
model AccountEndpoints {
  @doc("Gets the catalog endpoint.")
  @visibility("read")
  catalog?: string;

  @doc("Gets the guardian endpoint.")
  @visibility("read")
  guardian?: string;

  @doc("Gets the scan endpoint.")
  @visibility("read")
  scan?: string;
}

@doc("The managed resources in customer subscription.")
model ManagedResources {
  @doc("Gets the managed event hub namespace resource identifier.")
  @visibility("read")
  eventHubNamespace?: string;

  @doc("Gets the managed resource group resource identifier. This resource group will host resource dependencies for the account.")
  @visibility("read")
  resourceGroup?: string;

  @doc("Gets the managed storage account resource identifier.")
  @visibility("read")
  storageAccount?: string;
}

@doc("A private endpoint connection properties class.")
model PrivateEndpointConnectionProperties {
  @doc("The private endpoint information.")
  privateEndpoint?: PrivateEndpoint;

  @doc("The private link service connection state.")
  privateLinkServiceConnectionState?: PrivateLinkServiceConnectionState;

  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: string;
}

@doc("A private endpoint class.")
model PrivateEndpoint {
  @doc("The private endpoint identifier.")
  id?: string;
}

@doc("The private link service connection state.")
model PrivateLinkServiceConnectionState {
  @doc("The required actions.")
  actionsRequired?: string;

  @doc("The description.")
  description?: string;

  @doc("The status.")
  status?: Status;
}

@doc("The Sku")
model PurviewAccountSku {
  @doc("Gets or sets the sku capacity.")
  capacity?: int32;

  @doc("Gets or sets the sku name.")
  name?: Name;
}

@doc("The Managed Identity of the resource")
model Identity {
  @doc("Service principal object Id")
  @visibility("read")
  principalId?: string;

  @doc("Tenant Id")
  @visibility("read")
  tenantId?: string;

  @doc("Identity Type")
  type?: IdentityType;

  @doc("User Assigned Identities")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("Uses client ID and Principal ID")
model UserAssignedIdentity {
  @doc("Gets or Sets Client ID")
  @visibility("read")
  clientId?: string;

  @doc("Gets or Sets Principal ID")
  @visibility("read")
  principalId?: string;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model TrackedResourceSystemData extends SystemData {}

@doc("Default error response model")
@error
model ErrorResponseModel {
  @doc("Gets or sets the error.")
  @visibility("read")
  error?: ErrorResponseModelError;
}

@doc("Gets or sets the error.")
model ErrorResponseModelError extends ErrorModel {}

@doc("Default error model")
model ErrorModel {
  @doc("Gets or sets the code.")
  @visibility("read")
  code?: string;

  @doc("Gets or sets the details.")
  @visibility("read")
  details?: ErrorModel[];

  @doc("Gets or sets the messages.")
  @visibility("read")
  message?: string;

  @doc("Gets or sets the target.")
  @visibility("read")
  target?: string;
}

@doc("The Account access keys.")
model AccessKeys {
  @doc("Gets or sets the primary connection string.")
  atlasKafkaPrimaryEndpoint?: string;

  @doc("Gets or sets the secondary connection string.")
  atlasKafkaSecondaryEndpoint?: string;
}

@doc("Collection administrator update.")
model CollectionAdminUpdate {
  @doc("Gets or sets the object identifier of the admin.")
  objectId?: string;
}

@doc("Payload to get and set the default account in the given scope")
model DefaultAccountPayload {
  @doc("The name of the account that is set as the default.")
  accountName?: string;

  @doc("The resource group name of the account that is set as the default.")
  resourceGroupName?: string;

  @doc("The scope object ID. For example, sub ID or tenant ID.")
  scope?: string;

  @doc("The scope tenant in which the default account is set.")
  scopeTenantId?: string;

  @doc("The scope where the default account is set.")
  scopeType?: ScopeType;

  @doc("The subscription ID of the account that is set as the default.")
  subscriptionId?: string;
}

@doc("Paged list of operation resources")
model OperationList is Azure.Core.Page<Operation> {
  @doc("Total item count.")
  count?: int32;
}

@doc("properties on meta info")
model OperationProperties {
  @doc("meta service specification")
  serviceSpecification?: OperationMetaServiceSpecification;
}

@doc("The operation meta service specification")
model OperationMetaServiceSpecification {
  @doc("log specifications for the operation")
  logSpecifications?: OperationMetaLogSpecification[];

  @doc("metric specifications for the operation")
  metricSpecifications?: OperationMetaMetricSpecification[];
}

@doc("log specifications for operation api")
model OperationMetaLogSpecification {
  @doc("blob duration of the log")
  blobDuration?: string;

  @doc("localized name of the log category")
  displayName?: string;

  @doc("name of the log category")
  name?: string;
}

@doc("metric specifications for the operation")
model OperationMetaMetricSpecification {
  @doc("aggregation type of metric")
  aggregationType?: string;

  @doc("properties for dimension")
  dimensions?: DimensionProperties[];

  @doc("description of the metric")
  displayDescription?: string;

  @doc("localized name of the metric")
  displayName?: string;

  @doc("enable regional mdm account")
  enableRegionalMdmAccount?: string;

  @doc("internal metric name")
  internalMetricName?: string;

  @doc("name of the metric")
  name?: string;

  @doc("dimension name use to replace resource id if specified")
  resourceIdDimensionNameOverride?: string;

  @doc("""
Metric namespace.
Only set the namespace if different from the default value, 
leaving it empty makes it use the value from the ARM manifest.
""")
  sourceMdmNamespace?: string;

  @doc("supported aggregation types")
  supportedAggregationTypes?: string[];

  @doc("supported time grain types")
  supportedTimeGrainTypes?: string[];

  @doc("units for the metric")
  unit?: string;
}

@doc("properties for dimension")
model DimensionProperties {
  @doc("localized display name of the dimension to customer")
  displayName?: string;

  @doc("dimension name")
  name?: string;

  @doc("flag indicating whether this dimension should be included to the customer in Azure Monitor logs (aka Shoebox)")
  toBeExportedForCustomer?: boolean;
}

@doc("A privately linkable resource properties.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group identifier.")
  @visibility("read")
  groupId?: string;

  @doc("This translates to how many Private IPs should be created for each privately linkable resource.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The required zone names for private link resource.")
  @visibility("read")
  requiredZoneNames?: string[];
}

@doc("The request payload for CheckNameAvailability API")
model CheckNameAvailabilityRequest {
  @doc("Resource name to verify for availability")
  name?: string;

  @doc("Fully qualified resource type which includes provider namespace")
  type?: string;
}

@doc("The response payload for CheckNameAvailability API")
model CheckNameAvailabilityResult {
  @doc("Error message")
  message?: string;

  @doc("Indicates if name is valid and available.")
  nameAvailable?: boolean;

  @doc("The reason the name is not available.")
  reason?: Reason;
}
