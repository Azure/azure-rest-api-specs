import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Storage;

/**
 * The type of the advanced platform metrics rule.
 */
@added(Versions.v2026_04_01)
union AdvancedPlatformMetricsRuleType {
  string,

  /** Container level capacity metrics rule type */
  ContainerLevelCapacityMetrics: "ContainerLevelCapacityMetrics",

  /** Transaction metrics with implicit Priority and ResponseStatus dimensions. Container filters are not supported. */
  @added(Versions.v2026_12_01)
  PriorityTransactionMetrics: "PriorityTransactionMetrics",
}

/**
 * The type of filter applied to the advanced platform metrics rule.
 */
@added(Versions.v2026_04_01)
union AdvancedPlatformMetricsFilterType {
  string,

  /** Filter applies to all containers */
  AllContainersFilter: "AllContainersFilter",

  /** Filter applies to containers matching a prefix */
  ContainerPrefixFilter: "ContainerPrefixFilter",

  /** Filter applies to a specific list of containers */
  ContainerListFilter: "ContainerListFilter",
}

/**
 * The metrics emitted by the advanced platform metrics rule.
 */
@added(Versions.v2026_04_01)
union MetricsEmitted {
  string,

  /** Container blob count metric */
  ContainerBlobCount: "ContainerBlobCount",

  /** Container used size metric */
  ContainerUsedSize: "ContainerUsedSize",

  /** Transaction count by priority. */
  @added(Versions.v2026_12_01)
  PriorityTransactions: "PriorityTransactions",

  /** Ingress by priority. */
  @added(Versions.v2026_12_01)
  PriorityIngress: "PriorityIngress",

  /** Egress by priority. */
  @added(Versions.v2026_12_01)
  PriorityEgress: "PriorityEgress",

  /** Server latency by priority. */
  @added(Versions.v2026_12_01)
  PriorityServerLatency: "PriorityServerLatency",

  /** Client latency by priority. */
  @added(Versions.v2026_12_01)
  PriorityClientLatency: "PriorityClientLatency",

  /** Availability by priority. */
  @added(Versions.v2026_12_01)
  PriorityAvailability: "PriorityAvailability",
}

/**
 * An optional dimension for the advanced platform metrics rule.
 */
@added(Versions.v2026_12_01)
union AdvancedPlatformMetricsAdditionalDimension {
  string,

  /** The name of the storage API operation. */
  ApiName: "ApiName",
}

/**
 * Configuration for the advanced platform metrics rule.
 */
@added(Versions.v2026_04_01)
model AdvancedPlatformMetricsRuleConfig {
  /**
   * The type of filter applied to the rule. Possible values include: AllContainersFilter, ContainerPrefixFilter, ContainerListFilter.
   */
  filterType?: AdvancedPlatformMetricsFilterType;

  /**
   * The values for the filter applied to the rule. If filter type is AllContainersFilter, filter values should be empty. If filter type is ContainerPrefixFilter, filter values should contain a list of container prefixes. If filter type is ContainerListFilter, filter values should contain a list of container names.
   */
  filterValues?: string[];

  /**
   * Optional dimensions for PriorityTransactionMetrics. Priority and ResponseStatus are always included and must not be specified here. Only ApiName can be selected, without duplicates. Omit this property or use an empty list for no additional dimensions. Container filters (filterType and filterValues) must be omitted for PriorityTransactionMetrics. This property is not supported for ContainerLevelCapacityMetrics.
   */
  @added(Versions.v2026_12_01)
  additionalDimensions?: AdvancedPlatformMetricsAdditionalDimension[];
}

/**
 * An object that defines the advanced platform metrics rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not have a provisioning state per the original Swagger design"
@added(Versions.v2026_04_01)
model AdvancedPlatformMetricsRuleProperties {
  /**
   * Indicates the type of the advanced platform metrics rule specified in the request path.
   */
  @visibility(Lifecycle.Read)
  ruleType?: AdvancedPlatformMetricsRuleType;

  /**
   * A boolean flag which enables the advanced platform metrics rule.
   */
  enabled: boolean;

  /**
   * Gets the last modification date and time of the advanced platform metrics rule in UTC.
   */
  @visibility(Lifecycle.Read)
  lastModifiedTime?: utcDateTime;

  /**
   * The metrics requested by the caller. If omitted in a create or update request, the service enables all metrics supported by the selected rule type. When specified, the list must be nonempty, contain no duplicates, and contain only metrics supported by that rule type. ContainerLevelCapacityMetrics supports ContainerUsedSize and ContainerBlobCount. PriorityTransactionMetrics supports PriorityTransactions, PriorityIngress, PriorityEgress, PriorityServerLatency, PriorityClientLatency, and PriorityAvailability.
   */
  @added(Versions.v2026_12_01)
  metricsToEmit?: MetricsEmitted[];

  /**
   * The effective metrics emitted by the rule, based on the rule type and the requested metric selection.
   */
  @visibility(Lifecycle.Read)
  metricsEmitted?: MetricsEmitted[];

  /**
   * Configuration for the advanced platform metrics rule.
   */
  ruleConfig: AdvancedPlatformMetricsRuleConfig;
}

/**
 * The advanced platform metrics rule for the storage account.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not have a provisioning state per the original Swagger design"
@added(Versions.v2026_04_01)
@parentResource(StorageAccount)
model AdvancedPlatformMetricsRule
  is Azure.ResourceManager.ProxyResource<AdvancedPlatformMetricsRuleProperties> {
  ...ResourceNameParameter<
    Resource = AdvancedPlatformMetricsRule,
    KeyName = "advancedPlatformMetricsRuleType",
    SegmentName = "advancedPlatformMetrics",
    NamePattern = "",
    Type = AdvancedPlatformMetricsRuleType
  >;
}

@armResourceOperations
@added(Versions.v2026_04_01)
interface AdvancedPlatformMetrics {
  /**
   * Get the advanced platform metrics rule for the storage account by rule type.
   */
  get is ArmResourceRead<AdvancedPlatformMetricsRule>;

  /**
   * Create or update the advanced platform metrics rule for the storage account.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<AdvancedPlatformMetricsRule>;

  /**
   * Delete the advanced platform metrics rule for the storage account by rule type.
   */
  delete is ArmResourceDeleteSync<AdvancedPlatformMetricsRule>;

  /**
   * List the advanced platform metrics rules associated with the storage account.
   */
  list is ArmResourceListByParent<AdvancedPlatformMetricsRule>;
}

@@doc(
  AdvancedPlatformMetricsRule.name,
  "The type of the advanced platform metrics rule."
);
@@doc(
  AdvancedPlatformMetricsRule.properties,
  "Returns the advanced platform metrics rule."
);
