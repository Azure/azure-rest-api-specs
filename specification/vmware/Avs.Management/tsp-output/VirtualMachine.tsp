import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * Virtual Machine
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Cluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VirtualMachineProperties)
model VirtualMachine extends ProxyResourceBase {
  /**
   * Virtual Machine identifier
   */
  @path
  @key("virtualMachineId")
  @segment("virtualMachines")
  @visibility("read")
  name: string;

  /**
   * Virtual machine properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VirtualMachineProperties;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Get a virtual machine by id in a private cloud cluster
   */
  get is ArmResourceRead<VirtualMachine>;

  /**
   * List of virtual machines in a private cloud cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VirtualMachines_List")
  list is ArmResourceListByParent<VirtualMachine>;

  /**
   * Enable or disable DRS-driven VM movement restriction
   */
  restrictMovement is ArmResourceActionNoResponseContentAsync<
    VirtualMachine,
    VirtualMachineRestrictMovement
  >;
}

@@projectedName(VirtualMachines.restrictMovement::parameters.body,
  "json",
  "restrictMovement"
);
@@extension(VirtualMachines.restrictMovement::parameters.body,
  "x-ms-client-name",
  "restrictMovement"
);
@@doc(VirtualMachines.restrictMovement::parameters.body,
  "Whether VM DRS-driven movement is restricted (Enabled) or not (Disabled)"
);
