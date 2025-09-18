import "@typespec/openapi";
import "../common/models.tsp";
import "../assistants/models.tsp";
import "../threads/models.tsp";
import "../messages/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Represents an execution run on a [thread](https://platform.openai.com/docs/api-reference/threads). */
@summary("A run on a thread")
@extension(
  "x-oaiMeta",
  #{
    name: "The run object",
    beta: true,
    example: "{\n  \"id\": \"run_abc123\",\n  \"object\": \"thread.run\",\n  \"created_at\": 1698107661,\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"status\": \"completed\",\n  \"started_at\": 1699073476,\n  \"expires_at\": null,\n  \"cancelled_at\": null,\n  \"failed_at\": null,\n  \"completed_at\": 1699073498,\n  \"last_error\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": null,\n  \"tools\": [{\"type\": \"file_search\"}, {\"type\": \"code_interpreter\"}],\n  \"metadata\": {},\n  \"incomplete_details\": null,\n  \"usage\": {\n    \"prompt_tokens\": 123,\n    \"completion_tokens\": 456,\n    \"total_tokens\": 579\n  },\n  \"temperature\": 1.0,\n  \"top_p\": 1.0,\n  \"max_prompt_tokens\": 1000,\n  \"max_completion_tokens\": 1000,\n  \"truncation_strategy\": {\n    \"type\": \"auto\",\n    \"last_messages\": null\n  },\n  \"response_format\": \"auto\",\n  \"tool_choice\": \"auto\",\n  \"parallel_tool_calls\": true\n}\n",
  }
)
model RunObject {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `thread.run`. */
  @extension("x-stainless-const", true)
  object: "thread.run";

  /** The Unix timestamp (in seconds) for when the run was created. */
  created_at: integer;

  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) that was executed on as a part of this run. */
  thread_id: string;

  /** The ID of the [assistant](https://platform.openai.com/docs/api-reference/assistants) used for execution of this run. */
  assistant_id: string;

  status: RunStatus;

  /** Details on the action required to continue the run. Will be `null` if no action is required. */
  required_action: {
    @extension("x-stainless-const", true)
    type: "submit_tool_outputs";

    submit_tool_outputs: {
      tool_calls: RunToolCallObject[];
    };
  } | null;

  /** The last error associated with this run. Will be `null` if there are no errors. */
  last_error: {
    code: "server_error" | "rate_limit_exceeded" | "invalid_prompt";
    message: string;
  } | null;

  /** The Unix timestamp (in seconds) for when the run will expire. */
  expires_at: integer | null;

  /** The Unix timestamp (in seconds) for when the run was started. */
  started_at: integer | null;

  /** The Unix timestamp (in seconds) for when the run was cancelled. */
  cancelled_at: integer | null;

  /** The Unix timestamp (in seconds) for when the run failed. */
  failed_at: integer | null;

  /** The Unix timestamp (in seconds) for when the run was completed. */
  completed_at: integer | null;

  /** Details on why the run is incomplete. Will be `null` if the run is not incomplete. */
  incomplete_details: {
    reason?: "max_completion_tokens" | "max_prompt_tokens";
  } | null;

  /** The model that the [assistant](https://platform.openai.com/docs/api-reference/assistants) used for this run. */
  `model`: string;

  /** The instructions that the [assistant](https://platform.openai.com/docs/api-reference/assistants) used for this run. */
  instructions: string;

  /** The list of tools that the [assistant](https://platform.openai.com/docs/api-reference/assistants) used for this run. */
  @maxItems(20)
  tools: AssistantTool[] = #[];

  metadata: Metadata;
  usage: RunCompletionUsage;

  /** The sampling temperature used for this run. If not set, defaults to 1. */
  temperature?: numeric | null;

  /** The nucleus sampling value used for this run. If not set, defaults to 1. */
  top_p?: numeric | null;

  /** The maximum number of prompt tokens specified to have been used over the course of the run. */
  @minValue(256)
  max_prompt_tokens: integer | null;

  /** The maximum number of completion tokens specified to have been used over the course of the run. */
  @minValue(256)
  max_completion_tokens: integer | null;

  truncation_strategy: TruncationObject;
  tool_choice: AssistantsApiToolChoiceOption;
  parallel_tool_calls: ParallelToolCalls;
  response_format: AssistantsApiResponseFormatOption;
}

/** The status of the run, which can be either `queued`, `in_progress`, `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`, `incomplete`, or `expired`. */
enum RunStatus {
  queued,
  in_progress,
  requires_action,
  cancelling,
  cancelled,
  failed,
  completed,
  incomplete,
  expired,
}

/** Tool call objects */
model RunToolCallObject {
  /** The ID of the tool call. This ID must be referenced when you submit the tool outputs in using the [Submit tool outputs to run](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs) endpoint. */
  id: string;

  /** The type of tool call the output is required for. For now, this is always `function`. */
  @extension("x-stainless-const", true)
  type: "function";

  /** The function definition. */
  function: {
    name: string;
    arguments: string;
  };
}

/** Usage statistics related to the run. This value will be `null` if the run is not in a terminal state (i.e. `in_progress`, `queued`, etc.). */
model RunCompletionUsage {
  /** Number of completion tokens used over the course of the run. */
  completion_tokens: integer;

  /** Number of prompt tokens used over the course of the run. */
  prompt_tokens: integer;

  /** Total number of tokens used (prompt + completion). */
  total_tokens: integer;
}

/** Represents a step in execution of a run. */
@summary("Run steps")
@extension(
  "x-oaiMeta",
  #{
    name: "The run step object",
    beta: true,
    example: "{\n  \"id\": \"step_abc123\",\n  \"object\": \"thread.run.step\",\n  \"created_at\": 1699063291,\n  \"run_id\": \"run_abc123\",\n  \"assistant_id\": \"asst_abc123\",\n  \"thread_id\": \"thread_abc123\",\n  \"type\": \"message_creation\",\n  \"status\": \"completed\",\n  \"cancelled_at\": null,\n  \"completed_at\": 1699063291,\n  \"expired_at\": null,\n  \"failed_at\": null,\n  \"last_error\": null,\n  \"step_details\": {\n    \"type\": \"message_creation\",\n    \"message_creation\": {\n      \"message_id\": \"msg_abc123\"\n    }\n  },\n  \"usage\": {\n    \"prompt_tokens\": 123,\n    \"completion_tokens\": 456,\n    \"total_tokens\": 579\n  }\n}\n",
  }
)
model RunStepObject {
  /** The identifier of the run step, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `thread.run.step`. */
  @extension("x-stainless-const", true)
  object: "thread.run.step";

  /** The Unix timestamp (in seconds) for when the run step was created. */
  created_at: integer;

  /** The ID of the [assistant](https://platform.openai.com/docs/api-reference/assistants) associated with the run step. */
  assistant_id: string;

  /** The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) that was run. */
  thread_id: string;

  /** The ID of the [run](https://platform.openai.com/docs/api-reference/runs) that this run step is a part of. */
  run_id: string;

  /** The type of run step, which can be either `message_creation` or `tool_calls`. */
  type: "message_creation" | "tool_calls";

  /** The status of the run step, which can be either `in_progress`, `cancelled`, `failed`, `completed`, or `expired`. */
  status: "in_progress" | "cancelled" | "failed" | "completed" | "expired";

  /** The details of the run step. */
  step_details: RunStepDetailsMessageCreationObject | RunStepDetailsToolCallsObject;

  /** The last error associated with this run step. Will be `null` if there are no errors. */
  last_error: {
    code: "server_error" | "rate_limit_exceeded";
    message: string;
  } | null;

  /** The Unix timestamp (in seconds) for when the run step expired. A step is considered expired if the parent run is expired. */
  expired_at: integer | null;

  /** The Unix timestamp (in seconds) for when the run step was cancelled. */
  cancelled_at: integer | null;

  /** The Unix timestamp (in seconds) for when the run step failed. */
  failed_at: integer | null;

  /** The Unix timestamp (in seconds) for when the run step completed. */
  completed_at: integer | null;

  metadata: Metadata;
  usage: RunStepCompletionUsage;
}

/** Details of the message creation by the run step. */
@summary("Message creation")
model RunStepDetailsMessageCreationObject {
  /** Always `message_creation`. */
  @extension("x-stainless-const", true)
  type: "message_creation";

  message_creation: {
    message_id: string;
  };
}

/** Details of the tool call. */
@summary("Tool calls")
model RunStepDetailsToolCallsObject {
  /** Always `tool_calls`. */
  @extension("x-stainless-const", true)
  type: "tool_calls";

  /** An array of tool calls the run step was involved in. These can be associated with one of three types of tools: `code_interpreter`, `file_search`, or `function`. */
  tool_calls: RunStepDetailsToolCall[];
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union RunStepDetailsToolCall {
  code_interpreter: RunStepDetailsToolCallsCodeObject,
  file_search: RunStepDetailsToolCallsFileSearchObject,
  function: RunStepDetailsToolCallsFunctionObject,
}

/** Details of the Code Interpreter tool call the run step was involved in. */
@summary("Code Interpreter tool call")
model RunStepDetailsToolCallsCodeObject {
  /** The ID of the tool call. */
  id: string;

  /** The type of tool call. This is always going to be `code_interpreter` for this type of tool call. */
  @extension("x-stainless-const", true)
  type: "code_interpreter";

  /** The Code Interpreter tool call definition. */
  code_interpreter: {
    input: string;
    outputs: (RunStepDetailsToolCallsCodeOutputLogsObject | RunStepDetailsToolCallsCodeOutputImageObject)[];
  };
}

/** Text output from the Code Interpreter tool call as part of a run step. */
@summary("Code Interpreter log output")
@extension(
  "x-stainless-naming",
  #{ java: #{ type_name: "LogsOutput" }, kotlin: #{ type_name: "LogsOutput" } }
)
model RunStepDetailsToolCallsCodeOutputLogsObject {
  /** Always `logs`. */
  @extension("x-stainless-const", true)
  type: "logs";

  /** The text output from the Code Interpreter tool call. */
  logs: string;
}

@summary("Code Interpreter image output")
@extension(
  "x-stainless-naming",
  #{
    java: #{ type_name: "ImageOutput" },
    kotlin: #{ type_name: "ImageOutput" },
  }
)
model RunStepDetailsToolCallsCodeOutputImageObject {
  /** Always `image`. */
  @extension("x-stainless-const", true)
  type: "image";

  image: {
    file_id: string;
  };
}

@summary("File search tool call")
model RunStepDetailsToolCallsFileSearchObject {
  /** The ID of the tool call object. */
  id: string;

  /** The type of tool call. This is always going to be `file_search` for this type of tool call. */
  @extension("x-stainless-const", true)
  type: "file_search";

  /** For now, this is always going to be an empty object. */
  @extension("x-oaiTypeLabel", "map")
  file_search: {
    ranking_options?: RunStepDetailsToolCallsFileSearchRankingOptionsObject;
    results?: RunStepDetailsToolCallsFileSearchResultObject[];
  };
}

/** The ranking options for the file search. */
@summary("File search tool call ranking options")
model RunStepDetailsToolCallsFileSearchRankingOptionsObject {
  ranker: FileSearchRanker;

  /** The score threshold for the file search. All values must be a floating point number between 0 and 1. */
  @maxValue(1)
  @minValue(0)
  score_threshold: numeric;
}

/** A result instance of the file search. */
@summary("File search tool call result")
@extension("x-oaiTypeLabel", "map")
model RunStepDetailsToolCallsFileSearchResultObject {
  /** The ID of the file that result was found in. */
  file_id: string;

  /** The name of the file that result was found in. */
  file_name: string;

  /** The score of the result. All values must be a floating point number between 0 and 1. */
  @maxValue(1)
  @minValue(0)
  score: numeric;

  /** The content of the result that was found. The content is only included if requested via the include query parameter. */
  content?: {
    @extension("x-stainless-const", true)
    type?: "text";

    text?: string;
  }[];
}

@summary("Function tool call")
model RunStepDetailsToolCallsFunctionObject {
  /** The ID of the tool call object. */
  id: string;

  /** The type of tool call. This is always going to be `function` for this type of tool call. */
  @extension("x-stainless-const", true)
  type: "function";

  /** The definition of the function that was called. */
  function: {
    name: string;
    arguments: string;
    output: string | null;
  };
}

/** Usage statistics related to the run step. This value will be `null` while the run step's status is `in_progress`. */
model RunStepCompletionUsage {
  /** Number of completion tokens used over the course of the run step. */
  completion_tokens: integer;

  /** Number of prompt tokens used over the course of the run step. */
  prompt_tokens: integer;

  /** Total number of tokens used (prompt + completion). */
  total_tokens: integer;
}

model CreateRunRequest {
  /** The ID of the [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to execute this run. */
  assistant_id: string;

  /** The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to be used to execute this run. If a value is provided here, it will override the model associated with the assistant. If not, the model associated with the assistant will be used. */
  @extension("x-oaiTypeLabel", "string")
  `model`?: string | AssistantSupportedModels | null;

  reasoning_effort?: ReasoningEffort;

  /** Overrides the [instructions](https://platform.openai.com/docs/api-reference/assistants/createAssistant) of the assistant. This is useful for modifying the behavior on a per-run basis. */
  instructions?: string | null;

  /** Appends additional instructions at the end of the instructions for the run. This is useful for modifying the behavior on a per-run basis without overriding other instructions. */
  additional_instructions?: string | null;

  /** Adds additional messages to the thread before creating the run. */
  additional_messages?: CreateMessageRequest[] | null;

  /** Override the tools the assistant can use for this run. This is useful for modifying the behavior on a per-run basis. */
  @maxItems(20)
  tools?: AssistantTool[];

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

  /** If `true`, returns a stream of events that happen during the Run as server-sent events, terminating when the Run enters a terminal state with a `data: [DONE]` message. */
  stream?: boolean | null;

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

model CreateThreadAndRunRequest {
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

  /** If `true`, returns a stream of events that happen during the Run as server-sent events, terminating when the Run enters a terminal state with a `data: [DONE]` message. */
  stream?: boolean | null;

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

model ListRunStepsResponse {
  object: string;
  data: RunStepObject[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ListRunsResponse {
  object: string;
  data: RunObject[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ModifyRunRequest {
  metadata?: Metadata;
}

/** Represents a run step delta i.e. any changed fields on a run step during streaming. */
@summary("Run step delta object")
@extension(
  "x-oaiMeta",
  #{
    name: "The run step delta object",
    beta: true,
    example: "{\n  \"id\": \"step_123\",\n  \"object\": \"thread.run.step.delta\",\n  \"delta\": {\n    \"step_details\": {\n      \"type\": \"tool_calls\",\n      \"tool_calls\": [\n        {\n          \"index\": 0,\n          \"id\": \"call_123\",\n          \"type\": \"code_interpreter\",\n          \"code_interpreter\": { \"input\": \"\", \"outputs\": [] }\n        }\n      ]\n    }\n  }\n}\n",
  }
)
model RunStepDeltaObject {
  /** The identifier of the run step, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `thread.run.step.delta`. */
  @extension("x-stainless-const", true)
  object: "thread.run.step.delta";

  delta: RunStepDeltaObjectDelta;
}

/** The delta containing the fields that have changed on the run step. */
model RunStepDeltaObjectDelta {
  /** The details of the run step. */
  step_details?: RunStepDeltaStepDetailsMessageCreationObject | RunStepDeltaStepDetailsToolCallsObject;
}

/** Details of the message creation by the run step. */
@summary("Message creation")
model RunStepDeltaStepDetailsMessageCreationObject {
  /** Always `message_creation`. */
  @extension("x-stainless-const", true)
  type: "message_creation";

  message_creation?: {
    message_id?: string;
  };
}

/** Details of the tool call. */
@summary("Tool calls")
model RunStepDeltaStepDetailsToolCallsObject {
  /** Always `tool_calls`. */
  @extension("x-stainless-const", true)
  type: "tool_calls";

  /** An array of tool calls the run step was involved in. These can be associated with one of three types of tools: `code_interpreter`, `file_search`, or `function`. */
  tool_calls?: RunStepDeltaStepDetailsToolCall[];
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union RunStepDeltaStepDetailsToolCall {
  code_interpreter: RunStepDeltaStepDetailsToolCallsCodeObject,
  file_search: RunStepDeltaStepDetailsToolCallsFileSearchObject,
  function: RunStepDeltaStepDetailsToolCallsFunctionObject,
}

/** Details of the Code Interpreter tool call the run step was involved in. */
@summary("Code interpreter tool call")
model RunStepDeltaStepDetailsToolCallsCodeObject {
  /** The index of the tool call in the tool calls array. */
  index: integer;

  /** The ID of the tool call. */
  id?: string;

  /** The type of tool call. This is always going to be `code_interpreter` for this type of tool call. */
  @extension("x-stainless-const", true)
  type: "code_interpreter";

  /** The Code Interpreter tool call definition. */
  code_interpreter?: {
    input?: string;
    outputs?: (RunStepDeltaStepDetailsToolCallsCodeOutputLogsObject | RunStepDeltaStepDetailsToolCallsCodeOutputImageObject)[];
  };
}

/** Text output from the Code Interpreter tool call as part of a run step. */
@summary("Code interpreter log output")
model RunStepDeltaStepDetailsToolCallsCodeOutputLogsObject {
  /** The index of the output in the outputs array. */
  index: integer;

  /** Always `logs`. */
  @extension("x-stainless-const", true)
  type: "logs";

  /** The text output from the Code Interpreter tool call. */
  logs?: string;
}

@summary("Code interpreter image output")
model RunStepDeltaStepDetailsToolCallsCodeOutputImageObject {
  /** The index of the output in the outputs array. */
  index: integer;

  /** Always `image`. */
  @extension("x-stainless-const", true)
  type: "image";

  image?: {
    file_id?: string;
  };
}

@summary("File search tool call")
model RunStepDeltaStepDetailsToolCallsFileSearchObject {
  /** The index of the tool call in the tool calls array. */
  index: integer;

  /** The ID of the tool call object. */
  id?: string;

  /** The type of tool call. This is always going to be `file_search` for this type of tool call. */
  @extension("x-stainless-const", true)
  type: "file_search";

  /** For now, this is always going to be an empty object. */
  @extension("x-oaiTypeLabel", "map")
  file_search: {};
}

@summary("Function tool call")
model RunStepDeltaStepDetailsToolCallsFunctionObject {
  /** The index of the tool call in the tool calls array. */
  index: integer;

  /** The ID of the tool call object. */
  id?: string;

  /** The type of tool call. This is always going to be `function` for this type of tool call. */
  @extension("x-stainless-const", true)
  type: "function";

  /** The definition of the function that was called. */
  function?: {
    name?: string;
    arguments?: string;
    output?: string | null;
  };
}

model SubmitToolOutputsRunRequest {
  /** A list of tools for which the outputs are being submitted. */
  tool_outputs: {
    tool_call_id?: string;
    output?: string;
  }[];

  /** If `true`, returns a stream of events that happen during the Run as server-sent events, terminating when the Run enters a terminal state with a `data: [DONE]` message. */
  stream?: boolean | null;
}

model CreateRunRequestWithoutStream {
  /** The ID of the [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to execute this run. */
  assistant_id: string;

  /** The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to be used to execute this run. If a value is provided here, it will override the model associated with the assistant. If not, the model associated with the assistant will be used. */
  @extension("x-oaiTypeLabel", "string")
  `model`?: string | AssistantSupportedModels | null;

  reasoning_effort?: ReasoningEffort;

  /** Overrides the [instructions](https://platform.openai.com/docs/api-reference/assistants/createAssistant) of the assistant. This is useful for modifying the behavior on a per-run basis. */
  instructions?: string | null;

  /** Appends additional instructions at the end of the instructions for the run. This is useful for modifying the behavior on a per-run basis without overriding other instructions. */
  additional_instructions?: string | null;

  /** Adds additional messages to the thread before creating the run. */
  additional_messages?: CreateMessageRequest[] | null;

  /** Override the tools the assistant can use for this run. This is useful for modifying the behavior on a per-run basis. */
  @maxItems(20)
  tools?: AssistantTool[];

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

model SubmitToolOutputsRunRequestWithoutStream {
  /** A list of tools for which the outputs are being submitted. */
  tool_outputs: {
    tool_call_id?: string;
    output?: string;
  }[];
}
