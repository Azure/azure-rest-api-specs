import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataFactory;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudError.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FactoryUpdateParameters.properties);

@@clientName(LinkedIntegrationRuntimeRequest.factoryName, "linkedFactoryName");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MapperTable.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MappingDataFlow.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Flowlet.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WranglingDataFlow.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonS3Dataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AvroDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExcelDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ParquetDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DelimitedTextDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JsonDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(XmlDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OrcDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BinaryDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IcebergDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureBlobDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSqlTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSqlMITableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSqlDWTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CassandraTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CustomDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CosmosDbSqlApiCollectionDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DocumentDbCollectionDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DynamicsEntityDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DynamicsCrmEntityDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CommonDataServiceForAppsEntityDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDataLakeStoreDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureBlobFSDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Office365Dataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FileShareDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MongoDbCollectionDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MongoDbAtlasCollectionDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MongoDbV2CollectionDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CosmosDbMongoDbApiCollectionDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ODataResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OracleTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonRdsForOracleTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TeradataTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMySqlTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonRedshiftTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Db2TableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RelationalTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InformixTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OdbcTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MySqlTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PostgreSqlTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PostgreSqlV2TableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftAccessTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceServiceCloudObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SybaseTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapCloudForCustomerResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapEccResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapHanaTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapOpenHubTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlServerTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonRdsForSqlServerTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RestResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapTableResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapOdpResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSearchIndexDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HttpDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonMWSObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzurePostgreSqlTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ConcurObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CouchbaseTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DrillTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EloquaObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleBigQueryObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleBigQueryV2ObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GreenplumTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HBaseObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HiveObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HubspotObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImpalaObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JiraObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MagentoObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MariaDBTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMariaDBTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MarketoObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PaypalObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PhoenixObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrestoObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(QuickBooksObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServiceNowObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ShopifyObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SparkObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SquareObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(XeroObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ZohoObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetezzaTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VerticaTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceMarketingCloudObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ResponsysObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DynamicsAXResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OracleServiceCloudObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDataExplorerTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleAdWordsObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SnowflakeDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SnowflakeV2Dataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SharePointOnlineListResourceDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDatabricksDeltaLakeDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LakeHouseTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceV2ObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceServiceCloudV2ObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WarehouseTableDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServiceNowV2ObjectDataset.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedIntegrationRuntime.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CmdkeySetup.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EnvironmentVariableSetup.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ComponentSetup.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzPowerShellSetup.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SelfHostedIntegrationRuntime.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedIntegrationRuntimeStatus.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SelfHostedIntegrationRuntimeStatus.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureStorageLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureBlobStorageLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureTableStorageLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSqlDWLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlServerLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonRdsForSqlServerLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSqlDatabaseLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSqlMILinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureBatchLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureKeyVaultLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CosmosDbLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DynamicsLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DynamicsCrmLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CommonDataServiceForAppsLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HDInsightLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FileServerLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureFileStorageLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonS3CompatibleLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OracleCloudStorageLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleCloudStorageLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OracleLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonRdsForOracleLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMySqlLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MySqlLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PostgreSqlLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PostgreSqlV2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SybaseLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Db2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TeradataLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMLLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMLServiceLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OdbcLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(InformixLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftAccessLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HdfsLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ODataLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CassandraLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MongoDbLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MongoDbAtlasLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MongoDbV2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CosmosDbMongoDbApiLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDataLakeStoreLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureBlobFSLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Office365LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceServiceCloudLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapCloudForCustomerLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapEccLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapOpenHubLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapOdpLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RestServiceLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TeamDeskLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(QuickbaseLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SmartsheetLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ZendeskLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataworldLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AppFiguresLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AsanaLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TwilioLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleSheetsLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonS3LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonRedshiftLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CustomDataSourceLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSearchLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HttpLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FtpServerLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SftpServerLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapBWLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapHanaLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AmazonMWSLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzurePostgreSqlLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ConcurLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CouchbaseLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DrillLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EloquaLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleBigQueryLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleBigQueryV2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GreenplumLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HBaseLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HiveLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HubspotLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImpalaLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JiraLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MagentoLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MariaDBLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMariaDBLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MarketoLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PaypalLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PhoenixLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrestoLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(QuickBooksLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServiceNowLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ShopifyLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SparkLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SquareLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(XeroLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ZohoLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(VerticaLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NetezzaLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceMarketingCloudLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HDInsightOnDemandLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDataLakeAnalyticsLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDatabricksLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDatabricksDeltaLakeLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ResponsysLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DynamicsAXLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OracleServiceCloudLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GoogleAdWordsLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapTableLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDataExplorerLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureFunctionLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SnowflakeLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SnowflakeV2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SharePointOnlineListLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureSynapseArtifactsLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LakeHouseLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceV2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SalesforceServiceCloudV2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WarehouseLinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServiceNowV2LinkedService.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CopyActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HDInsightHiveActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HDInsightPigActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HDInsightMapReduceActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HDInsightStreamingActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HDInsightSparkActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExecuteSsisPackageActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SsisPackageLocation.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SsisLogLocation.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CustomActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SqlServerStoredProcedureActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExecutePipelineActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DeleteActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureDataExplorerCommandActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LookupActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GetMetadataActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IfConditionActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SwitchActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ForEachActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMLBatchExecutionActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMLUpdateResourceActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureMLExecutePipelineActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DataLakeAnalyticsUsqlActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WaitActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FailActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UntilActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ValidationActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FilterActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DatabricksNotebookActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DatabricksSparkJarActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DatabricksSparkPythonActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DatabricksJobActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SetVariableActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AppendVariableActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureFunctionActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WebHookActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExecuteDataFlowActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExecuteWranglingDataflowActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScriptActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SynapseNotebookActivity.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SynapseSparkJobDefinitionActivity.typeProperties);

@@clientName(SynapseSparkJobActivityTypeProperties.args, "arguments");

@@clientName(SalesforceV2Source.SOQLQuery, "soqlQuery");

@@clientName(SalesforceServiceCloudV2Source.SOQLQuery, "soqlQuery");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduleTrigger.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BlobTrigger.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BlobEventsTrigger.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CustomEventsTrigger.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TumblingWindowTrigger.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RerunTumblingWindowTrigger.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ChainingTrigger.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ServicePrincipalCredential.typeProperties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedIdentityCredential.typeProperties);

@@clientName(Factories.createOrUpdate::parameters.resource, "factory");
@@clientName(Factories.update::parameters.properties,
  "factoryUpdateParameters"
);
@@clientName(Factories.getGitHubAccessToken::parameters.body,
  "gitHubAccessTokenRequest"
);
@@clientName(Factories.getDataPlaneAccess::parameters.body, "policy");
@@clientLocation(Factories.getFeatureValueByFactory, "ExposureControl");
@@clientName(Factories.getFeatureValueByFactory::parameters.body,
  "exposureControlRequest"
);
@@clientLocation(Factories.queryFeatureValuesByFactory, "ExposureControl");
@@clientName(Factories.queryFeatureValuesByFactory::parameters.body,
  "exposureControlBatchRequest"
);
@@clientLocation(Factories.queryByFactory, "PipelineRuns");
@@clientName(Factories.queryByFactory::parameters.body, "filterParameters");
@@clientLocation(Factories.pipelineRunsGet, "PipelineRuns");
@@clientName(Factories.pipelineRunsGet, "Get");
@@clientLocation(Factories.cancel, "PipelineRuns");
@@clientLocation(Factories.queryByPipelineRun, "ActivityRuns");
@@clientName(Factories.queryByPipelineRun::parameters.body, "filterParameters");
@@clientLocation(Factories.triggersQueryByFactory, "Triggers");
@@clientName(Factories.triggersQueryByFactory, "QueryByFactory");
@@clientName(Factories.triggersQueryByFactory::parameters.body,
  "filterParameters"
);
@@clientLocation(Factories.triggerRunsQueryByFactory, "TriggerRuns");
@@clientName(Factories.triggerRunsQueryByFactory, "QueryByFactory");
@@clientName(Factories.triggerRunsQueryByFactory::parameters.body,
  "filterParameters"
);
@@clientLocation(Factories.create, "DataFlowDebugSession");
@@clientName(Factories.create::parameters.body, "request");
@@clientLocation(Factories.dataFlowDebugSessionQueryByFactory,
  "DataFlowDebugSession"
);
@@clientName(Factories.dataFlowDebugSessionQueryByFactory, "QueryByFactory");
@@clientLocation(Factories.addDataFlow, "DataFlowDebugSession");
@@clientName(Factories.addDataFlow::parameters.body, "request");
@@clientLocation(Factories.dataFlowDebugSessionDelete, "DataFlowDebugSession");
@@clientName(Factories.dataFlowDebugSessionDelete, "Delete");
@@clientName(Factories.dataFlowDebugSessionDelete::parameters.body, "request");
@@clientLocation(Factories.executeCommand, "DataFlowDebugSession");
@@clientName(Factories.executeCommand::parameters.body, "request");
@@clientLocation(Factories.privateLinkResourcesGet, "privateLinkResources");
@@clientName(Factories.privateLinkResourcesGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Factory.properties);

@@clientLocation(IntegrationRuntimeResources.get, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.createOrUpdate,
  "IntegrationRuntimes"
);
@@clientName(IntegrationRuntimeResources.createOrUpdate::parameters.resource,
  "integrationRuntime"
);
@@clientLocation(IntegrationRuntimeResources.update, "IntegrationRuntimes");
@@clientName(IntegrationRuntimeResources.update::parameters.properties,
  "updateIntegrationRuntimeRequest"
);
@@clientLocation(IntegrationRuntimeResources.delete, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.listByFactory,
  "IntegrationRuntimes"
);
@@clientLocation(IntegrationRuntimeResources.getStatus, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.listOutboundNetworkDependenciesEndpoints,
  "IntegrationRuntimes"
);
@@clientLocation(IntegrationRuntimeResources.getConnectionInfo,
  "IntegrationRuntimes"
);
@@clientLocation(IntegrationRuntimeResources.regenerateAuthKey,
  "IntegrationRuntimes"
);
@@clientName(IntegrationRuntimeResources.regenerateAuthKey::parameters.body,
  "regenerateKeyParameters"
);
@@clientLocation(IntegrationRuntimeResources.listAuthKeys,
  "IntegrationRuntimes"
);
@@clientLocation(IntegrationRuntimeResources.start, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.stop, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.syncCredentials,
  "IntegrationRuntimes"
);
@@clientLocation(IntegrationRuntimeResources.getMonitoringData,
  "IntegrationRuntimes"
);
@@clientLocation(IntegrationRuntimeResources.upgrade, "IntegrationRuntimes");
@@clientLocation(IntegrationRuntimeResources.removeLinks,
  "IntegrationRuntimes"
);
@@clientName(IntegrationRuntimeResources.removeLinks::parameters.body,
  "linkedIntegrationRuntimeRequest"
);
@@clientLocation(IntegrationRuntimeResources.createLinkedIntegrationRuntime,
  "IntegrationRuntimes"
);
@@clientName(IntegrationRuntimeResources.createLinkedIntegrationRuntime::parameters.body,
  "createLinkedIntegrationRuntimeRequest"
);
@@clientLocation(IntegrationRuntimeResources.refresh,
  "IntegrationRuntimeObjectMetadata"
);
@@clientLocation(IntegrationRuntimeResources.integrationRuntimeObjectMetadataGet,
  "IntegrationRuntimeObjectMetadata"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeObjectMetadataGet,
  "Get"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeObjectMetadataGet::parameters.body,
  "getMetadataRequest"
);
@@clientLocation(IntegrationRuntimeResources.integrationRuntimeNodesGet,
  "IntegrationRuntimeNodes"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeNodesGet, "Get");
@@clientLocation(IntegrationRuntimeResources.integrationRuntimeNodesDelete,
  "IntegrationRuntimeNodes"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeNodesDelete,
  "Delete"
);
@@clientLocation(IntegrationRuntimeResources.integrationRuntimeNodesUpdate,
  "IntegrationRuntimeNodes"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeNodesUpdate,
  "Update"
);
@@clientName(IntegrationRuntimeResources.integrationRuntimeNodesUpdate::parameters.body,
  "updateIntegrationRuntimeNodeRequest"
);
@@clientLocation(IntegrationRuntimeResources.getIpAddress,
  "IntegrationRuntimeNodes"
);
@@clientLocation(IntegrationRuntimeResources.enableInteractiveQuery,
  "IntegrationRuntime"
);
@@clientName(IntegrationRuntimeResources.enableInteractiveQuery::parameters.body,
  "enableInteractiveQueryRequest"
);
@@clientLocation(IntegrationRuntimeResources.disableInteractiveQuery,
  "IntegrationRuntime"
);

@@clientLocation(LinkedServiceResources.get, "LinkedServices");
@@clientLocation(LinkedServiceResources.createOrUpdate, "LinkedServices");
@@clientName(LinkedServiceResources.createOrUpdate::parameters.resource,
  "linkedService"
);
@@clientLocation(LinkedServiceResources.delete, "LinkedServices");
@@clientLocation(LinkedServiceResources.listByFactory, "LinkedServices");

@@clientLocation(DatasetResources.get, "Datasets");
@@clientLocation(DatasetResources.createOrUpdate, "Datasets");
@@clientName(DatasetResources.createOrUpdate::parameters.resource, "dataset");
@@clientLocation(DatasetResources.delete, "Datasets");
@@clientLocation(DatasetResources.listByFactory, "Datasets");

@@clientLocation(PipelineResources.get, "Pipelines");
@@clientLocation(PipelineResources.createOrUpdate, "Pipelines");
@@clientName(PipelineResources.createOrUpdate::parameters.resource, "pipeline");
@@clientLocation(PipelineResources.delete, "Pipelines");
@@clientLocation(PipelineResources.listByFactory, "Pipelines");
@@clientLocation(PipelineResources.createRun, "Pipelines");
@@clientName(PipelineResources.createRun::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PipelineResource.properties);

@@clientLocation(TriggerResources.get, "Triggers");
@@clientLocation(TriggerResources.createOrUpdate, "Triggers");
@@clientName(TriggerResources.createOrUpdate::parameters.resource, "trigger");
@@clientLocation(TriggerResources.delete, "Triggers");
@@clientLocation(TriggerResources.listByFactory, "Triggers");
@@clientLocation(TriggerResources.subscribeToEvents, "Triggers");
@@clientLocation(TriggerResources.getEventSubscriptionStatus, "Triggers");
@@clientLocation(TriggerResources.unsubscribeFromEvents, "Triggers");
@@clientLocation(TriggerResources.start, "Triggers");
@@clientLocation(TriggerResources.stop, "Triggers");
@@clientLocation(TriggerResources.rerun, "TriggerRuns");
@@clientLocation(TriggerResources.cancel, "TriggerRuns");

@@clientLocation(DataFlowResources.get, "DataFlows");
@@clientLocation(DataFlowResources.createOrUpdate, "DataFlows");
@@clientName(DataFlowResources.createOrUpdate::parameters.resource, "dataFlow");
@@clientLocation(DataFlowResources.delete, "DataFlows");
@@clientLocation(DataFlowResources.listByFactory, "DataFlows");

@@clientLocation(ManagedVirtualNetworkResources.get, "ManagedVirtualNetworks");
@@clientLocation(ManagedVirtualNetworkResources.createOrUpdate,
  "ManagedVirtualNetworks"
);
@@clientName(ManagedVirtualNetworkResources.createOrUpdate::parameters.resource,
  "managedVirtualNetwork"
);
@@clientLocation(ManagedVirtualNetworkResources.listByFactory,
  "ManagedVirtualNetworks"
);

@@clientLocation(ManagedPrivateEndpointResources.get,
  "ManagedPrivateEndpoints"
);
@@clientLocation(ManagedPrivateEndpointResources.createOrUpdate,
  "ManagedPrivateEndpoints"
);
@@clientName(ManagedPrivateEndpointResources.createOrUpdate::parameters.resource,
  "managedPrivateEndpoint"
);
@@clientLocation(ManagedPrivateEndpointResources.delete,
  "ManagedPrivateEndpoints"
);
@@clientLocation(ManagedPrivateEndpointResources.listByFactory,
  "ManagedPrivateEndpoints"
);

@@clientLocation(CredentialResources.get, "CredentialOperations");
@@clientLocation(CredentialResources.createOrUpdate, "CredentialOperations");
@@clientName(CredentialResources.createOrUpdate::parameters.resource,
  "credential"
);
@@clientLocation(CredentialResources.delete, "CredentialOperations");
@@clientLocation(CredentialResources.listByFactory, "CredentialOperations");

@@clientLocation(PrivateEndpointConnectionResources.get,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnectionResources.createOrUpdate,
  "PrivateEndpointConnection"
);
@@clientName(PrivateEndpointConnectionResources.createOrUpdate::parameters.resource,
  "privateEndpointWrapper"
);
@@clientLocation(PrivateEndpointConnectionResources.delete,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnectionResources.listByFactory,
  "privateEndPointConnections"
);

@@clientLocation(GlobalParameterResources.get, "GlobalParameters");
@@clientLocation(GlobalParameterResources.createOrUpdate, "GlobalParameters");
@@clientName(GlobalParameterResources.createOrUpdate::parameters.resource,
  "default"
);
@@clientLocation(GlobalParameterResources.delete, "GlobalParameters");
@@clientLocation(GlobalParameterResources.listByFactory, "GlobalParameters");

@@clientLocation(ChangeDataCaptureResources.get, "ChangeDataCapture");
@@clientLocation(ChangeDataCaptureResources.createOrUpdate,
  "ChangeDataCapture"
);
@@clientName(ChangeDataCaptureResources.createOrUpdate::parameters.resource,
  "changeDataCapture"
);
@@clientLocation(ChangeDataCaptureResources.delete, "ChangeDataCapture");
@@clientLocation(ChangeDataCaptureResources.listByFactory, "ChangeDataCapture");
@@clientLocation(ChangeDataCaptureResources.start, "ChangeDataCapture");
@@clientLocation(ChangeDataCaptureResources.stop, "ChangeDataCapture");
@@clientLocation(ChangeDataCaptureResources.status, "ChangeDataCapture");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ChangeDataCaptureResource.properties);

@@clientLocation(FactoriesOperationGroup.configureFactoryRepo, Factories);

@@clientLocation(ExposureControlOperationGroup.getFeatureValue,
  "ExposureControl"
);

@@clientName(FactoriesOperationGroup.configureFactoryRepo::parameters.body,
  "factoryRepoUpdate"
);
@@clientName(ExposureControlOperationGroup.getFeatureValue::parameters.body,
  "exposureControlRequest"
);
