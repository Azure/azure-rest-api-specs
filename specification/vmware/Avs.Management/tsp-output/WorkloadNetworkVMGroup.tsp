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
@doc("NSX VM Group")
@parentResource(PrivateCloud)
model WorkloadNetworkVMGroup
  is ProxyResource<WorkloadNetworkVMGroupProperties> {
  @doc("NSX VM Group identifier. Generally the same as the VM Group's display name")
  @path
  @key("vmGroupId")
  @segment("vmGroups")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkVMGroups {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a vm group by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_GetVMGroup")
  getVMGroup is ArmResourceRead<WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a vm group by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_CreateVMGroup")
  createVMGroup is ArmResourceCreateOrUpdateAsync<WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update a vm group by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_UpdateVMGroup")
  updateVMGroup is ArmCustomPatchAsync<
    WorkloadNetworkVMGroup,
    WorkloadNetworkVMGroup
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a vm group by id in a private cloud workload network.")
  @operationId("WorkloadNetworks_DeleteVMGroup")
  deleteVMGroup is ArmResourceDeleteAsync<WorkloadNetworkVMGroup>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of vm groups in a private cloud workload network.")
  @operationId("WorkloadNetworks_ListVMGroups")
  listVMGroups is ArmResourceListByParent<WorkloadNetworkVMGroup>;
}

@@projectedName(WorkloadNetworkVMGroups.createVMGroup::parameters.resource,
  "json",
  "workloadNetworkVMGroup"
);
@@extension(WorkloadNetworkVMGroups.createVMGroup::parameters.resource,
  "x-ms-client-name",
  "workloadNetworkVMGroup"
);
@@doc(WorkloadNetworkVMGroups.createVMGroup::parameters.resource,
  "NSX VM Group"
);
@@projectedName(WorkloadNetworkVMGroups.updateVMGroup::parameters.properties,
  "json",
  "workloadNetworkVMGroup"
);
@@extension(WorkloadNetworkVMGroups.updateVMGroup::parameters.properties,
  "x-ms-client-name",
  "workloadNetworkVMGroup"
);
@@doc(WorkloadNetworkVMGroups.updateVMGroup::parameters.properties,
  "NSX VM Group"
);
