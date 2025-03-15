import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/instruction.tsp";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Instructions.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.Instructions;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

alias jobLocationResponseHeaders = ResponseHeadersTrait<
  {
    @doc("The background job location.")
    @header
    @pollingLocation
    operationLocation: string;
  },
  TraitContext.Create | TraitContext.Update | TraitContext.Delete
>;

@doc("Instructions")
interface Instructions {
  @doc("Gets single instruction.")
  get is apiOperations.ResourceRead<Instruction>;

  @doc("List Instruction resources")
  list is apiOperations.ResourceList<
    Instruction,
    QueryParametersTrait<{
      @doc("Get all active instructions by status.")
      @query
      status: InstructionStatusEnum;
    }>
  >;

  // @doc("Create an instruction.")
  // @pollingOperation(
  //   MdsSolution.CopilotService.OperationStatus.OperationProgress.getOperationResult
  // )
  // create is apiOperations.LongRunningResourceCreateWithServiceProvidedName<
  //   Instruction,
  //   jobLocationResponseHeaders
  // >;

  @doc("create Or Replace instructions.")
  @pollingOperation(MdsSolution.CopilotService.OperationStatus.OperationApi.get)
  createOrReplace is apiOperations.LongRunningResourceCreateOrReplace<Instruction>;

  @doc("Delete instructions.")
  @pollingOperation(MdsSolution.CopilotService.OperationStatus.OperationApi.get)
  delete is apiOperations.LongRunningResourceDelete<Instruction>;
}
