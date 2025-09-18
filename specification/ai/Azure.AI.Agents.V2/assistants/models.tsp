import "@typespec/openapi";
import "../common/models.tsp";
import "../vector-stores/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Represents an `assistant` that can call the model and use tools. */
@summary("Assistant")
@extension(
  "x-oaiMeta",
  #{
    name: "The assistant object",
    beta: true,
    example: "{\n  \"id\": \"asst_abc123\",\n  \"object\": \"assistant\",\n  \"created_at\": 1698984975,\n  \"name\": \"Math Tutor\",\n  \"description\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": \"You are a personal math tutor. When asked a question, write and run Python code to answer the question.\",\n  \"tools\": [\n    {\n      \"type\": \"code_interpreter\"\n    }\n  ],\n  \"metadata\": {},\n  \"top_p\": 1.0,\n  \"temperature\": 1.0,\n  \"response_format\": \"auto\"\n}\n",
  }
)
model AssistantObject {
  /** The identifier, which can be referenced in API endpoints. */
  id: string;

  /** The object type, which is always `assistant`. */
  @extension("x-stainless-const", true)
  object: "assistant";

  /** The Unix timestamp (in seconds) for when the assistant was created. */
  created_at: integer;

  /** The name of the assistant. The maximum length is 256 characters. */
  @maxLength(256)
  name: string | null;

  /** The description of the assistant. The maximum length is 512 characters. */
  @maxLength(512)
  description: string | null;

  /** ID of the model to use. You can use the [List models](https://platform.openai.com/docs/api-reference/models/list) API to see all of your available models, or see our [Model overview](https://platform.openai.com/docs/models) for descriptions of them. */
  `model`: string;

  /** The system instructions that the assistant uses. The maximum length is 256,000 characters. */
  @maxLength(256000)
  instructions: string | null;

  /** A list of tool enabled on the assistant. There can be a maximum of 128 tools per assistant. Tools can be of types `code_interpreter`, `file_search`, or `function`. */
  @maxItems(128)
  tools: AssistantTool[] = #[];

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

  metadata: Metadata;

  /** What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. */
  @maxValue(2)
  @minValue(0)
  temperature?: numeric | null = 1;

  /**An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.

  We generally recommend altering this or temperature but not both.*/
  @maxValue(1)
  @minValue(0)
  top_p?: numeric | null = 1;

  response_format?: AssistantsApiResponseFormatOption;
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union AssistantTool {
  code_interpreter: AssistantToolsCode,
  file_search: AssistantToolsFileSearch,
  function: AssistantToolsFunction,
}

@summary("Code interpreter tool")
model AssistantToolsCode {
  /** The type of tool being defined: `code_interpreter` */
  @extension("x-stainless-const", true)
  type: "code_interpreter";
}

@summary("FileSearch tool")
model AssistantToolsFileSearch {
  /** The type of tool being defined: `file_search` */
  @extension("x-stainless-const", true)
  type: "file_search";

  /** Overrides for the file search tool. */
  file_search?: {
    @maxValue(50)
    @minValue(1)
    max_num_results?: integer;

    ranking_options?: FileSearchRankingOptions;
  };
}

/**The ranking options for the file search. If not specified, the file search tool will use the `auto` ranker and a score_threshold of 0.

See the [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.*/
@summary("File search tool call ranking options")
model FileSearchRankingOptions {
  ranker?: FileSearchRanker;

  /** The score threshold for the file search. All values must be a floating point number between 0 and 1. */
  @maxValue(1)
  @minValue(0)
  score_threshold: numeric;
}

@summary("Function tool")
model AssistantToolsFunction {
  /** The type of tool being defined: `function` */
  @extension("x-stainless-const", true)
  type: "function";

  function: FunctionObject;
}

/**Specifies the format that the model must output. Compatible with [GPT-4o](https://platform.openai.com/docs/models#gpt-4o), [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4), and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.

Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured Outputs which ensures the model will match your supplied JSON schema. Learn more in the [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).

Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the message the model generates is valid JSON.

**Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message. Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit, resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.*/
union AssistantsApiResponseFormatOption {
  "auto",
  ResponseFormatText,
  ResponseFormatJsonObject,
  ResponseFormatJsonSchema,
}

/** Controls for how a thread will be truncated prior to the run. Use this to control the initial context window of the run. */
@summary("Thread Truncation Controls")
model TruncationObject {
  /** The truncation strategy to use for the thread. The default is `auto`. If set to `last_messages`, the thread will be truncated to the n most recent messages in the thread. When set to `auto`, messages in the middle of the thread will be dropped to fit the context length of the model, `max_prompt_tokens`. */
  type: "auto" | "last_messages";

  /** The number of most recent messages from the thread when constructing the context for the run. */
  @minValue(1)
  last_messages?: integer | null;
}

/**Controls which (if any) tool is called by the model.
`none` means the model will not call any tools and instead generates a message.
`auto` is the default value and means the model can pick between generating a message or calling one or more tools.
`required` means the model must call one or more tools before responding to the user.
Specifying a particular tool like `{"type": "file_search"}` or `{"type": "function", "function": {"name": "my_function"}}` forces the model to call that tool.*/
union AssistantsApiToolChoiceOption {
  "none" | "auto" | "required",
  AssistantsNamedToolChoice,
}

/** Specifies a tool the model should use. Use to force the model to call a specific tool. */
model AssistantsNamedToolChoice {
  /** The type of the tool. If type is `function`, the function name must be set */
  type: "function" | "code_interpreter" | "file_search";

  function?: {
    name: string;
  };
}

@summary("FileSearch tool")
model AssistantToolsFileSearchTypeOnly {
  /** The type of tool being defined: `file_search` */
  @extension("x-stainless-const", true)
  type: "file_search";
}

model CreateAssistantRequest {
  /** ID of the model to use. You can use the [List models](https://platform.openai.com/docs/api-reference/models/list) API to see all of your available models, or see our [Model overview](https://platform.openai.com/docs/models) for descriptions of them. */
  @extension("x-oaiTypeLabel", "string")
  `model`: string | AssistantSupportedModels;

  /** The name of the assistant. The maximum length is 256 characters. */
  @maxLength(256)
  name?: string | null;

  /** The description of the assistant. The maximum length is 512 characters. */
  @maxLength(512)
  description?: string | null;

  /** The system instructions that the assistant uses. The maximum length is 256,000 characters. */
  @maxLength(256000)
  instructions?: string | null;

  reasoning_effort?: ReasoningEffort;

  /** A list of tool enabled on the assistant. There can be a maximum of 128 tools per assistant. Tools can be of types `code_interpreter`, `file_search`, or `function`. */
  @maxItems(128)
  tools?: AssistantTool[] = #[];

  /** A set of resources that are used by the assistant's tools. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs. */
  tool_resources?: {
    code_interpreter?: {
      @maxItems(20)
      file_ids?: string[] = #[];
    };
    file_search?: ToolResourcesFileSearch;
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

  response_format?: AssistantsApiResponseFormatOption;
}

enum AssistantSupportedModels {
  `gpt-5`,
  `gpt-5-mini`,
  `gpt-5-nano`,
  `gpt-5-2025-08-07`,
  `gpt-5-mini-2025-08-07`,
  `gpt-5-nano-2025-08-07`,
  `gpt-4.1`,
  `gpt-4.1-mini`,
  `gpt-4.1-nano`,
  `gpt-4.1-2025-04-14`,
  `gpt-4.1-mini-2025-04-14`,
  `gpt-4.1-nano-2025-04-14`,
  `o3-mini`,
  `o3-mini-2025-01-31`,
  o1,
  `o1-2024-12-17`,
  `gpt-4o`,
  `gpt-4o-2024-11-20`,
  `gpt-4o-2024-08-06`,
  `gpt-4o-2024-05-13`,
  `gpt-4o-mini`,
  `gpt-4o-mini-2024-07-18`,
  `gpt-4.5-preview`,
  `gpt-4.5-preview-2025-02-27`,
  `gpt-4-turbo`,
  `gpt-4-turbo-2024-04-09`,
  `gpt-4-0125-preview`,
  `gpt-4-turbo-preview`,
  `gpt-4-1106-preview`,
  `gpt-4-vision-preview`,
  `gpt-4`,
  `gpt-4-0314`,
  `gpt-4-0613`,
  `gpt-4-32k`,
  `gpt-4-32k-0314`,
  `gpt-4-32k-0613`,
  `gpt-3.5-turbo`,
  `gpt-3.5-turbo-16k`,
  `gpt-3.5-turbo-0613`,
  `gpt-3.5-turbo-1106`,
  `gpt-3.5-turbo-0125`,
  `gpt-3.5-turbo-16k-0613`,
}

model ToolResourcesFileSearch {
  /**The [vector store](/docs/api-reference/vector-stores/object) attached to this assistant.
  There can be a maximum of 1 vector store attached to the assistant.*/
  @maxItems(1)
  vector_store_ids?: string[];

  /**A helper to create a [vector store](/docs/api-reference/vector-stores/object) with
  file_ids and attach it to this assistant. There can be a maximum of 1 vector store
  attached to the assistant.*/
  @maxItems(1)
  vector_stores?: {
    @maxItems(10000)
    file_ids?: string[];

    @extension("x-oaiExpandable", true)
    chunking_strategy?: ChunkingStrategyRequestParam;

    @extension("x-oaiTypeLabel", "map")
    metadata?: Record<string>;
  }[];
}

model DeleteAssistantResponse {
  id: string;
  deleted: boolean;

  @extension("x-stainless-const", true)
  object: "assistant.deleted";
}

@extension(
  "x-oaiMeta",
  #{
    name: "List assistants response object",
    group: "chat",
    example: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"asst_abc123\",\n      \"object\": \"assistant\",\n      \"created_at\": 1698982736,\n      \"name\": \"Coding Tutor\",\n      \"description\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": \"You are a helpful assistant designed to make me better at coding!\",\n      \"tools\": [],\n      \"tool_resources\": {},\n      \"metadata\": {},\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"response_format\": \"auto\"\n    },\n    {\n      \"id\": \"asst_abc456\",\n      \"object\": \"assistant\",\n      \"created_at\": 1698982718,\n      \"name\": \"My Assistant\",\n      \"description\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": \"You are a helpful assistant designed to make me better at coding!\",\n      \"tools\": [],\n      \"tool_resources\": {},\n      \"metadata\": {},\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"response_format\": \"auto\"\n    },\n    {\n      \"id\": \"asst_abc789\",\n      \"object\": \"assistant\",\n      \"created_at\": 1698982643,\n      \"name\": null,\n      \"description\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": null,\n      \"tools\": [],\n      \"tool_resources\": {},\n      \"metadata\": {},\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"response_format\": \"auto\"\n    }\n  ],\n  \"first_id\": \"asst_abc123\",\n  \"last_id\": \"asst_abc789\",\n  \"has_more\": false\n}\n",
  }
)
model ListAssistantsResponse {
  object: string;
  data: AssistantObject[];
  first_id: string;
  last_id: string;
  has_more: boolean;
}

model ModifyAssistantRequest {
  /** ID of the model to use. You can use the [List models](https://platform.openai.com/docs/api-reference/models/list) API to see all of your available models, or see our [Model overview](https://platform.openai.com/docs/models) for descriptions of them. */
  `model`?: string | AssistantSupportedModels;

  reasoning_effort?: ReasoningEffort;

  /** The name of the assistant. The maximum length is 256 characters. */
  @maxLength(256)
  name?: string | null;

  /** The description of the assistant. The maximum length is 512 characters. */
  @maxLength(512)
  description?: string | null;

  /** The system instructions that the assistant uses. The maximum length is 256,000 characters. */
  @maxLength(256000)
  instructions?: string | null;

  /** A list of tool enabled on the assistant. There can be a maximum of 128 tools per assistant. Tools can be of types `code_interpreter`, `file_search`, or `function`. */
  @maxItems(128)
  tools?: AssistantTool[] = #[];

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

  response_format?: AssistantsApiResponseFormatOption;
}

model ToolResourcesFileSearchIdsOnly {
  /**The [vector store](/docs/api-reference/vector-stores/object) attached to this assistant.
  There can be a maximum of 1 vector store attached to the assistant.*/
  @maxItems(1)
  vector_store_ids?: string[];
}
