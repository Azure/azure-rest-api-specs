import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Insights;

interface ActivityLogsOperations {
  /**
   * Provides the list of records from the activity logs.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Insights/eventtypes/management/values")
  @get
  list is Azure.Core.Foundations.Operation<
    {
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

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    EventDataCollection
  >;
}

interface EventCategoriesOperations {
  /**
   * Get the list of available event categories supported in the Activity Logs Service.<br>The current list includes the following: Administrative, Security, ServiceHealth, Alert, Recommendation, Policy.
   */
  @route("/providers/Microsoft.Insights/eventcategories")
  @get
  list is Azure.Core.Foundations.Operation<{}, EventCategoryCollection>;
}

interface TenantActivityLogsOperations {
  /**
   * Gets the Activity Logs for the Tenant.<br>Everything that is applicable to the API to get the Activity Logs for the subscription is applicable to this API (the parameters, $filter, etc.).<br>One thing to point out here is that this API does *not* retrieve the logs at the individual subscription of the tenant but only surfaces the logs that were generated at the tenant level.
   */
  @route("/providers/Microsoft.Insights/eventtypes/management/values")
  @get
  list is Azure.Core.Foundations.Operation<
    {
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
    EventDataCollection
  >;
}

interface MetricDefinitionsOperations {
  /**
   * Lists the metric definitions for the resource.
   */
  @route("/{resourceUri}/providers/Microsoft.Insights/metricDefinitions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * Metric namespace to query metric definitions for.
       */
      @query("metricnamespace")
      metricnamespace?: string;
    },
    MetricDefinitionCollection
  >;
}

interface MetricsOperations {
  /**
   * **Lists the metric data for a subscription**.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Insights/metrics")
  @get
  listAtSubscriptionScope is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The region where the metrics you want reside.
       */
      @query("region")
      region: string;

      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      @query("timespan")
      timespan?: string;

      /**
       * The interval (i.e. timegrain) of the query.
       */
      @query("interval")
      interval?: duration;

      /**
       * The names of the metrics (comma separated) to retrieve.
       */
      @query("metricnames")
      metricnames?: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       */
      @query("aggregation")
      aggregation?: string;

      /**
* The maximum number of records to retrieve.
Valid only if $filter is specified.
Defaults to 10.
*/
      @query("top")
      top?: int32;

      /**
* The aggregation to use for sorting results and the direction of the sort.
Only one order can be specified.
Examples: sum asc.
*/
      @query("orderby")
      orderby?: string;

      /**
       * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
       */
      @query("resultType")
      resultType?: MetricResultType;

      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;

      /**
       * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
       */
      @query("AutoAdjustTimegrain")
      AutoAdjustTimegrain?: boolean;

      /**
       * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
       */
      @query("ValidateDimensions")
      ValidateDimensions?: boolean;
    },
    SubscriptionScopeMetricResponse
  >;

  /**
   * **Lists the metric data for a subscription**. Parameters can be specified on either query params or the body.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Insights/metrics")
  @post
  listAtSubscriptionScopePost is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The region where the metrics you want reside.
       */
      @query("region")
      region: string;

      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      @query("timespan")
      timespan?: string;

      /**
       * The interval (i.e. timegrain) of the query.
       */
      @query("interval")
      interval?: duration;

      /**
       * The names of the metrics (comma separated) to retrieve.
       */
      @query("metricnames")
      metricnames?: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       */
      @query("aggregation")
      aggregation?: string;

      /**
* The maximum number of records to retrieve.
Valid only if $filter is specified.
Defaults to 10.
*/
      @query("top")
      top?: int32;

      /**
* The aggregation to use for sorting results and the direction of the sort.
Only one order can be specified.
Examples: sum asc.
*/
      @query("orderby")
      orderby?: string;

      /**
       * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
       */
      @query("resultType")
      resultType?: MetricResultType;

      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;

      /**
       * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
       */
      @query("AutoAdjustTimegrain")
      AutoAdjustTimegrain?: boolean;

      /**
       * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
       */
      @query("ValidateDimensions")
      ValidateDimensions?: boolean;

      /**
       * Parameters serialized in the body
       */
      @body
      body?: SubscriptionScopeMetricsRequestBodyParameters;
    },
    SubscriptionScopeMetricResponse
  >;

  /**
   * **Lists the metric values for a resource**.
   */
  @route("/{resourceUri}/providers/Microsoft.Insights/metrics")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      @query("timespan")
      timespan?: string;

      /**
       * The interval (i.e. timegrain) of the query.
       */
      @query("interval")
      interval?: duration;

      /**
       * The names of the metrics (comma separated) to retrieve.
       */
      @query("metricnames")
      metricnames?: string;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       */
      @query("aggregation")
      aggregation?: string;

      /**
* The maximum number of records to retrieve.
Valid only if $filter is specified.
Defaults to 10.
*/
      @query("top")
      top?: int32;

      /**
* The aggregation to use for sorting results and the direction of the sort.
Only one order can be specified.
Examples: sum asc.
*/
      @query("orderby")
      orderby?: string;

      /**
       * The **$filter** is used to reduce the set of metric data returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all time series of C where A = a1 and B = b1 or b2<br>**$filter=A eq ‘a1’ and B eq ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical or operator cannot separate two different metadata names.<br>- Return all time series where A = a1, B = b1 and C = c1:<br>**$filter=A eq ‘a1’ and B eq ‘b1’ and C eq ‘c1’**<br>- Return all time series where A = a1<br>**$filter=A eq ‘a1’ and B eq ‘*’ and C eq ‘*’**.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Reduces the set of data collected. The syntax allowed depends on the operation. See the operation's description for details.
       */
      @query("resultType")
      resultType?: ResultType;

      /**
       * Metric namespace where the metrics you want reside.
       */
      @query("metricnamespace")
      metricnamespace?: string;

      /**
       * When set to true, if the timespan passed in is not supported by this metric, the API will return the result using the closest supported timespan. When set to false, an error is returned for invalid timespan parameters. Defaults to false.
       */
      @query("AutoAdjustTimegrain")
      AutoAdjustTimegrain?: boolean;

      /**
       * When set to false, invalid filter parameter values will be ignored. When set to true, an error is returned for invalid filter parameters. Defaults to true.
       */
      @query("ValidateDimensions")
      ValidateDimensions?: boolean;
    },
    Response
  >;
}

interface BaselinesOperations {
  /**
   * **Lists the metric baseline values for a resource**.
   */
  @route("/{resourceUri}/providers/Microsoft.Insights/metricBaselines")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * The names of the metrics (comma separated) to retrieve. Special case: If a metricname itself has a comma in it then use %2 to indicate it. Eg: 'Metric,Name1' should be **'Metric%2Name1'**
       */
      @query("metricnames")
      metricnames?: string;

      /**
       * Metric namespace to query metric definitions for.
       */
      @query("metricnamespace")
      metricnamespace?: string;

      /**
       * The timespan of the query. It is a string with the following format 'startDateTime_ISO/endDateTime_ISO'.
       */
      @query("timespan")
      timespan?: string;

      /**
       * The interval (i.e. timegrain) of the query.
       */
      @query("interval")
      interval?: duration;

      /**
       * The list of aggregation types (comma separated) to retrieve.
       */
      @query("aggregation")
      aggregation?: string;

      /**
       * The list of sensitivities (comma separated) to retrieve.
       */
      @query("sensitivities")
      sensitivities?: string;

      /**
       * The **$filter** is used to reduce the set of metric data returned. Example: Metric contains metadata A, B and C. - Return all time series of C where A = a1 and B = b1 or b2 **$filter=A eq 'a1' and B eq 'b1' or B eq 'b2' and C eq '*'** - Invalid variant: **$filter=A eq 'a1' and B eq 'b1' and C eq '*' or B = 'b2'** This is invalid because the logical or operator cannot separate two different metadata names. - Return all time series where A = a1, B = b1 and C = c1: **$filter=A eq 'a1' and B eq 'b1' and C eq 'c1'** - Return all time series where A = a1 **$filter=A eq 'a1' and B eq '*' and C eq '*'**. Special case: When dimension name or dimension value uses round brackets. Eg: When dimension name is **dim (test) 1** Instead of using $filter= "dim (test) 1 eq '*' " use **$filter= "dim %2528test%2529 1 eq '*' "** When dimension name is **dim (test) 3** and dimension value is **dim3 (test) val** Instead of using $filter= "dim (test) 3 eq 'dim3 (test) val' " use **$filter= "dim %2528test%2529 3 eq 'dim3 %2528test%2529 val' "**
       */
      @query("$filter")
      $filter?: string;

      /**
       * Allows retrieving only metadata of the baseline. On data request all information is retrieved.
       */
      @query("resultType")
      resultType?: ResultType;
    },
    MetricBaselinesResponse
  >;
}

interface MetricNamespacesOperations {
  /**
   * Lists the metric namespaces for the resource.
   */
  @route("/{resourceUri}/providers/microsoft.insights/metricNamespaces")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * The identifier of the resource.
       */
      @path
      resourceUri: string;

      /**
       * The ISO 8601 conform Date start time from which to query for metric namespaces.
       */
      @query("startTime")
      startTime?: string;
    },
    MetricNamespaceCollection
  >;
}

interface PrivateLinkScopeOperationStatusOperations {
  /**
   * Get the status of an azure asynchronous operation associated with a private link scope operation.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.insights/privateLinkScopeOperationStatuses/{asyncOperationId}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * The operation Id.
       */
      @path
      asyncOperationId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;
    },
    OperationStatus
  >;
}
