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
 * Site network service resource.
 */
model SiteNetworkService
  is Azure.ResourceManager.TrackedResource<SiteNetworkServicePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = SiteNetworkService,
    KeyName = "siteNetworkServiceName",
    SegmentName = "siteNetworkServices",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;

  /**
   * Sku of the site network service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  sku?: Sku;
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
    LroHeaders = ArmAsyncOperationHeader
  >;

  /**
   * Updates a site update tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<SiteNetworkService, PatchModel = TagsObject>;

  /**
   * Deletes the specified site network service.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    SiteNetworkService,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets 'Deleting' provisioningState until the operation completes. Returns an operation URI that can be queried to find the current state of the operation.",
      LroHeaders = ArmLroLocationHeader
    > | ArmNoContentResponse<"Request successful. Resource does not exist.">,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Lists all site network services.
   */
  listByResourceGroup is ArmResourceListByParent<SiteNetworkService>;

  /**
   * Lists all sites in the network service in a subscription.
   */
  listBySubscription is ArmListBySubscription<SiteNetworkService>;
}

@@maxLength(SiteNetworkService.name, 64);
@@doc(SiteNetworkService.name, "The name of the site network service.");
@@doc(SiteNetworkService.properties, "Site network service properties.");
@@doc(SiteNetworkServices.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update site network service operation."
);
@@doc(SiteNetworkServices.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
@@doc(SiteNetworkService.identity,
  "The managed identity of the Site network service, if configured."
);
