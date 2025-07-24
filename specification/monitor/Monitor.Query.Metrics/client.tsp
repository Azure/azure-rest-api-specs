import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace ClientCustomizations;

@@clientName(MonitorQueryMetrics, "Client", "go");

@@clientName(MonitorQueryMetrics.batch, "queryResources");

using MonitorQueryMetrics;

@@clientNamespace(MonitorQueryMetrics,
  "com.azure.monitor.query.metrics.implementation",
  "java"
);

@@clientNamespace(MonitorQueryMetrics.MetricUnit, "com.azure.monitor.query.metrics", "java");
@@clientNamespace(MonitorQueryMetrics.Metric, "com.azure.monitor.query.metrics", "java");
@@clientNamespace(MonitorQueryMetrics.MetricResultsResponse, "com.azure.monitor.query.metrics", "java");
@@clientNamespace(MonitorQueryMetrics.MetricResultsResponseValuesItem, "com.azure.monitor.query.metrics", "java");

@@clientName(MonitorQueryMetrics.MetricResultsResponse, "MetricsQueryResourcesResult", "java");
@@clientName(MonitorQueryMetrics.MetricResultsResponseValuesItem, "MetricsQueryResult", "java");
@@clientName(MonitorQueryMetrics.MetricResultsResponseValuesItem.value, "metrics", "java");

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

@@clientName(Metric.timeseries, "TimeSeries", "go,java");
