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
@doc("Script Package resources available for execution")
@parentResource(PrivateCloud)
model ScriptPackage is ProxyResource<ScriptPackageProperties> {
  @doc("Name of the script package in the private cloud")
  @path
  @key("scriptPackageName")
  @segment("scriptPackages")
  name: string;
}

@armResourceOperations
interface ScriptPackages {
  @doc("Get a script package available to run on a private cloud")
  get is ArmResourceRead<ScriptPackage>;

  @doc("List script packages available to run on the private cloud")
  list is ArmResourceListByParent<ScriptPackage>;
}
