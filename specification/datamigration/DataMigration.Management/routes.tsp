import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./migrationService.tsp";
import "./databaseMigration.tsp";

using Azure.ResourceManager;

namespace Microsoft.DataMigration;

@armResourceOperations
interface MigrationServices {
  @doc("Gets a migration service.")
  get is ArmResourceRead<MigrationService>;

  @doc("Creates or updates a migration service.")
  create is ArmResourceCreateOrReplaceSync<MigrationService>;

  @doc("Updates a migration service.")
  update is ArmResourcePatchSync<MigrationService, MigrationServiceProperties>;

  @doc("Deletes a migration service.")
  delete is ArmResourceDeleteSync<MigrationService>;

  @doc("Lists migration services by resource group.")
  listByResourceGroup is ArmResourceListByParent<MigrationService>;

  @doc("Tests connectivity to source and target databases.")
  testConnectivity is ArmResourceActionAsync<
    MigrationService,
    TestConnectivityRequest,
    TestConnectivityResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Discovers database objects (databases and schemas) from source and target.")
  discoverDatabaseObjects is ArmResourceActionAsync<
    MigrationService,
    DiscoverDatabaseObjectsRequest,
    DiscoverDatabaseObjectsResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
}

@armResourceOperations
interface DatabaseMigrations {
  @doc("Gets a database migration.")
  get is ArmResourceRead<DatabaseMigration>;

  @doc("Creates or updates a database migration.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseMigration>;

  @doc("Updates a database migration. Supports cancel and cutover operations.")
  update is ArmResourcePatchSync<
    DatabaseMigration,
    DatabaseMigrationUpdateProperties
  >;

  @doc("Deletes a database migration.")
  delete is ArmResourceDeleteAsync<DatabaseMigration>;

  @doc("Lists database migrations by migration service.")
  listByMigrationService is ArmResourceListByParent<DatabaseMigration>;
}
