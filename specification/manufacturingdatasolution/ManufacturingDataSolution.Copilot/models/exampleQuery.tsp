import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.ExampleQuery.Models;

@doc("The sample query resource.")
model SampleQuery {
  @doc("The query language.")
  language: string = "KQL";

  @doc("The query string.")
  query: string;
}

@resource("exampleQuery")
@doc("The example query resource.")
model ExampleQueryRequest {
  @key("exampleId")
  @doc("The ID of the example query.")
  @visibility(Lifecycle.Read)
  exampleId: string;

  @doc("The user question associated with the example.")
  userQuestion: string;

  @doc("The linked instructions for the example query.")
  linkedInstructions: string[];

  @doc("The sample query for the example.")
  sampleQuery: SampleQuery;
}

@doc("The patch request for the example query.")
model LinkInstructionRequest {
  @doc("The linked instructions for the example query.")
  linkedInstructions?: string[];
}
