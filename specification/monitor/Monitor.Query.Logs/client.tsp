import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using MonitorQueryLogs;

@TypeSpec.Versioning.useDependency(Versions.V1)
namespace ClientCustomizations;

@@clientDoc(BatchQueryRequest.path,
  "The path for the batch query request.",
  DocumentationMode.replace
);
@@alternateType(BatchQueryRequest.path, "/query");
@@clientDoc(BatchQueryRequest.method,
  "The method of a single request in a batch.",
  DocumentationMode.replace
);
@@alternateType(BatchQueryRequest.method, "POST");

@client(
  {
    name: "MonitorQueryLogsClient",
    service: MonitorQueryLogs,
  },
  "!go, !csharp"
)
interface MonitorQueryLogsClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  execute is MonitorQueryLogs.Query.execute;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  executeWithResourceId is MonitorQueryLogs.Query.executeWithResourceId;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  batch is MonitorQueryLogs.Query.batch;
}

// go and C# client definition
@client(
  {
    name: "Client",
    service: MonitorQueryLogs,
  },
  "go, csharp"
)
interface Client {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  queryWorkspace is MonitorQueryLogs.Query.execute;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  queryResource is MonitorQueryLogs.Query.executeWithResourceId;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  queryBatch is MonitorQueryLogs.Query.batch;
}

// Java configuration
@@clientNamespace(MonitorQueryLogs,
  "com.azure.monitor.query.logs.implementation",
  "java"
);
@@clientNamespace(ClientCustomizations,
  "com.azure.monitor.query.logs.implementation",
  "java"
);

// go configuration
@@access(Versions, Access.internal, "go,python");

@@clientName(BatchQueryRequest.workspace, "WorkspaceID", "go");

@@clientName(BatchQueryResults.render, "Visualization", "go");
@@alternateType(BatchQueryResults.render, unknown, "go");
@@alternateType(BatchQueryResults.statistics, unknown, "go");

@@clientName(QueryResults.render, "Visualization", "go");
@@alternateType(QueryResults.render, unknown, "go");
@@alternateType(QueryResults.statistics, unknown, "go");

@@clientName(ColumnDataType, "ColumnType", "go");

@@clientName(QueryBody.workspaces, "AdditionalWorkspaces", "go");

@@alternateType(Table.rows, bytes[][], "go");

@@clientName(ColumnDataType, "_ColumnType", "python");
@@access(MonitorQueryLogsClient.batch, Access.internal, "python");
@@access(MonitorQueryLogsClient.execute, Access.internal, "python");
@@access(MonitorQueryLogsClient.executeWithResourceId,
  Access.internal,
  "python"
);

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
@@access(Metric.name, Access.internal, "csharp");
@@access(Metric.errorCode, Access.internal, "csharp");
@@access(Metric.errorMessage, Access.internal, "csharp");
@@access(MonitorQueryMetrics.batch, Access.internal, "csharp");
@@access(MetricResultsResponseValuesItem.resourceid, Access.internal, "csharp");
@@access(MetricResultsResponseValuesItem.starttime, Access.internal, "csharp");
@@access(MetricResultsResponseValuesItem.endtime, Access.internal, "csharp");
