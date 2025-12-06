import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace OpenAI;

@discriminator("type")
model ResponseFormat {
  type: "text" | "json_object" | "json_schema";
}

alias AcceptJsonHeader = {
  @header accept: "application/json";
};

alias AcceptJsonOrEventStreamHeader = {
  @header accept: "application/json" | "text/event-stream";
};

alias AssistantsBetaHeader = {
  @header("OpenAI-Beta") openAIBeta: "assistants=v2";
};

alias PageLimitQueryParameter = {
  /**
   * A limit on the number of objects to be returned. Limit can range between 1 and 100, and the
   * default is 20.
   */
  @query limit?: int32 = 20;
};

alias PageOrderQueryParameter = {
  /**
   * Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and`desc`
   * for descending order.
   */
  @query order?: "asc" | "desc";
};

alias PageAfterQueryParameter = {
  /**
   * A cursor for use in pagination. `after` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include after=obj_foo in order to fetch the next page of the list.
   */
  @query @continuationToken after?: string;
};

alias PageBeforeQueryParameter = {
  /**
   * A cursor for use in pagination. `before` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include before=obj_foo in order to fetch the previous page of the list.
   */
  @query before?: string;
};

alias CommonPageQueryParameters = {
  ...PageLimitQueryParameter;
  ...PageOrderQueryParameter;
  ...PageAfterQueryParameter;
  ...PageBeforeQueryParameter;
};

alias SseResponseOf<T> = {
  @header("Content-Type") contentType: "text/event-stream";
  @body responseBody: T;
};
