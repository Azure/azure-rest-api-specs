import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using Azure.Core.Traits;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@service(#{ title: "Image Analysis" })
@versioned(ImageAnalysis.Versions)
@useAuth(
  ApiKeyAuth<
    ApiKeyLocation.header,
    "Ocp-Apim-Subscription-Key"
  > | AadOauth2Auth<["https://cognitiveservices.azure.com/.default"]>
)
@server(
  "{endpoint}/computervision",
  "Analyze an image to generate a description of its content, detect text, objects and more.",
  {
    @doc("""
      Azure AI Computer Vision endpoint (protocol and hostname, for example:
      https://<resource-name>.cognitiveservices.azure.com).
      """)
    endpoint: url,
  }
)
namespace ImageAnalysis;

enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_10_01: "2023-10-01",
}
