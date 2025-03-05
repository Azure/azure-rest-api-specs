import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PgsqlInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridInventory;
/**
 * The PGSQLDatabase resource definition.
 */
@parentResource(PgsqlSite)
model PgsqlDatabase
  is Azure.ResourceManager.ProxyResource<PgsqlDatabaseProperties, false> {
  ...ResourceNameParameter<
    Resource = PgsqlDatabase,
    KeyName = "databaseName",
    SegmentName = "PGSQLDatabases",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface PgsqlDatabases {
  /**
   * Gets the PGSQLDatabases resource.
   */
  get is ArmResourceRead<PgsqlDatabase>;

  /**
   * Puts the PGSQLDatabases resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<PgsqlDatabase>;

  /**
   * Patch the PGSQLDatabases resource.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PgsqlDatabase,
    PgsqlDatabaseResourcePatchProperties
  >;
  // @patch(#{ implicitOptionality: false })
  // update is ArmCustomPatchAsync<
  //   PgsqlDatabase,
  //   PatchModel = PgsqlDatabaseResourcePatch
  // >;

  /**
   * Deletes the PGSQLDatabases resource.
   */
  delete is ArmResourceDeleteSync<PgsqlDatabase>;

  /**
   * Lists the PGSQLInstances resource in PGSQLSites.
   */
  listBySite is ArmResourceListByParent<
    PgsqlDatabase,
    Response = ArmResponse<PgsqlDatabaseList>
  >;
}

@@maxLength(PgsqlDatabase.name, 63);
@@minLength(PgsqlDatabase.name, 3);
@@doc(PgsqlDatabase.name, "The name of Database");
@@doc(PgsqlDatabase.properties, "Resource properties.");
@@doc(PgsqlDatabases.createOrUpdate::parameters.resource,
  "The machines to add to the assessment"
);
@@doc(PgsqlDatabases.update::parameters.properties, "Clouds patch payload.");
