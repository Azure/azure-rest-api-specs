import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Edge, "WorkloadOrchestrationMgmtClient", "python");
@@clientName(Microsoft.Edge,
  "WorkloadOrchestrationManagementClient",
  "javascript"
);
