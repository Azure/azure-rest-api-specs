import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
using TypeSpec.Http;
using TypeSpec.Rest;

using OpenAPI;
using Autorest;

namespace Azure.Core;

@pagedResult
@friendlyName("Paged{name}", TResource)
@doc("Paged collection of {name} items", TResource)
model PageUpdated<TResource extends object> {
  @doc("The {name} items on this page", TResource)
  @items
  @visibility("read")
  @extension("x-ms-identifiers", [])
  value?: TResource[];

  @doc("The link to the next page of items")
  @nextLink
  @visibility("read")
  nextLink?: string;
}