import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseTable.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database column resource.
 */
@parentResource(DatabaseTable)
model DatabaseColumn
  is Azure.ResourceManager.ProxyResource<DatabaseColumnProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseColumn,
    KeyName = "columnName",
    SegmentName = "columns",
    NamePattern = ""
  >;
}

alias DatabaseColumnOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the table. */
    @path
    @segment("tables")
    @key
    tableName: string;
  },
  {
    /** The name of the column. */
    @path
    @segment("columns")
    @key
    columnName: string;
  }
>;

@armResourceOperations
interface DatabaseColumns {
  /**
   * Get database column
   */
  get is DatabaseColumnOps.Read<DatabaseColumn>;

  /**
   * List database columns
   */
  listByTable is DatabaseColumnOps.List<
    DatabaseColumn,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}
alias ManagedDatabaseColumnOps = Azure.ResourceManager.Legacy.LegacyOperations<
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

    /** The name of the table. */
    @path
    @segment("tables")
    @key
    tableName: string;
  },
  {
    /** The name of the column. */
    @path
    @segment("columns")
    @key
    columnName: string;
  }
>;

@armResourceOperations
interface ManagedDatabaseColumns {
  /**
   * Get managed database column
   */
  get is ManagedDatabaseColumnOps.Read<DatabaseColumn>;

  /**
   * List managed database columns
   */
  listByTable is ManagedDatabaseColumnOps.List<
    DatabaseColumn,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@doc(DatabaseColumn.name, "The name of the column.");
@@doc(DatabaseColumn.properties, "Resource properties.");
