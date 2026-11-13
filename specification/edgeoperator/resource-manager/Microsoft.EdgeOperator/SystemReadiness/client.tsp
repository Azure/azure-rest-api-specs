import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.EdgeOperator, "EdgeOperatorMgmtClient", "python");

@@clientName(
  Microsoft.EdgeOperator.SystemReadinessProperties.systemReady,
  "IsSystemReady",
  "csharp"
);
