import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * Script Package resources available for execution
 */
@parentResource(PrivateCloud)
model ScriptPackage
  is Azure.ResourceManager.ProxyResource<ScriptPackageProperties> {
  ...ResourceNameParameter<
    Resource = ScriptPackage,
    KeyName = "scriptPackageName",
    SegmentName = "scriptPackages",
    NamePattern = "^[-\\w\\._@]+$"
  >;
}

@armResourceOperations
interface ScriptPackages {
  /**
   * Get a ScriptPackage
   */
  get is ArmResourceRead<ScriptPackage>;

  /**
   * List ScriptPackage resources by PrivateCloud
   */
  list is ArmResourceListByParent<
    ScriptPackage,
    Response = ArmResponse<ScriptPackagesList>
  >;
}

@@doc(ScriptPackage.name, "Name of the script package.");
@@doc(ScriptPackage.properties,
  "The resource-specific properties for this resource."
);
