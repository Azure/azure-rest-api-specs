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
}
