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
using Common;

namespace Compute;
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
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;
  ...KeysOf<ResourceNameParameter<
    VirtualMachine,
    SegmentName = "virtualMachines",
    KeyName = "vmName",
    NamePattern = ""
  >>;
};

@armResourceOperations
interface VirtualMachineRunCommandOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      VirtualMachinePath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineRunCommand,
          SegmentName = "runCommands",
          KeyName = "runCommandName",
          NamePattern = ""
        >,
      }>,
      CloudError
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
    LroHeaders = ArmLroLocationHeader<FinalResult = VirtualMachineRunCommand> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update the run command.
   */
  @patch(#{ implicitOptionality: false })
  update is VirtualMachineRunCommandOps.CustomPatchAsync<
    VirtualMachineRunCommand,
    VirtualMachineRunCommandUpdate,
    Response = ArmResponse<VirtualMachineRunCommand> &
      ArmLroLocationHeader<FinalResult = VirtualMachineRunCommand> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete the run command.
   */
  delete is VirtualMachineRunCommandOps.DeleteWithoutOkAsync<
    VirtualMachineRunCommand,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * The operation to get all run commands of a Virtual Machine.
   */
  @list
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
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;
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
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      VirtualMachineScaleSetVMPath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineRunCommand,
          SegmentName = "runCommands",
          KeyName = "runCommandName",
          NamePattern = ""
        >,
      }>,
      CloudError
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
    LroHeaders = ArmLroLocationHeader<FinalResult = VirtualMachineRunCommand> &
      Azure.Core.Foundations.RetryAfterHeader
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
      ArmLroLocationHeader<FinalResult = VirtualMachineRunCommand> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete the VMSS VM run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  @operationId("VirtualMachineScaleSetVMRunCommands_Delete")
  delete is VirtualMachineScaleSetVMRunCommandOps.DeleteWithoutOkAsync<
    VirtualMachineRunCommand,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * The operation to get all run commands of an instance in Virtual Machine Scaleset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineScaleSetVMRunCommands_List")
  @list
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

@@doc(
  VirtualMachineRunCommand.name,
  "The name of the virtual machine run command."
);
@@doc(
  VirtualMachineRunCommand.properties,
  "Describes the properties of a Virtual Machine run command."
);
@@doc(
  VirtualMachineRunCommands.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Virtual Machine RunCommand operation."
);
@@doc(
  VirtualMachineRunCommands.update::parameters.properties,
  "Parameters supplied to the Update Virtual Machine RunCommand operation."
);
@@doc(
  VirtualMachineScaleSetVMRunCommands.createOrUpdate::parameters.resource,
  "Parameters supplied to the Create Virtual Machine RunCommand operation."
);
