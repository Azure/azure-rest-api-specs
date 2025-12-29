import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DocumentDB;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseAccountUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseAccountCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GraphResourceCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlDatabaseCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThroughputSettingsUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClientEncryptionKeyCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlContainerCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RetrieveThroughputParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PhysicalPartitionThroughputInfoResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RedistributeThroughputParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlStoredProcedureCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlUserDefinedFunctionCreateUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlTriggerCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoDBDatabaseCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoDBCollectionCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TableCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraKeyspaceCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraTableCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GremlinDatabaseCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GremlinGraphCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraViewCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoRoleDefinitionCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoUserDefinitionCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlRoleDefinitionCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlRoleAssignmentCreateUpdateParameters.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableSqlDatabaseGetResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableSqlContainerGetResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableMongodbDatabaseGetResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableMongodbCollectionGetResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableGremlinDatabaseGetResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableGremlinGraphGetResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableTableGetResult.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThroughputPoolUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FleetResourceUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FleetspaceUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThroughputPoolAccountCreateParameters.properties);

@@clientLocation(ChaosFaultResources.get, "ChaosFault");
@@clientLocation(ChaosFaultResources.enableDisable, "ChaosFault");
@@clientName(ChaosFaultResources.enableDisable::parameters.resource,
  "chaosFaultRequest"
);
@@clientLocation(ChaosFaultResources.list, "ChaosFault");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ChaosFaultResource.properties);

@@clientName(CopyJobs.create::parameters.resource, "jobCreateParameters");

@@clientName(DatabaseAccounts.createOrUpdate::parameters.resource,
  "createUpdateParameters"
);
@@clientName(DatabaseAccounts.update::parameters.properties,
  "updateParameters"
);
@@clientName(DatabaseAccounts.failoverPriorityChange::parameters.body,
  "failoverParameters"
);
@@clientName(DatabaseAccounts.offlineRegion::parameters.body,
  "regionParameterForOffline"
);
@@clientName(DatabaseAccounts.onlineRegion::parameters.body,
  "regionParameterForOnline"
);
@@clientName(DatabaseAccounts.regenerateKey::parameters.body,
  "keyToRegenerate"
);
@@clientLocation(DatabaseAccounts.databaseListMetrics, "Database");
@@clientName(DatabaseAccounts.databaseListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.databaseListUsages, "Database");
@@clientName(DatabaseAccounts.databaseListUsages, "ListUsages");
@@clientLocation(DatabaseAccounts.databaseListMetricDefinitions, "Database");
@@clientName(DatabaseAccounts.databaseListMetricDefinitions,
  "ListMetricDefinitions"
);
@@clientLocation(DatabaseAccounts.collectionListMetrics, "Collection");
@@clientName(DatabaseAccounts.collectionListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.collectionListUsages, "Collection");
@@clientName(DatabaseAccounts.collectionListUsages, "ListUsages");
@@clientLocation(DatabaseAccounts.collectionListMetricDefinitions,
  "Collection"
);
@@clientName(DatabaseAccounts.collectionListMetricDefinitions,
  "ListMetricDefinitions"
);
@@clientLocation(DatabaseAccounts.collectionRegionListMetrics,
  "CollectionRegion"
);
@@clientName(DatabaseAccounts.collectionRegionListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.databaseAccountRegionListMetrics,
  "DatabaseAccountRegion"
);
@@clientName(DatabaseAccounts.databaseAccountRegionListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.percentileSourceTargetListMetrics,
  "PercentileSourceTarget"
);
@@clientName(DatabaseAccounts.percentileSourceTargetListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.percentileTargetListMetrics,
  "PercentileTarget"
);
@@clientName(DatabaseAccounts.percentileTargetListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.percentileListMetrics, "Percentile");
@@clientName(DatabaseAccounts.percentileListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.collectionPartitionRegionListMetrics,
  "CollectionPartitionRegion"
);
@@clientName(DatabaseAccounts.collectionPartitionRegionListMetrics,
  "ListMetrics"
);
@@clientLocation(DatabaseAccounts.collectionPartitionListMetrics,
  "CollectionPartition"
);
@@clientName(DatabaseAccounts.collectionPartitionListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.collectionPartitionListUsages,
  "CollectionPartition"
);
@@clientName(DatabaseAccounts.collectionPartitionListUsages, "ListUsages");
@@clientLocation(DatabaseAccounts.partitionKeyRangeIdListMetrics,
  "PartitionKeyRangeId"
);
@@clientName(DatabaseAccounts.partitionKeyRangeIdListMetrics, "ListMetrics");
@@clientLocation(DatabaseAccounts.partitionKeyRangeIdRegionListMetrics,
  "PartitionKeyRangeIdRegion"
);
@@clientName(DatabaseAccounts.partitionKeyRangeIdRegionListMetrics,
  "ListMetrics"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseAccountGetResults.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(GraphResources.createUpdateGraph::parameters.resource,
  "createUpdateGraphParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GraphResourceGetResults.properties);

@@clientName(SqlResources.createUpdateSqlDatabase::parameters.resource,
  "createUpdateSqlDatabaseParameters"
);
@@clientName(SqlResources.sqlDatabasePartitionMerge::parameters.body,
  "mergeParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlDatabaseGetResults.properties);

@@clientLocation(ThroughputSettingsGetResultsOperationGroup.getSqlDatabaseThroughput,
  SqlResources
);
@@clientLocation(ThroughputSettingsGetResultsOperationGroup.updateSqlDatabaseThroughput,
  SqlResources
);
@@clientName(ThroughputSettingsGetResultsOperationGroup.updateSqlDatabaseThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(ThroughputSettingsGetResultsOperationGroup.migrateSqlDatabaseToAutoscale,
  SqlResources
);
@@clientLocation(ThroughputSettingsGetResultsOperationGroup.migrateSqlDatabaseToManualThroughput,
  SqlResources
);
@@clientLocation(ThroughputSettingsGetResultsOperationGroup.sqlDatabaseRetrieveThroughputDistribution,
  SqlResources
);
@@clientName(ThroughputSettingsGetResultsOperationGroup.sqlDatabaseRetrieveThroughputDistribution::parameters.body,
  "retrieveThroughputParameters"
);
@@clientLocation(ThroughputSettingsGetResultsOperationGroup.sqlDatabaseRedistributeThroughput,
  SqlResources
);
@@clientName(ThroughputSettingsGetResultsOperationGroup.sqlDatabaseRedistributeThroughput::parameters.body,
  "redistributeThroughputParameters"
);
@@clientLocation(SqlResourcesThroughputSettingsGetResultsOperationGroup.getSqlContainerThroughput,
  SqlResources
);
@@clientLocation(SqlResourcesThroughputSettingsGetResultsOperationGroup.updateSqlContainerThroughput,
  SqlResources
);
@@clientName(SqlResourcesThroughputSettingsGetResultsOperationGroup.updateSqlContainerThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(SqlResourcesThroughputSettingsGetResultsOperationGroup.migrateSqlContainerToAutoscale,
  SqlResources
);
@@clientLocation(SqlResourcesThroughputSettingsGetResultsOperationGroup.migrateSqlContainerToManualThroughput,
  SqlResources
);
@@clientLocation(SqlResourcesThroughputSettingsGetResultsOperationGroup.sqlContainerRetrieveThroughputDistribution,
  SqlResources
);
@@clientName(SqlResourcesThroughputSettingsGetResultsOperationGroup.sqlContainerRetrieveThroughputDistribution::parameters.body,
  "retrieveThroughputParameters"
);
@@clientLocation(SqlResourcesThroughputSettingsGetResultsOperationGroup.sqlContainerRedistributeThroughput,
  SqlResources
);
@@clientName(SqlResourcesThroughputSettingsGetResultsOperationGroup.sqlContainerRedistributeThroughput::parameters.body,
  "redistributeThroughputParameters"
);
@@clientName(MongoDBResources.updateMongoDBDatabaseThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientName(MongoDBResources.mongoDBDatabaseRetrieveThroughputDistribution::parameters.body,
  "retrieveThroughputParameters"
);
@@clientName(MongoDBResources.mongoDBDatabaseRedistributeThroughput::parameters.body,
  "redistributeThroughputParameters"
);
@@clientLocation(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.getMongoDBCollectionThroughput,
  MongoDBResources
);
@@clientLocation(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.updateMongoDBCollectionThroughput,
  MongoDBResources
);
@@clientName(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.updateMongoDBCollectionThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.mongoDBContainerRetrieveThroughputDistribution,
  MongoDBResources
);
@@clientName(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.mongoDBContainerRetrieveThroughputDistribution::parameters.body,
  "retrieveThroughputParameters"
);
@@clientLocation(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.mongoDBContainerRedistributeThroughput,
  MongoDBResources
);
@@clientName(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.mongoDBContainerRedistributeThroughput::parameters.body,
  "redistributeThroughputParameters"
);
@@clientLocation(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.migrateMongoDBCollectionToAutoscale,
  MongoDBResources
);
@@clientLocation(MongoDBResourcesThroughputSettingsGetResultsOperationGroup.migrateMongoDBCollectionToManualThroughput,
  MongoDBResources
);
@@clientName(TableResources.updateTableThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientName(CassandraResources.updateCassandraKeyspaceThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(CassandraResourcesThroughputSettingsGetResultsOperationGroup.getCassandraTableThroughput,
  CassandraResources
);
@@clientLocation(CassandraResourcesThroughputSettingsGetResultsOperationGroup.updateCassandraTableThroughput,
  CassandraResources
);
@@clientName(CassandraResourcesThroughputSettingsGetResultsOperationGroup.updateCassandraTableThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(CassandraResourcesThroughputSettingsGetResultsOperationGroup.migrateCassandraTableToAutoscale,
  CassandraResources
);
@@clientLocation(CassandraResourcesThroughputSettingsGetResultsOperationGroup.migrateCassandraTableToManualThroughput,
  CassandraResources
);
@@clientLocation(ViewCassandraResourcesThroughputSettingsGetResultsOperationGroup.getCassandraViewThroughput,
  CassandraResources
);
@@clientLocation(ViewCassandraResourcesThroughputSettingsGetResultsOperationGroup.updateCassandraViewThroughput,
  CassandraResources
);
@@clientName(ViewCassandraResourcesThroughputSettingsGetResultsOperationGroup.updateCassandraViewThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(ViewCassandraResourcesThroughputSettingsGetResultsOperationGroup.migrateCassandraViewToAutoscale,
  CassandraResources
);
@@clientLocation(ViewCassandraResourcesThroughputSettingsGetResultsOperationGroup.migrateCassandraViewToManualThroughput,
  CassandraResources
);
@@clientName(GremlinResources.updateGremlinDatabaseThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(GremlinResourcesThroughputSettingsGetResultsOperationGroup.getGremlinGraphThroughput,
  GremlinResources
);
@@clientLocation(GremlinResourcesThroughputSettingsGetResultsOperationGroup.updateGremlinGraphThroughput,
  GremlinResources
);
@@clientName(GremlinResourcesThroughputSettingsGetResultsOperationGroup.updateGremlinGraphThroughput::parameters.resource,
  "updateThroughputParameters"
);
@@clientLocation(GremlinResourcesThroughputSettingsGetResultsOperationGroup.migrateGremlinGraphToAutoscale,
  GremlinResources
);
@@clientLocation(GremlinResourcesThroughputSettingsGetResultsOperationGroup.migrateGremlinGraphToManualThroughput,
  GremlinResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThroughputSettingsGetResults.properties);

@@clientLocation(ClientEncryptionKeyGetResultsOperationGroup.getClientEncryptionKey,
  SqlResources
);
@@clientLocation(ClientEncryptionKeyGetResultsOperationGroup.createUpdateClientEncryptionKey,
  SqlResources
);
@@clientName(ClientEncryptionKeyGetResultsOperationGroup.createUpdateClientEncryptionKey::parameters.resource,
  "createUpdateClientEncryptionKeyParameters"
);
@@clientLocation(ClientEncryptionKeyGetResultsOperationGroup.listClientEncryptionKeys,
  SqlResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClientEncryptionKeyGetResults.properties);

@@clientLocation(SqlContainerGetResultsOperationGroup.getSqlContainer,
  SqlResources
);
@@clientLocation(SqlContainerGetResultsOperationGroup.createUpdateSqlContainer,
  SqlResources
);
@@clientName(SqlContainerGetResultsOperationGroup.createUpdateSqlContainer::parameters.resource,
  "createUpdateSqlContainerParameters"
);
@@clientLocation(SqlContainerGetResultsOperationGroup.deleteSqlContainer,
  SqlResources
);
@@clientLocation(SqlContainerGetResultsOperationGroup.listSqlContainers,
  SqlResources
);
@@clientLocation(SqlContainerGetResultsOperationGroup.listSqlContainerPartitionMerge,
  SqlResources
);
@@clientName(SqlContainerGetResultsOperationGroup.listSqlContainerPartitionMerge::parameters.body,
  "mergeParameters"
);
@@clientLocation(SqlContainerGetResultsOperationGroup.retrieveContinuousBackupInformation,
  SqlResources
);
@@clientName(SqlContainerGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "location"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlContainerGetResults.properties);

@@clientLocation(SqlStoredProcedureGetResultsOperationGroup.getSqlStoredProcedure,
  SqlResources
);
@@clientLocation(SqlStoredProcedureGetResultsOperationGroup.createUpdateSqlStoredProcedure,
  SqlResources
);
@@clientName(SqlStoredProcedureGetResultsOperationGroup.createUpdateSqlStoredProcedure::parameters.resource,
  "createUpdateSqlStoredProcedureParameters"
);
@@clientLocation(SqlStoredProcedureGetResultsOperationGroup.deleteSqlStoredProcedure,
  SqlResources
);
@@clientLocation(SqlStoredProcedureGetResultsOperationGroup.listSqlStoredProcedures,
  SqlResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlStoredProcedureGetResults.properties);

@@clientLocation(SqlUserDefinedFunctionGetResultsOperationGroup.getSqlUserDefinedFunction,
  SqlResources
);
@@clientLocation(SqlUserDefinedFunctionGetResultsOperationGroup.createUpdateSqlUserDefinedFunction,
  SqlResources
);
@@clientName(SqlUserDefinedFunctionGetResultsOperationGroup.createUpdateSqlUserDefinedFunction::parameters.resource,
  "createUpdateSqlUserDefinedFunctionParameters"
);
@@clientLocation(SqlUserDefinedFunctionGetResultsOperationGroup.deleteSqlUserDefinedFunction,
  SqlResources
);
@@clientLocation(SqlUserDefinedFunctionGetResultsOperationGroup.listSqlUserDefinedFunctions,
  SqlResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlUserDefinedFunctionGetResults.properties);

@@clientLocation(SqlTriggerGetResultsOperationGroup.getSqlTrigger,
  SqlResources
);
@@clientLocation(SqlTriggerGetResultsOperationGroup.createUpdateSqlTrigger,
  SqlResources
);
@@clientName(SqlTriggerGetResultsOperationGroup.createUpdateSqlTrigger::parameters.resource,
  "createUpdateSqlTriggerParameters"
);
@@clientLocation(SqlTriggerGetResultsOperationGroup.deleteSqlTrigger,
  SqlResources
);
@@clientLocation(SqlTriggerGetResultsOperationGroup.listSqlTriggers,
  SqlResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlTriggerGetResults.properties);

@@clientLocation(MongoDBDatabaseGetResultsOperationGroup.getMongoDBDatabase,
  MongoDBResources
);
@@clientLocation(MongoDBDatabaseGetResultsOperationGroup.createUpdateMongoDBDatabase,
  MongoDBResources
);
@@clientName(MongoDBDatabaseGetResultsOperationGroup.createUpdateMongoDBDatabase::parameters.resource,
  "createUpdateMongoDBDatabaseParameters"
);
@@clientLocation(MongoDBDatabaseGetResultsOperationGroup.deleteMongoDBDatabase,
  MongoDBResources
);
@@clientLocation(MongoDBDatabaseGetResultsOperationGroup.listMongoDBDatabases,
  MongoDBResources
);
@@clientLocation(MongoDBDatabaseGetResultsOperationGroup.mongoDBDatabasePartitionMerge,
  MongoDBResources
);
@@clientName(MongoDBDatabaseGetResultsOperationGroup.mongoDBDatabasePartitionMerge::parameters.body,
  "mergeParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoDBDatabaseGetResults.properties);

@@clientLocation(MongoDBCollectionGetResultsOperationGroup.getMongoDBCollection,
  MongoDBResources
);
@@clientLocation(MongoDBCollectionGetResultsOperationGroup.createUpdateMongoDBCollection,
  MongoDBResources
);
@@clientName(MongoDBCollectionGetResultsOperationGroup.createUpdateMongoDBCollection::parameters.resource,
  "createUpdateMongoDBCollectionParameters"
);
@@clientLocation(MongoDBCollectionGetResultsOperationGroup.deleteMongoDBCollection,
  MongoDBResources
);
@@clientLocation(MongoDBCollectionGetResultsOperationGroup.listMongoDBCollections,
  MongoDBResources
);
@@clientLocation(MongoDBCollectionGetResultsOperationGroup.listMongoDBCollectionPartitionMerge,
  MongoDBResources
);
@@clientName(MongoDBCollectionGetResultsOperationGroup.listMongoDBCollectionPartitionMerge::parameters.body,
  "mergeParameters"
);
@@clientLocation(MongoDBCollectionGetResultsOperationGroup.retrieveContinuousBackupInformation,
  MongoDBResources
);
@@clientName(MongoDBCollectionGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "location"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoDBCollectionGetResults.properties);

@@clientLocation(TableGetResultsOperationGroup.getTable, TableResources);
@@clientLocation(TableGetResultsOperationGroup.createUpdateTable,
  TableResources
);
@@clientName(TableGetResultsOperationGroup.createUpdateTable::parameters.resource,
  "createUpdateTableParameters"
);
@@clientLocation(TableGetResultsOperationGroup.deleteTable, TableResources);
@@clientLocation(TableGetResultsOperationGroup.listTables, TableResources);
@@clientLocation(TableGetResultsOperationGroup.retrieveContinuousBackupInformation,
  TableResources
);
@@clientName(TableGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "location"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TableGetResults.properties);

@@clientLocation(CassandraKeyspaceGetResultsOperationGroup.getCassandraKeyspace,
  CassandraResources
);
@@clientLocation(CassandraKeyspaceGetResultsOperationGroup.createUpdateCassandraKeyspace,
  CassandraResources
);
@@clientName(CassandraKeyspaceGetResultsOperationGroup.createUpdateCassandraKeyspace::parameters.resource,
  "createUpdateCassandraKeyspaceParameters"
);
@@clientLocation(CassandraKeyspaceGetResultsOperationGroup.deleteCassandraKeyspace,
  CassandraResources
);
@@clientLocation(CassandraKeyspaceGetResultsOperationGroup.listCassandraKeyspaces,
  CassandraResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraKeyspaceGetResults.properties);

@@clientLocation(CassandraTableGetResultsOperationGroup.getCassandraTable,
  CassandraResources
);
@@clientLocation(CassandraTableGetResultsOperationGroup.createUpdateCassandraTable,
  CassandraResources
);
@@clientName(CassandraTableGetResultsOperationGroup.createUpdateCassandraTable::parameters.resource,
  "createUpdateCassandraTableParameters"
);
@@clientLocation(CassandraTableGetResultsOperationGroup.deleteCassandraTable,
  CassandraResources
);
@@clientLocation(CassandraTableGetResultsOperationGroup.listCassandraTables,
  CassandraResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraTableGetResults.properties);

@@clientLocation(GremlinDatabaseGetResultsOperationGroup.getGremlinDatabase,
  GremlinResources
);
@@clientLocation(GremlinDatabaseGetResultsOperationGroup.createUpdateGremlinDatabase,
  GremlinResources
);
@@clientName(GremlinDatabaseGetResultsOperationGroup.createUpdateGremlinDatabase::parameters.resource,
  "createUpdateGremlinDatabaseParameters"
);
@@clientLocation(GremlinDatabaseGetResultsOperationGroup.deleteGremlinDatabase,
  GremlinResources
);
@@clientLocation(GremlinDatabaseGetResultsOperationGroup.listGremlinDatabases,
  GremlinResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GremlinDatabaseGetResults.properties);

@@clientLocation(GremlinGraphGetResultsOperationGroup.getGremlinGraph,
  GremlinResources
);
@@clientLocation(GremlinGraphGetResultsOperationGroup.createUpdateGremlinGraph,
  GremlinResources
);
@@clientName(GremlinGraphGetResultsOperationGroup.createUpdateGremlinGraph::parameters.resource,
  "createUpdateGremlinGraphParameters"
);
@@clientLocation(GremlinGraphGetResultsOperationGroup.deleteGremlinGraph,
  GremlinResources
);
@@clientLocation(GremlinGraphGetResultsOperationGroup.listGremlinGraphs,
  GremlinResources
);
@@clientLocation(GremlinGraphGetResultsOperationGroup.retrieveContinuousBackupInformation,
  GremlinResources
);
@@clientName(GremlinGraphGetResultsOperationGroup.retrieveContinuousBackupInformation::parameters.body,
  "location"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GremlinGraphGetResults.properties);

@@clientLocation(LocationGetResults.get, "Locations");
@@clientLocation(LocationGetResults.list, "Locations");

@@clientLocation(CassandraViewGetResultsOperationGroup.getCassandraView,
  CassandraResources
);
@@clientLocation(CassandraViewGetResultsOperationGroup.createUpdateCassandraView,
  CassandraResources
);
@@clientName(CassandraViewGetResultsOperationGroup.createUpdateCassandraView::parameters.resource,
  "createUpdateCassandraViewParameters"
);
@@clientLocation(CassandraViewGetResultsOperationGroup.deleteCassandraView,
  CassandraResources
);
@@clientLocation(CassandraViewGetResultsOperationGroup.listCassandraViews,
  CassandraResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraViewGetResults.properties);

@@clientName(DataTransferJobs.create::parameters.resource,
  "jobCreateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DataTransferJobGetResults.properties);

@@clientLocation(ClusterResources.get, "CassandraClusters");
@@clientLocation(ClusterResources.createUpdate, "CassandraClusters");
@@clientName(ClusterResources.createUpdate::parameters.resource, "body");
@@clientLocation(ClusterResources.update, "CassandraClusters");
@@clientName(ClusterResources.update::parameters.properties, "body");
@@clientLocation(ClusterResources.delete, "CassandraClusters");
@@clientLocation(ClusterResources.listByResourceGroup, "CassandraClusters");
@@clientLocation(ClusterResources.listBySubscription, "CassandraClusters");
@@clientLocation(ClusterResources.invokeCommand, "CassandraClusters");
@@clientLocation(ClusterResources.invokeCommandAsync, "CassandraClusters");
@@clientLocation(ClusterResources.listCommand, "CassandraClusters");
@@clientLocation(ClusterResources.getCommandAsync, "CassandraClusters");
@@clientLocation(ClusterResources.listBackups, "CassandraClusters");
@@clientLocation(ClusterResources.getBackup, "CassandraClusters");
@@clientLocation(ClusterResources.deallocate, "CassandraClusters");
@@clientLocation(ClusterResources.start, "CassandraClusters");
@@clientLocation(ClusterResources.status, "CassandraClusters");

@@clientLocation(DataCenterResources.get, "CassandraDataCenters");
@@clientLocation(DataCenterResources.createUpdate, "CassandraDataCenters");
@@clientName(DataCenterResources.createUpdate::parameters.resource, "body");
@@clientLocation(DataCenterResources.update, "CassandraDataCenters");
@@clientName(DataCenterResources.update::parameters.properties, "body");
@@clientLocation(DataCenterResources.delete, "CassandraDataCenters");
@@clientLocation(DataCenterResources.list, "CassandraDataCenters");

@@clientLocation(MongoRoleDefinitionGetResultsOperationGroup.getMongoRoleDefinition,
  MongoDBResources
);
@@clientLocation(MongoRoleDefinitionGetResultsOperationGroup.createUpdateMongoRoleDefinition,
  MongoDBResources
);
@@clientName(MongoRoleDefinitionGetResultsOperationGroup.createUpdateMongoRoleDefinition::parameters.resource,
  "createUpdateMongoRoleDefinitionParameters"
);
@@clientLocation(MongoRoleDefinitionGetResultsOperationGroup.deleteMongoRoleDefinition,
  MongoDBResources
);
@@clientLocation(MongoRoleDefinitionGetResultsOperationGroup.listMongoRoleDefinitions,
  MongoDBResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoRoleDefinitionGetResults.properties);

@@clientLocation(MongoUserDefinitionGetResultsOperationGroup.getMongoUserDefinition,
  MongoDBResources
);
@@clientLocation(MongoUserDefinitionGetResultsOperationGroup.createUpdateMongoUserDefinition,
  MongoDBResources
);
@@clientName(MongoUserDefinitionGetResultsOperationGroup.createUpdateMongoUserDefinition::parameters.resource,
  "createUpdateMongoUserDefinitionParameters"
);
@@clientLocation(MongoUserDefinitionGetResultsOperationGroup.deleteMongoUserDefinition,
  MongoDBResources
);
@@clientLocation(MongoUserDefinitionGetResultsOperationGroup.listMongoUserDefinitions,
  MongoDBResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoUserDefinitionGetResults.properties);

@@clientName(NotebookWorkspaces.createOrUpdate::parameters.resource,
  "notebookCreateUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NotebookWorkspace.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientLocation(SqlRoleDefinitionGetResultsOperationGroup.getSqlRoleDefinition,
  SqlResources
);
@@clientLocation(SqlRoleDefinitionGetResultsOperationGroup.createUpdateSqlRoleDefinition,
  SqlResources
);
@@clientName(SqlRoleDefinitionGetResultsOperationGroup.createUpdateSqlRoleDefinition::parameters.resource,
  "createUpdateSqlRoleDefinitionParameters"
);
@@clientLocation(SqlRoleDefinitionGetResultsOperationGroup.deleteSqlRoleDefinition,
  SqlResources
);
@@clientLocation(SqlRoleDefinitionGetResultsOperationGroup.listSqlRoleDefinitions,
  SqlResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlRoleDefinitionGetResults.properties);

@@clientLocation(SqlRoleAssignmentGetResultsOperationGroup.getSqlRoleAssignment,
  SqlResources
);
@@clientLocation(SqlRoleAssignmentGetResultsOperationGroup.createUpdateSqlRoleAssignment,
  SqlResources
);
@@clientName(SqlRoleAssignmentGetResultsOperationGroup.createUpdateSqlRoleAssignment::parameters.resource,
  "createUpdateSqlRoleAssignmentParameters"
);
@@clientLocation(SqlRoleAssignmentGetResultsOperationGroup.deleteSqlRoleAssignment,
  SqlResources
);
@@clientLocation(SqlRoleAssignmentGetResultsOperationGroup.listSqlRoleAssignments,
  SqlResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SqlRoleAssignmentGetResults.properties);

@@clientLocation(RestorableDatabaseAccountGetResults.getByLocation,
  "RestorableDatabaseAccounts"
);
@@clientLocation(RestorableDatabaseAccountGetResults.listByLocation,
  "RestorableDatabaseAccounts"
);
@@clientLocation(RestorableDatabaseAccountGetResults.list,
  "RestorableSqlDatabases"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableSqlContainersList,
  "RestorableSqlContainers"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableSqlContainersList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableSqlResourcesList,
  "RestorableSqlResources"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableSqlResourcesList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableMongodbDatabasesList,
  "RestorableMongodbDatabases"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableMongodbDatabasesList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableMongodbCollectionsList,
  "RestorableMongodbCollections"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableMongodbCollectionsList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableMongodbResourcesList,
  "RestorableMongodbResources"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableMongodbResourcesList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableGremlinDatabasesList,
  "RestorableGremlinDatabases"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableGremlinDatabasesList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableGremlinGraphsList,
  "RestorableGremlinGraphs"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableGremlinGraphsList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableGremlinResourcesList,
  "RestorableGremlinResources"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableGremlinResourcesList,
  "List"
);
@@clientLocation(RestorableDatabaseAccountGetResults.restorableTablesList,
  "RestorableTables"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableTablesList, "List");
@@clientLocation(RestorableDatabaseAccountGetResults.restorableTableResourcesList,
  "RestorableTableResources"
);
@@clientName(RestorableDatabaseAccountGetResults.restorableTableResourcesList,
  "List"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestorableDatabaseAccountGetResult.properties);

@@clientLocation(ServiceResources.get, "Service");
@@clientLocation(ServiceResources.create, "Service");
@@clientName(ServiceResources.create::parameters.resource,
  "createUpdateParameters"
);
@@clientLocation(ServiceResources.delete, "Service");
@@clientLocation(ServiceResources.list, "Service");

@@clientLocation(TableRoleDefinitionResources.getTableRoleDefinition,
  TableResources
);
@@clientLocation(TableRoleDefinitionResources.createUpdateTableRoleDefinition,
  TableResources
);
@@clientName(TableRoleDefinitionResources.createUpdateTableRoleDefinition::parameters.resource,
  "createUpdateTableRoleDefinitionParameters"
);
@@clientLocation(TableRoleDefinitionResources.deleteTableRoleDefinition,
  TableResources
);
@@clientLocation(TableRoleDefinitionResources.listTableRoleDefinitions,
  TableResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TableRoleDefinitionResource.properties);

@@clientLocation(TableRoleAssignmentResources.getTableRoleAssignment,
  TableResources
);
@@clientLocation(TableRoleAssignmentResources.createUpdateTableRoleAssignment,
  TableResources
);
@@clientName(TableRoleAssignmentResources.createUpdateTableRoleAssignment::parameters.resource,
  "createUpdateTableRoleAssignmentParameters"
);
@@clientLocation(TableRoleAssignmentResources.deleteTableRoleAssignment,
  TableResources
);
@@clientLocation(TableRoleAssignmentResources.listTableRoleAssignments,
  TableResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TableRoleAssignmentResource.properties);

@@clientLocation(ThroughputPoolResources.get, "ThroughputPool");
@@clientLocation(ThroughputPoolResources.createOrUpdate, "ThroughputPool");
@@clientName(ThroughputPoolResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ThroughputPoolResources.update, "ThroughputPool");
@@clientName(ThroughputPoolResources.update::parameters.properties, "body");
@@clientLocation(ThroughputPoolResources.delete, "ThroughputPool");
@@clientLocation(ThroughputPoolResources.listByResourceGroup,
  "ThroughputPools"
);
@@clientLocation(ThroughputPoolResources.list, "ThroughputPools");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThroughputPoolResource.properties);

@@clientLocation(ThroughputPoolAccountResources.get, "ThroughputPoolAccount");
@@clientLocation(ThroughputPoolAccountResources.create,
  "ThroughputPoolAccount"
);
@@clientName(ThroughputPoolAccountResources.create::parameters.resource,
  "body"
);
@@clientLocation(ThroughputPoolAccountResources.delete,
  "ThroughputPoolAccount"
);
@@clientLocation(ThroughputPoolAccountResources.list, "ThroughputPoolAccounts");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThroughputPoolAccountResource.properties);

@@clientLocation(CassandraRoleDefinitionResources.getCassandraRoleDefinition,
  CassandraResources
);
@@clientLocation(CassandraRoleDefinitionResources.createUpdateCassandraRoleDefinition,
  CassandraResources
);
@@clientName(CassandraRoleDefinitionResources.createUpdateCassandraRoleDefinition::parameters.resource,
  "createUpdateCassandraRoleDefinitionParameters"
);
@@clientLocation(CassandraRoleDefinitionResources.deleteCassandraRoleDefinition,
  CassandraResources
);
@@clientLocation(CassandraRoleDefinitionResources.listCassandraRoleDefinitions,
  CassandraResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraRoleDefinitionResource.properties);

@@clientLocation(CassandraRoleAssignmentResources.getCassandraRoleAssignment,
  CassandraResources
);
@@clientLocation(CassandraRoleAssignmentResources.createUpdateCassandraRoleAssignment,
  CassandraResources
);
@@clientName(CassandraRoleAssignmentResources.createUpdateCassandraRoleAssignment::parameters.resource,
  "createUpdateCassandraRoleAssignmentParameters"
);
@@clientLocation(CassandraRoleAssignmentResources.deleteCassandraRoleAssignment,
  CassandraResources
);
@@clientLocation(CassandraRoleAssignmentResources.listCassandraRoleAssignments,
  CassandraResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CassandraRoleAssignmentResource.properties);

@@clientLocation(MongoMIRoleDefinitionResources.getMongoMIRoleDefinition,
  "MongoMIResources"
);
@@clientLocation(MongoMIRoleDefinitionResources.createUpdateMongoMIRoleDefinition,
  "MongoMIResources"
);
@@clientName(MongoMIRoleDefinitionResources.createUpdateMongoMIRoleDefinition::parameters.resource,
  "createUpdateMongoMIRoleDefinitionParameters"
);
@@clientLocation(MongoMIRoleDefinitionResources.deleteMongoMIRoleDefinition,
  "MongoMIResources"
);
@@clientLocation(MongoMIRoleDefinitionResources.listMongoMIRoleDefinitions,
  "MongoMIResources"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoMIRoleDefinitionResource.properties);

@@clientLocation(MongoMIRoleAssignmentResources.getMongoMIRoleAssignment,
  "MongoMIResources"
);
@@clientLocation(MongoMIRoleAssignmentResources.createUpdateMongoMIRoleAssignment,
  "MongoMIResources"
);
@@clientName(MongoMIRoleAssignmentResources.createUpdateMongoMIRoleAssignment::parameters.resource,
  "createUpdateMongoMIRoleAssignmentParameters"
);
@@clientLocation(MongoMIRoleAssignmentResources.deleteMongoMIRoleAssignment,
  "MongoMIResources"
);
@@clientLocation(MongoMIRoleAssignmentResources.listMongoMIRoleAssignments,
  "MongoMIResources"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MongoMIRoleAssignmentResource.properties);

@@clientLocation(GremlinRoleDefinitionResources.getGremlinRoleDefinition,
  GremlinResources
);
@@clientLocation(GremlinRoleDefinitionResources.createUpdateGremlinRoleDefinition,
  GremlinResources
);
@@clientName(GremlinRoleDefinitionResources.createUpdateGremlinRoleDefinition::parameters.resource,
  "createUpdateGremlinRoleDefinitionParameters"
);
@@clientLocation(GremlinRoleDefinitionResources.deleteGremlinRoleDefinition,
  GremlinResources
);
@@clientLocation(GremlinRoleDefinitionResources.listGremlinRoleDefinitions,
  GremlinResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GremlinRoleDefinitionResource.properties);

@@clientLocation(GremlinRoleAssignmentResources.getGremlinRoleAssignment,
  GremlinResources
);
@@clientLocation(GremlinRoleAssignmentResources.createUpdateGremlinRoleAssignment,
  GremlinResources
);
@@clientName(GremlinRoleAssignmentResources.createUpdateGremlinRoleAssignment::parameters.resource,
  "createUpdateGremlinRoleAssignmentParameters"
);
@@clientLocation(GremlinRoleAssignmentResources.deleteGremlinRoleAssignment,
  GremlinResources
);
@@clientLocation(GremlinRoleAssignmentResources.listGremlinRoleAssignments,
  GremlinResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GremlinRoleAssignmentResource.properties);

@@clientLocation(FleetResources.get, "Fleet");
@@clientLocation(FleetResources.create, "Fleet");
@@clientName(FleetResources.create::parameters.resource, "body");
@@clientLocation(FleetResources.update, "Fleet");
@@clientName(FleetResources.update::parameters.properties, "body");
@@clientLocation(FleetResources.delete, "Fleet");
@@clientLocation(FleetResources.listByResourceGroup, "Fleet");
@@clientLocation(FleetResources.list, "Fleet");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FleetResource.properties);

@@clientLocation(FleetAnalyticsResources.get, "FleetAnalytics");
@@clientLocation(FleetAnalyticsResources.create, "FleetAnalytics");
@@clientName(FleetAnalyticsResources.create::parameters.resource, "body");
@@clientLocation(FleetAnalyticsResources.delete, "FleetAnalytics");
@@clientLocation(FleetAnalyticsResources.list, "FleetAnalytics");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FleetAnalyticsResource.properties);

@@clientLocation(FleetspaceResources.get, "Fleetspace");
@@clientLocation(FleetspaceResources.create, "Fleetspace");
@@clientName(FleetspaceResources.create::parameters.resource, "body");
@@clientLocation(FleetspaceResources.update, "Fleetspace");
@@clientName(FleetspaceResources.update::parameters.properties, "body");
@@clientLocation(FleetspaceResources.delete, "Fleetspace");
@@clientLocation(FleetspaceResources.list, "Fleetspace");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FleetspaceResource.properties);

@@clientLocation(FleetspaceAccountResources.get, "FleetspaceAccount");
@@clientLocation(FleetspaceAccountResources.create, "FleetspaceAccount");
@@clientName(FleetspaceAccountResources.create::parameters.resource, "body");
@@clientLocation(FleetspaceAccountResources.delete, "FleetspaceAccount");
@@clientLocation(FleetspaceAccountResources.list, "FleetspaceAccount");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FleetspaceAccountResource.properties);

@@clientLocation(DatabaseAccountsOperationGroup.checkNameExists,
  DatabaseAccounts
);

@@clientLocation(RestorableDatabaseAccountsOperationGroup.list,
  "RestorableDatabaseAccounts"
);
