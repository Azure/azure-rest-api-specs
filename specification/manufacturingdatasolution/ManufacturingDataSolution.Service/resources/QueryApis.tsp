import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/querymodels.tsp";

using TypeSpec.Rest;
using QueryModels;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(MdsSolution.Versions)
namespace MdsSolution.QueryApis {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
  @doc("Get the ingestion status.")
  @route("query/ingestionStatus")
  @get
  op getIngestionStatus(
    @doc("API version.")
    @query("api-version")
    apiVersion: string,

    @doc("Time series operator.")
    @query
    operators?: TimeSeriesOperator,

    @doc("Start time.")
    @query
    startedAt?: utcDateTime,

    @doc("End time.")
    @query
    endedAt?: utcDateTime,
  ): IngestionStatusResponse | Azure.Core.Foundations.ErrorResponse;

  @doc("Query the data.")
  @action("entityData")
  @list
  op queryEntityData is Operations.ResourceCollectionAction<
    PagedQueryRequest,
    PagedQueryRequest,
    PagedQueryResult
  >;

  @doc("Query the related nodes.")
  @action("relatedNodes")
  @list
  op queryRelatedNodes is Operations.ResourceCollectionAction<
    QueryRequestRelatedNodes,
    QueryRequestRelatedNodes,
    PagedRelatedNodeResult
  >;

  @doc("Query the related entities data.")
  @action("relatedEntities")
  @list
  op queryRelatedEntities is Operations.ResourceCollectionAction<
    QueryRequestRelatedEntitiesData,
    QueryRequestRelatedEntitiesData,
    PagedRelatedEntityData
  >;

  @doc("Query the related entities data history.")
  @action("relatedEntitiesHistory")
  @list
  op queryRelatedEntitiesDataHistory is Operations.ResourceCollectionAction<
    QueryRequestRelatedEntitiesData,
    QueryRequestRelatedEntitiesData,
    PagedRelatedEntityData
  >;
}
