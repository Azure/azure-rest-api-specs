import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DBforPostgreSQL;
/**
 * Represents a migration resource.
 */
model MigrationResource
  is Azure.ResourceManager.TrackedResource<MigrationResourceProperties> {
  ...ResourceNameParameter<
    Resource = MigrationResource,
    KeyName = "migrationName",
    SegmentName = "migrations",
    NamePattern = "^[a-z][a-z0-9]*$"
  >;
}

@armResourceOperations
interface MigrationResources {
  /**
   * Gets details of a migration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migrations_Get")
  get is ArmResourceRead<MigrationResource>;

  /**
   * Creates a new migration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migrations_Create")
  create is ArmResourceCreateOrReplaceSync<MigrationResource>;

  /**
   * Updates an existing migration. The request body can contain one to many of the mutable properties present in the migration definition. Certain property updates initiate migration state transitions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("Migrations_Update")
  update is ArmCustomPatchSync<
    MigrationResource,
    PatchModel = MigrationResourceForPatch
  >;

  /**
   * Deletes a migration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migrations_Delete")
  delete is ArmResourceDeleteSync<MigrationResource>;

  /**
   * List all the migrations on a given target server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Migrations_ListByTargetServer")
  listByTargetServer is ArmResourceListByParent<
    MigrationResource,
    Parameters = {
      /**
       * Migration list filter. Retrieves either active migrations or all migrations.
       */
      @query("migrationListFilter")
      migrationListFilter?: MigrationListFilter;
    }
  >;
}

@@doc(MigrationResource.name, "The name of the migration.");
@@doc(MigrationResource.properties, "Migration resource properties.");
@@doc(MigrationResources.create::parameters.resource,
  "The required parameters for creating a migration."
);
@@doc(MigrationResources.update::parameters.properties,
  "The required parameters for updating a migration."
);
