import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Lab.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
@doc("A virtual machine.")
@parentResource(Lab)
model LabVirtualMachine is TrackedResource<LabVirtualMachineProperties> {
  @doc("The name of the virtual machine.")
  @path
  @key("name")
  @segment("virtualmachines")
  name: string;
}

@armResourceOperations
interface LabVirtualMachines {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get virtual machine.")
  @operationId("VirtualMachines_Get")
  get is ArmResourceRead<
    LabVirtualMachine,
    {
      ...BaseParameters<LabVirtualMachine>;

      @doc("Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or replace an existing virtual machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LabVirtualMachine>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Allows modifying tags of virtual machines. All other properties will be ignored.")
  @operationId("VirtualMachines_Update")
  update is ArmCustomPatchSync<LabVirtualMachine, LabVirtualMachineFragment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete virtual machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_Delete")
  delete is ArmResourceDeleteAsync<LabVirtualMachine>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List virtual machines in a given lab.")
  @operationId("VirtualMachines_List")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Attach a new or existing data disk to virtual machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_AddDataDisk")
  addDataDisk is ArmResourceActionAsync<
    LabVirtualMachine,
    DataDiskProperties,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Apply artifacts to virtual machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_ApplyArtifacts")
  applyArtifacts is ArmResourceActionAsync<
    LabVirtualMachine,
    ApplyArtifactsRequest,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Take ownership of an existing virtual machine This operation can take a while to complete.")
  @operationId("VirtualMachines_Claim")
  claim is ArmResourceActionAsync<LabVirtualMachine, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Detach the specified disk from the virtual machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_DetachDataDisk")
  detachDataDisk is ArmResourceActionAsync<
    LabVirtualMachine,
    DetachDataDiskProperties,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a string that represents the contents of the RDP file for the virtual machine")
  @operationId("VirtualMachines_GetRdpFileContents")
  getRdpFileContents is ArmResourceActionSync<
    LabVirtualMachine,
    void,
    RdpConnection
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists the applicable start/stop schedules, if any.")
  @operationId("VirtualMachines_ListApplicableSchedules")
  listApplicableSchedules is ArmResourceActionSync<
    LabVirtualMachine,
    void,
    ApplicableSchedule
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Redeploy a virtual machine This operation can take a while to complete.")
  @operationId("VirtualMachines_Redeploy")
  redeploy is ArmResourceActionAsync<LabVirtualMachine, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Resize Virtual Machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_Resize")
  resize is ArmResourceActionAsync<
    LabVirtualMachine,
    ResizeLabVirtualMachineProperties,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Restart a virtual machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_Restart")
  restart is ArmResourceActionAsync<LabVirtualMachine, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Start a virtual machine. This operation can take a while to complete.")
  @operationId("VirtualMachines_Start")
  start is ArmResourceActionAsync<LabVirtualMachine, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stop a virtual machine This operation can take a while to complete.")
  @operationId("VirtualMachines_Stop")
  stop is ArmResourceActionAsync<LabVirtualMachine, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Transfers all data disks attached to the virtual machine to be owned by the current user. This operation can take a while to complete.")
  @operationId("VirtualMachines_TransferDisks")
  transferDisks is ArmResourceActionAsync<LabVirtualMachine, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Release ownership of an existing virtual machine This operation can take a while to complete.")
  @operationId("VirtualMachines_UnClaim")
  unClaim is ArmResourceActionAsync<LabVirtualMachine, void, void>;
}

@@projectedName(LabVirtualMachines.createOrUpdate::parameters.resource,
  "json",
  "labVirtualMachine"
);
@@extension(LabVirtualMachines.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "labVirtualMachine"
);
@@doc(LabVirtualMachines.createOrUpdate::parameters.resource,
  "A virtual machine."
);
@@projectedName(LabVirtualMachines.update::parameters.properties,
  "json",
  "labVirtualMachine"
);
@@extension(LabVirtualMachines.update::parameters.properties,
  "x-ms-client-name",
  "labVirtualMachine"
);
@@doc(LabVirtualMachines.update::parameters.properties, "A virtual machine.");
@@projectedName(LabVirtualMachines.addDataDisk::parameters.body,
  "json",
  "dataDiskProperties"
);
@@extension(LabVirtualMachines.addDataDisk::parameters.body,
  "x-ms-client-name",
  "dataDiskProperties"
);
@@doc(LabVirtualMachines.addDataDisk::parameters.body,
  "Request body for adding a new or existing data disk to a virtual machine."
);
@@projectedName(LabVirtualMachines.applyArtifacts::parameters.body,
  "json",
  "applyArtifactsRequest"
);
@@extension(LabVirtualMachines.applyArtifacts::parameters.body,
  "x-ms-client-name",
  "applyArtifactsRequest"
);
@@doc(LabVirtualMachines.applyArtifacts::parameters.body,
  "Request body for applying artifacts to a virtual machine."
);
@@projectedName(LabVirtualMachines.detachDataDisk::parameters.body,
  "json",
  "detachDataDiskProperties"
);
@@extension(LabVirtualMachines.detachDataDisk::parameters.body,
  "x-ms-client-name",
  "detachDataDiskProperties"
);
@@doc(LabVirtualMachines.detachDataDisk::parameters.body,
  "Request body for detaching data disk from a virtual machine."
);
@@projectedName(LabVirtualMachines.resize::parameters.body,
  "json",
  "resizeLabVirtualMachineProperties"
);
@@extension(LabVirtualMachines.resize::parameters.body,
  "x-ms-client-name",
  "resizeLabVirtualMachineProperties"
);
@@doc(LabVirtualMachines.resize::parameters.body,
  "Request body for resizing a virtual machine."
);
