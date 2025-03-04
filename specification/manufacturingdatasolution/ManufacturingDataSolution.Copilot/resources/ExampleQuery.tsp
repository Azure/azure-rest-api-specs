import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/copilotmodels.tsp";
import "./../models/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.ExampleQueryService;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

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
  @visibility("read")
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

interface ExampleQueryOperations {
  @doc("get the example query")
  getExample is apiOperations.ResourceRead<ExampleQueryRequest>;

  @doc("get all example queries")
  listAllExamples is apiOperations.ResourceList<ExampleQueryRequest>;

  @doc("update the example query")
  updateExample is apiOperations.ResourceCreateOrUpdate<ExampleQueryRequest>;

  @doc("delete the example query")
  deleteExample is apiOperations.ResourceDelete<ExampleQueryRequest>;

  @doc("create the example query")
  createExample is apiOperations.ResourceCreateWithServiceProvidedName<ExampleQueryRequest>;

  @doc("Update instruction status.")
  linkInstruction is apiOperations.ResourceAction<
    ExampleQueryRequest,
    LinkInstructionRequest,
    LinkInstructionRequest
  >;
}
