/*
 * This file was automatically generated from an OpenAPI .yaml file.
 * Edits made directly to this file will be lost.
 */

import "./custom.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

model Error {
  code: string | null;
  message: string;
  param: string | null;
  type: string;
}

// Tool customization: apply error decorator
@error
model ErrorResponse {
  error: Error;
}

// Tool customization: Wrap for reuse
@doc("""
  The parameters the functions accepts, described as a JSON Schema object. See the [guide](/docs/guides/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format.
  
  Omitting `parameters` defines a function with an empty parameter list.
  """)
model FunctionParametersCommon {
  /**
   * The parameters the functions accepts, described as a JSON Schema object. See the [guide](/docs/guides/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format.
   *
   * Omitting `parameters` defines a function with an empty parameter list.
   */
  parameters?: unknown;
}

model FunctionObject {
  /** A description of what the function does, used by the model to choose when and how to call the function. */
  description?: string;

  /** The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
  name: string;

  ...FunctionParametersCommon;

  @doc("""
    Whether to enable strict schema adherence when generating the function call. If set to true, the model will follow the exact schema defined in the `parameters` field. Only a subset of JSON Schema is supported when `strict` is `true`. Learn more about Structured Outputs in the [function calling guide](docs/guides/function-calling).
    """)
  strict?: boolean | null = false;
}

// Tool customization: Wrap for reuse
/**
 * Set of 16 key-value pairs that can be attached to an object. This can be
 * useful for storing additional information about the object in a structured
 * format, and querying for objects via API or the dashboard.
 *
 * Keys are strings with a maximum length of 64 characters. Values are strings
 * with a maximum length of 512 characters.
 */
model MetadataPropertyForRequest {
  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be
   * useful for storing additional information about the object in a structured
   * format, and querying for objects via API or the dashboard.
   *
   * Keys are strings with a maximum length of 64 characters. Values are strings
   * with a maximum length of 512 characters.
   */
  @extension("x-oaiTypeLabel", "map")
  metadata?: Record<string>;
}
model MetadataPropertyForResponse {
  /**
   * Set of 16 key-value pairs that can be attached to an object. This can be
   * useful for storing additional information about the object in a structured
   * format, and querying for objects via API or the dashboard.
   *
   * Keys are strings with a maximum length of 64 characters. Values are strings
   * with a maximum length of 512 characters.
   */
  @extension("x-oaiTypeLabel", "map")
  metadata: Record<string> | null;
}

// Tool customization (apply_discriminator): establish a common, discriminated union
/** Default response format. Used to generate text responses. */
model ResponseFormatText extends ResponseFormat {
  @doc("""
    The type of response format being defined. Always `text`.
    """)
  type: "text";
}

// Tool customization (apply_discriminator): establish a common, discriminated union
@doc("""
  JSON object response format. An older method of generating JSON responses.
  Using `json_schema` is recommended for models that support it. Note that the
  model will not generate JSON without a system or user message instructing it
  to do so.
  """)
model ResponseFormatJsonObject extends ResponseFormat {
  @doc("""
    The type of response format being defined. Always `json_object`.
    """)
  type: "json_object";
}

/**
 * The schema for the response format, described as a JSON Schema object.
 * Learn how to build JSON schemas [here](https://json-schema.org/).
 */
model ResponseFormatJsonSchemaSchema is Record<unknown>;

// Tool customization (apply_discriminator): establish a common, discriminated union
/**
 * JSON Schema response format. Used to generate structured JSON responses.
 * Learn more about [Structured Outputs](/docs/guides/structured-outputs).
 */
model ResponseFormatJsonSchema extends ResponseFormat {
  @doc("""
    The type of response format being defined. Always `json_schema`.
    """)
  type: "json_schema";

  /** Structured Outputs configuration options, including a JSON Schema. */
  json_schema: {
    /**
     * A description of what the response format is for, used by the model to
     * determine how to respond in the format.
     */
    description?: string;

    /**
     * The name of the response format. Must be a-z, A-Z, 0-9, or contain
     * underscores and dashes, with a maximum length of 64.
     */
    name: string;

    schema?: ResponseFormatJsonSchemaSchema;

    @doc("""
      Whether to enable strict schema adherence when generating the output.
      If set to true, the model will always follow the exact schema defined
      in the `schema` field. Only a subset of JSON Schema is supported when
      `strict` is `true`. To learn more, read the [Structured Outputs
      guide](/docs/guides/structured-outputs).
      """)
    strict?: boolean | null = false;
  };
}

/** Whether to enable [parallel function calling](/docs/guides/function-calling#configuring-parallel-function-calling) during tool use. */
scalar ParallelToolCalls extends boolean;

/** Usage statistics for the completion request. */
model CompletionUsage {
  /** Number of tokens in the generated completion. */
  completion_tokens: int32 = 0;

  /** Number of tokens in the prompt. */
  prompt_tokens: int32 = 0;

  /** Total number of tokens used in the request (prompt + completion). */
  total_tokens: int32 = 0;

  /** Breakdown of tokens used in a completion. */
  completion_tokens_details?: {
    /**
     * When using Predicted Outputs, the number of tokens in the
     * prediction that appeared in the completion.
     */
    accepted_prediction_tokens?: int32 = 0;

    /** Audio input tokens generated by the model. */
    audio_tokens?: int32 = 0;

    /** Tokens generated by the model for reasoning. */
    reasoning_tokens?: int32 = 0;

    /**
     * When using Predicted Outputs, the number of tokens in the
     * prediction that did not appear in the completion. However, like
     * reasoning tokens, these tokens are still counted in the total
     * completion tokens for purposes of billing, output, and context window
     * limits.
     */
    rejected_prediction_tokens?: int32 = 0;
  };

  /** Breakdown of tokens used in the prompt. */
  prompt_tokens_details?: {
    /** Audio input tokens present in the prompt. */
    audio_tokens?: int32 = 0;

    /** Cached tokens present in the prompt. */
    cached_tokens?: int32 = 0;
  };
}

@doc("""
  Options for streaming response. Only set this when you set `stream: true`.
  """)
model ChatCompletionStreamOptions {
  @doc("""
    If set, an additional chunk will be streamed before the `data: [DONE]`
    message. The `usage` field on this chunk shows the token usage statistics
    for the entire request, and the `choices` field will always be an empty
    array.
    
    All other chunks will also include a `usage` field, but with a null
    value. **NOTE:** If the stream is interrupted, you may not receive the
    final usage chunk which contains the total token usage for the request.
    """)
  include_usage?: boolean;
}

@doc("""
  **o-series models only**
  
  Constrains effort on reasoning for
  [reasoning models](https://platform.openai.com/docs/guides/reasoning).
  Currently supported values are `low`, `medium`, and `high`. Reducing
  reasoning effort can result in faster responses and fewer tokens used
  on reasoning in a response.
  """)
union ReasoningEffort {
  "low",
  "medium",
  "high",
}

// Tool customization: Stub for separated type
alias CreateModelResponseProperties = ModelResponsePropertiesForRequest;

// Tool customization: Replace imprecise common spread source with split request/response models honoring optionality and nullability
model ModelResponsePropertiesForRequest {
  ...MetadataPropertyForRequest;

  @doc("""
    What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    We generally recommend altering this or `top_p` but not both.
    """)
  @minValue(0)
  @maxValue(2)
  temperature?: float32 | null = 1;

  @doc("""
    An alternative to sampling with temperature, called nucleus sampling,
    where the model considers the results of the tokens with top_p probability
    mass. So 0.1 means only the tokens comprising the top 10% probability mass
    are considered.
    
    We generally recommend altering this or `temperature` but not both.
    """)
  @minValue(0)
  @maxValue(1)
  top_p?: float32 | null = 1;

  /** A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](/docs/guides/safety-best-practices#end-user-ids). */
  user?: string;

  service_tier?: ServiceTier;

  /** An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. */
  @minValue(0)
  @maxValue(20)
  top_logprobs?: int32;
}
model ModelResponsePropertiesForResponse {
  ...MetadataPropertyForResponse;

  @doc("""
    What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    We generally recommend altering this or `top_p` but not both.
    """)
  @minValue(0)
  @maxValue(2)
  temperature: float32 | null;

  @doc("""
    An alternative to sampling with temperature, called nucleus sampling,
    where the model considers the results of the tokens with top_p probability
    mass. So 0.1 means only the tokens comprising the top 10% probability mass
    are considered.
    
    We generally recommend altering this or `temperature` but not both.
    """)
  @minValue(0)
  @maxValue(1)
  top_p: float32 | null;

  /** A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](/docs/guides/safety-best-practices#end-user-ids). */
  user: string | null;

  service_tier?: ServiceTier;

  /** An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. */
  top_logprobs?: int32 | null;
}

@doc("""
  Output types that you would like the model to generate.
  Most models are capable of generating text, which is the default:
  
  `["text"]`
  
  The `gpt-4o-audio-preview` model can also be used to
  [generate audio](/docs/guides/audio). To request that this model generate
  both text and audio responses, you can use:
  
  `["text", "audio"]`
  """)
model ResponseModalities is ("text" | "audio")[];

@doc("""
  Not supported with latest reasoning models `o3` and `o4-mini`.
  
  Up to 4 sequences where the API will stop generating further tokens. The
  returned text will not contain the stop sequence.
  """)
union StopConfiguration {
  string,
  string[],
}

@doc("""
  High level guidance for the amount of context window space to use for the
  search. One of `low`, `medium`, or `high`. `medium` is the default.
  """)
union WebSearchContextSize {
  "low",
  "medium",
  "high",
}

/** Approximate location parameters for the search. */
model WebSearchLocation {
  @doc("""
    The two-letter
    [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of the user,
    e.g. `US`.
    """)
  country?: string;

  @doc("""
    Free text input for the region of the user, e.g. `California`.
    """)
  region?: string;

  @doc("""
    Free text input for the city of the user, e.g. `San Francisco`.
    """)
  city?: string;

  @doc("""
    The [IANA timezone](https://timeapi.io/documentation/iana-timezones)
    of the user, e.g. `America/Los_Angeles`.
    """)
  timezone?: string;
}

@doc("""
  The ranker to use for the file search. If not specified will use the `auto` ranker.
  """)
union FileSearchRanker {
  "auto",
  "default_2024_08_21",
}

union ModelIdsShared {
  string,
  "gpt-4.1",
  "gpt-4.1-mini",
  "gpt-4.1-nano",
  "gpt-4.1-2025-04-14",
  "gpt-4.1-mini-2025-04-14",
  "gpt-4.1-nano-2025-04-14",
  "o4-mini",
  "o4-mini-2025-04-16",
  "o3",
  "o3-2025-04-16",
  "o3-mini",
  "o3-mini-2025-01-31",
  "o1",
  "o1-2024-12-17",
  "o1-preview",
  "o1-preview-2024-09-12",
  "o1-mini",
  "o1-mini-2024-09-12",
  "gpt-4o",
  "gpt-4o-2024-11-20",
  "gpt-4o-2024-08-06",
  "gpt-4o-2024-05-13",
  "gpt-4o-audio-preview",
  "gpt-4o-audio-preview-2024-10-01",
  "gpt-4o-audio-preview-2024-12-17",
  "gpt-4o-audio-preview-2025-06-03",
  "gpt-4o-mini-audio-preview",
  "gpt-4o-mini-audio-preview-2024-12-17",
  "gpt-4o-search-preview",
  "gpt-4o-mini-search-preview",
  "gpt-4o-search-preview-2025-03-11",
  "gpt-4o-mini-search-preview-2025-03-11",
  "chatgpt-4o-latest",
  "codex-mini-latest",
  "gpt-4o-mini",
  "gpt-4o-mini-2024-07-18",
  "gpt-4-turbo",
  "gpt-4-turbo-2024-04-09",
  "gpt-4-0125-preview",
  "gpt-4-turbo-preview",
  "gpt-4-1106-preview",
  "gpt-4-vision-preview",
  "gpt-4",
  "gpt-4-0314",
  "gpt-4-0613",
  "gpt-4-32k",
  "gpt-4-32k-0314",
  "gpt-4-32k-0613",
  "gpt-3.5-turbo",
  "gpt-3.5-turbo-16k",
  "gpt-3.5-turbo-0301",
  "gpt-3.5-turbo-0613",
  "gpt-3.5-turbo-1106",
  "gpt-3.5-turbo-0125",
  "gpt-3.5-turbo-16k-0613",
}

/** A log probability object. */
model LogProbProperties {
  /** The token that was used to generate the log probability. */
  token: string;

  /** The log probability of the token. */
  logprob: float32;

  /** The bytes that were used to generate the log probability. */
  bytes: int32[];
}

union VoiceIdsShared {
  string,
  "alloy",
  "ash",
  "ballad",
  "coral",
  "echo",
  "fable",
  "onyx",
  "nova",
  "sage",
  "shimmer",
  "verse",
}

@doc("""
  Specifies the processing type used for serving the request.
    - If set to 'auto', then the request will be processed with the service tier configured in the Project settings. Unless otherwise configured, the Project will use 'default'.
    - If set to 'default', then the request will be processed with the standard pricing and performance for the selected model.
    - If set to '[flex](/docs/guides/flex-processing)' or 'priority', then the request will be processed with the corresponding service tier. [Contact sales](https://openai.com/contact-sales) to learn more about Priority processing.
    - When not set, the default behavior is 'auto'.
  
    When the `service_tier` parameter is set, the response body will include the `service_tier` value based on the processing mode actually used to serve the request. This response value may be different from the value set in the parameter.
  """)
union ServiceTier {
  "auto",
  "default",
  "flex",
  "scale",
  "priority",
}

/**Set of 16 key-value pairs that can be attached to an object. This can be
useful for storing additional information about the object in a structured
format, and querying for objects via API or the dashboard.

Keys are strings with a maximum length of 64 characters. Values are strings
with a maximum length of 512 characters.*/
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@extension("x-oaiTypeLabel", "map")
model Metadata {}

/**The parameters the functions accepts, described as a JSON Schema object. See the [guide](https://platform.openai.com/docs/guides/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format.

Omitting `parameters` defines a function with an empty parameter list.*/
model FunctionParameters {}
