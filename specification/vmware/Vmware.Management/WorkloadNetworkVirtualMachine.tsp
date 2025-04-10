import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./WorkloadNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * NSX Virtual Machine
 */
@parentResource(WorkloadNetwork)
model WorkloadNetworkVirtualMachine
  is Azure.ResourceManager.ProxyResource<WorkloadNetworkVirtualMachineProperties> {
  ...ResourceNameParameter<
    Resource = WorkloadNetworkVirtualMachine,
    KeyName = "virtualMachineId",
    SegmentName = "virtualMachines",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface WorkloadNetworkVirtualMachines {
  /**
   * Get a WorkloadNetworkVirtualMachine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_GetVirtualMachine")
  getVirtualMachine is ArmResourceRead<WorkloadNetworkVirtualMachine>;

  /**
   * List WorkloadNetworkVirtualMachine resources by WorkloadNetwork
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkloadNetworks_ListVirtualMachines")
  listVirtualMachines is ArmResourceListByParent<
    WorkloadNetworkVirtualMachine,
    Response = ArmResponse<WorkloadNetworkVirtualMachinesList>
  >;
}

@@doc(WorkloadNetworkVirtualMachine.name, "ID of the virtual machine.");
@@doc(WorkloadNetworkVirtualMachine.properties,
  "The resource-specific properties for this resource."
);
