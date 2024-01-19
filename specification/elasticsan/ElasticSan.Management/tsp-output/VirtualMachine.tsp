import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
@doc("VirtualMachine represents the on-premises Network Cloud virtual machine.")
model VirtualMachine is TrackedResource<VirtualMachineProperties> {
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
interface VirtualMachines {
  @doc("Get properties of the provided virtual machine.")
  get is ArmResourceRead<VirtualMachine>;

  @doc("Create a new virtual machine or update the properties of the existing virtual machine.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualMachine,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  @doc("Patch the properties of the provided virtual machine, or update the tags associated with the virtual machine. Properties and tag updates can be done independently.")
  update is ArmCustomPatchAsync<
    VirtualMachine,
    VirtualMachinePatchParameters,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  @doc("Delete the provided virtual machine.")
  delete is ArmResourceDeleteAsync<
    VirtualMachine,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  @doc("Get a list of virtual machines in the provided resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualMachine>;

  @doc("Get a list of virtual machines in the provided subscription.")
  listBySubscription is ArmListBySubscription<VirtualMachine>;

  @doc("Power off the provided virtual machine.")
  powerOff is ArmResourceActionNoResponseContentAsync<
    VirtualMachine,
    VirtualMachinePowerOffParameters,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  @doc("Reimage the provided virtual machine.")
  reimage is ArmResourceActionNoResponseContentAsync<
    VirtualMachine,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  @doc("Restart the provided virtual machine.")
  restart is ArmResourceActionNoResponseContentAsync<
    VirtualMachine,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;

  @doc("Start the provided virtual machine.")
  start is ArmResourceActionNoResponseContentAsync<
    VirtualMachine,
    void,
    BaseParameters<VirtualMachine>,
    ArmLroLocationHeader
  >;
}

@@projectedName(VirtualMachines.createOrUpdate::parameters.resource,
  "json",
  "virtualMachineParameters"
);
@@extension(VirtualMachines.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "virtualMachineParameters"
);
@@doc(VirtualMachines.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(VirtualMachines.update::parameters.properties,
  "json",
  "virtualMachineUpdateParameters"
);
@@extension(VirtualMachines.update::parameters.properties,
  "x-ms-client-name",
  "virtualMachineUpdateParameters"
);
@@doc(VirtualMachines.update::parameters.properties, "The request body.");
@@projectedName(VirtualMachines.powerOff::parameters.body,
  "json",
  "virtualMachinePowerOffParameters"
);
@@extension(VirtualMachines.powerOff::parameters.body,
  "x-ms-client-name",
  "virtualMachinePowerOffParameters"
);
@@doc(VirtualMachines.powerOff::parameters.body, "The request body.");
