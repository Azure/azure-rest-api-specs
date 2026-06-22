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
model AvailabilityStatus extends Foundations.ProxyResource {
  /**
   * Azure Resource Manager geo location of the resource.
   */
  location?: string;

  /**
   * Properties of availability state.
   */
  properties?: AvailabilityStatusProperties;
}

alias AvailabilityStatusesOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.ResourceHealth";
  },
  {
    /** undefined */
    @path
    @segment("availabilityStatuses")
    @key
    current: "current";
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "The 'current' endpoints are non-resource operations"
interface AvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  @tag("AvailabilityStatuses")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a non-resource operation"
  @get
  @route("/{+resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses/current")
  getByResource(
    /** The resource URI */
    @path
    resourceUri: string,

    /** The API version to use for this operation */
    @query("api-version")
    @minLength(1)
    apiVersion: string,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string
  ): AvailabilityStatus | ErrorResponse;

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

    /** The subscription ID */
    @path
    subscriptionId: string,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string
  ): availabilityStatusListResult | ErrorResponse;

  /**
   * Lists all historical availability transitions and impacting events for a single resource.
   */
  @tag("AvailabilityStatuses")
  @action("availabilityStatuses")
  list is Extension.ListByTarget<
    Extension.ScopeParameter,
    AvailabilityStatus,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = availabilityStatusListResult,
    Error = ErrorResponse
  >;

  /**
   * Lists the current availability status for all the resources in the resource group.
   */
  @tag("AvailabilityStatuses")
  listByResourceGroup is AvailabilityStatusesOps.List<
    AvailabilityStatus,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = availabilityStatusListResult,
    OverrideErrorType = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "The 'current' endpoints are non-resource operations"
interface ChildAvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  @tag("ChildAvailabilityStatuses")
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a non-resource operation"
  @get
  @route("/{+resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses/current")
  getByResource(
    /** The resource URI */
    @path
    resourceUri: string,

    /** The API version to use for this operation */
    @query("api-version")
    @minLength(1)
    apiVersion: string,

    /**
     * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
     */
    @query("$filter")
    $filter?: string,

    /**
     * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
     */
    @query("$expand")
    $expand?: string
  ): AvailabilityStatus | ErrorResponse;

  /**
   * Lists the historical availability statuses for a single child resource. Use the nextLink property in the response to get the next page of availability status
   */
  @list
  @get
  @route("/{+resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses")
  @segment("childAvailabilityStatuses")
  list(
    ...ApiVersionParameter,

    /** The resource URI */
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
    $expand?: string
  ): availabilityStatusListResult | ErrorResponse;
}

@@doc(AvailabilityStatus.name, "");
@@doc(AvailabilityStatus.properties, "Properties of availability state.");
@@key(Extension.ScopeParameter.scope, "resourceUri");
