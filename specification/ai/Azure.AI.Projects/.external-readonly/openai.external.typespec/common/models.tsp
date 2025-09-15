import "@typespec/openapi";
import "../chat/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
/** The ranker to use for the file search. If not specified will use the `auto` ranker. */
enum FileSearchRanker {
  auto,
  default_2024_08_21,
}

model FunctionObject {
  /** A description of what the function does, used by the model to choose when and how to call the function. */
  description?: string;

  /** The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
  name: string;

  parameters?: FunctionParameters;

  /** Whether to enable strict schema adherence when generating the function call. If set to true, the model will follow the exact schema defined in the `parameters` field. Only a subset of JSON Schema is supported when `strict` is `true`. Learn more about Structured Outputs in the [function calling guide](https://platform.openai.com/docs/guides/function-calling). */
  strict?: boolean | null;
}

/**The parameters the functions accepts, described as a JSON Schema object. See the [guide](https://platform.openai.com/docs/guides/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format.

Omitting `parameters` defines a function with an empty parameter list.*/
model FunctionParameters {}

/**Set of 16 key-value pairs that can be attached to an object. This can be
useful for storing additional information about the object in a structured
format, and querying for objects via API or the dashboard.

Keys are strings with a maximum length of 64 characters. Values are strings
with a maximum length of 512 characters.*/
@extension("x-oaiTypeLabel", "map")
model Metadata {}

/** Default response format. Used to generate text responses. */
@summary("Text")
model ResponseFormatText {
  /** The type of response format being defined. Always `text`. */
  @extension("x-stainless-const", true)
  type: "text";
}

/**JSON object response format. An older method of generating JSON responses.
Using `json_schema` is recommended for models that support it. Note that the
model will not generate JSON without a system or user message instructing it
to do so.*/
@summary("JSON object")
model ResponseFormatJsonObject {
  /** The type of response format being defined. Always `json_object`. */
  @extension("x-stainless-const", true)
  type: "json_object";
}

/**JSON Schema response format. Used to generate structured JSON responses.
Learn more about [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).*/
@summary("JSON schema")
model ResponseFormatJsonSchema {
  /** The type of response format being defined. Always `json_schema`. */
  @extension("x-stainless-const", true)
  type: "json_schema";

  /** Structured Outputs configuration options, including a JSON Schema. */
  @summary("JSON schema")
  json_schema: {
    description?: string;
    name: string;
    schema?: ResponseFormatJsonSchemaSchema;
    strict?: boolean | null;
  };
}

/**The schema for the response format, described as a JSON Schema object.
Learn how to build JSON schemas [here](https://json-schema.org/).*/
@summary("JSON schema")
model ResponseFormatJsonSchemaSchema {}

/** Whether to enable [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling) during tool use. */
scalar ParallelToolCalls extends boolean;

model Error {
  code: string | null;
  message: string;
  param: string | null;
  type: string;
}

/**Specifies the processing type used for serving the request.
- If set to 'auto', then the request will be processed with the service tier configured in the Project settings. Unless otherwise configured, the Project will use 'default'.
- If set to 'default', then the request will be processed with the standard pricing and performance for the selected model.
- If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or '[priority](https://openai.com/api-priority-processing/)', then the request will be processed with the corresponding service tier.
- When not set, the default behavior is 'auto'.

When the `service_tier` parameter is set, the response body will include the `service_tier` value based on the processing mode actually used to serve the request. This response value may be different from the value set in the parameter.*/
union ServiceTier {
  "auto",
  "default",
  "flex",
  "scale",
  "priority",
  null,
}

/** Usage statistics for the completion request. */
model CompletionUsage {
  /** Number of tokens in the generated completion. */
  completion_tokens: integer;

  /** Number of tokens in the prompt. */
  prompt_tokens: integer;

  /** Total number of tokens used in the request (prompt + completion). */
  total_tokens: integer;

  /** Breakdown of tokens used in a completion. */
  completion_tokens_details?: {
    accepted_prediction_tokens?: integer;
    audio_tokens?: integer;
    reasoning_tokens?: integer;
    rejected_prediction_tokens?: integer;
  };

  /** Breakdown of tokens used in the prompt. */
  prompt_tokens_details?: {
    audio_tokens?: integer;
    cached_tokens?: integer;
  };
}

/** Options for streaming response. Only set this when you set `stream: true`. */
model ChatCompletionStreamOptions {
  /**If set, an additional chunk will be streamed before the `data: [DONE]`
  message. The `usage` field on this chunk shows the token usage statistics
  for the entire request, and the `choices` field will always be an empty
  array.

  All other chunks will also include a `usage` field, but with a null
  value. **NOTE:** If the stream is interrupted, you may not receive the
  final usage chunk which contains the total token usage for the request.*/
  include_usage?: boolean;

  /**When true, stream obfuscation will be enabled. Stream obfuscation adds
  random characters to an `obfuscation` field on streaming delta events to
  normalize payload sizes as a mitigation to certain side-channel attacks.
  These obfuscation fields are included by default, but add a small amount
  of overhead to the data stream. You can set `include_obfuscation` to
  false to optimize for bandwidth if you trust the network links between
  your application and the OpenAI API.*/
  include_obfuscation?: boolean;
}

/**Constrains effort on reasoning for
[reasoning models](https://platform.openai.com/docs/guides/reasoning).
Currently supported values are `minimal`, `low`, `medium`, and `high`. Reducing
reasoning effort can result in faster responses and fewer tokens used
on reasoning in a response.*/
union ReasoningEffort {
  "minimal",
  "low",
  "medium",
  "high",
  null,
}

model ModelResponseProperties {
  metadata?: Metadata;

  /**An integer between 0 and 20 specifying the number of most likely tokens to
  return at each token position, each with an associated log probability.*/
  @maxValue(20)
  @minValue(0)
  top_logprobs?: integer | null;

  /**What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  We generally recommend altering this or `top_p` but not both.*/
  @maxValue(2)
  @minValue(0)
  temperature?: numeric | null = 1;

  /**An alternative to sampling with temperature, called nucleus sampling,
  where the model considers the results of the tokens with top_p probability
  mass. So 0.1 means only the tokens comprising the top 10% probability mass
  are considered.

  We generally recommend altering this or `temperature` but not both.*/
  @maxValue(1)
  @minValue(0)
  top_p?: numeric | null = 1;

  /**This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching optimizations.
  A stable identifier for your end-users.
  Used to boost cache hit rates by better bucketing similar requests and  to help OpenAI detect and prevent abuse. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).*/
  user?: string;

  /**A stable identifier used to help detect users of your application that may be violating OpenAI's usage policies.
  The IDs should be a string that uniquely identifies each user. We recommend hashing their username or email address, in order to avoid sending us any identifying information. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).*/
  safety_identifier?: string;

  /** Used by OpenAI to cache responses for similar requests to optimize your cache hit rates. Replaces the `user` field. [Learn more](https://platform.openai.com/docs/guides/prompt-caching). */
  prompt_cache_key?: string;

  service_tier?: ServiceTier;
}

model CreateModelResponseProperties {
  metadata?: Metadata;

  /**An integer between 0 and 20 specifying the number of most likely tokens to
  return at each token position, each with an associated log probability.*/
  @maxValue(20)
  @minValue(0)
  top_logprobs?: integer | null;

  /**What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  We generally recommend altering this or `top_p` but not both.*/
  @maxValue(2)
  @minValue(0)
  temperature?: numeric | null = 1;

  /**An alternative to sampling with temperature, called nucleus sampling,
  where the model considers the results of the tokens with top_p probability
  mass. So 0.1 means only the tokens comprising the top 10% probability mass
  are considered.

  We generally recommend altering this or `temperature` but not both.*/
  @maxValue(1)
  @minValue(0)
  top_p?: numeric | null = 1;

  /**This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching optimizations.
  A stable identifier for your end-users.
  Used to boost cache hit rates by better bucketing similar requests and  to help OpenAI detect and prevent abuse. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).*/
  user?: string;

  /**A stable identifier used to help detect users of your application that may be violating OpenAI's usage policies.
  The IDs should be a string that uniquely identifies each user. We recommend hashing their username or email address, in order to avoid sending us any identifying information. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#safety-identifiers).*/
  safety_identifier?: string;

  /** Used by OpenAI to cache responses for similar requests to optimize your cache hit rates. Replaces the `user` field. [Learn more](https://platform.openai.com/docs/guides/prompt-caching). */
  prompt_cache_key?: string;

  service_tier?: ServiceTier;
}

union ModelIdsShared {
  string,
  ChatModel,
}

/**Output types that you would like the model to generate.
Most models are capable of generating text, which is the default:

`["text"]`

The `gpt-4o-audio-preview` model can also be used to
[generate audio](https://platform.openai.com/docs/guides/audio). To request that this model generate
both text and audio responses, you can use:

`["text", "audio"]`*/
union ResponseModalities {
  ("text" | "audio")[],
  null,
}

/** Approximate location parameters for the search. */
@summary("Web search location")
model WebSearchLocation {
  /**The two-letter
  [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of the user,
  e.g. `US`.*/
  country?: string;

  /** Free text input for the region of the user, e.g. `California`. */
  region?: string;

  /** Free text input for the city of the user, e.g. `San Francisco`. */
  city?: string;

  /**The [IANA timezone](https://timeapi.io/documentation/iana-timezones)
  of the user, e.g. `America/Los_Angeles`.*/
  timezone?: string;
}

/**High level guidance for the amount of context window space to use for the
search. One of `low`, `medium`, or `high`. `medium` is the default.*/
enum WebSearchContextSize {
  low,
  medium,
  high,
}

union VoiceIdsShared {
  string,

    | "alloy"
    | "ash"
    | "ballad"
    | "coral"
    | "echo"
    | "sage"
    | "shimmer"
    | "verse"
    | "marin"
    | "cedar",
}

/**Not supported with latest reasoning models `o3` and `o4-mini`.

Up to 4 sequences where the API will stop generating further tokens. The
returned text will not contain the stop sequence.*/
union StopConfiguration {
  string | null,
  string[],
  null,
}

model ErrorResponse {
  error: Error;
}

/** A log probability object. */
model LogProbProperties {
  /** The token that was used to generate the log probability. */
  token: string;

  /** The log probability of the token. */
  logprob: numeric;

  /** The bytes that were used to generate the log probability. */
  bytes: integer[];
}
