import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./VirtualMachineScaleSetVM.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Compute;

/**
 * Describes a gallery application installed on a virtual machine scale set VM.
 */
@added(Versions.v2026_04_01)
@parentResource(VirtualMachineScaleSetVM)
model VirtualMachineScaleSetVMGalleryApplication
  is Azure.ResourceManager.ProxyResource<VMGalleryApplication> {
  ...ResourceNameParameter<
    Resource = VirtualMachineScaleSetVMGalleryApplication,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = ""
  >;
}

/**
 * The list of gallery applications installed on a virtual machine scale set VM.
 */
@added(Versions.v2026_04_01)
model VirtualMachineScaleSetVMGalleryApplicationListResult
  is Azure.Core.Page<VirtualMachineScaleSetVMGalleryApplication>;

@@doc(
  VirtualMachineScaleSetVMGalleryApplicationListResult.value,
  "The list of gallery applications installed on the virtual machine scale set VM."
);
@@doc(
  VirtualMachineScaleSetVMGalleryApplicationListResult.nextLink,
  "The URI to fetch the next page of gallery applications."
);

alias VirtualMachineScaleSetVMGalleryApplicationPath = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;
  ...Azure.ResourceManager.Legacy.Provider;
  ...KeysOf<ResourceNameParameter<
    VirtualMachineScaleSet,
    SegmentName = "virtualMachineScaleSets",
    KeyName = "vmScaleSetName",
    NamePattern = ""
  >>;
  ...KeysOf<ResourceNameParameter<
    VirtualMachineScaleSetVM,
    SegmentName = "virtualMachines",
    KeyName = "instanceId",
    NamePattern = ""
  >>;
};

@armResourceOperations
interface VirtualMachineScaleSetVMGalleryApplicationOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      VirtualMachineScaleSetVMGalleryApplicationPath,
      KeysOf<{
        ...ResourceNameParameter<
          VirtualMachineScaleSetVMGalleryApplication,
          SegmentName = "applications",
          KeyName = "applicationName",
          NamePattern = ""
        >,
      }>,
      CloudError
    > {}

@armResourceOperations
interface VirtualMachineScaleSetVMGalleryApplications {
  /**
   * Gets a gallery application installed on a virtual machine scale set VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @added(Versions.v2026_04_01)
  @operationId("VirtualMachineScaleSetVMGalleryApplications_Get")
  get is VirtualMachineScaleSetVMGalleryApplicationOps.Read<
    VirtualMachineScaleSetVMGalleryApplication,
    Parameters = {
      /**
       * The expand expression to apply to the operation. The supported value is 'instanceView'.
       */
      @query("$expand")
      $expand?: "instanceView";
    }
  >;

  /**
   * Lists gallery applications installed on a virtual machine scale set VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @added(Versions.v2026_04_01)
  @operationId("VirtualMachineScaleSetVMGalleryApplications_List")
  @list
  list is VirtualMachineScaleSetVMGalleryApplicationOps.List<
    VirtualMachineScaleSetVMGalleryApplication,
    Response = VirtualMachineScaleSetVMGalleryApplicationListResult
  >;

  /**
   * Gets a gallery application and its instance view from a virtual machine scale set VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "The controller exposes instanceView as a GET action."
  @added(Versions.v2026_04_01)
  @get
  @action("instanceView")
  @operationId("VirtualMachineScaleSetVMGalleryApplications_GetInstanceView")
  getInstanceView is ComputeResourceActionSync<
    VirtualMachineScaleSetVMGalleryApplication,
    void,
    VirtualMachineScaleSetVMGalleryApplication
  >;
}

@@doc(
  VirtualMachineScaleSetVMGalleryApplication.name,
  "The name of the gallery application."
);
@@doc(
  VirtualMachineScaleSetVMGalleryApplication.properties,
  "The gallery application properties."
);