import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Event.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
/**
 * Impacted resource for an event.
 */
@parentResource(Event)
model EventImpactedResource is ProxyResource<EventImpactedResourceProperties> {
  /**
   * Name of the Impacted Resource.
   */
  @pattern("^[^*#&+:<>%?]+$")
  @path
  @key("impactedResourceName")
  @segment("impactedResources")
  name: string;
}

@armResourceOperations
interface EventImpactedResources {
  /**
   * Gets the specific impacted resource in the subscription by an event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ImpactedResources_Get")
  get is ArmResourceRead<EventImpactedResource>;

  /**
   * Lists impacted resources in the subscription by an event.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ImpactedResources_ListBySubscriptionIdAndEventId")
  listBySubscriptionIdAndEventId is ArmResourceListByParent<
    EventImpactedResource,
    {
      ...BaseParameters<EventImpactedResource>;

      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
