import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkCloudVirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetworkCloud;
@doc("Console represents the console of an on-premises Network Cloud virtual machine.")
@parentResource(NetworkCloudVirtualMachine)
model NetworkCloudVirtualMachineConsole is TrackedResource<ConsoleProperties> {
  @doc("The name of the virtual machine console.")
  @pattern("^default$")
  @path
  @key("consoleName")
  @segment("consoles")
  name: string;

  @doc("The extended location of the cluster manager associated with the cluster this virtual machine is created on.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface NetworkCloudVirtualMachineConsoles {
  @doc("Get properties of the provided virtual machine console.")
  get is ArmResourceRead<NetworkCloudVirtualMachineConsole>;
  @doc("Create a new virtual machine console or update the properties of the existing virtual machine console.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetworkCloudVirtualMachineConsole>;
  @doc("Patch the properties of the provided virtual machine console, or update the tags associated with the virtual machine console. Properties and tag updates can be done independently.")
  update is ArmResourcePatchAsync<
    NetworkCloudVirtualMachineConsole,
    ConsoleProperties
  >;
  @doc("Delete the provided virtual machine console.")
  delete is ArmResourceDeleteAsync<NetworkCloudVirtualMachineConsole>;
  @doc("Get a list of consoles for the provided virtual machine.")
  listByVirtualMachine is ArmResourceListByParent<NetworkCloudVirtualMachineConsole>;
}
