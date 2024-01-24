import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Site resource. Must be created in the same location as its parent mobile network.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MobileNetwork)
@Azure.ResourceManager.Private.armResourceInternal(SitePropertiesFormat)
@includeInapplicableMetadataInPayload(false)
model Site extends TrackedResourceBase {
  /**
   * The name of the mobile network site.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("siteName")
  @segment("sites")
  name: string;

  /**
   * Site properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SitePropertiesFormat;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters<Site>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates site tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<Site, TagsObject>;

  /**
   * Deletes the specified mobile network site. This will also delete any network functions that are a part of this site.
   */
  delete is ArmResourceDeleteAsync<
    Site,
    BaseParameters<Site>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all sites in the mobile network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Sites_ListByMobileNetwork")
  listByMobileNetwork is ArmResourceListByParent<Site>;

  /**
   * Deletes a packet core under the specified mobile network site.
   */
  deletePacketCore is ArmResourceActionAsync<
    Site,
    SiteDeletePacketCore,
    void,
    BaseParameters<Site>,
    ArmLroLocationHeader
  >;
}

@@projectedName(Sites.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Sites.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sites.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update mobile network site operation."
);
@@projectedName(Sites.updateTags::parameters.properties, "json", "parameters");
@@extension(Sites.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sites.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
@@projectedName(Sites.deletePacketCore::parameters.body, "json", "parameters");
@@extension(Sites.deletePacketCore::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sites.deletePacketCore::parameters.body,
  "Parameters supplied to delete a packet core under a site."
);
