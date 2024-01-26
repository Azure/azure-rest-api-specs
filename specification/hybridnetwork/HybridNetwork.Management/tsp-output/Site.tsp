import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * Site resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SitePropertiesFormat)
model Site extends TrackedResourceBase {
  /**
   * The name of the network service site.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility("read")
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
   * Gets information about the specified network site.
   */
  get is ArmResourceRead<Site>;

  /**
   * Creates or updates a network site.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters<Site>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a site update tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<Site, TagsObject>;

  /**
   * Deletes the specified network site.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Site,
    BaseParameters<Site>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all sites in the network service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Sites_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Site>;

  /**
   * Lists all sites in the network service in a subscription.
   */
  listBySubscription is ArmListBySubscription<Site>;
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
  "Parameters supplied to the create or update network site operation."
);
@@projectedName(Sites.updateTags::parameters.properties, "json", "parameters");
@@extension(Sites.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Sites.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
