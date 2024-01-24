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
 * Site network service resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  SiteNetworkServicePropertiesFormat
)
@includeInapplicableMetadataInPayload(false)
model SiteNetworkService extends TrackedResourceBase {
  /**
   * The name of the site network service.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("siteNetworkServiceName")
  @segment("siteNetworkServices")
  name: string;

  /**
   * Site network service properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SiteNetworkServicePropertiesFormat;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SiteNetworkServices {
  /**
   * Gets information about the specified site network service.
   */
  get is ArmResourceRead<SiteNetworkService>;

  /**
   * Creates or updates a network site.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SiteNetworkService,
    BaseParameters<SiteNetworkService>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates a site update tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<SiteNetworkService, TagsObject>;

  /**
   * Deletes the specified site network service.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    SiteNetworkService,
    BaseParameters<SiteNetworkService>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all site network services.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SiteNetworkServices_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<SiteNetworkService>;

  /**
   * Lists all sites in the network service in a subscription.
   */
  listBySubscription is ArmListBySubscription<SiteNetworkService>;
}

@@projectedName(SiteNetworkServices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SiteNetworkServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SiteNetworkServices.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update site network service operation."
);
@@projectedName(SiteNetworkServices.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(SiteNetworkServices.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SiteNetworkServices.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
