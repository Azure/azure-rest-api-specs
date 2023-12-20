import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Config Server resource")
@parentResource(AppPlatformService)
@singleton("default")
model AppPlatformConfigServer is ProxyResource<ConfigServerProperties> {
  @key("default")
  @segment("configServers")
  name: string;
}

@armResourceOperations
interface AppPlatformConfigServers {
  @doc("Get the config server and its properties.")
  get is ArmResourceRead<AppPlatformConfigServer>;
  @doc("Update the config server.")
  updatePut is ArmResourceCreateOrUpdateAsync<AppPlatformConfigServer>;
  @doc("Update the config server.")
  updatePatch is ArmResourcePatchAsync<
    AppPlatformConfigServer,
    ConfigServerProperties
  >;
}
