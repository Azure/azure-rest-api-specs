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

namespace AzureChangeAnalysisManagementClient;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourceChangesOperationGroup {
  /**
   * List the changes of a resource within the specified time range. Customer data will be masked if the user doesn't have access.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List the changes of a resource within the specified time range. Customer data will be masked if the user doesn't have access.")
  @operationId("ResourceChanges_List")
  @route("/{resourceId}/providers/Microsoft.ChangeAnalysis/resourceChanges")
  @post
  list(
    ...ApiVersionParameter,

    /**
     * The identifier of the resource.
     */
    @path
    resourceId: string,

    /**
     * Specifies the start time of the changes request.
     */
    @query("$startTime")
    $startTime: utcDateTime,

    /**
     * Specifies the end time of the changes request.
     */
    @query("$endTime")
    $endTime: utcDateTime,

    /**
     * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
     */
    @query("$skipToken")
    $skipToken?: string,
  ): ArmResponse<ChangeList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ChangesOperationGroup {
  /**
   * List the changes of a resource group within the specified time range. Customer data will always be masked.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List the changes of a resource group within the specified time range. Customer data will always be masked.")
  @operationId("Changes_ListChangesByResourceGroup")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ChangeAnalysis/changes")
  @get
  listChangesByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Specifies the start time of the changes request.
     */
    @query("$startTime")
    $startTime: utcDateTime,

    /**
     * Specifies the end time of the changes request.
     */
    @query("$endTime")
    $endTime: utcDateTime,

    /**
     * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
     */
    @query("$skipToken")
    $skipToken?: string,
  ): ArmResponse<ChangeList> | ErrorResponse;

  /**
   * List the changes of a subscription within the specified time range. Customer data will always be masked.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List the changes of a subscription within the specified time range. Customer data will always be masked.")
  @operationId("Changes_ListChangesBySubscription")
  @autoRoute
  @get
  @action("changes")
  listChangesBySubscription is ArmProviderActionSync<
    Response = ChangeList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Specifies the start time of the changes request.
       */
      @query("$startTime")
      $startTime: utcDateTime;

      /**
       * Specifies the end time of the changes request.
       */
      @query("$endTime")
      $endTime: utcDateTime;

      /**
       * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
