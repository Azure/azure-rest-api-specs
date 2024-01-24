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
 * NSX Virtual Machine
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateCloud)
@Azure.ResourceManager.Private.armResourceInternal(
  WorkloadNetworkVirtualMachineProperties
)
@includeInapplicableMetadataInPayload(false)
model WorkloadNetworkVirtualMachine extends ProxyResourceBase {
  /**
   * Virtual Machine identifier
   */
  @path
  @key("virtualMachineId")
  @segment("virtualMachines")
  name: string;

  /**
   * Virtual machine properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkloadNetworkVirtualMachineProperties;
}

@armResourceOperations
interface WorkloadNetworkVirtualMachines {
  /**
   * Get a virtual machine by id in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_GetVirtualMachine")
  getVirtualMachine is ArmResourceRead<WorkloadNetworkVirtualMachine>;

  /**
   * List of virtual machines in a private cloud workload network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WorkloadNetworks_ListVirtualMachines")
  listVirtualMachines is ArmResourceListByParent<WorkloadNetworkVirtualMachine>;
}
