import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kusto;

@@clientName(Microsoft.Kusto, "KustoManagementClient", "javascript,python");
@@clientName(
  Microsoft.Kusto.ComponentsSgqdofSchemasIdentityPropertiesUserassignedidentitiesAdditionalproperties,
  "IdentityUserAssignedIdentities",
  "java"
);
@@clientName(Microsoft.Kusto.PublicIPType, "PublicIpType", "java");
@@clientName(
  Microsoft.Kusto.ClusterProperties.publicIPType,
  "publicIpType",
  "java"
);
@@access(CalloutPoliciesList, Access.public, "java");
@@access(LanguageExtensionsList, Access.public, "java");

@@clientName(IotHubDataFormat.W3CLOGFILE, "W3_CLOGFILE", "python");
@@clientName(EventHubDataFormat.W3CLOGFILE, "W3_CLOGFILE", "python");
@@clientName(EventGridDataFormat.W3CLOGFILE, "W3_CLOGFILE", "python");

// Suppress and rename OperationsResults.get to avoid duplicate Get/GetAsync methods
// (GA SDK removed OperationsResults_Get operation)
@@access(OperationsResultsOperationGroup.get, Access.internal, "csharp");
@@clientName(OperationsResultsOperationGroup.get, "GetOperationResult", "csharp");

// C# resource and model renames for backward compatibility with GA SDK
@@clientName(Cluster, "KustoCluster", "csharp");
@@clientName(Database, "KustoDatabase", "csharp");
@@clientName(AttachedDatabaseConfiguration, "KustoAttachedDatabaseConfiguration", "csharp");
@@clientName(ClusterPrincipalAssignment, "KustoClusterPrincipalAssignment", "csharp");
@@clientName(DatabasePrincipalAssignment, "KustoDatabasePrincipalAssignment", "csharp");
@@clientName(DataConnection, "KustoDataConnection", "csharp");
@@clientName(ManagedPrivateEndpoint, "KustoManagedPrivateEndpoint", "csharp");
@@clientName(PrivateEndpointConnection, "KustoPrivateEndpointConnection", "csharp");
@@clientName(PrivateLinkResource, "KustoPrivateLinkResource", "csharp");
@@clientName(Script, "KustoScript", "csharp");

// C# model renames from autorest.md rename-mapping
@@clientName(ClusterUpdate, "KustoClusterPatch", "csharp");
@@clientName(ProvisioningState, "KustoProvisioningState", "csharp");
@@clientName(AzureSku, "KustoSku", "csharp");
@@clientName(AzureResourceSku, "KustoAvailableSkuDetails", "csharp");
@@clientName(AcceptedAudiences, "AcceptedAudience", "csharp");
@@clientName(EngineType, "KustoClusterEngineType", "csharp");
@@clientName(KeyVaultProperties, "KustoKeyVaultProperties", "csharp");
@@clientName(PublicIPType, "KustoClusterPublicIPType", "csharp");
@@clientName(PublicNetworkAccess, "KustoClusterPublicNetworkAccess", "csharp");
@@clientName(ClusterNetworkAccessFlag, "KustoClusterNetworkAccessFlag", "csharp");
@@clientName(State, "KustoClusterState", "csharp");
@@clientName(VnetState, "KustoClusterVnetState", "csharp");
@@clientName(VirtualNetworkConfiguration, "KustoClusterVirtualNetworkConfiguration", "csharp");
@@clientName(PrincipalType, "KustoPrincipalAssignmentType", "csharp");
@@clientName(ClusterPrincipalRole, "KustoClusterPrincipalRole", "csharp");
@@clientName(Language, "SandboxCustomImageLanguage", "csharp");
@@clientName(LanguageExtension, "KustoLanguageExtension", "csharp");
@@clientName(LanguageExtensionsList, "KustoLanguageExtensionList", "csharp");
@@clientName(LanguageExtensionName, "KustoLanguageExtensionName", "csharp");
@@clientName(CheckNameResult, "KustoNameAvailabilityResult", "csharp");
@@clientName(DatabasePrincipalRole, "KustoDatabasePrincipalRole", "csharp");
@@clientName(DatabasePrincipalType, "KustoDatabasePrincipalType", "csharp");
@@clientName(DatabasePrincipal, "KustoDatabasePrincipal", "csharp");
@@clientName(DatabasePrincipalListRequest, "DatabasePrincipalList", "csharp");
@@clientName(DataConnectionValidation, "DataConnectionValidationContent", "csharp");
@@clientName(DataConnectionValidationListResult, "DataConnectionValidationResults", "csharp");
@@clientName(FollowerDatabaseDefinition, "KustoFollowerDatabaseDefinition", "csharp");
@@clientName(FollowerDatabaseDefinitionGet, "KustoFollowerDatabase", "csharp");
@@clientName(AzureCapacity, "KustoCapacity", "csharp");
@@clientName(AzureScaleType, "KustoScaleType", "csharp");
@@clientName(AzureSkuName, "KustoSkuName", "csharp");
@@clientName(AzureSkuTier, "KustoSkuTier", "csharp");
@@clientName(Reason, "KustoNameUnavailableReason", "csharp");
@@clientName(Compression, "EventHubMessagesCompressionType", "csharp");
@@clientName(DatabaseRouting, "KustoDatabaseRouting", "csharp");
@@clientName(EventGridDataConnection, "KustoEventGridDataConnection", "csharp");
@@clientName(EventGridDataFormat, "KustoEventGridDataFormat", "csharp");
@@clientName(EventHubDataConnection, "KustoEventHubDataConnection", "csharp");
@@clientName(EventHubDataFormat, "KustoEventHubDataFormat", "csharp");
@@clientName(CosmosDbDataConnection, "KustoCosmosDBDataConnection", "csharp");
@@clientName(IotHubDataConnection, "KustoIotHubDataConnection", "csharp");
@@clientName(IotHubDataFormat, "KustoIotHubDataFormat", "csharp");
@@clientName(ReadOnlyFollowingDatabase, "KustoReadOnlyFollowingDatabase", "csharp");
@@clientName(ReadWriteDatabase, "KustoReadWriteDatabase", "csharp");
@@clientName(SkuDescription, "KustoSkuDescription", "csharp");
@@clientName(SkuLocationInfoItem, "KustoSkuLocationInfoItem", "csharp");
@@clientName(PrincipalsModificationKind, "KustoDatabasePrincipalsModificationKind", "csharp");
@@clientName(DefaultPrincipalsModificationKind, "KustoDatabaseDefaultPrincipalsModificationKind", "csharp");
@@clientName(TableLevelSharingProperties, "KustoDatabaseTableLevelSharingProperties", "csharp");
@@clientName(TrustedExternalTenant, "KustoClusterTrustedExternalTenant", "csharp");
@@clientName(CallerRole, "KustoDatabaseCallerRole", "csharp");
@@clientName(DatabaseShareOrigin, "KustoDatabaseShareOrigin", "csharp");
@@clientName(LanguageExtensionImageName, "KustoLanguageExtensionImageName", "csharp");
@@clientName(ResourceSkuCapabilities, "KustoResourceSkuCapabilities", "csharp");
@@clientName(ResourceSkuZoneDetails, "KustoResourceSkuZoneDetails", "csharp");
@@clientName(SkuDescriptionList, "KustoSkuDescriptionList", "csharp");
@@clientName(OutboundAccess, "KustoCalloutPolicyOutboundAccess", "csharp");
@@clientName(ZoneStatus, "KustoClusterZoneStatus", "csharp");
@@clientName(ScriptLevel, "KustoScriptLevel", "csharp");
@@clientName(CalloutPolicy, "KustoCalloutPolicy", "csharp");
@@clientName(CalloutType, "KustoCalloutPolicyCalloutType", "csharp");
@@clientName(Kind, "KustoKind", "csharp");

// C# check-name request model renames
@@clientName(AttachedDatabaseConfigurationsCheckNameRequest, "KustoAttachedDatabaseConfigurationNameAvailabilityContent", "csharp");
@@clientName(ClusterPrincipalAssignmentCheckNameRequest, "KustoClusterPrincipalAssignmentNameAvailabilityContent", "csharp");
@@clientName(ManagedPrivateEndpointsCheckNameRequest, "KustoManagedPrivateEndpointNameAvailabilityContent", "csharp");
@@clientName(CheckNameRequest, "KustoDatabaseNameAvailabilityContent", "csharp");
@@clientName(DatabasePrincipalAssignmentCheckNameRequest, "KustoDatabasePrincipalAssignmentNameAvailabilityContent", "csharp");
@@clientName(DataConnectionCheckNameRequest, "KustoDataConnectionNameAvailabilityContent", "csharp");
@@clientName(ScriptCheckNameRequest, "KustoScriptNameAvailabilityContent", "csharp");
@@clientName(ClusterCheckNameRequest, "KustoClusterNameAvailabilityContent", "csharp");

// C# enum member renames
@@clientName(EventGridDataFormat.APACHEAVRO, "ApacheAvro", "csharp");
@@clientName(EventHubDataFormat.APACHEAVRO, "ApacheAvro", "csharp");
@@clientName(IotHubDataFormat.APACHEAVRO, "ApacheAvro", "csharp");
@@clientName(EventGridDataFormat.MULTIJSON, "MultiJson", "csharp");
@@clientName(EventGridDataFormat.CSV, "Csv", "csharp");
@@clientName(EventGridDataFormat.TSV, "Tsv", "csharp");
@@clientName(EventGridDataFormat.PSV, "Psv", "csharp");
@@clientName(EventGridDataFormat.TXT, "Txt", "csharp");
@@clientName(EventGridDataFormat.RAW, "Raw", "csharp");
@@clientName(EventGridDataFormat.SINGLEJSON, "SingleJson", "csharp");
@@clientName(EventGridDataFormat.ORC, "Orc", "csharp");
@@clientName(EventGridDataFormat.W3CLOGFILE, "W3CLogFile", "csharp");
@@clientName(EventHubDataFormat.MULTIJSON, "MultiJson", "csharp");
@@clientName(EventHubDataFormat.CSV, "Csv", "csharp");
@@clientName(EventHubDataFormat.TSV, "Tsv", "csharp");
@@clientName(EventHubDataFormat.PSV, "Psv", "csharp");
@@clientName(EventHubDataFormat.TXT, "Txt", "csharp");
@@clientName(EventHubDataFormat.RAW, "Raw", "csharp");
@@clientName(EventHubDataFormat.SINGLEJSON, "SingleJson", "csharp");
@@clientName(EventHubDataFormat.ORC, "Orc", "csharp");
@@clientName(EventHubDataFormat.W3CLOGFILE, "W3CLogFile", "csharp");
@@clientName(IotHubDataFormat.MULTIJSON, "MultiJson", "csharp");
@@clientName(IotHubDataFormat.CSV, "Csv", "csharp");
@@clientName(IotHubDataFormat.TSV, "Tsv", "csharp");
@@clientName(IotHubDataFormat.PSV, "Psv", "csharp");
@@clientName(IotHubDataFormat.TXT, "Txt", "csharp");
@@clientName(IotHubDataFormat.RAW, "Raw", "csharp");
@@clientName(IotHubDataFormat.SINGLEJSON, "SingleJson", "csharp");
@@clientName(IotHubDataFormat.ORC, "Orc", "csharp");
@@clientName(IotHubDataFormat.W3CLOGFILE, "W3CLogFile", "csharp");

// C# property renames
@@clientName(ClusterProperties.uri, "ClusterUri", "csharp");
@@clientName(ClusterProperties.enableAutoStop, "IsAutoStopEnabled", "csharp");
@@clientName(ClusterProperties.enableDiskEncryption, "IsDiskEncryptionEnabled", "csharp");
@@clientName(ClusterProperties.enableDoubleEncryption, "IsDoubleEncryptionEnabled", "csharp");
@@clientName(ClusterProperties.enablePurge, "IsPurgeEnabled", "csharp");
@@clientName(ClusterProperties.enableStreamingIngest, "IsStreamingIngestEnabled", "csharp");
@@clientName(ClusterPrincipalProperties.principalId, "ClusterPrincipalId", "csharp");
@@clientName(DatabasePrincipalProperties.principalId, "DatabasePrincipalId", "csharp");
@@clientName(ScriptProperties.continueOnErrors, "ShouldContinueOnErrors", "csharp");
@@clientName(ScriptProperties.scriptUrlSasToken, "ScriptUriSasToken", "csharp");
@@clientName(EventGridConnectionProperties.ignoreFirstRecord, "IsFirstRecordIgnored", "csharp");

// Missing type renames (old SDK names)
@@clientName(ClusterMigrateRequest, "ClusterMigrateContent", "csharp");
@@clientName(DatabaseInviteFollowerRequest, "DatabaseInviteFollowerContent", "csharp");
@@clientName(SandboxCustomImagesCheckNameRequest, "SandboxCustomImagesCheckNameContent", "csharp");

// Data format enum member renames (ALL_CAPS → PascalCase to match GA SDK)
@@clientName(EventGridDataFormat.JSON, "Json", "csharp");
@@clientName(EventGridDataFormat.AVRO, "Avro", "csharp");
@@clientName(EventGridDataFormat.SCSV, "Scsv", "csharp");
@@clientName(EventGridDataFormat.SOHSV, "Sohsv", "csharp");
@@clientName(EventGridDataFormat.TSVE, "Tsve", "csharp");
@@clientName(EventGridDataFormat.PARQUET, "Parquet", "csharp");
@@clientName(EventGridDataFormat.AZMONSTREAM, "AzmonStream", "csharp");
@@clientName(EventHubDataFormat.JSON, "Json", "csharp");
@@clientName(EventHubDataFormat.AVRO, "Avro", "csharp");
@@clientName(EventHubDataFormat.SCSV, "Scsv", "csharp");
@@clientName(EventHubDataFormat.SOHSV, "Sohsv", "csharp");
@@clientName(EventHubDataFormat.TSVE, "Tsve", "csharp");
@@clientName(EventHubDataFormat.PARQUET, "Parquet", "csharp");
@@clientName(EventHubDataFormat.AZMONSTREAM, "AzmonStream", "csharp");
@@clientName(IotHubDataFormat.JSON, "Json", "csharp");
@@clientName(IotHubDataFormat.AVRO, "Avro", "csharp");
@@clientName(IotHubDataFormat.SCSV, "Scsv", "csharp");
@@clientName(IotHubDataFormat.SOHSV, "Sohsv", "csharp");
@@clientName(IotHubDataFormat.TSVE, "Tsve", "csharp");
@@clientName(IotHubDataFormat.PARQUET, "Parquet", "csharp");
@@clientName(IotHubDataFormat.AZMONSTREAM, "AzmonStream", "csharp");

// SKU name casing (DevNoSLA → DevNoSla)
@@clientName(AzureSkuName.`Dev(No SLA)_Standard_D11_v2`, "DevNoSlaStandardD11V2", "csharp");
@@clientName(AzureSkuName.`Dev(No SLA)_Standard_E2a_v4`, "DevNoSlaStandardE2aV4", "csharp");

// LanguageExtensionName casing (PYTHON → Python)
@@clientName(LanguageExtensionName.PYTHON, "Python", "csharp");

// LanguageExtensionImageName (prevent underscore stripping by generator)
@@clientName(LanguageExtensionImageName.Python3_6_5, "Python3_6_5", "csharp");
@@clientName(LanguageExtensionImageName.Python3_10_8, "Python3_10_8", "csharp");
@@clientName(LanguageExtensionImageName.Python3_10_8_DL, "Python3_10_8_DL", "csharp");
@@clientName(LanguageExtensionImageName.Python3_11_7, "Python3_11_7", "csharp");
@@clientName(LanguageExtensionImageName.Python3_11_7_DL, "Python3_11_7_DL", "csharp");

// KustoDatabaseResourceType was enum in old SDK, now extensible enum struct — rename to match
// Kind enum is internal discriminator, renamed to KustoKind above

// ClusterUpdate base type — old SDK inherited from TrackedResourceData
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(ClusterUpdate, Azure.ResourceManager.Foundations.TrackedResource, "csharp");

// ResourceIdentifier property type annotations
@@alternateType(AttachedDatabaseConfigurationProperties.clusterResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(ManagedPrivateEndpointProperties.privateLinkResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(EventGridConnectionProperties.eventGridResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(EventGridConnectionProperties.eventHubResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(EventGridConnectionProperties.managedIdentityResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(EventGridConnectionProperties.storageAccountResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(EventHubConnectionProperties.eventHubResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(EventHubConnectionProperties.managedIdentityResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(IotHubConnectionProperties.iotHubResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(FollowerDatabaseDefinition.clusterResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(CosmosDbDataConnectionProperties.managedIdentityResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(CosmosDbDataConnectionProperties.cosmosDbAccountResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(FollowerDatabaseProperties.clusterResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(PrivateEndpointProperty.id, Azure.Core.armResourceIdentifier, "csharp");

// Uri type annotations (string → System.Uri)
@@alternateType(ClusterProperties.uri, url, "csharp");
@@alternateType(ClusterProperties.dataIngestionUri, url, "csharp");
@@alternateType(ScriptProperties.scriptUrl, url, "csharp");

// Property renames — casing and name fixes
@@clientName(PrivateEndpointConnectionProperties.privateLinkServiceConnectionState, "ConnectionState", "csharp");
@@clientName(EndpointDetail.ipAddress, "IPAddress", "csharp");
@@clientName(VirtualNetworkConfiguration.enginePublicIpId, "EnginePublicIPId", "csharp");
@@clientName(VirtualNetworkConfiguration.dataManagementPublicIpId, "DataManagementPublicIPId", "csharp");
@@clientName(CosmosDbDataConnectionProperties.cosmosDbAccountResourceId, "CosmosDBAccountResourceId", "csharp");
@@clientName(CosmosDbDataConnectionProperties.cosmosDbDatabase, "CosmosDBDatabase", "csharp");
@@clientName(CosmosDbDataConnectionProperties.cosmosDbContainer, "CosmosDBContainer", "csharp");
@@clientName(ClusterProperties.allowedIpRangeList, "AllowedIPRangeList", "csharp");

// Guid property renames — rename generated string properties so we can add Guid? compat shims
@@clientName(ClusterPrincipalProperties.tenantId, "TenantIdValue", "csharp");
@@clientName(ClusterPrincipalProperties.aadObjectId, "AadObjectIdValue", "csharp");
@@clientName(DatabasePrincipalProperties.tenantId, "TenantIdValue", "csharp");
@@clientName(DatabasePrincipalProperties.aadObjectId, "AadObjectIdValue", "csharp");
@@clientName(CosmosDbDataConnectionProperties.managedIdentityObjectId, "ManagedIdentityObjectIdValue", "csharp");
@@clientName(EventGridConnectionProperties.managedIdentityObjectId, "ManagedIdentityObjectIdValue", "csharp");
@@clientName(EventHubConnectionProperties.managedIdentityObjectId, "ManagedIdentityObjectIdValue", "csharp");

// Output-only types that need setters for backward compat
@@usage(EndpointDetail, Usage.input, "csharp");
@@usage(EndpointDependency, Usage.input, "csharp");
@@usage(OutboundNetworkDependenciesEndpointProperties, Usage.input, "csharp");
