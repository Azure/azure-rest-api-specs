import "@typespec/http";
import "@typespec/openapi";

import "../openai-responses/models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias ItemTypeQueryParameter = {
  @query
  @doc("Filter by item type. If provided, only items of the specified type will be returned.")
  item_type?: OpenAI.ItemType;
};
