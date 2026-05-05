// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Interface defined for custom operations"
interface UsagesOperationGroup {
  /**
   * Gets the current usage information as well as limits for AML resources for given subscription and location.
   */
  @autoRoute
  @list
  @get
  @action("usages")
  list is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = SubscriptionActionScope,
    Parameters = CustomLocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Interface defined for custom operations"
interface VirtualMachineSizesOperationGroup {
  /**
   * Returns supported VM Sizes in a location
   */
  @autoRoute
  @get
  @action("vmSizes")
  list is ArmProviderActionSync<
    Response = VirtualMachineSizeListResult,
    Scope = SubscriptionActionScope,
    Parameters = CustomLocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Interface defined for custom operations"
interface QuotasOperationGroup {
  /**
   * Update quota for each VM family in workspace.
   */
  @autoRoute
  @action("updateQuotas")
  update is ArmProviderActionSync<
    Request = QuotaUpdateParameters,
    Response = UpdateWorkspaceQuotasResult,
    Scope = SubscriptionActionScope,
    Parameters = CustomLocationParameter
  >;
  /**
   * Gets the currently assigned Workspace Quotas based on VMFamily.
   */
  @autoRoute
  @list
  @get
  @action("quotas")
  list is ArmProviderActionSync<
    Response = ListWorkspaceQuotas,
    Scope = SubscriptionActionScope,
    Parameters = CustomLocationParameter
  >;
}

/**
 * PTUQuotaOperationGroup is preview-only.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Interface defined for custom operations"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API contract uses this naming convention"
@removed(Versions.v2025_12_01)
interface PTUQuotaOperationGroup {
  /**
   * List available MaaS PTU quota.
   */
  @summary("List available MaaS PTU quota.")
  @autoRoute
  @list
  @get
  @action("availableQuota")
  listAvailable is ArmProviderActionSync<
    Response = AvailableQuotaArmPaginatedResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    }
  >;
  /**
   * Get available MaaS PTU quota.
   */
  @summary("Get available MaaS PTU quota.")
  @autoRoute
  @get
  @action("availableQuota/default")
  getAvailable is ArmProviderActionSync<
    Response = AvailableQuota,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * List MaaS PTU usage and quota.
   */
  @summary("List MaaS PTU usage and quota.")
  @autoRoute
  @list
  @get
  @action("quotaAndUsage")
  list is ArmProviderActionSync<
    Response = UsageAndQuotaDetailsArmPaginatedResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;
    }
  >;
}
