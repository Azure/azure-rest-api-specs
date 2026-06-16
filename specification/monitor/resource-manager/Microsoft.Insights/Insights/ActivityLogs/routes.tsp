// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ActivityLogs;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ActivityLogsOperationGroup {
  /**
   * Provides the list of records from the activity logs.
   */
  @autoRoute
  @get
  @action("eventtypes/management/values")
  @tag("ActivityLogs")
  @list
  list is ArmProviderActionSync<
    Response = EventDataCollection,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Reduces the set of data collected.<br>This argument is required and it also requires at least the start date/time.<br>The **$filter** argument is very restricted and allows only the following patterns.<br>- *List events for a resource group*: $filter=eventTimestamp ge '2014-07-16T04:36:37.6407898Z' and eventTimestamp le '2014-07-20T04:36:37.6407898Z' and resourceGroupName eq 'resourceGroupName'.<br>- *List events for resource*: $filter=eventTimestamp ge '2014-07-16T04:36:37.6407898Z' and eventTimestamp le '2014-07-20T04:36:37.6407898Z' and resourceUri eq 'resourceURI'.<br>- *List events for a subscription in a time range*: $filter=eventTimestamp ge '2014-07-16T04:36:37.6407898Z' and eventTimestamp le '2014-07-20T04:36:37.6407898Z'.<br>- *List events for a resource provider*: $filter=eventTimestamp ge '2014-07-16T04:36:37.6407898Z' and eventTimestamp le '2014-07-20T04:36:37.6407898Z' and resourceProvider eq 'resourceProviderName'.<br>- *List events for a correlation Id*: $filter=eventTimestamp ge '2014-07-16T04:36:37.6407898Z' and eventTimestamp le '2014-07-20T04:36:37.6407898Z' and correlationId eq 'correlationID'.<br><br>**NOTE**: No other syntax is allowed.
       */
      @query("$filter")
      $filter: string;

      /**
       * Used to fetch events with only the given properties.<br>The **$select** argument is a comma separated list of property names to be returned. Possible values are: *authorization*, *claims*, *correlationId*, *description*, *eventDataId*, *eventName*, *eventTimestamp*, *httpRequest*, *level*, *operationId*, *operationName*, *properties*, *resourceGroupName*, *resourceProviderName*, *resourceId*, *status*, *submissionTimestamp*, *subStatus*, *subscriptionId*
       */
      @query("$select")
      $select?: string;
    },
    Error = Microsoft.Common.ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface EventCategoriesOperationGroup {
  /**
   * Get the list of available event categories supported in the Activity Logs Service.<br>The current list includes the following: Administrative, Security, ServiceHealth, Alert, Recommendation, Policy.
   */
  @autoRoute
  @get
  @action("eventcategories")
  @tag("EventCategories")
  @list
  list is ArmProviderActionSync<
    Response = EventCategoryCollection,
    Error = Microsoft.Common.ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TenantActivityLogsOperationGroup {
  /**
   * Gets the Activity Logs for the Tenant.<br>Everything that is applicable to the API to get the Activity Logs for the subscription is applicable to this API (the parameters, $filter, etc.).<br>One thing to point out here is that this API does *not* retrieve the logs at the individual subscription of the tenant but only surfaces the logs that were generated at the tenant level.
   */
  @autoRoute
  @get
  @action("eventtypes/management/values")
  @tag("TenantActivityLogs")
  @list
  list is ArmProviderActionSync<
    Response = EventDataCollection,
    Parameters = {
      /**
       * Reduces the set of data collected. <br>The **$filter** is very restricted and allows only the following patterns.<br>- List events for a resource group: $filter=eventTimestamp ge '<Start Time>' and eventTimestamp le '<End Time>' and eventChannels eq 'Admin, Operation' and resourceGroupName eq '<ResourceGroupName>'.<br>- List events for resource: $filter=eventTimestamp ge '<Start Time>' and eventTimestamp le '<End Time>' and eventChannels eq 'Admin, Operation' and resourceUri eq '<ResourceURI>'.<br>- List events for a subscription: $filter=eventTimestamp ge '<Start Time>' and eventTimestamp le '<End Time>' and eventChannels eq 'Admin, Operation'.<br>- List events for a resource provider: $filter=eventTimestamp ge '<Start Time>' and eventTimestamp le '<End Time>' and eventChannels eq 'Admin, Operation' and resourceProvider eq '<ResourceProviderName>'.<br>- List events for a correlation Id: api-version=2014-04-01&$filter=eventTimestamp ge '2014-07-16T04:36:37.6407898Z' and eventTimestamp le '2014-07-20T04:36:37.6407898Z' and eventChannels eq 'Admin, Operation' and correlationId eq '<CorrelationID>'.<br>**NOTE**: No other syntax is allowed.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Used to fetch events with only the given properties.<br>The **$select** argument is a comma separated list of property names to be returned. Possible values are: *authorization*, *claims*, *correlationId*, *description*, *eventDataId*, *eventName*, *eventTimestamp*, *httpRequest*, *level*, *operationId*, *operationName*, *properties*, *resourceGroupName*, *resourceProviderName*, *resourceId*, *status*, *submissionTimestamp*, *subStatus*, *subscriptionId*
       */
      @query("$select")
      $select?: string;
    },
    Error = Microsoft.Common.ErrorResponse
  >;
}
