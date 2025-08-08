import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(BicepClient, "BicepMgmtClient", "python");

@@clientName(BicepClient.DecompileOperationSuccessResponse,
  "DecompileOperationSuccessResult",
  "csharp"
);
@@clientName(BicepClient.FileDefinition, "DecompiledFile", "csharp");
