import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the Shared Gallery Subscription that hosts shared galleries shared at subscription level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(SharedGallerySubscription)
model SharedGalleryInvite
  is ProxyResourceShared<SharedGalleryInviteProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = SharedGallerySubscription,
    KeyName = "sharedGalleryName",
    SegmentName = "sharedGalleries",
    NamePattern = ""
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
  gallerySharingAccept is ComputeResourceActionAsyncBase<
    SharedGalleryInvite,
    void,
    ArmResponse<SharedGalleryInvite> | (ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader<FinalResult = SharedGalleryInvite> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot _: SharedGalleryInvite;
    })
  >;

  /**
   * Reject sharing of a subscription-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("reject")
  @operationId("GallerySharing_Reject")
  gallerySharingReject is ComputeResourceActionAsyncBase<
    SharedGalleryInvite,
    void,
    ArmResponse<SharedGalleryInvite> | (ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader<FinalResult = SharedGalleryInvite> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot _: SharedGalleryInvite;
    })
  >;
}
