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

interface ApiDefinitions {
  @doc("List a collection of API definitions.")
  listDefinitions is Operations.ResourceList<
    ApiDefinition,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Get an API definition.")
  getDefinition is Operations.ResourceRead<ApiDefinition>;

  @doc("Export an API specification.")
  exportSpecification is Operations.ResourceAction<
    ExportSpecification,
    {},
    ExportSpecification
  >;
}
