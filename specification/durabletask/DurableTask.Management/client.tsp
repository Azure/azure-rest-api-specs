import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientNamespace(Microsoft.DurableTask,
  "com.azure.resourcemanager.durabletask",
  "java"
);
@@clientName(Microsoft.DurableTask, "DurableTaskMgmt", "python");
@@clientName(Microsoft.DurableTask, "DurableTaskManagementClient", "java");
