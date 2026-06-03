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
@singleton("current")
@extensionResource
model AvailabilityStatus extends ProxyResource {
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

@armResourceOperations
interface AvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  getByResource is Extension.Read<
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

      /** undefined */
      @path
      @segment("availabilityStatuses")
      @key
      current: "current";
    },
    Error = ErrorResponse
  >;

  /**
   * Lists the current availability status for all the resources in the subscription.
   */
  @action("availabilityStatuses")
  listBySubscriptionId is Extension.ListByTarget<
    Extension.Subscription,
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

alias ChildAvailabilityStatusOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    resourceUri: string;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.ResourceHealth";
  },
  {},
  {
    /** undefined */
    @path
    @segment("childAvailabilityStatuses")
    @key
    current: "current";
  }
>;

@armResourceOperations
interface ChildAvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  getByResource is ChildAvailabilityStatusOps.Read<
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
    ErrorType = ErrorResponse
  >;

  /**
   * Lists the historical availability statuses for a single child resource. Use the nextLink property in the response to get the next page of availability status
   */
  @segment("childAvailabilityStatuses")
  list is ChildAvailabilityStatusOps.List<
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
    ErrorType = ErrorResponse
  >;
}

@@doc(AvailabilityStatus.name, "");
@@doc(AvailabilityStatus.properties, "Properties of availability state.");
@@key(Extension.ScopeParameter.scope, "resourceUri");
