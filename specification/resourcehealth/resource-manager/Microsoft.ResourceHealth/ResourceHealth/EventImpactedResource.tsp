import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Event.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
/**
 * Impacted resource for an event.
 */
@subscriptionResource
@parentResource(Event)
model EventImpactedResource
  is Azure.ResourceManager.ProxyResource<EventImpactedResourceProperties> {
  ...ResourceNameParameter<
    Resource = EventImpactedResource,
    KeyName = "impactedResourceName",
    SegmentName = "impactedResources",
    NamePattern = "^[^*#&+:<>%?]+$"
  >;
}

alias EventImpactedResourceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.ResourceHealth";

    /** Event Id which uniquely identifies ServiceHealth event. */
    @path
    @segment("events")
    @key
    eventTrackingId: string;
  },
  {},
  {
    /** Name of the Impacted Resource. */
    @path
    @segment("impactedResources")
    @key
    @pattern("^[^*#&+:<>%?]+$")
    impactedResourceName: string;
  }
>;

@armResourceOperations
interface EventImpactedResources {
  /**
   * Gets the specific impacted resource in the subscription by an event.
   */
  get is EventImpactedResourceOps.Read<
    EventImpactedResource,
    ErrorType = ErrorResponse
  >;

  /**
   * Lists impacted resources in the subscription by an event.
   */
  listBySubscriptionIdAndEventId is EventImpactedResourceOps.List<
    EventImpactedResource,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    },
    Response = eventImpactedResourceListResult,
    ErrorType = ErrorResponse
  >;
}
alias ImpactedResourceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.ResourceHealth";

    /** Event Id which uniquely identifies ServiceHealth event. */
    @path
    @segment("events")
    @key
    eventTrackingId: string;
  },
  {},
  {
    /** Name of the Impacted Resource. */
    @path
    @segment("impactedResources")
    @key
    @pattern("^[^*#&+:<>%?]+$")
    impactedResourceName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface ImpactedResources {
  /**
   * Gets the specific impacted resource in the tenant by an event.
   */
  @tag("EventImpactedResources")
  getByTenantId is ImpactedResourceOps.Read<
    EventImpactedResource,
    ErrorType = ErrorResponse
  >;

  /**
   * Lists impacted resources in the tenant by an event.
   */
  @tag("EventImpactedResources")
  listByTenantIdAndEventId is ImpactedResourceOps.List<
    EventImpactedResource,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    },
    Response = eventImpactedResourceListResult,
    ErrorType = ErrorResponse
  >;
}

@@doc(EventImpactedResource.name, "Name of the Impacted Resource.");
@@doc(EventImpactedResource.properties, "Properties of impacted resource.");
