import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/querymodels.tsp";

using TypeSpec.Http;

using Azure.Core.Foundations;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

alias queryParams = QueryParametersTrait<{
  @doc("maxRetry")
  @query
  maxRetry?: string;

  @doc("includeSummary")
  @query
  includeSummary?: Choice;
}>;

alias headerParams = RequestHeadersTrait<{
  @doc("conversation-id")
  @header
  conversationId?: string;

  @doc("Accept-Language")
  @header
  acceptLanguage: string;
}>;

@doc("Query client operations")
interface QueryServiceClient {
  // Need to discuss with the Team
  // @doc("Get the details of a query")
  // execute is apiOperations.ResourceCollectionAction<
  //   UserQuery,
  //   UserQueryRequest,
  //   QueryResponse,
  //   queryParams & headerParams
  // >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
  @post
  @route("/query")
  @doc("execute the query")
  queryExecute(
    @doc("api-version to use")
    @query("api-version")
    apiVersion: string,

    @doc("conversation id")
    @header("conversation-id")
    conversationId?: string,

    @doc("Accept-Language header")
    @header("Accept-Language")
    acceptLanguage?: string,

    @doc("maximum number of retries")
    @query("maxRetry")
    maxRetry?: int32 = 2,

    @doc("Include summary in the response.")
    @query("includeSummary")
    includeSummary?: Choice,

    @doc("request body")
    @body
    request: UserQueryRequest,
  ): QueryResponse | Azure.Core.Foundations.ErrorResponse;

  @doc("Share feedback for the copilot's query response")
  submitFeedback is apiOperations.ResourceAction<
    FeedbackRequest,
    {},
    FeedbackRequest
  >;
}
