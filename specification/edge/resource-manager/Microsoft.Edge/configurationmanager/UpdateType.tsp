import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Denotes which part of the version number will be updated")
union UpdateType {
  @doc("Major version")
  Major: "Major",

  @doc("Minor version")
  Minor: "Minor",

  @doc("Patch version")
  Patch: "Patch",

  string,
}

@doc("Query parameters for updating Version")
model VersionUpdateQueryParameters {
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-point-op" "Back compat: Existing VersionUpdateQueryParameters.updateType retains the updateType query parameter; preserve wire compatibility."
  @doc("The type of update")
  @query
  updateType: UpdateType;
}
