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
/**
 * NSX VM Group
 */
@parentResource(PrivateCloud)
model WorkloadNetworkVMGroup
  is ProxyResource<WorkloadNetworkVMGroupProperties> {
  /**
   * NSX VM Group identifier. Generally the same as the VM Group's display name
   */
  @path
  @key("vmGroupId")
  @segment("vmGroups")
  name: string;
}

@armResourceOperations
interface WorkloadNetworkVMGroups {
  /**
   * Get a vm group by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetVMGroup")
  getVMGroup is ArmResourceRead<WorkloadNetworkVMGroup>;

  /**
   * Create a vm group by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_CreateVMGroup")
  createVMGroup is ArmResourceCreateOrReplaceAsync<WorkloadNetworkVMGroup>;

  /**
   * Create or update a vm group by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WorkloadNetworks_UpdateVMGroup")
  updateVMGroup is ArmCustomPatchAsync<
    WorkloadNetworkVMGroup,
    WorkloadNetworkVMGroup
  >;

  /**
   * Delete a vm group by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_DeleteVMGroup")
  deleteVMGroup is ArmResourceDeleteAsync<WorkloadNetworkVMGroup>;

  /**
   * List of vm groups in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
