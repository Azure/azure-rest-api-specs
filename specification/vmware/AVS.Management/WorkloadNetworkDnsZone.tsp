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
@doc("NSX DNS Zone")
@parentResource(PrivateCloud)
model WorkloadNetworkDnsZone
  is ProxyResource<WorkloadNetworkDnsZoneProperties> {
  @doc("NSX DNS Zone identifier. Generally the same as the DNS Zone's display name")
  @path
  @key("dnsZoneId")
  @segment("dnsZones")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkDnsZones {
  @doc("Get a DNS zone by id in a private cloud workload network.")
  getDnsZone is ArmResourceRead<WorkloadNetworkDnsZone>;
  @doc("Create a DNS zone by id in a private cloud workload network.")
  createDnsZone is ArmResourceCreateOrUpdateAsync<WorkloadNetworkDnsZone>;
  @doc("Create or update a DNS zone by id in a private cloud workload network.")
  updateDnsZone is ArmResourcePatchAsync<
    WorkloadNetworkDnsZone,
    WorkloadNetworkDnsZoneProperties
  >;
  @doc("Delete a DNS zone by id in a private cloud workload network.")
  deleteDnsZone is ArmResourceDeleteAsync<WorkloadNetworkDnsZone>;
  @doc("List of DNS zones in a private cloud workload network.")
  listDnsZones is ArmResourceListByParent<WorkloadNetworkDnsZone>;
}
