import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace ClientCustomizations;

@@clientName(MonitorQueryMetrics, "Client", "go");

@@clientName(MonitorQueryMetrics.batch, "queryResources");

using MonitorQueryMetrics;

@@clientName(MetricResultsResponse, "MetricResults", "go");

@@clientName(ResourceIdList.resourceids, "ResourceIDs", "go");

@@clientName(TimeSeriesElement.metadatavalues, "MetadataValues", "go");

@@clientName(MetricResultsResponseValuesItem, "MetricData", "go");
@@clientName(MetricResultsResponseValuesItem.starttime, "StartTime", "go");
@@clientName(MetricResultsResponseValuesItem.endtime, "EndTime", "go");
@@clientName(MetricResultsResponseValuesItem.value, "Values", "go");
@@clientName(MetricResultsResponseValuesItem.resourceid, "ResourceID", "go");
@@clientName(MetricResultsResponseValuesItem.resourceregion,
  "ResourceRegion",
  "go"
);

@@clientName(Metric.timeseries, "TimeSeries", "go");
