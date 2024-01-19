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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a DNS service by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_GetDnsService")
  getDnsService is ArmResourceRead<WorkloadNetworkDnsService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a DNS service by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_CreateDnsService")
  createDnsService is ArmResourceCreateOrUpdateAsync<WorkloadNetworkDnsService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a DNS service by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_UpdateDnsService")
  updateDnsService is ArmCustomPatchAsync<
    WorkloadNetworkDnsService,
    WorkloadNetworkDnsService
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a DNS service by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_DeleteDnsService")
  deleteDnsService is ArmResourceDeleteAsync<WorkloadNetworkDnsService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of DNS services in a private cloud workload network.")
  @operationId("WorkloadNetworks_ListDnsServices")
  listDnsServices is ArmResourceListByParent<WorkloadNetworkDnsService>;
}

@@projectedName(WorkloadNetworkDnsServices.createDnsService::parameters.resource,
  "json",
  "workloadNetworkDnsService"
);
@@extension(WorkloadNetworkDnsServices.createDnsService::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDnsService"
);
@@doc(WorkloadNetworkDnsServices.createDnsService::parameters.resource,
  "NSX DNS Service"
);
@@projectedName(WorkloadNetworkDnsServices.updateDnsService::parameters.properties,
  "json",
  "workloadNetworkDnsService"
);
@@extension(WorkloadNetworkDnsServices.updateDnsService::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDnsService"
);
@@doc(WorkloadNetworkDnsServices.updateDnsService::parameters.properties,
  "NSX DNS Service"
);
