import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/querymodels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.QueryService.QueryModels;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.QueryService;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

alias additionalHeaders = RequestHeadersTrait<
    {
      @header("Conversation-Id")
      @doc("Conversation-Id header")
      conversationId?: string;

      @header("Accept-Language")
      @doc("Accept-Language header")
      acceptLanguage: string;
    }
  >;

alias additionalQueryParams = QueryParametersTrait<
    {
      @doc("maxRetry")
      @query
      maxRetry?: int32 = 2;

      @doc("Include summary in the response.")
      @query
      includeSummary?: boolean = false;
    }
  >;

interface QueryApi { 
    @doc("execute the query")
    execute is apiOperations.ResourceCollectionAction<
      QueryRequest,
      {
        @doc("Natural language query")
        ask?: string;
      },
      QueryResponse,
      additionalHeaders & additionalQueryParams
    >;
}
