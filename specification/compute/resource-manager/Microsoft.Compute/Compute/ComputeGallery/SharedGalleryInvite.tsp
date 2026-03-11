import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.Compute;
/**
 * Specifies information about the Shared Gallery Subscription that hosts shared galleries shared at subscription level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(SharedGallerySubscription)
@added(Versions.v2025_12_03)
model SharedGalleryInvite
  is ProxyResourceShared<SharedGalleryInviteProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGallerySubscription,
    KeyName = "sharedGalleryName",
    SegmentName = "sharedGalleries",
    NamePattern = "^[^_\\W][\\w-._]{0,79}(?<![-.])$"
  >;
}

@armResourceOperations
interface SharedGalleryInvites {
  /**
   * Accept sharing of a subscription-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("accept")
  @operationId("GallerySharing_Accept")
  @added(Versions.v2025_12_03)
  gallerySharingAccept is ComputeResourceActionAsyncBase<
    SharedGalleryInvite,
    void,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmNoContentResponse<"Action completed successfully."> & {})
  >;

  /**
   * Reject sharing of a subscription-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("reject")
  @operationId("GallerySharing_Reject")
  @added(Versions.v2025_12_03)
  gallerySharingReject is ComputeResourceActionAsyncBase<
    SharedGalleryInvite,
    void,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmNoContentResponse<"Action completed successfully."> & {})
  >;
}
