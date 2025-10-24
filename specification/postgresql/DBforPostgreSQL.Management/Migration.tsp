import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Properties of a migration.
 */
@parentResource(Server)
model Migration is Azure.ResourceManager.TrackedResource<MigrationProperties> {
  ...ResourceNameParameter<
    Resource = Migration,
    KeyName = "migrationName",
    SegmentName = "migrations",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface Migrations {
  /**
   * Gets information about a migration.
   */
  get is ArmResourceRead<Migration>;

  /**
   * Creates a new migration.
   */
  create is ArmResourceCreateOrReplaceSync<Migration>;

  /**
   * Updates an existing migration. The request body can contain one to many of the mutable properties present in the migration definition. Certain property updates initiate migration state transitions.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Migration,
    PatchModel = MigrationResourceForPatch
  >;

  /**
   * Cancels an active migration.
   */
  cancel is ArmResourceDeleteSync<
    Migration,
    Response = ArmResponse<Migration> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all migrations of a target flexible server.
   */
  listByTargetServer is ArmResourceListByParent<
    Migration,
    Parameters = {
      /**
       * Migration list filter. Indicates if the request should retrieve only active migrations or all migrations. Defaults to Active.
       */
      @query("migrationListFilter")
      migrationListFilter?: MigrationListFilter;
    },
    Response = ArmResponse<MigrationList>
  >;
}

@@doc(Migration.name, "Name of migration.");
@@doc(Migration.properties, "Migration properties.");
@@doc(Migrations.create::parameters.resource,
  "Parameters required for creating a migration."
);
@@doc(Migrations.update::parameters.properties,
  "Parameters required to update an existing migration."
);
