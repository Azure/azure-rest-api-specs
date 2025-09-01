import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.KubernetesRuntime;

@doc("A LoadBalancer resource for an Arc connected cluster (Microsoft.Kubernetes/connectedClusters)")
model LoadBalancer is ExtensionResource<LoadBalancerProperties> {
  @doc("The name of the LoadBalancer")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("loadBalancerName")
  @segment("loadBalancers")
  @path
  name: string;
}

@doc("Enum of advertise mode")
union AdvertiseMode {
  string,

  @doc("ARP advertise mode")
  ARP: "ARP",

  @doc("BGP advertise mode")
  BGP: "BGP",

  @doc("both ARP and BGP advertise mode")
  Both: "Both",
}

@doc("Details of the LoadBalancer.")
model LoadBalancerProperties {
  @doc("IP Range")
  addresses: string[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The type of the field is a record because it is a mapping of labels in the customer cluster"
  @doc("A dynamic label mapping to select related services. For instance, if you want to create a load balancer only for services with label \"a=b\", then please specify {\"a\": \"b\"} in the field.")
  serviceSelector?: Record<string>;

  @doc("Advertise Mode")
  advertiseMode: AdvertiseMode;

  @doc("The list of BGP peers it should advertise to. Null or empty means to advertise to all peers.")
  @added(Microsoft.KubernetesRuntime.Versions.v2024_03_01)
  bgpPeers?: string[];

  @visibility(Lifecycle.Read)
  @doc("Resource provision state")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(LoadBalancer)
interface LoadBalancers {
  get is ArmResourceRead<LoadBalancer>;
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    LoadBalancer,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  @sharedRoute
  @added(Versions.v2024_03_01)
  delete is ArmResourceDeleteSync<LoadBalancer>;
  #suppress "@azure-tools/typespec-providerhub/non-breaking-versioning" "The intended way to change the delete operation from async to sync. Ref: https://github.com/Azure/typespec-azure/issues/312"
  @sharedRoute
  @renamedFrom(Versions.v2024_03_01, "delete")
  @removed(Versions.v2024_03_01)
  oldDelete is ArmResourceDeleteWithoutOkAsync<LoadBalancer>;
  list is ArmResourceListByParent<LoadBalancer>;
}
