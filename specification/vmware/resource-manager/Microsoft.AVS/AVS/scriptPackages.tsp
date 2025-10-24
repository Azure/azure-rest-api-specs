namespace Microsoft.AVS;

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;

@armResourceOperations
interface ScriptPackages {
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
  @visibility(Lifecycle.Read)
  provisioningState?: ScriptPackageProvisioningState;

  @doc("User friendly description of the package")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Module version")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("Company that created and supports the package")
  @visibility(Lifecycle.Read)
  company?: string;

  @doc("Link to support by the package vendor")
  @visibility(Lifecycle.Read)
  uri?: string;
}
