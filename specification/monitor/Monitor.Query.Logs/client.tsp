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
  "!go"
)
interface MonitorQueryLogsClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  execute is MonitorQueryLogs.Query.execute;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  executeWithResourceId is MonitorQueryLogs.Query.executeWithResourceId;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  batch is MonitorQueryLogs.Query.batch;
}

@@clientNamespace(MonitorQueryLogs,
  "com.azure.monitor.query.logs.implementation",
  "java"
);
@@clientNamespace(ClientCustomizations,
  "com.azure.monitor.query.logs.implementation",
  "java"
);

// go configuration
@client(
  {
    name: "Client",
    service: MonitorQueryLogs,
  },
  "go"
)
interface Client {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  queryWorkspace is MonitorQueryLogs.Query.execute;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  queryResource is MonitorQueryLogs.Query.executeWithResourceId;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  queryBatch is MonitorQueryLogs.Query.batch;
}

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
