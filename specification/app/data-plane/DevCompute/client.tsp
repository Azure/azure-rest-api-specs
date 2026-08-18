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
@@clientName(
  AzureDataPlaneClientCredentialsFlow.tokenUrl,
  "tokenUri",
  "csharp"
);
@@clientName(
  UserAuthorizationCodeFlow.authorizationUrl,
  "authorizationUri",
  "csharp"
);
@@clientName(UserAuthorizationCodeFlow.tokenUrl, "tokenUri", "csharp");
@@clientName(ErrorResponse, "ErrorResult", "csharp");
@@clientName(AddPortRequest, "AddPortContent", "csharp");
@@clientName(PatchSandboxRequest, "PatchSandboxContent", "csharp");
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
  AzureDevCompute.SandboxOperations.SandboxListResponse,
  "SandboxListResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxOperations.SandboxCreatedResponse,
  "SandboxCreatedResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxOperations.SandboxResponse,
  "SandboxResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxOperations.SandboxDeletedResponse,
  "SandboxDeletedResult",
  "csharp"
);
@@clientName(
  AzureDevCompute.SandboxOperations.SandboxDeletedNoContentResponse,
  "SandboxDeletedNoContentResult",
  "csharp"
);
