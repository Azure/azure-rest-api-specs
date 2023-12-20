import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("VirtualMachine represents the on-premises Network Cloud virtual machine.")
model NetworkCloudVirtualMachine is TrackedResource<VirtualMachineProperties> {
  @doc("The name of the virtual machine.")
  @pattern("^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$")
  @path
  @key("virtualMachineName")
  @segment("virtualMachines")
  name: string;

  @doc("The extended location of the cluster associated with the resource.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudVirtualMachines {
  @doc("Get properties of the provided virtual machine.")
  get is ArmResourceRead<NetworkCloudVirtualMachine>;
  @doc("Create a new virtual machine or update the properties of the existing virtual machine.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudVirtualMachine>;
  @doc("Patch the properties of the provided virtual machine, or update the tags associated with the virtual machine. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<
    NetworkCloudVirtualMachine,
    VirtualMachineProperties
  >;
  @doc("Delete the provided virtual machine.")
  delete is ArmResourceDeleteAsync<NetworkCloudVirtualMachine>;
  @doc("Get a list of virtual machines in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<NetworkCloudVirtualMachine>;
  @doc("Get a list of virtual machines in the provided subscription.")
  listBySubscription is ArmListBySubscription<NetworkCloudVirtualMachine>;
  @doc("Power off the provided virtual machine.")
  powerOff is ArmResourceActionNoResponseContentAsync<
    NetworkCloudVirtualMachine,
    VirtualMachinePowerOffParameters
  >;
  @doc("Reimage the provided virtual machine.")
  reimage is ArmResourceActionNoResponseContentAsync<
    NetworkCloudVirtualMachine,
    void
  >;
  @doc("Restart the provided virtual machine.")
  restart is ArmResourceActionNoResponseContentAsync<
    NetworkCloudVirtualMachine,
    void
  >;
  @doc("Start the provided virtual machine.")
  start is ArmResourceActionNoResponseContentAsync<
    NetworkCloudVirtualMachine,
    void
  >;
}
