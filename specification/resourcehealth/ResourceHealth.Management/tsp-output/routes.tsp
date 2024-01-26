import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ResourceHealth;

interface AvailabilityStatusesOperations {
  /**
   * Lists the current availability status for all the resources in the subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @get
  listBySubscriptionId is Azure.Core.Foundations.Operation<
    {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
       */
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatusListResult
  >;

  /**
   * Lists the current availability status for all the resources in the resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

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
    AvailabilityStatusListResult
  >;

  /**
   * Gets current availability status for a single resource
   */
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses/current")
  @get
  getByResource is Azure.Core.Foundations.Operation<
    {
      /**
       * The fully qualified ID of the resource, including the resource name and resource type. Currently the API support not nested and one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name} and /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}
       */
      @path
      resourceUri: string;

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
    AvailabilityStatus
  >;

  /**
   * Lists all historical availability transitions and impacting events for a single resource.
   */
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The fully qualified ID of the resource, including the resource name and resource type. Currently the API support not nested and one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name} and /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}
       */
      @path
      resourceUri: string;

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
    AvailabilityStatusListResult
  >;
}

interface ImpactedResourcesOperations {
  /**
   * Lists impacted resources in the tenant by an event.
   */
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/impactedResources")
  @get
  listByTenantIdAndEventId is Azure.Core.Foundations.Operation<
    {
      /**
       * Event Id which uniquely identifies ServiceHealth event.
       */
      @path
      eventTrackingId: string;

      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<EventImpactedResource>
  >;

  /**
   * Gets the specific impacted resource in the tenant by an event.
   */
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/impactedResources/{impactedResourceName}")
  @get
  getByTenantId is Azure.Core.Foundations.Operation<
    {
      /**
       * Event Id which uniquely identifies ServiceHealth event.
       */
      @path
      eventTrackingId: string;

      /**
       * Name of the Impacted Resource.
       */
      @pattern("^[^*#&+:<>%?]+$")
      @path
      impactedResourceName: string;
    },
    EventImpactedResource
  >;
}

interface SecurityAdvisoryImpactedResourcesOperations {
  /**
   * Lists impacted resources in the tenant by an event (Security Advisory).
   */
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/listSecurityAdvisoryImpactedResources")
  @post
  listByTenantIdAndEventId is Azure.Core.Foundations.Operation<
    {
      /**
       * Event Id which uniquely identifies ServiceHealth event.
       */
      @path
      eventTrackingId: string;

      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<EventImpactedResource>
  >;
}

interface EventsOperations {
  /**
   * Lists current service health events in the tenant.
   */
  @route("/providers/Microsoft.ResourceHealth/events")
  @get
  listByTenantId is Azure.Core.Foundations.Operation<
    {
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
    },
    ResourceListResult<Event>
  >;

  /**
   * Lists current service health events for given resource.
   */
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/events")
  @get
  listBySingleResource is Azure.Core.Foundations.Operation<
    {
      /**
       * The fully qualified ID of the resource, including the resource name and resource type. Currently the API support not nested and one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name} and /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}
       */
      @path
      resourceUri: string;

      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<Event>
  >;
}

interface EventOperations {
  /**
   * Service health event in the tenant by event tracking id
   */
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}")
  @get
  getByTenantIdAndTrackingId is Azure.Core.Foundations.Operation<
    {
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

      /**
       * Event Id which uniquely identifies ServiceHealth event.
       */
      @path
      eventTrackingId: string;
    },
    Event
  >;

  /**
   * Service health event details in the tenant by event tracking id. This can be used to fetch sensitive properties for Security Advisory events
   */
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/fetchEventDetails")
  @post
  fetchDetailsByTenantIdAndTrackingId is Azure.Core.Foundations.Operation<
    {
      /**
       * Event Id which uniquely identifies ServiceHealth event.
       */
      @path
      eventTrackingId: string;
    },
    Event
  >;
}

interface ChildAvailabilityStatusesOperations {
  /**
   * Gets current availability status for a single resource
   */
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses/current")
  @get
  getByResource is Azure.Core.Foundations.Operation<
    {
      /**
       * The fully qualified ID of the resource, including the resource name and resource type. Currently the API only support one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}
       */
      @path
      resourceUri: string;

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
    AvailabilityStatus
  >;

  /**
   * Lists the historical availability statuses for a single child resource. Use the nextLink property in the response to get the next page of availability status
   */
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The fully qualified ID of the resource, including the resource name and resource type. Currently the API only support one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}
       */
      @path
      resourceUri: string;

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
    AvailabilityStatusListResult
  >;
}

interface ChildResourcesOperations {
  /**
   * Lists the all the children and its current health status for a parent resource. Use the nextLink property in the response to get the next page of children current health
   */
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/childResources")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The fully qualified ID of the resource, including the resource name and resource type. Currently the API only support not nested parent resource type: /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name}
       */
      @path
      resourceUri: string;

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
    AvailabilityStatusListResult
  >;
}
