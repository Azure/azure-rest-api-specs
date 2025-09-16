import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Site resource. Must be created in the same location as its parent mobile network.
 */
@parentResource(MobileNetwork)
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
   * Gets information about the specified mobile network site.
   */
  get is ArmResourceRead<Site>;

  /**
   * Creates or updates a mobile network site. Must be created in the same location as its parent mobile network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;

  /**
   * Updates site tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<Site, PatchModel = TagsObject>;

  /**
   * Deletes the specified mobile network site. This will also delete any network functions that are a part of this site.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Site,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all sites in the mobile network.
   */
  listByMobileNetwork is ArmResourceListByParent<Site>;

  /**
   * Deletes a packet core under the specified mobile network site.
   */
  deletePacketCore is ArmResourceActionAsync<
    Site,
    SiteDeletePacketCore,
    OkResponse
  >;
}

@@maxLength(Site.name, 64);
@@doc(Site.name, "The name of the mobile network site.");
@@doc(Site.properties, "Site properties.");
@@doc(Sites.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update mobile network site operation."
);
@@doc(Sites.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
@@doc(Sites.deletePacketCore::parameters.body,
  "Parameters supplied to delete a packet core under a site."
);
