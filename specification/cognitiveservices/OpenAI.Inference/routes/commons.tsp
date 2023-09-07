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

alias AOAIMultipartRequestDeploymentAction<
  T extends {},
  U extends {}
> = Azure.Core.StandardResourceOperations.ResourceAction<Deployment, T, U>;

alias AOAIMultipartTextPlainAction<T extends {}> = Azure.Core.Foundations.ResourceOperation<
  Deployment,
  T,
  string
>;
