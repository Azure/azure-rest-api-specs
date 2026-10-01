import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;

namespace MonitorQueryMetrics;

/** Lists the metric values for multiple resources. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
@route("/subscriptions/{subscriptionId}/metrics:getBatch")
@post
op batch is Azure.Core.Foundations.Operation<
  {
    /** The subscription identifier for the resources in this batch. */
    @path
    subscriptionId: uuid;

    /**
     * The start time of the query. It is a string in the format
     * 'yyyy-MM-ddTHH:mm:ss.fffZ'. If you have specified the endtime parameter, then
     * this parameter is required.
     * If only starttime is specified, then endtime defaults to the current time.
     * If no time interval is specified, the default is 1 hour.
     */
    @query("starttime")
    startTime?: string;

    /** The end time of the query. It is a string in the format 'yyyy-MM-ddTHH:mm:ss.fffZ'. */
    @query("endtime")
    endTime?: string;

    /**
     * The interval (i.e. timegrain) of the query in ISO 8601 duration format.
     * Defaults to PT1M. Special case for 'FULL' value that returns single datapoint
     * for entire time span requested.
     * *Examples: PT15M, PT1H, P1D, FULL*
     */
    @query("interval")
    interval?: string = "PT1M";

    /** Metric namespace that contains the requested metric names. */
    @query("metricnamespace")
    metricNamespace: string;

    /** The names of the metrics (comma separated) to retrieve. */
    @query("metricnames")
    metricNames: string[];

    /** The list of aggregation types (comma separated) to retrieve. *Examples: average, minimum, maximum* */
    @query("aggregation")
    aggregation?: string;

    /**
     * The maximum number of records to retrieve per resource ID in the request.
     * Valid only if filter is specified.
     * Defaults to 10.
     */
    @query("top")
    top?: int32;

    /**
     * The aggregation to use for sorting results and the direction of the sort.
     * Only one order can be specified.
     * *Examples: sum asc*
     */
    @query("orderby")
    orderBy?: string;

    /**
     * The filter is used to reduce the set of metric data
     * returned.<br>Example:<br>Metric contains metadata A, B and C.<br>- Return all
     * time series of C where A = a1 and B = b1 or b2<br>**filter=A eq ‘a1’ and B eq
     * ‘b1’ or B eq ‘b2’ and C eq ‘*’**<br>- Invalid variant:<br>**filter=A eq ‘a1’
     * and B eq ‘b1’ and C eq ‘*’ or B = ‘b2’**<br>This is invalid because the logical
     * or operator cannot separate two different metadata names.<br>- Return all time
     * series where A = a1, B = b1 and C = c1:<br>**filter=A eq ‘a1’ and B eq ‘b1’ and
     * C eq ‘c1’**<br>- Return all time series where A = a1<br>**filter=A eq ‘a1’ and
     * B eq ‘*’ and C eq ‘*’**.
     */
    @query("filter")
    filter?: string;

    /**
     * Dimension name(s) to rollup results by. For example if you only want to see
     * metric values with a filter like 'City eq Seattle or City eq Tacoma' but don't
     * want to see separate values for each city, you can specify 'RollUpBy=City' to
     * see the results for Seattle and Tacoma rolled up into one timeseries.
     */
    @query("rollupby")
    rollUpBy?: string;

    /** Body Parameter content-type */
    @header("content-type")
    contentType: "application/json";

    /** Metrics batch body including the list of resource ids */
    @bodyRoot
    @clientName("resourceIDs", "go")
    batchRequest: ResourceIdList;
  },
  MonitorQueryMetrics.MetricResultsResponse,
  {},
  Azure.ResourceManager.CommonTypes.ErrorResponse
>;
