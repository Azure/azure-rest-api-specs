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
/**
 * Service health event
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@subscriptionResource
@Azure.ResourceManager.Private.armResourceInternal(EventProperties)
@includeInapplicableMetadataInPayload(false)
model Event extends ProxyResourceBase {
  /**
   * Event Id which uniquely identifies ServiceHealth event.
   */
  @path
  @key("eventTrackingId")
  @segment("events")
  name: string;

  /**
   * Properties of event.
   */
  @extension("x-ms-client-flatten", true)
  properties?: EventProperties;
}

@armResourceOperations
interface Events {
  /**
   * Service health event in the subscription by event tracking id
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Event_GetBySubscriptionIdAndTrackingId")
  getBySubscriptionIdAndTrackingId is ArmResourceRead<
    Event,
    {
      ...BaseParameters<Event>;

      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies from when to return events, based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020
       */
      @query("queryStartTime")
      queryStartTime?: string;
    }
  >;

  /**
   * Lists service health events in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Events_ListBySubscriptionId")
  listBySubscriptionId is ArmResourceListByParent<
    Event,
    {
      ...BaseParameters<Event>;

      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies from when to return events, based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020
       */
      @query("queryStartTime")
      queryStartTime?: string;
    }
  >;

  /**
   * Lists impacted resources in the subscription by an event (Security Advisory).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SecurityAdvisoryImpactedResources_ListBySubscriptionIdAndEventId")
  listBySubscriptionIdAndEventId is ArmResourceActionSync<
    Event,
    void,
    ResourceListResult<EventImpactedResource>,
    {
      ...BaseParameters<Event>;

      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Service health event details in the subscription by event tracking id. This can be used to fetch sensitive properties for Security Advisory events
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Event_fetchDetailsBySubscriptionIdAndTrackingId")
  fetchDetailsBySubscriptionIdAndTrackingId is ArmResourceActionSync<
    Event,
    void,
    Event
  >;
}
