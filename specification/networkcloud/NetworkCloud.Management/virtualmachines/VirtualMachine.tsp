import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./VirtualMachine_models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.NetworkCloud;
/**
 * The name of the virtual machine.
 */
model VirtualMachineNameParameter
  is ResourceNameParameter<
    Resource = VirtualMachine,
    KeyName = "virtualMachineName",
    SegmentName = "virtualMachines",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$"
  >;

/**
 * VirtualMachine represents the on-premises Network Cloud virtual machine.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "legacy resource using legacy features"
model VirtualMachine
  is Azure.ResourceManager.TrackedResource<VirtualMachineProperties, false> {
  ...VirtualMachineNameParameter;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
  ...RequiredExtendedLocationProperty;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Get properties of the provided virtual machine.
   */
  get is ArmResourceRead<VirtualMachine>;

  /**
   * Create a new virtual machine or update the properties of the existing virtual machine.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachine,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = VirtualMachine>
  >;

  /**
   * Patch the properties of the provided virtual machine, or update the tags associated with the virtual machine. Properties and tag updates can be done independently.
   */
  @patch(#{ implicitOptionality: false })
  /* Note: It is preferred to use Azure.ResourceManager.ArmCustomPatchAsync, for existing resources the patch body is (nonsensically) "optional", and this is the only way to achieve it. */
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    VirtualMachine,
    PatchModel = VirtualMachinePatchParameters,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    LroHeaders = ArmAsyncOperationHeader<FinalResult = VirtualMachine> &
      ArmLroLocationHeader<FinalResult = VirtualMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided virtual machine.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachine,
    Parameters = {
      ...IfMatchParameter;
      ...IfNoneMatchParameter;
    },
    Response = ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatusResult>> | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of virtual machines in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualMachine,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<VirtualMachineList>
  >;

  /**
   * Get a list of virtual machines in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    VirtualMachine,
    Parameters = {
      ...TopParameter;
      ...SkipTokenParameter;
    },
    Response = ArmResponse<VirtualMachineList>
  >;

  /**
   * Assigns a relay to the specified Microsoft.HybridCompute machine associated with the provided virtual machine.
   */
  assignRelay is ActionAsync<
    VirtualMachine,
    VirtualMachineAssignRelayParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Power off the provided virtual machine.
   */
  powerOff is ActionAsync<
    VirtualMachine,
    VirtualMachinePowerOffParameters,
    OperationStatusResult,
    OptionalRequestBody = true
  >;

  /**
   * Reimage the provided virtual machine.
   */
  reimage is ActionAsync<VirtualMachine, void, OperationStatusResult>;

  /**
   * Restart the provided virtual machine.
   */
  restart is ActionAsync<VirtualMachine, void, OperationStatusResult>;

  /**
   * Start the provided virtual machine.
   */
  start is ActionAsync<VirtualMachine, void, OperationStatusResult>;
}

@@doc(VirtualMachine.name, "The name of the virtual machine.");
@@doc(VirtualMachine.properties, "The list of the resource properties.");
@@doc(VirtualMachines.createOrUpdate::parameters.resource, "The request body.");
@@doc(VirtualMachines.update::parameters.properties, "The request body.");
@@doc(VirtualMachines.assignRelay::parameters.body, "The request body.");
@@doc(VirtualMachines.powerOff::parameters.body, "The request body.");
