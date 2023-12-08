import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DevTestLab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DevTestLabs;
@doc("A virtual machine.")
@parentResource(DevTestLab)
model DevTestLabVm is TrackedResource<LabVirtualMachineProperties> {
  @doc("The name of the virtual machine.")
  @path
  @key("name")
  @segment("virtualmachines")
  name: string;
}

@armResourceOperations
interface DevTestLabVms {
  @doc("Get virtual machine.")
  get is ArmResourceRead<
    DevTestLabVm,
    {
      ...BaseParameters<DevTestLabVm>;

      @doc("Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or replace an existing virtual machine. This operation can take a while to complete.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DevTestLabVm>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Allows modifying tags of virtual machines. All other properties will be ignored.")
  update is ArmCustomPatchSync<DevTestLabVm, LabVirtualMachineFragment>;
  @doc("Delete virtual machine. This operation can take a while to complete.")
  delete is ArmResourceDeleteAsync<DevTestLabVm>;
  @doc("List virtual machines in a given lab.")
  list is ArmResourceListByParent<
    DevTestLabVm,
    {
      ...BaseParameters<DevTestLabVm>;

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
  addDataDisk is ArmResourceActionAsync<DevTestLabVm, DataDiskProperties, {}>;
  @doc("Apply artifacts to virtual machine. This operation can take a while to complete.")
  applyArtifacts is ArmResourceActionAsync<
    DevTestLabVm,
    ApplyArtifactsRequest,
    {}
  >;
  @doc("Take ownership of an existing virtual machine This operation can take a while to complete.")
  claim is ArmResourceActionAsync<DevTestLabVm, {}, {}>;
  @doc("Detach the specified disk from the virtual machine. This operation can take a while to complete.")
  detachDataDisk is ArmResourceActionAsync<
    DevTestLabVm,
    DetachDataDiskProperties,
    {}
  >;
  @doc("Gets a string that represents the contents of the RDP file for the virtual machine")
  getRdpFileContents is ArmResourceActionSync<DevTestLabVm, {}, RdpConnection>;
  @doc("Lists the applicable start/stop schedules, if any.")
  listApplicableSchedules is ArmResourceActionSync<
    DevTestLabVm,
    {},
    ApplicableSchedule
  >;
  @doc("Redeploy a virtual machine This operation can take a while to complete.")
  redeploy is ArmResourceActionAsync<DevTestLabVm, {}, {}>;
  @doc("Resize Virtual Machine. This operation can take a while to complete.")
  resize is ArmResourceActionAsync<
    DevTestLabVm,
    ResizeLabVirtualMachineProperties,
    {}
  >;
  @doc("Restart a virtual machine. This operation can take a while to complete.")
  restart is ArmResourceActionAsync<DevTestLabVm, {}, {}>;
  @doc("Start a virtual machine. This operation can take a while to complete.")
  start is ArmResourceActionAsync<DevTestLabVm, {}, {}>;
  @doc("Stop a virtual machine This operation can take a while to complete.")
  stop is ArmResourceActionAsync<DevTestLabVm, {}, {}>;
  @doc("Transfers all data disks attached to the virtual machine to be owned by the current user. This operation can take a while to complete.")
  transferDisks is ArmResourceActionAsync<DevTestLabVm, {}, {}>;
  @doc("Release ownership of an existing virtual machine This operation can take a while to complete.")
  unClaim is ArmResourceActionAsync<DevTestLabVm, {}, {}>;
}
