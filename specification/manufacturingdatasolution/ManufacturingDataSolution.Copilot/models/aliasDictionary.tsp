import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./../models/common.tsp";

using TypeSpec.Rest;

namespace MdsSolution.CopilotService.Models;

@resource("aliases")
@doc("This is the request model for Alias")
model Alias {
  @doc("Id for the alias")
  @key("id")
  @visibility(Lifecycle.Read)
  @maxLength(50)
  @pattern("^[a-zA-Z0-9_]*$")
  id: string;

  @doc("Key for the alias")
  name: string;

  @doc("List of aliases")
  aliases: string[];

  @doc("Indicates if the alias is enabled")
  @visibility(Lifecycle.Read)
  isCustom: Choice;

  @doc("Indicates if the alias is enabled")
  @visibility(Lifecycle.Update)
  state: ResourceState;
}
