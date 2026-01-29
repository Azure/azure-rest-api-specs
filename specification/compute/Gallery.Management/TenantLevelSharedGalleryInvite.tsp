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
 * Specifies information about the Invite for a Shared Gallery shared at tenant level.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
@subscriptionResource
@parentResource(TenantLevelSharedGallerySubscription)
@added(Versions.v2025_12_03)
model TenantLevelSharedGalleryInvite
  is ProxyResourceShared<SharedGalleryInviteProperties> {
  ...Azure.ResourceManager.Legacy.ResourceNameParameter<
    Resource = TenantLevelSharedGallerySubscription,
    KeyName = "sharedGalleryName",
    SegmentName = "sharedGalleries",
    NamePattern = "^[^_\\W][\\w-._]{0,79}(?<![-.])$"
  >;
}

@armResourceOperations
interface TenantLevelSharedGalleryInvites {
  /**
   * Accept sharing of a tenant-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("accept")
  @operationId("TenantLevelGallerySharing_Accept")
  @added(Versions.v2025_12_03)
  tenantLevelGallerySharingAccept is ComputeResourceActionAsyncBase<
    TenantLevelSharedGalleryInvite,
    void,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmNoContentResponse<"Action completed successfully."> & {})
  >;

  /**
   * Reject sharing of a tenant-level shared gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("reject")
  @operationId("TenantLevelGallerySharing_Reject")
  @added(Versions.v2025_12_03)
  tenantLevelGallerySharingReject is ComputeResourceActionAsyncBase<
    TenantLevelSharedGalleryInvite,
    void,
    ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmNoContentResponse<"Action completed successfully."> & {})
  >;
}
