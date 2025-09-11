import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The StorageSite resource definition.
 */
model StorageSite
  is Azure.ResourceManager.TrackedResource<StorageSiteProperties, false> {
  ...ResourceNameParameter<
    Resource = StorageSite,
    KeyName = "siteName",
    SegmentName = "StorageSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface StorageSites {
  /**
   * Gets the StorageSites resource.
   */
  get is ArmResourceRead<StorageSite>;

  /**
   * Puts the StorageSites resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageSite>;

  // /**
  //  * Patch the StorageSites resource.
  //  */
  // @parameterVisibility
  // update is ArmResourcePatchAsync<StorageSite, StorageSiteProperties>;

  /**
   * Patch the StorageSites resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<StorageSite, SiteTagsPatch>;

  /**
   * Deletes the StorageSites resource.
   */
  delete is ArmResourceDeleteSync<StorageSite>;

  /**
   * Lists the StorageSites resource in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    StorageSite,
    Response = ArmResponse<StorageSiteList>
  >;

  /**
   * Lists the StorageSites resource in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    StorageSite,
    Response = ArmResponse<StorageSiteList>
  >;
}

@@maxLength(StorageSite.name, 63);
@@minLength(StorageSite.name, 3);
@@doc(StorageSite.name, "The name of Site");
@@doc(StorageSite.properties, "Resource properties.");
@@doc(StorageSites.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
// @@doc(StorageSites.update::parameters.properties, "Clouds patch payload.");
