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
 * Specifies information about the Invite for a Shared Gallery shared at tenant level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(TenantLevelSharedGallerySubscription)
model TenantLevelSharedGalleryInvite
  is ProxyResourceShared<SharedGalleryInviteProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = TenantLevelSharedGallerySubscription,
    KeyName = "sharedGalleryName",
    SegmentName = "sharedGalleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface TenantLevelSharedGalleryInvites {
  /**
   * Accept sharing of a subscription-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("accept")
  @operationId("TenantLevelGallerySharing_Accept")
  tenantLevelGallerySharingAccept is ComputeResourceActionAsyncBase<
    TenantLevelSharedGalleryInvite,
    void,
    ArmResponse<SharedGalleryInviteProperties> | (ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader<FinalResult = SharedGalleryInviteProperties> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot _: SharedGalleryInviteProperties;
    })
  >;

  /**
   * Reject sharing of a subscription-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("reject")
  @operationId("TenantLevelGallerySharing_Reject")
  tenantLevelGallerySharingReject is ComputeResourceActionAsyncBase<
    TenantLevelSharedGalleryInvite,
    void,
    ArmResponse<SharedGalleryInviteProperties> | (ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader<FinalResult = SharedGalleryInviteProperties> &
        Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot _: SharedGalleryInviteProperties;
    })
  >;
}
