import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Agents;

@doc("The possible values for roles attributed to messages in a thread.")
union MessageRole {
  string,

  @doc("The role representing the end-user.")
  user: "user",

  @doc("The role representing the agent.")
  agent: "assistant",
}

@doc("The available sorting options when requesting a list of response objects.")
union ListSortOrder {
  string,

  @doc("Specifies an ascending sort order.")
  ascending: "asc",

  @doc("Specifies a descending sort order.")
  descending: "desc",
}

alias AgentsListOptions = {
  @doc("A limit on the number of objects to be returned on one page. Limit can range between 1 and 100, and the default is 20.")
  @query
  limit?: int32 = 20;

  @doc("Sort order by the created_at timestamp of the objects. asc for ascending order and desc for descending order.")
  @query
  order?: ListSortOrder = ListSortOrder.descending;

  @doc("A cursor for use in pagination. after is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list.")
  @query
  @continuationToken
  after?: string;

  @doc("A cursor for use in pagination. before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list.")
  @query
  before?: string;
};

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("The response data for a requested list of items.")
model AgentsPagedResult<T> {
  @doc("The requested list of items.")
  @pageItems
  data: T[];

  @encodedName("application/json", "last_id")
  @doc("The last ID represented in this list.")
  @continuationToken
  lastId?: string;

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
 * Specifies the format that the model must output. Compatible with GPT-4 Turbo and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
 *
 * Setting to `{ "type": "json_object" }` enables JSON mode, which guarantees the message the model generates is valid JSON.
 *
 * **Important:** when using JSON mode, you **must** also instruct the model to produce JSON yourself via a system or user message.
 * Without this, the model may generate an unending stream of whitespace until the generation reaches the token limit,
 * resulting in a long-running and seemingly "stuck" request. Also note that the message content may be partially cut off
 * if `finish_reason="length"`, which indicates the generation exceeded `max_tokens` or the conversation exceeded the max context length.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "This union is defined according to the OpenAI API"
union AgentsResponseFormatOption {
  string,

  /** The model will handle the return format. */
  AgentsResponseFormatMode,

  /** Sets the format of the output of the model when a ToolCall is returned. */
  AgentsResponseFormat,

  /** Using `json_schema` format will provide a description of what the response format is for. */
  ResponseFormatJsonSchemaType,
}

/** Represents the mode in which the model will handle the return format of a tool call. */
union AgentsResponseFormatMode {
  string,

  /** Default value. Let the model handle the return format. */
  "auto",

  /** Setting the value to `none`, will result in a 400 Bad request. */
  "none",
}

/**
 * An object describing the expected output of the model. If `json_object` only `function` type `tools` are allowed to be passed to the Run.
 * If `text` the model can return text or any value needed.
 */
model AgentsResponseFormat {
  /** Must be one of `text` or `json_object`. */
  type?: ResponseFormat = ResponseFormat.text;
}

/** Possible API response formats. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
union ResponseFormat {
  string,

  /** `text` format should be used for requests involving any sort of ToolCall. */
  text: "text",

  /** Using `json_object` format will limit the usage of ToolCall to only functions. */
  jsonObject: "json_object",
}

/**
 * The type of response format being defined: `json_schema`
 */
model ResponseFormatJsonSchemaType {
  /** Type */
  type: "json_schema";

  /** The JSON schema, describing response format. */
  @encodedName("application/json", "json_schema")
  jsonSchema: ResponseFormatJsonSchema;
}

/**
 * A description of what the response format is for, used by the model to determine how to respond in the format.
 */
#suppress "@azure-tools/typespec-azure-core/no-unknown" "JSON schema takes an arbitrary json"
model ResponseFormatJsonSchema {
  /** A description of what the response format is for, used by the model to determine how to respond in the format. */
  description?: string;

  /** The name of a schema. */
  name: string;

  /** The JSON schema object, describing the response format. */
  schema: unknown;
}
