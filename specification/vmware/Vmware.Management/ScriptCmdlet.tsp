import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ScriptPackage.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * A cmdlet available for script execution
 */
@parentResource(ScriptPackage)
model ScriptCmdlet
  is Azure.ResourceManager.ProxyResource<ScriptCmdletProperties> {
  ...ResourceNameParameter<
    Resource = ScriptCmdlet,
    KeyName = "scriptCmdletName",
    SegmentName = "scriptCmdlets",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface ScriptCmdlets {
  /**
   * Get a ScriptCmdlet
   */
  get is ArmResourceRead<ScriptCmdlet>;

  /**
   * List ScriptCmdlet resources by ScriptPackage
   */
  list is ArmResourceListByParent<
    ScriptCmdlet,
    Response = ArmResponse<ScriptCmdletsList>
  >;
}

@@doc(ScriptCmdlet.name, "Name of the script cmdlet.");
@@doc(ScriptCmdlet.properties,
  "The resource-specific properties for this resource."
);
