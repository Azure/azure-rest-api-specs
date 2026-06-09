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
@@clientName(ActivityDependency, "PipelineActivityDependency", "csharp");
@@clientName(ActivityPolicy, "PipelineActivityPolicy", "csharp");
@@clientName(ActivityPolicy.secureInput, "IsSecureInputEnabled", "csharp");
@@clientName(ActivityPolicy.secureOutput, "IsSecureOutputEnabled", "csharp");
@@clientName(ActivityRun, "PipelineActivityRunInformation", "csharp");
@@clientName(ActivityRun.activityRunStart, "StartOn", "csharp");
@@clientName(ActivityRun.activityRunEnd, "EndOn", "csharp");
@@clientName(ActivityRunsQueryResponse, "PipelineActivityRunsResult", "csharp");
@@clientName(ActivityState, "PipelineActivityState", "csharp");
@@clientName(
  AddDataFlowToDebugSessionResponse,
  "DataFactoryDataFlowStartDebugSessionResult",
  "csharp"
);
@@clientName(AvroDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(AvroFormat, "DatasetAvroFormat", "csharp");
@@clientName(BinaryDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.ALL, "All", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.ONE, "One", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.TWO, "Two", "csharp");
@@clientName(WebHookActivityMethod.POST, "Post", "csharp");
@@clientName(
  CassandraSourceReadConsistencyLevels.LOCAL_ONE,
  "LocalOne",
  "csharp"
);
@@clientName(
  ChangeDataCaptureResource,
  "DataFactoryChangeDataCapture",
  "csharp"
);
@@clientName(
  ChangeDataCaptureListResponse,
  "ChangeDataCaptureListResult",
  "csharp"
);
@@clientName(CMKIdentityDefinition, "DataFactoryCmkIdentity", "csharp");
@@clientName(ConfigurationType, "DataFactorySparkConfigurationType", "csharp");
@@clientName(ConnectionType, "MapperConnectionType", "csharp");
@@clientName(CopySource, "CopyActivitySource", "csharp");
@@clientName(CopySource.type, "CopySourceType", "csharp");
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
@@clientName(CreateRunResponse, "PipelineCreateRunResult", "csharp");
@@clientName(
  CredentialListResponse,
  "DataFactoryCredentialListResult",
  "csharp"
);
@@clientName(DataFlow, "DataFactoryDataFlowProperties", "csharp");
@@clientName(DataFlowListResponse, "DataFactoryDataFlowListResult", "csharp");
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
@@clientName(DataFlowDebugSessionInfo.startTime, "StartOn", "csharp");
@@alternateType(DataFlowDebugSessionInfo.startTime, utcDateTime, "csharp");
@@clientName(
  DataFlowDebugSessionInfo.timeToLiveInMinutes,
  "TimeToLiveInMinutes",
  "csharp"
);
@@clientName(
  DataFlowDebugSessionInfo.lastActivityTime,
  "LastActivityOn",
  "csharp"
);
@@alternateType(
  DataFlowDebugSessionInfo.lastActivityTime,
  utcDateTime,
  "csharp"
);
@@clientName(DataFlowResource, "DataFactoryDataFlow", "csharp");
@@clientName(Dataset, "DataFactoryDatasetProperties", "csharp");
@@clientName(Dataset.type, "DatasetType", "csharp");
@@clientName(DatasetListResponse, "DataFactoryDatasetListResult", "csharp");
@@clientName(DatasetDataElement.name, "ColumnName", "csharp");
@@clientName(DatasetDataElement.type, "ColumnType", "csharp");
@@clientName(DatasetDebugResource, "DataFactoryDatasetDebugInfo", "csharp");
@@clientName(DatasetResource, "DataFactoryDataset", "csharp");
@@clientName(DatasetSchemaDataElement.name, "SchemaColumnName", "csharp");
@@clientName(DatasetSchemaDataElement.type, "SchemaColumnType", "csharp");
@@clientName(DatasetCompression.type, "DatasetCompressionType", "csharp");
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
@@clientName(ValueType, "DatasetSourceValueType", "csharp");
@@clientName(DayOfWeek, "DataFactoryDayOfWeek", "csharp");
@@clientName(DaysOfWeek, "DataFactoryDaysOfWeek", "csharp");
@@clientName(
  DelimitedTextDatasetTypeProperties.location,
  "DataLocation",
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
  ExposureControlBatchResponse,
  "ExposureControlBatchResult",
  "csharp"
);
@@clientName(
  ExposureControlBatchResponse.exposureControlResponses,
  "ExposureControlResults",
  "csharp"
);
@@clientName(ExposureControlRequest, "ExposureControlContent", "csharp");
@@clientName(ExposureControlResponse, "ExposureControlResult", "csharp");
@@clientName(ExpressionV2.value, "V2Value", "csharp");
@@clientName(Factory, "DataFactory", "csharp");
@@clientName(FactoryListResponse, "DataFactoryListResult", "csharp");
@@clientName(FactoryRepoUpdate, "FactoryRepoContent", "csharp");
@@alternateType(
  FactoryRepoUpdate.factoryResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(FrequencyType, "MapperPolicyRecurrenceFrequencyType", "csharp");
@@clientName(GetMetadataActivity, "GetDatasetMetadataActivity", "csharp");
@@clientName(GitHubClientSecret, "FactoryGitHubClientSecret", "csharp");
@@clientName(GitHubAccessTokenResponse, "GitHubAccessTokenResult", "csharp");
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
@@clientName(
  HDInsightActivityDebugInfoOption,
  "HDInsightActivityDebugInfoOptionSetting",
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
@@clientName(HttpSource, "DataFactoryHttpFileSource", "csharp");
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
  IntegrationRuntimeCustomerVirtualNetwork.subnetId,
  "SubnetId",
  "csharp"
);
@@alternateType(
  IntegrationRuntimeCustomerVirtualNetwork.subnetId,
  Azure.Core.armResourceIdentifier,
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
@@clientName(IntegrationRuntimeNodeIpAddress.ipAddress, "IPAddress", "csharp");
@@alternateType(
  IntegrationRuntimeNodeIpAddress.ipAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(
  IntegrationRuntimeOutboundNetworkDependenciesEndpointsResponse,
  "IntegrationRuntimeOutboundNetworkDependenciesResult",
  "csharp"
);
@@clientName(SalesforceV2Source.SOQLQuery, "SoqlQuery", "csharp");
@@clientName(SalesforceServiceCloudV2Source.SOQLQuery, "SoqlQuery", "csharp");
@@clientName(
  IntegrationRuntimeNodeIpAddress,
  "IntegrationRuntimeNodeIPAddress",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResources.getIpAddress,
  "GetIPAddressIntegrationRuntimeNode",
  "csharp"
);
@@clientName(
  IntegrationRuntimeResource,
  "DataFactoryIntegrationRuntime",
  "csharp"
);
@@clientName(
  IntegrationRuntimeStatusResponse,
  "DataFactoryIntegrationRuntimeStatusResult",
  "csharp"
);
@@clientName(IntegrationRuntimeVNetProperties.vNetId, "VnetId", "csharp");
@@clientName(IntegrationRuntimeStatus.type, "RuntimeType", "csharp");
@@alternateType(
  IntegrationRuntimeVNetProperties.vNetId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(IntegrationRuntimeVNetProperties.subnetId, "SubnetId", "csharp");
@@alternateType(
  IntegrationRuntimeVNetProperties.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(FactoryProperties.createTime, "CreatedOn", "csharp");
@@clientName(Flowlet, "DataFactoryFlowletProperties", "csharp");
@@clientName(JsonDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(JsonFormat, "DatasetJsonFormat", "csharp");
@@clientName(LinkedIntegrationRuntime.createTime, "CreatedOn", "csharp");
@@alternateType(
  LinkedIntegrationRuntimeRbacAuthorization.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(LinkedService, "DataFactoryLinkedServiceProperties", "csharp");
@@clientName(LinkedService.version, "LinkedServiceVersion", "csharp");
@@clientName(LinkedService.type, "LinkedServiceType", "csharp");
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
@@clientName(
  ManagedIdentityCredential,
  "DataFactoryManagedIdentityCredentialProperties",
  "csharp"
);
@@alternateType(
  ManagedIdentityTypeProperties.resourceId,
  Azure.Core.armResourceIdentifier,
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
@@alternateType(
  ManagedPrivateEndpoint.privateLinkResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PrivateEndpoint.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ArmIdWrapper.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  PurviewConfiguration.purviewResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  managedPrivateEndpointListResponse,
  "DataFactoryPrivateEndpointListResult",
  "csharp"
);
@@clientName(
  ManagedVirtualNetworkListResponse,
  "DataFactoryManagedVirtualNetworkListResult",
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
@@alternateType(ManagedVirtualNetwork.vNetId, Azure.Core.uuid, "csharp");
@@clientName(
  ManagedVirtualNetworkResource,
  "DataFactoryManagedVirtualNetwork",
  "csharp"
);
@@clientName(MappingDataFlow, "DataFactoryMappingDataFlowProperties", "csharp");
@@clientName(MetadataItem, "DataFactoryMetadataItemInfo", "csharp");
@@clientName(Office365Source.endTime, "EndOn", "csharp");
@@clientName(Office365Source.startTime, "StartOn", "csharp");
@@clientName(OrcDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(OrcFormat, "DatasetOrcFormat", "csharp");
@@clientName(OutputColumn, "Office365TableOutputColumn", "csharp");
@@clientName(ParameterSpecification, "EntityParameterSpecification", "csharp");
@@clientName(ParameterType, "EntityParameterType", "csharp");
@@clientName(ParquetDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(ParquetFormat, "DatasetParquetFormat", "csharp");
@@clientName(PipelineListResponse, "DataFactoryPipelineListResult", "csharp");
@@clientName(PipelineResource, "DataFactoryPipeline", "csharp");
@@clientName(PipelineRun, "DataFactoryPipelineRunInfo", "csharp");
@@clientName(PipelineRun.lastUpdated, "LastUpdatedOn", "csharp");
@@clientName(PipelineRun.runStart, "RunStartOn", "csharp");
@@clientName(PipelineRun.runEnd, "RunEndOn", "csharp");
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
  PrivateEndpointConnectionListResponse,
  "DataFactoryPrivateEndpointConnectionListResult",
  "csharp"
);
@@clientName(
  RemotePrivateEndpointConnection,
  "DataFactoryPrivateEndpointConnectionProperties",
  "csharp"
);
@@clientName(RunFilterParameters, "RunFilterContent", "csharp");
@@clientName(
  PrivateEndpointConnectionResource,
  "DataFactoryPrivateEndpointConnection",
  "csharp"
);
@@clientName(
  QueryDataFlowDebugSessionsResponse,
  "DataFlowDebugSessionInfoListResult",
  "csharp"
);
@@clientName(ScriptActivityParameterType.Timespan, "TimeSpan", "csharp");
@@clientName(
  ScriptActivityTypePropertiesLogSettings,
  "ScriptActivityTypeLogSettings",
  "csharp"
);
@@clientName(TarGZipReadSettings, "TarGzipReadSettings", "csharp");
@@clientName(ScriptActivityScriptBlock.type, "QueryType", "csharp");
@@clientName(WebActivityMethod.GET, "Get", "csharp");
@@clientName(WebActivityMethod.POST, "Post", "csharp");
@@clientName(WebActivityMethod.PUT, "Put", "csharp");
@@clientName(WebActivityMethod.DELETE, "Delete", "csharp");
@@clientName(SqlServerAuthenticationType.SQL, "Sql", "csharp");
@@clientName(AzureSqlDatabaseAuthenticationType.SQL, "Sql", "csharp");
@@clientName(AmazonRdsForSqlAuthenticationType.SQL, "Sql", "csharp");
@@clientName(SparkThriftTransportProtocol.SASL, "Sasl", "csharp");
@@clientName(SparkThriftTransportProtocol.`HTTP `, "Http", "csharp");
@@clientName(RunQueryOrder.ASC, "Asc", "csharp");
@@clientName(RunQueryOrder.DESC, "Desc", "csharp");
@@clientName(PrestoAuthenticationType.LDAP, "Ldap", "csharp");
// Map SecretBase and LinkedServiceReference to the external Azure.Core.Expressions.DataFactory types
// so baseline API surface matches (avoids exposing local DataFactorySecret/Reference classes).
@@alternateType(
  SecretBase,
  {
    identity: "Azure.Core.Expressions.DataFactory.DataFactorySecret",
  },
  "csharp"
);
@@alternateType(
  LinkedServiceReference,
  {
    identity: "Azure.Core.Expressions.DataFactory.DataFactoryLinkedServiceReference",
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
@@clientName(
  SelfHostedIntegrationRuntimeTypeProperties.selfContainedInteractiveAuthoringEnabled,
  "IsSelfContainedInteractiveAuthoringEnabled",
  "csharp"
);
@@clientName(SelfHostedIntegrationRuntimeNode.expiryTime, "ExpireOn", "csharp");
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
  SelfHostedIntegrationRuntimeStatusTypeProperties.autoUpdateETA,
  "AutoUpdateEta",
  "csharp"
);
@@alternateType(
  SelfHostedIntegrationRuntimeStatusTypeProperties.taskQueueId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(
  SelfHostedIntegrationRuntimeStatusTypeProperties.serviceUrls,
  "ServiceUriStringList",
  "csharp"
);
@@clientName(SubResourceDebugResource, "DataFactoryDebugInfo", "csharp");
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
@@clientName(SsisPackageLocationType.SSISDB, "SsisDB", "csharp");
@@clientName(SsisParameter, "SsisParameterInfo", "csharp");
@@clientName(SsisParameter.required, "IsRequired", "csharp");
@@clientName(SsisParameter.sensitive, "IsSensitive", "csharp");
@@clientName(SsisParameter.valueSet, "HasValueSet", "csharp");
@@clientName(SsisVariable.sensitive, "IsSensitive", "csharp");
@@clientName(SwitchCase, "SwitchCaseActivity", "csharp");
@@clientName(ScriptType, "DataFactoryScriptType", "csharp");
@@clientName(TextFormat, "DatasetTextFormat", "csharp");
@@clientName(Transformation, "DataFlowTransformation", "csharp");
@@clientName(Trigger, "DataFactoryTriggerProperties", "csharp");
@@clientName(TriggerListResponse, "DataFactoryTriggerListResult", "csharp");
@@clientName(TriggerQueryResponse, "DataFactoryTriggerQueryResult", "csharp");
@@clientName(TriggerResource, "DataFactoryTrigger", "csharp");
@@clientName(
  TriggerRunsQueryResponse,
  "DataFactoryTriggerRunsQueryResult",
  "csharp"
);
@@clientName(
  TriggerSubscriptionOperationStatus,
  "DataFactoryTriggerSubscriptionOperationResult",
  "csharp"
);
@@clientName(
  UserAccessPolicy,
  "DataFactoryDataPlaneUserAccessPolicy",
  "csharp"
);
@@clientName(UserAccessPolicy.startTime, "StartOn", "csharp");
@@alternateType(UserAccessPolicy.startTime, utcDateTime, "csharp");
@@clientName(UserAccessPolicy.expireTime, "ExpireOn", "csharp");
@@alternateType(UserAccessPolicy.expireTime, utcDateTime, "csharp");
@@clientName(UserProperty, "PipelineActivityUserProperty", "csharp");
@@clientName(VariableSpecification, "PipelineVariableSpecification", "csharp");
@@clientName(VariableType, "PipelineVariableType", "csharp");
@@clientName(
  WranglingDataFlow,
  "DataFactoryWranglingDataFlowProperties",
  "csharp"
);
@@clientName(XmlDatasetTypeProperties.location, "DataLocation", "csharp");
@@clientName(CredentialResource, "DataFactoryServiceCredential", "csharp");
@@clientName(
  AzureFunctionActivityTypeProperties.headers,
  "RequestHeaders",
  "csharp"
);
@@clientName(WebActivityTypeProperties.headers, "RequestHeaders", "csharp");
@@clientName(WebHookActivityTypeProperties.headers, "RequestHeaders", "csharp");
@@clientName(SapOdpLinkedServiceTypeProperties.sncMode, "SncFlag", "csharp");
@@clientName(SapTableLinkedServiceTypeProperties.sncMode, "SncFlag", "csharp");
@@clientName(StoreWriteSettings.type, "StoreWriteSettingsType", "csharp");
@@clientName(StoreReadSettings.type, "StoreReadSettingsType", "csharp");
@@clientName(SsisObjectMetadata.type, "MetadataType", "csharp");

// Force-rename shared/unions to their baseline DataFactory*-prefixed names so the
// generator emits a file with the matching name and downstream references resolve.
@@clientName(
  CassandraSourceReadConsistencyLevels,
  "CassandraSourceReadConsistencyLevel",
  "csharp"
);
@@clientName(Credential, "DataFactoryCredential", "csharp");
@@clientName(CredentialReference, "DataFactoryCredentialReference", "csharp");
@@clientName(
  EncryptionConfiguration,
  "DataFactoryEncryptionConfiguration",
  "csharp"
);
@@clientName(Expression, "DataFactoryExpression", "csharp");
@@clientName(ExpressionV2, "DataFactoryExpressionV2", "csharp");
@@clientName(GlobalParameterType, "DataFactoryGlobalParameterType", "csharp");
@@clientName(PackageStore, "DataFactoryPackageStore", "csharp");
@@clientName(PipelineReference, "DataFactoryPipelineReference", "csharp");
@@clientName(PublicNetworkAccess, "DataFactoryPublicNetworkAccess", "csharp");
@@clientName(RecurrenceFrequency, "DataFactoryRecurrenceFrequency", "csharp");
@@clientName(RecurrenceSchedule, "DataFactoryRecurrenceSchedule", "csharp");
@@clientName(
  RecurrenceScheduleOccurrence,
  "DataFactoryRecurrenceScheduleOccurrence",
  "csharp"
);
@@clientName(TriggerReference, "DataFactoryTriggerReference", "csharp");
@@clientName(TriggerRuntimeState, "DataFactoryTriggerRuntimeState", "csharp");

// RunQueryFilterOperator.Equals collides with ValueType.Equals on the generated
// readonly struct; baseline AutoRest SDK exposed this value as `EqualsValue`.
@@clientName(RunQueryFilterOperator.Equals, "EqualsValue", "csharp");

// Three `queryByFactory`-style operations share the same parameter signature on
// the resource client and collide after MPG flattens them onto DataFactoryResource.
// Match the baseline AutoRest method names to disambiguate.
@@clientName(Factories.queryByFactory, "getPipelineRuns", "csharp");
@@clientName(Factories.triggerRunsQueryByFactory, "getTriggerRuns", "csharp");
@@clientName(
  Factories.dataFlowDebugSessionQueryByFactory,
  "getDataFlowDebugSessions",
  "csharp"
);

// Rename `schema` properties on table-dataset type-properties to the baseline
// AutoRest flattened name `SchemaTypePropertiesSchema`, avoiding CS0108 hiding
// of `DataFactoryDatasetProperties.Schema` after MPG flattening.
@@clientName(
  AmazonRdsForOracleTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
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
@@clientName(
  AzurePostgreSqlTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  AzureSqlDWTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
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
  Db2TableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  DrillDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  GreenplumDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  HiveDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  ImpalaDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  JiraTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  LakeHouseTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  NetezzaTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  OracleTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  PhoenixDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
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
@@clientName(
  PrestoDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  SapHanaTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  SnowflakeDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  SparkDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
@@clientName(
  SqlServerTableDatasetTypeProperties.schema,
  "SchemaTypePropertiesSchema",
  "csharp"
);
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
@@alternateType(
  LocationIdParameter.locationId,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  UpdateIntegrationRuntimeRequest.updateDelayOffset,
  duration,
  "csharp"
);
@@alternateType(
  SelfHostedIntegrationRuntimeStatusTypeProperties.updateDelayOffset,
  duration,
  "csharp"
);
@@alternateType(
  SelfHostedIntegrationRuntimeStatusTypeProperties.localTimeZoneOffset,
  duration,
  "csharp"
);
@@clientName(Type, "LinkedServiceReferenceType", "csharp");

// Rename privateLinkResourcesGet to avoid colliding with Factory's canonical GetAsync on the resource.
@@clientName(
  Factories.privateLinkResourcesGet,
  "GetPrivateLinkResources",
  "csharp"
);

// MPG migration: restore baseline DataFactory* type names for back-compat.
// These map current generator-produced names (left) to the baseline AutoRest names (right).
@@clientName(AmazonMWSObjectDataset, "AmazonMwsObjectDataset", "csharp");
@@clientName(AmazonMWSLinkedService, "AmazonMwsLinkedService", "csharp");
@@clientName(AmazonMWSSource, "AmazonMwsSource", "csharp");
@@clientName(CosmosDbConnectionMode, "CosmosDBConnectionMode", "csharp");
@@clientName(
  CosmosDbSqlApiCollectionDataset,
  "CosmosDBSqlApiCollectionDataset",
  "csharp"
);
@@clientName(
  CosmosDbMongoDbApiCollectionDataset,
  "CosmosDBMongoDBApiCollectionDataset",
  "csharp"
);
@@clientName(CosmosDbLinkedService, "CosmosDBLinkedService", "csharp");
@@clientName(
  CosmosDbMongoDbApiLinkedService,
  "CosmosDBMongoDBApiLinkedService",
  "csharp"
);
@@clientName(CosmosDbSqlApiSource, "CosmosDBSqlApiSource", "csharp");
@@clientName(CosmosDbMongoDbApiSource, "CosmosDBMongoDBApiSource", "csharp");
@@clientName(CosmosDbSqlApiSink, "CosmosDBSqlApiSink", "csharp");
@@clientName(CosmosDbMongoDbApiSink, "CosmosDBMongoDBApiSink", "csharp");
@@clientName(MongoDbAuthenticationType, "MongoDBAuthenticationType", "csharp");
@@clientName(MongoDbCollectionDataset, "MongoDBCollectionDataset", "csharp");
@@clientName(
  MongoDbAtlasCollectionDataset,
  "MongoDBAtlasCollectionDataset",
  "csharp"
);
@@clientName(
  MongoDbV2CollectionDataset,
  "MongoDBV2CollectionDataset",
  "csharp"
);
@@clientName(MongoDbLinkedService, "MongoDBLinkedService", "csharp");
@@clientName(MongoDbAtlasLinkedService, "MongoDBAtlasLinkedService", "csharp");
@@clientName(MongoDbV2LinkedService, "MongoDBV2LinkedService", "csharp");
@@clientName(MongoDbSource, "MongoDBSource", "csharp");
@@clientName(MongoDbAtlasSource, "MongoDBAtlasSource", "csharp");
@@clientName(
  MongoDbCursorMethodsProperties,
  "MongoDBCursorMethodsProperties",
  "csharp"
);
@@clientName(MongoDbV2Source, "MongoDBV2Source", "csharp");
@@clientName(MongoDbAtlasSink, "MongoDBAtlasSink", "csharp");
@@clientName(MongoDbV2Sink, "MongoDBV2Sink", "csharp");
@@clientName(
  DocumentDbCollectionDataset,
  "DocumentDBCollectionDataset",
  "csharp"
);
@@clientName(
  DocumentDbCollectionSource,
  "DocumentDBCollectionSource",
  "csharp"
);
@@clientName(DocumentDbCollectionSink, "DocumentDBCollectionSink", "csharp");
@@clientName(SSISPackageLocation, "SsisPackageLocation", "csharp");
@@clientName(SSISAccessCredential, "SsisAccessCredential", "csharp");
@@clientName(SSISChildPackage, "SsisChildPackage", "csharp");
@@clientName(SSISExecutionCredential, "SsisExecutionCredential", "csharp");
@@clientName(SSISExecutionParameter, "SsisExecutionParameter", "csharp");
@@clientName(SSISPropertyOverride, "SsisPropertyOverride", "csharp");
@@clientName(SSISLogLocation, "SsisLogLocation", "csharp");
@@clientName(
  DataLakeAnalyticsUSQLActivity,
  "DataLakeAnalyticsUsqlActivity",
  "csharp"
);
@@clientName(SapBwCubeDataset, "SapBWCubeDataset", "csharp");
@@clientName(SapBwSource, "SapBWSource", "csharp");
@@clientName(
  IntegrationRuntimeVNetProperties,
  "IntegrationRuntimeVnetProperties",
  "csharp"
);
@@clientName(
  HDInsightOndemandClusterResourceGroupAuthenticationType,
  "HDInsightOnDemandClusterResourceGroupAuthenticationType",
  "csharp"
);
@@clientName(FactoryVSTSConfiguration, "FactoryVstsConfiguration", "csharp");
@@clientName(BlobEventsTrigger, "DataFactoryBlobEventsTrigger", "csharp");
@@clientName(BlobSink, "DataFactoryBlobSink", "csharp");
@@clientName(BlobSource, "DataFactoryBlobSource", "csharp");
@@clientName(BlobTrigger, "DataFactoryBlobTrigger", "csharp");
@@clientName(
  CredentialReferenceType,
  "DataFactoryCredentialReferenceType",
  "csharp"
);
@@clientName(ExpressionType, "DataFactoryExpressionType", "csharp");
@@clientName(ExpressionV2Type, "DataFactoryExpressionV2Type", "csharp");
@@clientName(HttpDataset, "DataFactoryHttpDataset", "csharp");
@@clientName(LogSettings, "DataFactoryLogSettings", "csharp");
@@clientName(
  PipelineReferenceType,
  "DataFactoryPipelineReferenceType",
  "csharp"
);
@@clientName(ScheduleTrigger, "DataFactoryScheduleTrigger", "csharp");
@@clientName(ScriptAction, "DataFactoryScriptAction", "csharp");
@@clientName(ScriptActivity, "DataFactoryScriptActivity", "csharp");
@@clientName(TriggerReferenceType, "DataFactoryTriggerReferenceType", "csharp");
@@clientName(TriggerRun, "DataFactoryTriggerRun", "csharp");
@@clientName(TriggerRunStatus, "DataFactoryTriggerRunStatus", "csharp");

// MPG migration: restore baseline TrackedResourceData inheritance for Factory (DataFactoryResource).
// Factory previously used Legacy.TrackedResourceWithOptionalLocation; switched to ProxyResource +
// hierarchyBuilding to expose Tags/Location while preserving the manual location? optionality on the wire.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Factory,
  Azure.ResourceManager.CommonTypes.TrackedResource,
  "csharp"
);

// MPG migration: backward-compat class renames (Request/Parameters → Content suffix to match previously published SDK).
@@clientName(
  ExposureControlBatchRequest,
  "ExposureControlBatchContent",
  "csharp"
);
@@clientName(GitHubAccessTokenRequest, "GitHubAccessTokenContent", "csharp");
@@clientName(
  IntegrationRuntimeRegenerateKeyParameters,
  "IntegrationRuntimeRegenerateKeyContent",
  "csharp"
);
@@clientName(
  LinkedIntegrationRuntimeRequest,
  "LinkedIntegrationRuntimeContent",
  "csharp"
);
@@clientName(
  CreateLinkedIntegrationRuntimeRequest,
  "CreateLinkedIntegrationRuntimeContent",
  "csharp"
);
@@clientName(
  GetSsisObjectMetadataRequest,
  "GetSsisObjectMetadataContent",
  "csharp"
);
@@clientName(
  UpdateIntegrationRuntimeNodeRequest,
  "UpdateIntegrationRuntimeNodeContent",
  "csharp"
);
@@clientName(
  EnableInteractiveQueryRequest,
  "EnableInteractiveQueryContent",
  "csharp"
);
@@clientName(TriggerFilterParameters, "TriggerFilterContent", "csharp");
@@clientName(
  DeleteDataFlowDebugSessionRequest,
  "DeleteDataFlowDebugSessionContent",
  "csharp"
);
@@clientName(
  DataFlowDebugCommandRequest,
  "DataFlowDebugCommandContent",
  "csharp"
);
@@clientName(
  PrivateLinkConnectionApprovalRequestResource,
  "DataFactoryPrivateEndpointConnectionCreateOrUpdateContent",
  "csharp"
);

// MPG migration: backward-compat property casing renames.
@@clientName(
  ChangeDataCapture.allowVNetOverride,
  "AllowVnetOverride",
  "csharp"
);
@@clientName(
  IntegrationRuntimeComputeProperties.vNetProperties,
  "VnetProperties",
  "csharp"
);

// MPG migration: map AzureKeyVaultSecretReference to the external
// Azure.Core.Expressions.DataFactory.DataFactoryKeyVaultSecret type so property
// types match the legacy SDK surface (avoids exposing local AzureKeyVaultSecretReference).
@@alternateType(
  AzureKeyVaultSecretReference,
  {
    identity: "Azure.Core.Expressions.DataFactory.DataFactoryKeyVaultSecret",
  },
  "csharp"
);

// MPG migration: rename TypeSpec `type` properties to back-compat names so the
// generator emits the legacy property names (e.g. ParameterType, ReferenceType).
@@clientName(ParameterSpecification.type, "ParameterType", "csharp");
@@clientName(Expression.type, "ExpressionType", "csharp");
@@clientName(CredentialReference.type, "ReferenceType", "csharp");
@@clientName(PipelineReference.type, "ReferenceType", "csharp");
@@clientName(TriggerReference.type, "ReferenceType", "csharp");
@@clientName(DataFlowReference.type, "ReferenceType", "csharp");
@@clientName(DatasetReference.type, "ReferenceType", "csharp");
@@clientName(IntegrationRuntimeReference.type, "ReferenceType", "csharp");
@@clientName(ManagedVirtualNetworkReference.type, "ReferenceType", "csharp");
@@clientName(
  BigDataPoolParametrizationReference.type,
  "ReferenceType",
  "csharp"
);
@@clientName(
  SparkConfigurationParametrizationReference.type,
  "ReferenceType",
  "csharp"
);
@@clientName(
  EntityReference.type,
  "IntegrationRuntimeEntityReferenceType",
  "csharp"
);
@@clientName(MapperAttributeMapping.type, "MappingType", "csharp");
@@clientName(MapperConnection.type, "ConnectionType", "csharp");
@@clientName(MapperConnectionReference.type, "ConnectionType", "csharp");
@@clientName(NotebookParameter.type, "ParameterType", "csharp");
@@clientName(VariableSpecification.type, "VariableType", "csharp");
@@clientName(ScriptActivityParameter.type, "ParameterType", "csharp");
@@clientName(SSISLogLocation.type, "LocationType", "csharp");
@@clientName(SSISPackageLocation.type, "LocationType", "csharp");
@@clientName(SynapseNotebookReference.type, "NotebookReferenceType", "csharp");
@@clientName(SynapseSparkJobReference.type, "SparkJobReferenceType", "csharp");
@@clientName(
  ManagedIntegrationRuntimeOperationResult.type,
  "ManagedIntegrationRuntimeOperationResultType",
  "csharp"
);
@@clientName(
  WebActivityAuthentication.type,
  "WebActivityAuthenticationType",
  "csharp"
);
@@clientName(
  PrestoLinkedServiceTypeProperties.timeZoneID,
  "TimeZoneId",
  "csharp"
);

// MPG migration: restore public parameterless ctor + settable properties on models
// that the generator otherwise marks output-only (loss of public ctor, read-only props).
// Using `Usage.input` alone is the canonical, proven pattern; the `Usage.input | Usage.output`
// form did not produce a public ctor in DataFactory's regen (ApiCompat MembersMustExist for `..ctor()`).
@@usage(OutputColumn, Usage.input, "csharp");
@@usage(ScriptType, Usage.input | Usage.output, "csharp");
@@usage(DatasetDataElement, Usage.input, "csharp");
@@usage(
  PrivateEndpointConnectionResource,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(RemotePrivateEndpointConnection, Usage.input | Usage.output, "csharp");
@@usage(DatasetSchemaDataElement, Usage.input, "csharp");
@@access(DatasetSchemaDataElement, Access.public, "csharp");

// MPG migration: GA shipped DataFactoryPrivateLinkResource + DataFactoryPrivateLinkResourceProperties
// with public parameterless ctor and settable Properties; spec marks all props @visibility(Read)
// so generator emits internal ctor + readonly props. Force input usage to restore the GA surface.
@@usage(PrivateLinkResource, Usage.input, "csharp");
@@usage(PrivateLinkResourceProperties, Usage.input, "csharp");

// MPG migration: enum value casing renames (back-compat with previously published SDK).
@@clientName(AzureSqlDWAuthenticationType.SQL, "Sql", "csharp");
@@clientName(AzureSqlMIAuthenticationType.SQL, "Sql", "csharp");
@@clientName(AzureFunctionActivityMethod.GET, "Get", "csharp");
@@clientName(AzureFunctionActivityMethod.POST, "Post", "csharp");
@@clientName(AzureFunctionActivityMethod.PUT, "Put", "csharp");
@@clientName(AzureFunctionActivityMethod.DELETE, "Delete", "csharp");
@@clientName(AzureFunctionActivityMethod.OPTIONS, "Options", "csharp");
@@clientName(AzureFunctionActivityMethod.HEAD, "Head", "csharp");
@@clientName(AzureFunctionActivityMethod.TRACE, "Trace", "csharp");
@@clientName(HiveThriftTransportProtocol.SASL, "Sasl", "csharp");
@@clientName(HiveThriftTransportProtocol.`HTTP `, "Http", "csharp");
@@clientName(ImpalaThriftTransportProtocol.HTTP, "Http", "csharp");
@@clientName(ImpalaAuthenticationType.SASLUsername, "SaslUsername", "csharp");
@@clientName(
  CassandraSourceReadConsistencyLevels.EACH_QUORUM,
  "EachQuorum",
  "csharp"
);
@@clientName(CassandraSourceReadConsistencyLevels.QUORUM, "Quorum", "csharp");
@@clientName(
  CassandraSourceReadConsistencyLevels.LOCAL_QUORUM,
  "LocalQuorum",
  "csharp"
);
@@clientName(CassandraSourceReadConsistencyLevels.THREE, "Three", "csharp");
@@clientName(CassandraSourceReadConsistencyLevels.SERIAL, "Serial", "csharp");
@@clientName(
  CassandraSourceReadConsistencyLevels.LOCAL_SERIAL,
  "LocalSerial",
  "csharp"
);

// MPG migration: rename BlobEventTypes -> DataFactoryBlobEventType to match previously published SDK.
@@clientName(BlobEventTypes, "DataFactoryBlobEventType", "csharp");

// MPG migration: property casing renames (ML*, ID -> Id) to match previously published SDK.
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
  AzureMLExecutePipelineActivityTypeProperties.mlPipelineId,
  "MLPipelineId",
  "csharp"
);
@@clientName(
  AzureMLExecutePipelineActivityTypeProperties.mlPipelineEndpointId,
  "MLPipelineEndpointId",
  "csharp"
);
@@clientName(
  AzureMLExecutePipelineActivityTypeProperties.mlPipelineParameters,
  "MLPipelineParameters",
  "csharp"
);
@@clientName(
  AzureMLExecutePipelineActivityTypeProperties.mlParentRunId,
  "MLParentRunId",
  "csharp"
);
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

// MPG migration: rename ExecuteSSISPackageActivity to ExecuteSsisPackageActivity for consistent casing.
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

// MPG migration: change ExpressionV2.type -> V2Type so the public surface keeps a single V2Type property.
@@clientName(ExpressionV2.type, "V2Type", "csharp");

// MPG migration: model CustomActivity.retentionTimeInDays as BinaryData (back-compat with previously published SDK).
@@alternateType(
  CustomActivityTypeProperties.retentionTimeInDays,
  unknown,
  "csharp"
);

// MPG migration: make PrivateLinkConnectionApprovalRequestResource (DataFactoryPrivateEndpointConnectionCreateOrUpdateContent)
// inherit from ResourceData instead of the spec's local SubResource (back-compat).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PrivateLinkConnectionApprovalRequestResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);

// MPG migration: make PrivateLinkResource (DataFactoryPrivateLinkResource) inherit from ResourceData
// instead of the spec's local SubResource (back-compat with the previously shipped GA contract).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  PrivateLinkResource,
  Azure.ResourceManager.CommonTypes.ProxyResource,
  "csharp"
);

// MPG migration: rename operations to match baseline AutoRest SDK method names so
// downstream consumers compile against the regenerated client without source breaks.
@@clientName(
  ExposureControlOperationGroup.getFeatureValue,
  "GetFeatureValueExposureControl",
  "csharp"
);
@@clientName(Factories.addDataFlow, "AddDataFlowToDebugSession", "csharp");
@@clientName(Factories.cancel, "CancelPipelineRun", "csharp");
@@clientName(Factories.create, "CreateDataFlowDebugSession", "csharp");
@@clientName(
  Factories.dataFlowDebugSessionDelete,
  "DeleteDataFlowDebugSession",
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
@@clientName(Factories.queryByPipelineRun, "GetActivityRun", "csharp");
@@clientName(
  Factories.queryFeatureValuesByFactory,
  "GetExposureControlFeatures",
  "csharp"
);
@@clientName(Factories.triggersQueryByFactory, "GetTriggers", "csharp");
@@clientName(
  FactoriesOperationGroup.configureFactoryRepo,
  "ConfigureFactoryRepoInformation",
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
@@clientName(TriggerResources.cancel, "CancelTriggerRun", "csharp");
@@clientName(TriggerResources.rerun, "RerunTriggerRun", "csharp");

// Project the ARM entity-tag (eTag) onto Azure.ETag for the C# surface so the published GA contract
// (Azure.ETag? ETag on each resource Data type) is preserved; the current emitter otherwise projects
// it as plain string for some of these resources.
@@alternateType(ChangeDataCaptureResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(CredentialResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(DataFlowResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(DatasetResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(GlobalParameterResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(IntegrationRuntimeResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(LinkedServiceResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(ManagedPrivateEndpointResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(ManagedVirtualNetworkResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(PipelineResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  PrivateEndpointConnectionResource.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(TriggerResource.etag, Azure.Core.eTag, "csharp");
@@alternateType(Factory.eTag, Azure.Core.eTag, "csharp");

// Rename the polymorphic discriminator property "type" on the remaining discriminated base models to
// the GA name "<Base>Type" (matching the previously shipped surface) so the generated discriminator
// constructor parameter / deserialization local is not emitted as the escaped identifier "@type".
@@clientName(Activity.type, "ActivityType", "csharp");
@@clientName(
  CompressionReadSettings.type,
  "CompressionReadSettingsType",
  "csharp"
);
@@clientName(CopySink.type, "CopySinkType", "csharp");
@@clientName(Credential.type, "CredentialType", "csharp");
@@clientName(CustomSetupBase.type, "CustomSetupBaseType", "csharp");
@@clientName(DataFlow.type, "DataFlowType", "csharp");
@@clientName(DatasetLocation.type, "DatasetLocationType", "csharp");
@@clientName(DatasetStorageFormat.type, "DatasetStorageFormatType", "csharp");
@@clientName(DependencyReference.type, "DependencyReferenceType", "csharp");
@@clientName(ExportSettings.type, "ExportSettingsType", "csharp");
@@clientName(
  FactoryRepoConfiguration.type,
  "FactoryRepoConfigurationType",
  "csharp"
);
@@clientName(FormatReadSettings.type, "FormatReadSettingsType", "csharp");
@@clientName(FormatWriteSettings.type, "FormatWriteSettingsType", "csharp");
@@clientName(ImportSettings.type, "ImportSettingsType", "csharp");
@@clientName(Trigger.type, "TriggerType", "csharp");
