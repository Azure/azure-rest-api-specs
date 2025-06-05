import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Describes a Virtual Machine run command.
 */
@parentResource(VirtualMachine)
model VirtualMachineRunCommand
  is Azure.ResourceManager.TrackedResource<VirtualMachineRunCommandProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachineRunCommand,
    KeyName = "runCommandName",
    SegmentName = "runCommands",
    NamePattern = ""
  >;
}

alias VirtualMachinePath = {
  ...Azure.ResourceManager.Legacy.BasePath;
  ...KeysOf<ResourceNameParameter<
    VirtualMachine,
    SegmentName = "virtualMachines",
    KeyName = "vmName",
    NamePattern = ""
  >>;
};

@armResourceOperations
interface VirtualMachineRunCommandOps
  extends Azure.ResourceManager.Legacy.ComputeLegacyOperations<
      VirtualMachinePath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineRunCommand,
          SegmentName = "runCommands",
          KeyName = "runCommandName",
          NamePattern = ""
        >,
      }>
    > {}

@armResourceOperations
interface VirtualMachineRunCommands {
  /**
   * The operation to get the run command.
   */
  getByVirtualMachine is VirtualMachineRunCommandOps.Read<
    VirtualMachineRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to create or update the run command.
   */
  createOrUpdate is VirtualMachineRunCommandOps.CreateOrUpdateAsync<
    VirtualMachineRunCommand,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update the run command.
   */
  @patch(#{ implicitOptionality: false })
  update is VirtualMachineRunCommandOps.CustomPatchAsync<
    VirtualMachineRunCommand,
    VirtualMachineRunCommandUpdate,
    Response = ArmResponse<VirtualMachineRunCommand> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete the run command.
   */
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  delete is VirtualMachineRunCommandOps.DeleteAsync<VirtualMachineRunCommand>;

  /**
   * The operation to get all run commands of a Virtual Machine.
   */
  listByVirtualMachine is VirtualMachineRunCommandOps.List<
    VirtualMachineRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = VirtualMachineRunCommandsListResult
  >;
}

alias VirtualMachineScaleSetVMPath = {
  ...Azure.ResourceManager.Legacy.BasePath;
  ...KeysOf<ResourceNameParameter<
    VirtualMachineScaleSet,
    SegmentName = "virtualMachineScaleSets",
    KeyName = "vmScaleSetName",
    NamePattern = ""
  >>;
  ...KeysOf<ResourceNameParameter<
    VirtualMachineScaleSetVM,
    SegmentName = "virtualMachines",
    KeyName = "instanceId",
    NamePattern = ""
  >>;
};

@armResourceOperations
interface VirtualMachineScaleSetVMRunCommandOps
  extends Azure.ResourceManager.Legacy.ComputeLegacyOperations<
      VirtualMachineScaleSetVMPath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineRunCommand,
          SegmentName = "runCommands",
          KeyName = "runCommandName",
          NamePattern = ""
        >,
      }>
    > {}

@armResourceOperations
interface VirtualMachineScaleSetVMRunCommands {
  /**
   * The operation to get the VMSS VM run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMRunCommands_Get")
  get is VirtualMachineScaleSetVMRunCommandOps.Read<
    VirtualMachineRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to create or update the VMSS VM run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMRunCommands_CreateOrUpdate")
  createOrUpdate is VirtualMachineScaleSetVMRunCommandOps.CreateOrUpdateAsync<
    VirtualMachineRunCommand,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update the VMSS VM run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@typespec/http/patch-implicit-optional" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMRunCommands_Update")
  update is VirtualMachineScaleSetVMRunCommandOps.CustomPatchAsync<
    VirtualMachineRunCommand,
    VirtualMachineRunCommandUpdate,
    Response = ArmResponse<VirtualMachineRunCommand> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete the VMSS VM run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  @operationId("VirtualMachineScaleSetVMRunCommands_Delete")
  delete is VirtualMachineScaleSetVMRunCommandOps.DeleteAsync<VirtualMachineRunCommand>;

  /**
   * The operation to get all run commands of an instance in Virtual Machine Scaleset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMRunCommands_List")
  list is VirtualMachineScaleSetVMRunCommandOps.List<
    VirtualMachineRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = VirtualMachineRunCommandsListResult
  >;
}

@@doc(VirtualMachineRunCommand.name,
  "The name of the virtual machine run command."
);
@@doc(VirtualMachineRunCommand.properties,
  "Describes the properties of a Virtual Machine run command."
);
@@doc(VirtualMachineRunCommands.createOrUpdate::parameters.body,
  "Parameters supplied to the Create Virtual Machine RunCommand operation."
);
@@doc(VirtualMachineRunCommands.update::parameters.body,
  "Parameters supplied to the Update Virtual Machine RunCommand operation."
);
@@doc(VirtualMachineScaleSetVMRunCommands.createOrUpdate::parameters.body,
  "Parameters supplied to the Create Virtual Machine RunCommand operation."
);
