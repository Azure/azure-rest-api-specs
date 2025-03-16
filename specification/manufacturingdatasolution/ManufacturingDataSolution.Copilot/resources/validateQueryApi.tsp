import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/validateQuery.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

@doc("Query validation job client operations")
interface QueryValidateJobClient {
  @doc("Validate a query")
  run is apiOperations.ResourceAction<
    QueryValidationJobRequest,
    QueryValidationJobRequestBody,
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
      fromDateAt?: utcDateTime;

      @doc("end date")
      @query
      endDateAt?: utcDateTime;

      @doc("test run id")
      @query
      testRunId?: string;
    }>
  >;
}
