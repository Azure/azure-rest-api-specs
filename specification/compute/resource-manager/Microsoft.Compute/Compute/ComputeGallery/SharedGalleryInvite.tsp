import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Common;

namespace ComputeGallery;
/**
 * Specifies information about the Shared Gallery Subscription that hosts shared galleries shared at subscription level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(SharedGallerySubscription)
@added(Versions.v2025_12_03)
model SharedGalleryInvite
  is ProxyResourceShared<SharedGalleryInviteProperties> {
  ...ResourceNameParameter<
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("accept")
  @added(Versions.v2025_12_03)
  gallerySharingAccept is ComputeResourceActionAsyncBase<
    SharedGalleryInvite,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
      >
    | (ArmNoContentResponse<"Action completed successfully."> & {})
  >;

  /**
   * Reject sharing of a subscription-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("reject")
  @added(Versions.v2025_12_03)
  gallerySharingReject is ComputeResourceActionAsyncBase<
    SharedGalleryInvite,
    void,
    | ArmAcceptedLroResponse<
        "Resource operation accepted.",
        ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
      >
    | (ArmNoContentResponse<"Action completed successfully."> & {})
  >;
}
