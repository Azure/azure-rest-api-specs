import "@typespec/http";

import "./models/common.tsp";
import "./models/blocking.tsp";
import "./models/streaming.tsp";

namespace Azure.AI.ChatProtocol;

using TypeSpec.Http;

interface Chat<TState, TContext> {
  /* This operation returns a stream of objects in jsonl format. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "API version is not supported by the back end"
  @doc("Creates a new streaming chat completion.")
  @sharedRoute
  createStreaming(
    ...StreamingChatCompletionOptions<TState, TContext>,
    ...OperationRouteParam,
  ): ChatCompletionChunk<TState, TContext>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defining the operation in an Azure independent fashion"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "API version is not supported by the back end"
  @doc("Creates a new chat completion.")
  @sharedRoute
  create(
    ...ChatCompletionOptions<TState, TContext>,
    ...OperationRouteParam,
  ): ChatCompletion<TState, TContext>;
}

interface GenericChatClient extends Chat<unknown, Record<unknown>> {}
