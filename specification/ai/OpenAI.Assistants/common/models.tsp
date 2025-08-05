import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

@doc("The possible values for roles attributed to messages in a thread.")
@added(ServiceApiVersions.v2024_02_15_preview)
union MessageRole {
  string,

  @doc("The role representing the end-user.")
  user: "user",

  @doc("The role representing the assistant.")
  assistant: "assistant",
}

@doc("The available sorting options when requesting a list of response objects.")
union ListSortOrder {
  string,

  @doc("Specifies an ascending sort order.")
  ascending: "asc",

  @doc("Specifies a descending sort order.")
  descending: "desc",
}

alias OpenAIListRequestOptions = {
  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @query
  limit?: int32 = 20;

  @doc("Sort order by the created_at timestamp of the objects. asc for ascending order and desc for descending order.")
  @query
  order?: ListSortOrder = ListSortOrder.descending;

  @doc("A cursor for use in pagination. after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list.")
  @query
  after?: string;

  @doc("A cursor for use in pagination. before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list.")
  @query
  before?: string;
};

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("The response data for a requested list of items.")
model OpenAIPageableListOf<T> {
  @doc("The object type, which is always list.")
  object: "list";

  @doc("The requested list of items.")
  data: T[];

  @encodedName("application/json", "first_id")
  @doc("The first ID represented in this list.")
  firstId: string;

  @encodedName("application/json", "last_id")
  @doc("The last ID represented in this list.")
  lastId: string;

  @encodedName("application/json", "has_more")
  @doc("A value indicating whether there are additional values available not captured in this list.")
  hasMore: boolean;
}

alias DeletionStatus = {
  @doc("The ID of the resource specified for deletion.")
  id: string;

  @doc("A value indicating whether deletion was successful.")
  deleted: boolean;
};

alias RequiredNullableMetadata = {
  /**
   * A set of up to 16 key/value pairs that can be attached to an object, used for storing additional information about that object in a structured format. Keys may be up to 64 characters in length and values may be up to 512 characters in length.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  metadata: Record<string> | null;
};

alias OptionalNullableMetadata = {
  /**
   * A set of up to 16 key/value pairs that can be attached to an object, used for storing additional information about that object in a structured format. Keys may be up to 64 characters in length and values may be up to 512 characters in length.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "OpenAI uses explicit nullability, distinct from optionality"
  metadata?: Record<string> | null;
};

/**
 * Specifies the format that the model must output. Compatible with GPT-4o, GPT-4 Turbo, and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
 *
 * Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured Outputs which ensures the model will match your supplied JSON
 * schema. Learn more in the Structured Outputs guide.
 *
 * Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the message the model generates is valid JSON.
 *
 * **Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message.
 * Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit,
 * resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off
 * if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
@added(ServiceApiVersions.v2024_05_01_preview)
union AssistantsApiResponseFormatOption {
  string,

  /** The model will handle the return format. */
  AssistantsApiResponseFormatMode,

  /** Sets the format of the output of the model when a ToolCall is returned. */
  AssistantsApiResponseFormat,
}

/** Represents the mode in which the model will handle the return format of a tool call. */
@added(ServiceApiVersions.v2024_05_01_preview)
union AssistantsApiResponseFormatMode {
  string,

  /** Default value. Let the model handle the return format. */
  "auto",

  /** Setting the value to `none`, will result in a 400 Bad request. */
  @removed(ServiceApiVersions.v2025_01_01_preview)
  "none",
}

/**
 * An object describing the expected output of the model. If `json_object` only `function` type `tools` are allowed to be passed to the Run.
 * If `text` the model can return text or any value needed.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
@discriminator("type")
model AssistantsApiResponseFormat {
  /** Must be one of `text`, `json_object` or `json_schema` . */
  type?: ApiResponseFormat = ApiResponseFormat.text;
}

/**
 * An object describing expected output of the model as text.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model AssistantsApiResponseFormatText extends AssistantsApiResponseFormat {
  /** The type of response format being defined: `text` */
  type: ApiResponseFormat.text;
}

/**
 * An object describing expected output of the model as a JSON object.
 */
@added(ServiceApiVersions.v2024_05_01_preview)
model AssistantsApiResponseFormatJsonObject
  extends AssistantsApiResponseFormat {
  /** The type of response format being defined: `json_object` */
  type: ApiResponseFormat.jsonObject;
}

/**
 * An object describing expected output of the model to match a JSON schema.
 */
@added(ServiceApiVersions.v2025_01_01_preview)
model AssistantsApiResponseFormatJsonSchema
  extends AssistantsApiResponseFormat {
  /** The type of response format being defined: `json_schema` */
  type: ApiResponseFormat.jsonSchema;

  /** The JSON schema that the model must output. */
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with current SDKs."
  @encodedName("application/json", "json_schema")
  jsonSchema: {
    /** A description of what the response format is for, used by the model to determine how to respond in the format. */
    description?: string;

    /** The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. */
    name: string;

    /** The schema for the response format, described as a JSON Schema object. */
    #suppress "@azure-tools/typespec-azure-core/no-unknown" "External API shape takes an arbitrary json"
    schema: unknown;

    /**
     * Whether to enable strict schema adherence when generating the output. If set to true, the model will always follow the exact schema defined in the `schema` field. Only a subset of JSON Schema is supported when `strict` is `true`. To learn more, read the Structured Outputs guide.
     */
    strict?: boolean;
  };
}

/** Possible API response formats. */
@added(ServiceApiVersions.v2024_05_01_preview)
union ApiResponseFormat {
  string,

  /** `text` format should be used for requests involving any sort of ToolCall. */
  text: "text",

  /** Using `json_object` format will limit the usage of ToolCall to only functions. */
  jsonObject: "json_object",

  /** Using `json_schema` format will ensure the model matches the supplied JSON schema. */
  jsonSchema: "json_schema",
}
