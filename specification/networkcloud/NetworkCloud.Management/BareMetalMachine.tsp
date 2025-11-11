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
  get is ArmResourceRead<BareMetalMachine>;

  /**
   * Create a new bare metal machine or update the properties of the existing one. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    BareMetalMachine,
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

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    }
  >;

  /**
   * Patch properties of the provided bare metal machine, or update tags associated with the bare metal machine. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    BareMetalMachine,
    PatchModel = BareMetalMachinePatchParameters,
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

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<BareMetalMachine> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = BareMetalMachine> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BareMetalMachine;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided bare metal machine. All customer initiated requests will be rejected as the life cycle of this resource is managed by the system.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    BareMetalMachine,
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

      /**
       * Set to True to enable UserRPs to call into their extension endpoints using their services First Party Application.
       */
      @header
      `X-Ms-Userrp-Extension-Callback-Enabled`?: boolean;
    },
    Response = ArmResponse<OperationStatusResult> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get a list of bare metal machines in the provided resource group.
   */
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
  cordon is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineCordonParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Power off the provided bare metal machine.
   */
  powerOff is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachinePowerOffParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Reimage the provided bare metal machine.
   */
  reimage is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Replace the provided bare metal machine.
   */
  replace is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineReplaceParameters,
    ArmResponse<OperationStatusResult>,
    OptionalRequestBody = true
  >;

  /**
   * Restart the provided bare metal machine.
   */
  restart is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Run the command or the script on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runCommand is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineRunCommandParameters,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Run one or more data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runDataExtracts is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Run one or more restricted data extractions on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runDataExtractsRestricted is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineRunDataExtractsParameters,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Run one or more read-only commands on the provided bare metal machine. The URL to storage account with the command execution results and the command exit code can be retrieved from the operation status API once available.
   */
  runReadCommands is ArmResourceActionAsync<
    BareMetalMachine,
    BareMetalMachineRunReadCommandsParameters,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Start the provided bare metal machine.
   */
  start is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    ArmResponse<OperationStatusResult>
  >;

  /**
   * Uncordon the provided bare metal machine's Kubernetes node.
   */
  uncordon is ArmResourceActionAsync<
    BareMetalMachine,
    void,
    ArmResponse<OperationStatusResult>
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
