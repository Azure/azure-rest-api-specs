import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ResourceHealth;
@doc("Service health event")
@subscriptionResource
model Event is ProxyResource<EventProperties> {
  @doc("Event Id which uniquely identifies ServiceHealth event.")
  @key("eventTrackingId")
  @segment("events")
  name: string;
}

@armResourceOperations
@projectedName("client", "Event")
interface Events_Event {
  @doc("Service health event in the subscription by event tracking id")
  getBySubscriptionIdAndTrackingId is ArmResourceRead<
    Event,
    {
      ...BaseParameters<Event>;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Specifies from when to return events, based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020")
      @query("queryStartTime")
      queryStartTime?: string;
    }
  >;

  @doc("Service health event details in the subscription by event tracking id. This can be used to fetch sensitive properties for Security Advisory events")
  fetchDetailsBySubscriptionIdAndTrackingId is ArmResourceActionSync<
    Event,
    void,
    Event
  >;
}

@armResourceOperations
interface Events {
  @doc("Lists service health events in the subscription.")
  listBySubscriptionId is ArmResourceListByParent<
    Event,
    {
      ...BaseParameters<Event>;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Specifies from when to return events, based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020")
      @query("queryStartTime")
      queryStartTime?: string;
    }
  >;
}

@armResourceOperations
@projectedName("client", "SecurityAdvisoryImpactedResources")
interface Events_SecurityAdvisoryImpactedResources {
  @doc("Lists impacted resources in the subscription by an event (Security Advisory).")
  listBySubscriptionIdAndEventId is ArmResourceActionSync<
    Event,
    void,
    ResourceListResult<EventImpactedResource>,
    {
      ...BaseParameters<Event>;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;
    }
  >;
}
