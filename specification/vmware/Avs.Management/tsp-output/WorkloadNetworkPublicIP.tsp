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
@doc("NSX Public IP Block")
@parentResource(PrivateCloud)
model WorkloadNetworkPublicIP
  is ProxyResource<WorkloadNetworkPublicIPProperties> {
  @doc("NSX Public IP Block identifier. Generally the same as the Public IP Block's display name")
  @path
  @key("publicIPId")
  @segment("publicIPs")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkPublicIPS {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Public IP Block by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_GetPublicIP")
  getPublicIP is ArmResourceRead<WorkloadNetworkPublicIP>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a Public IP Block by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_CreatePublicIP")
  createPublicIP is ArmResourceCreateOrUpdateAsync<WorkloadNetworkPublicIP>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Public IP Block by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_DeletePublicIP")
  deletePublicIP is ArmResourceDeleteAsync<WorkloadNetworkPublicIP>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of Public IP Blocks in a private cloud workload network.")
  @operationId("WorkloadNetworks_ListPublicIPs")
  listPublicIPs is ArmResourceListByParent<WorkloadNetworkPublicIP>;
}

@@projectedName(WorkloadNetworkPublicIPS.createPublicIP::parameters.resource,
  "json",
  "workloadNetworkPublicIP"
);
@@extension(WorkloadNetworkPublicIPS.createPublicIP::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkPublicIP"
);
@@doc(WorkloadNetworkPublicIPS.createPublicIP::parameters.resource,
  "NSX Public IP Block"
);
