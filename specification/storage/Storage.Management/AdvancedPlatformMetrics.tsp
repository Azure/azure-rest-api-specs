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
@added(Versions.v2025_08_01)
union AdvancedPlatformMetricsRuleType {
  string,

  /** Container level capacity metrics rule type */
  ContainerLevelCapacityMetrics: "ContainerLevelCapacityMetrics",
}

/**
 * The type of filter applied to the advanced platform metrics rule.
 */
@added(Versions.v2025_08_01)
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
@added(Versions.v2025_08_01)
union MetricsEmitted {
  string,

  /** Container used size metric */
  ContainerUsedSize: "ContainerUsedSize",

  /** Container blob count metric */
  ContainerBlobCount: "ContainerBlobCount",
}

/**
 * Configuration for the advanced platform metrics rule.
 */
@added(Versions.v2025_08_01)
model AdvancedPlatformMetricsRuleConfig {
  /**
   * The type of filter applied to the rule. Possible values include: AllContainersFilter, ContainerPrefixFilter, ContainerListFilter.
   */
  filterType?: AdvancedPlatformMetricsFilterType;

  /**
   * The values for the filter applied to the rule. If filter type is AllContainersFilter, filter values should be empty. If filter type is ContainerPrefixFilter, filter values should contain a list of container prefixes. If filter type is ContainerListFilter, filter values should contain a list of container names.
   */
  filterValues?: string[];
}

/**
 * An object that defines the advanced platform metrics rule.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource does not have a provisioning state per the original Swagger design"
@added(Versions.v2025_08_01)
model AdvancedPlatformMetricsRuleProperties {
  /**
   * Indicates the type of the advanced platform metrics rule. Possible values include: ContainerLevelCapacityMetrics.
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
   * The metrics emitted by the rule. Metrics are mapped according to the rule type from RuleTypeProperty. Rule type to metrics mapping: ContainerLevelCapacityMetrics => {ContainerUsedSize, ContainerBlobCount}.
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
@added(Versions.v2025_08_01)
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

/**
 * List of advanced platform metrics rules returned.
 */
@added(Versions.v2025_08_01)
model AdvancedPlatformMetricsRuleListResult {
  /**
   * List of advanced platform metrics rules.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  value?: AdvancedPlatformMetricsRule[];

  /**
   * The URL to the next page of results.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Using explicit routes for custom path structure"
@added(Versions.v2025_08_01)
interface AdvancedPlatformMetrics {
  /**
   * Get the advanced platform metrics rule for the storage account by rule type.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/advancedPlatformMetrics/{advancedPlatformMetricsRuleType}/default")
  @armResourceRead(AdvancedPlatformMetricsRule)
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The name of the storage account within the specified resource group.")
    @path
    @minLength(3)
    @maxLength(24)
    @pattern("^[a-z0-9]+$")
    accountName: string,

    @doc("The type of the advanced platform metrics rule.")
    @path
    advancedPlatformMetricsRuleType: AdvancedPlatformMetricsRuleType,
  ): ArmResponse<AdvancedPlatformMetricsRule> | ErrorResponse;

  /**
   * Create or update the advanced platform metrics rule for the storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @put
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/advancedPlatformMetrics/{advancedPlatformMetricsRuleType}/default")
  @armResourceCreateOrUpdate(AdvancedPlatformMetricsRule)
  createOrUpdate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The name of the storage account within the specified resource group.")
    @path
    @minLength(3)
    @maxLength(24)
    @pattern("^[a-z0-9]+$")
    accountName: string,

    @doc("The type of the advanced platform metrics rule.")
    @path
    advancedPlatformMetricsRuleType: AdvancedPlatformMetricsRuleType,

    @doc("The advanced platform metrics rule set to a storage account.")
    @body
    properties: AdvancedPlatformMetricsRule,
  ): ArmResponse<AdvancedPlatformMetricsRule> | ErrorResponse;

  /**
   * Delete the advanced platform metrics rule for the storage account by rule type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "Returns 204 with no body for not found"
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/advancedPlatformMetrics/{advancedPlatformMetricsRuleType}/default")
  @armResourceDelete(AdvancedPlatformMetricsRule)
  delete(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The name of the storage account within the specified resource group.")
    @path
    @minLength(3)
    @maxLength(24)
    @pattern("^[a-z0-9]+$")
    accountName: string,

    @doc("The type of the advanced platform metrics rule.")
    @path
    advancedPlatformMetricsRuleType: AdvancedPlatformMetricsRuleType,
  ): ArmDeletedResponse | ArmDeletedNoContentResponse | ErrorResponse;

  /**
   * List the advanced platform metrics rules associated with the storage account.
   */
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}/advancedPlatformMetrics")
  @armResourceList(AdvancedPlatformMetricsRule)
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    @doc("The name of the storage account within the specified resource group.")
    @path
    @minLength(3)
    @maxLength(24)
    @pattern("^[a-z0-9]+$")
    accountName: string,
  ): ArmResponse<AdvancedPlatformMetricsRuleListResult> | ErrorResponse;
}

@@doc(AdvancedPlatformMetricsRule.name,
  "The type of the advanced platform metrics rule."
);
@@doc(AdvancedPlatformMetricsRule.properties,
  "Returns the advanced platform metrics rule."
);
