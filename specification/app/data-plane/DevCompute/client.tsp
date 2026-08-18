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
