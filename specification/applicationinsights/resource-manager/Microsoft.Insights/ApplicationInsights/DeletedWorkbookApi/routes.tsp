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

using ApplicationInsightsCommonTypes;

namespace DeletedWorkbookApi;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DeletedWorkbooksOperationGroup {
  /**
   * Get all recently deleted Workbooks in a specified subscription.
   */
  @autoRoute
  @get
  @list
  @action("deletedWorkbooks")
  listBySubscription is ArmProviderActionSync<
    Response = DeletedWorkbooksListResult,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Category of workbook to return.
       */
      @query("category")
      category?: CategoryType;

      /**
       * Tags presents on each workbook returned.
       */
      @query("tags")
      tags?: string[];
    },
    Error = DeletedWorkbookError
  >;
}
