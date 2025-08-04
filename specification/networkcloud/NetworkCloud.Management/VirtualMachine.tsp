import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetworkCloud;
/**
 * VirtualMachine represents the on-premises Network Cloud virtual machine.
 */
model VirtualMachine
  is Azure.ResourceManager.TrackedResource<VirtualMachineProperties, false> {
  ...ResourceNameParameter<
    Resource = VirtualMachine,
    KeyName = "virtualMachineName",
    SegmentName = "virtualMachines",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;
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
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;
    }
  >;

  /**
   * Patch the properties of the provided virtual machine, or update the tags associated with the virtual machine. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    VirtualMachine,
    PatchModel = VirtualMachinePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<VirtualMachine> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = VirtualMachine> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: VirtualMachine;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided virtual machine.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachine,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      @header
      `If-None-Match`?: string;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of virtual machines in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    VirtualMachine,
    Response = ArmResponse<VirtualMachineList>
  >;

  /**
   * Get a list of virtual machines in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    VirtualMachine,
    Response = ArmResponse<VirtualMachineList>
  >;

  /**
   * Power off the provided virtual machine.
   */
  powerOff is ArmResourceActionAsync<
    VirtualMachine,
    VirtualMachinePowerOffParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Reimage the provided virtual machine.
   */
  reimage is ArmResourceActionAsync<
    VirtualMachine,
    void,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Restart the provided virtual machine.
   */
  restart is ArmResourceActionAsync<
    VirtualMachine,
    void,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Start the provided virtual machine.
   */
  start is ArmResourceActionAsync<
    VirtualMachine,
    void,
    ArmResponse<OperationStatusResult>
  >;
}

@@doc(VirtualMachine.name, "The name of the virtual machine.");
@@encodedName(VirtualMachine.eTag, "application/json", "etag");
@@doc(VirtualMachine.properties, "The list of the resource properties.");
@@doc(VirtualMachines.createOrUpdate::parameters.resource, "The request body.");
@@doc(VirtualMachines.update::parameters.properties, "The request body.");
@@doc(VirtualMachines.powerOff::parameters.body, "The request body.");
