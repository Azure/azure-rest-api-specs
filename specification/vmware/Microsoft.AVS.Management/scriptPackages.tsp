namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface ScriptPackages {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Can not change existing operationId."
  @operationId("ScriptPackages_List")
  list is ArmResourceListByParent<
    ScriptPackage,
    Response = ArmResponse<ResourceList<ScriptPackage, "{name}sList">>
  >;

  get is ArmResourceRead<ScriptPackage>;
}

@doc("Script Package resources available for execution")
@parentResource(PrivateCloud)
model ScriptPackage is ProxyResource<ScriptPackageProperties> {
  @doc("Name of the script package.")
  @pattern("^[-\\w\\._@]+$")
  @key("scriptPackageName")
  @path
  @segment("scriptPackages")
  name: string;
}

@doc("Script Package provisioning state")
union ScriptPackageProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("Properties of a Script Package subresource")
model ScriptPackageProperties {
  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ScriptPackageProvisioningState;

  @doc("User friendly description of the package")
  @visibility("read")
  description?: string;

  @doc("Module version")
  @visibility("read")
  version?: string;

  @doc("Company that created and supports the package")
  @visibility("read")
  company?: string;

  @doc("Link to support by the package vendor")
  @visibility("read")
  uri?: string;
}
