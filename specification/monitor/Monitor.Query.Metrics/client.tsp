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
