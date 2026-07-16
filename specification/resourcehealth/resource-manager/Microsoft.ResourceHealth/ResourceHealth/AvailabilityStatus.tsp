import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
/**
 * availabilityStatus of a resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AvailabilityStatus extends ProxyResource {
  /**
   * Properties of availability state.
   */
  properties?: AvailabilityStatusProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "The 'current' endpoints are non-resource operations"
interface AvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "This is a non-resource operation"
  @tag("AvailabilityStatuses")
  @get
  @route("/{+resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses/current")
  getByResource(
    ...ApiVersionParameter,

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path
    resourceUri: string,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string,
  ): ArmResponse<AvailabilityStatus> | ErrorResponse;

  /**
   * Lists the current availability status for all the resources in the subscription.
   */
  @list
  @get
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @action("availabilityStatuses")
  @tag("AvailabilityStatuses")
  listBySubscriptionId(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string,
  ): availabilityStatusListResult | ErrorResponse;

  /**
   * Lists all historical availability transitions and impacting events for a single resource.
   */
  @list
  @get
  @route("/{+resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @tag("AvailabilityStatuses")
  @action("availabilityStatuses")
  list(
    ...ApiVersionParameter,

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path
    resourceUri: string,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string,
  ): availabilityStatusListResult | ErrorResponse;

  /**
   * Lists the current availability status for all the resources in the resource group.
   */
  @list
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @action("availabilityStatuses")
  @tag("AvailabilityStatuses")
  listByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string,
  ): availabilityStatusListResult | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "The 'current' endpoints are non-resource operations"
interface ChildAvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-api-version" "FIXME: review suppression and update justification"
#suppress "@azure-tools/typespec-azure-resource-manager/use-interface" "This is a non-resource operation"
  @tag("ChildAvailabilityStatuses")
  @get
  @route("/{+resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses/current")
  getByResource(
    ...ApiVersionParameter,

    /** undefined */
    @path
    resourceUri: string,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string,
  ): ArmResponse<AvailabilityStatus> | ErrorResponse;

  /**
   * Lists the historical availability statuses for a single child resource. Use the nextLink property in the response to get the next page of availability status
   */
  @list
  @get
  @route("/{+resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses")
  @segment("childAvailabilityStatuses")
  @tag("ChildAvailabilityStatuses")
  list(
    ...ApiVersionParameter,

    /** undefined */
    @path
    resourceUri: string,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string,
  ): availabilityStatusListResult | ErrorResponse;
}

@@doc(AvailabilityStatus.name, "");
@@doc(AvailabilityStatus.properties, "Properties of availability state.");
@@key(Extension.ScopeParameter.scope, "resourceUri");
