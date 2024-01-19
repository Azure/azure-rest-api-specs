import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
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
interface BuildServices {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a build service resource.")
  @operationId("BuildService_GetBuildService")
  getBuildService is ArmResourceRead<BuildService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List build services resource.")
  @operationId("BuildService_ListBuildServices")
  listBuildServices is ArmResourceListByParent<BuildService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get an resource upload URL for build service, which may be artifacts or source archive.")
  @operationId("BuildService_GetResourceUploadUrl")
  getResourceUploadUrl is ArmResourceActionSync<
    BuildService,
    void,
    ResourceUploadDefinition
  >;
}
