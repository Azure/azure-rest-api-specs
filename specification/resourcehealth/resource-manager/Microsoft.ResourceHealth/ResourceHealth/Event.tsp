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
 * Service health event
 */
@subscriptionResource
model Event is Azure.ResourceManager.ProxyResource<EventProperties> {
  ...ResourceNameParameter<
    Resource = Event,
    KeyName = "eventTrackingId",
    SegmentName = "events",
    NamePattern = ""
  >;
}

alias EventOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.ResourceHealth";
  },
  {},
  {
    /** Event Id which uniquely identifies ServiceHealth event. */
    @path
    @segment("events")
    @key
    eventTrackingId: string;
  }
>;

@armResourceOperations
interface EventOperationGroup {
  /**
   * Service health event in the subscription by event tracking id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Event_GetBySubscriptionIdAndTrackingId")
  getBySubscriptionIdAndTrackingId is EventOperationGroupOps.Read<
    Event,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies from when to return events (default is 3 days), based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020
       */
      @query("queryStartTime")
      queryStartTime?: string;
    }
  >;

  /**
   * Lists service health events in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Events_ListBySubscriptionId")
  listBySubscriptionId is EventOperationGroupOps.List<
    Event,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies from when to return events (default is 3 days), based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020
       */
      @query("queryStartTime")
      queryStartTime?: string;
    },
    Response = ArmResponse<Events>
  >;

  /**
   * Lists impacted resources in the subscription by an event (Security Advisory).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecurityAdvisoryImpactedResources_ListBySubscriptionIdAndEventId")
  @list
  @action("listSecurityAdvisoryImpactedResources")
  listBySubscriptionIdAndEventId is EventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<ResourceListResult<EventImpactedResource>>,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Service health event details in the subscription by event tracking id. This can be used to fetch sensitive properties for Security Advisory events. Please see https://learn.microsoft.com/en-us/azure/service-health/security-advisories-elevated-access
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Event_fetchDetailsBySubscriptionIdAndTrackingId")
  @action("fetchEventDetails")
  fetchDetailsBySubscriptionIdAndTrackingId is EventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<Event>
  >;

  /**
   * Service health event details specific in the subscription by event tracking id. This can be used to fetch sensitive properties for Billing event type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Event_fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId")
  @action("fetchBillingCommunicationDetails")
  fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId is EventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<Event>
  >;
}
alias EventOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.ResourceHealth";
  },
  {},
  {
    /** Event Id which uniquely identifies ServiceHealth event. */
    @path
    @segment("events")
    @key
    eventTrackingId: string;
  }
>;

@armResourceOperations
interface EventOperationGroup {
  /**
   * Service health event in the tenant by event tracking id
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Event_GetByTenantIdAndTrackingId")
  getByTenantIdAndTrackingId is EventOperationGroupOps.Read<
    Event,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies from when to return events (default is 3 days), based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020
       */
      @query("queryStartTime")
      queryStartTime?: string;
    }
  >;

  /**
   * Lists current service health events in the tenant.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Events_ListByTenantId")
  listByTenantId is EventOperationGroupOps.List<
    Event,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies from when to return events (default is 3 days), based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020
       */
      @query("queryStartTime")
      queryStartTime?: string;
    },
    Response = ArmResponse<Events>
  >;

  /**
   * Lists impacted resources in the tenant by an event (Security Advisory).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SecurityAdvisoryImpactedResources_ListByTenantIdAndEventId")
  @list
  @action("listSecurityAdvisoryImpactedResources")
  listByTenantIdAndEventId is EventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<ResourceListResult<EventImpactedResource>>,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Service health event details in the tenant by event tracking id. This can be used to fetch sensitive properties for Security Advisory events. Please see https://learn.microsoft.com/en-us/azure/service-health/security-advisories-elevated-access
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Event_fetchDetailsByTenantIdAndTrackingId")
  @action("fetchEventDetails")
  fetchDetailsByTenantIdAndTrackingId is EventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<Event>
  >;
}

@@doc(Event.name, "Event Id which uniquely identifies ServiceHealth event.");
@@doc(Event.properties, "Properties of event.");
