import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataMigration;
/**
 * Database Migration Resource for SQL Managed Instance.
 */
model DatabaseMigrationSqlMi
  is Azure.ResourceManager.ProxyResource<DatabaseMigrationPropertiesSqlMi> {
  ...ResourceNameParameter<
    Resource = DatabaseMigrationSqlMi,
    KeyName = "targetDbName",
    SegmentName = "databaseMigrations",
    NamePattern = ""
  >;
}

alias DatabaseMigrationSqlMiOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Sql";

    /** The name of the target SQL Managed Instance. */
    @path
    @segment("managedInstances")
    @key
    managedInstanceName: string;
  },
  {},
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationSqlMi>;

    /** The name of the target database. */
    @path
    @segment("databaseMigrations")
    @key
    targetDbName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface DatabaseMigrationSqlMis {
  /**
   * Retrieve the specified database migration for a given SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsSqlMi_Get")
  @tag("DatabaseMigrations")
  get is DatabaseMigrationSqlMiOps.Read<
    DatabaseMigrationSqlMi,
    Parameters = {
      /**
       * Optional migration operation ID. If this is provided, then details of migration operation for that ID are retrieved. If not provided (default), then details related to most recent or current operation are retrieved.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsSqlMi_CreateOrUpdate")
  @tag("DatabaseMigrations")
  createOrUpdate is DatabaseMigrationSqlMiOps.CreateOrUpdateAsync<
    DatabaseMigrationSqlMi,
    LroHeaders = ArmLroLocationHeader<FinalResult = DatabaseMigrationSqlMi> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Database Migration resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsSqlMi_Delete")
  @tag("DatabaseMigrations")
  delete is DatabaseMigrationSqlMiOps.DeleteWithoutOkAsync<
    DatabaseMigrationSqlMi,
    Parameters = {
      /**
       * Optional force delete boolean. If this is provided as true, migration will be deleted even if active.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmResponse<DatabaseMigrationSqlMi> | ArmDeleteAcceptedLroResponse<ArmLroLocationHeader<FinalResult = DatabaseMigrationSqlMi> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Stop in-progress database migration to SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsSqlMi_cancel")
  @tag("DatabaseMigrations")
  cancel is DatabaseMigrationSqlMiOps.ActionAsync<
    DatabaseMigrationSqlMi,
    MigrationOperationInput,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Initiate cutover for in-progress online database migration to SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsSqlMi_cutover")
  @tag("DatabaseMigrations")
  cutover is DatabaseMigrationSqlMiOps.ActionAsync<
    DatabaseMigrationSqlMi,
    MigrationOperationInput,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;
}

@@doc(DatabaseMigrationSqlMi.name, "The name of the target database.");
@@doc(DatabaseMigrationSqlMi.properties,
  "Database Migration Resource properties for SQL Managed Instance."
);
@@doc(DatabaseMigrationSqlMis.createOrUpdate::parameters.resource,
  "Details of SqlMigrationService resource."
);
@@doc(DatabaseMigrationSqlMis.cancel::parameters.body,
  "Required migration operation ID for which cancel will be initiated."
);
@@doc(DatabaseMigrationSqlMis.cutover::parameters.body,
  "Required migration operation ID for which cutover will be initiated."
);
