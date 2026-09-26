// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface UsagesOperationGroup {
  /**
   * Gets the current usage information as well as limits for AML resources for given subscription and location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_List")
  @autoRoute
  @get
  @action("usages")
  list is ArmProviderActionSync<
    Response = ListUsagesResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface VirtualMachineSizesOperationGroup {
  /**
   * Returns supported VM Sizes in a location
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineSizes_List")
  @autoRoute
  @get
  @action("vmSizes")
  list is ArmProviderActionSync<
    Response = VirtualMachineSizeListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface QuotasOperationGroup {
  /**
   * Update quota for each VM family in workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quotas_Update")
  @autoRoute
  @action("updateQuotas")
  update is ArmProviderActionSync<
    Request = QuotaUpdateParameters,
    Response = UpdateWorkspaceQuotasResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Gets the currently assigned Workspace Quotas based on VMFamily.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Quotas_List")
  @autoRoute
  @get
  @action("quotas")
  list is ArmProviderActionSync<
    Response = ListWorkspaceQuotas,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PTUQuotaOperationGroup {
  /**
   * List available MaaS PTU quota.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List available MaaS PTU quota.")
  @operationId("PTUQuota_ListAvailable")
  @autoRoute
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get available MaaS PTU quota.")
  @operationId("PTUQuota_GetAvailable")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List MaaS PTU usage and quota.")
  @operationId("PTUQuota_List")
  @autoRoute
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
