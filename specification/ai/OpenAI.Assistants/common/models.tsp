import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.OpenAI.Assistants;

@doc("The possible values for roles attributed to messages in a thread.")
@added(ServiceApiVersions.v2023_11_06_beta)
enum MessageRole {
  @doc("The role representing the end-user.")
  user: "user",

  @doc("The role representing the assistant.")
  assistant: "assistant",
}

@doc("The available sorting options when requesting a list of response objects.")
enum ListSortOrder {
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

  @doc("A cursor for use in pagination. before is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list.")
  @query
  before?: string;
};

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("The response data for a requested list of items.")
model ListResponseOf<T> {
  @doc("The object type, which is always list.")
  object: "list";

  @doc("The requested list of items.")
  data: T[];

  @projectedName("json", "first_id")
  @doc("The first ID represented in this list.")
  firstId: string;

  @projectedName("json", "last_id")
  @doc("The last ID represented in this list.")
  lastId: string;

  @projectedName("json", "has_more")
  @doc("A value indicating whether there are additional values available not captured in this list.")
  hasMore: boolean;
}

@doc("An abstract representation of an OpenAI deletion operation result status.")
// @discriminator("object")
model DeletionStatus {
  // @doc("The object type representing the deletion operation performed.")
  // object: string;

  @doc("A value indicating whether deletion was successful.")
  deleted: boolean;
}

alias OptionalMetadata = {
  /**
   * A set of up to 16 key/value pairs that can be attached to an object, used for storing additional information about that object in a structured format. Keys may be up to 64 characters in length and values may be up to 512 characters in length.
   */
  metadata?: Record<string>;
};
