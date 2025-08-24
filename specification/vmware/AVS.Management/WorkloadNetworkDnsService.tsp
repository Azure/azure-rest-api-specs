import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("NSX DNS Service")
@parentResource(PrivateCloud)
model WorkloadNetworkDnsService
  is ProxyResource<WorkloadNetworkDnsServiceProperties> {
  @doc("NSX DNS Service identifier. Generally the same as the DNS Service's display name")
  @path
  @key("dnsServiceId")
  @segment("dnsServices")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkDnsServices {
  @doc("Get a DNS service by id in a private cloud workload network.")
  getDnsService is ArmResourceRead<WorkloadNetworkDnsService>;
  @doc("Create a DNS service by id in a private cloud workload network.")
  createDnsService is ArmResourceCreateOrUpdateAsync<WorkloadNetworkDnsService>;
  @doc("Create or update a DNS service by id in a private cloud workload network.")
  updateDnsService is ArmResourcePatchAsync<
    WorkloadNetworkDnsService,
    WorkloadNetworkDnsServiceProperties
  >;
  @doc("Delete a DNS service by id in a private cloud workload network.")
  deleteDnsService is ArmResourceDeleteAsync<WorkloadNetworkDnsService>;
  @doc("List of DNS services in a private cloud workload network.")
  listDnsServices is ArmResourceListByParent<WorkloadNetworkDnsService>;
}
