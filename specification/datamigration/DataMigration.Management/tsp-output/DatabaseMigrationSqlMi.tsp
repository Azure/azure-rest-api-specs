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
 * Database Migration Resource for SQL Managed Instance.
 */
model DatabaseMigrationSqlMi
  is ProxyResource<DatabaseMigrationSqlMIProperties> {
  /**
   * The name of the target database.
   */
  @path
  @key("targetDbName")
  @segment("databaseMigrations")
  name: string;
}

@armResourceOperations
interface DatabaseMigrationSqlMis {
  /**
   * Retrieve the specified database migration for a given SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlMi_Get")
  get is ArmResourceRead<
    DatabaseMigrationSqlMi,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

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
   * Create a new database migration to a given SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlMi_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DatabaseMigrationSqlMi,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

      /**
       * The name of the target database.
       */
      @path
      targetDbName: string;
    }
  >;

  /**
   * Stop in-progress database migration to SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlMi_cancel")
  cancel is ArmResourceActionAsync<
    DatabaseMigrationSqlMi,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

      /**
       * The name of the target database.
       */
      @path
      targetDbName: string;
    }
  >;

  /**
   * Initiate cutover for in-progress online database migration to SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseMigrationsSqlMi_cutover")
  cutover is ArmResourceActionAsync<
    DatabaseMigrationSqlMi,
    MigrationOperationInput,
    void,
    {
      ...BaseParameters<DatabaseMigrationSqlMi>;

      /**
       * The name of the target database.
       */
      @path
      targetDbName: string;
    }
  >;
}

@@projectedName(DatabaseMigrationSqlMis.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlMis.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlMis.createOrUpdate::parameters.resource,
  "Details of SqlMigrationService resource."
);
@@projectedName(DatabaseMigrationSqlMis.cancel::parameters.body,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlMis.cancel::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlMis.cancel::parameters.body,
  "Required migration operation ID for which cancel will be initiated."
);
@@projectedName(DatabaseMigrationSqlMis.cutover::parameters.body,
  "json",
  "parameters"
);
@@extension(DatabaseMigrationSqlMis.cutover::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseMigrationSqlMis.cutover::parameters.body,
  "Required migration operation ID for which cutover will be initiated."
);
