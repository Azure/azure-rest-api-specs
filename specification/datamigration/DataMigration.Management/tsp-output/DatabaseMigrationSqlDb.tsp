import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
@doc("Database Migration Resource for SQL Database.")
model DatabaseMigrationSqlDb
  is ProxyResource<DatabaseMigrationSqlDBProperties> {
  @doc("The name of the target database.")
  @path
  @key("targetDbName")
  @segment("databaseMigrations")
  name: string;
}

@armResourceOperations
interface DatabaseMigrationSqlDbs {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the Database Migration resource.")
  @operationId("DatabaseMigrationsSqlDb_Get")
  get is ArmResourceRead<
    DatabaseMigrationSqlDb,
    {
      ...BaseParameters<DatabaseMigrationSqlDb>;

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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or Update Database Migration resource.")
  @operationId("DatabaseMigrationsSqlDb_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DatabaseMigrationSqlDb,
    {
      ...BaseParameters<DatabaseMigrationSqlDb>;

      @path
      sqlDbInstanceName: string;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete Database Migration resource.")
  @operationId("DatabaseMigrationsSqlDb_Delete")
  delete is ArmResourceDeleteAsync<
    DatabaseMigrationSqlDb,
    {
      ...BaseParameters<DatabaseMigrationSqlDb>;

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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stop on going migration for the database.")
  @operationId("DatabaseMigrationsSqlDb_cancel")
  cancel is ArmResourceActionAsync<
    DatabaseMigrationSqlDb,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlDb>;

      @path
      sqlDbInstanceName: string;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;
}

@@projectedName(DatabaseMigrationSqlDbs.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlDbs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlDbs.createOrUpdate::parameters.resource,
  "Details of Sql Db migration resource."
);
@@projectedName(DatabaseMigrationSqlDbs.cancel::parameters.body,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlDbs.cancel::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlDbs.cancel::parameters.body,
  "Required migration operation ID for which cancel will be initiated."
);
