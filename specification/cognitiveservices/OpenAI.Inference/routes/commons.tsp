import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

@doc("A specific deployment")
@TypeSpec.Rest.resource("deployments")
model Deployment {
    @visibility("read")
    @doc("Specifies either the model deployment name (when using Azure OpenAI) or model name (when using non-Azure OpenAI) to use for this request.")
    @projectedName("java", "deploymentOrModelName")
    @key
    deploymentId: string;
}

alias RequestHeaders = Azure.Core.Traits.RequestHeadersTrait<{
    @doc("The content type for the operation. Always multipart/form-data for this operation.")
    @header("content-type")
    contentType: "multipart/form-data";
}>;
