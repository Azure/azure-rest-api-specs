// imports to rest,http and versioning should be done outside of this file (csharp emitter issue)
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@service({
  title: "Azure Health Insights",
})
@versioned(ApiVersion)
@doc("Azure Health Insights provides an API that serves insight models, specific for Health & Life Sciences, that perform analysis and provide inferences to be used by a human.")
@server(
  "{endpoint}/healthinsights",
  "Azure Health Insights provides an API that serves insight models, specific for Health & Life Sciences, that perform analysis and provide inferences to be used by a human.",
  {
    @doc("Supported Cognitive Services endpoints (protocol and hostname, for example: https://westus2.api.cognitive.microsoft.com).")
    endpoint: url,
  }
)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
namespace AzureHealthInsights;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum ApiVersion {
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_03_01_preview: "2023-03-01-preview",
}
