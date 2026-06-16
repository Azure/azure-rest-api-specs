import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A virtual machine.
 */
@parentResource(Lab)
model LabVirtualMachine
  is Azure.ResourceManager.ProxyResource<LabVirtualMachineProperties, false> {
  ...ResourceNameParameter<
    Resource = LabVirtualMachine,
    KeyName = "virtualMachineName",
    SegmentName = "virtualmachines",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface VirtualMachines {
  /**
   * Get virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<
    LabVirtualMachine,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    LabVirtualMachine,
    LroHeaders = ArmLroLocationHeader<FinalResult = LabVirtualMachine> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of virtual machines. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "Already contains tags"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    LabVirtualMachine,
    PatchModel = LabVirtualMachineFragment
  >;

  /**
   * Delete virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    LabVirtualMachine,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List virtual machines in a given lab.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  list is ArmResourceListByParent<
    LabVirtualMachine,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($expand=artifacts,computeVm,networkInterface,applicableSchedule)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<LabVirtualMachineList>
  >;

  /**
   * Attach a new or existing data disk to virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  addDataDisk is ArmResourceActionAsync<
    LabVirtualMachine,
    DataDiskProperties,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Apply artifacts to virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  applyArtifacts is ArmResourceActionAsync<
    LabVirtualMachine,
    ApplyArtifactsRequest,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Take ownership of an existing virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  claim is ArmResourceActionAsync<
    LabVirtualMachine,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Detach the specified disk from the virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  detachDataDisk is ArmResourceActionAsync<
    LabVirtualMachine,
    DetachDataDiskProperties,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Gets a string that represents the contents of the RDP file for the virtual machine
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  getRdpFileContents is ArmResourceActionSync<
    LabVirtualMachine,
    void,
    ArmResponse<RdpConnection>
  >;

  /**
   * Lists the applicable start/stop schedules, if any.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listApplicableSchedules is ArmResourceActionSync<
    LabVirtualMachine,
    void,
    ArmResponse<ApplicableSchedule>
  >;

  /**
   * Redeploy a virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  redeploy is ArmResourceActionAsync<
    LabVirtualMachine,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Resize Virtual Machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  resize is ArmResourceActionAsync<
    LabVirtualMachine,
    ResizeLabVirtualMachineProperties,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Restart a virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  restart is ArmResourceActionAsync<
    LabVirtualMachine,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Start a virtual machine. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  start is ArmResourceActionAsync<
    LabVirtualMachine,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Stop a virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  stop is ArmResourceActionAsync<
    LabVirtualMachine,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Transfers all data disks attached to the virtual machine to be owned by the current user. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  transferDisks is ArmResourceActionAsync<
    LabVirtualMachine,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Release ownership of an existing virtual machine This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  unClaim is ArmResourceActionAsync<
    LabVirtualMachine,
    void,
    {
      @body body: void;
    },
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;
}

@@doc(LabVirtualMachine.name, "The name of the virtual machine.");
@@doc(LabVirtualMachine.properties, "The properties of the resource.");
@@doc(VirtualMachines.createOrUpdate::parameters.resource,
  "A virtual machine."
);
@@doc(VirtualMachines.update::parameters.properties, "A virtual machine.");
@@doc(VirtualMachines.addDataDisk::parameters.body,
  "Request body for adding a new or existing data disk to a virtual machine."
);
@@doc(VirtualMachines.applyArtifacts::parameters.body,
  "Request body for applying artifacts to a virtual machine."
);
@@doc(VirtualMachines.detachDataDisk::parameters.body,
  "Request body for detaching data disk from a virtual machine."
);
@@doc(VirtualMachines.resize::parameters.body,
  "Request body for resizing a virtual machine."
);
