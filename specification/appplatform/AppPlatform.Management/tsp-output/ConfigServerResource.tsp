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
@doc("Config Server resource")
@singleton("default")
@parentResource(ServiceResource)
model ConfigServerResource is ProxyResource<ConfigServerProperties> {
  @key("default")
  @segment("configServers")
  name: string;
}

@armResourceOperations
interface ConfigServers {
  @doc("Get the config server and its properties.")
  get is ArmResourceRead<ConfigServerResource>;
  @doc("Update the config server.")
  updatePut is ArmResourceCreateOrUpdateAsync<ConfigServerResource>;
  @doc("Update the config server.")
  updatePatch is ArmResourcePatchAsync<
    ConfigServerResource,
    ConfigServerProperties
  >;
}
