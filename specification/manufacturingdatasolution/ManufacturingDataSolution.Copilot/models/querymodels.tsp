import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.QueryService.QueryModels;

@doc("query request")
@resource("query")
model QueryRequest {
  @key
  @doc("User query in natural language")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  ask: string;
}

@doc("Query Response Result")
model QueryResponse {
  @doc("Resultant Query Query or Query query execution response (JArray string)")
  result?: string;

  @doc("Summary of the Resultant Query Query or Query query execution response (JArray string)")
  summary?: string;
}
