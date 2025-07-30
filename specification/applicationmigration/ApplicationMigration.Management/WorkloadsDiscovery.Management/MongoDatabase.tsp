import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MongoInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApplicationMigration;
/**
 * The MongoDatabase resource definition.
 */
@parentResource(MongoSite)
model MongoDatabase
  is Azure.ResourceManager.ProxyResource<MongoDatabaseProperties, false> {
  ...ResourceNameParameter<
    Resource = MongoDatabase,
    KeyName = "databaseName",
    SegmentName = "MongoDatabases",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface MongoDatabases {
  /**
   * Gets the MongoDatabases resource.
   */
  get is ArmResourceRead<MongoDatabase>;

  /**
   * Puts the MongoDatabases resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MongoDatabase>;

  /**
   * Patch the MongoDatabases resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MongoDatabase,
    MongoDatabaseResourcePatchProperties
  >;

  /**
   * Deletes the MongoDatabases resource.
   */
  delete is ArmResourceDeleteSync<MongoDatabase>;

  /**
   * Lists the MongoDatabases resource in MongoSites.
   */
  listBySite is ArmResourceListByParent<
    MongoDatabase,
    Response = ArmResponse<MongoDatabaseList>
  >;
}

@@maxLength(MongoDatabase.name, 63);
@@minLength(MongoDatabase.name, 3);
@@doc(MongoDatabase.name, "The name of Database");
@@doc(MongoDatabase.properties, "Resource properties.");
@@doc(MongoDatabases.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(MongoDatabases.update::parameters.properties, "Clouds patch payload.");
