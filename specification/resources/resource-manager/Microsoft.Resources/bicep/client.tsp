import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using BicepClient;

@@clientName(BicepClient, "BicepMgmtClient", "python");

@@clientName(FileDefinition, "DecompiledFileDefinition", "csharp");
@@clientName(DecompileOperationGroup.bicep, "BicepDecompile", "csharp");
@@clientName(DecompileOperationRequest, "DecompileOperationContent", "csharp");
@@clientName(DecompileOperationSuccessResponse,
  "DecompileOperationSuccessResult",
  "csharp"
);
