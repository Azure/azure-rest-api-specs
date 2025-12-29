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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
    @minLength(3)
    @maxLength(50)
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
  getSqlDatabaseThroughput is ThroughputSettingsGetResultsOperationGroupOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB SQL database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateSqlDatabaseThroughput is ThroughputSettingsGetResultsOperationGroupOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB SQL database from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateSqlDatabaseToAutoscale is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB SQL database from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateSqlDatabaseToManualThroughput is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB SQL database
   */
  @action("retrieveThroughputDistribution")
  sqlDatabaseRetrieveThroughputDistribution is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB SQL database
   */
  @action("redistributeThroughput")
  sqlDatabaseRedistributeThroughput is ThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;
}
alias SqlResourcesThroughputSettingsGetResultsOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @minLength(3)
    @maxLength(50)
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SqlResourcesThroughputSettingsGetResultsOperationGroup {
  /**
   * Gets the RUs per second of the SQL container under an existing Azure Cosmos DB database account.
   */
  getSqlContainerThroughput is SqlResourcesThroughputSettingsGetResultsOperationGroupOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB SQL container
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateSqlContainerThroughput is SqlResourcesThroughputSettingsGetResultsOperationGroupOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB SQL container from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateSqlContainerToAutoscale is SqlResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults>>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB SQL container from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateSqlContainerToManualThroughput is SqlResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults>>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB SQL container
   */
  @action("retrieveThroughputDistribution")
  sqlContainerRetrieveThroughputDistribution is SqlResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult>>,
    OverrideErrorType = CloudError
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB SQL container
   */
  @action("redistributeThroughput")
  sqlContainerRedistributeThroughput is SqlResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult>>,
    OverrideErrorType = CloudError
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
    @minLength(3)
    @maxLength(50)
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MongoDBResources {
  /**
   * Gets the RUs per second of the MongoDB database under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getMongoDBDatabaseThroughput is MongoDBResourceOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of the an Azure Cosmos DB MongoDB database
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateMongoDBDatabaseThroughput is MongoDBResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB database from manual throughput to autoscale
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("migrateToAutoscale")
  migrateMongoDBDatabaseToAutoscale is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB database from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("migrateToManualThroughput")
  migrateMongoDBDatabaseToManualThroughput is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB MongoDB database
   */
  @action("retrieveThroughputDistribution")
  mongoDBDatabaseRetrieveThroughputDistribution is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB MongoDB database
   */
  @action("redistributeThroughput")
  mongoDBDatabaseRedistributeThroughput is MongoDBResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;
}
alias MongoDBResourcesThroughputSettingsGetResultsOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @minLength(3)
    @maxLength(50)
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface MongoDBResourcesThroughputSettingsGetResultsOperationGroup {
  /**
   * Gets the RUs per second of the MongoDB collection under an existing Azure Cosmos DB database account with the provided name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  getMongoDBCollectionThroughput is MongoDBResourcesThroughputSettingsGetResultsOperationGroupOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update the RUs per second of an Azure Cosmos DB MongoDB collection
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateMongoDBCollectionThroughput is MongoDBResourcesThroughputSettingsGetResultsOperationGroupOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Retrieve throughput distribution for an Azure Cosmos DB MongoDB container
   */
  @action("retrieveThroughputDistribution")
  mongoDBContainerRetrieveThroughputDistribution is MongoDBResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RetrieveThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Redistribute throughput for an Azure Cosmos DB MongoDB container
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("redistributeThroughput")
  mongoDBContainerRedistributeThroughput is MongoDBResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    RedistributeThroughputParameters,
    PhysicalPartitionThroughputInfoResult,
    Response = ArmResponse<PhysicalPartitionThroughputInfoResult> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PhysicalPartitionThroughputInfoResult> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB collection from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateMongoDBCollectionToAutoscale is MongoDBResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB MongoDB collection from autoscale to manual throughput
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("migrateToManualThroughput")
  migrateMongoDBCollectionToManualThroughput is MongoDBResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
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
    @minLength(3)
    @maxLength(50)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateTableThroughput is TableResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB Table from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateTableToAutoscale is TableResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB Table from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateTableToManualThroughput is TableResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
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
    @minLength(3)
    @maxLength(50)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateCassandraKeyspaceThroughput is CassandraResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra Keyspace from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateCassandraKeyspaceToAutoscale is CassandraResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra Keyspace from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateCassandraKeyspaceToManualThroughput is CassandraResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;
}
alias CassandraResourcesThroughputSettingsGetResultsOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @minLength(3)
    @maxLength(50)
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface CassandraResourcesThroughputSettingsGetResultsOperationGroup {
  /**
   * Gets the RUs per second of the Cassandra table under an existing Azure Cosmos DB database account with the provided name.
   */
  getCassandraTableThroughput is CassandraResourcesThroughputSettingsGetResultsOperationGroupOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Cassandra table
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateCassandraTableThroughput is CassandraResourcesThroughputSettingsGetResultsOperationGroupOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra table from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateCassandraTableToAutoscale is CassandraResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra table from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateCassandraTableToManualThroughput is CassandraResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;
}
alias ViewCassandraResourcesThroughputSettingsGetResultsOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @minLength(3)
    @maxLength(50)
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ViewCassandraResourcesThroughputSettingsGetResultsOperationGroup {
  /**
   * Gets the RUs per second of the Cassandra view under an existing Azure Cosmos DB database account with the provided name.
   */
  getCassandraViewThroughput is ViewCassandraResourcesThroughputSettingsGetResultsOperationGroupOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Cassandra view
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateCassandraViewThroughput is ViewCassandraResourcesThroughputSettingsGetResultsOperationGroupOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra view from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateCassandraViewToAutoscale is ViewCassandraResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB Cassandra view from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateCassandraViewToManualThroughput is ViewCassandraResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
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
    @minLength(3)
    @maxLength(50)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateGremlinDatabaseThroughput is GremlinResourceOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin database from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateGremlinDatabaseToAutoscale is GremlinResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin database from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateGremlinDatabaseToManualThroughput is GremlinResourceOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;
}
alias GremlinResourcesThroughputSettingsGetResultsOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
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
    @minLength(3)
    @maxLength(50)
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface GremlinResourcesThroughputSettingsGetResultsOperationGroup {
  /**
   * Gets the Gremlin graph throughput under an existing Azure Cosmos DB database account with the provided name.
   */
  getGremlinGraphThroughput is GremlinResourcesThroughputSettingsGetResultsOperationGroupOps.Read<ThroughputSettingsGetResults>;

  /**
   * Update RUs per second of an Azure Cosmos DB Gremlin graph
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateGremlinGraphThroughput is GremlinResourcesThroughputSettingsGetResultsOperationGroupOps.CreateOrUpdateAsync<
    ThroughputSettingsGetResults,
    Request = ThroughputSettingsUpdateParameters,
    Response = ArmResourceUpdatedResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin graph from manual throughput to autoscale
   */
  @action("migrateToAutoscale")
  migrateGremlinGraphToAutoscale is GremlinResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
  >;

  /**
   * Migrate an Azure Cosmos DB Gremlin graph from autoscale to manual throughput
   */
  @action("migrateToManualThroughput")
  migrateGremlinGraphToManualThroughput is GremlinResourcesThroughputSettingsGetResultsOperationGroupOps.ActionAsync<
    ThroughputSettingsGetResults,
    void,
    ThroughputSettingsGetResults,
    Response = ArmResponse<ThroughputSettingsGetResults> | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ThroughputSettingsGetResults> &
      Azure.Core.Foundations.RetryAfterHeader>,
    OverrideErrorType = CloudError
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
@@doc(SqlResourcesThroughputSettingsGetResultsOperationGroup.updateSqlContainerThroughput::parameters.resource,
  "The parameters to provide for the RUs per second of the current SQL container."
);
@@doc(SqlResourcesThroughputSettingsGetResultsOperationGroup.sqlContainerRetrieveThroughputDistribution::parameters.body,
  "The parameters to provide for retrieving throughput distribution for the current SQL container."
);
@@doc(SqlResourcesThroughputSettingsGetResultsOperationGroup.sqlContainerRedistributeThroughput::parameters.body,
  "The parameters to provide for redistributing throughput for the current SQL container."
);
@@doc(MongoDBResources.updateMongoDBDatabaseThroughput::parameters.resource,
  "The RUs per second of the parameters to provide for the current MongoDB database."
);
@@doc(MongoDBResources.mongoDBDatabaseRetrieveThroughputDistribution::parameters.body,
  "The parameters to provide for retrieving throughput distribution for the current MongoDB database."
);
@@doc(MongoDBResources.mongoDBDatabaseRedistributeThroughput::parameters.body,
  "The parameters to provide for redistributing throughput for the current MongoDB database."
);
@@doc(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.updateMongoDBCollectionThroughput::parameters.resource,
  "The RUs per second of the parameters to provide for the current MongoDB collection."
);
@@doc(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.mongoDBContainerRetrieveThroughputDistribution::parameters.body,
  "The parameters to provide for retrieving throughput distribution for the current MongoDB container."
);
@@doc(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.mongoDBContainerRedistributeThroughput::parameters.body,
  "The parameters to provide for redistributing throughput for the current MongoDB container."
);
@@doc(TableResources.updateTableThroughput::parameters.resource,
  "The parameters to provide for the RUs per second of the current Table."
);
@@doc(CassandraResources.updateCassandraKeyspaceThroughput::parameters.resource,
  "The RUs per second of the parameters to provide for the current Cassandra Keyspace."
);
@@doc(CassandraResourcesThroughputSettingsGetResultsOperationGroup.updateCassandraTableThroughput::parameters.resource,
  "The RUs per second of the parameters to provide for the current Cassandra table."
);
@@doc(ViewCassandraResourcesThroughputSettingsGetResultsOperationGroup.updateCassandraViewThroughput::parameters.resource,
  "The RUs per second of the parameters to provide for the current Cassandra view."
);
@@doc(GremlinResources.updateGremlinDatabaseThroughput::parameters.resource,
  "The RUs per second of the parameters to provide for the current Gremlin database."
);
@@doc(GremlinResourcesThroughputSettingsGetResultsOperationGroup.updateGremlinGraphThroughput::parameters.resource,
  "The RUs per second of the parameters to provide for the current Gremlin graph."
);
