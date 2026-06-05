import "@typespec/http";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias AgentSessionIdResponseHeader = {
  @doc("Session ID for this request. Only present for hosted agent responses. Returns the provided session ID or an auto-generated one if not provided in the request.")
  @header("x-agent-session-id")
  agentSessionId?: string;
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "OpenAI Response schemas can be intentionally combined for documentation clarity"
@sharedRoute
op OpenAISharedOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
> is OpenAIOperation<
  Params,
  Response,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "OpenAI Response schemas can be intentionally combined for documentation clarity"
op OpenAIAgentOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
> is OpenAIOperation<
  {
    ...UserIsolationKeyHeader;
    ...Params;
  },
  Response,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "OpenAI Response schemas can be intentionally combined for documentation clarity"
@sharedRoute
op OpenAIAgentSessionOperation<
  Params extends Reflection.Model,
  Response extends Reflection.Model,
  ErrorResponse = ApiErrorResponse
>(...UserIsolationKeyHeader, ...Params):
  | (Response & AgentSessionIdResponseHeader)
  | AzureRangeErrorResponse<ErrorResponse>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "OpenAI Response schemas can be intentionally combined for documentation clarity"
@sharedRoute
op OpenAIAgentStreamingOperation<
  Params extends Reflection.Model,
  Event,
  ErrorResponse = ApiErrorResponse
>(...UserIsolationKeyHeader, ...Params):
  | SseResponseOf<Event>
  | AzureRangeErrorResponse<ErrorResponse>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "OpenAI Response schemas can be intentionally combined for documentation clarity"
op OpenAIAgentPagedOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
> is OpenAIOperation<
  {
    ...UserIsolationKeyHeader;
    ...Params;
  },
  Response,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "OpenAI Response schemas can be intentionally combined for documentation clarity"
@list
op OpenAIAgentFilteredPagedOperation<
  Params extends Reflection.Model,
  Item extends Reflection.Model,
  ErrorResponse = ApiErrorResponse
>(...UserIsolationKeyHeader, ...CommonPageQueryParameters, ...Params):
  | AgentsPagedResult<Item>
  | AzureRangeErrorResponse<ErrorResponse>;
