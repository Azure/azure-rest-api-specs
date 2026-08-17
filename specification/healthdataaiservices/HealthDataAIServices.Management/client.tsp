import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HealthDataAIServices;

@@clientName(
  Microsoft.HealthDataAIServices,
  "HealthDataAIServicesMgmt",
  "python"
);

@@clientName(
  PrivateEndpointConnectionResource,
  "HealthDataAIServicesPrivateEndpointConnectionResource",
  "csharp"
);
@@clientName(
  PublicNetworkAccess,
  "HealthDataAIServicesPublicNetworkAccess",
  "csharp"
);
@@clientName(
  ProvisioningState,
  "HealthDataAIServicesProvisioningState",
  "csharp"
);
@@clientName(
  PrivateLinkResource,
  "HealthDataAIServicesPrivateLinkResourceData",
  "csharp"
);
@@clientName(PrivateLinks.listByDeidService, "GetPrivateLinks", "csharp");

@@clientName(
  Versions.v2024_09_20,
  "$DO_NOT_NORMALIZE$V2024_09_20",
  "javascript"
);
