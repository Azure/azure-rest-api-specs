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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a sandbox custom image.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    SandboxCustomImage,
    PatchModel = SandboxCustomImage,
    Response = ArmResponse<SandboxCustomImage> | ArmResourceCreatedResponse<SandboxCustomImage> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: SandboxCustomImage;
    })
  >;

  /**
   * Deletes a sandbox custom image.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    SandboxCustomImage,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns the list of the existing sandbox custom images of the given Kusto cluster.
   */
  listByCluster is ArmResourceListByParent<SandboxCustomImage>;
}

@@doc(SandboxCustomImage.name, "The name of the sandbox custom image.");
@@doc(SandboxCustomImage.properties, "A sandbox custom image.");
@@doc(SandboxCustomImages.createOrUpdate::parameters.resource,
  "The sandbox custom image parameters."
);
@@doc(SandboxCustomImages.update::parameters.properties,
  "The sandbox custom image parameters."
);
