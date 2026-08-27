import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using AzureDevCompute;

namespace AzureDevCompute;

@@clientName(SandboxFields.appUrl, "appUri", "csharp");
@@clientName(SandboxFields.managementUrl, "managementUri", "csharp");
@@clientName(GatewayConnection.mcpRuntimeUrl, "mcpRuntimeUri", "csharp");
@@clientName(
  GatewayConnection.connectionRuntimeUrl,
  "connectionRuntimeUri",
  "csharp"
);
@@clientName(ErrorResponse, "ErrorResult", "csharp");
@@clientName(AddPortRequest, "AddPortContent", "csharp");
@@clientName(
  SandboxExecutionTokenResponse,
  "SandboxExecutionTokenResult",
  "csharp"
);
@@clientName(
  SandboxExecutionTokensRequest,
  "SandboxExecutionTokensContent",
  "csharp"
);
@@clientName(SandboxRequest, "SandboxContent", "csharp");
@@clientName(
  AzureDevCompute.SandboxListResponse,
  "SandboxListResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxCreatedResponse,
  "SandboxCreatedResult",
  "csharp"
);
@@clientName(AzureDevCompute.SandboxResponse, "SandboxResult", "csharp");
@@clientName(
  AzureDevCompute.SandboxDeletedResponse,
  "SandboxDeletedResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxDeletedNoContentResponse,
  "SandboxDeletedNoContentResult",
  "csharp"
);
