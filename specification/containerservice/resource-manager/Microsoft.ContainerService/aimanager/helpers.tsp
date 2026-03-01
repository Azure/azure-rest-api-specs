import "@typespec/rest";

using TypeSpec.OpenAPI;
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

@doc("Provides the standard '$skiptoken' query parameter for list operations.")
model SkipTokenQueryParameter {
  @query("$skipToken")
  @doc("The page-continuation token to use with a paged version of this API.")
  skipToken?: string;
}

@doc("Provides the standard '$top' query parameter for list operations.")
model TopQueryParameter {
  @query("$top")
  @doc("The number of result items to return.")
  top?: int32;
}

@doc("Provides the standard '$filter' query parameter for list operations.")
model FilterQueryParameter {
  @query("$filter")
  @doc("Filter the result list using the given expression.")
  filter?: string;
}

@doc("The list credential result response.")
model CredentialResults {
  @doc("Base64-encoded Kubernetes configuration file.")
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
  value?: bytes;
}

@doc("The format of the kubeconfig credential.")
union Format {
  string,

  @doc("Return azure auth-provider kubeconfig. This format is deprecated in v1.22 and will be fully removed in v1.26.")
  azure: "azure",

  @doc("Return exec format kubeconfig. This format requires kubelogin binary in the path.")
  exec: "exec",
}
