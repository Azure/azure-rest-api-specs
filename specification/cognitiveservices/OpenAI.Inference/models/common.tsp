import "@typespec/http";
import "@typespec/versioning";

import "../main.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.OpenAI;

#suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI is a case-sensitive name"
@doc("The response data for a requested list of items.")
@added(ServiceApiVersions.v2024_07_01_Preview)
model OpenAIPageableListOf<T> {
  @doc("The object type, which is always list.")
  object: "list";

  @doc("The requested list of items.")
  data?: T[];

  @encodedName("application/json", "first_id")
  @doc("The first ID represented in this list.")
  firstId?: string;

  @encodedName("application/json", "last_id")
  @doc("The last ID represented in this list.")
  lastId?: string;

  @encodedName("application/json", "has_more")
  @doc("A value indicating whether there are additional values available not captured in this list.")
  hasMore?: boolean;
}
