import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./BareMetalMachine_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.NetworkCloud;
/**
 * The name of the bare metal machine.
 */
model BareMetalMachineNameParameter
  is ResourceNameParameter<
    Resource = BareMetalMachine,
    KeyName = "bareMetalMachineName",
    SegmentName = "bareMetalMachines",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$"
  >;

/**
 * BareMetalMachine represents the physical machine in the rack.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model BareMetalMachine
  is Azure.ResourceManager.TrackedResource<BareMetalMachineProperties, false> {
  ...BareMetalMachineNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
}

@armResourceOperations
interface BareMetalMachines {
  /**
   * Get properties of the provided bare metal machine.
   */
  get is ArmResourceRead<BareMetalMachine>;

  /**
   * Create a new bare metal machine or update the properties of the existing one. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BareMetalMachine,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BareMetalMachine>
  >;

  /**
   * Patch properties of the provided bare metal machine, or update tags associated with the bare metal machine. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BareMetalMachine,
    PatchModel = BareMetalMachinePatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = BareMetalMachine> &
      ArmLroLocationHeader<FinalResult = BareMetalMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided bare metal machine. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    BareMetalMachine,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of bare metal machines in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    BareMetalMachine,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<BareMetalMachineList>
  >;

  /**
   * Get a list of bare metal machines in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    BareMetalMachine,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<BareMetalMachineList>
  >;

  /**
   * Cordon the provided bare metal machine's Kubernetes node.
   */
  cordon is ActionAsync<
    BareMetalMachine,
    BareMetalMachineCordonParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Power off the provided bare metal machine.
   */
  powerOff is ActionAsync<
    BareMetalMachine,
    BareMetalMachinePowerOffParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  // Note: added optional body with 2026-05-01-preview to support safeguard mode parameter.
  /**
   * Reimage the provided bare metal machine.
   */
  @renamedFrom(Versions.v2026_05_01_preview, "reimage")
  @removed(Versions.v2026_05_01_preview)
  @sharedRoute
  reimageOld is ActionAsync<BareMetalMachine, void, OperationStatusResult>;

  /**
   * Reimage the provided bare metal machine.
   */
  @added(Versions.v2026_05_01_preview)
  @sharedRoute
  reimage is ActionAsync<
    BareMetalMachine,
    BareMetalMachineReimageParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Replace the provided bare metal machine.
   */
  replace is ActionAsync<
    BareMetalMachine,
    BareMetalMachineReplaceParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Restart the provided bare metal machine.
   */
  restart is ActionAsync<BareMetalMachine, void, OperationStatusResult>;

  /**
   * Run the command or the script on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runCommand is ActionAsync<
    BareMetalMachine,
    BareMetalMachineRunCommandParameters,
    OperationStatusResult
  >;

  /**
   * Run one or more data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runDataExtracts is ActionAsync<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    OperationStatusResult
  >;

  /**
   * Run one or more restricted data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runDataExtractsRestricted is ActionAsync<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    OperationStatusResult
  >;

  /**
   * Run one or more read-only commands on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runReadCommands is ActionAsync<
    BareMetalMachine,
    BareMetalMachineRunReadCommandsParameters,
    OperationStatusResult
  >;

  /**
   * Start the provided bare metal machine.
   */
  start is ActionAsync<BareMetalMachine, void, OperationStatusResult>;

  /**
   * Uncordon the provided bare metal machine's Kubernetes node.
   */
  uncordon is ActionAsync<BareMetalMachine, void, OperationStatusResult>;
}

@@doc(BareMetalMachine.name, "The name of the bare metal machine.");
@@doc(BareMetalMachine.properties, "The list of the resource properties.");
@@doc(BareMetalMachines.createOrUpdate::parameters.resource,
  "The request body."
);
@@doc(BareMetalMachines.update::parameters.properties, "The request body.");
@@doc(BareMetalMachines.cordon::parameters.body, "The request body.");
@@doc(BareMetalMachines.powerOff::parameters.body, "The request body.");
@@doc(BareMetalMachines.replace::parameters.body, "The request body.");
@@doc(BareMetalMachines.runCommand::parameters.body, "The request body.");
@@doc(BareMetalMachines.runDataExtracts::parameters.body, "The request body.");
@@doc(BareMetalMachines.runDataExtractsRestricted::parameters.body,
  "The request body."
);
@@doc(BareMetalMachines.runReadCommands::parameters.body, "The request body.");
