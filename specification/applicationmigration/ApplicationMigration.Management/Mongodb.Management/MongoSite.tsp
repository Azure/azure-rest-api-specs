import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The MongoSite resource definition.
 */
model MongoSite
  is Azure.ResourceManager.TrackedResource<MongoSiteProperties, false> {
  ...ResourceNameParameter<
    Resource = MongoSite,
    KeyName = "siteName",
    SegmentName = "mongoSites",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface MongoSites {
  /**
   * Gets the MongoSites resource.
   */
  get is ArmResourceRead<MongoSite>;

  /**
   * Puts the MongoSites resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MongoSite>;

  /**
   * Patch the MongoSites resource.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.ClientGenerator.Core.convenientAPI(false, "!javascript, !csharp")
  update is ArmCustomPatchAsync<MongoSite, SiteTagsPatch>;

  /**
   * Deletes the MongoSites resource.
   */
  delete is ArmResourceDeleteSync<MongoSite>;

  /**
   * Lists the MongoSites resource in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    MongoSite,
    Response = ArmResponse<MongoSiteList>
  >;

  /**
   * Lists the MongoSites resource in a subscription.
   */
  listBySubscription is ArmListBySubscription<
    MongoSite,
    Response = ArmResponse<MongoSiteList>
  >;

  /**
   * Trigger Refresh action
   */
  //#suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" ""
  @action("refresh")
  triggerRefresh is ArmResourceActionNoResponseContentAsync<MongoSite, void>;
}

@@maxLength(MongoSite.name, 63);
@@minLength(MongoSite.name, 3);
@@doc(MongoSite.name, "The name of Site");
@@doc(MongoSite.properties, "Resource properties.");
@@doc(MongoSites.createOrUpdate::parameters.resource,
  "The request body for creating or updating a MongoSite resource."
);
