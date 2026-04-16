import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.VirtualMachineImages;
/**
 * Image template is an ARM resource managed by Microsoft.VirtualMachineImages provider
 */
model ImageTemplate
  is Azure.ResourceManager.TrackedResource<ImageTemplateProperties> {
  ...ResourceNameParameter<
    Resource = ImageTemplate,
    KeyName = "imageTemplateName",
    SegmentName = "imageTemplates",
    NamePattern = "^[A-Za-z0-9-_.]{1,64}$"
  >;

  /**
   * The identity of the image template, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity: ImageTemplateIdentity;
}

@armResourceOperations
interface ImageTemplates {
  /**
   * Get information about a virtual machine image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_Get")
  get is ArmResourceRead<ImageTemplate>;

  /**
   * Create or update a virtual machine image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ImageTemplate>;

  /**
   * Update the tags for this Virtual Machine Image Template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ImageTemplate,
    PatchModel = ImageTemplateUpdateParameters,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ImageTemplate> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a virtual machine image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<ImageTemplate>;

  /**
   * Gets information about the VM image templates associated with the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<ImageTemplate>;

  /**
   * Gets information about the VM image templates associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_List")
  list is ArmListBySubscription<ImageTemplate>;

  /**
   * Create artifacts from a existing image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_Run")
  run is ArmResourceActionAsync<
    ImageTemplate,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Cancel the long running image build based on the image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("VirtualMachineImageTemplates_Cancel")
  cancel is ArmResourceActionAsync<
    ImageTemplate,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(ImageTemplate.name, "The name of the image Template");
@@doc(ImageTemplate.properties, "The properties of the image template");
@@doc(ImageTemplates.createOrUpdate::parameters.resource,
  "Parameters supplied to the CreateImageTemplate operation"
);
@@doc(ImageTemplates.update::parameters.properties,
  "Additional parameters for Image Template update."
);
