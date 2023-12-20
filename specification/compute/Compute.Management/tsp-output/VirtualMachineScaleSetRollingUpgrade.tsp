import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineScaleSet.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Compute;
@doc("The status of the latest virtual machine scale set rolling upgrade.")
@parentResource(VirtualMachineScaleSet)
@singleton("latest")
model VirtualMachineScaleSetRollingUpgrade
  is TrackedResource<RollingUpgradeStatusInfoProperties> {
  @key("latest")
  @segment("rollingUpgrades")
  name: string;
}

@armResourceOperations
interface VirtualMachineScaleSetRollingUpgrades {
  @doc("Gets the status of the latest virtual machine scale set rolling upgrade.")
  getLatest is ArmResourceRead<
    VirtualMachineScaleSetRollingUpgrade,
    {
      ...BaseParameters<VirtualMachineScaleSetRollingUpgrade>;

      @doc("The name of the VM scale set.")
      @path
      vmScaleSetName: string;
    }
  >;
}
