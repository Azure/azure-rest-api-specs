namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface ScriptPackages {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("ScriptPackages_List")
  list is ArmResourceListByParent<
    ScriptPackage,
    Response = ArmResponse<ResourceList<ScriptPackage, "{name}sList">>
  >;

  get is ArmResourceRead<ScriptPackage>;
}
