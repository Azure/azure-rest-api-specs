import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataMigration;
@doc("Database Migration Resource for SQL Database.")
model DatabaseMigrationSqlDB
  is ProxyResource<DatabaseMigrationSqlDBProperties> {
  @doc("The name of the target database.")
  @path
  @key("targetDbName")
  @segment("databaseMigrations")
  name: string;
}

@armResourceOperations
interface DatabaseMigrationSqlDBS {
  @doc("Retrieve the Database Migration resource.")
  get is ArmResourceRead<
    DatabaseMigrationSqlDB,
    {
      ...BaseParameters<DatabaseMigrationSqlDB>;

      @path
      sqlDbInstanceName: string;

      @doc("The name of the target database.")
      @path
      targetDbName: string;

      @doc("Optional migration operation ID. If this is provided, then details of migration operation for that ID are retrieved. If not provided (default), then details related to most recent or current operation are retrieved.")
      @query("migrationOperationId")
      migrationOperationId?: string;

      @doc("Complete migration details be included in the response.")
      @query("$expand")
      $expand?: string;
    }
  >;
  @doc("Create or Update Database Migration resource.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DatabaseMigrationSqlDB,
    {
      ...BaseParameters<DatabaseMigrationSqlDB>;

      @path
      sqlDbInstanceName: string;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;
  @doc("Delete Database Migration resource.")
  delete is ArmResourceDeleteAsync<
    DatabaseMigrationSqlDB,
    {
      ...BaseParameters<DatabaseMigrationSqlDB>;

      @path
      sqlDbInstanceName: string;

      @doc("The name of the target database.")
      @path
      targetDbName: string;

      @doc("Optional force delete boolean. If this is provided as true, migration will be deleted even if active.")
      @query("force")
      force?: boolean;
    }
  >;
  @doc("Stop on going migration for the database.")
  cancel is ArmResourceActionAsync<
    DatabaseMigrationSqlDB,
    MigrationOperationInput,
    {},
    {
      ...BaseParameters<DatabaseMigrationSqlDB>;

      @path
      sqlDbInstanceName: string;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;
}
