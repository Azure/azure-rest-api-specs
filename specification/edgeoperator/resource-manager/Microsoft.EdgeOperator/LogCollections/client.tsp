import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(
  Microsoft.EdgeOperator.CollectLogsRequest,
  "CollectLogsContent",
  "csharp"
);
@@clientName(
  Microsoft.EdgeOperator.CollectLogsIndirectRequest,
  "CollectLogsIndirectContent",
  "csharp"
);
