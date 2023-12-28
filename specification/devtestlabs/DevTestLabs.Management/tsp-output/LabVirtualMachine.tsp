import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A virtual machine.")
@parentResource(Lab)
model LabVirtualMachine is TrackedResource<LabVirtualMachineProperties> {
  @doc("The name of the virtual machine.")
  @key("name")
  @segment("virtualmachines")
  name: string;
}

@armResourceOperations
interface VirtualMachines {
  @doc("Get virtual machine.")
  get is ArmResourceRead<
    LabVirtualMachine,
    {
      ...BaseParameters<LabVirtualMachine>;

      @doc("Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing virtual machine. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LabVirtualMachine>;
  @doc("Allows modifying tags of virtual machines. All other properties will be ignored.")
  update is ArmCustomPatchSync<LabVirtualMachine, LabVirtualMachineFragment>;
  @doc("Delete virtual machine. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<LabVirtualMachine>;
  @doc("List virtual machines in a given lab.")
  list is ArmResourceListByParent<
    LabVirtualMachine,
    {
      ...BaseParameters<LabVirtualMachine>;

      @doc("Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'")
      @query("$expand")
      $expand?: string;

      @doc("The filter to apply to the operation. Example: '$filter=contains(name,'myName')")
      @query("$filter")
      $filter?: string;

      @doc("The maximum number of resources to return from the operation. Example: '$top=10'")
      @query("$top")
      $top?: int32;

      @doc("The ordering expression for the results, using OData notation. Example: '$orderby=name desc'")
      @query("$orderby")
      $orderby?: string;
    }
  >;
  @doc("Attach a new or existing data disk to virtual machine. This operation can take a while to complete.")
  addDataDisk is ArmResourceActionAsync<
    LabVirtualMachine,
    DataDiskProperties,
    void
  >;
  @doc("Apply artifacts to virtual machine. This operation can take a while to complete.")
  applyArtifacts is ArmResourceActionAsync<
    LabVirtualMachine,
    ApplyArtifactsRequest,
    void
  >;
  @doc("Take ownership of an existing virtual machine This operation can take a while to complete.")
  claim is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Detach the specified disk from the virtual machine. This operation can take a while to complete.")
  detachDataDisk is ArmResourceActionAsync<
    LabVirtualMachine,
    DetachDataDiskProperties,
    void
  >;
  @doc("Gets a string that represents the contents of the RDP file for the virtual machine")
  getRdpFileContents is ArmResourceActionSync<
    LabVirtualMachine,
    void,
    RdpConnection
  >;
  @doc("Lists the applicable start/stop schedules, if any.")
  listApplicableSchedules is ArmResourceActionSync<
    LabVirtualMachine,
    void,
    ApplicableSchedule
  >;
  @doc("Redeploy a virtual machine This operation can take a while to complete.")
  redeploy is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Resize Virtual Machine. This operation can take a while to complete.")
  resize is ArmResourceActionAsync<
    LabVirtualMachine,
    ResizeLabVirtualMachineProperties,
    void
  >;
  @doc("Restart a virtual machine. This operation can take a while to complete.")
  restart is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Start a virtual machine. This operation can take a while to complete.")
  start is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Stop a virtual machine This operation can take a while to complete.")
  stop is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Transfers all data disks attached to the virtual machine to be owned by the current user. This operation can take a while to complete.")
  transferDisks is ArmResourceActionAsync<LabVirtualMachine, void, void>;
  @doc("Release ownership of an existing virtual machine This operation can take a while to complete.")
  unClaim is ArmResourceActionAsync<LabVirtualMachine, void, void>;
}
