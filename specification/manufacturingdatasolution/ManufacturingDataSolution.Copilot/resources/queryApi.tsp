import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/querymodels.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

@doc("Query client operations")
interface QueryServiceClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
  @post
  @route("/query")
  @doc("execute the query")
  queryExecute(
    @doc("api-version to use")
    @query("api-version")
    apiVersion: string,

    @doc("conversation id")
    @header("conversationId")
    conversationId?: string,

    @doc("Accept-Language header")
    @header("Accept-Language")
    acceptLanguage?: string,

    @doc("maximum number of retries")
    @query("maxRetry")
    maxRetry?: int32 = 2,

    @doc("Include summary in the response.")
    @query("includeSummary")
    includeSummary?: choice,

    @doc("request body")
    @body
    request: QueryRequest,
  ): QueryResponse;

  @doc("Share feedback for the copilot's query response")
  submitFeedback is apiOperations.ResourceCollectionAction<
    FeedbackRequest,
    FeedbackRequest,
    FeedbackRequest
  >;
}
