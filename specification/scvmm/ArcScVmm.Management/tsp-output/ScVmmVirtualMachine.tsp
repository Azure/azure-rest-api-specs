import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ArcScVmm;
@doc("The VirtualMachines resource definition.")
model ScVmmVirtualMachine is TrackedResource<VirtualMachineProperties> {
  @doc("Name of the VirtualMachine.")
  @path
  @key("virtualMachineName")
  @segment("virtualMachines")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface ScVmmVirtualMachines {
  @doc("Implements VirtualMachine GET method.")
  get is ArmResourceRead<ScVmmVirtualMachine>;
  @doc("Creates Or Updates virtual machines deployed on scvmm fabric.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ScVmmVirtualMachine>;
  @doc("Updates the VirtualMachines resource.")
  update is ArmResourcePatchAsync<
    ScVmmVirtualMachine,
    VirtualMachineProperties
  >;
  @doc("Deletes a VirtualMachine deployed on ScVmm fabric.")
  delete is ArmResourceDeleteAsync<
    ScVmmVirtualMachine,
    {
      ...BaseParameters<ScVmmVirtualMachine>;

      @doc("Whether to just disable the VM from azure and retain the VM in the VMM.")
      @query("retain")
      retain?: boolean;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("List of VirtualMachines in a resource group.")
  listByResourceGroup is ArmResourceListByParent<ScVmmVirtualMachine>;
  @doc("List of VirtualMachines in a subscription.")
  listBySubscription is ArmListBySubscription<ScVmmVirtualMachine>;
  @doc("Stop virtual machine.")
  stop is ArmResourceActionAsync<
    ScVmmVirtualMachine,
    StopVirtualMachineOptions,
    void
  >;
  @doc("Start virtual machine.")
  start is ArmResourceActionAsync<ScVmmVirtualMachine, void, void>;
  @doc("Restart virtual machine.")
  restart is ArmResourceActionAsync<ScVmmVirtualMachine, void, void>;
  @doc("Creates a checkpoint in virtual machine.")
  createCheckpoint is ArmResourceActionAsync<
    ScVmmVirtualMachine,
    VirtualMachineCreateCheckpoint,
    void
  >;
  @doc("Deletes a checkpoint in virtual machine.")
  deleteCheckpoint is ArmResourceActionAsync<
    ScVmmVirtualMachine,
    VirtualMachineDeleteCheckpoint,
    void
  >;
  @doc("Restores to a checkpoint in virtual machine.")
  restoreCheckpoint is ArmResourceActionAsync<
    ScVmmVirtualMachine,
    VirtualMachineRestoreCheckpoint,
    void
  >;
}
