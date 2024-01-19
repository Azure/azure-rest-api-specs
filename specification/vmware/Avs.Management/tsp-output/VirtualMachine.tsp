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
@doc("Virtual Machine")
@parentResource(Cluster)
model VirtualMachine is ProxyResource<VirtualMachineProperties> {
  @doc("Virtual Machine identifier")
  @path
  @key("virtualMachineId")
  @segment("virtualMachines")
  name: string;
}

@armResourceOperations
interface VirtualMachines {
  @doc("Get a virtual machine by id in a private cloud cluster")
  get is ArmResourceRead<VirtualMachine>;

  @doc("List of virtual machines in a private cloud cluster")
  list is ArmResourceListByParent<VirtualMachine>;

  @doc("Enable or disable DRS-driven VM movement restriction")
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
