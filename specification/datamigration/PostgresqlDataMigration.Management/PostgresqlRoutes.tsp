import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./PostgresqlModels.tsp";
import "./PostgresqlMigrationService.tsp";
import "./PostgresqlDatabaseMigration.tsp";

using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataMigration;

@armResourceOperations
interface PostgresqlMigrationServices {
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

  @doc("Lists migration services by subscription.")
  listBySubscription is ArmListBySubscription<MigrationService>;

  @doc("Tests connectivity to source and target databases.")
  testConnectivity is ArmResourceActionAsync<
    MigrationService,
    TestConnectivityRequest,
    ConnectivityTestResult
  >;

  @doc("Discovers database objects (databases and schemas) from source and target.")
  discoverDatabaseObjects is ArmResourceActionAsync<
    MigrationService,
    DiscoverDatabaseObjectsRequest,
    DatabaseDiscoveryResult
  >;
}

@armResourceOperations
interface PostgresqlDatabaseMigrations {
  @doc("Gets a database migration.")
  get is ArmResourceRead<DatabaseMigration>;

  @doc("Creates or updates a database migration.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseMigration>;

  @doc("Updates a database migration. Supports cancel and cutover operations.")
  update is ArmResourcePatchSync<
    DatabaseMigration,
    DatabaseMigrationProperties
  >;

  @doc("Deletes a database migration.")
  delete is ArmResourceDeleteWithoutOkAsync<DatabaseMigration>;

  @doc("Lists database migrations by migration service.")
  listByMigrationService is ArmResourceListByParent<DatabaseMigration>;
}
