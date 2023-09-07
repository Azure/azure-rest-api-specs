import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

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

alias AOAIDeploymentAction<
  T extends {},
  U extends {}
> = Azure.Core.ResourceAction<Deployment, T, U>;

alias AOAIMultipartHeaders = Azure.Core.Traits.RequestHeadersTrait<{
  @doc("""
  The content type for the operation. Always multipart/form-data for this operation.
  You need to set your content separtor with the boundary value hardcode here: "azure_openai"
  """)
  @header("content-type")
  contentType: "multipart/form-data; boundary=azure_openai";

  @doc("The content length of the operation. This needs to be provided by the caller.")
  @header("content-length")
  contentLength: int64;
}>;

alias AOAIMultipartRequestDeploymentAction<
  T extends {},
  U extends {}
> = Azure.Core.ResourceAction<Deployment, T, U, AOAIMultipartHeaders>;

alias AOAIMultipartTextPlainAction<T extends {}> = Azure.Core.Foundations.ResourceOperation<
  Deployment,
  T,
  string,
  AOAIMultipartHeaders
>;
