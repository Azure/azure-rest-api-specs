import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(APIVersion)
@service({
  title: "Form Recognizer",
})
@server(
  "{endpoint}/formrecognizer/{api_version}",
  "Extracts information from forms and images into structured data.",
  {
    @doc("""
Supported Cognitive Services endpoints (protocol and hostname, for example:
https://westus2.api.cognitive.microsoft.com).
""")
    endpoint: string,
    api_version: APIVersion,
  }
)
@doc("Extracts information from forms and images into structured data.")
namespace FormRecognizer;

enum APIVersion {
  v2_0: "2.0",
  v2_1: "2.1"
}