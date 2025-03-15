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

// alias ServiceTraits = NoRepeatableRequests &
//   NoConditionalRequests &
//   NoClientRequestId;

// alias apiOperations = Azure.Core.ResourceOperations<ServiceTraits>;

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
  get is apiOperations.ResourceRead<Alias>;

  @doc("Update an alias")
  @pollingOperation(MdsSolution.CopilotService.OperationApi.get)
  createOrReplace is apiOperations.LongRunningResourceCreateOrReplace<Alias>;

  @doc("Delete an alias")
  delete is apiOperations.ResourceDelete<Alias>;

  @doc("List all aliases")
  list is apiOperations.ResourceList<Alias>;
}
