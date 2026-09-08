import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerService;

alias IfMatchParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  @header("If-Match")
  @doc("The request should only proceed if an entity matches this string.")
  ifMatch?: string;
};

alias IfNoneMatchParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  @header("If-None-Match")
  @doc("The request should only proceed if no entity matches this string.")
  ifNoneMatch?: string;
};

alias IfMatchHeadersParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  ...IfMatchParameters<T>;
  ...IfNoneMatchParameters<T>;
};

@doc("The polling header for an asynchronous Azure operation.")
model ArmPollingOnlyAsyncOperationHeader {
  @doc("A link to the status monitor")
  @header("Azure-AsyncOperation")
  azureAsyncOperation?: string;
}

@doc("Resource '{name}' create operation succeeded", Resource)
model ArmResourceCreatedPollingOnlyResponse<
  Resource extends Azure.ResourceManager.Foundations.SimpleResource
> {
  ...CreatedResponse;
  ...ArmPollingOnlyAsyncOperationHeader;
  ...Azure.Core.Foundations.RetryAfterHeader;
  ...Body<Resource>;
}

@doc("The list credential result response.")
model CredentialResults {
  @doc("Array of credential results.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  kubeconfigs?: CredentialResult[];
}

@doc("The credential result response.")
model CredentialResult {
  @doc("The name of the credential.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Base64-encoded Kubernetes configuration file.")
  @visibility(Lifecycle.Read)
  @secret
  value?: bytes;
}

