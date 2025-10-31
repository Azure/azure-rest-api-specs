import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Site resource.
 */
model Site is Azure.ResourceManager.TrackedResource<SitePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = Site,
    KeyName = "siteName",
    SegmentName = "sites",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface Sites {
  /**
   * Gets information about the specified network site.
   */
  get is ArmResourceRead<Site>;

  /**
   * Creates or updates a network site.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Updates a site update tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<Site, PatchModel = TagsObject>;

  /**
   * Deletes the specified network site.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Site,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets 'Deleting' provisioningState until the operation completes. Returns an operation URI that can be queried to find the current state of the operation.",
      LroHeaders = ArmLroLocationHeader
    > | ArmNoContentResponse<"Request successful. Resource does not exist.">,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Lists all sites in the network service.
   */
  listByResourceGroup is ArmResourceListByParent<Site>;

  /**
   * Lists all sites in the network service in a subscription.
   */
  listBySubscription is ArmListBySubscription<Site>;
}

@@maxLength(Site.name, 64);
@@doc(Site.name, "The name of the network service site.");
@@doc(Site.properties, "Site properties.");
@@doc(Sites.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network site operation."
);
@@doc(Sites.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
