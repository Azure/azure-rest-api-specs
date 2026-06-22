import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataFactory;

@@clientName(
  Microsoft.DataFactory,
  "DataFactoryManagementClient",
  "python,javascript"
);

@@clientName(CMKIdentityDefinition, "CmkIdentityDefinition", "java");
@@clientName(AmazonMWSObjectDataset, "AmazonMwsObjectDataset", "java");
@@clientName(AmazonMWSLinkedService, "AmazonMwsLinkedService", "java");
@@clientName(WebHookActivity, "WebhookActivity", "java");
@@clientName(WebHookActivityMethod, "WebhookActivityMethod", "java");

@@clientName(
  AmazonMWSLinkedServiceTypeProperties,
  "AmazonMwsLinkedServiceTypeProperties",
  "java"
);
@@clientName(AmazonMWSSource, "AmazonMwsSource", "java");

@@clientName(
  CommonDataServiceForAppsLinkedServiceTypeProperties.hostName,
  "hostname",
  "java"
);
@@clientName(
  DynamicsCrmLinkedServiceTypeProperties.hostName,
  "hostname",
  "java"
);
@@clientName(DynamicsLinkedServiceTypeProperties.hostName, "hostname", "java");
@@clientName(FactoryGitHubConfiguration.hostName, "hostname", "java");

@@clientName(Azure.ResourceManager.EntityTagProperty.eTag, "etag", "java");

@@clientName(
  AmazonRdsForSqlServerLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(
  AppFiguresLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(
  AzureSqlDatabaseLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(
  AzureSqlDWLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(
  AzureSqlMILinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(CmdkeySetupTypeProperties.userName, "username", "java");
@@clientName(FtpServerLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(HdfsLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(HDInsightLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(HttpLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(InformixLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(
  MicrosoftAccessLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(ODataLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(OdbcLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(
  RestServiceLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(SapBWLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(SapHanaLinkedServiceProperties.userName, "username", "java");
@@clientName(SapOdpLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(
  SapOpenHubLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(SapTableLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(
  SftpServerLinkedServiceTypeProperties.userName,
  "username",
  "java"
);
@@clientName(SqlServerLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(SSISAccessCredential.userName, "username", "java");
@@clientName(SSISExecutionCredential.userName, "username", "java");
@@clientName(TeamDeskLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(TwilioLinkedServiceTypeProperties.userName, "username", "java");
@@clientName(ZendeskLinkedServiceTypeProperties.userName, "username", "java");

@@clientName(
  AmazonMWSLinkedServiceTypeProperties.marketplaceID,
  "marketplaceId",
  "java"
);
@@clientName(AmazonMWSLinkedServiceTypeProperties.sellerID, "sellerId", "java");

@@clientName(
  SqlServerBaseLinkedServiceTypeProperties.hostNameInCertificate,
  "hostnameInCertificate",
  "java"
);

@@clientName(
  HBaseLinkedServiceTypeProperties.allowHostNameCNMismatch,
  "allowHostnameCNMismatch",
  "java"
);
@@clientName(
  HiveLinkedServiceTypeProperties.allowHostNameCNMismatch,
  "allowHostnameCNMismatch",
  "java"
);
@@clientName(
  ImpalaLinkedServiceTypeProperties.allowHostNameCNMismatch,
  "allowHostnameCNMismatch",
  "java"
);
@@clientName(
  PhoenixLinkedServiceTypeProperties.allowHostNameCNMismatch,
  "allowHostnameCNMismatch",
  "java"
);
@@clientName(
  PrestoLinkedServiceTypeProperties.allowHostNameCNMismatch,
  "allowHostnameCNMismatch",
  "java"
);
@@clientName(
  SparkLinkedServiceTypeProperties.allowHostNameCNMismatch,
  "allowHostnameCNMismatch",
  "java"
);
@@clientName(
  PrestoLinkedServiceTypeProperties.timeZoneID,
  "timeZoneId",
  "java"
);
@@clientName(
  HDInsightOnDemandLinkedServiceTypeProperties.clusterUserName,
  "clusterUsername",
  "java"
);
@@clientName(
  HDInsightOnDemandLinkedServiceTypeProperties.clusterSshUserName,
  "clusterSshUsername",
  "java"
);
@@clientName(
  GoogleAdWordsLinkedServiceTypeProperties.clientCustomerID,
  "clientCustomerId",
  "java"
);
@@clientName(
  GoogleAdWordsLinkedServiceTypeProperties.loginCustomerID,
  "loginCustomerId",
  "java"
);
@@clientName(
  IntegrationRuntimeSsisCatalogInfo.catalogAdminUserName,
  "catalogAdminUsername",
  "java"
);
@@clientName(
  SelfHostedIntegrationRuntimeStatusTypeProperties.autoUpdateETA,
  "autoUpdateEta",
  "java"
);
@@clientName(SalesforceServiceCloudV2Source.SOQLQuery, "soqlQuery", "java");

@@clientLocation(
  PrivateEndpointConnectionResources.get,
  "PrivateEndpointConnectionOperations",
  "java"
);
@@clientLocation(
  PrivateEndpointConnectionResources.createOrUpdate,
  "PrivateEndpointConnectionOperations",
  "java"
);
@@clientLocation(
  PrivateEndpointConnectionResources.delete,
  "PrivateEndpointConnectionOperations",
  "java"
);
@@clientLocation(
  PrivateEndpointConnectionResources.listByFactory,
  "PrivateEndPointConnections",
  "java"
);

@@clientName(
  DataLakeAnalyticsUSQLActivity,
  "DataLakeAnalyticsUsqlActivity",
  "java"
);
@@clientName(
  DataLakeAnalyticsUSQLActivityTypeProperties,
  "DataLakeAnalyticsUsqlActivityTypeProperties",
  "java"
);
@@clientName(SSISLogLocation, "SsisLogLocation", "java");
@@clientName(SSISAccessCredential, "SsisAccessCredential", "java");
@@clientName(SSISChildPackage, "SsisChildPackage", "java");
@@clientName(SSISPropertyOverride, "SsisPropertyOverride", "java");
@@clientName(ExecuteSSISPackageActivity, "ExecuteSsisPackageActivity", "java");
@@clientName(SSISExecutionParameter, "SsisExecutionParameter", "java");
@@clientName(SSISExecutionCredential, "SsisExecutionCredential", "java");
@@clientName(SSISPackageLocation, "SsisPackageLocation", "java");
@@clientName(
  ExecuteSSISPackageActivityTypeProperties,
  "ExecuteSsisPackageActivityTypeProperties",
  "java"
);
@@clientName(
  SSISLogLocationTypeProperties,
  "SsisLogLocationTypeProperties",
  "java"
);
@@clientName(FactoryVSTSConfiguration, "FactoryVstsConfiguration", "java");
@@clientName(SalesforceV2Source.SOQLQuery, "soqlQuery", "java");

@@usage(CopyTranslator, Usage.input | Usage.output, "java");
@@access(CopyTranslator, Access.public, "java");
@@usage(TabularTranslator, Usage.input | Usage.output, "java");
@@access(TabularTranslator, Access.public, "java");
@@usage(TypeConversionSettings, Usage.input | Usage.output, "java");
@@access(TypeConversionSettings, Access.public, "java");
@@usage(DatasetSchemaDataElement, Usage.input | Usage.output, "java");
@@access(DatasetSchemaDataElement, Access.public, "java");

@@clientLocation(
  PrivateEndpointConnectionResources.listByFactory,
  "PrivateEndPointConnections",
  "python"
);
@@clientLocation(
  Factories.privateLinkResourcesGet,
  "PrivateLinkResources",
  "python"
);
@@clientName(Type, "LinkedServiceReferenceType", "go");
@@clientName(
  Factories.dataFlowDebugSessionQueryByFactory,
  "listQueryByFactory",
  "javascript"
);
// C# customizations converted from AutoRest rename-mapping and type-changing directives.
@@clientName(
  AccessPolicyResponse,
  "DataFactoryDataPlaneAccessPolicyResult",
  "csharp"
);
@@clientName(Activity, "PipelineActivity", "csharp");
@@clientName(Activity.type, "ActivityType", "csharp");
@@clientName(ActivityDependency, "PipelineActivityDependency", "csharp");
@@clientName(ActivityPolicy, "PipelineActivityPolicy", "csharp");
@@clientName(ActivityPolicy.secureInput, "IsSecureInputEnabled", "csharp");
@@clientName(ActivityPolicy.secureOutput, "IsSecureOutputEnabled", "csharp");
@@clientName(ActivityRun, "PipelineActivityRunInformation", "csharp");
@@clientName(ActivityRun.activityRunEnd, "EndOn", "csharp");
@@clientName(ActivityRun.activityRunStart, "StartOn", "csharp");
@@clientName(ActivityRunsQueryResponse, "PipelineActivityRunsResult", "csharp");
@@clientName(ActivityState, "PipelineActivityState", "csharp");
@@clientName(
  AddDataFlowToDebugSessionResponse,
  "DataFactoryDataFlowStartDebugSessionResult",
  "csharp"
);
@@clientName(AmazonMWSLinkedService, "AmazonMwsLinkedService", "csharp");
@@clientName(
  AmazonMWSLinkedServiceTypeProperties.marketplaceID,
  "MarketplaceId",
  "csharp"
);
@@clientName(
  AmazonMWSLinkedServiceTypeProperties.sellerID,
  "SellerId",
  "csharp"
);
@@clientName(AmazonMWSObjectDataset, "AmazonMwsObjectDataset", "csharp");
@@clientName(AmazonMWSSource, "AmazonMwsSource", "csharp");
@@clientName(
  AmazonRdsForOracleTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(AmazonRdsForSqlAuthenticationType.SQL, "Sql", "csharp");
@@clientName(
  AmazonRdsForSqlServerTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  AmazonRedshiftTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(AvroDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(AvroFormat, "DatasetAvroFormat", "csharp");
@@clientName(AzureFunctionActivityMethod.DELETE, "Delete", "csharp");
@@clientName(AzureFunctionActivityMethod.GET, "Get", "csharp");
@@clientName(AzureFunctionActivityMethod.HEAD, "Head", "csharp");
@@clientName(AzureFunctionActivityMethod.OPTIONS, "Options", "csharp");
@@clientName(AzureFunctionActivityMethod.POST, "Post", "csharp");
@@clientName(AzureFunctionActivityMethod.PUT, "Put", "csharp");
@@clientName(AzureFunctionActivityMethod.TRACE, "Trace", "csharp");
@@clientName(
  AzureFunctionActivityTypeProperties.headers,
  "RequestHeaders",
  "csharp"
);
@@clientName(
  AzureMLExecutePipelineActivityTypeProperties.mlParentRunId,
  "MLParentRunId",
  "csharp"
);
@@clientName(
  AzureMLExecutePipelineActivityTypeProperties.mlPipelineEndpointId,
  "MLPipelineEndpointId",
  "csharp"
);
@@clientName(
  AzureMLExecutePipelineActivityTypeProperties.mlPipelineId,
  "MLPipelineId",
  "csharp"
);
@@clientName(
  AzureMLExecutePipelineActivityTypeProperties.mlPipelineParameters,
  "MLPipelineParameters",
  "csharp"
);
@@clientName(
  AzureMLLinkedServiceTypeProperties.mlEndpoint,
  "MLEndpoint",
  "csharp"
);
@@clientName(
  AzureMLServiceLinkedServiceTypeProperties.mlWorkspaceName,
  "MLWorkspaceName",
  "csharp"
);
@@clientName(
  AzurePostgreSqlTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(AzureSqlDatabaseAuthenticationType.SQL, "Sql", "csharp");
@@clientName(AzureSqlDWAuthenticationType.SQL, "Sql", "csharp");
@@clientName(
  AzureSqlDWTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(AzureSqlMIAuthenticationType.SQL, "Sql", "csharp");
@@clientName(
  AzureSqlMITableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  AzureSqlTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  BigDataPoolParametrizationReference.type,
  "ReferenceType",
  "csharp"
);
@@clientName(BinaryDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(BlobEventsTrigger, "DataFactoryBlobEventsTrigger", "csharp");
@@clientName(BlobEventTypes, "DataFactoryBlobEventType", "csharp");
@@clientName(BlobSink, "DataFactoryBlobSink", "csharp");
@@clientName(BlobSource, "DataFactoryBlobSource", "csharp");
@@clientName(BlobTrigger, "DataFactoryBlobTrigger", "csharp");
@@clientName(
  CassandraSourceReadConsistencyLevels,
  "CassandraSourceReadConsistencyLevel",
  "csharp"
);
@@clientName(CassandraSourceReadConsistencyLevels.ALL, "All", "csharp");
@@clientName(
  CassandraSourceReadConsistencyLevels.EACH_QUORUM,
  "EachQuorum",
  "csharp"
);
@@clientName(
  CassandraSourceReadConsistencyLevels.LOCAL_ONE,
  "LocalOne",
  "csharp"
);
@@clientName(
  CassandraSourceReadConsistencyLevels.LOCAL_QUORUM,
  "LocalQuorum",
  "csharp"
);
@@clientName(
  CassandraSourceReadConsistencyLevels.LOCAL_SERIAL,
  "LocalSerial",
  "csharp"
);
@@clientName(CassandraSourceReadConsistencyLevels.ONE, "One", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.QUORUM, "Quorum", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.SERIAL, "Serial", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.THREE, "Three", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.TWO, "Two", "csharp");
@@clientName(
  ChangeDataCapture.allowVNetOverride,
  "AllowVnetOverride",
  "csharp"
);
@@clientName(
  ChangeDataCaptureListResponse,
  "ChangeDataCaptureListResult",
  "csharp"
);
@@clientName(
  ChangeDataCaptureResource,
  "DataFactoryChangeDataCapture",
  "csharp"
);
@@clientName(CMKIdentityDefinition, "DataFactoryCmkIdentity", "csharp");
@@clientName(
  CompressionReadSettings.type,
  "CompressionReadSettingsType",
  "csharp"
);
@@clientName(ConfigurationType, "DataFactorySparkConfigurationType", "csharp");
@@clientName(ConnectionType, "MapperConnectionType", "csharp");
@@clientName(CopySink.type, "CopySinkType", "csharp");
@@clientName(CopySource, "CopyActivitySource", "csharp");
@@clientName(CopySource.type, "CopySourceType", "csharp");
@@clientName(CosmosDbConnectionMode, "CosmosDBConnectionMode", "csharp");
@@clientName(CosmosDbLinkedService, "CosmosDBLinkedService", "csharp");
@@clientName(
  CosmosDbMongoDbApiCollectionDataset,
  "CosmosDBMongoDBApiCollectionDataset",
  "csharp"
);
@@clientName(
  CosmosDbMongoDbApiLinkedService,
  "CosmosDBMongoDBApiLinkedService",
  "csharp"
);
@@clientName(CosmosDbMongoDbApiSink, "CosmosDBMongoDBApiSink", "csharp");
@@clientName(CosmosDbMongoDbApiSource, "CosmosDBMongoDBApiSource", "csharp");
@@clientName(
  CosmosDbSqlApiCollectionDataset,
  "CosmosDBSqlApiCollectionDataset",
  "csharp"
);
@@clientName(CosmosDbSqlApiSink, "CosmosDBSqlApiSink", "csharp");
@@clientName(CosmosDbSqlApiSource, "CosmosDBSqlApiSource", "csharp");
@@clientName(
  CreateDataFlowDebugSessionRequest,
  "DataFactoryDataFlowDebugSessionContent",
  "csharp"
);
@@clientName(
  CreateDataFlowDebugSessionRequest.timeToLive,
  "TimeToLiveInMinutes",
  "csharp"
);
@@clientName(
  CreateDataFlowDebugSessionResponse,
  "DataFactoryDataFlowCreateDebugSessionResult",
  "csharp"
);
@@clientName(
  CreateLinkedIntegrationRuntimeRequest,
  "CreateLinkedIntegrationRuntimeContent",
  "csharp"
);
@@clientName(CreateRunResponse, "PipelineCreateRunResult", "csharp");
// Back-compat: the GA (AutoRest) C# SDK exposed the createRun body parameter as
// "parameterValueSpecification" (generated default is "parameters"); restore it for C#.
@@clientName(
  PipelineResources.createRun::parameters.body,
  "parameterValueSpecification",
  "csharp"
);
@@clientName(Credential, "DataFactoryCredential", "csharp");
@@clientName(Credential.type, "CredentialType", "csharp");
@@clientName(
  CredentialListResponse,
  "DataFactoryCredentialListResult",
  "csharp"
);
@@clientName(CredentialReference, "DataFactoryCredentialReference", "csharp");
@@clientName(CredentialReference.type, "ReferenceType", "csharp");
@@clientName(
  CredentialReferenceType,
  "DataFactoryCredentialReferenceType",
  "csharp"
);
@@clientName(CredentialResource, "DataFactoryServiceCredential", "csharp");
@@clientName(CustomSetupBase.type, "CustomSetupBaseType", "csharp");
@@clientName(DataFlow, "DataFactoryDataFlowProperties", "csharp");
@@clientName(DataFlow.type, "DataFlowType", "csharp");
@@clientName(
  DataFlowDebugCommandRequest,
  "DataFlowDebugCommandContent",
  "csharp"
);
@@clientName(
  DataFlowDebugCommandResponse,
  "DataFactoryDataFlowDebugCommandResult",
  "csharp"
);
@@clientName(
  DataFlowDebugPackage,
  "DataFactoryDataFlowDebugPackageContent",
  "csharp"
);
@@clientName(DataFlowDebugResource, "DataFactoryDataFlowDebugInfo", "csharp");
@@clientName(
  DataFlowDebugSessionInfo.lastActivityTime,
  "LastActivityOn",
  "csharp"
);
@@clientName(DataFlowDebugSessionInfo.startTime, "StartOn", "csharp");
@@clientName(
  DataFlowDebugSessionInfo.timeToLiveInMinutes,
  "TimeToLiveInMinutes",
  "csharp"
);
@@clientName(DataFlowListResponse, "DataFactoryDataFlowListResult", "csharp");
@@clientName(DataFlowReference.type, "ReferenceType", "csharp");
@@clientName(DataFlowResource, "DataFactoryDataFlow", "csharp");
@@clientName(
  DataLakeAnalyticsUSQLActivity,
  "DataLakeAnalyticsUsqlActivity",
  "csharp"
);
@@clientName(Dataset, "DataFactoryDatasetProperties", "csharp");
@@clientName(Dataset.type, "DatasetType", "csharp");
@@clientName(DatasetCompression.type, "DatasetCompressionType", "csharp");
@@clientName(DatasetDataElement.name, "ColumnName", "csharp");
@@clientName(DatasetDataElement.type, "ColumnType", "csharp");
@@clientName(DatasetDebugResource, "DataFactoryDatasetDebugInfo", "csharp");
@@clientName(DatasetListResponse, "DataFactoryDatasetListResult", "csharp");
@@clientName(DatasetLocation.type, "DatasetLocationType", "csharp");
@@clientName(DatasetReference.type, "ReferenceType", "csharp");
@@clientName(DatasetResource, "DataFactoryDataset", "csharp");
@@clientName(DatasetSchemaDataElement.name, "SchemaColumnName", "csharp");
@@clientName(DatasetSchemaDataElement.type, "SchemaColumnType", "csharp");
@@clientName(DatasetStorageFormat.type, "DatasetStorageFormatType", "csharp");
@@clientName(DayOfWeek, "DataFactoryDayOfWeek", "csharp");
@@clientName(DaysOfWeek, "DataFactoryDaysOfWeek", "csharp");
@@clientName(
  Db2TableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  DeleteDataFlowDebugSessionRequest,
  "DeleteDataFlowDebugSessionContent",
  "csharp"
);
@@clientName(
  DelimitedTextDatasetTypeProperties.location,
  "DataLocation",
  "csharp"
);
@@clientName(DependencyReference.type, "DependencyReferenceType", "csharp");
@@clientName(
  DocumentDbCollectionDataset,
  "DocumentDBCollectionDataset",
  "csharp"
);
@@clientName(DocumentDbCollectionSink, "DocumentDBCollectionSink", "csharp");
@@clientName(
  DocumentDbCollectionSource,
  "DocumentDBCollectionSource",
  "csharp"
);
@@clientName(
  DrillDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  EnableInteractiveQueryRequest,
  "EnableInteractiveQueryContent",
  "csharp"
);
@@clientName(
  EncryptionConfiguration,
  "DataFactoryEncryptionConfiguration",
  "csharp"
);
@@clientName(
  EntityReference.type,
  "IntegrationRuntimeEntityReferenceType",
  "csharp"
);
@@clientName(ExcelDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(
  ExecuteDataFlowActivityTypePropertiesCompute,
  "ExecuteDataFlowActivityComputeType",
  "csharp"
);
@@clientName(
  ExecutePipelineActivityPolicy.secureInput,
  "IsSecureInputEnabled",
  "csharp"
);
@@clientName(
  ExecuteSSISPackageActivity,
  "ExecuteSsisPackageActivity",
  "csharp"
);
@@clientName(
  ExecuteSSISPackageActivityTypeProperties,
  "ExecuteSsisPackageActivityTypeProperties",
  "csharp"
);
@@clientName(ExportSettings.type, "ExportSettingsType", "csharp");
@@clientName(
  ExposureControlBatchRequest,
  "ExposureControlBatchContent",
  "csharp"
);
@@clientName(
  ExposureControlBatchResponse,
  "ExposureControlBatchResult",
  "csharp"
);
@@clientName(
  ExposureControlBatchResponse.exposureControlResponses,
  "ExposureControlResults",
  "csharp"
);
@@clientName(
  ExposureControlOperationGroup.getFeatureValue,
  "GetFeatureValueExposureControl",
  "csharp"
);
@@clientName(ExposureControlRequest, "ExposureControlContent", "csharp");
@@clientName(ExposureControlResponse, "ExposureControlResult", "csharp");
@@clientName(Expression, "DataFactoryExpression", "csharp");
@@clientName(Expression.type, "ExpressionType", "csharp");
@@clientName(ExpressionType, "DataFactoryExpressionType", "csharp");
@@clientName(ExpressionV2, "DataFactoryExpressionV2", "csharp");
@@clientName(ExpressionV2.type, "V2Type", "csharp");
@@clientName(ExpressionV2.value, "V2Value", "csharp");
@@clientName(ExpressionV2Type, "DataFactoryExpressionV2Type", "csharp");
@@clientName(Factories.addDataFlow, "AddDataFlowToDebugSession", "csharp");
@@clientName(Factories.cancel, "CancelPipelineRun", "csharp");
@@clientName(Factories.create, "CreateDataFlowDebugSession", "csharp");
@@clientName(
  Factories.dataFlowDebugSessionDelete,
  "DeleteDataFlowDebugSession",
  "csharp"
);
@@clientName(
  Factories.dataFlowDebugSessionQueryByFactory,
  "getDataFlowDebugSessions",
  "csharp"
);
@@clientName(
  Factories.executeCommand,
  "ExecuteDataFlowDebugSessionCommand",
  "csharp"
);
@@clientName(
  Factories.getFeatureValueByFactory,
  "GetExposureControlFeature",
  "csharp"
);
@@clientName(Factories.pipelineRunsGet, "GetPipelineRun", "csharp");
@@clientName(
  Factories.privateLinkResourcesGet,
  "GetPrivateLinkResources",
  "csharp"
);
@@clientName(
  Factories.privateLinkResourcesGet,
  "GetPrivateLinkResources",
  "csharp"
);
@@clientName(Factories.queryByFactory, "getPipelineRuns", "csharp");
@@clientName(Factories.queryByPipelineRun, "GetActivityRun", "csharp");
@@clientName(
  Factories.queryFeatureValuesByFactory,
  "GetExposureControlFeatures",
  "csharp"
);
@@clientName(Factories.triggerRunsQueryByFactory, "getTriggerRuns", "csharp");
@@clientName(Factories.triggersQueryByFactory, "GetTriggers", "csharp");
@@clientName(
  FactoriesOperationGroup.configureFactoryRepo,
  "ConfigureFactoryRepoInformation",
  "csharp"
);
@@clientName(Factory, "DataFactory", "csharp");
@@clientName(FactoryListResponse, "DataFactoryListResult", "csharp");
@@clientName(FactoryProperties.createTime, "CreatedOn", "csharp");
@@clientName(
  FactoryRepoConfiguration.type,
  "FactoryRepoConfigurationType",
  "csharp"
);
@@clientName(FactoryRepoUpdate, "FactoryRepoContent", "csharp");
@@clientName(FactoryVSTSConfiguration, "FactoryVstsConfiguration", "csharp");
@@clientName(Flowlet, "DataFactoryFlowletProperties", "csharp");
@@clientName(FormatReadSettings.type, "FormatReadSettingsType", "csharp");
@@clientName(FormatWriteSettings.type, "FormatWriteSettingsType", "csharp");
@@clientName(FrequencyType, "MapperPolicyRecurrenceFrequencyType", "csharp");
@@clientName(GetMetadataActivity, "GetDatasetMetadataActivity", "csharp");
@@clientName(
  GetSsisObjectMetadataRequest,
  "GetSsisObjectMetadataContent",
  "csharp"
);
@@clientName(GitHubAccessTokenRequest, "GitHubAccessTokenContent", "csharp");
@@clientName(GitHubAccessTokenResponse, "GitHubAccessTokenResult", "csharp");
@@clientName(GitHubClientSecret, "FactoryGitHubClientSecret", "csharp");
@@clientName(
  GlobalParameterListResponse,
  "DataFactoryGlobalParameterListResult",
  "csharp"
);
@@clientName(GlobalParameterResource, "DataFactoryGlobalParameter", "csharp");
@@clientName(
  GlobalParameterSpecification,
  "DataFactoryGlobalParameterProperties",
  "csharp"
);
@@clientName(
  GlobalParameterSpecification.type,
  "GlobalParameterType",
  "csharp"
);
@@clientName(GlobalParameterType, "DataFactoryGlobalParameterType", "csharp");
@@clientName(
  GoogleAdWordsLinkedServiceTypeProperties.clientCustomerID,
  "ClientCustomerId",
  "csharp"
);
@@clientName(
  GoogleAdWordsLinkedServiceTypeProperties.loginCustomerID,
  "LoginCustomerId",
  "csharp"
);
@@clientName(
  GreenplumDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  HDInsightActivityDebugInfoOption,
  "HDInsightActivityDebugInfoOptionSetting",
  "csharp"
);
@@clientName(
  HDInsightOndemandClusterResourceGroupAuthenticationType,
  "HDInsightOnDemandClusterResourceGroupAuthenticationType",
  "csharp"
);
@@clientName(
  HDInsightOnDemandLinkedServiceTypeProperties.timeToLive,
  "TimeToLiveExpression",
  "csharp"
);
@@clientName(
  HDInsightOnDemandLinkedServiceTypeProperties.version,
  "Version",
  "csharp"
);
@@clientName(
  HiveDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(HiveThriftTransportProtocol.`HTTP `, "Http", "csharp");
@@clientName(HiveThriftTransportProtocol.SASL, "Sasl", "csharp");
@@clientName(HttpDataset, "DataFactoryHttpDataset", "csharp");
@@clientName(HttpSource, "DataFactoryHttpFileSource", "csharp");
@@clientName(ImpalaAuthenticationType.SASLUsername, "SaslUsername", "csharp");
@@clientName(
  ImpalaDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(ImpalaThriftTransportProtocol.HTTP, "Http", "csharp");
@@clientName(ImportSettings.type, "ImportSettingsType", "csharp");
@@clientName(
  IntegrationRuntime,
  "DataFactoryIntegrationRuntimeProperties",
  "csharp"
);
@@clientName(IntegrationRuntime.type, "IntegrationRuntimeType", "csharp");
@@clientName(
  IntegrationRuntimeAutoUpdate,
  "IntegrationRuntimeAutoUpdateState",
  "csharp"
);
@@clientName(
  IntegrationRuntimeComputeProperties.vNetProperties,
  "VnetProperties",
  "csharp"
);
@@clientName(
  IntegrationRuntimeCustomerVirtualNetwork.subnetId,
  "SubnetId",
  "csharp"
);
@@clientName(
  IntegrationRuntimeDataFlowProperties.cleanup,
  "ShouldCleanupAfterTtl",
  "csharp"
);
@@clientName(
  IntegrationRuntimeDataFlowProperties.timeToLive,
  "TimeToLiveInMinutes",
  "csharp"
);
@@clientName(
  IntegrationRuntimeDataFlowPropertiesCustomPropertiesItem,
  "IntegrationRuntimeDataFlowCustomItem",
  "csharp"
);
@@clientName(
  IntegrationRuntimeDebugResource,
  "DataFactoryIntegrationRuntimeDebugInfo",
  "csharp"
);
@@clientName(
  IntegrationRuntimeListResponse,
  "DataFactoryIntegrationRuntimeListResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimeNodeIpAddress,
  "IntegrationRuntimeNodeIPAddress",
  "csharp"
);
@@clientName(IntegrationRuntimeNodeIpAddress.ipAddress, "IPAddress", "csharp");
@@clientName(
  IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse,
  "IntegrationRuntimeOutboundNetworkDependenciesResult",
  "csharp"
);
@@clientName(IntegrationRuntimeReference.type, "ReferenceType", "csharp");
@@clientName(
  IntegrationRuntimeRegenerateKeyParameters,
  "IntegrationRuntimeRegenerateKeyContent",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResource,
  "DataFactoryIntegrationRuntime",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.disableInteractiveQuery,
  "DisableInteractiveQueryIntegrationRuntime",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.enableInteractiveQuery,
  "EnableInteractiveQueryIntegrationRuntime",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.getIpAddress,
  "GetIPAddressIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodesDelete,
  "DeleteIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodesGet,
  "GetIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeNodesUpdate,
  "UpdateIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.integrationRuntimeObjectMetadataGet,
  "GetAllIntegrationRuntimeObjectMetadata",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.listOutboundNetworkDependenciesEndpoints,
  "GetOutboundNetworkDependencies",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.refresh,
  "RefreshIntegrationRuntimeObjectMetadata",
  "csharp"
);
@@clientName(IntegrationRuntimeStatus.type, "RuntimeType", "csharp");
@@clientName(
  IntegrationRuntimeStatusResponse,
  "DataFactoryIntegrationRuntimeStatusResult",
  "csharp"
);
@@clientName(
  IntegrationRuntimeVNetProperties,
  "IntegrationRuntimeVnetProperties",
  "csharp"
);
@@clientName(IntegrationRuntimeVNetProperties.subnetId, "SubnetId", "csharp");
@@clientName(IntegrationRuntimeVNetProperties.vNetId, "VnetId", "csharp");
@@clientName(
  JiraTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(JsonDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(JsonFormat, "DatasetJsonFormat", "csharp");
@@clientName(
  LakeHouseTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(LinkedIntegrationRuntime.createTime, "CreatedOn", "csharp");
@@clientName(
  LinkedIntegrationRuntimeRequest,
  "LinkedIntegrationRuntimeContent",
  "csharp"
);
@@clientName(LinkedService, "DataFactoryLinkedServiceProperties", "csharp");
@@clientName(LinkedService.type, "LinkedServiceType", "csharp");
@@clientName(LinkedService.version, "LinkedServiceVersion", "csharp");
@@clientName(
  LinkedServiceDebugResource,
  "DataFactoryLinkedServiceDebugInfo",
  "csharp"
);
@@clientName(
  LinkedServiceListResponse,
  "DataFactoryLinkedServiceListResult",
  "csharp"
);
@@clientName(LinkedServiceResource, "DataFactoryLinkedService", "csharp");
@@clientName(LogSettings, "DataFactoryLogSettings", "csharp");
@@clientName(
  ManagedIdentityCredential,
  "DataFactoryManagedIdentityCredentialProperties",
  "csharp"
);
@@clientName(
  ManagedIntegrationRuntimeOperationResult.type,
  "ManagedIntegrationRuntimeOperationResultType",
  "csharp"
);
@@clientName(
  ManagedIntegrationRuntimeStatusTypeProperties.createTime,
  "CreatedOn",
  "csharp"
);
@@clientName(
  ManagedPrivateEndpoint,
  "DataFactoryPrivateEndpointProperties",
  "csharp"
);
@@clientName(
  managedPrivateEndpointListResponse,
  "DataFactoryPrivateEndpointListResult",
  "csharp"
);
@@clientName(
  ManagedPrivateEndpointResource,
  "DataFactoryPrivateEndpoint",
  "csharp"
);
@@clientName(
  ManagedVirtualNetwork,
  "DataFactoryManagedVirtualNetworkProperties",
  "csharp"
);
@@clientName(ManagedVirtualNetwork.vNetId, "VnetId", "csharp");
@@clientName(
  ManagedVirtualNetworkListResponse,
  "DataFactoryManagedVirtualNetworkListResult",
  "csharp"
);
@@clientName(ManagedVirtualNetworkReference.type, "ReferenceType", "csharp");
@@clientName(
  ManagedVirtualNetworkResource,
  "DataFactoryManagedVirtualNetwork",
  "csharp"
);
@@clientName(MapperAttributeMapping.type, "MappingType", "csharp");
@@clientName(MapperConnection.type, "ConnectionType", "csharp");
@@clientName(MapperConnectionReference.type, "ConnectionType", "csharp");
@@clientName(MappingDataFlow, "DataFactoryMappingDataFlowProperties", "csharp");
@@clientName(MetadataItem, "DataFactoryMetadataItemInfo", "csharp");
@@clientName(
  MongoDbAtlasCollectionDataset,
  "MongoDBAtlasCollectionDataset",
  "csharp"
);
@@clientName(MongoDbAtlasLinkedService, "MongoDBAtlasLinkedService", "csharp");
@@clientName(MongoDbAtlasSink, "MongoDBAtlasSink", "csharp");
@@clientName(MongoDbAtlasSource, "MongoDBAtlasSource", "csharp");
@@clientName(MongoDbAuthenticationType, "MongoDBAuthenticationType", "csharp");
@@clientName(MongoDbCollectionDataset, "MongoDBCollectionDataset", "csharp");
@@clientName(
  MongoDbCursorMethodsProperties,
  "MongoDBCursorMethodsProperties",
  "csharp"
);
@@clientName(MongoDbLinkedService, "MongoDBLinkedService", "csharp");
@@clientName(MongoDbSource, "MongoDBSource", "csharp");
@@clientName(
  MongoDbV2CollectionDataset,
  "MongoDBV2CollectionDataset",
  "csharp"
);
@@clientName(MongoDbV2LinkedService, "MongoDBV2LinkedService", "csharp");
@@clientName(MongoDbV2Sink, "MongoDBV2Sink", "csharp");
@@clientName(MongoDbV2Source, "MongoDBV2Source", "csharp");
@@clientName(
  NetezzaTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(NotebookParameter.type, "ParameterType", "csharp");
@@clientName(Office365Source.endTime, "EndOn", "csharp");
@@clientName(Office365Source.startTime, "StartOn", "csharp");
@@clientName(
  OracleTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(OrcDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(OrcFormat, "DatasetOrcFormat", "csharp");
@@clientName(OutputColumn, "Office365TableOutputColumn", "csharp");
@@clientName(PackageStore, "DataFactoryPackageStore", "csharp");
@@clientName(ParameterSpecification, "EntityParameterSpecification", "csharp");
@@clientName(ParameterSpecification.type, "ParameterType", "csharp");
@@clientName(ParameterType, "EntityParameterType", "csharp");
@@clientName(ParquetDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(ParquetFormat, "DatasetParquetFormat", "csharp");
@@clientName(
  PhoenixDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(PipelineListResponse, "DataFactoryPipelineListResult", "csharp");
@@clientName(PipelineReference, "DataFactoryPipelineReference", "csharp");
@@clientName(PipelineReference.type, "ReferenceType", "csharp");
@@clientName(
  PipelineReferenceType,
  "DataFactoryPipelineReferenceType",
  "csharp"
);
@@clientName(PipelineResource, "DataFactoryPipeline", "csharp");
@@clientName(PipelineRun, "DataFactoryPipelineRunInfo", "csharp");
@@clientName(PipelineRun.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(PipelineRun.runEnd, "RunEndOn", "csharp");
@@clientName(PipelineRun.runStart, "RunStartOn", "csharp");
@@clientName(
  PipelineRunInvokedBy,
  "DataFactoryPipelineRunEntityInfo",
  "csharp"
);
@@clientName(
  PipelineRunsQueryResponse,
  "DataFactoryPipelineRunsQueryResult",
  "csharp"
);
@@clientName(
  PostgreSqlTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  PostgreSqlV2TableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(PrestoAuthenticationType.LDAP, "Ldap", "csharp");
@@clientName(
  PrestoDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  PrestoLinkedServiceTypeProperties.timeZoneID,
  "TimeZoneId",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionListResponse,
  "DataFactoryPrivateEndpointConnectionListResult",
  "csharp"
);
@@clientName(
  PrivateEndpointConnectionResource,
  "DataFactoryPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  PrivateLinkConnectionApprovalRequestResource,
  "DataFactoryPrivateEndpointConnectionCreateOrUpdateContent",
  "csharp"
);
@@clientName(PublicNetworkAccess, "DataFactoryPublicNetworkAccess", "csharp");
@@clientName(
  QueryDataFlowDebugSessionsResponse,
  "DataFlowDebugSessionInfoListResult",
  "csharp"
);
@@clientName(RecurrenceFrequency, "DataFactoryRecurrenceFrequency", "csharp");
@@clientName(RecurrenceSchedule, "DataFactoryRecurrenceSchedule", "csharp");
@@clientName(
  RecurrenceScheduleOccurrence,
  "DataFactoryRecurrenceScheduleOccurrence",
  "csharp"
);
@@clientName(
  RemotePrivateEndpointConnection,
  "DataFactoryPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(RunFilterParameters, "RunFilterContent", "csharp");
@@clientName(RunQueryFilterOperator.Equals, "EqualsValue", "csharp");
@@clientName(RunQueryOrder.ASC, "Asc", "csharp");
@@clientName(RunQueryOrder.DESC, "Desc", "csharp");
@@clientName(SalesforceServiceCloudV2Source.SOQLQuery, "SoqlQuery", "csharp");
@@clientName(SalesforceV2Source.SOQLQuery, "SoqlQuery", "csharp");
@@clientName(SapBwCubeDataset, "SapBWCubeDataset", "csharp");
@@clientName(SapBwSource, "SapBWSource", "csharp");
@@clientName(
  SapHanaTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(SapOdpLinkedServiceTypeProperties.sncMode, "SncFlag", "csharp");
@@clientName(SapTableLinkedServiceTypeProperties.sncMode, "SncFlag", "csharp");
@@clientName(ScheduleTrigger, "DataFactoryScheduleTrigger", "csharp");
@@clientName(ScriptAction, "DataFactoryScriptAction", "csharp");
@@clientName(ScriptActivity, "DataFactoryScriptActivity", "csharp");
@@clientName(ScriptActivityParameter.type, "ParameterType", "csharp");
@@clientName(ScriptActivityParameterType.Timespan, "TimeSpan", "csharp");
@@clientName(ScriptActivityScriptBlock.type, "QueryType", "csharp");
@@clientName(
  ScriptActivityTypePropertiesLogSettings,
  "ScriptActivityTypeLogSettings",
  "csharp"
);
@@clientName(ScriptType, "DataFactoryScriptType", "csharp");
@@clientName(
  SecureInputOutputPolicy.secureInput,
  "IsSecureInputEnabled",
  "csharp"
);
@@clientName(
  SecureInputOutputPolicy.secureOutput,
  "IsSecureOutputEnabled",
  "csharp"
);
@@clientName(SelfHostedIntegrationRuntimeNode.expiryTime, "ExpireOn", "csharp");
@@clientName(
  SelfHostedIntegrationRuntimeStatusTypeProperties.autoUpdateETA,
  "AutoUpdateEta",
  "csharp"
);
@@clientName(
  SelfHostedIntegrationRuntimeStatusTypeProperties.createTime,
  "CreatedOn",
  "csharp"
);
@@clientName(
  SelfHostedIntegrationRuntimeStatusTypeProperties.selfContainedInteractiveAuthoringEnabled,
  "IsSelfContainedInteractiveAuthoringEnabled",
  "csharp"
);
@@clientName(
  SelfHostedIntegrationRuntimeStatusTypeProperties.serviceUrls,
  "ServiceUriStringList",
  "csharp"
);
@@clientName(
  SelfHostedIntegrationRuntimeTypeProperties.selfContainedInteractiveAuthoringEnabled,
  "IsSelfContainedInteractiveAuthoringEnabled",
  "csharp"
);
@@clientName(
  SnowflakeDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  SparkConfigurationParametrizationReference.type,
  "ReferenceType",
  "csharp"
);
@@clientName(
  SparkDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(SparkThriftTransportProtocol.`HTTP `, "Http", "csharp");
@@clientName(SparkThriftTransportProtocol.SASL, "Sasl", "csharp");
@@clientName(SqlServerAuthenticationType.SQL, "Sql", "csharp");
@@clientName(
  SqlServerTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(SSISAccessCredential, "SsisAccessCredential", "csharp");
@@clientName(SSISChildPackage, "SsisChildPackage", "csharp");
@@clientName(SSISExecutionCredential, "SsisExecutionCredential", "csharp");
@@clientName(SSISExecutionParameter, "SsisExecutionParameter", "csharp");
@@clientName(SSISLogLocation, "SsisLogLocation", "csharp");
@@clientName(SSISLogLocation.type, "LocationType", "csharp");
@@clientName(SsisObjectMetadata.type, "MetadataType", "csharp");
@@clientName(
  SsisObjectMetadataListResponse,
  "SsisObjectMetadataListResult",
  "csharp"
);
@@clientName(
  SsisObjectMetadataStatusResponse,
  "SsisObjectMetadataStatusResult",
  "csharp"
);
@@clientName(SSISPackageLocation, "SsisPackageLocation", "csharp");
@@clientName(SSISPackageLocation.type, "LocationType", "csharp");
@@clientName(SsisPackageLocationType.SSISDB, "SsisDB", "csharp");
@@clientName(SsisParameter, "SsisParameterInfo", "csharp");
@@clientName(SsisParameter.required, "IsRequired", "csharp");
@@clientName(SsisParameter.sensitive, "IsSensitive", "csharp");
@@clientName(SsisParameter.valueSet, "HasValueSet", "csharp");
@@clientName(SSISPropertyOverride, "SsisPropertyOverride", "csharp");
@@clientName(SsisVariable.sensitive, "IsSensitive", "csharp");
@@clientName(StoreReadSettings.type, "StoreReadSettingsType", "csharp");
@@clientName(StoreWriteSettings.type, "StoreWriteSettingsType", "csharp");
@@clientName(SubResourceDebugResource, "DataFactoryDebugInfo", "csharp");
@@clientName(SwitchCase, "SwitchCaseActivity", "csharp");
@@clientName(SynapseNotebookReference.type, "NotebookReferenceType", "csharp");
@@clientName(SynapseSparkJobReference.type, "SparkJobReferenceType", "csharp");
@@clientName(TarGZipReadSettings, "TarGzipReadSettings", "csharp");
@@clientName(TextFormat, "DatasetTextFormat", "csharp");
@@clientName(Transformation, "DataFlowTransformation", "csharp");
@@clientName(Trigger, "DataFactoryTriggerProperties", "csharp");
@@clientName(Trigger.type, "TriggerType", "csharp");
@@clientName(TriggerFilterParameters, "TriggerFilterContent", "csharp");
@@clientName(TriggerListResponse, "DataFactoryTriggerListResult", "csharp");
@@clientName(TriggerQueryResponse, "DataFactoryTriggerQueryResult", "csharp");
@@clientName(TriggerReference, "DataFactoryTriggerReference", "csharp");
@@clientName(TriggerReference.type, "ReferenceType", "csharp");
@@clientName(TriggerReferenceType, "DataFactoryTriggerReferenceType", "csharp");
@@clientName(TriggerResource, "DataFactoryTrigger", "csharp");
@@clientName(TriggerResources.cancel, "CancelTriggerRun", "csharp");
@@clientName(TriggerResources.rerun, "RerunTriggerRun", "csharp");
@@clientName(TriggerRun, "DataFactoryTriggerRun", "csharp");
@@clientName(
  TriggerRunsQueryResponse,
  "DataFactoryTriggerRunsQueryResult",
  "csharp"
);
@@clientName(TriggerRunStatus, "DataFactoryTriggerRunStatus", "csharp");
@@clientName(TriggerRuntimeState, "DataFactoryTriggerRuntimeState", "csharp");
@@clientName(
  TriggerSubscriptionOperationStatus,
  "DataFactoryTriggerSubscriptionOperationResult",
  "csharp"
);
@@clientName(Type, "LinkedServiceReferenceType", "csharp");
@@clientName(
  UpdateIntegrationRuntimeNodeRequest,
  "UpdateIntegrationRuntimeNodeContent",
  "csharp"
);
@@clientName(
  UserAccessPolicy,
  "DataFactoryDataPlaneUserAccessPolicy",
  "csharp"
);
@@clientName(UserAccessPolicy.expireTime, "ExpireOn", "csharp");
@@clientName(UserAccessPolicy.startTime, "StartOn", "csharp");
@@clientName(UserProperty, "PipelineActivityUserProperty", "csharp");
@@clientName(ValueType, "DatasetSourceValueType", "csharp");
@@clientName(VariableSpecification, "PipelineVariableSpecification", "csharp");
@@clientName(VariableSpecification.type, "VariableType", "csharp");
@@clientName(VariableType, "PipelineVariableType", "csharp");
@@clientName(
  VerticaDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  WarehouseTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  WebActivityAuthentication.type,
  "WebActivityAuthenticationType",
  "csharp"
);
@@clientName(WebActivityMethod.DELETE, "Delete", "csharp");
@@clientName(WebActivityMethod.GET, "Get", "csharp");
@@clientName(WebActivityMethod.POST, "Post", "csharp");
@@clientName(WebActivityMethod.PUT, "Put", "csharp");
@@clientName(WebActivityTypeProperties.headers, "RequestHeaders", "csharp");
@@clientName(WebHookActivityMethod.POST, "Post", "csharp");
@@clientName(WebHookActivityTypeProperties.headers, "RequestHeaders", "csharp");
@@clientName(
  WranglingDataFlow,
  "DataFactoryWranglingDataFlowProperties",
  "csharp"
);
@@clientName(XmlDatasetTypeProperties.location, "DataLocation", "csharp");

@@alternateType(ArmIdWrapper.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  AzureKeyVaultSecretReference,
  {
    identity: "Azure.Core.Expressions.DataFactory.DataFactoryKeyVaultSecret",
  },
  "csharp"
);
@@alternateType(ChangeDataCaptureResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(CredentialResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  CustomActivityTypeProperties.retentionTimeInDays,
  unknown,
  "csharp"
);
@@alternateType(
  DataFlowDebugSessionInfo.lastActivityTime,
  utcDateTime,
  "csharp"
);
@@alternateType(DataFlowDebugSessionInfo.startTime, utcDateTime, "csharp");
@@alternateType(DataFlowResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(DatasetResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(Factory.eTag, Azure.Core.eTag, "csharp");
@@alternateType(
  FactoryRepoUpdate.factoryResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(GlobalParameterResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  IntegrationRuntimeCustomerVirtualNetwork.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IntegrationRuntimeNodeIpAddress.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(IntegrationRuntimeResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  IntegrationRuntimeVNetProperties.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IntegrationRuntimeVNetProperties.vNetId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  LinkedIntegrationRuntimeRbacAuthorization.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LinkedServiceReference,
  {
    identity: "Azure.Core.Expressions.DataFactory.DataFactoryLinkedServiceReference",
  },
  "csharp"
);
@@alternateType(LinkedServiceResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  LocationIdParameter.locationId,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  ManagedIdentityTypeProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedPrivateEndpoint.privateLinkResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ManagedPrivateEndpointResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(ManagedVirtualNetwork.vNetId, Azure.Core.uuid, "csharp");
@@alternateType(ManagedVirtualNetworkResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(PipelineResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  PrivateEndpointConnectionResource.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(
  PurviewConfiguration.purviewResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SecretBase,
  {
    identity: "Azure.Core.Expressions.DataFactory.DataFactorySecret",
  },
  "csharp"
);
@@alternateType(
  SecureString,
  {
    identity: "Azure.Core.Expressions.DataFactory.DataFactorySecretString",
  },
  "csharp"
);
@@alternateType(
  SelfHostedIntegrationRuntimeStatusTypeProperties.localTimeZoneOffset,
  duration,
  "csharp"
);
@@alternateType(
  SelfHostedIntegrationRuntimeStatusTypeProperties.taskQueueId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  SelfHostedIntegrationRuntimeStatusTypeProperties.updateDelayOffset,
  duration,
  "csharp"
);
@@alternateType(TriggerResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  UpdateIntegrationRuntimeRequest.updateDelayOffset,
  duration,
  "csharp"
);
@@alternateType(UserAccessPolicy.expireTime, utcDateTime, "csharp");
@@alternateType(UserAccessPolicy.startTime, utcDateTime, "csharp");

@@usage(DatasetDataElement, Usage.input, "csharp");
@@usage(DatasetSchemaDataElement, Usage.input, "csharp");
@@usage(OutputColumn, Usage.input, "csharp");
@@usage(
  PrivateEndpointConnectionResource,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(PrivateLinkResource, Usage.input, "csharp");
@@usage(PrivateLinkResourceProperties, Usage.input, "csharp");
@@usage(RemotePrivateEndpointConnection, Usage.input | Usage.output, "csharp");
@@usage(ScriptType, Usage.input | Usage.output, "csharp");

@@access(DatasetSchemaDataElement, Access.public, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Factory,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PrivateLinkConnectionApprovalRequestResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PrivateLinkResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);

// Internalize the per-type `typeProperties` envelope models surfaced by the MPG generator.
// The previously shipped (AutoRest) public surface flattened these onto the parent
// LinkedService/Dataset/Activity types, so the standalone envelope models are redundant
// public surface; keep them internal to preserve the GA-compatible public API.
@@access(AmazonRdsForLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  AmazonRdsForSqlServerLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(AmazonRedshiftLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(AmazonS3DatasetTypeProperties, Access.internal, "csharp");
@@access(AppendVariableActivityTypeProperties, Access.internal, "csharp");
@@access(AppFiguresLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(AzureBlobDatasetTypeProperties, Access.internal, "csharp");
@@access(AzureBlobFSDatasetTypeProperties, Access.internal, "csharp");
@@access(AzureBlobFSLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  AzureBlobStorageLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(
  AzureDatabricksDetltaLakeLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(AzureDatabricksLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  AzureDataExplorerLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(
  AzureDataLakeAnalyticsLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(AzureDataLakeStoreDatasetTypeProperties, Access.internal, "csharp");
@@access(
  AzureDataLakeStoreLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(
  AzureMLExecutePipelineActivityTypeProperties,
  Access.internal,
  "csharp"
);
@@access(AzureMLLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(AzureMLServiceLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(AzurePostgreSqlLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(AzureSearchLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  AzureSqlDatabaseLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(AzureSqlDWLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(AzureSqlMILinkedServiceTypeProperties, Access.internal, "csharp");
@@access(CassandraLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(CmdkeySetupTypeProperties, Access.internal, "csharp");
@@access(
  CommonDataServiceForAppsLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(ConcurLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(CosmosDbLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(CustomActivityTypeProperties, Access.internal, "csharp");
@@access(Db2LinkedServiceTypeProperties, Access.internal, "csharp");
@@access(DeleteActivityTypeProperties, Access.internal, "csharp");
@@access(DelimitedTextDatasetTypeProperties, Access.internal, "csharp");
@@access(DynamicsAXLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(DynamicsAXResourceDatasetTypeProperties, Access.internal, "csharp");
@@access(DynamicsCrmLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(DynamicsLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(EloquaLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(ExcelDatasetTypeProperties, Access.internal, "csharp");
@@access(FileShareDatasetTypeProperties, Access.internal, "csharp");
@@access(FtpServerLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(GoogleBigQueryLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(GreenplumLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(HBaseLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(HdfsLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(HDInsightLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  HDInsightOnDemandLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(HiveLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(HttpDatasetTypeProperties, Access.internal, "csharp");
@@access(HttpLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(ImpalaLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(InformixLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(JiraLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(JsonDatasetTypeProperties, Access.internal, "csharp");
@@access(LakeHouseLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(MariaDBLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(MicrosoftAccessLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(MongoDbLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(MySqlLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(ODataLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(ODataResourceDatasetTypeProperties, Access.internal, "csharp");
@@access(OdbcLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(Office365LinkedServiceTypeProperties, Access.internal, "csharp");
@@access(OracleLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  OracleServiceCloudLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(PhoenixLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(PostgreSqlV2LinkedServiceTypeProperties, Access.internal, "csharp");
@@access(PrestoLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(QuickbaseLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(RestResourceDatasetTypeProperties, Access.internal, "csharp");
@@access(RestServiceLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(SalesforceLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  SalesforceServiceCloudLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(SapBWLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  SapCloudForCustomerLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(
  SapCloudForCustomerResourceDatasetTypeProperties,
  Access.internal,
  "csharp"
);
@@access(SapEccLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(SapEccResourceDatasetTypeProperties, Access.internal, "csharp");
@@access(SapOdpLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(SapOpenHubLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(SapOpenHubTableDatasetTypeProperties, Access.internal, "csharp");
@@access(SapTableLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(ServiceNowLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(ServiceNowV2LinkedServiceTypeProperties, Access.internal, "csharp");
@@access(ServicePrincipalCredentialTypeProperties, Access.internal, "csharp");
@@access(SetVariableActivityTypeProperties, Access.internal, "csharp");
@@access(SftpServerLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(
  SharePointOnlineListLinkedServiceTypeProperties,
  Access.internal,
  "csharp"
);
@@access(SnowflakeLinkedV2ServiceTypeProperties, Access.internal, "csharp");
@@access(SparkLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(SqlServerBaseLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(SqlServerLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(SSISPackageLocationTypeProperties, Access.internal, "csharp");
@@access(SybaseLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(TeamDeskLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(TeradataLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(TwilioLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(UntilActivityTypeProperties, Access.internal, "csharp");
@@access(ValidationActivityTypeProperties, Access.internal, "csharp");
@@access(WarehouseLinkedServiceTypeProperties, Access.internal, "csharp");
@@access(WebActivityTypeProperties, Access.internal, "csharp");
@@access(WebHookActivityTypeProperties, Access.internal, "csharp");
@@access(WebTableDatasetTypeProperties, Access.internal, "csharp");
@@access(XmlDatasetTypeProperties, Access.internal, "csharp");
@@access(ZendeskLinkedServiceTypeProperties, Access.internal, "csharp");
