// imports to rest,http and versioning should be done outside of this file (csharp emitter issue)
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@service(#{ title: "Azure AI Health Insights" })
@versioned(ApiVersion)
@doc("Azure AI Health Insights provides an API that serves insight models, specific for Health & Life Sciences, that perform analysis and provide inferences to be used by a human.")
@server(
  "{endpoint}/health-insights",
  "Azure AI Health Insights provides an API that serves insight models, specific for Health & Life Sciences, that perform analysis and provide inferences to be used by a human.",
  {
    @doc("Supported Cognitive Services endpoints (protocol and hostname, for example: https://westus2.api.cognitive.microsoft.com).")
    endpoint: url,
  }
)
@useAuth(AzureKey | EntraIdToken)
namespace AzureHealthInsights;

@doc("The secret key for your Azure Cognitive Services subscription.")
model AzureKey is ApiKeyAuth<
  ApiKeyLocation.header,
  "Ocp-Apim-Subscription-Key"
>;

@doc("The Microsoft Entra Id Flow")
model EntraIdToken
  is Azure.Core.AadOauth2Auth<["https://cognitiveservices.azure.com/.default"]>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
#suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
enum ApiVersion {
  v2024_04_01: "2024-04-01",
  v2024_08_01_preview: "2024-08-01-preview",
  v2024_10_01: "2024-10-01",
}
