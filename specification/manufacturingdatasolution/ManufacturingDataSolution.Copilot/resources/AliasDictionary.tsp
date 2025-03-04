import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService.AliasDictionary;

@resource("aliases")
@doc("This is the request model for Alias")
model Alias {
  @doc("Id for the alias")
  @key("id")
  @visibility("read")
  id: string;

  @doc("Key for the alias")
  name: string;

  @doc("List of aliases")
  aliases: string[];

  @doc("Indicates if the alias is enabled")
  @visibility("read")
  isCustom: boolean = true;

  @doc("Indicates if the alias is enabled")
  @visibility("read")
  enabled: boolean;
}

@doc("This is the patch request to update the status of Alias")
model ActivateAlias {
  @doc("status of the alias")
  enabled: boolean;
}

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Aliases {
  @doc("Get an alias by Id")
  getAlias is Operations.ResourceRead<Alias>;

  @doc("Create an alias")
  createAlias is Operations.ResourceCreateWithServiceProvidedName<Alias>;

  @doc("Delete an alias")
  deleteAlias is Operations.ResourceDelete<Alias>;

  @doc("List all aliases")
  listAliases is Operations.ResourceList<Alias>;

  @doc("Update the status of an alias")
  updateAliasStatus is Operations.ResourceCreateOrUpdate<Alias>;

  @doc("Deactivate an alias")
  activateAlias is Operations.ResourceAction<
    Alias,
    ActivateAlias,
    ActivateAlias
  >;
}
