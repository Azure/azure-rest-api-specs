import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualMachine.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Compute;

/**
 * Describes a gallery application installed on a virtual machine.
 */
@parentResource(VirtualMachine)
model VirtualMachineVMGalleryApplication
  is Azure.ResourceManager.ProxyResource<VMGalleryApplication> {
  ...ResourceNameParameter<
    Resource = VirtualMachineVMGalleryApplication,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;
}

/**
 * Describes an update to a gallery application installed on a virtual machine.
 */
model VirtualMachineVMGalleryApplicationUpdate {
  /**
   * The gallery application properties. This can be omitted for a tags-only update.
   */
  properties?: VMGalleryApplication;
}

/**
 * The list of gallery applications installed on a virtual machine scale set VM.
 */
model VirtualMachineVMGalleryApplicationListResult
  is Azure.Core.Page<VirtualMachineVMGalleryApplication>;

@@doc(
  VirtualMachineVMGalleryApplicationListResult.value,
  "The list of gallery applications installed on the virtual machine scale set VM."
);
@@doc(
  VirtualMachineVMGalleryApplicationListResult.nextLink,
  "The URI to fetch the next page of gallery applications."
);

alias VirtualMachineVMGalleryApplicationPath = {
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
interface VirtualMachineVMGalleryApplicationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      VirtualMachineVMGalleryApplicationPath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineVMGalleryApplication,
          SegmentName = "applications",
          KeyName = "applicationName",
          NamePattern = ""
        >,
      }>,
      CloudError
    > {}

@armResourceOperations
interface VirtualMachineVMGalleryApplications {
  /**
    * Gets a gallery application installed on a virtual machine.
   */
  get is VirtualMachineVMGalleryApplicationOps.Read<
    VirtualMachineVMGalleryApplication,
    Parameters = {
      /**
       * The expand expression to apply to the operation. The supported value is 'instanceView'.
       */
      @query("$expand")
      $expand?: "instanceView";
    }
  >;

  /**
   * Creates or updates a gallery application on a virtual machine.
   */
  createOrUpdate is VirtualMachineVMGalleryApplicationOps.CreateOrUpdateAsync<
    VirtualMachineVMGalleryApplication,
    LroHeaders = ArmLroLocationHeader<FinalResult = VirtualMachineVMGalleryApplication> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a gallery application on a virtual machine. A request containing only tags is completed synchronously.
   */
  @patch(#{ implicitOptionality: false })
  update is VirtualMachineVMGalleryApplicationOps.CustomPatchAsync<
    VirtualMachineVMGalleryApplication,
    VirtualMachineVMGalleryApplicationUpdate,
    Response = ArmResponse<VirtualMachineVMGalleryApplication> &
      ArmLroLocationHeader<FinalResult = VirtualMachineVMGalleryApplication> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes a gallery application from a virtual machine.
   */
  delete is VirtualMachineVMGalleryApplicationOps.DeleteWithoutOkAsync<
    VirtualMachineVMGalleryApplication,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Lists gallery applications installed on a virtual machine.
   */
  @list
  list is VirtualMachineVMGalleryApplicationOps.List<
    VirtualMachineVMGalleryApplication,
    Response = VirtualMachineVMGalleryApplicationListResult
  >;

  /**
    * Gets a gallery application and its instance view from a virtual machine.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "The controller exposes instanceView as a GET action."
  @added(Versions.v2026_04_01)
  @get
  @action("instanceView")
  @operationId("VirtualMachineVMGalleryApplications_GetInstanceView")
  getInstanceView is ComputeResourceActionSync<
    VirtualMachineVMGalleryApplication,
    void,
    VirtualMachineVMGalleryApplication
  >;
}

@@doc(
  VirtualMachineVMGalleryApplication.name,
  "The name of the gallery application."
);
@@doc(
  VirtualMachineVMGalleryApplication.properties,
  "The gallery application properties."
);
@@doc(
  VirtualMachineVMGalleryApplications.createOrUpdate::parameters.resource,
  "The gallery application to create or update."
);
@@doc(
  VirtualMachineVMGalleryApplications.update::parameters.properties,
  "The gallery application update."
);