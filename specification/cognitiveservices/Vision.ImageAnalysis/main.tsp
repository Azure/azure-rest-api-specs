import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using Azure.Core.Traits;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service({
    title: "ImageAnalysis Service",
  })

@versioned(ImageAnalysis.Versions)
@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">)
@server(
    "{endpoint}/computervision",
    "Analyze an image to generate a description of its content.",
    {
      @doc("""
  Supported Cognitive Services endpoints (protocol and hostname, for example:
  https://<resource-name>.cognitiveservices.azure.com).
  """)
      endpoint: url,
    }
  )

namespace ImageAnalysis;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_04_01_Preview: "2023-04-01-preview",
}

