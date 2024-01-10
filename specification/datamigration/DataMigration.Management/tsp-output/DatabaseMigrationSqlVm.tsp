import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.DataMigration;
@doc("Database Migration Resource for SQL Virtual Machine.")
model DatabaseMigrationSqlVm
  is ProxyResource<DatabaseMigrationSqlVmProperties> {
  @doc("The name of the target database.")
  @key("targetDbName")
  @segment("databaseMigrations")
  name: string;
}

@armResourceOperations
@projectedName("client", "DatabaseMigrationsSqlVm")
interface DatabaseMigrationSqlVms_DatabaseMigrationsSqlVm {
  @doc("Retrieve the specified database migration for a given SQL VM.")
  get is ArmResourceRead<
    DatabaseMigrationSqlVm,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

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

  @doc("Create a new database migration to a given SQL VM.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DatabaseMigrationSqlVm,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;

  @doc("Stop in-progress database migration to SQL VM.")
  cancel is ArmResourceActionAsync<
    DatabaseMigrationSqlVm,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;

  @doc("Initiate cutover for in-progress online database migration to SQL VM.")
  cutover is ArmResourceActionAsync<
    DatabaseMigrationSqlVm,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;
}
