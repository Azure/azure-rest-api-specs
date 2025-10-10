import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabaseGetResults.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DocumentDB;
/**
 * An Azure Cosmos DB resource throughput.
 */
@singleton("default")
@parentResource(SqlDatabaseGetResults)
model ThroughputSettingsGetResults
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<ThroughputSettingsGetProperties> {
  ...ResourceNameParameter<
    Resource = ThroughputSettingsGetResults,
    KeyName = "throughputSetting",
    SegmentName = "throughputSettings",
    NamePattern = ""
  >;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ManagedServiceIdentity;
}

alias ThroughputSettingsGetResultsOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB database name. */
    @path
    @segment("sqlDatabases")
    @key
    databaseName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;

@armResourceOperations
interface ThroughputSettingsGetResultsOperationGroup {
  /**
   * Gets the RUs per second of the SQL database under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_GetSqlDatabaseThroughput")
  getSqlDatabaseThroughput is ThroughputSettingsGetResultsOperationGroupOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB SQL database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlResources_UpdateSqlDatabaseThroughput")
  updateSqlDatabaseThroughput is ThroughputSettingsGetResultsOperationGroupOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB SQL database from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_MigrateSqlDatabaseToAutoscale")
  @action("migrateToAutoscale")
  migrateSqlDatabaseToAutoscale is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB SQL database from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_MigrateSqlDatabaseToManualThroughput")
  @action("migrateToManualThroughput")
  migrateSqlDatabaseToManualThroughput is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB SQL database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_SqlDatabaseRetrieveThroughputDistribution")
  @action("retrieveThroughputDistribution")
  sqlDatabaseRetrieveThroughputDistribution is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB SQL database
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_SqlDatabaseRedistributeThroughput")
  @action("redistributeThroughput")
  sqlDatabaseRedistributeThroughput is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;
}
alias ThroughputSettingsGetResultsOperationGroupOps_2 = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB database name. */
    @path
    @segment("sqlDatabases")
    @key
    databaseName: string;

    /** Cosmos DB container name. */
    @path
    @segment("containers")
    @key
    containerName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;
#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@armResourceOperations
interface ThroughputSettingsGetResultsOperationGroup_2 {
  /**
   * Gets the RUs per second of the SQL container under an existing Azure Cosmos DB database account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_GetSqlContainerThroughput")
  getSqlContainerThroughput is ThroughputSettingsGetResultsOperationGroupOps_2.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB SQL container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("SqlResources_UpdateSqlContainerThroughput")
  updateSqlContainerThroughput is ThroughputSettingsGetResultsOperationGroupOps_2.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB SQL container from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_MigrateSqlContainerToAutoscale")
  @action("migrateToAutoscale")
  migrateSqlContainerToAutoscale is ThroughputSettingsGetResultsOperationGroupOps_2.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB SQL container from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_MigrateSqlContainerToManualThroughput")
  @action("migrateToManualThroughput")
  migrateSqlContainerToManualThroughput is ThroughputSettingsGetResultsOperationGroupOps_2.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB SQL container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_SqlContainerRetrieveThroughputDistribution")
  @action("retrieveThroughputDistribution")
  sqlContainerRetrieveThroughputDistribution is ThroughputSettingsGetResultsOperationGroupOps_2.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB SQL container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlResources_SqlContainerRedistributeThroughput")
  @action("redistributeThroughput")
  sqlContainerRedistributeThroughput is ThroughputSettingsGetResultsOperationGroupOps_2.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;
}
alias MongoDBResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB database name. */
    @path
    @segment("mongodbDatabases")
    @key
    databaseName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;
#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@armResourceOperations
interface MongoDBResources {
  /**
   * Gets the RUs per second of the MongoDB database under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  getMongoDBDatabaseThroughput is MongoDBResourceOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of the an Azure Cosmos DB MongoDB database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  updateMongoDBDatabaseThroughput is MongoDBResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB database from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  @action("migrateToAutoscale")
  migrateMongoDBDatabaseToAutoscale is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB database from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  @action("migrateToManualThroughput")
  migrateMongoDBDatabaseToManualThroughput is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB MongoDB database
   */
  @action("retrieveThroughputDistribution")
  mongoDBDatabaseRetrieveThroughputDistribution is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB MongoDB database
   */
  @action("redistributeThroughput")
  mongoDBDatabaseRedistributeThroughput is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;
}
alias ThroughputSettingsGetResultsOperationGroupOps_3 = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB database name. */
    @path
    @segment("mongodbDatabases")
    @key
    databaseName: string;

    /** Cosmos DB collection name. */
    @path
    @segment("collections")
    @key
    collectionName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;
#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@armResourceOperations
interface ThroughputSettingsGetResultsOperationGroup_3 {
  /**
   * Gets the RUs per second of the MongoDB collection under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_GetMongoDBCollectionThroughput")
  getMongoDBCollectionThroughput is ThroughputSettingsGetResultsOperationGroupOps_3.Read<ThroughputSettingsGetResults>;

  /**
   * Update the RUs per second of an Azure Cosmos DB MongoDB collection
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("MongoDBResources_UpdateMongoDBCollectionThroughput")
  updateMongoDBCollectionThroughput is ThroughputSettingsGetResultsOperationGroupOps_3.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB MongoDB container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_MongoDBContainerRetrieveThroughputDistribution")
  @action("retrieveThroughputDistribution")
  mongoDBContainerRetrieveThroughputDistribution is ThroughputSettingsGetResultsOperationGroupOps_3.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB MongoDB container
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_MongoDBContainerRedistributeThroughput")
  @action("redistributeThroughput")
  mongoDBContainerRedistributeThroughput is ThroughputSettingsGetResultsOperationGroupOps_3.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    ArmResponse<PhysicalPartitionThroughputInfoResult>
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB collection from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_MigrateMongoDBCollectionToAutoscale")
  @action("migrateToAutoscale")
  migrateMongoDBCollectionToAutoscale is ThroughputSettingsGetResultsOperationGroupOps_3.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB collection from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("MongoDBResources_MigrateMongoDBCollectionToManualThroughput")
  @action("migrateToManualThroughput")
  migrateMongoDBCollectionToManualThroughput is ThroughputSettingsGetResultsOperationGroupOps_3.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;
}
alias TableResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB table name. */
    @path
    @segment("tables")
    @key
    tableName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;

@armResourceOperations
interface TableResources {
  /**
   * Gets the RUs per second of the Table under an existing Azure Cosmos DB database account with the provided name.
   */
  getTableThroughput is TableResourceOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Table
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  updateTableThroughput is TableResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB Table from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateTableToAutoscale is TableResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB Table from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateTableToManualThroughput is TableResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;
}
alias CassandraResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB keyspace name. */
    @path
    @segment("cassandraKeyspaces")
    @key
    keyspaceName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;

@armResourceOperations
interface CassandraResources {
  /**
   * Gets the RUs per second of the Cassandra Keyspace under an existing Azure Cosmos DB database account with the provided name.
   */
  getCassandraKeyspaceThroughput is CassandraResourceOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Cassandra Keyspace
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  updateCassandraKeyspaceThroughput is CassandraResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra Keyspace from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateCassandraKeyspaceToAutoscale is CassandraResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra Keyspace from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateCassandraKeyspaceToManualThroughput is CassandraResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;
}
alias ThroughputSettingsGetResultsOperationGroupOps_4 = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB keyspace name. */
    @path
    @segment("cassandraKeyspaces")
    @key
    keyspaceName: string;

    /** Cosmos DB table name. */
    @path
    @segment("tables")
    @key
    tableName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;

#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@armResourceOperations
interface ThroughputSettingsGetResultsOperationGroup_4 {
  /**
   * Gets the RUs per second of the Cassandra table under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_GetCassandraTableThroughput")
  getCassandraTableThroughput is ThroughputSettingsGetResultsOperationGroupOps_4.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Cassandra table
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("CassandraResources_UpdateCassandraTableThroughput")
  updateCassandraTableThroughput is ThroughputSettingsGetResultsOperationGroupOps_4.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra table from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_MigrateCassandraTableToAutoscale")
  @action("migrateToAutoscale")
  migrateCassandraTableToAutoscale is ThroughputSettingsGetResultsOperationGroupOps_4.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra table from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_MigrateCassandraTableToManualThroughput")
  @action("migrateToManualThroughput")
  migrateCassandraTableToManualThroughput is ThroughputSettingsGetResultsOperationGroupOps_4.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;
}
alias ThroughputSettingsGetResultsOperationGroupOps_5 = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB keyspace name. */
    @path
    @segment("cassandraKeyspaces")
    @key
    keyspaceName: string;

    /** Cosmos DB view name. */
    @path
    @segment("views")
    @key
    viewName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;
#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@armResourceOperations
interface ThroughputSettingsGetResultsOperationGroup_5 {
  /**
   * Gets the RUs per second of the Cassandra view under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_GetCassandraViewThroughput")
  getCassandraViewThroughput is ThroughputSettingsGetResultsOperationGroupOps_5.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Cassandra view
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("CassandraResources_UpdateCassandraViewThroughput")
  updateCassandraViewThroughput is ThroughputSettingsGetResultsOperationGroupOps_5.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra view from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_MigrateCassandraViewToAutoscale")
  @action("migrateToAutoscale")
  migrateCassandraViewToAutoscale is ThroughputSettingsGetResultsOperationGroupOps_5.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra view from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CassandraResources_MigrateCassandraViewToManualThroughput")
  @action("migrateToManualThroughput")
  migrateCassandraViewToManualThroughput is ThroughputSettingsGetResultsOperationGroupOps_5.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;
}
alias GremlinResourceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB database name. */
    @path
    @segment("gremlinDatabases")
    @key
    databaseName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;

@armResourceOperations
interface GremlinResources {
  /**
   * Gets the RUs per second of the Gremlin database under an existing Azure Cosmos DB database account with the provided name.
   */
  getGremlinDatabaseThroughput is GremlinResourceOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Gremlin database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  updateGremlinDatabaseThroughput is GremlinResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin database from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateGremlinDatabaseToAutoscale is GremlinResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin database from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateGremlinDatabaseToManualThroughput is GremlinResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;
}
alias ThroughputSettingsGetResultsOperationGroupOps_6 = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Cosmos DB database account name. */
    @path
    @segment("databaseAccounts")
    @key
    @pattern("^[a-z0-9]+(-[a-z0-9]+)*")
    accountName: string;

    /** Cosmos DB database name. */
    @path
    @segment("gremlinDatabases")
    @key
    databaseName: string;

    /** Cosmos DB graph name. */
    @path
    @segment("graphs")
    @key
    graphName: string;
  },
  {
    /** undefined */
    @path
    @segment("throughputSettings")
    @key
    default: "default";
  }
>;
#suppress "@azure-tools/typespec-azure-core/casing-style" "non-standard operations"
@armResourceOperations
interface ThroughputSettingsGetResultsOperationGroup_6 {
  /**
   * Gets the Gremlin graph throughput under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_GetGremlinGraphThroughput")
  getGremlinGraphThroughput is ThroughputSettingsGetResultsOperationGroupOps_6.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Gremlin graph
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("GremlinResources_UpdateGremlinGraphThroughput")
  updateGremlinGraphThroughput is ThroughputSettingsGetResultsOperationGroupOps_6.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin graph from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_MigrateGremlinGraphToAutoscale")
  @action("migrateToAutoscale")
  migrateGremlinGraphToAutoscale is ThroughputSettingsGetResultsOperationGroupOps_6.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin graph from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GremlinResources_MigrateGremlinGraphToManualThroughput")
  @action("migrateToManualThroughput")
  migrateGremlinGraphToManualThroughput is ThroughputSettingsGetResultsOperationGroupOps_6.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ArmResponse<ThroughputSettingsGetResults>
  >;
}

@@doc(ThroughputSettingsGetResults.name, "");
@@doc(ThroughputSettingsGetResults.properties,
  "The properties of an Azure Cosmos DB resource throughput"
);
@@doc(ThroughputSettingsGetResultsOperationGroup.updateSqlDatabaseThroughput::parameters.resource,
  "The parameters to provide for the RUs per second of the current SQL database."
);
@@doc(ThroughputSettingsGetResultsOperationGroup.sqlDatabaseRetrieveThroughputDistribution::parameters.body,
  "The parameters to provide for retrieving throughput distribution for the current SQL database."
);
@@doc(ThroughputSettingsGetResultsOperationGroup.sqlDatabaseRedistributeThroughput::parameters.body,
  "The parameters to provide for redistributing throughput for the current SQL database."
);
// @@doc(ThroughputSettingsGetResultsOperationGroup.updateSqlContainerThroughput::parameters.resource,
//   "The parameters to provide for the RUs per second of the current SQL container."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.sqlContainerRetrieveThroughputDistribution::parameters.body,
//   "The parameters to provide for retrieving throughput distribution for the current SQL container."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.sqlContainerRedistributeThroughput::parameters.body,
//   "The parameters to provide for redistributing throughput for the current SQL container."
// );
// @@doc(MongoDBResources.updateMongoDBDatabaseThroughput::parameters.resource,
//   "The RUs per second of the parameters to provide for the current MongoDB database."
// );
// @@doc(MongoDBResources.mongoDBDatabaseRetrieveThroughputDistribution::parameters.body,
//   "The parameters to provide for retrieving throughput distribution for the current MongoDB database."
// );
// @@doc(MongoDBResources.mongoDBDatabaseRedistributeThroughput::parameters.body,
//   "The parameters to provide for redistributing throughput for the current MongoDB database."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.updateMongoDBCollectionThroughput::parameters.resource,
//   "The RUs per second of the parameters to provide for the current MongoDB collection."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.mongoDBContainerRetrieveThroughputDistribution::parameters.body,
//   "The parameters to provide for retrieving throughput distribution for the current MongoDB container."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.mongoDBContainerRedistributeThroughput::parameters.body,
//   "The parameters to provide for redistributing throughput for the current MongoDB container."
// );
// @@doc(TableResources.updateTableThroughput::parameters.resource,
//   "The parameters to provide for the RUs per second of the current Table."
// );
// @@doc(CassandraResources.updateCassandraKeyspaceThroughput::parameters.resource,
//   "The RUs per second of the parameters to provide for the current Cassandra Keyspace."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.updateCassandraTableThroughput::parameters.resource,
//   "The RUs per second of the parameters to provide for the current Cassandra table."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.updateCassandraViewThroughput::parameters.resource,
//   "The RUs per second of the parameters to provide for the current Cassandra view."
// );
// @@doc(GremlinResources.updateGremlinDatabaseThroughput::parameters.resource,
//   "The RUs per second of the parameters to provide for the current Gremlin database."
// );
// @@doc(ThroughputSettingsGetResultsOperationGroup.updateGremlinGraphThroughput::parameters.resource,
//   "The RUs per second of the parameters to provide for the current Gremlin graph."
// );
