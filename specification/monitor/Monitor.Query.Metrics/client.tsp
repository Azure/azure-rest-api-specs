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

@@clientNamespace(MonitorQueryMetrics.MetricValue,
  "com.azure.monitor.query.metrics",
  "java"
);

@@clientNamespace(MonitorQueryMetrics.MetricUnit,
  "com.azure.monitor.query.metrics",
  "java"
);

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

@@clientName(MonitorQueryMetrics, "MetricsClient", "python");
@@access(batch, Access.internal, "python");

@@clientName(MonitorQueryMetrics, "MetricsClient", "javascript");
@@clientName(MetricResultsResponseValuesItem.resourceid,
  "resourceId",
  "javascript"
);
@@clientName(MetricResultsResponseValuesItem.resourceregion,
  "resourceRegion",
  "javascript"
);
@@clientName(MetricResultsResponseValuesItem.starttime,
  "startTime",
  "javascript"
);
@@clientName(MetricResultsResponseValuesItem.endtime, "endTime", "javascript");
@@clientName(MetricResultsResponseValuesItem.value, "metrics", "javascript");
@@clientName(Metric.displayDescription, "description", "javascript");

// .NET configuration
@@clientName(Metric, "MetricResult", "csharp");
@@clientName(MonitorQueryMetrics, "MetricsClient", "csharp");
@@clientName(MetricResultsResponse, "MetricsQueryResourcesResult", "csharp");
@@clientName(MetricResultsResponseValuesItem, "MetricsQueryResult", "csharp");
@@clientName(TimeSeriesElement, "MetricTimeSeriesElement", "csharp");

@@clientName(MetricResultsResponseValuesItem.value, "Metrics", "csharp");
@@clientName(MetricResultsResponseValuesItem.interval, "Granularity", "csharp");
@@clientName(MetricResultsResponseValuesItem.starttime, "StartTime", "csharp");
@@clientName(MetricResultsResponseValuesItem.endtime, "EndTime", "csharp");
@@clientName(Metric.displayDescription, "Description", "csharp");
@@clientName(Metric.timeseries, "TimeSeries", "csharp");
@@clientName(Metric.name, "LocalizedName", "csharp");
@@clientName(TimeSeriesElement.data, "Values", "csharp");
@@clientName(MetricResultsResponseValuesItem.resourceid,
  "ResourceId",
  "csharp"
);
@@clientName(MetricResultsResponseValuesItem.resourceregion,
  "ResourceRegion",
  "csharp"
);

@@access(ResourceIdList, Access.internal, "csharp");
@@access(MonitorQueryMetrics.batch, Access.internal, "csharp");
