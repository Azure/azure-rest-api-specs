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

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Get properties of the provided virtual machine.
   */
  @summary("Retrieve the virtual machine.")
  get is ArmResourceRead<VirtualMachine>;

  /**
   * Create a new virtual machine or update the properties of the existing virtual machine.
   */
  @summary("Create or update the virtual machine.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VirtualMachine,
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
   * Patch the properties of the provided virtual machine, or update the tags associated with the virtual machine. Properties and tag updates can be done independently.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @summary("Patch the virtual machine.")
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchAsync<
    VirtualMachine,
    PatchModel = VirtualMachinePatchParameters,
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
    Response = ArmResponse<VirtualMachine> | (ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = VirtualMachine> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: VirtualMachine;
    }),
    OptionalRequestBody = true
  >;

  /**
   * Delete the provided virtual machine.
   */
  @summary("Delete the virtual machine.")
  delete is ArmResourceDeleteWithoutOkAsync<
    VirtualMachine,
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
   * Get a list of virtual machines in the provided resource group.
   */
  @summary("List virtual machines in the resource group.")
  listByResourceGroup is ArmResourceListByParent<
    VirtualMachine,
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
    Response = ArmResponse<VirtualMachineList>
  >;

  /**
   * Get a list of virtual machines in the provided subscription.
   */
  @summary("List virtual machines in the subscription.")
  listBySubscription is ArmListBySubscription<
    VirtualMachine,
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
    Response = ArmResponse<VirtualMachineList>
  >;

  /**
   * Assigns a relay to the specified Microsoft.HybridCompute machine associated with the provided virtual machine.
   */
  @summary("Assigns a relay to the specified Microsoft.HybridCompute machine.")
  assignRelay is ArmResourceActionAsyncBase<
    VirtualMachine,
    VirtualMachineAssignRelayParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Power off the provided virtual machine.
   */
  @summary("Power off the virtual machine.")
  powerOff is ArmResourceActionAsyncBase<
    VirtualMachine,
    VirtualMachinePowerOffParameters,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualMachine>,
    OptionalRequestBody = true
  >;

  /**
   * Reimage the provided virtual machine.
   */
  @summary("Reimage the virtual machine.")
  reimage is ArmResourceActionAsyncBase<
    VirtualMachine,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualMachine>
  >;

  /**
   * Restart the provided virtual machine.
   */
  @summary("Restart the virtual machine.")
  restart is ArmResourceActionAsyncBase<
    VirtualMachine,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualMachine>
  >;

  /**
   * Start the provided virtual machine.
   */
  @summary("Start the virtual machine.")
  start is ArmResourceActionAsyncBase<
    VirtualMachine,
    void,
    ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<VirtualMachine>
  >;
}

@@doc(VirtualMachine.name, "The name of the virtual machine.");
@@doc(VirtualMachine.properties, "The list of the resource properties.");
@@doc(VirtualMachines.createOrUpdate::parameters.resource, "The request body.");
@@doc(VirtualMachines.update::parameters.properties, "The request body.");
@@doc(VirtualMachines.assignRelay::parameters.body, "The request body.");
@@doc(VirtualMachines.powerOff::parameters.body, "The request body.");
