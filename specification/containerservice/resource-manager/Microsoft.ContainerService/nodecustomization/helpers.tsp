import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerService;

// #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "built-in conditional request includes time based conditional headers"
alias IfMatchParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  @header("If-Match")
  @doc("The request should only proceed if the targeted resource's etag matches the value provided.")
  ifMatch?: string;
};

alias IfNoneMatchParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  @header("If-None-Match")
  @doc("The request should only proceed if the targeted resource's etag does not match the value provided.")
  ifNoneMatch?: string;
};

alias IfMatchHeadersParameters<T extends Azure.ResourceManager.Foundations.Resource> = {
  ...IfMatchParameters<T>;
  ...IfNoneMatchParameters<T>;
};
