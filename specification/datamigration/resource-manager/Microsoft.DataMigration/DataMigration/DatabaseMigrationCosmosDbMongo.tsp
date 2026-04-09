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
 * Database Migration Resource for Mongo to CosmosDb.
 */
model DatabaseMigrationCosmosDbMongo
  is Azure.ResourceManager.ProxyResource<DatabaseMigrationPropertiesCosmosDbMongo> {
  ...ResourceNameParameter<
    Resource = DatabaseMigrationCosmosDbMongo,
    KeyName = "migrationName",
    SegmentName = "databaseMigrations",
    NamePattern = "^[A-Za-z][A-Za-z0-9_-]*$"
  >;
}

alias DatabaseMigrationCosmosDbMongoOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.DocumentDB";

    /** The name of the target resource/account. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[A-Za-z][A-Za-z0-9_-]*$")
    targetResourceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationCosmosDbMongo>;
  },
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationCosmosDbMongo>;

    /** Name of the migration. */
    @path
    @segment("databaseMigrations")
    @key
    @pattern("^[A-Za-z][A-Za-z0-9_-]*$")
    migrationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface DatabaseMigrationCosmosDbMongos {
  /**
   * Get Database Migration resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsMongoToCosmosDbRUMongo_Get")
  @tag("DatabaseMigrations")
  get is DatabaseMigrationCosmosDbMongoOps.Read<DatabaseMigrationCosmosDbMongo>;

  /**
   * Create or Update Database Migration resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsMongoToCosmosDbRUMongo_Create")
  @tag("DatabaseMigrations")
  create is DatabaseMigrationCosmosDbMongoOps.CreateOrUpdateAsync<
    DatabaseMigrationCosmosDbMongo,
    LroHeaders = ArmLroLocationHeader<FinalResult = DatabaseMigrationCosmosDbMongo> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Database Migration resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsMongoToCosmosDbRUMongo_Delete")
  @tag("DatabaseMigrations")
  delete is DatabaseMigrationCosmosDbMongoOps.DeleteWithoutOkAsync<
    DatabaseMigrationCosmosDbMongo,
    Parameters = {
      /**
       * Optional force delete boolean. If this is provided as true, migration will be deleted even if active.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * Get Database Migration resources for the scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("DatabaseMigrationsMongoToCosmosDbRUMongo_GetForScope")
  @tag("DatabaseMigrations")
  getForScope is DatabaseMigrationCosmosDbMongoOps.List<
    DatabaseMigrationCosmosDbMongo,
    Response = ArmResponse<DatabaseMigrationCosmosDbMongoListResult>
  >;
}
alias DatabaseMigrationsMongoToCosmosDbvCoreMongoOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.DocumentDB";

    /** The name of the target resource/account. */
    @path
    @segment("mongoClusters")
    @key
    @pattern("^[A-Za-z][A-Za-z0-9_-]*$")
    targetResourceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationCosmosDbMongo>;
  },
  {
    ...Extension.ExtensionProviderNamespace<DatabaseMigrationCosmosDbMongo>;

    /** Name of the migration. */
    @path
    @segment("databaseMigrations")
    @key
    @pattern("^[A-Za-z][A-Za-z0-9_-]*$")
    migrationName: string;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface DatabaseMigrationsMongoToCosmosDbvCoreMongo {
  /**
   * Get Database Migration resource.
   */
  @tag("DatabaseMigrations")
  get is DatabaseMigrationsMongoToCosmosDbvCoreMongoOps.Read<DatabaseMigrationCosmosDbMongo>;

  /**
   * Create or Update Database Migration resource.
   */
  @tag("DatabaseMigrations")
  create is DatabaseMigrationsMongoToCosmosDbvCoreMongoOps.CreateOrUpdateAsync<
    DatabaseMigrationCosmosDbMongo,
    LroHeaders = ArmLroLocationHeader<FinalResult = DatabaseMigrationCosmosDbMongo> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete Database Migration resource.
   */
  @tag("DatabaseMigrations")
  delete is DatabaseMigrationsMongoToCosmosDbvCoreMongoOps.DeleteWithoutOkAsync<
    DatabaseMigrationCosmosDbMongo,
    Parameters = {
      /**
       * Optional force delete boolean. If this is provided as true, migration will be deleted even if active.
       */
      @query("force")
      force?: boolean;
    }
  >;

  /**
   * Get Database Migration resources for the scope.
   */
  @tag("DatabaseMigrations")
  getForScope is DatabaseMigrationsMongoToCosmosDbvCoreMongoOps.List<
    DatabaseMigrationCosmosDbMongo,
    Response = ArmResponse<DatabaseMigrationCosmosDbMongoListResult>
  >;
}

@@doc(DatabaseMigrationCosmosDbMongo.name, "Name of the migration.");
@@doc(DatabaseMigrationCosmosDbMongo.properties,
  "Database Migration Resource properties for CosmosDb for Mongo."
);
@@doc(DatabaseMigrationCosmosDbMongos.create::parameters.resource,
  "Details of CosmosDB for Mongo API Migration resource."
);
@@doc(DatabaseMigrationsMongoToCosmosDbvCoreMongo.create::parameters.resource,
  "Details of CosmosDB for Mongo API Migration resource."
);
