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
 * Database Migration Resource for SQL Database.
 */
model DatabaseMigrationSqlDb
  is Azure.ResourceManager.ProxyResource<DatabaseMigrationPropertiesSqlDb> {
  ...ResourceNameParameter<
    Resource = DatabaseMigrationSqlDb,
    KeyName = "targetDbName",
    SegmentName = "databaseMigrations",
    NamePattern = ""
  >;
}

alias DatabaseMigrationSqlDbOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Sql";

    /** The name of the target SQL DB instance. */
    @path
    @segment("servers")
    @key
    sqlDbInstanceName: string;
  },
  {},
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationSqlDb>;

    /** The name of the target database. */
    @path
    @segment("databaseMigrations")
    @key
    targetDbName: string;
  }
>;

alias DatabaseMigrationSqlDbOpsWithPattern = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Sql";

    /** The name of the target SQL DB instance. */
    @path
    @segment("servers")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,127}$")
    sqlDbInstanceName: string;
  },
  {},
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationSqlDb>;

    /** The name of the target database. */
    @path
    @segment("databaseMigrations")
    @key
    @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,127}$")
    targetDbName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface DatabaseMigrationSqlDbs {
  /**
   * Retrieve the Database Migration resource.
   */
  @tag("DatabaseMigrations")
  get is DatabaseMigrationSqlDbOps.Read<
    DatabaseMigrationSqlDb,
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
   * Create or Update Database Migration resource.
   */
  @tag("DatabaseMigrations")
  createOrUpdate is DatabaseMigrationSqlDbOps.CreateOrUpdateAsync<
    DatabaseMigrationSqlDb,
    LroHeaders = ArmLroLocationHeader<FinalResult = DatabaseMigrationSqlDb> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Database Migration resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("DatabaseMigrations")
  delete is DatabaseMigrationSqlDbOps.DeleteWithoutOkAsync<
    DatabaseMigrationSqlDb,
    Parameters = {
      /**
       * Optional force delete boolean. If this is provided as true, migration will be deleted even if active.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Stop on going migration for the database.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsSqlDb_cancel")
  @tag("DatabaseMigrations")
  cancel is DatabaseMigrationSqlDbOps.ActionAsync<
    DatabaseMigrationSqlDb,
    MigrationOperationInput,
    void,
    Response = OkResponse | ArmAcceptedLroResponse
  >;

  /**
   * Retry on going migration for the database.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsSqlDb_retry")
  @tag("DatabaseMigrations")
  retry is DatabaseMigrationSqlDbOpsWithPattern.ActionAsync<
    DatabaseMigrationSqlDb,
    MigrationOperationInput,
    DatabaseMigrationSqlDb,
    Response = ArmAcceptedLroResponse & {
      @bodyRoot
      _: DatabaseMigrationSqlDb;
    }
  >;
}

@@doc(DatabaseMigrationSqlDb.name, "The name of the target database.");
@@doc(DatabaseMigrationSqlDb.properties,
  "Database Migration Resource properties for SQL database."
);
@@doc(DatabaseMigrationSqlDbs.createOrUpdate::parameters.resource,
  "Details of Sql Db migration resource."
);
@@doc(DatabaseMigrationSqlDbs.cancel::parameters.body,
  "Required migration operation ID for which cancel will be initiated."
);
@@doc(DatabaseMigrationSqlDbs.retry::parameters.body,
  "Required migration operation ID for which retry will be initiated."
);
