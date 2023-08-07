import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "ContentSafety Service",
})
@versioned(ContentSafety.Versions)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@server(
  "{endpoint}/contentsafety",
  "Analyze harmful content",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://<resource-name>.cognitiveservices.azure.com).
""")
    endpoint: string,
  }
)
@doc("Analyze harmful content")
namespace ContentSafety;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_30_Preview: "2023-04-30-preview",
}
