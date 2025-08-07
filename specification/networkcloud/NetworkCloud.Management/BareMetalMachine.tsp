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
 * BareMetalMachine represents the physical machine in the rack.
 */
model BareMetalMachine
  is Azure.ResourceManager.TrackedResource<BareMetalMachineProperties, false> {
  ...ResourceNameParameter<
    Resource = BareMetalMachine,
    KeyName = "bareMetalMachineName",
    SegmentName = "bareMetalMachines",
    NamePattern = "^([a-zA-Z0-9][a-zA-Z0-9]{0,62}[a-zA-Z0-9])$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface BareMetalMachines {
  /**
   * Get properties of the provided bare metal machine.
   */
  get is ArmResourceRead<BareMetalMachine>;

  /**
   * Create a new bare metal machine or update the properties of the existing one.
   * All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BareMetalMachine,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    }
  >;

  /**
   * Patch properties of the provided bare metal machine, or update tags associated with the bare metal machine. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BareMetalMachine,
    PatchModel = BareMetalMachinePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmResponse<BareMetalMachine> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = BareMetalMachine> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BareMetalMachine;

      /**
       * The URL to retrieve the status of the asynchronous operation.
       */
      @header("Location")
      location?: string;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided bare metal machine.
   * All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    BareMetalMachine,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-None-Match")
      `If-None-Match`?: string;
    },
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of bare metal machines in the provided resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    BareMetalMachine,
    Response = ArmResponse<BareMetalMachineList>
  >;

  /**
   * Get a list of bare metal machines in the provided subscription.
   */
  listBySubscription is ArmListBySubscription<
    BareMetalMachine,
    Response = ArmResponse<BareMetalMachineList>
  >;

  /**
   * Cordon the provided bare metal machine's Kubernetes node.
   */
  cordon is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineCordonParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Power off the provided bare metal machine.
   */
  powerOff is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachinePowerOffParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Reimage the provided bare metal machine.
   */
  reimage is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Replace the provided bare metal machine.
   */
  replace is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineReplaceParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Restart the provided bare metal machine.
   */
  restart is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Run the command or the script on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runCommand is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineRunCommandParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Run one or more data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runDataExtracts is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Run one or more read-only commands on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runReadCommands is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineRunReadCommandsParameters,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Start the provided bare metal machine.
   */
  start is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Uncordon the provided bare metal machine's Kubernetes node.
   */
  uncordon is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    Response = ArmAcceptedLroResponse,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;
}

@@doc(BareMetalMachine.name, "The name of the bare metal machine.");
@@encodedName(BareMetalMachine.eTag, "application/json", "etag");
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
@@doc(BareMetalMachines.runReadCommands::parameters.body, "The request body.");
