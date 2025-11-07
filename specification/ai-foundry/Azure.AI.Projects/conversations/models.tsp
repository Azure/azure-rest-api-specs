import "../responses/models.tsp";
import "../.external-readonly/openai.external.typespec/conversations/custom.tsp";

import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

alias ItemTypeQueryParameter = {
  @query
  @doc("Filter by item type. If provided, only items of the specified type will be returned.")
  item_type?: OpenAI.ItemType;
};

model ConversationList {
  /** A list of items used to generate this response. */
  data: OpenAI.ConversationResource[];

  ...CommonListObjectProperties;
}
