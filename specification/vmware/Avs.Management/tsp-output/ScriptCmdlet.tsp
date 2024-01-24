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
/**
 * A cmdlet available for script execution
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ScriptPackage)
@Azure.ResourceManager.Private.armResourceInternal(ScriptCmdletProperties)
@includeInapplicableMetadataInPayload(false)
model ScriptCmdlet extends ProxyResourceBase {
  /**
   * Name of the script cmdlet resource in the script package in the private cloud
   */
  @pattern("^[-\\w\\._]+$")
  @path
  @key("scriptCmdletName")
  @segment("scriptCmdlets")
  name: string;

  /**
   * The properties of a script cmdlet resource
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScriptCmdletProperties;
}

@armResourceOperations
interface ScriptCmdlets {
  /**
   * Return information about a script cmdlet resource in a specific package on a private cloud
   */
  get is ArmResourceRead<ScriptCmdlet>;

  /**
   * List script cmdlet resources available for a private cloud to create a script execution resource on a private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScriptCmdlets_List")
  list is ArmResourceListByParent<ScriptCmdlet>;
}
