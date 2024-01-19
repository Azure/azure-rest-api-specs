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
@doc("NSX DHCP")
@parentResource(PrivateCloud)
model WorkloadNetworkDhcp is ProxyResource<WorkloadNetworkDhcpEntity> {
  @doc("NSX DHCP identifier. Generally the same as the DHCP display name")
  @path
  @key("dhcpId")
  @segment("dhcpConfigurations")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkDhcps {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get dhcp by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_GetDhcp")
  getDhcp is ArmResourceRead<WorkloadNetworkDhcp>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create dhcp by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_CreateDhcp")
  createDhcp is ArmResourceCreateOrUpdateAsync<WorkloadNetworkDhcp>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update dhcp by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_UpdateDhcp")
  updateDhcp is ArmCustomPatchAsync<WorkloadNetworkDhcp, WorkloadNetworkDhcp>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete dhcp by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_DeleteDhcp")
  deleteDhcp is ArmResourceDeleteAsync<WorkloadNetworkDhcp>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List dhcp in a private cloud workload network.")
  @operationId("WorkloadNetworks_ListDhcp")
  listDhcp is ArmResourceListByParent<WorkloadNetworkDhcp>;
}

@@projectedName(WorkloadNetworkDhcps.createDhcp::parameters.resource,
  "json",
  "workloadNetworkDhcp"
);
@@extension(WorkloadNetworkDhcps.createDhcp::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);
@@doc(WorkloadNetworkDhcps.createDhcp::parameters.resource, "NSX DHCP");
@@projectedName(WorkloadNetworkDhcps.updateDhcp::parameters.properties,
  "json",
  "workloadNetworkDhcp"
);
@@extension(WorkloadNetworkDhcps.updateDhcp::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkDhcp"
);
@@doc(WorkloadNetworkDhcps.updateDhcp::parameters.properties, "NSX DHCP");
