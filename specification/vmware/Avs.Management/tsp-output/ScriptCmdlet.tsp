import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ScriptPackage.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
@doc("A cmdlet available for script execution")
@parentResource(ScriptPackage)
model ScriptCmdlet is ProxyResource<ScriptCmdletProperties> {
  @doc("Name of the script cmdlet resource in the script package in the private cloud")
  @path
  @key("scriptCmdletName")
  @segment("scriptCmdlets")
  name: string;
}

@armResourceOperations
interface ScriptCmdlets {
  @doc("Return information about a script cmdlet resource in a specific package on a private cloud")
  get is ArmResourceRead<ScriptCmdlet>;

  @doc("List script cmdlet resources available for a private cloud to create a script execution resource on a private cloud")
  list is ArmResourceListByParent<ScriptCmdlet>;
}
