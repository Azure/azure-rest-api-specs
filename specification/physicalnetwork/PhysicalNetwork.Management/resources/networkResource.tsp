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

@parentResource(TenantLocationResource)
model NetworkDeviceResource is ProxyResource<NetworkDeviceProperties> {
  /** The network device's name, same as Hostname. */
  @key("deviceName")
  @segment("networkDevices")
  @path
  @pattern(resourceNameRegex)
  name: string;
}

@armResourceOperations
interface NetworkDevices {
  get is ArmResourceRead<NetworkDeviceResource>;
  list is ArmResourceListByParent<NetworkDeviceResource>;
}
