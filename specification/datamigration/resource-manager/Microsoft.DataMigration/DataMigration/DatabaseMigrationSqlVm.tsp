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
 * Database Migration Resource for SQL Virtual Machine.
 */
model DatabaseMigrationSqlVm
  is Azure.ResourceManager.ProxyResource<DatabaseMigrationPropertiesSqlVm> {
  ...ResourceNameParameter<
    Resource = DatabaseMigrationSqlVm,
    KeyName = "targetDbName",
    SegmentName = "databaseMigrations",
    NamePattern = ""
  >;
}

alias DatabaseMigrationSqlVmOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.SqlVirtualMachine";

    /** The name of the target SQL Virtual Machine. */
    @path
    @segment("sqlVirtualMachines")
    @key
    sqlVirtualMachineName: string;
  },
  {},
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationSqlVm>;

    /** The name of the target database. */
    @path
    @segment("databaseMigrations")
    @key
    targetDbName: string;
  }
>;

@armResourceOperations
interface DatabaseMigrationSqlVms {
  /**
   * Retrieve the specified database migration for a given SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseMigrationsSqlVm_Get")
  get is DatabaseMigrationSqlVmOps.Read<
    DatabaseMigrationSqlVm,
    Parameters = {
      /**
       * Optional migration operation ID. If this is provided, then details of migration operation for that ID are retrieved. If not provided (default), then details related to most recent or current operation are retrieved.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
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
   * Create a new database migration to a given SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseMigrationsSqlVm_CreateOrUpdate")
  createOrUpdate is DatabaseMigrationSqlVmOps.CreateOrUpdateAsync<
    DatabaseMigrationSqlVm,
    LroHeaders = ArmLroLocationHeader<FinalResult = DatabaseMigrationSqlVm> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Database Migration resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseMigrationsSqlVm_Delete")
  delete is DatabaseMigrationSqlVmOps.DeleteWithoutOkAsync<
    DatabaseMigrationSqlVm,
    Parameters = {
      /**
       * Optional force delete boolean. If this is provided as true, migration will be deleted even if active.
       */
      @query("force")
      force?: boolean;
    },
    Response = ArmResponse<DatabaseMigrationSqlVm> | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Stop in-progress database migration to SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseMigrationsSqlVm_cancel")
  cancel is DatabaseMigrationSqlVmOps.ActionAsync<
    DatabaseMigrationSqlVm,
    MigrationOperationInput,
    OkResponse
  >;

  /**
   * Initiate cutover for in-progress online database migration to SQL VM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseMigrationsSqlVm_cutover")
  cutover is DatabaseMigrationSqlVmOps.ActionAsync<
    DatabaseMigrationSqlVm,
    MigrationOperationInput,
    OkResponse
  >;
}

@@doc(DatabaseMigrationSqlVm.name, "The name of the target database.");
@@doc(DatabaseMigrationSqlVm.properties,
  "Database Migration Resource properties for SQL Virtual Machine."
);
@@doc(DatabaseMigrationSqlVms.createOrUpdate::parameters.resource,
  "Details of SqlMigrationService resource."
);
@@doc(DatabaseMigrationSqlVms.cancel::parameters.body, "");
@@doc(DatabaseMigrationSqlVms.cutover::parameters.body, "");
