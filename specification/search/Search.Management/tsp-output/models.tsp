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

enum PrivateLinkServiceConnectionProvisioningState {
  @doc("The private link service connection is in the process of being created along with other resources for it to be fully functional.")
  Updating,
  @doc("The private link service connection is in the process of being deleted.")
  Deleting,
  @doc("The private link service connection has failed to be provisioned or deleted.")
  Failed,
  @doc("The private link service connection has finished provisioning and is ready for approval.")
  Succeeded,
  @doc("Provisioning request for the private link service connection resource has been accepted but the process of creation has not commenced yet.")
  Incomplete,
  @doc("Provisioning request for the private link service connection resource has been canceled")
  Canceled,
}

enum SearchSemanticSearch {
  @doc("Indicates that semantic search is disabled for the search service.")
  disabled,
  @doc("Enables semantic search on a search service and indicates that it is to be used within the limits of the free tier. This would cap the volume of semantic search requests and is offered at no extra charge. This is the default for newly provisioned search services.")
  free,
  @doc("Enables semantic search on a search service as a billable feature, with higher throughput and volume of semantic search queries.")
  standard,
}

enum UnavailableNameReason {
  @doc("The search service name does not match naming requirements.") Invalid,
  @doc("The search service name is already assigned to a different search service.")
  AlreadyExists,
}

enum SharedPrivateLinkResourceAsyncOperationResult {
  Running,
  Succeeded,
  Failed,
}
@fixed
enum AdminKeyKind {
  @doc("The primary API key for the search service.") Primary: "primary",
  @doc("The secondary API key for the search service.") Secondary: "secondary",
}
@fixed
enum HostingMode {
  @doc("The limit on number of indexes is determined by the default limits for the SKU.")
  Default: "default",
  @doc("Only application for standard3 SKU, where the search service can have up to 1000 indexes.")
  HighDensity: "highDensity",
}
@fixed
enum PublicNetworkAccess {
  enabled,
  disabled,
}
@fixed
enum SearchServiceStatus {
  @doc("The search service is running and no provisioning operations are underway.")
  Running: "running",
  @doc("The search service is being provisioned or scaled up or down.")
  Provisioning: "provisioning",
  @doc("The search service is being deleted.") Deleting: "deleting",
  @doc("The search service is degraded because underlying search units are not healthy.")
  Degraded: "degraded",
  @doc("The search service is disabled and all API requests will be rejected.")
  Disabled: "disabled",
  @doc("The search service is in error state, indicating either a failure to provision or to be deleted.")
  Error: "error",
}
@fixed
enum ProvisioningState {
  @doc("The last provisioning operation has completed successfully.")
  Succeeded: "succeeded",
  @doc("The search service is being provisioned or scaled up or down.")
  Provisioning: "provisioning",
  @doc("The last provisioning operation has failed.") Failed: "failed",
}
@fixed
enum SearchEncryptionWithCmk {
  @doc("No enforcement will be made and the search service can have non customer encrypted resources.")
  Disabled,
  @doc("Search service will be marked as non-compliant if there are one or more non customer encrypted resources.")
  Enabled,
  @doc("Enforcement policy is not explicitly specified, with the behavior being the same as if it were set to 'Disabled'.")
  Unspecified,
}
@fixed
enum SearchEncryptionComplianceStatus {
  @doc("Indicates that the search service is compliant, either because number of non customer encrypted resources is zero or enforcement is disabled.")
  Compliant,
  @doc("Indicates that the search service has more than 1 non customer encrypted resources.")
  NonCompliant,
}
@fixed
enum AadAuthFailureMode {
  @doc("Indicates that requests that failed authentication should be presented with an HTTP status code of 403 (Forbidden).")
  Http403: "http403",
  @doc("Indicates that requests that failed authentication should be presented with an HTTP status code of 401 (Unauthorized) and present a Bearer Challenge.")
  Http401WithBearerChallenge: "http401WithBearerChallenge",
}
@fixed
enum PrivateLinkServiceConnectionStatus {
  @doc("The private endpoint connection has been created and is pending approval.")
  Pending,
  @doc("The private endpoint connection is approved and is ready for use.")
  Approved,
  @doc("The private endpoint connection has been rejected and cannot be used.")
  Rejected,
  @doc("The private endpoint connection has been removed from the service.")
  Disconnected,
}
@fixed
enum SharedPrivateLinkResourceStatus {
  Pending,
  Approved,
  Rejected,
  Disconnected,
}
@fixed
enum SharedPrivateLinkResourceProvisioningState {
  Updating,
  Deleting,
  Failed,
  Succeeded,
  Incomplete,
}
@fixed
enum SkuName {
  @doc("Free tier, with no SLA guarantees and a subset of features offered to paid tiers.")
  Free: "free",
  @doc("Paid tier dedicated service with up to 3 replicas.") Basic: "basic",
  @doc("Paid tier dedicated service with up to 12 partitions and 12 replicas.")
  Standard: "standard",
  @doc("Similar to 'standard', but with more capacity per search unit.")
  Standard2: "standard2",
  @doc(" The largest Standard offering with up to 12 partitions and 12 replicas (or up to 3 partitions with more indexes if you also set the hostingMode property to 'highDensity').")
  Standard3: "standard3",
  @doc("Paid tier dedicated service that supports 1TB per partition, up to 12 partitions.")
  StorageOptimizedL1: "storage_optimized_l1",
  @doc("Paid tier dedicated service that supports 2TB per partition, up to 12 partitions.")
  StorageOptimizedL2: "storage_optimized_l2",
}
@fixed
enum IdentityType {
  None,
  SystemAssigned,
}

@doc("Contains information about an API error.")
@error
model CloudError {
  @doc("Describes a particular API error with an error code and a message.")
  error?: CloudErrorBody;
}

@doc("Describes a particular API error with an error code and a message.")
model CloudErrorBody {
  @doc("An error code that describes the error condition more precisely than an HTTP status code. Can be used to programmatically handle specific error cases.")
  code?: string;

  @doc("A message that describes the error in detail and provides debugging information.")
  message?: string;

  @doc("The target of the particular error (for example, the name of the property in error).")
  target?: string;

  @doc("Contains nested errors that are related to this error.")
  details?: CloudErrorBody[];
}

@doc("Response containing the primary and secondary admin API keys for a given Azure Cognitive Search service.")
model AdminKeyResult {
  @doc("The primary admin API key of the search service.")
  @visibility("read")
  primaryKey?: string;

  @doc("The secondary admin API key of the search service.")
  @visibility("read")
  secondaryKey?: string;
}

@doc("Describes an API key for a given Azure Cognitive Search service that has permissions for query operations only.")
model QueryKey {
  @doc("The name of the query API key; may be empty.")
  @visibility("read")
  name?: string;

  @doc("The value of the query API key.")
  @visibility("read")
  key?: string;
}

@doc("Response containing the query API keys for a given Azure Cognitive Search service.")
model ListQueryKeysResult is Azure.Core.Page<QueryKey>;

@doc("Properties of the search service.")
model SearchServiceProperties {
  @doc("The number of replicas in the search service. If specified, it must be a value between 1 and 12 inclusive for standard SKUs or between 1 and 3 inclusive for basic SKU.")
  @maxValue(12)
  @minValue(1)
  replicaCount?: int32;

  @doc("The number of partitions in the search service; if specified, it can be 1, 2, 3, 4, 6, or 12. Values greater than 1 are only valid for standard SKUs. For 'standard3' services with hostingMode set to 'highDensity', the allowed values are between 1 and 3.")
  @maxValue(12)
  @minValue(1)
  partitionCount?: int32;

  @doc("Applicable only for the standard3 SKU. You can set this property to enable up to 3 high density partitions that allow up to 1000 indexes, which is much higher than the maximum indexes allowed for any other SKU. For the standard3 SKU, the value is either 'default' or 'highDensity'. For all other SKUs, this value must be 'default'.")
  hostingMode?: HostingMode;

  @doc("This value can be set to 'enabled' to avoid breaking changes on existing customer resources and templates. If set to 'disabled', traffic over public interface is not allowed, and private endpoint connections would be the exclusive access method.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The status of the search service. Possible values include: 'running': The search service is running and no provisioning operations are underway. 'provisioning': The search service is being provisioned or scaled up or down. 'deleting': The search service is being deleted. 'degraded': The search service is degraded. This can occur when the underlying search units are not healthy. The search service is most likely operational, but performance might be slow and some requests might be dropped. 'disabled': The search service is disabled. In this state, the service will reject all API requests. 'error': The search service is in an error state. If your service is in the degraded, disabled, or error states, it means the Azure Cognitive Search team is actively investigating the underlying issue. Dedicated services in these states are still chargeable based on the number of search units provisioned.")
  @visibility("read")
  status?: SearchServiceStatus;

  @doc("The details of the search service status.")
  @visibility("read")
  statusDetails?: string;

  @doc("The state of the last provisioning operation performed on the search service. Provisioning is an intermediate state that occurs while service capacity is being established. After capacity is set up, provisioningState changes to either 'succeeded' or 'failed'. Client applications can poll provisioning status (the recommended polling interval is from 30 seconds to one minute) by using the Get Search Service operation to see when an operation is completed. If you are using the free service, this value tends to come back as 'succeeded' directly in the call to Create search service. This is because the free service uses capacity that is already set up.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Network specific rules that determine how the Azure Cognitive Search service may be reached.")
  networkRuleSet?: NetworkRuleSet;

  @doc("Specifies any policy regarding encryption of resources (such as indexes) using customer manager keys within a search service.")
  encryptionWithCmk?: EncryptionWithCmk;

  @doc("When set to true, calls to the search service will not be permitted to utilize API keys for authentication. This cannot be set to true if 'dataPlaneAuthOptions' are defined.")
  disableLocalAuth?: boolean;

  @doc("Defines the options for how the data plane API of a search service authenticates requests. This cannot be set if 'disableLocalAuth' is set to true.")
  authOptions?: DataPlaneAuthOptions;

  @doc("The list of private endpoint connections to the Azure Cognitive Search service.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];

  @doc("Sets options that control the availability of semantic search. This configuration is only possible for certain Azure Cognitive Search SKUs in certain locations.")
  semanticSearch?: SearchSemanticSearch;

  @doc("The list of shared private link resources managed by the Azure Cognitive Search service.")
  @visibility("read")
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];
}

@doc("Network specific rules that determine how the Azure Cognitive Search service may be reached.")
model NetworkRuleSet {
  @doc("A list of IP restriction rules that defines the inbound network(s) with allowing access to the search service endpoint. At the meantime, all other public IP networks are blocked by the firewall. These restriction rules are applied only when the 'publicNetworkAccess' of the search service is 'enabled'; otherwise, traffic over public interface is not allowed even with any public IP rules, and private endpoint connections would be the exclusive access method.")
  ipRules?: IpRule[];
}

@doc("The IP restriction rule of the Azure Cognitive Search service.")
model IpRule {
  @doc("Value corresponding to a single IPv4 address (eg., 123.1.2.3) or an IP range in CIDR format (eg., 123.1.2.3/24) to be allowed.")
  value?: string;
}

@doc("Describes a policy that determines how resources within the search service are to be encrypted with Customer Managed Keys.")
model EncryptionWithCmk {
  @doc("Describes how a search service should enforce having one or more non customer encrypted resources.")
  enforcement?: SearchEncryptionWithCmk;

  @doc("Describes whether the search service is compliant or not with respect to having non customer encrypted resources. If a service has more than one non customer encrypted resource and 'Enforcement' is 'enabled' then the service will be marked as 'nonCompliant'.")
  @visibility("read")
  encryptionComplianceStatus?: SearchEncryptionComplianceStatus;
}

@doc("Defines the options for how the data plane API of a Search service authenticates requests. This cannot be set if 'disableLocalAuth' is set to true.")
model DataPlaneAuthOptions {
  @doc("Indicates that only the API key needs to be used for authentication.")
  apiKeyOnly?: Record<unknown>;

  @doc("Indicates that either the API key or an access token from Azure Active Directory can be used for authentication.")
  aadOrApiKey?: DataPlaneAadOrApiKeyAuthOption;
}

@doc("Indicates that either the API key or an access token from Azure Active Directory can be used for authentication.")
model DataPlaneAadOrApiKeyAuthOption {
  @doc("Describes what response the data plane API of a Search service would send for requests that failed authentication.")
  aadAuthFailureMode?: AadAuthFailureMode;
}

@doc("Describes the properties of an existing Private Endpoint connection to the Azure Cognitive Search service.")
model PrivateEndpointConnectionProperties {
  @doc("The private endpoint resource from Microsoft.Network provider.")
  privateEndpoint?: PrivateEndpointConnectionPropertiesPrivateEndpoint;

  @doc("Describes the current state of an existing Private Link Service connection to the Azure Private Endpoint.")
  privateLinkServiceConnectionState?: PrivateEndpointConnectionPropertiesPrivateLinkServiceConnectionState;

  @doc("The group id from the provider of resource the private link service connection is for.")
  groupId?: string;

  @doc("The provisioning state of the private link service connection. Can be Updating, Deleting, Failed, Succeeded, or Incomplete")
  provisioningState?: PrivateLinkServiceConnectionProvisioningState;
}

@doc("The private endpoint resource from Microsoft.Network provider.")
model PrivateEndpointConnectionPropertiesPrivateEndpoint {
  @doc("The resource id of the private endpoint resource from Microsoft.Network provider.")
  id?: string;
}

@doc("Describes the current state of an existing Private Link Service connection to the Azure Private Endpoint.")
model PrivateEndpointConnectionPropertiesPrivateLinkServiceConnectionState {
  @doc("Status of the the private link service connection. Can be Pending, Approved, Rejected, or Disconnected.")
  status?: PrivateLinkServiceConnectionStatus;

  @doc("The description for the private link service connection state.")
  description?: string;

  @doc("A description of any extra actions that may be required.")
  actionsRequired?: string;
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
}

@doc("Describes the properties of an existing Shared Private Link Resource managed by the Azure Cognitive Search service.")
model SharedPrivateLinkResourceProperties {
  @doc("The resource id of the resource the shared private link resource is for.")
  privateLinkResourceId?: string;

  @doc("The group id from the provider of resource the shared private link resource is for.")
  groupId?: string;

  @doc("The request message for requesting approval of the shared private link resource.")
  requestMessage?: string;

  @doc("Optional. Can be used to specify the Azure Resource Manager location of the resource to which a shared private link is to be created. This is only required for those resources whose DNS configuration are regional (such as Azure Kubernetes Service).")
  resourceRegion?: string;

  @doc("Status of the shared private link resource. Can be Pending, Approved, Rejected or Disconnected.")
  status?: SharedPrivateLinkResourceStatus;

  @doc("The provisioning state of the shared private link resource. Can be Updating, Deleting, Failed, Succeeded or Incomplete.")
  provisioningState?: SharedPrivateLinkResourceProvisioningState;
}

@doc("Defines the SKU of an Azure Cognitive Search Service, which determines price tier and capacity limits.")
model Sku {
  @doc("The SKU of the search service. Valid values include: 'free': Shared service. 'basic': Dedicated service with up to 3 replicas. 'standard': Dedicated service with up to 12 partitions and 12 replicas. 'standard2': Similar to standard, but with more capacity per search unit. 'standard3': The largest Standard offering with up to 12 partitions and 12 replicas (or up to 3 partitions with more indexes if you also set the hostingMode property to 'highDensity'). 'storage_optimized_l1': Supports 1TB per partition, up to 12 partitions. 'storage_optimized_l2': Supports 2TB per partition, up to 12 partitions.'")
  name?: SkuName;
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of the system-assigned identity of the search service.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of the system-assigned identity of the search service.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type: IdentityType;
}

@doc("The parameters used to update an Azure Cognitive Search service.")
model SearchServiceUpdate extends Resource {
  @doc("Properties of the search service.")
  properties?: SearchServiceProperties;

  @doc("The SKU of the Search Service, which determines price tier and capacity limits. This property is required when creating a new Search Service.")
  sku?: Sku;

  @doc("The geographic location of the resource. This must be one of the supported and registered Azure Geo Regions (for example, West US, East US, Southeast Asia, and so forth). This property is required when creating a new resource.")
  @visibility("read", "create")
  location?: string;

  @doc("Tags to help categorize the resource in the Azure portal.")
  tags?: Record<string>;

  @doc("The identity of the resource.")
  identity?: Identity;
}

@doc("Response containing a list of supported Private Link Resources.")
@pagedResult
model PrivateLinkResourcesResult {
  @doc("The list of supported Private Link Resources.")
  @visibility("read")
  @items
  value?: PrivateLinkResource[];
}

@doc("Describes a supported private link resource for the Azure Cognitive Search service.")
model PrivateLinkResource extends Resource {
  @doc("Describes the properties of a supported private link resource for the Azure Cognitive Search service.")
  @visibility("read")
  properties?: PrivateLinkResourceProperties;
}

@doc("Describes the properties of a supported private link resource for the Azure Cognitive Search service. For a given API version, this represents the 'supported' groupIds when creating a shared private link resource.")
model PrivateLinkResourceProperties {
  @doc("The group ID of the private link resource.")
  @visibility("read")
  groupId?: string;

  @doc("The list of required members of the private link resource.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The list of required DNS zone names of the private link resource.")
  @visibility("read")
  requiredZoneNames?: string[];

  @doc("The list of resources that are onboarded to private link service, that are supported by Azure Cognitive Search.")
  @visibility("read")
  shareablePrivateLinkResourceTypes?: ShareablePrivateLinkResourceType[];
}

@doc("Describes an resource type that has been onboarded to private link service, supported by Azure Cognitive Search.")
model ShareablePrivateLinkResourceType {
  @doc("The name of the resource type that has been onboarded to private link service, supported by Azure Cognitive Search.")
  @visibility("read")
  name?: string;

  @doc("Describes the properties of a resource type that has been onboarded to private link service, supported by Azure Cognitive Search.")
  @visibility("read")
  properties?: ShareablePrivateLinkResourceProperties;
}

@doc("Describes the properties of a resource type that has been onboarded to private link service, supported by Azure Cognitive Search.")
model ShareablePrivateLinkResourceProperties {
  @doc("The resource provider type for the resource that has been onboarded to private link service, supported by Azure Cognitive Search.")
  @visibility("read")
  type?: string;

  @doc("The resource provider group id for the resource that has been onboarded to private link service, supported by Azure Cognitive Search.")
  @visibility("read")
  groupId?: string;

  @doc("The description of the resource type that has been onboarded to private link service, supported by Azure Cognitive Search.")
  @visibility("read")
  description?: string;
}

@doc("Input of check name availability API.")
model CheckNameAvailabilityInput {
  @doc("The search service name to validate. Search service names must only contain lowercase letters, digits or dashes, cannot use dash as the first two or last one characters, cannot contain consecutive dashes, and must be between 2 and 60 characters in length.")
  name: string;

  @doc("The type of the resource whose name is to be validated. This value must always be 'searchServices'.")
  type: "searchServices";
}

@doc("Output of check name availability API.")
model CheckNameAvailabilityOutput {
  @doc("A value indicating whether the name is available.")
  @visibility("read")
  @projectedName("json", "nameAvailable")
  IsNameAvailable?: boolean;

  @doc("The reason why the name is not available. 'Invalid' indicates the name provided does not match the naming requirements (incorrect length, unsupported characters, etc.). 'AlreadyExists' indicates that the name is already in use and is therefore unavailable.")
  @visibility("read")
  reason?: UnavailableNameReason;

  @doc("A message that explains why the name is invalid and provides resource naming requirements. Available only if 'Invalid' is returned in the 'reason' property.")
  @visibility("read")
  message?: string;
}

@doc("Response containing the quota usage information for all the supported skus of Azure Cognitive Search service.")
model QuotaUsagesListResult is Azure.Core.Page<QuotaUsageResult>;

@doc("Describes the quota usage for a particular sku supported by Azure Cognitive Search.")
model QuotaUsageResult {
  @doc("The resource id of the quota usage sku endpoint for Microsoft.Search provider.")
  id?: string;

  @doc("The unit of measurement for the search sku.")
  unit?: string;

  @doc("The currently used up value for the particular search sku.")
  currentValue?: int32;

  @doc("The quota limit for the particular search sku.")
  limit?: int32;

  @doc("The name of the sku supported by Azure Cognitive Search.")
  @visibility("read")
  name?: QuotaUsageResultName;
}

@doc("The name of the sku supported by Azure Cognitive Search.")
model QuotaUsageResultName {
  @doc("The sku name supported by Azure Cognitive Search.")
  value?: string;

  @doc("The localized string value for the sku supported by Azure Cognitive Search.")
  localizedValue?: string;
}

@doc("The details of a long running asynchronous shared private link resource operation")
model AsyncOperationResult {
  @doc("The current status of the long running asynchronous shared private link resource operation.")
  status?: SharedPrivateLinkResourceAsyncOperationResult;
}
