import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MongoDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The MongoCollection resource definition.
 */
@parentResource(MongoDatabase)
model MongoCollection
  is Azure.ResourceManager.ProxyResource<MongoCollectionProperties, false> {
  ...ResourceNameParameter<
    Resource = MongoCollection,
    KeyName = "collectionName",
    SegmentName = "MongoCollections",
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
  update is ArmCustomPatchSync<
    MongoCollection,
    MongoCollectionResourcePatchProperties
  >;

  /**
   * Deletes the MongoCollection resource.
   */
  delete is ArmResourceDeleteSync<MongoCollection>;

  /**
   * Lists the MongoCollection resources in MongoDatabase.
   */
  listByDatabase is ArmResourceListByParent<
    MongoCollection,
    Response = ArmResponse<MongoCollectionList>
  >;
}

@@maxLength(MongoCollection.name, 63);
@@minLength(MongoCollection.name, 3);
@@doc(MongoCollection.name, "The name of Collection");
@@doc(MongoCollection.properties, "Resource properties.");
@@doc(MongoCollections.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MongoCollections.update::parameters.properties, "Clouds patch payload.");
