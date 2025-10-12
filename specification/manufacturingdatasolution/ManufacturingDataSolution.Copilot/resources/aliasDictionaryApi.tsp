import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/aliasDictionary.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Http;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.AliasDictionary.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.AliasDictionary;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

alias jobLocationResponseHeaders = ResponseHeadersTrait<
  {
    @doc("The background job location.")
    @header
    @pollingLocation
    operationLocation: string;
  },
  TraitContext.Create | TraitContext.Update | TraitContext.Delete
>;

interface Aliases {
  @doc("Get an alias by Id")
  get is Operations.ResourceRead<Alias>;

  @doc("Create an alias")
  @pollingOperation(
    MdsSolution.CopilotService.OperationStatus.OperationProgress.getOperationResult
  )
  create is Operations.LongRunningResourceCreateWithServiceProvidedName<
    Alias,
    jobLocationResponseHeaders
  >;

  @doc("Update an alias")
  @pollingOperation(
    MdsSolution.CopilotService.OperationStatus.OperationProgress.getOperationResult
  )
  createOrReplace is Operations.LongRunningResourceCreateOrReplace<Alias>;

  @doc("Delete an alias")
  delete is Operations.ResourceDelete<Alias>;

  @doc("List all aliases")
  list is Operations.ResourceList<Alias>;

  @doc("Deactivate an alias")
  updateState is Operations.ResourceAction<Alias, ActivateAlias, ActivateAlias>;
}
