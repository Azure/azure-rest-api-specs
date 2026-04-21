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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity: ImageTemplateIdentity;
}

@armResourceOperations(#{ omitTags: true })
interface ImageTemplates {
  /**
   * Get information about a virtual machine image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_Get")
  @tag("VirtualMachineImageTemplate")
  get is ArmResourceRead<ImageTemplate>;

  /**
   * Create or update a virtual machine image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_CreateOrUpdate")
  @tag("VirtualMachineImageTemplate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ImageTemplate>;

  /**
   * Update the tags for this Virtual Machine Image Template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_Update")
  @patch(#{ implicitOptionality: false })
  @tag("VirtualMachineImageTemplate")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    ImageTemplate,
    PatchModel = ImageTemplateUpdateParameters,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ImageTemplate> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a virtual machine image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_Delete")
  @tag("VirtualMachineImageTemplate")
  delete is ArmResourceDeleteWithoutOkAsync<ImageTemplate>;

  /**
   * Gets information about the VM image templates associated with the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_ListByResourceGroup")
  @tag("VirtualMachineImageTemplate")
  listByResourceGroup is ArmResourceListByParent<ImageTemplate>;

  /**
   * Gets information about the VM image templates associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_List")
  @tag("VirtualMachineImageTemplate")
  list is ArmListBySubscription<ImageTemplate>;

  /**
   * Create artifacts from a existing image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_Run")
  @tag("VirtualMachineImageTemplate")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  run is ArmResourceActionAsync<
    ImageTemplate,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Cancel the long running image build based on the image template
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("VirtualMachineImageTemplates_Cancel")
  @tag("VirtualMachineImageTemplate")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  cancel is ArmResourceActionAsync<
    ImageTemplate,
    void,
    OkResponse | NoContentResponse,
    LroHeaders = ArmCombinedLroHeaders & Azure.Core.Foundations.RetryAfterHeader
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
