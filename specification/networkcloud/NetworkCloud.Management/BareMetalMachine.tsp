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

  /**
   * Resource ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * The extended location of the cluster associated with the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface BareMetalMachines {
  /**
   * Get properties of the provided bare metal machine.
   */
  @summary("Retrieve the bare metal machine.")
  get is ArmResourceRead<BareMetalMachine>;

  /**
   * Create a new bare metal machine or update the properties of the existing one. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  @summary("Create or update the bare metal machine.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BareMetalMachine,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Patch properties of the provided bare metal machine, or update tags associated with the bare metal machine. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @summary("Patch the bare metal machine.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BareMetalMachine,
    PatchModel = BareMetalMachinePatchParameters,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<BareMetalMachine> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = BareMetalMachine> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BareMetalMachine;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided bare metal machine. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  @summary("Delete the bare metal machine.")
  delete is ArmResourceDeleteWithoutOkAsync<
    BareMetalMachine,
    Parameters = {
      /**
       * The ETag of the transformation. Omit this value to always overwrite the current resource. Specify the last-seen ETag value to prevent accidentally overwriting concurrent changes.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-Match`?: string;

      /**
       * Set to '*' to allow a new record set to be created, but to prevent updating an existing resource. Other values will result in error from server as they are not supported.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `If-None-Match`?: string;

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of bare metal machines in the provided resource group.
   */
  @summary("List bare metal machines in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    BareMetalMachine,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<BareMetalMachineList>
  >;

  /**
   * Get a list of bare metal machines in the provided subscription.
   */
  @summary("List bare metal machines in the subscription.")
  listBySubscription is ArmListBySubscription<
    BareMetalMachine,
    Parameters = {
      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'.
       */
      @query("$top")
      $top?: int32;

      /**
       * The opaque token that the server returns to indicate where to continue listing resources from. This is used for paging through large result sets.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<BareMetalMachineList>
  >;

  /**
   * Cordon the provided bare metal machine's Kubernetes node.
   */
  @summary("Cordon the bare metal machine.")
  cordon is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineCordonParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Power off the provided bare metal machine.
   */
  @summary("Power off the bare metal machine.")
  powerOff is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachinePowerOffParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Reimage the provided bare metal machine.
   */
  @summary("Reimage the bare metal machine.")
  reimage is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Replace the provided bare metal machine.
   */
  @summary("Replace (service) the bare metal machine.")
  replace is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineReplaceParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Restart the provided bare metal machine.
   */
  @summary("Restart the bare metal machine.")
  restart is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Run the command or the script on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  @summary("Run the command on the bare metal machine.")
  runCommand is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineRunCommandParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Run one or more data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  @summary("Run data extraction for a bare metal machine.")
  runDataExtracts is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Run one or more restricted data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  @summary("Run restricted data extraction for a bare metal machine.")
  runDataExtractsRestricted is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Run one or more read-only commands on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  @summary("Run read-only commands against a bare metal machine.")
  runReadCommands is ArmResourceActionAsyncBase<
    BareMetalMachine,
    BareMetalMachineRunReadCommandsParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Start the provided bare metal machine.
   */
  @summary("Start the bare metal machine.")
  start is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;

  /**
   * Uncordon the provided bare metal machine's Kubernetes node.
   */
  @summary("Uncordon the bare metal machine.")
  uncordon is ArmResourceActionAsyncBase<
    BareMetalMachine,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<BareMetalMachine>
  >;
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
