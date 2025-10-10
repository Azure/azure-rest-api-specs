import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.Compute;
/**
 * Describes a Virtual Machine diagnostic run command.
 */
@added(Versions.v2025_04_01)
@parentResource(VirtualMachine)
model VirtualMachineDiagnosticRunCommand
  is Azure.ResourceManager.TrackedResource<VirtualMachineRunCommandProperties> {
  ...ResourceNameParameter<
    Resource = VirtualMachineRunCommand,
    KeyName = "runCommandName",
    SegmentName = "diagnosticRunCommands",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VirtualMachineDiagnosticRunCommandOps
  extends Azure.ResourceManager.Legacy.ComputeLegacyOperations<
      VirtualMachinePath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineDiagnosticRunCommand,
          SegmentName = "diagnosticRunCommands",
          KeyName = "runCommandName",
          NamePattern = ""
        >,
      }>
    > {}

@armResourceOperations
interface VirtualMachineDiagnosticRunCommands {
  /**
   * The operation to get the diagnostic run command.
   */
  @added(Versions.v2025_04_01)
  getByVirtualMachine is VirtualMachineDiagnosticRunCommandOps.Read<
    VirtualMachineDiagnosticRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to create or update the diagnostic run command.
   */
  @added(Versions.v2025_04_01)
  createOrUpdate is VirtualMachineDiagnosticRunCommandOps.CreateOrUpdateAsync<
    VirtualMachineDiagnosticRunCommand,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update the diagnostic run command.
   */
  @added(Versions.v2025_04_01)
  @patch(#{ implicitOptionality: false })
  update is VirtualMachineDiagnosticRunCommandOps.CustomPatchAsync<
    VirtualMachineDiagnosticRunCommand,
    VirtualMachineRunCommandUpdate,
    Response = ArmResponse<VirtualMachineDiagnosticRunCommand> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete the diagnostic run command.
   */
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  @added(Versions.v2025_04_01)
  delete is VirtualMachineDiagnosticRunCommandOps.DeleteAsync<VirtualMachineDiagnosticRunCommand>;

  /**
   * The operation to get all diagnostic run commands of a Virtual Machine.
   */
  @list
  @added(Versions.v2025_04_01)
  diagnosticListByVirtualMachine is VirtualMachineDiagnosticRunCommandOps.List<
    VirtualMachineDiagnosticRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = VirtualMachineDiagnosticRunCommandsListResult
  >;
}

@armResourceOperations
interface VirtualMachineScaleSetVMDiagnosticRunCommandOps
  extends Azure.ResourceManager.Legacy.ComputeLegacyOperations<
      VirtualMachineScaleSetVMPath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineDiagnosticRunCommand,
          SegmentName = "diagnosticRunCommands",
          KeyName = "runCommandName",
          NamePattern = ""
        >,
      }>
    > {}

@armResourceOperations
interface VirtualMachineScaleSetVMDiagnosticRunCommands {
  /**
   * The operation to get the VMSS VM diagnostic run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @added(Versions.v2025_04_01)
  @operationId("VirtualMachineScaleSetVMDiagnosticRunCommands_Get")
  get is VirtualMachineScaleSetVMDiagnosticRunCommandOps.Read<
    VirtualMachineDiagnosticRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * The operation to create or update the VMSS VM diagnostic run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @added(Versions.v2025_04_01)
  @operationId("VirtualMachineScaleSetVMDiagnosticRunCommands_CreateOrUpdate")
  createOrUpdate is VirtualMachineScaleSetVMDiagnosticRunCommandOps.CreateOrUpdateAsync<
    VirtualMachineDiagnosticRunCommand,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to update the VMSS VM diagnostic run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@typespec/http/patch-implicit-optional" "non-standard operations"
  @added(Versions.v2025_04_01)
  @operationId("VirtualMachineScaleSetVMDiagnosticRunCommands_Update")
  update is VirtualMachineScaleSetVMDiagnosticRunCommandOps.CustomPatchAsync<
    VirtualMachineDiagnosticRunCommand,
    VirtualMachineRunCommandUpdate,
    Response = ArmResponse<VirtualMachineDiagnosticRunCommand> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * The operation to delete the VMSS VM diagnostic run command.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  @added(Versions.v2025_04_01)
  @operationId("VirtualMachineScaleSetVMDiagnosticRunCommands_Delete")
  delete is VirtualMachineScaleSetVMDiagnosticRunCommandOps.DeleteAsync<VirtualMachineDiagnosticRunCommand>;

  /**
   * The operation to get all diagnostic run commands of an instance in Virtual Machine Scaleset.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @added(Versions.v2025_04_01)
  @operationId("VirtualMachineScaleSetVMDiagnosticRunCommands_List")
  @list
  diagnosticList is VirtualMachineScaleSetVMDiagnosticRunCommandOps.List<
    VirtualMachineDiagnosticRunCommand,
    Parameters = {
      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = VirtualMachineDiagnosticRunCommandsListResult
  >;
}

@@clientName(VirtualMachineDiagnosticRunCommands.createOrUpdate::parameters.body,
  "runCommand"
);

@@clientName(VirtualMachineDiagnosticRunCommands.update::parameters.body,
  "runCommand"
);

@@clientName(VirtualMachineScaleSetVMDiagnosticRunCommands.createOrUpdate::parameters.body,
  "runCommand"
);

@@clientName(VirtualMachineScaleSetVMDiagnosticRunCommands.update::parameters.body,
  "runCommand"
);

@@doc(VirtualMachineDiagnosticRunCommand.name,
  "The name of the virtual machine diagnostic run command."
);
@@doc(VirtualMachineDiagnosticRunCommand.properties,
  "Describes the properties of a Virtual Machine diagnostic run command."
);
@@doc(VirtualMachineDiagnosticRunCommands.createOrUpdate::parameters.body,
  "Parameters supplied to the Create Virtual Machine Diagnostic RunCommand operation."
);
@@doc(VirtualMachineDiagnosticRunCommands.update::parameters.body,
  "Parameters supplied to the Update Virtual Machine Diagnostic RunCommand operation."
);
@@doc(VirtualMachineScaleSetVMDiagnosticRunCommands.createOrUpdate::parameters.body,
  "Parameters supplied to the Create Virtual Machine Diagnostic RunCommand operation."
);
