import "./common.tsp";
import "../models/networkResource.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.PhysicalNetwork Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.PhysicalNetwork management service" })
@versioned(Versions)
namespace Microsoft.PhysicalNetwork;

@Versioning.added(Versions.v2025_04_01_preview)
@parentResource(TenantLocationResource)
model TorRouterResource is ProxyResource<NetworkDeviceProperties> {
  /** The network device's name, same as Hostname. */
  @key("deviceName")
  @segment("torRouters")
  @path
  @pattern(resourceNameRegex)
  name: string;
}

@Versioning.added(Versions.v2025_04_01_preview)
@armResourceOperations
interface TorRouters {
  get is ArmResourceRead<TorRouterResource>;
  list is ArmResourceListByParent<TorRouterResource>;
}
