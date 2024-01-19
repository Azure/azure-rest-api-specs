import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
@doc("Service health event")
@subscriptionResource
model Event is ProxyResource<EventProperties> {
  @doc("Event Id which uniquely identifies ServiceHealth event.")
  @path
  @key("eventTrackingId")
  @segment("events")
  name: string;
}

@armResourceOperations
interface Events {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Service health event in the subscription by event tracking id")
  @operationId("Event_GetBySubscriptionIdAndTrackingId")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists impacted resources in the subscription by an event (Security Advisory).")
  @operationId("SecurityAdvisoryImpactedResources_ListBySubscriptionIdAndEventId")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Service health event details in the subscription by event tracking id. This can be used to fetch sensitive properties for Security Advisory events")
  @operationId("Event_fetchDetailsBySubscriptionIdAndTrackingId")
  fetchDetailsBySubscriptionIdAndTrackingId is ArmResourceActionSync<
    Event,
    void,
    Event
  >;
}
