import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Using the AI acronym similar to what was done for OpenAI"
namespace Microsoft.HealthDataAIServices {
  @@access(Operations.list, Access.internal, "csharp");

  @@clientName(PrivateEndpointConnectionResource, "HealthDataAIServicePrivateEndpointConnectionResource", "csharp");
  @@clientName(PrivateLinkResource, "HealthDataAIServicePrivateLinkResourceData", "csharp");

}
