using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.AszLabHardware;

@doc("Microsoft.AszLabHardware/Pool/Server resource")
@parentResource(Pool)
model PoolServer is ProxyResource<PoolServerProperties> {
  @doc("The name of the server")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("serverName")
  @segment("servers")
  @path
  name: string;
}

@doc("Microsoft.AszLabHardware/Pool/Server properties")
model PoolServerProperties {
  ...ServerPropertiesBase;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Endpoint for managing the server")
  managementEndpoint?: string;
}

@armResourceOperations
interface PoolServers {
  get is ArmResourceRead<PoolServer>;
  listByParent is ArmResourceListByParent<PoolServer>;
}

scalar PoolServerResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AszLabHardware/pools/servers",
    }
  ]>;
