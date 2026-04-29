import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Cluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
/**
 * Class representing a Kusto sandbox custom image.
 */
@parentResource(Cluster)
model SandboxCustomImage
  is Azure.ResourceManager.ProxyResource<SandboxCustomImageProperties> {
  ...ResourceNameParameter<
    Resource = SandboxCustomImage,
    KeyName = "sandboxCustomImageName",
    SegmentName = "sandboxCustomImages",
    NamePattern = "^.*$"
  >;
}

@armResourceOperations
interface SandboxCustomImages {
  /**
   * Returns a sandbox custom image
   */
  get is ArmResourceRead<SandboxCustomImage>;

  /**
   * Creates or updates a sandbox custom image.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SandboxCustomImage,
    LroHeaders = ArmLroLocationHeader<FinalResult = SandboxCustomImage> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a sandbox custom image.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SandboxCustomImage,
    PatchModel = SandboxCustomImage,
    Response = ArmResponse<SandboxCustomImage> | ArmResourceCreatedResponse<SandboxCustomImage> | (ArmAcceptedLroResponse<
      "Update accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = SandboxCustomImage> &
        ArmAsyncOperationHeader<FinalResult = SandboxCustomImage> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot
      _: SandboxCustomImage;
    })
  >;

  /**
   * Deletes a sandbox custom image.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    SandboxCustomImage,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of the existing sandbox custom images of the given Kusto cluster.
   */
  listByCluster is ArmResourceListByParent<
    SandboxCustomImage,
    Response = ArmResponse<SandboxCustomImagesListResult>
  >;
}

@@doc(SandboxCustomImage.name, "The name of the sandbox custom image.");
@@doc(SandboxCustomImage.properties, "A sandbox custom image.");
@@doc(SandboxCustomImages.createOrUpdate::parameters.resource,
  "The sandbox custom image parameters."
);
@@doc(SandboxCustomImages.update::parameters.properties,
  "The sandbox custom image parameters."
);
