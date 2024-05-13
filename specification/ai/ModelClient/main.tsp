import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

#suppress "@azure-tools/typespec-autorest/unsupported-http-auth-scheme"
@useAuth(
  BearerAuth | AadOauth2Auth<["https://cognitiveservices.azure.com/.default"]>
)
@service({
  title: "AI Model Inference",
})
// Is this the right way to do this? This results in an error in the emitted Python code.
// @server(
//   "{endpoint}",
//   "An AI endpoint that does chat completions or embeddings",
//   {
//     @doc("The AI model service endpoint.")
//     endpoint: string,
//
//     @doc("Controls what happens if extra parameters are passed in the request payload.")
//     @header("extra-parameters")
//     extra_parameters?: ExtraParameters,
//   }
// )
@versioned(ModelClient.Versions)
namespace ModelClient;

@doc("The ModelClient service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-04-01-preview version of the ModelClient service.")
  v2024_04_01_Preview: "2024-04-01-preview",
}
