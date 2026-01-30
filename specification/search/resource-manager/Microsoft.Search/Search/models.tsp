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

/**
 * The intended executor of the operation; as in Resource Based Access Control (RBAC) and audit logs UX. Default value is "user,system"
 */
union Origin {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  user: "user",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  system: "system",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  `user,system`: "user,system",
}

/**
 * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
 */
union ActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Internal: "Internal",
}

/**
 * Configure this property to support the search service using either the Default Compute or Azure Confidential Compute.
 */
union ComputeType {
  string,

  /**
   * Create the service with the Default Compute.
   */
  Default: "Default",

  /**
   * Create the service with Azure Confidential Compute.
   */
  Confidential: "Confidential",
}

/**
 * This value can be set to 'Enabled' to avoid breaking changes on existing customer resources and templates. If set to 'Disabled', traffic over public interface is not allowed, and private endpoint connections would be the exclusive access method.
 */
union PublicNetworkAccess {
  string,

  /**
   * The search service is accessible from traffic originating from the public internet.
   */
  Enabled: "Enabled",

  /**
   * The search service is not accessible from traffic originating from the public internet. Access is only permitted over approved private endpoint connections.
   */
  Disabled: "Disabled",

  /**
   * The network security perimeter configuration rules allow or disallow public network access to the resource. Requires an associated network security perimeter.
   */
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * Possible origins of inbound traffic that can bypass the rules defined in the 'ipRules' section.
 */
union SearchBypass {
  string,

  /**
   * Indicates that no origin can bypass the rules defined in the 'ipRules' section. This is the default.
   */
  None: "None",

  /**
   * Indicates that requests originating from Azure trusted services can bypass the rules defined in the 'ipRules' section.
   */
  AzureServices: "AzureServices",
}

/**
 * A specific data exfiltration scenario that is disabled for the service.
 */
union SearchDataExfiltrationProtection {
  string,

  /**
   * Indicates that all data exfiltration scenarios are disabled.
   */
  BlockAll: "BlockAll",
}

/**
 * Sets options that control the availability of semantic search. This configuration is only possible for certain Azure AI Search SKUs in certain locations.
 */
union SearchSemanticSearch {
  string,

  /**
   * Indicates that semantic reranker is disabled for the search service. This is the default.
   */
  disabled: "disabled",

  /**
   * Enables semantic reranker on a search service and indicates that it is to be used within the limits of the free plan. The free plan would cap the volume of semantic ranking requests and is offered at no extra charge. This is the default for newly provisioned search services.
   */
  free: "free",

  /**
   * Enables semantic reranker on a search service as a billable feature, with higher throughput and volume of semantically reranked queries.
   */
  standard: "standard",
}

/**
 * The provisioning state of the private link service connection. Valid values are Updating, Deleting, Failed, Succeeded, Incomplete, or Canceled.
 */
union PrivateLinkServiceConnectionProvisioningState {
  string,

  /**
   * The private link service connection is in the process of being created along with other resources for it to be fully functional.
   */
  Updating: "Updating",

  /**
   * The private link service connection is in the process of being deleted.
   */
  Deleting: "Deleting",

  /**
   * The private link service connection has failed to be provisioned or deleted.
   */
  Failed: "Failed",

  /**
   * The private link service connection has finished provisioning and is ready for approval.
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning request for the private link service connection resource has been accepted but the process of creation has not commenced yet.
   */
  Incomplete: "Incomplete",

  /**
   * Provisioning request for the private link service connection resource has been canceled.
   */
  Canceled: "Canceled",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Status of the shared private link resource. Valid values are Pending, Approved, Rejected or Disconnected.
 */
union SharedPrivateLinkResourceStatus {
  string,

  /**
   * The shared private link resource has been created and is pending approval.
   */
  Pending: "Pending",

  /**
   * The shared private link resource is approved and is ready for use.
   */
  Approved: "Approved",

  /**
   * The shared private link resource has been rejected and cannot be used.
   */
  Rejected: "Rejected",

  /**
   * The shared private link resource has been removed from the service.
   */
  Disconnected: "Disconnected",
}

/**
 * The provisioning state of the shared private link resource. Valid values are Updating, Deleting, Failed, Succeeded or Incomplete.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
union SharedPrivateLinkResourceProvisioningState {
  string,

  /**
   * The shared private link resource is in the process of being created along with other resources for it to be fully functional.
   */
  Updating: "Updating",

  /**
   * The shared private link resource is in the process of being deleted.
   */
  Deleting: "Deleting",

  /**
   * The shared private link resource has failed to be provisioned or deleted.
   */
  Failed: "Failed",

  /**
   * The shared private link resource has finished provisioning and is ready for approval.
   */
  Succeeded: "Succeeded",

  /**
   * Provisioning request for the shared private link resource has been accepted but the process of creation has not commenced yet.
   */
  Incomplete: "Incomplete",
}

/**
 * Indicates if the search service has an upgrade available.
 */
union UpgradeAvailable {
  string,

  /**
   * An upgrade is currently not available for the service.
   */
  NotAvailable: "notAvailable",

  /**
   * There is an upgrade available for the service.
   */
  Available: "available",
}

/**
 * The SKU of the search service. Valid values include: 'free': Shared service. 'basic': Dedicated service with up to 3 replicas. 'standard': Dedicated service with up to 12 partitions and 12 replicas. 'standard2': Similar to standard, but with more capacity per search unit. 'standard3': The largest Standard offering with up to 12 partitions and 12 replicas (or up to 3 partitions with more indexes if you also set the hostingMode property to 'highDensity'). 'storage_optimized_l1': Supports 1TB per partition, up to 12 partitions. 'storage_optimized_l2': Supports 2TB per partition, up to 12 partitions.'
 */
union SkuName {
  string,

  /**
   * Free tier, with no SLA guarantees and a subset of the features offered on billable tiers.
   */
  Free: "free",

  /**
   * Billable tier for a dedicated service having up to 3 replicas.
   */
  Basic: "basic",

  /**
   * Billable tier for a dedicated service having up to 12 partitions and 12 replicas.
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
   * Billable tier for a dedicated service that supports 1TB per partition, up to 12 partitions.
   */
  StorageOptimizedL1: "storage_optimized_l1",

  /**
   * Billable tier for a dedicated service that supports 2TB per partition, up to 12 partitions.
   */
  StorageOptimizedL2: "storage_optimized_l2",
}

/**
 * The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an identity created by the system and a set of user assigned identities. The type 'None' will remove all identities from the service.
 */
union IdentityType {
  string,

  /**
   * Indicates that any identity associated with the search service needs to be removed.
   */
  None: "None",

  /**
   * Indicates that system-assigned identity for the search service will be enabled.
   */
  SystemAssigned: "SystemAssigned",

  /**
   * Indicates that one or more user assigned identities will be assigned to the search service.
   */
  UserAssigned: "UserAssigned",

  /**
   * Indicates that system-assigned identity for the search service will be enabled along with the assignment of one or more user assigned identities.
   */
  `SystemAssigned, UserAssigned`: "SystemAssigned, UserAssigned",
}

/**
 * The reason why the name is not available. 'Invalid' indicates the name provided does not match the naming requirements (incorrect length, unsupported characters, etc.). 'AlreadyExists' indicates that the name is already in use and is therefore unavailable.
 */
union UnavailableNameReason {
  string,

  /**
   * The search service name doesn't match naming requirements.
   */
  Invalid: "Invalid",

  /**
   * The search service name is already assigned to a different search service.
   */
  AlreadyExists: "AlreadyExists",
}

/**
 * Type of issue
 */
union IssueType {
  string,

  /**
   * Unknown issue type
   */
  Unknown: "Unknown",

  /**
   * An error occurred while applying the network security perimeter (NSP) configuration.
   */
  ConfigurationPropagationFailure: "ConfigurationPropagationFailure",

  /**
   * A network connectivity issue is happening on the resource which could be addressed either by adding new resources to the network security perimeter (NSP) or by modifying access rules.
   */
  MissingPerimeterConfiguration: "MissingPerimeterConfiguration",

  /**
   * An managed identity hasn't been associated with the resource. The resource will still be able to validate inbound traffic from the network security perimeter (NSP) or matching inbound access rules, but it won't be able to perform outbound access as a member of the NSP.
   */
  MissingIdentityConfiguration: "MissingIdentityConfiguration",
}

/**
 * Severity of the issue.
 */
union Severity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warning: "Warning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Error: "Error",
}

/**
 * The current status of the long running asynchronous shared private link resource operation.
 */
union SharedPrivateLinkResourceAsyncOperationResult {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Applicable only for the standard3 SKU. You can set this property to enable up to 3 high density partitions that allow up to 1000 indexes, which is much higher than the maximum indexes allowed for any other SKU. For the standard3 SKU, the value is either 'Default' or 'HighDensity'. For all other SKUs, this value must be 'Default'.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum HostingMode {
  /**
   * The limit on number of indexes is determined by the default limits for the SKU.
   */
  Default,

  /**
   * Only application for standard3 SKU, where the search service can have up to 1000 indexes.
   */
  HighDensity,
}

/**
 * The status of the search service. Possible values include: 'running': The search service is running and no provisioning operations are underway. 'provisioning': The search service is being provisioned or scaled up or down. 'deleting': The search service is being deleted. 'degraded': The search service is degraded. This can occur when the underlying search units are not healthy. The search service is most likely operational, but performance might be slow and some requests might be dropped. 'disabled': The search service is disabled. In this state, the service will reject all API requests. 'error': The search service is in an error state. 'stopped': The search service is in a subscription that's disabled. If your service is in the degraded, disabled, or error states, it means the Azure AI Search team is actively investigating the underlying issue. Dedicated services in these states are still chargeable based on the number of search units provisioned.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

  /**
   * The search service is in a subscription that's disabled.
   */
  Stopped: "stopped",
}

/**
 * The state of the last provisioning operation performed on the search service. Provisioning is an intermediate state that occurs while service capacity is being established. After capacity is set up, provisioningState changes to either 'Succeeded' or 'Failed'. Client applications can poll provisioning status (the recommended polling interval is from 30 seconds to one minute) by using the Get Search Service operation to see when an operation is completed. If you are using the free service, this value tends to come back as 'Succeeded' directly in the call to Create search service. This is because the free service uses capacity that is already set up.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Describes how a search service should enforce compliance if it finds objects that aren't encrypted with the customer-managed key.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SearchEncryptionWithCmk {
  /**
   * No enforcement of customer-managed key encryption will be made. Only the built-in service-managed encryption is used.
   */
  Disabled,

  /**
   * Search service will be marked as non-compliant if one or more objects aren't encrypted with a customer-managed key.
   */
  Enabled,

  /**
   * Enforcement policy is not explicitly specified, with the behavior being the same as if it were set to 'Disabled'.
   */
  Unspecified,
}

/**
 * Returns the status of search service compliance with respect to non-CMK-encrypted objects. If a service has more than one unencrypted object, and enforcement is enabled, the service is marked as noncompliant.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SearchEncryptionComplianceStatus {
  /**
   * Indicates that the search service is compliant, either because the number of non-CMK-encrypted objects is zero or enforcement is disabled.
   */
  Compliant,

  /**
   * Indicates that the search service has more than one non-CMK-encrypted objects.
   */
  NonCompliant,
}

/**
 * Describes what response the data plane API of a search service would send for requests that failed authentication.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Status of the the private link service connection. Valid values are Pending, Approved, Rejected, or Disconnected.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Contains information about an API error.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@error
@Azure.ResourceManager.Legacy.armExternalType
model CloudError {
  /**
   * Describes a particular API error with an error code and a message.
   */
  error?: CloudErrorBody;

  /**
   * A brief description of the error that hints at what went wrong (for details/debugging information refer to the 'error.message' property).
   */
  message?: string;
}

/**
 * Describes a particular API error with an error code and a message.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  details?: CloudErrorBody[];
}

/**
 * Response containing the primary and secondary admin API keys for a given Azure AI Search service.
 */
model AdminKeyResult {
  /**
   * The primary admin API key of the search service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  primaryKey?: string;

  /**
   * The secondary admin API key of the search service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  secondaryKey?: string;
}

/**
 * Describes an API key for a given Azure AI Search service that conveys read-only permissions on the docs collection of an index.
 */
model QueryKey {
  /**
   * The name of the query API key. Query names are optional, but assigning a name can help you remember how it's used.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The value of the query API key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  key?: string;
}

/**
 * Response containing the query API keys for a given Azure AI Search service.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model ListQueryKeysResult {
  /**
   * The query keys for the Azure AI Search service.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: QueryKey[];

  /**
   * Request URL that can be used to query next page of query keys. Returned when the total number of requested query keys exceed maximum page size.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

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
   * The endpoint of the Azure AI Search service.
   */
  endpoint?: url;

  /**
   * Applicable only for the standard3 SKU. You can set this property to enable up to 3 high density partitions that allow up to 1000 indexes, which is much higher than the maximum indexes allowed for any other SKU. For the standard3 SKU, the value is either 'Default' or 'HighDensity'. For all other SKUs, this value must be 'Default'.
   */
  hostingMode?: HostingMode = HostingMode.Default;

  /**
   * Configure this property to support the search service using either the Default Compute or Azure Confidential Compute.
   */
  computeType?: ComputeType;

  /**
   * This value can be set to 'Enabled' to avoid breaking changes on existing customer resources and templates. If set to 'Disabled', traffic over public interface is not allowed, and private endpoint connections would be the exclusive access method.
   */
  publicNetworkAccess?: PublicNetworkAccess = PublicNetworkAccess.Enabled;

  /**
   * The status of the search service. Possible values include: 'running': The search service is running and no provisioning operations are underway. 'provisioning': The search service is being provisioned or scaled up or down. 'deleting': The search service is being deleted. 'degraded': The search service is degraded. This can occur when the underlying search units are not healthy. The search service is most likely operational, but performance might be slow and some requests might be dropped. 'disabled': The search service is disabled. In this state, the service will reject all API requests. 'error': The search service is in an error state. 'stopped': The search service is in a subscription that's disabled. If your service is in the degraded, disabled, or error states, it means the Azure AI Search team is actively investigating the underlying issue. Dedicated services in these states are still chargeable based on the number of search units provisioned.
   */
  @visibility(Lifecycle.Read)
  status?: SearchServiceStatus;

  /**
   * The details of the search service status.
   */
  @visibility(Lifecycle.Read)
  statusDetails?: string;

  /**
   * The state of the last provisioning operation performed on the search service. Provisioning is an intermediate state that occurs while service capacity is being established. After capacity is set up, provisioningState changes to either 'Succeeded' or 'Failed'. Client applications can poll provisioning status (the recommended polling interval is from 30 seconds to one minute) by using the Get Search Service operation to see when an operation is completed. If you are using the free service, this value tends to come back as 'Succeeded' directly in the call to Create search service. This is because the free service uses capacity that is already set up.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Network specific rules that determine how the Azure AI Search service may be reached.
   */
  networkRuleSet?: NetworkRuleSet;

  /**
   * A list of data exfiltration scenarios that are explicitly disallowed for the search service. Currently, the only supported value is 'All' to disable all possible data export scenarios with more fine grained controls planned for the future.
   */
  dataExfiltrationProtections?: SearchDataExfiltrationProtection[];

  /**
   * Specifies any policy regarding encryption of resources (such as indexes) using customer manager keys within a search service.
   */
  encryptionWithCmk?: EncryptionWithCmk;

  /**
   * When set to true, calls to the search service will not be permitted to utilize API keys for authentication. This cannot be set to true if 'dataPlaneAuthOptions' are defined.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disableLocalAuth?: boolean | null;

  /**
   * Defines the options for how the data plane API of a search service authenticates requests. This cannot be set if 'disableLocalAuth' is set to true.
   */
  authOptions?: DataPlaneAuthOptions;

  /**
   * Sets options that control the availability of semantic search. This configuration is only possible for certain Azure AI Search SKUs in certain locations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  semanticSearch?: SearchSemanticSearch | null;

  /**
   * The list of private endpoint connections to the Azure AI Search service.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * The list of shared private link resources managed by the Azure AI Search service.
   */
  @visibility(Lifecycle.Read)
  sharedPrivateLinkResources?: SharedPrivateLinkResource[];

  /**
   * A system generated property representing the service's etag that can be for optimistic concurrency control during updates.
   */
  @visibility(Lifecycle.Read)
  eTag?: string;

  /**
   * Indicates if the search service has an upgrade available.
   */
  upgradeAvailable?: UpgradeAvailable;

  /**
   * The date and time the search service was last upgraded. This field will be null until the service gets upgraded for the first time.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  serviceUpgradedAt?: utcDateTime;
}

/**
 * Network specific rules that determine how the Azure AI Search service may be reached.
 */
model NetworkRuleSet {
  /**
   * A list of IP restriction rules that defines the inbound network(s) with allowing access to the search service endpoint. At the meantime, all other public IP networks are blocked by the firewall. These restriction rules are applied only when the 'publicNetworkAccess' of the search service is 'enabled'; otherwise, traffic over public interface is not allowed even with any public IP rules, and private endpoint connections would be the exclusive access method.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ipRules?: IpRule[];

  /**
   * Possible origins of inbound traffic that can bypass the rules defined in the 'ipRules' section.
   */
  bypass?: SearchBypass;
}

/**
 * The IP restriction rule of the Azure AI Search service.
 */
model IpRule {
  /**
   * Value corresponding to a single IPv4 address (eg., 123.1.2.3) or an IP range in CIDR format (eg., 123.1.2.3/24) to be allowed.
   */
  value?: string;
}

/**
 * Describes a policy that determines how resources within the search service are to be encrypted with customer managed keys.
 */
model EncryptionWithCmk {
  /**
   * Describes how a search service should enforce compliance if it finds objects that aren't encrypted with the customer-managed key.
   */
  enforcement?: SearchEncryptionWithCmk;

  /**
   * Returns the status of search service compliance with respect to non-CMK-encrypted objects. If a service has more than one unencrypted object, and enforcement is enabled, the service is marked as noncompliant.
   */
  @visibility(Lifecycle.Read)
  encryptionComplianceStatus?: SearchEncryptionComplianceStatus;
}

/**
 * Defines the options for how the search service authenticates a data plane request. This cannot be set if 'disableLocalAuth' is set to true.
 */
model DataPlaneAuthOptions {
  /**
   * Indicates that only the API key can be used for authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  apiKeyOnly?: unknown;

  /**
   * Indicates that either the API key or an access token from a Microsoft Entra ID tenant can be used for authentication.
   */
  aadOrApiKey?: DataPlaneAadOrApiKeyAuthOption;
}

/**
 * Indicates that either the API key or an access token from a Microsoft Entra ID tenant can be used for authentication.
 */
model DataPlaneAadOrApiKeyAuthOption {
  /**
   * Describes what response the data plane API of a search service would send for requests that failed authentication.
   */
  aadAuthFailureMode?: AadAuthFailureMode;
}

/**
 * Describes the properties of an existing private endpoint connection to the search service.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The private endpoint resource from Microsoft.Network provider.
   */
  privateEndpoint?: PrivateEndpointConnectionPropertiesPrivateEndpoint;

  /**
   * Describes the current state of an existing Azure Private Link service connection to the private endpoint.
   */
  privateLinkServiceConnectionState?: PrivateEndpointConnectionPropertiesPrivateLinkServiceConnectionState;

  /**
   * The group ID of the Azure resource for which the private link service is for.
   */
  groupId?: string;

  /**
   * The provisioning state of the private link service connection. Valid values are Updating, Deleting, Failed, Succeeded, Incomplete, or Canceled.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: PrivateLinkServiceConnectionProvisioningState;
}

/**
 * The private endpoint resource from Microsoft.Network provider.
 */
model PrivateEndpointConnectionPropertiesPrivateEndpoint {
  /**
   * The resource ID of the private endpoint resource from Microsoft.Network provider.
   */
  id?: string;
}

/**
 * Describes the current state of an existing Azure Private Link service connection to the private endpoint.
 */
model PrivateEndpointConnectionPropertiesPrivateLinkServiceConnectionState {
  /**
   * Status of the the private link service connection. Valid values are Pending, Approved, Rejected, or Disconnected.
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
 * Describes the properties of an existing shared private link resource managed by the Azure AI Search service.
 */
model SharedPrivateLinkResourceProperties {
  /**
   * The resource ID of the resource the shared private link resource is for.
   */
  privateLinkResourceId?: string;

  /**
   * The group ID from the provider of resource the shared private link resource is for.
   */
  groupId?: string;

  /**
   * The message for requesting approval of the shared private link resource.
   */
  requestMessage?: string;

  /**
   * Optional. Can be used to specify the Azure Resource Manager location of the resource for which a shared private link is being created. This is only required for those resources whose DNS configuration are regional (such as Azure Kubernetes Service).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs(
    "https://docs.microsoft.com/azure/private-link/private-endpoint-dns",
    "List of all Azure resources which have a regional DNS configuration requirement can be found here."
  )
  resourceRegion?: string;

  /**
   * Status of the shared private link resource. Valid values are Pending, Approved, Rejected or Disconnected.
   */
  status?: SharedPrivateLinkResourceStatus;

  /**
   * The provisioning state of the shared private link resource. Valid values are Updating, Deleting, Failed, Succeeded or Incomplete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  provisioningState?: SharedPrivateLinkResourceProvisioningState;
}

/**
 * Defines the SKU of a search service, which determines billing rate and capacity limits.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@OpenAPI.externalDocs("https://azure.microsoft.com/documentation/articles/search-sku-tier/")
model Sku {
  /**
   * The SKU of the search service. Valid values include: 'free': Shared service. 'basic': Dedicated service with up to 3 replicas. 'standard': Dedicated service with up to 12 partitions and 12 replicas. 'standard2': Similar to standard, but with more capacity per search unit. 'standard3': The largest Standard offering with up to 12 partitions and 12 replicas (or up to 3 partitions with more indexes if you also set the hostingMode property to 'highDensity'). 'storage_optimized_l1': Supports 1TB per partition, up to 12 partitions. 'storage_optimized_l2': Supports 2TB per partition, up to 12 partitions.'
   */
  name?: SkuName;
}

/**
 * Details about the search service identity. A null value indicates that the search service has no identity assigned.
 */
model Identity {
  /**
   * The principal ID of the system-assigned identity of the search service.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of the system-assigned identity of the search service.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of identity used for the resource. The type 'SystemAssigned, UserAssigned' includes both an identity created by the system and a set of user assigned identities. The type 'None' will remove all identities from the service.
   */
  type: IdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource IDs in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The parameters used to update an Azure AI Search service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SearchServiceUpdate extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Properties of the search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: SearchServiceProperties;

  /**
   * The SKU of the search service, which determines price tier and capacity limits. This property is required when creating a new search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("https://azure.microsoft.com/documentation/articles/search-sku-tier/")
  sku?: Sku;

  /**
   * The geographic location of the resource. This must be one of the supported and registered Azure geo regions (for example, West US, East US, Southeast Asia, and so forth). This property is required when creating a new resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @OpenAPI.externalDocs("https://aka.ms/search-rp-info")
  location?: string;

  /**
   * Tags to help categorize the resource in the Azure portal.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Details about the search service identity. A null value indicates that the search service has no identity assigned.
   */
  identity?: Identity;
}

/**
 * Response containing a list of supported Private Link Resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model PrivateLinkResourcesResult {
  /**
   * The list of supported Private Link Resources.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: PrivateLinkResource[];

  /**
   * The URL to get the next set of private link resources, if there are any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * Describes a supported private link resource for the Azure AI Search service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResource extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Describes the properties of a supported private link resource for the Azure AI Search service.
   */
  @visibility(Lifecycle.Read)
  properties?: PrivateLinkResourceProperties;
}

/**
 * Describes the properties of a supported private link resource for the Azure AI Search service. For a given API version, this represents the 'supported' groupIds when creating a shared private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The group ID of the private link resource.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The list of required members of the private link resource.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The list of required DNS zone names of the private link resource.
   */
  @visibility(Lifecycle.Read)
  requiredZoneNames?: string[];

  /**
   * The list of resources that are onboarded to private link service, that are supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
  shareablePrivateLinkResourceTypes?: ShareablePrivateLinkResourceType[];
}

/**
 * Describes an resource type that has been onboarded to private link service, supported by Azure AI Search.
 */
model ShareablePrivateLinkResourceType {
  /**
   * The name of the resource type that has been onboarded to private link service, supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Describes the properties of a resource type that has been onboarded to private link service, supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
  properties?: ShareablePrivateLinkResourceProperties;
}

/**
 * Describes the properties of a resource type that has been onboarded to private link service, supported by Azure AI Search.
 */
model ShareablePrivateLinkResourceProperties {
  /**
   * The resource provider type for the resource that has been onboarded to private link service, supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The resource provider group id for the resource that has been onboarded to private link service, supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The description of the resource type that has been onboarded to private link service, supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * The reason why the name is not available. 'Invalid' indicates the name provided does not match the naming requirements (incorrect length, unsupported characters, etc.). 'AlreadyExists' indicates that the name is already in use and is therefore unavailable.
   */
  @visibility(Lifecycle.Read)
  reason?: UnavailableNameReason;

  /**
   * A message that explains why the name is invalid and provides resource naming requirements. Available only if 'Invalid' is returned in the 'reason' property.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Response containing the quota usage information for all the supported SKUs of Azure AI Search.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model QuotaUsagesListResult {
  /**
   * The quota usages for the SKUs supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: QuotaUsageResult[];

  /**
   * Request URL that can be used to query next page of quota usages. Returned when the total number of requested quota usages exceed maximum page size.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Describes the quota usage for a particular SKU.
 */
model QuotaUsageResult {
  /**
   * The resource ID of the quota usage SKU endpoint for Microsoft.Search provider.
   */
  id?: string;

  /**
   * The unit of measurement for the search SKU.
   */
  unit?: string;

  /**
   * The currently used up value for the particular search SKU.
   */
  currentValue?: int32;

  /**
   * The quota limit for the particular search SKU.
   */
  limit?: int32;

  /**
   * The name of the SKU supported by Azure AI Search.
   */
  @visibility(Lifecycle.Read)
  name?: QuotaUsageResultName;
}

/**
 * The name of the SKU supported by Azure AI Search.
 */
model QuotaUsageResultName {
  /**
   * The SKU name supported by Azure AI Search.
   */
  value?: string;

  /**
   * The localized string value for the SKU name.
   */
  localizedValue?: string;
}

/**
 * The details of a long running asynchronous shared private link resource operation.
 */
model AsyncOperationResult {
  /**
   * The current status of the long running asynchronous shared private link resource operation.
   */
  status?: SharedPrivateLinkResourceAsyncOperationResult;
}
/**
 * The result of the request to list REST API operations. It contains a list of operations and a URL to get the next set of results.
 */
model OperationListResult {
  /**
   * The list of operations by Azure AI Search, some supported by the resource provider and others by data plane APIs.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: Operation[];

  /**
   * The URL to get the next set of operation list results, if any.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/**
 * Response containing a list of private endpoint connections.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model PrivateEndpointConnectionListResult {
  /**
   * The list of private endpoint connections.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: PrivateEndpointConnection[];

  /**
   * Request URL that can be used to query next page of private endpoint connections. Returned when the total number of requested private endpoint connections exceed maximum page size.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
/**
 * Response containing a list of Azure AI Search services.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model SearchServiceListResult {
  /**
   * The list of search services.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SearchService[];

  /**
   * Request URL that can be used to query next page of search services. Returned when the total number of requested search services exceed maximum page size.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}
/**
 * Response containing a list of shared private link resources.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.armExternalType
model SharedPrivateLinkResourceListResult {
  /**
   * The list of shared private link resources.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: SharedPrivateLinkResource[];

  /**
   * The URL to get the next set of shared private link resources, if there are any.
   */
  @nextLink
  nextLink?: string;
}
