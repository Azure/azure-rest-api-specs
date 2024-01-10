import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.ResourceHealth;

interface AvailabilityStatusesOperations {
  @doc("Lists the current availability status for all the resources in the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @get
  ListBySubscriptionId is Azure.Core.Foundations.Operation<
    {
      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("Setting $expand=recommendedactions in url query expands the recommendedactions in the response.")
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatusListResult
  >;

  @doc("Lists the current availability status for all the resources in the resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Setting $expand=recommendedactions in url query expands the recommendedactions in the response.")
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatusListResult
  >;

  @doc("Gets current availability status for a single resource")
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses/current")
  @get
  GetByResource is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified ID of the resource, including the resource name and resource type. Currently the API support not nested and one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name} and /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}")
      @path
      resourceUri: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Setting $expand=recommendedactions in url query expands the recommendedactions in the response.")
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatus
  >;

  @doc("Lists all historical availability transitions and impacting events for a single resource.")
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/availabilityStatuses")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified ID of the resource, including the resource name and resource type. Currently the API support not nested and one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name} and /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}")
      @path
      resourceUri: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Setting $expand=recommendedactions in url query expands the recommendedactions in the response.")
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatusListResult
  >;
}

interface ImpactedResourcesOperations {
  @doc("Lists impacted resources in the tenant by an event.")
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/impactedResources")
  @get
  ListByTenantIdAndEventId is Azure.Core.Foundations.Operation<
    {
      @doc("Event Id which uniquely identifies ServiceHealth event.")
      @path
      eventTrackingId: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<EventImpactedResource>
  >;

  @doc("Gets the specific impacted resource in the tenant by an event.")
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/impactedResources/{impactedResourceName}")
  @get
  GetByTenantId is Azure.Core.Foundations.Operation<
    {
      @doc("Event Id which uniquely identifies ServiceHealth event.")
      @path
      eventTrackingId: string;

      @doc("Name of the Impacted Resource.")
      @pattern("^[^*#&+:<>%?]+$")
      @path
      impactedResourceName: string;
    },
    EventImpactedResource
  >;
}

interface SecurityAdvisoryImpactedResourcesOperations {
  @doc("Lists impacted resources in the tenant by an event (Security Advisory).")
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/listSecurityAdvisoryImpactedResources")
  @post
  ListByTenantIdAndEventId is Azure.Core.Foundations.Operation<
    {
      @doc("Event Id which uniquely identifies ServiceHealth event.")
      @path
      eventTrackingId: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<EventImpactedResource>
  >;
}

interface EventsOperations {
  @doc("Lists current service health events in the tenant.")
  @route("/providers/Microsoft.ResourceHealth/events")
  @get
  ListByTenantId is Azure.Core.Foundations.Operation<
    {
      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Specifies from when to return events, based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020")
      @query("queryStartTime")
      queryStartTime?: string;
    },
    ResourceListResult<Event>
  >;

  @doc("Lists current service health events for given resource.")
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/events")
  @get
  ListBySingleResource is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified ID of the resource, including the resource name and resource type. Currently the API support not nested and one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name} and /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}")
      @path
      resourceUri: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;
    },
    ResourceListResult<Event>
  >;
}

interface EventOperations {
  @doc("Service health event in the tenant by event tracking id")
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}")
  @get
  GetByTenantIdAndTrackingId is Azure.Core.Foundations.Operation<
    {
      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Specifies from when to return events, based on the lastUpdateTime property. For example, queryStartTime = 7/24/2020 OR queryStartTime=7%2F24%2F2020")
      @query("queryStartTime")
      queryStartTime?: string;

      @doc("Event Id which uniquely identifies ServiceHealth event.")
      @path
      eventTrackingId: string;
    },
    Event
  >;

  @doc("Service health event details in the tenant by event tracking id. This can be used to fetch sensitive properties for Security Advisory events")
  @route("/providers/Microsoft.ResourceHealth/events/{eventTrackingId}/fetchEventDetails")
  @post
  fetchDetailsByTenantIdAndTrackingId is Azure.Core.Foundations.Operation<
    {
      @doc("Event Id which uniquely identifies ServiceHealth event.")
      @path
      eventTrackingId: string;
    },
    Event
  >;
}

interface ChildAvailabilityStatusesOperations {
  @doc("Gets current availability status for a single resource")
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses/current")
  @get
  GetByResource is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified ID of the resource, including the resource name and resource type. Currently the API only support one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}")
      @path
      resourceUri: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Setting $expand=recommendedactions in url query expands the recommendedactions in the response.")
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatus
  >;

  @doc("Lists the historical availability statuses for a single child resource. Use the nextLink property in the response to get the next page of availability status")
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/childAvailabilityStatuses")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified ID of the resource, including the resource name and resource type. Currently the API only support one nesting level resource types : /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resource-provider-name}/{parentResourceType}/{parentResourceName}/{resourceType}/{resourceName}")
      @path
      resourceUri: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Setting $expand=recommendedactions in url query expands the recommendedactions in the response.")
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatusListResult
  >;
}

interface ChildResourcesOperations {
  @doc("Lists the all the children and its current health status for a parent resource. Use the nextLink property in the response to get the next page of children current health")
  @route("/{resourceUri}/providers/Microsoft.ResourceHealth/childResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The fully qualified ID of the resource, including the resource name and resource type. Currently the API only support not nested parent resource type: /subscriptions/{subscriptionId}/resourceGroups/{resource-group-name}/providers/{resource-provider-name}/{resource-type}/{resource-name}")
      @path
      resourceUri: string;

      @doc("The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN")
      @query("$filter")
      $filter?: string;

      @doc("Setting $expand=recommendedactions in url query expands the recommendedactions in the response.")
      @query("$expand")
      $expand?: string;
    },
    AvailabilityStatusListResult
  >;
}
