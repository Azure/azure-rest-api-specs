import "@typespec/openapi";
import "../common/models.tsp";
import "../assistants/models.tsp";
import "../messages/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Represents a thread that contains [messages](https://platform.openai.com/docs/api-reference/messages). */
@summary("Thread")
@extension(
  "x-oaiMeta",
  #{
    name: "The thread object",
    beta: true,
    example: "{\n  \"id\": \"thread_abc123\",\n  \"object\": \"thread\",\n  \"created_at\": 1698107661,\n  \"metadata\": {}\n}\n",
  }
)
model ThreadObject {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `thread`. */
  @extension("x-stainless-const", true)
  object: "thread";

  /** The Unix timestamp (in seconds) for when the thread was created. */
  created_at: integer;

  /** A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs. */
  tool_resources: {
    code_interpreter?: {
      @maxItems(20)
      file_ids?: string[] = #[];
    };
    file_search?: {
      @maxItems(1)
      vector_store_ids?: string[];
    };
  } | null;

  metadata: Metadata;
}

/**Options to create a new thread. If no thread is provided when running a
request, an empty thread will be created.*/
model CreateThreadRequest {
  /** A list of [messages](https://platform.openai.com/docs/api-reference/messages) to start the thread with. */
  messages?: CreateMessageRequest[];

  /** A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs. */
  tool_resources?: {
    code_interpreter?: {
      @maxItems(20)
      file_ids?: string[] = #[];
    };
    file_search?: ToolResourcesFileSearch;
  } | null;

  metadata?: Metadata;
}

model DeleteThreadResponse {
  id: string;
  deleted: boolean;

  @extension("x-stainless-const", true)
  object: "thread.deleted";
}

model ModifyThreadRequest {
  /** A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs. */
  tool_resources?: {
    code_interpreter?: {
      @maxItems(20)
      file_ids?: string[] = #[];
    };
    file_search?: {
      @maxItems(1)
      vector_store_ids?: string[];
    };
  } | null;

  metadata?: Metadata;
}

model CreateThreadAndRunRequestWithoutStream {
  /** The ID of the [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to execute this run. */
  assistant_id: string;

  thread?: CreateThreadRequest;

  /** The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to be used to execute this run. If a value is provided here, it will override the model associated with the assistant. If not, the model associated with the assistant will be used. */
  @extension("x-oaiTypeLabel", "string")
  `model`?:
    | string
    | "gpt-5"
    | "gpt-5-mini"
    | "gpt-5-nano"
    | "gpt-5-2025-08-07"
    | "gpt-5-mini-2025-08-07"
    | "gpt-5-nano-2025-08-07"
    | "gpt-4.1"
    | "gpt-4.1-mini"
    | "gpt-4.1-nano"
    | "gpt-4.1-2025-04-14"
    | "gpt-4.1-mini-2025-04-14"
    | "gpt-4.1-nano-2025-04-14"
    | "gpt-4o"
    | "gpt-4o-2024-11-20"
    | "gpt-4o-2024-08-06"
    | "gpt-4o-2024-05-13"
    | "gpt-4o-mini"
    | "gpt-4o-mini-2024-07-18"
    | "gpt-4.5-preview"
    | "gpt-4.5-preview-2025-02-27"
    | "gpt-4-turbo"
    | "gpt-4-turbo-2024-04-09"
    | "gpt-4-0125-preview"
    | "gpt-4-turbo-preview"
    | "gpt-4-1106-preview"
    | "gpt-4-vision-preview"
    | "gpt-4"
    | "gpt-4-0314"
    | "gpt-4-0613"
    | "gpt-4-32k"
    | "gpt-4-32k-0314"
    | "gpt-4-32k-0613"
    | "gpt-3.5-turbo"
    | "gpt-3.5-turbo-16k"
    | "gpt-3.5-turbo-0613"
    | "gpt-3.5-turbo-1106"
    | "gpt-3.5-turbo-0125"
    | "gpt-3.5-turbo-16k-0613"
    | null;

  /** Override the default system message of the assistant. This is useful for modifying the behavior on a per-run basis. */
  instructions?: string | null;

  /** Override the tools the assistant can use for this run. This is useful for modifying the behavior on a per-run basis. */
  @maxItems(20)
  tools?: AssistantTool[];

  /** A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs. */
  tool_resources?: {
    code_interpreter?: {
      @maxItems(20)
      file_ids?: string[] = #[];
    };
    file_search?: {
      @maxItems(1)
      vector_store_ids?: string[];
    };
  } | null;

  metadata?: Metadata;

  /** What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. */
  @maxValue(2)
  @minValue(0)
  temperature?: numeric | null = 1;

  /**An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.

  We generally recommend altering this or temperature but not both.*/
  @maxValue(1)
  @minValue(0)
  top_p?: numeric | null = 1;

  /** The maximum number of prompt tokens that may be used over the course of the run. The run will make a best effort to use only the number of prompt tokens specified, across multiple turns of the run. If the run exceeds the number of prompt tokens specified, the run will end with status `incomplete`. See `incomplete_details` for more info. */
  @minValue(256)
  max_prompt_tokens?: integer | null;

  /** The maximum number of completion tokens that may be used over the course of the run. The run will make a best effort to use only the number of completion tokens specified, across multiple turns of the run. If the run exceeds the number of completion tokens specified, the run will end with status `incomplete`. See `incomplete_details` for more info. */
  @minValue(256)
  max_completion_tokens?: integer | null;

  truncation_strategy?: TruncationObject;
  tool_choice?: AssistantsApiToolChoiceOption;
  parallel_tool_calls?: ParallelToolCalls;
  response_format?: AssistantsApiResponseFormatOption;
}
