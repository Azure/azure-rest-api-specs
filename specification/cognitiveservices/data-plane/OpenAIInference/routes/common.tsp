import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;

@doc("A specific deployment")
@TypeSpec.Rest.resource("deployments")
model Deployment {
  @visibility(Lifecycle.Read)
  @doc("Specifies either the model deployment name (when using Azure OpenAI) or model name (when using non-Azure OpenAI) to use for this request.")
  @clientName("deploymentOrModelName", "java")
  @key
  deploymentId: string;
}

// Audio implementation note: depending on the response_format provided in operation request bodies, these operations
// may respond with a response body that's either a JSON object or a text/plain string. Pending more precise
// specification of the relationship between the input format selection and resulting output response format, the two
// content-type-specific options are provided for each operation with no delineation between the matching request body
// requirements. These content-type-specific operations should be hidden by clients and combined into single operations
// that share common characteristics whenever possible.

alias MultipartFormDataRequestHeadersTraits = Azure.Core.Traits.RequestHeadersTrait<{
  @doc("The content type for the operation. Always multipart/form-data for this operation.")
  @header("content-type")
  contentType: "multipart/form-data";
}>;

alias TextPlainResponseHeadersTraits = Azure.Core.Traits.ResponseHeadersTrait<{
  @doc("The content type 'text/plain' for the audio text response.")
  @header("content-type")
  contentType: "text/plain";
}>;
