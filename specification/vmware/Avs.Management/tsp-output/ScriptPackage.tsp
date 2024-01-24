import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * Script Package resources available for execution
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@Azure.ResourceManager.Private.armResourceInternal(ScriptPackageProperties)
@includeInapplicableMetadataInPayload(false)
model ScriptPackage extends ProxyResourceBase {
  /**
   * Name of the script package in the private cloud
   */
  @pattern("^[-\\w\\._@]+$")
  @path
  @key("scriptPackageName")
  @segment("scriptPackages")
  name: string;

  /**
   * ScriptPackage resource properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ScriptPackageProperties;
}

@armResourceOperations
interface ScriptPackages {
  /**
   * Get a script package available to run on a private cloud
   */
  get is ArmResourceRead<ScriptPackage>;

  /**
   * List script packages available to run on the private cloud
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ScriptPackages_List")
  list is ArmResourceListByParent<ScriptPackage>;
}
