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
@singleton("current")
@extensionResource
model AvailabilityStatus
  is Azure.ResourceManager.ExtensionResource<AvailabilityStatusProperties> {
  ...ResourceNameParameter<
    Resource = AvailabilityStatus,
    KeyName = "availabilityStatus",
    SegmentName = "availabilityStatuses",
    NamePattern = ""
  >;

  /**
   * Azure Resource Manager geo location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

alias AvailabilityStatusOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path
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
    @segment("availabilityStatuses")
    @key
    current: string;
  }
>;

@armResourceOperations
interface AvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  getByResource is AvailabilityStatusOps.Read<
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
    }
  >;

  /**
   * Lists the current availability status for all the resources in the subscription.
   */
  listBySubscriptionId is AvailabilityStatusOps.List<
    Extension.ScopeParameter,
    AvailabilityStatus,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      ...SubscriptionIdParameter;

      /**
       * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}
alias ChildAvailabilityStatusOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path
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
    current: string;
  }
>;

@armResourceOperations
interface ChildAvailabilityStatuses {
  /**
   * Gets current availability status for a single resource
   */
  getByResource is ChildAvailabilityStatusOps.Read<
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
    }
  >;

  /**
   * Lists the historical availability statuses for a single child resource. Use the nextLink property in the response to get the next page of availability status
   */
  list is ChildAvailabilityStatusOps.List<
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
    }
  >;
}

@@doc(AvailabilityStatus.name, "");
@@doc(AvailabilityStatus.properties, "Properties of availability state.");
