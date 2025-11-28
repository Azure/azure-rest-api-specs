import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/validateQuery.tsp";

using TypeSpec.Http;
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
  run is apiOperations.ResourceCollectionAction<
    QueryValidationJobRequest,
    QueryValidationJobRequest,
    QueryValidationJobScheduleConfirmation
  >;

  @doc("Get the details of a validation job")
  getQueryValidationJobDetails is apiOperations.ResourceRead<QueryValidationJobDetails>;

  @doc("List validate test requests")
  listQueryValidationJobHistory is apiOperations.ResourceList<
    QueryValidationJobRun,
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
