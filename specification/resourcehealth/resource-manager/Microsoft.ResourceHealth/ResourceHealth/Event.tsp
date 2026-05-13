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

@armResourceOperations(#{ omitTags: true })
interface EventOperationGroup {
  /**
   * Service health event in the subscription by event tracking id
   */
  @tag("Event")
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
    },
    ErrorType = ErrorResponse
  >;

  /**
   * Lists service health events in the subscription.
   */
  @tag("Events")
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
    Response = ArmResponse<Events>,
    ErrorType = ErrorResponse
  >;

  /**
   * Lists impacted resources in the subscription by an event (Security Advisory).
   */
  @list
  @action("listSecurityAdvisoryImpactedResources")
  @tag("SecurityAdvisoryImpactedResources")
  listBySubscriptionIdAndEventId is EventOperationGroupOps.ActionSync<
    Event,
    void,
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

  /**
   * Service health event details in the subscription by event tracking id. This can be used to fetch sensitive properties for Security Advisory events. Please see https://learn.microsoft.com/en-us/azure/service-health/security-advisories-elevated-access
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Event_fetchDetailsBySubscriptionIdAndTrackingId")
  @action("fetchEventDetails")
  @tag("Event")
  fetchDetailsBySubscriptionIdAndTrackingId is EventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<Event>,
    ErrorType = ErrorResponse
  >;

  /**
   * Service health event details specific in the subscription by event tracking id. This can be used to fetch sensitive properties for Billing event type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Event_fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId")
  @action("fetchBillingCommunicationDetails")
  @tag("Event")
  fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId is EventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<Event>,
    ErrorType = ErrorResponse
  >;
}
alias TenantEventOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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

@armResourceOperations(#{ omitTags: true })
interface TenantEventOperationGroup {
  /**
   * Service health event in the tenant by event tracking id
   */
  @tag("Event")
  getByTenantIdAndTrackingId is TenantEventOperationGroupOps.Read<
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
    ErrorType = ErrorResponse
  >;

  /**
   * Lists current service health events in the tenant.
   */
  @tag("Events")
  listByTenantId is TenantEventOperationGroupOps.List<
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
    Response = ArmResponse<Events>,
    ErrorType = ErrorResponse
  >;

  /**
   * Lists impacted resources in the tenant by an event (Security Advisory).
   */
  @list
  @action("listSecurityAdvisoryImpactedResources")
  @tag("SecurityAdvisoryImpactedResources")
  listByTenantIdAndEventId is TenantEventOperationGroupOps.ActionSync<
    Event,
    void,
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

  /**
   * Service health event details in the tenant by event tracking id. This can be used to fetch sensitive properties for Security Advisory events. Please see https://learn.microsoft.com/en-us/azure/service-health/security-advisories-elevated-access
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Event_fetchDetailsByTenantIdAndTrackingId")
  @action("fetchEventDetails")
  @tag("Event")
  fetchDetailsByTenantIdAndTrackingId is TenantEventOperationGroupOps.ActionSync<
    Event,
    void,
    ArmResponse<Event>,
    ErrorType = ErrorResponse
  >;
}

@@doc(Event.name, "Event Id which uniquely identifies ServiceHealth event.");
@@doc(Event.properties, "Properties of event.");
