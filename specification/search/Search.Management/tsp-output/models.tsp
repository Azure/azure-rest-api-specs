import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Search;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state of the private link service connection. Can be Updating, Deleting, Failed, Succeeded, or Incomplete
 */
enum PrivateLinkServiceConnectionProvisioningState {
  /**
   * The private link service connection is in the process of being created along with other resources for it to be fully functional.
   */
  Updating,

  /**
   * The private link service connection is in the process of being deleted.
   */
  Deleting,

  /**
   * The private link service connection has failed to be provisioned or deleted.
   */
  Failed,

  /**
   * The private link service connection has finished provisioning and is ready for approval.
   */
  Succeeded,

  /**
   * Provisioning request for the private link service connection resource has been accepted but the process of creation has not commenced yet.
   */
  Incomplete,

  /**
   * Provisioning request for the private link service connection resource has been canceled
   */
  Canceled,
}

/**
 * Sets options that control the availability of semantic search. This configuration is only possible for certain Azure Cognitive Search SKUs in certain locations.
 */
enum SearchSemanticSearch {
  /**
   * Indicates that semantic search is disabled for the search service.
   */
  disabled,

  /**
   * Enables semantic search on a search service and indicates that it is to be used within the limits of the free tier. This would cap the volume of semantic search requests and is offered at no extra charge. This is the default for newly provisioned search services.
   */
  free,

  /**
   * Enables semantic search on a search service as a billable feature, with higher throughput and volume of semantic search queries.
   */
  standard,
}

/**
 * The reason why the name is not available. 'Invalid' indicates the name provided does not match the naming requirements (incorrect length, unsupported characters, etc.). 'AlreadyExists' indicates that the name is already in use and is therefore unavailable.
 */
enum UnavailableNameReason {
  /**
   * The search service name does not match naming requirements.
   */
  Invalid,

  /**
   * The search service name is already assigned to a different search service.
   */
  AlreadyExists,
}

/**
 * The current status of the long running asynchronous shared private link resource operation.
 */
enum SharedPrivateLinkResourceAsyncOperationResult {
  Running,
  Succeeded,
  Failed,
}

@fixed
enum AdminKeyKind {
  /**
   * The primary API key for the search service.
   */
  Primary: "primary",

  /**
   * The secondary API key for the search service.
   */
  Secondary: "secondary",
}

/**
 * Applicable only for the standard3 SKU. You can set this property to enable up to 3 high density partitions that allow up to 1000 indexes, which is much higher than the maximum indexes allowed for any other SKU. For the standard3 SKU, the value is either 'default' or 'highDensity'. For all other SKUs, this value must be 'default'.
 */
@fixed
enum HostingMode {
  /**
   * The limit on number of indexes is determined by the default limits for the SKU.
   */
  Default: "default",

  /**
   * Only application for standard3 SKU, where the search service can have up to 1000 indexes.
   */
  HighDensity: "highDensity",
}

/**
 * This value can be set to 'enabled' to avoid breaking changes on existing customer resources and templates. If set to 'disabled', traffic over public interface is not allowed, and private endpoint connections would be the exclusive access method.
 */
@fixed
enum PublicNetworkAccess {
  enabled,
  disabled,
}

/**
 * The status of the search service. Possible values include: 'running': The search service is running and no provisioning operations are underway. 'provisioning': The search service is being provisioned or scaled up or down. 'deleting': The search service is being deleted. 'degraded': The search service is degraded. This can occur when the underlying search units are not healthy. The search service is most likely operational, but performance might be slow and some requests might be dropped. 'disabled': The search service is disabled. In this state, the service will reject all API requests. 'error': The search service is in an error state. If your service is in the degraded, disabled, or error states, it means the Azure Cognitive Search team is actively investigating the underlying issue. Dedicated services in these states are still chargeable based on the number of search units provisioned.
 */
@fixed
enum SearchServiceStatus {
  /**
   * The search service is running and no provisioning operations are underway.
   */
  Running: "running",

  /**
   * The search service is being provisioned or scaled up or down.
   */
  Provisioning: "provisioning",

  /**
   * The search service is being deleted.
   */
  Deleting: "deleting",

  /**
   * The search service is degraded because underlying search units are not healthy.
   */
  Degraded: "degraded",

  /**
   * The search service is disabled and all API requests will be rejected.
   */
  Disabled: "disabled",

  /**
   * The search service is in error state, indicating either a failure to provision or to be deleted.
   */
  Error: "error",
}

/**
 * The state of the last provisioning operation performed on the search service. Provisioning is an intermediate state that occurs while service capacity is being established. After capacity is set up, provisioningState changes to either 'succeeded' or 'failed'. Client applications can poll provisioning status (the recommended polling interval is from 30 seconds to one minute) by using the Get Search Service operation to see when an operation is completed. If you are using the free service, this value tends to come back as 'succeeded' directly in the call to Create search service. This is because the free service uses capacity that is already set up.
 */
@fixed
enum ProvisioningState {
  /**
   * The last provisioning operation has completed successfully.
   */
  Succeeded: "succeeded",

  /**
   * The search service is being provisioned or scaled up or down.
   */
  Provisioning: "provisioning",

  /**
   * The last provisioning operation has failed.
   */
  Failed: "failed",
}

/**
 * Describes how a search service should enforce having one or more non customer encrypted resources.
 */
@fixed
enum SearchEncryptionWithCmk {
  /**
   * No enforcement will be made and the search service can have non customer encrypted resources.
   */
  Disabled,

  /**
   * Search service will be marked as non-compliant if there are one or more non customer encrypted resources.
   */
  Enabled,

  /**
   * Enforcement policy is not explicitly specified, with the behavior being the same as if it were set to 'Disabled'.
   */
  Unspecified,
}

/**
 * Describes whether the search service is compliant or not with respect to having non customer encrypted resources. If a service has more than one non customer encrypted resource and 'Enforcement' is 'enabled' then the service will be marked as 'nonCompliant'.
 */
@fixed
enum SearchEncryptionComplianceStatus {
  /**
   * Indicates that the search service is compliant, either because number of non customer encrypted resources is zero or enforcement is disabled.
   */
  Compliant,

  /**
   * Indicates that the search service has more than 1 non customer encrypted resources.
   */
  NonCompliant,
}

/**
 * Describes what response the data plane API of a Search service would send for requests that failed authentication.
 */
@fixed
enum AadAuthFailureMode {
  /**
   * Indicates that requests that failed authentication should be presented with an HTTP status code of 403 (Forbidden).
   */
  Http403: "http403",

  /**
   * Indicates that requests that failed authentication should be presented with an HTTP status code of 401 (Unauthorized) and present a Bearer Challenge.
   */
  Http401WithBearerChallenge: "http401WithBearerChallenge",
}

/**
 * Status of the the private link service connection. Can be Pending, Approved, Rejected, or Disconnected.
 */
@fixed
enum PrivateLinkServiceConnectionStatus {
  /**
   * The private endpoint connection has been created and is pending approval.
   */
  Pending,

  /**
   * The private endpoint connection is approved and is ready for use.
   */
  Approved,

  /**
   * The private endpoint connection has been rejected and cannot be used.
   */
  Rejected,

  /**
   * The private endpoint connection has been removed from the service.
   */
  Disconnected,
}

/**
 * Status of the shared private link resource. Can be Pending, Approved, Rejected or Disconnected.
 */
@fixed
enum SharedPrivateLinkResourceStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}

/**
 * The provisioning state of the shared private link resource. Can be Updating, Deleting, Failed, Succeeded or Incomplete.
 */
@fixed
enum SharedPrivateLinkResourceProvisioningState {
  Updating,
  Deleting,
  Failed,
  Succeeded,
  Incomplete,
}

/**
 * The SKU of the search service. Valid values include: 'free': Shared service. 'basic': Dedicated service with up to 3 replicas. 'standard': Dedicated service with up to 12 partitions and 12 replicas. 'standard2': Similar to standard, but with more capacity per search unit. 'standard3': The largest Standard offering with up to 12 partitions and 12 replicas (or up to 3 partitions with more indexes if you also set the hostingMode property to 'highDensity'). 'storage_optimized_l1': Supports 1TB per partition, up to 12 partitions. 'storage_optimized_l2': Supports 2TB per partition, up to 12 partitions.'
 */
@fixed
enum SkuName {
  /**
   * Free tier, with no SLA guarantees and a subset of features offered to paid tiers.
   */
  Free: "free",

  /**
   * Paid tier dedicated service with up to 3 replicas.
   */
  Basic: "basic",

  /**
   * Paid tier dedicated service with up to 12 partitions and 12 replicas.
   */
  Standard: "standard",

  /**
   * Similar to 'standard', but with more capacity per search unit.
   */
  Standard2: "standard2",

  /**
   *  The largest Standard offering with up to 12 partitions and 12 replicas (or up to 3 partitions with more indexes if you also set the hostingMode property to 'highDensity').
   */
  Standard3: "standard3",

  /**
   * Paid tier dedicated service that supports 1TB per partition, up to 12 partitions.
   */
  StorageOptimizedL1: "storage_optimized_l1",

  /**
   * Paid tier dedicated service that supports 2TB per partition, up to 12 partitions.
   */
  StorageOptimizedL2: "storage_optimized_l2",
}

/**
 * The identity type.
 */
@fixed
enum IdentityType {
  None,
  SystemAssigned,
}

/**
 * Contains information about an API error.
 */
@error
model CloudError {
  /**
   * Describes a particular API error with an error code and a message.
   */
  error?: CloudErrorBody;
}

/**
 * Describes a particular API error with an error code and a message.
 */
model CloudErrorBody {
  /**
   * An error code that describes the error condition more precisely than an HTTP status code. Can be used to programmatically handle specific error cases.
   */
  code?: string;

  /**
   * A message that describes the error in detail and provides debugging information.
   */
  message?: string;

  /**
   * The target of the particular error (for example, the name of the property in error).
   */
  target?: string;

  /**
   * Contains nested errors that are related to this error.
   */
  details?: CloudErrorBody[];
}

/**
 * Response containing the primary and secondary admin API keys for a given Azure Cognitive Search service.
 */
model AdminKeyResult {
  /**
   * The primary admin API key of the search service.
   */
  @visibility("read")
  primaryKey?: string;

  /**
   * The secondary admin API key of the search service.
   */
  @visibility("read")
  secondaryKey?: string;
}

/**
 * Describes an API key for a given Azure Cognitive Search service that has permissions for query operations only.
 */
model QueryKey {
  /**
   * The name of the query API key; may be empty.
   */
  @visibility("read")
  name?: string;

  /**
   * The value of the query API key.
   */
  @visibility("read")
  key?: string;
}

/**
 * Response containing the query API keys for a given Azure Cognitive Search service.
 */
model ListQueryKeysResult is Azure.Core.Page<QueryKey>;

/**
 * Properties of the search service.
 */
model SearchServiceProperties {
  /**
   * The number of replicas in the search service. If specified, it must be a value between 1 and 12 inclusive for standard SKUs or between 1 and 3 inclusive for basic SKU.
   */
  @maxValue(12)
  @minValue(1)
  replicaCount?: int32 = 1;

  /**
   * The number of partitions in the search service; if specified, it can be 1, 2, 3, 4, 6, or 12. Values greater than 1 are only valid for standard SKUs. For 'standard3' services with hostingMode set to 'highDensity', the allowed values are between 1 and 3.
   */
  @maxValue(12)
  @minValue(1)
  partitionCount?: int32 = 1;

  /**
   * Applicable only for the standard3 SKU. You can set this property to enable up to 3 high density partitions that allow up to 1000 indexes, which is much higher than the maximum indexes allowed for any other SKU. For the standard3 SKU, the value is either 'default' or 'highDensity'. For all other SKUs, this value must be 'default'.
   */
  hostingMode?: HostingMode = HostingMode.default;

  /**
   * This value can be set to 'enabled' to avoid breaking changes on existing customer resources and templates. If set to 'disabled', traffic over public interface is not allowed, and private endpoint connections would be the exclusive access method.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.enabled;

  /**
   * The status of the search service. Possible values include: 'running': The search service is running and no provisioning operations are underway. 'provisioning': The search service is being provisioned or scaled up or down. 'deleting': The search service is being deleted. 'degraded': The search service is degraded. This can occur when the underlying search units are not healthy. The search service is most likely operational, but performance might be slow and some requests might be dropped. 'disabled': The search service is disabled. In this state, the service will reject all API requests. 'error': The search service is in an error state. If your service is in the degraded, disabled, or error states, it means the Azure Cognitive Search team is actively investigating the underlying issue. Dedicated services in these states are still chargeable based on the number of search units provisioned.
   */
  @visibility("read")
  status?: SearchServiceStatus;

  /**
   * The details of the search service status.
   */
  @visibility("read")
  statusDetails?: string;

  /**
   * The state of the last provisioning operation performed on the search service. Provisioning is an intermediate state that occurs while service capacity is being established. After capacity is set up, provisioningState changes to either 'succeeded' or 'failed'. Client applications can poll provisioning status (the recommended polling interval is from 30 seconds to one minute) by using the Get Search Service operation to see when an operation is completed. If you are using the free service, this value tends to come back as 'succeeded' directly in the call to Create search service. This is because the free service uses capacity that is already set up.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Network specific rules that determine how the Azure Cognitive Search service may be reached.
   */
  networkRuleSet?: NetworkRuleSet;

  /**
   * Specifies any policy regarding encryption of resources (such as indexes) using customer manager keys within a search service.
   */
  encryptionWithCmk?: EncryptionWithCmk;

  /**
   * When set to true, calls to the search service will not be permitted to utilize API keys for authentication. This cannot be set to true if 'dataPlaneAuthOptions' are defined.
   */
  disableLocalAuth?: boolean;

  /**
   * Defines the options for how the data plane API of a search service authenticates requests. This cannot be set if 'disableLocalAuth' is set to true.
   */
  authOptions?: DataPlaneAuthOptions;

  /**
   * The list of private endpoint connections to the Azure Cognitive Search service.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Sets options that control the availability of semantic search. This configuration is only possible for certain Azure Cognitive Search SKUs in certain locations.
   */
  semanticSearch?: SearchSemanticSearch;

  /**
   * The list of shared private link resources managed by the Azure Cognitive Search service.
   */
  @visibility("read")
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];
}

/**
 * Network specific rules that determine how the Azure Cognitive Search service may be reached.
 */
model NetworkRuleSet {
  /**
   * A list of IP restriction rules that defines the inbound network(s) with allowing access to the search service endpoint. At the meantime, all other public IP networks are blocked by the firewall. These restriction rules are applied only when the 'publicNetworkAccess' of the search service is 'enabled'; otherwise, traffic over public interface is not allowed even with any public IP rules, and private endpoint connections would be the exclusive access method.
   */
  ipRules?: IpRule[];
}

/**
 * The IP restriction rule of the Azure Cognitive Search service.
 */
model IpRule {
  /**
   * Value corresponding to a single IPv4 address (eg., 123.1.2.3) or an IP range in CIDR format (eg., 123.1.2.3/24) to be allowed.
   */
  value?: string;
}

/**
 * Describes a policy that determines how resources within the search service are to be encrypted with Customer Managed Keys.
 */
model EncryptionWithCmk {
  /**
   * Describes how a search service should enforce having one or more non customer encrypted resources.
   */
  enforcement?: SearchEncryptionWithCmk;

  /**
   * Describes whether the search service is compliant or not with respect to having non customer encrypted resources. If a service has more than one non customer encrypted resource and 'Enforcement' is 'enabled' then the service will be marked as 'nonCompliant'.
   */
  @visibility("read")
  encryptionComplianceStatus?: SearchEncryptionComplianceStatus;
}

/**
 * Defines the options for how the data plane API of a Search service authenticates requests. This cannot be set if 'disableLocalAuth' is set to true.
 */
model DataPlaneAuthOptions {
  /**
   * Indicates that only the API key needs to be used for authentication.
   */
  apiKeyOnly?: Record<unknown>;

  /**
   * Indicates that either the API key or an access token from Azure Active Directory can be used for authentication.
   */
  aadOrApiKey?: DataPlaneAadOrApiKeyAuthOption;
}

/**
 * Indicates that either the API key or an access token from Azure Active Directory can be used for authentication.
 */
model DataPlaneAadOrApiKeyAuthOption {
  /**
   * Describes what response the data plane API of a Search service would send for requests that failed authentication.
   */
  aadAuthFailureMode?: AadAuthFailureMode;
}

/**
 * Describes the properties of an existing Private Endpoint connection to the Azure Cognitive Search service.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint resource from Microsoft.Network provider.
   */
  privateEndpoint?: PrivateEndpointConnectionPropertiesPrivateEndpoint;

  /**
   * Describes the current state of an existing Private Link Service connection to the Azure Private Endpoint.
   */
  privateLinkServiceConnectionState?: PrivateEndpointConnectionPropertiesPrivateLinkServiceConnectionState;

  /**
   * The group id from the provider of resource the private link service connection is for.
   */
  groupId?: string;

  /**
   * The provisioning state of the private link service connection. Can be Updating, Deleting, Failed, Succeeded, or Incomplete
   */
  provisioningState?: PrivateLinkServiceConnectionProvisioningState;
}

/**
 * The private endpoint resource from Microsoft.Network provider.
 */
model PrivateEndpointConnectionPropertiesPrivateEndpoint {
  /**
   * The resource id of the private endpoint resource from Microsoft.Network provider.
   */
  id?: string;
}

/**
 * Describes the current state of an existing Private Link Service connection to the Azure Private Endpoint.
 */
model PrivateEndpointConnectionPropertiesPrivateLinkServiceConnectionState {
  /**
   * Status of the the private link service connection. Can be Pending, Approved, Rejected, or Disconnected.
   */
  status?: PrivateLinkServiceConnectionStatus;

  /**
   * The description for the private link service connection state.
   */
  description?: string;

  /**
   * A description of any extra actions that may be required.
   */
  actionsRequired?: string = "None";
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
}

/**
 * Describes the properties of an existing Shared Private Link Resource managed by the Azure Cognitive Search service.
 */
model SharedPrivateLinkResourceProperties {
  /**
   * The resource id of the resource the shared private link resource is for.
   */
  privateLinkResourceId?: string;

  /**
   * The group id from the provider of resource the shared private link resource is for.
   */
  groupId?: string;

  /**
   * The request message for requesting approval of the shared private link resource.
   */
  requestMessage?: string;

  /**
   * Optional. Can be used to specify the Azure Resource Manager location of the resource to which a shared private link is to be created. This is only required for those resources whose DNS configuration are regional (such as Azure Kubernetes Service).
   */
  resourceRegion?: string;

  /**
   * Status of the shared private link resource. Can be Pending, Approved, Rejected or Disconnected.
   */
  status?: SharedPrivateLinkResourceStatus;

  /**
   * The provisioning state of the shared private link resource. Can be Updating, Deleting, Failed, Succeeded or Incomplete.
   */
  provisioningState?: SharedPrivateLinkResourceProvisioningState;
}

/**
 * Defines the SKU of an Azure Cognitive Search Service, which determines price tier and capacity limits.
 */
model Sku {
  /**
   * The SKU of the search service. Valid values include: 'free': Shared service. 'basic': Dedicated service with up to 3 replicas. 'standard': Dedicated service with up to 12 partitions and 12 replicas. 'standard2': Similar to standard, but with more capacity per search unit. 'standard3': The largest Standard offering with up to 12 partitions and 12 replicas (or up to 3 partitions with more indexes if you also set the hostingMode property to 'highDensity'). 'storage_optimized_l1': Supports 1TB per partition, up to 12 partitions. 'storage_optimized_l2': Supports 2TB per partition, up to 12 partitions.'
   */
  name?: SkuName;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of the system-assigned identity of the search service.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of the system-assigned identity of the search service.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type: IdentityType;
}

/**
 * The parameters used to update an Azure Cognitive Search service.
 */
model SearchServiceUpdate extends Resource {
  /**
   * Properties of the search service.
   */
  properties?: SearchServiceProperties;

  /**
   * The SKU of the Search Service, which determines price tier and capacity limits. This property is required when creating a new Search Service.
   */
  sku?: Sku;

  /**
   * The geographic location of the resource. This must be one of the supported and registered Azure Geo Regions (for example, West US, East US, Southeast Asia, and so forth). This property is required when creating a new resource.
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Tags to help categorize the resource in the Azure portal.
   */
  tags?: Record<string>;

  /**
   * The identity of the resource.
   */
  identity?: Identity;
}

/**
 * Response containing a list of supported Private Link Resources.
 */
@pagedResult
model PrivateLinkResourcesResult {
  /**
   * The list of supported Private Link Resources.
   */
  @visibility("read")
  @items
  value?: PrivateLinkResource[];
}

/**
 * Describes a supported private link resource for the Azure Cognitive Search service.
 */
model PrivateLinkResource extends Resource {
  /**
   * Describes the properties of a supported private link resource for the Azure Cognitive Search service.
   */
  @visibility("read")
  properties?: PrivateLinkResourceProperties;
}

/**
 * Describes the properties of a supported private link resource for the Azure Cognitive Search service. For a given API version, this represents the 'supported' groupIds when creating a shared private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The group ID of the private link resource.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The list of required members of the private link resource.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The list of required DNS zone names of the private link resource.
   */
  @visibility("read")
  requiredZoneNames?: string[];

  /**
   * The list of resources that are onboarded to private link service, that are supported by Azure Cognitive Search.
   */
  @visibility("read")
  shareablePrivateLinkResourceTypes?: ShareablePrivateLinkResourceType[];
}

/**
 * Describes an resource type that has been onboarded to private link service, supported by Azure Cognitive Search.
 */
model ShareablePrivateLinkResourceType {
  /**
   * The name of the resource type that has been onboarded to private link service, supported by Azure Cognitive Search.
   */
  @visibility("read")
  name?: string;

  /**
   * Describes the properties of a resource type that has been onboarded to private link service, supported by Azure Cognitive Search.
   */
  @visibility("read")
  properties?: ShareablePrivateLinkResourceProperties;
}

/**
 * Describes the properties of a resource type that has been onboarded to private link service, supported by Azure Cognitive Search.
 */
model ShareablePrivateLinkResourceProperties {
  /**
   * The resource provider type for the resource that has been onboarded to private link service, supported by Azure Cognitive Search.
   */
  @visibility("read")
  type?: string;

  /**
   * The resource provider group id for the resource that has been onboarded to private link service, supported by Azure Cognitive Search.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The description of the resource type that has been onboarded to private link service, supported by Azure Cognitive Search.
   */
  @visibility("read")
  description?: string;
}

/**
 * Input of check name availability API.
 */
model CheckNameAvailabilityInput {
  /**
   * The search service name to validate. Search service names must only contain lowercase letters, digits or dashes, cannot use dash as the first two or last one characters, cannot contain consecutive dashes, and must be between 2 and 60 characters in length.
   */
  name: string;

  /**
   * The type of the resource whose name is to be validated. This value must always be 'searchServices'.
   */
  type: "searchServices";
}

/**
 * Output of check name availability API.
 */
model CheckNameAvailabilityOutput {
  /**
   * A value indicating whether the name is available.
   */
  @visibility("read")
  @projectedName("json", "nameAvailable")
  IsNameAvailable?: boolean;

  /**
   * The reason why the name is not available. 'Invalid' indicates the name provided does not match the naming requirements (incorrect length, unsupported characters, etc.). 'AlreadyExists' indicates that the name is already in use and is therefore unavailable.
   */
  @visibility("read")
  reason?: UnavailableNameReason;

  /**
   * A message that explains why the name is invalid and provides resource naming requirements. Available only if 'Invalid' is returned in the 'reason' property.
   */
  @visibility("read")
  message?: string;
}

/**
 * Response containing the quota usage information for all the supported skus of Azure Cognitive Search service.
 */
model QuotaUsagesListResult is Azure.Core.Page<QuotaUsageResult>;

/**
 * Describes the quota usage for a particular sku supported by Azure Cognitive Search.
 */
model QuotaUsageResult {
  /**
   * The resource id of the quota usage sku endpoint for Microsoft.Search provider.
   */
  id?: string;

  /**
   * The unit of measurement for the search sku.
   */
  unit?: string;

  /**
   * The currently used up value for the particular search sku.
   */
  currentValue?: int32;

  /**
   * The quota limit for the particular search sku.
   */
  limit?: int32;

  /**
   * The name of the sku supported by Azure Cognitive Search.
   */
  @visibility("read")
  name?: QuotaUsageResultName;
}

/**
 * The name of the sku supported by Azure Cognitive Search.
 */
model QuotaUsageResultName {
  /**
   * The sku name supported by Azure Cognitive Search.
   */
  value?: string;

  /**
   * The localized string value for the sku supported by Azure Cognitive Search.
   */
  localizedValue?: string;
}

/**
 * The details of a long running asynchronous shared private link resource operation
 */
model AsyncOperationResult {
  /**
   * The current status of the long running asynchronous shared private link resource operation.
   */
  status?: SharedPrivateLinkResourceAsyncOperationResult;
}
