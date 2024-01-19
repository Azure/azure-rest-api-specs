import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a DNS zone by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_GetDnsZone")
  getDnsZone is ArmResourceRead<WorkloadNetworkDnsZone>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a DNS zone by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_CreateDnsZone")
  createDnsZone is ArmResourceCreateOrUpdateAsync<WorkloadNetworkDnsZone>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a DNS zone by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_UpdateDnsZone")
  updateDnsZone is ArmCustomPatchAsync<
    WorkloadNetworkDnsZone,
    WorkloadNetworkDnsZone
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a DNS zone by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_DeleteDnsZone")
  deleteDnsZone is ArmResourceDeleteAsync<WorkloadNetworkDnsZone>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of DNS zones in a private cloud workload network.")
  @operationId("WorkloadNetworks_ListDnsZones")
  listDnsZones is ArmResourceListByParent<WorkloadNetworkDnsZone>;
}

@@projectedName(WorkloadNetworkDnsZones.createDnsZone::parameters.resource,
  "json",
  "workloadNetworkDnsZone"
);
@@extension(WorkloadNetworkDnsZones.createDnsZone::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDnsZone"
);
@@doc(WorkloadNetworkDnsZones.createDnsZone::parameters.resource,
  "NSX DNS Zone"
);
@@projectedName(WorkloadNetworkDnsZones.updateDnsZone::parameters.properties,
  "json",
  "workloadNetworkDnsZone"
);
@@extension(WorkloadNetworkDnsZones.updateDnsZone::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDnsZone"
);
@@doc(WorkloadNetworkDnsZones.updateDnsZone::parameters.properties,
  "NSX DNS Zone"
);
