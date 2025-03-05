import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace MdsSolution.CopilotService.AliasDictionary.Models;

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
