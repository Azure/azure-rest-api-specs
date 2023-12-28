import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Supported buildpack resource payload")
@parentResource(BuildService)
model SupportedBuildpackResource
  is ProxyResource<SupportedBuildpackResourceProperties> {
  @doc("The name of the buildpack resource.")
  @key("buildpackName")
  @segment("supportedBuildpacks")
  name: string;
}

@armResourceOperations
interface BuildService {
  @doc("Get the supported buildpack resource.")
  getSupportedBuildpack is ArmResourceRead<SupportedBuildpackResource>;
  @doc("Get all supported buildpacks.")
  listSupportedBuildpacks is ArmResourceListByParent<SupportedBuildpackResource>;
}
