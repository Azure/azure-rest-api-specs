import "./MongoDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The MongoCollection resource definition.
 */
@parentResource(MongoSite)
model MongoCollection
  is Azure.ResourceManager.ProxyResource<MongoCollectionProperties, false> {
  ...ResourceNameParameter<
    Resource = MongoCollection,
    KeyName = "collectionName",
    SegmentName = "mongoCollections",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

/**
 * Properties of the MongoCollection resource.
 */
@armResourceOperations
interface MongoCollections {
  /**
   * Gets the MongoCollection resource.
   */
  get is ArmResourceRead<MongoCollection>;

  /**
   * Puts the MongoCollection resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MongoCollection>;

  /**
   * Patch the MongoCollection resource.
   */
  @patch(#{ implicitOptionality: false })
  @Azure.ClientGenerator.Core.convenientAPI(false, "!javascript, !csharp")
  update is ArmCustomPatchSync<MongoCollection, MongoCollectionResourcePatch>;

  /**
   * Deletes the MongoCollection resource.
   */
  delete is ArmResourceDeleteSync<MongoCollection>;

  /**
   * Lists the MongoCollection resources in MongoSite.
   */
  listBySite is ArmResourceListByParent<
    MongoCollection,
    Response = ArmResponse<MongoCollectionList>
  >;
}

@@maxLength(MongoCollection.name, 63);
@@minLength(MongoCollection.name, 3);
@@doc(MongoCollection.name, "The name of Collection");
@@doc(MongoCollection.properties, "Resource properties.");
@@doc(MongoCollections.createOrUpdate::parameters.resource,
  "The request body for creating or updating a MongoCollection resource."
);
@@doc(MongoCollections.update::parameters.properties,
  "The request body for updating a MongoCollection resource."
);
