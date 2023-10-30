import "@typespec/rest";
import "../models/definition.tsp";
import "../models/exportSpecification.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi.Models;
@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;

// Models /////////////////////////////////////////////////////////////////////

@doc("API Definition resource model.")
@resource("definitions")
@parentResource(ApiVersionResource)
model ApiDefinitionResource extends ApiDefinition {
  @doc("Definition identifier.")
  @key("apiDefinitionName")
  @visibility("query")
  apiDefinitionName: string;
}

@doc("Export specification resource model.")
@resource("definitions")
@parentResource(ApiVersionResource)
model ExportSpecificationResource extends ExportSpecification {
  @doc("Definition identifier.")
  @key("apiDefinitionName")
  @visibility("query")
  apiDefinitionName: string;
}

interface ApiDefinitions {
  @doc("List a collection of API definitions.")
  listDefinitions is Operations.ResourceList<ApiDefinitionResource, ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>>;

  @doc("Get an API definition.")
  getDefinition is Operations.ResourceRead<ApiDefinitionResource>;

  @doc("Export an API specification.")
  exportSpecification is Operations.ResourceAction<ExportSpecificationResource, {}, ExportSpecificationResource>;
}