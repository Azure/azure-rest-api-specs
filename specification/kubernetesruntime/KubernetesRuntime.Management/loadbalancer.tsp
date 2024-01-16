import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.KubernetesRuntime;

@doc("A LoadBalancer resource")
model LoadBalancer is ExtensionResource<LoadBalancerProperties> {
  @doc("The name of the LoadBalancer")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("loadBalancerName")
  @segment("loadBalancers")
  @path
  name: string;
}

@doc("Enum of advertise mode")
enum AdvertiseMode {
  @doc("ARP advertise mode")
  ARP,

  @doc("BGP advertise mode")
  BGP,

  @doc("both ARP and BGP advertise mode")
  Both,
}

@doc("Details of the LoadBalancer.")
model LoadBalancerProperties {
  @doc("IP Range")
  addresses: string[];

  @doc("A dynamic label mapping to select related services. For instance, if you want to create a load balancer only for services with label \"a=b\", then please specify {\"a\": \"b\"} in the field.")
  serviceSelector?: Record<string>;

  @doc("Advertise Mode")
  advertiseMode: AdvertiseMode;

  @visibility("read")
  @doc("Resource provision state")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(LoadBalancer)
interface LoadBalancers {
  get is ArmResourceRead<LoadBalancer>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LoadBalancer>;
  delete is ArmResourceDeleteWithoutOkAsync<LoadBalancer>;
  listByParent is ArmResourceListByParent<LoadBalancer>;
}
