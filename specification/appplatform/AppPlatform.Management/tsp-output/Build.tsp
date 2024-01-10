import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./BuildService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Build resource payload")
@parentResource(BuildService)
model Build is ProxyResource<BuildProperties> {
  @doc("The name of the build resource.")
  @key("buildName")
  @segment("builds")
  name: string;
}

@armResourceOperations
@projectedName("client", "BuildService")
interface Builds_BuildService {
  @doc("Get a KPack build.")
  getBuild is ArmResourceRead<Build>;

  @doc("Create or update a KPack build.")
  createOrUpdateBuild is ArmResourceCreateOrReplaceSync<Build>;

  @doc("List KPack builds.")
  listBuilds is ArmResourceListByParent<Build>;
}
