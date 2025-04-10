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

namespace Microsoft.DataLakeStore;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AccountsOperationGroup {
  /**
   * Lists the Data Lake Store accounts within the subscription. The response includes a link to the next page of results, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_List")
  @autoRoute
  @get
  @action("accounts")
  list is ArmProviderActionSync<
    Response = ResourceListResult<DataLakeStoreAccountBasic>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * OData filter. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of items to return. Optional.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * The number of items to skip over before returning elements. Optional.
       */
      @minValue(1)
      @query("$skip")
      $skip?: int32;

      /**
       * OData Select statement. Limits the properties on each entry to just those requested, e.g. Categories?$select=CategoryName,Description. Optional.
       */
      @query("$select")
      $select?: string;

      /**
       * OrderBy clause. One or more comma-separated expressions with an optional "asc" (the default) or "desc" depending on the order you'd like the values sorted, e.g. Categories?$orderby=CategoryName desc. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * The Boolean value of true or false to request a count of the matching resources included with the resources in the response, e.g. Categories?$count=true. Optional.
       */
      @query("$count")
      $count?: boolean;
    }
  >;
  /**
   * Lists the Data Lake Store accounts within a specific resource group. The response includes a link to the next page of results, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_ListByResourceGroup")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataLakeStore/accounts")
  @get
  listByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * OData filter. Optional.
     */
    @query("$filter")
    $filter?: string,

    /**
     * The number of items to return. Optional.
     */
    @minValue(1)
    @query("$top")
    $top?: int32,

    /**
     * The number of items to skip over before returning elements. Optional.
     */
    @minValue(1)
    @query("$skip")
    $skip?: int32,

    /**
     * OData Select statement. Limits the properties on each entry to just those requested, e.g. Categories?$select=CategoryName,Description. Optional.
     */
    @query("$select")
    $select?: string,

    /**
     * OrderBy clause. One or more comma-separated expressions with an optional "asc" (the default) or "desc" depending on the order you'd like the values sorted, e.g. Categories?$orderby=CategoryName desc. Optional.
     */
    @query("$orderby")
    $orderby?: string,

    /**
     * A Boolean value of true or false to request a count of the matching resources included with the resources in the response, e.g. Categories?$count=true. Optional.
     */
    @query("$count")
    $count?: boolean,
  ): ArmResponse<ResourceListResult<DataLakeStoreAccountBasic>> | ErrorResponse;

  /**
   * Checks whether the specified account name is available or taken.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = CheckNameAvailabilityParameters,
    Response = NameAvailabilityInformation,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LocationsOperationGroup {
  /**
   * Gets subscription-level properties and limits for Data Lake Store specified by resource location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_GetCapability")
  @autoRoute
  @get
  @action("capability")
  getCapability is ArmProviderActionSync<
    Response = CapabilityInformation,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
  /**
   * Gets the current usage count and the limit for the resources of the location under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Locations_GetUsage")
  @autoRoute
  @get
  @action("usages")
  getUsage is ArmProviderActionSync<
    Response = UsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
