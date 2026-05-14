import "@typespec/rest";
import "../models/models.tsp";
import "../models/apiDefinition.tsp";
import "../models/exportSpecification.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi;

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

  @doc("Gets status of a an API specification export operation.")
  getExportSpecificationOperationStatus is Operations.GetResourceOperationStatus<ApiSpecExportResult>;

  @doc("Export an API specification asynchronously.")
  @pollingOperation(ApiDefinitions.getExportSpecificationOperationStatus)
  exportSpecification is Operations.LongRunningResourceAction<
    ApiSpecExportResult,
    {},
    ApiSpecExportResult
  >;
}
