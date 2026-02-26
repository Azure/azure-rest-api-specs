import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

@doc("Provides the standard '$filter' query parameter for list operations.")
model FilterQueryParameter {
  @query("$filter")
  @doc("Filter the result list using the given expression.")
  filter?: string;
}

@doc("Provides the standard '$top' query parameter for list operations.")
model TopQueryParameter {
  @query("$top")
  @doc("The number of result items to return.")
  top?: int32;
}

@doc("Provides the standard '$skip' query parameter for list operations.")
model SkipQueryParameter {
  @query("$skip")
  @doc("The number of result items to skip.")
  skip?: int32;
}
