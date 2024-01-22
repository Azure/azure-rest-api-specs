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
/**
 * Database Migration Resource for SQL Virtual Machine.
 */
model DatabaseMigrationSqlVm
  is ProxyResource<DatabaseMigrationSqlVmProperties> {
  /**
   * The name of the target database.
   */
  @path
  @key("targetDbName")
  @segment("databaseMigrations")
  name: string;
}

@armResourceOperations
interface DatabaseMigrationSqlVms {
  /**
   * Retrieve the specified database migration for a given SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlVm_Get")
  get is ArmResourceRead<
    DatabaseMigrationSqlVm,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      /**
       * The name of the target database.
       */
      @path
      targetDbName: string;

      /**
       * Optional migration operation ID. If this is provided, then details of migration operation for that ID are retrieved. If not provided (default), then details related to most recent or current operation are retrieved.
       */
      @query("migrationOperationId")
      migrationOperationId?: string;

      /**
       * Complete migration details be included in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create a new database migration to a given SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlVm_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DatabaseMigrationSqlVm,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      /**
       * The name of the target database.
       */
      @path
      targetDbName: string;
    }
  >;

  /**
   * Stop in-progress database migration to SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlVm_cancel")
  cancel is ArmResourceActionAsync<
    DatabaseMigrationSqlVm,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      /**
       * The name of the target database.
       */
      @path
      targetDbName: string;
    }
  >;

  /**
   * Initiate cutover for in-progress online database migration to SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlVm_cutover")
  cutover is ArmResourceActionAsync<
    DatabaseMigrationSqlVm,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlVm>;

      /**
       * The name of the target database.
       */
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
