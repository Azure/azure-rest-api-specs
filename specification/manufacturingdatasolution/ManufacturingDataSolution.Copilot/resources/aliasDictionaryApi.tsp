import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/aliasDictionary.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Http;
using TypeSpec.Versioning;
using MdsSolution.CopilotService.Models;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

alias jobLocationResponseHeaders = ResponseHeadersTrait<
  {
    @doc("The background job location.")
    @header
    @pollingLocation
    operationLocation: string;
  },
  TraitContext.Create | TraitContext.Update | TraitContext.Delete
>;

@doc("Aliases client operations")
interface AliasesServiceClient {
  @doc("Get an alias by Id")
  get is apiOperations.ResourceRead<Alias>;

  @doc("Update an alias")
  @pollingOperation(MdsSolution.CopilotService.OperationServiceClient.get)
  createOrReplace is apiOperations.LongRunningResourceCreateOrReplace<Alias>;

  @doc("Delete an alias")
  delete is apiOperations.ResourceDelete<Alias>;

  @doc("List all aliases")
  list is apiOperations.ResourceList<Alias>;
}
