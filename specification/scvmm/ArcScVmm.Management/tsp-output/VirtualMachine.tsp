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

namespace Microsoft.ScVmm;
@doc("The VirtualMachines resource definition.")
model VirtualMachine is TrackedResource<VirtualMachineProperties> {
  @doc("Name of the VirtualMachine.")
  @path
  @key("virtualMachineName")
  @segment("virtualMachines")
  name: string;

  @doc("The extended location.")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VirtualMachines {
  @doc("Implements VirtualMachine GET method.")
  get is ArmResourceRead<VirtualMachine>;

  @doc("Creates Or Updates virtual machines deployed on scvmm fabric.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    VirtualMachine,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the VirtualMachines resource.")
  update is ArmCustomPatchAsync<
    VirtualMachine,
    VirtualMachineUpdate,
    BaseParameters<VirtualMachine>,
    ArmAsyncOperationHeader
  >;

  @doc("Deletes a VirtualMachine deployed on ScVmm fabric.")
  delete is ArmResourceDeleteAsync<
    VirtualMachine,
    {
      ...BaseParameters<VirtualMachine>;

      @doc("Whether to just disable the VM from azure and retain the VM in the VMM.")
      @query("retain")
      retain?: boolean;

      @doc("Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.")
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  @doc("List of VirtualMachines in a resource group.")
  listByResourceGroup is ArmResourceListByParent<VirtualMachine>;

  @doc("List of VirtualMachines in a subscription.")
  listBySubscription is ArmListBySubscription<VirtualMachine>;

  @doc("Stop virtual machine.")
  stop is ArmResourceActionAsync<
    VirtualMachine,
    StopVirtualMachineOptions,
    void
  >;

  @doc("Start virtual machine.")
  start is ArmResourceActionAsync<VirtualMachine, void, void>;

  @doc("Restart virtual machine.")
  restart is ArmResourceActionAsync<VirtualMachine, void, void>;

  @doc("Creates a checkpoint in virtual machine.")
  createCheckpoint is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachineCreateCheckpoint,
    void
  >;

  @doc("Deletes a checkpoint in virtual machine.")
  deleteCheckpoint is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachineDeleteCheckpoint,
    void
  >;

  @doc("Restores to a checkpoint in virtual machine.")
  restoreCheckpoint is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachineRestoreCheckpoint,
    void
  >;
}

@@projectedName(VirtualMachines.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(VirtualMachines.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachines.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(VirtualMachines.update::parameters.properties, "json", "body");
@@extension(VirtualMachines.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VirtualMachines.update::parameters.properties,
  "VirtualMachines patch payload."
);
@@doc(VirtualMachines.stop::parameters.body,
  "Virtualmachine stop action payload."
);
@@doc(VirtualMachines.createCheckpoint::parameters.body,
  "Virtualmachine create checkpoint action payload."
);
@@doc(VirtualMachines.deleteCheckpoint::parameters.body,
  "Virtualmachine delete checkpoint action payload."
);
@@doc(VirtualMachines.restoreCheckpoint::parameters.body,
  "Virtualmachine restore checkpoint action payload."
);
