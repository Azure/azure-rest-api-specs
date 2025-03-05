import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/validateQuery.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.ValidateQuery.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.ValidateQueryService;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

interface ValidateQueryApi {
  @doc("Validate a query")
  execute is apiOperations.ResourceCollectionAction<
    TestQuery,
    TestQueryRequest,
    TestResponse
  >;

  @doc("Get the details of a validate test")
  getValidateTestDetails is apiOperations.ResourceRead<
    TestQuery,
    TestDetailsResponse
  >;

  @doc("List validate test requests")
  listValidateTestRequests is apiOperations.ResourceList<
    ValidateTestSummary,
    QueryParametersTrait<{
      @doc("start date")
      @query
      fromDate?: utcDateTime;

      @doc("end date")
      @query
      endDate?: utcDateTime;

      @doc("start date")
      @query
      testRunId?: utcDateTime;
    }>
  >;
}
