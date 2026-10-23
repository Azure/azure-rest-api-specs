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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing TopQueryParameter.top retains the $top query parameter; preserve wire compatibility."
  @query("$top")
  @doc("The number of result items to return.")
  top?: int32;
}

@doc("Provides the standard '$skip' query parameter for list operations.")
model SkipQueryParameter {
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing SkipQueryParameter.skip retains the $skip query parameter; preserve wire compatibility."
  @query("$skip")
  @doc("The number of result items to skip.")
  skip?: int32;
}
