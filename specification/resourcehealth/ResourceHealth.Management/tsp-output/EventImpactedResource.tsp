import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Event.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ResourceHealth;
@doc("Impacted resource for an event.")
@parentResource(Event)
model EventImpactedResource is ProxyResource<EventImpactedResourceProperties> {
  @doc("Name of the Impacted Resource.")
  @pattern("^[^*#&+:<>%?]+$")
  @key("impactedResourceName")
  @segment("impactedResources")
  name: string;
}

@armResourceOperations
interface ImpactedResources {
  @doc("Gets the specific impacted resource in the subscription by an event.")
  get is ArmResourceRead<EventImpactedResource>;
  @doc("Lists impacted resources in the subscription by an event.")
  listBySubscriptionIdAndEventId is ArmResourceListByParent<
    EventImpactedResource,
    {
      ...BaseParameters<EventImpactedResource>;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;
    }
  >;
}
