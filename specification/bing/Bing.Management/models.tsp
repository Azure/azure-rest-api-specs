import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Bing;

/**
 * Available operations of the service
 */
@Azure.Core.pagedResult
model AvailableOperations {
  /**
   * Collection of available operation details
   */
  @Azure.Core.items
  value: OperationDetail[];

  /**
   * URL client should use to fetch the next page (per server side paging).
   * It's null for now, added for future use.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The boost level for the allowed domain.
 */
union BoostLevel {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Demoted: "Demoted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Default: "Default",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Boosted: "Boosted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SuperBoost: "SuperBoost",
}

/**
 * Defines how the query terms should match the search terms entered by the user. If set to Exact (default), the pinned domain appears only if the user's search query exactly matches the specified query. If set to StartsWith, the pinned domain appears if the user's search query starts with the specified query. If set to Contains, the pinned domain appears if the user's search query contains the specified query. If set to EndsWith, the pinned domain appears if the user's search query ends with the specified query.
 */
union PinnedDomainCondition {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Exact: "Exact",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StartsWith: "StartsWith",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Contains: "Contains",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EndsWith: "EndsWith",
}

/**
 * Gets the status of the Bing Custom Search configuration at the time the operation was called.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * The reason for restriction.
 */
union ResourceSkuRestrictionsReasonCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  QuotaId: "QuotaId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * The unit of the metric.
 */
union UnitType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Count: "Count",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Bytes: "Bytes",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Seconds: "Seconds",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Percent: "Percent",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CountPerSecond: "CountPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  BytesPerSecond: "BytesPerSecond",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Milliseconds: "Milliseconds",
}

/**
 * Bing account quota usage status.
 */
union QuotaUsageStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Included: "Included",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Blocked: "Blocked",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  InOverage: "InOverage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
}

/**
 * Gets the SKU tier. This is based on the SKU name.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum SkuTier {
  Free,
  Standard,
  Premium,
}

/**
 * key name to generate (Key1|Key2)
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum KeyName {
  Key1,
  Key2,
}

/**
 * The type of restrictions.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResourceSkuRestrictionsType {
  Location,
  Zone,
}

/**
 * Properties of Bing Custom Search Configuration.
 */
model CustomConfigurationProperties {
  /**
   * List of allowed domains for Bing Custom Search configuration. Total number of domains in Allowed List, Blocked List, and Pinned List combined cannot exceed 250.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  allowedDomains?: AllowedDomain[];

  /**
   * List of blocked domains for Bing Custom Search configuration. Total number of domains in Allowed List, Blocked List, and Pinned List combined cannot exceed 250.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  blockedDomains?: BlockedDomain[];

  /**
   * List of pinned domains for Bing Custom Search configuration. Total number of domains in Allowed List, Blocked List, and Pinned List combined cannot exceed 250.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  pinnedDomains?: PinnedDomain[];

  /**
   * Gets the status of the Bing Custom Search configuration at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * An allowed domain for Bing Custom Search configuration.
 */
model AllowedDomain {
  /**
   * A domain string that can be used to specify allowed, blocked, or pinned domains in Bing Custom Search configuration.
   */
  @pattern("^\\s*(((https?:\\/\\/)|(?!(.*:\\/\\/)))((-\\.)?([^\\s\\/?\\.#]+\\.)([^\\s\\/?\\.#]+\\.?)+([^\\s\\/?\\.#]+)(\\/[^\\s]*)?))\\s*$")
  domain: string;

  /**
   * A flag to indicate whether subpages of the allowed domain should be included in the search result. If set to true (default), all subpages and nested paths under the specified domain will be included in the search result. If set to false, only the main domain will be included in the search result, excluding any subpages.
   */
  includeSubPages?: boolean = true;

  /**
   * The boost level for the allowed domain.
   */
  boostLevel?: BoostLevel = BoostLevel.Default;
}

/**
 * A blocked domain for Bing Custom Search configuration.
 */
model BlockedDomain {
  /**
   * A domain string that can be used to specify allowed, blocked, or pinned domains in Bing Custom Search configuration.
   */
  @pattern("^\\s*(((https?:\\/\\/)|(?!(.*:\\/\\/)))((-\\.)?([^\\s\\/?\\.#]+\\.)([^\\s\\/?\\.#]+\\.?)+([^\\s\\/?\\.#]+)(\\/[^\\s]*)?))\\s*$")
  domain: string;

  /**
   * A flag to indicate whether subpages of the blocked domain should be excluded from search results. If set to true (default), all subpages and nested paths under the specified domain will be excluded from search results. If set to false, only the main domain will be excluded from search results.
   */
  includeSubPages?: boolean = true;
}

/**
 * A pinned domain for Bing Custom Search configuration.
 */
model PinnedDomain {
  /**
   * A domain string that can be used to specify allowed, blocked, or pinned domains in Bing Custom Search configuration.
   */
  @pattern("^\\s*(((https?:\\/\\/)|(?!(.*:\\/\\/)))((-\\.)?([^\\s\\/?\\.#]+\\.)([^\\s\\/?\\.#]+\\.?)+([^\\s\\/?\\.#]+)(\\/[^\\s]*)?))\\s*$")
  domain: string;

  /**
   * The search terms or keywords that trigger the pinned domain to appear at the top of the search results if the user's search query meets the condition specified.
   */
  query: string;

  /**
   * Defines how the query terms should match the search terms entered by the user. If set to Exact (default), the pinned domain appears only if the user's search query exactly matches the specified query. If set to StartsWith, the pinned domain appears if the user's search query starts with the specified query. If set to Contains, the pinned domain appears if the user's search query contains the specified query. If set to EndsWith, the pinned domain appears if the user's search query ends with the specified query.
   */
  condition?: PinnedDomainCondition = PinnedDomainCondition.Exact;
}

/**
 * Properties of Bing account.
 */
model BingAccountProperties {
  /**
   * Gets the status of the Bing account at the time the operation was called.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Endpoint of the created account.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;

  /**
   * An internal identifier.
   */
  @visibility(Lifecycle.Read)
  internalId?: string;

  /**
   * (Bing Search Only) A flag indicating whether Bing Statistics is enabled.
   */
  statisticsEnabled?: boolean;
}

/**
 * The SKU of the Bing account.
 */
model Sku {
  /**
   * Gets or sets the SKU name. Required for account creation, optional for update.
   */
  name: string;

  /**
   * Gets the SKU tier. This is based on the SKU name.
   */
  @visibility(Lifecycle.Read)
  tier?: SkuTier;
}

/**
 * The access keys for the Bing account.
 */
model BingAccountKeys {
  /**
   * Gets the value of key 1.
   */
  key1?: string;

  /**
   * Gets the value of key 2.
   */
  key2?: string;
}

/**
 * Regenerate key parameters.
 */
model RegenerateKeyParameters {
  /**
   * key name to generate (Key1|Key2)
   */
  keyName: KeyName;
}

/**
 * The list SKUs operation response.
 */
model ResourceSkusResult is Azure.Core.Page<ResourceSku>;

/**
 * Describes an available Bing SKU.
 */
model ResourceSku {
  /**
   * The type of resource the SKU applies to.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The name of SKU.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Specifies the tier of Bing account.
   */
  @visibility(Lifecycle.Read)
  tier?: string;

  /**
   * The Kind of resources that are supported in this SKU.
   */
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * The set of locations that the SKU is available.
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * A list of locations and availability zones in those locations where the SKU is available.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  locationInfo?: ResourceSkuLocationInfo[];

  /**
   * The restrictions because of which SKU cannot be used. This is empty if there are no restrictions.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  restrictions?: ResourceSkuRestrictions[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ResourceSkuLocationInfo {
  /**
   * Location of the SKU
   */
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * List of availability zones where the SKU is supported.
   */
  @visibility(Lifecycle.Read)
  zones?: string[];

  /**
   * Details of capabilities available to a SKU in specific zones.
   */
  @visibility(Lifecycle.Read)
  zoneDetails?: ResourceSkuZoneDetails[];
}

/**
 * Describes The zonal capabilities of a SKU.
 */
model ResourceSkuZoneDetails {
  /**
   * The set of zones that the SKU is available in with the specified capabilities.
   */
  @visibility(Lifecycle.Read)
  name?: string[];

  /**
   * A list of capabilities that are available for the SKU in the specified list of zones.
   */
  @visibility(Lifecycle.Read)
  capabilities?: SkuCapability[];
}

/**
 * SkuCapability indicates the capability of a certain feature.
 */
model SkuCapability {
  /**
   * The name of the SkuCapability.
   */
  name?: string;

  /**
   * The value of the SkuCapability.
   */
  value?: string;
}

/**
 * Describes restrictions of a SKU.
 */
model ResourceSkuRestrictions {
  /**
   * The type of restrictions.
   */
  @visibility(Lifecycle.Read)
  type?: ResourceSkuRestrictionsType;

  /**
   * The value of restrictions. If the restriction type is set to location. This would be different locations where the SKU is restricted.
   */
  @visibility(Lifecycle.Read)
  values?: string[];

  /**
   * Information about the restriction where the SKU cannot be used.
   */
  @visibility(Lifecycle.Read)
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * The reason for restriction.
   */
  @visibility(Lifecycle.Read)
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

/**
 * Information about the restriction where the SKU cannot be used.
 */
model ResourceSkuRestrictionInfo {
  /**
   * Locations where the SKU is restricted
   */
  @visibility(Lifecycle.Read)
  locations?: string[];

  /**
   * List of availability zones where the SKU is restricted.
   */
  @visibility(Lifecycle.Read)
  zones?: string[];
}

/**
 * The list of Bing accounts operation response.
 */
model BingAccountEnumerateSkusResult {
  /**
   * Gets the list of Bing accounts and their properties.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  value?: BingResourceAndSku[];
}

/**
 * Bing resource type and SKU.
 */
model BingResourceAndSku {
  /**
   * Resource Namespace and Type
   */
  resourceType?: string;

  /**
   * The SKU of Bing account.
   */
  sku?: Sku;
}

/**
 * The response to a list usage request.
 */
model UsagesResult {
  /**
   * The list of usages for bing account.
   */
  @visibility(Lifecycle.Read)
  value?: Usage[];
}

/**
 * The usage data for a usage request.
 */
model Usage {
  /**
   * The unit of the metric.
   */
  @visibility(Lifecycle.Read)
  unit?: UnitType;

  /**
   * The name information for the metric.
   */
  @visibility(Lifecycle.Read)
  name?: MetricName;

  /**
   * The quota period used to summarize the usage values.
   */
  @visibility(Lifecycle.Read)
  quotaPeriod?: string;

  /**
   * Maximum value for this metric.
   */
  @visibility(Lifecycle.Read)
  limit?: float64;

  /**
   * Current value for this metric.
   */
  @visibility(Lifecycle.Read)
  currentValue?: float64;

  /**
   * Next reset time for current quota.
   */
  @visibility(Lifecycle.Read)
  nextResetTime?: string;

  /**
   * Bing account quota usage status.
   */
  status?: QuotaUsageStatus;
}

/**
 * A metric name.
 */
model MetricName {
  /**
   * The name of the metric.
   */
  @visibility(Lifecycle.Read)
  value?: string;

  /**
   * The friendly name of the metric.
   */
  @visibility(Lifecycle.Read)
  localizedValue?: string;
}

/**
 * Operation detail payload
 */
model OperationDetail {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  properties?: OperationProperties;
}

/**
 * Operation display payload
 */
model OperationDisplay {
  /**
   * Resource provider of the operation
   */
  provider?: string;

  /**
   * Resource of the operation
   */
  resource?: string;

  /**
   * Localized friendly name for the operation
   */
  operation?: string;

  /**
   * Localized friendly description for the operation
   */
  description?: string;
}

/**
 * Extra Operation properties
 */
model OperationProperties {
  /**
   * Service specifications of the operation
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Log for Azure Monitoring
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Specifications of the Metrics for Azure Monitoring
 */
model MetricSpecification {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Localized friendly display name of the metric
   */
  displayName?: string;

  /**
   * Localized friendly description of the metric
   */
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric
   */
  unit?: string;

  /**
   * Name of the metric category that the metric belongs to. A metric can only belong to a single category.
   */
  category?: string;

  /**
   * Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  aggregationType?: string;

  /**
   * List of availability.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  availabilities?: Availability[];

  /**
   * Supported aggregation types
   */
  supportedAggregationTypes?: string[];

  /**
   * Supported time grain types
   */
  supportedTimeGrainTypes?: string[];

  /**
   * Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.
   */
  fillGapWithZero?: boolean;

  /**
   * Dimensions of the metric
   */
  dimensions?: MetricDimension[];
}

/**
 * Availability of the metric.
 */
model Availability {
  /**
   * The time grain of the availability.
   */
  timeGrain?: string;

  /**
   * The retention of the availability.
   */
  retention?: string;

  /**
   * Duration of the availability blob.
   */
  blobDuration?: string;
}

/**
 * Specifications of the Dimension of metrics
 */
model MetricDimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension
   */
  displayName?: string;
}

/**
 * The SKUs to check for availability in the specified subscription and location
 */
model CheckSkuAvailabilityParameter {
  /**
   * The SKU of the resource.
   */
  skus: string[];

  /**
   * Required. Indicates the type of Bing account.
   */
  kind: string;

  /**
   * The Type of the resource.
   */
  type: string;
}

/**
 * Check SKU availability result list.
 */
model CheckSkuAvailabilityResultList {
  /**
   * Check SKU availability result list.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  value?: CheckSkuAvailabilityResult[];
}

/**
 * Check SKU availability result.
 */
model CheckSkuAvailabilityResult {
  /**
   * Required. Indicates the type of Bing account.
   */
  kind?: string;

  /**
   * The Type of the resource.
   */
  type?: string;

  /**
   * The name of SKU.
   */
  skuName?: string;

  /**
   * Indicates the given SKU is available or not.
   */
  skuAvailable?: boolean;

  /**
   * Reason why the SKU is not available.
   */
  reason?: string;

  /**
   * Additional error message.
   */
  message?: string;
}

/**
 * The list of Bing accounts.
 */
model BingAccountListResult is Azure.Core.Page<BingAccount>;
@@visibility(BingAccountListResult.value, Lifecycle.Read);

/**
 * The list of Bing Custom Search configurations.
 */
model CustomSearchConfigurationListResult
  is Azure.Core.Page<CustomSearchConfiguration>;
@@visibility(CustomSearchConfigurationListResult.value, Lifecycle.Read);
