import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/exampleQuery.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.ExampleQuery.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.ExampleQueryService;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

interface ExampleQueryOperations {
  @doc("get the example query")
  getExample is apiOperations.ResourceRead<ExampleQueryRequest>;

  @doc("get all example queries")
  listAllExamples is apiOperations.ResourceList<
    ExampleQueryRequest,
    QueryParametersTrait<{
      @doc("Instruction id.")
      @query
      instructionId?: string;
    }>
  >;

  @doc("update the example query")
  createOrReplace is apiOperations.ResourceCreateOrReplace<ExampleQueryRequest>;

  @doc("delete the example query")
  deleteExample is apiOperations.ResourceDelete<ExampleQueryRequest>;

  @doc("Update instruction status.")
  linkInstruction is apiOperations.ResourceAction<
    ExampleQueryRequest,
    LinkInstructionRequest,
    LinkInstructionRequest
  >;
}
