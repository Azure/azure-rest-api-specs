import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/querymodels.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.QueryService.QueryModels;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.QueryService;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "There is no standard operation that fits this scenario"
@post
@route("/query")
@doc("execute the query")
op queryExecute(
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
  includeSummary?: boolean = false,

  @doc("request body")
  @body
  request: QueryRequest,
): QueryResponse;
