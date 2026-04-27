import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
// FIXME: DatabaseSchema has no properties property
/**
 * A database schema resource.
 */
@parentResource(Database)
model DatabaseSchema is Azure.ResourceManager.ProxyResource<never> {
  ...ResourceNameParameter<
    Resource = DatabaseSchema,
    KeyName = "schemaName",
    SegmentName = "schemas",
    NamePattern = ""
  >;
}

alias DatabaseSchemaOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the server. */
    @path
    @segment("servers")
    @key
    serverName: string;

    /** The name of the database. */
    @path
    @segment("databases")
    @key
    databaseName: string;
  },
  {
    /** The name of the schema. */
    @path
    @segment("schemas")
    @key
    schemaName: string;
  }
>;

@armResourceOperations
interface DatabaseSchemas {
  /**
   * Get database schema
   */
  get is DatabaseSchemaOps.Read<DatabaseSchema>;

  /**
   * List database schemas
   */
  listByDatabase is DatabaseSchemaOps.List<
    DatabaseSchema,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
alias ManagedDatabaseSchemaOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the managed instance. */
    @path
    @segment("managedInstances")
    @key
    managedInstanceName: string;

    /** The name of the database. */
    @path
    @segment("databases")
    @key
    databaseName: string;
  },
  {
    /** The name of the schema. */
    @path
    @segment("schemas")
    @key
    schemaName: string;
  }
>;

@armResourceOperations
interface ManagedDatabaseSchemas {
  /**
   * Get managed database schema
   */
  get is ManagedDatabaseSchemaOps.Read<DatabaseSchema>;

  /**
   * List managed database schemas
   */
  listByDatabase is ManagedDatabaseSchemaOps.List<
    DatabaseSchema,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(DatabaseSchema.name, "The name of the schema.");
