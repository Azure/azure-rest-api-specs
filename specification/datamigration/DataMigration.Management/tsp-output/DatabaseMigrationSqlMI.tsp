import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.DataMigration;
@doc("Database Migration Resource for SQL Managed Instance.")
model DatabaseMigrationSqlMi
  is ProxyResource<DatabaseMigrationSqlMIProperties> {
  @doc("The name of the target database.")
  @path
  @key("targetDbName")
  @segment("databaseMigrations")
  name: string;
}

@armResourceOperations
interface DatabaseMigrationsSqlMi {
  @doc("Retrieve the specified database migration for a given SQL Managed Instance.")
  get is ArmResourceRead<
    DatabaseMigrationSqlMi,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

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
  @doc("Create a new database migration to a given SQL Managed Instance.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DatabaseMigrationSqlMi,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;
  @doc("Stop in-progress database migration to SQL Managed Instance.")
  cancel is ArmResourceActionAsync<
    DatabaseMigrationSqlMi,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;
  @doc("Initiate cutover for in-progress online database migration to SQL Managed Instance.")
  cutover is ArmResourceActionAsync<
    DatabaseMigrationSqlMi,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;
}
