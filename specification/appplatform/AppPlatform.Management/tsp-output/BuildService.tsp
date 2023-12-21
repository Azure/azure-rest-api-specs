import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Build service resource payload")
@parentResource(ServiceResource)
model BuildService is ProxyResource<BuildServiceProperties> {
  @doc("The name of the build service resource.")
  @path
  @key("buildServiceName")
  @segment("buildServices")
  name: string;
}

@armResourceOperations
interface BuildService {
  @doc("Get a build service resource.")
  getBuildService is ArmResourceRead<BuildService>;
  @doc("List build services resource.")
  listBuildServices is ArmResourceListByParent<BuildService>;
  @doc("Get an resource upload URL for build service, which may be artifacts or source archive.")
  getResourceUploadUrl is ArmResourceActionSync<
    BuildService,
    void,
    ResourceUploadDefinition
  >;
}
