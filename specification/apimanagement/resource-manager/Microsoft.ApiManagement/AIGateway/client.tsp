import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.ApiManagement, "AIGatewayMgmtClient", "python");

@@clientName(
  Microsoft.ApiManagement.AiGatewayResourceExistsResponse,
  "AiGatewayResourceExistsResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AiGatewayCheckNameAvailabilityRequest,
  "AiGatewayCheckNameAvailabilityContent",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AiGatewayCheckNameAvailabilityResponse,
  "AiGatewayCheckNameAvailabilityResult",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AiGatewayEndpoint.baseUrl,
  "baseUri",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AiGatewayToolServerOauth2Authentication.authorizationUrl,
  "authorizationUri",
  "csharp"
);
@@clientName(
  Microsoft.ApiManagement.AiGatewayToolServerOauth2Authentication.tokenUrl,
  "tokenUri",
  "csharp"
);
