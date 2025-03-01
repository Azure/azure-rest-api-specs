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

/**
 * Represents a request model for alias dictionary.
 */
@resource("aliases")
model Alias {
  /** Id for the alias */
  @key("id")
  @visibility("read")
  id: string;

  /** Key for the alias */
  @visibility("read")
  @doc("Key for the alias")
  name: string;

  @visibility("read")
  /** List of aliases */
  aliases: string[];

  /** Indicates if the alias is enabled */
  @visibility("read")
  isCustom: boolean = true;

  /** status of the alias */
  @visibility("update")
  enabled: boolean;
}

@resource("aliases")
@doc("Alias Create or Update Request model")
model AliasCreateOrUpdateRequest {
  /** Key for the alias */
  /** Id for the alias */
  @key("id")
  @visibility("read")
  id: string;

  /** unique key for the alias e.g. production, person */
  key: string;

  /** List of aliases */
  aliases: string[];
}

@resource("aliases")
@doc("This is the patch request to update the status of Alias")
model UpdateAliasStatus {
  /** Id for the alias */
  @key("id")
  @visibility("read")
  id: string;

  /** status of the alias */
  enabled: boolean;
}

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Aliases {
  /** Fetch an alias by Id. */
  getAlias is Operations.ResourceRead<Alias>;

  /** Creates or updates an alias */
  createOrReplaceAlias is Operations.ResourceCreateOrReplace<AliasCreateOrUpdateRequest>;

  /** Delete an alias */
  deleteAlias is Operations.ResourceDelete<Alias>;

  /** List Alias resources */
  listAliases is Operations.ResourceList<Alias>;

  /** update alias status */
  updateAliasStatus is Operations.ResourceCreateOrUpdate<UpdateAliasStatus>;

  activeAlias is Operations.ResourceCollectionAction<Alias, Alias, {}>;
}
