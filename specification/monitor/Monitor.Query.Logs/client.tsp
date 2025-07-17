import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using MonitorQueryLogs;

@TypeSpec.Versioning.useDependency(Versions.V1)
namespace ClientCustomizations;

@client({
  name: "MonitorQueryLogsClient",
  service: MonitorQueryLogs,
})
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
