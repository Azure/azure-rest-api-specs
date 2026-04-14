import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseSchema.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database table resource.
 */
@parentResource(DatabaseSchema)
model DatabaseTable
  is Azure.ResourceManager.ProxyResource<DatabaseTableProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseTable,
    KeyName = "tableName",
    SegmentName = "tables",
    NamePattern = ""
  >;
}

alias DatabaseTableOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the schema. */
    @path
    @segment("schemas")
    @key
    schemaName: string;
  },
  {
    /** The name of the table. */
    @path
    @segment("tables")
    @key
    tableName: string;
  }
>;

@armResourceOperations
interface DatabaseTables {
  /**
   * Get database table
   */
  get is DatabaseTableOps.Read<DatabaseTable>;

  /**
   * List database tables
   */
  listBySchema is DatabaseTableOps.List<
    DatabaseTable,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
alias ManagedDatabaseTableOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the schema. */
    @path
    @segment("schemas")
    @key
    schemaName: string;
  },
  {
    /** The name of the table. */
    @path
    @segment("tables")
    @key
    tableName: string;
  }
>;

@armResourceOperations
interface ManagedDatabaseTables {
  /**
   * Get managed database table
   */
  get is ManagedDatabaseTableOps.Read<DatabaseTable>;

  /**
   * List managed database tables
   */
  listBySchema is ManagedDatabaseTableOps.List<
    DatabaseTable,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(DatabaseTable.name, "The name of the table.");
@@doc(DatabaseTable.properties, "Resource properties.");
