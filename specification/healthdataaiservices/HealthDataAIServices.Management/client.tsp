import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.HealthDataAIServices,
  "HealthDataAIServicesMgmt",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "Using the AI acronym similar to what was done for OpenAI"
namespace Microsoft.HealthDataAIServices {
  @@access(Operations.list, Access.internal, "csharp");

  @@clientName(PrivateEndpointConnectionResource,
    "HealthDataAIServicesPrivateEndpointConnectionResource",
    "csharp"
  );
  @@clientName(PublicNetworkAccess,
    "HealthDataAIServicesPublicNetworkAccess",
    "csharp"
  );
  @@clientName(ProvisioningState,
    "HealthDataAIServicesProvisioningState",
    "csharp"
  );
  @@clientName(PrivateLinkResource,
    "HealthDataAIServicesPrivateLinkResourceData",
    "csharp"
  );
  @@clientName(PrivateLinks.listByDeidService, "GetPrivateLinks", "csharp");

  @@clientName(DeidServiceSku,
    "HealthDataAIServicesSku",
    "csharp"
  );
  @@clientName(DeidServiceSkuName,
    "HealthDataAIServicesSkuName",
    "csharp"
  );
  @@access(DeidServiceSkuName, Access.public, "csharp");

  @@clientName(Versions.v2024_09_20,
    "$DO_NOT_NORMALIZE$V2024_09_20",
    "javascript"
  );
}
