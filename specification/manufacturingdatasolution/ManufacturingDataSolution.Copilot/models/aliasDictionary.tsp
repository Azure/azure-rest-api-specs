import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.AliasDictionary.Models;

@resource("aliases")
@doc("This is the request model for Alias")
model Alias {
  @doc("Id for the alias")
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Key for the alias")
  name: string;

  @doc("List of aliases")
  aliases: string[];

  @doc("Indicates if the alias is enabled")
  @visibility(Lifecycle.Read)
  isCustom: boolean = true;

  @doc("Indicates if the alias is enabled")
  @visibility(Lifecycle.Read)
  enabled: boolean;
}

@doc("This is the patch request to update the status of Alias")
model ActivateAlias {
  @doc("status of the alias")
  enabled: boolean;
}
