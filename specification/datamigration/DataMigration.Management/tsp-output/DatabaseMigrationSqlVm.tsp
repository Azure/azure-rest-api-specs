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
@doc("Database Migration Resource for SQL Virtual Machine.")
model DatabaseMigrationSqlVm
  is ProxyResource<DatabaseMigrationSqlVmProperties> {
  @doc("The name of the target database.")
  @path
  @key("targetDbName")
  @segment("databaseMigrations")
  name: string;
}

@armResourceOperations
interface DatabaseMigrationSqlVms {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the specified database migration for a given SQL VM.")
  @operationId("DatabaseMigrationsSqlVm_Get")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new database migration to a given SQL VM.")
  @operationId("DatabaseMigrationsSqlVm_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    DatabaseMigrationSqlVm,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      @doc("The name of the target database.")
      @path
      targetDbName: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stop in-progress database migration to SQL VM.")
  @operationId("DatabaseMigrationsSqlVm_cancel")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Initiate cutover for in-progress online database migration to SQL VM.")
  @operationId("DatabaseMigrationsSqlVm_cutover")
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

@@projectedName(DatabaseMigrationSqlVms.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlVms.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlVms.createOrUpdate::parameters.resource,
  "Details of SqlMigrationService resource."
);
@@projectedName(DatabaseMigrationSqlVms.cancel::parameters.body,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlVms.cancel::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlVms.cancel::parameters.body, "");
@@projectedName(DatabaseMigrationSqlVms.cutover::parameters.body,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlVms.cutover::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlVms.cutover::parameters.body, "");
