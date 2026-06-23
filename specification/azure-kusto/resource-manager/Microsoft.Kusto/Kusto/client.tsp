import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using TypeSpec.Http;
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

// C# client customizations for Kusto MPG migration (preserve GA Azure.ResourceManager.Kusto names).
// Model/enum/property renames + property type adjustments mirror the previous AutoRest rename-mapping.

// Model and enum type renames
@@clientName(
  AttachedDatabaseConfiguration,
  "KustoAttachedDatabaseConfiguration",
  "csharp"
);
@@clientName(ProvisioningState, "KustoProvisioningState", "csharp");
@@clientName(Cluster, "KustoCluster", "csharp");
@@clientName(AzureSku, "KustoSku", "csharp");
@@clientName(AzureResourceSku, "KustoAvailableSkuDetails", "csharp");
@@clientName(AcceptedAudiences, "AcceptedAudience", "csharp");
@@clientName(EngineType, "KustoClusterEngineType", "csharp");
@@clientName(KeyVaultProperties, "KustoKeyVaultProperties", "csharp");
@@clientName(PublicIPType, "KustoClusterPublicIPType", "csharp");
@@clientName(PublicNetworkAccess, "KustoClusterPublicNetworkAccess", "csharp");
@@clientName(
  ClusterNetworkAccessFlag,
  "KustoClusterNetworkAccessFlag",
  "csharp"
);
@@clientName(State, "KustoClusterState", "csharp");
@@clientName(VnetState, "KustoClusterVnetState", "csharp");
@@clientName(
  VirtualNetworkConfiguration,
  "KustoClusterVirtualNetworkConfiguration",
  "csharp"
);
@@clientName(
  ClusterPrincipalAssignment,
  "KustoClusterPrincipalAssignment",
  "csharp"
);
@@clientName(PrincipalType, "KustoPrincipalAssignmentType", "csharp");
@@clientName(ClusterPrincipalRole, "KustoClusterPrincipalRole", "csharp");
@@clientName(Language, "SandboxCustomImageLanguage", "csharp");
@@clientName(LanguageExtension, "KustoLanguageExtension", "csharp");
@@clientName(LanguageExtensionsList, "KustoLanguageExtensionList", "csharp");
@@clientName(LanguageExtensionName, "KustoLanguageExtensionName", "csharp");
@@clientName(
  AttachedDatabaseConfigurationsCheckNameRequest,
  "KustoAttachedDatabaseConfigurationNameAvailabilityContent",
  "csharp"
);
@@clientName(
  ClusterPrincipalAssignmentCheckNameRequest,
  "KustoClusterPrincipalAssignmentNameAvailabilityContent",
  "csharp"
);
@@clientName(
  ManagedPrivateEndpointsCheckNameRequest,
  "KustoManagedPrivateEndpointNameAvailabilityContent",
  "csharp"
);
@@clientName(
  CheckNameRequest,
  "KustoDatabaseNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameResult, "KustoNameAvailabilityResult", "csharp");
@@clientName(Database, "KustoDatabase", "csharp");
@@clientName(
  DatabasePrincipalAssignment,
  "KustoDatabasePrincipalAssignment",
  "csharp"
);
@@clientName(DatabasePrincipalRole, "KustoDatabasePrincipalRole", "csharp");
@@clientName(DatabasePrincipalType, "KustoDatabasePrincipalType", "csharp");
@@clientName(DatabasePrincipal, "KustoDatabasePrincipal", "csharp");
@@clientName(DatabasePrincipalListRequest, "DatabasePrincipalList", "csharp");
@@clientName(
  DatabasePrincipalAssignmentCheckNameRequest,
  "KustoDatabasePrincipalAssignmentNameAvailabilityContent",
  "csharp"
);
@@clientName(
  DataConnectionCheckNameRequest,
  "KustoDataConnectionNameAvailabilityContent",
  "csharp"
);
@@clientName(
  ScriptCheckNameRequest,
  "KustoScriptNameAvailabilityContent",
  "csharp"
);
@@clientName(
  DataConnectionValidation,
  "DataConnectionValidationContent",
  "csharp"
);
@@clientName(
  DataConnectionValidationListResult,
  "DataConnectionValidationResults",
  "csharp"
);
@@clientName(DataConnection, "KustoDataConnection", "csharp");
@@clientName(ManagedPrivateEndpoint, "KustoManagedPrivateEndpoint", "csharp");
@@clientName(Script, "KustoScript", "csharp");
@@clientName(
  ClusterCheckNameRequest,
  "KustoClusterNameAvailabilityContent",
  "csharp"
);
@@clientName(Type, "KustoDatabaseResourceType", "csharp");
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
@@clientName(
  FollowerDatabaseDefinition,
  "KustoFollowerDatabaseDefinition",
  "csharp"
);
@@clientName(IotHubDataConnection, "KustoIotHubDataConnection", "csharp");
@@clientName(IotHubDataFormat, "KustoIotHubDataFormat", "csharp");
@@clientName(
  ReadOnlyFollowingDatabase,
  "KustoReadOnlyFollowingDatabase",
  "csharp"
);
@@clientName(ReadWriteDatabase, "KustoReadWriteDatabase", "csharp");
@@clientName(SkuDescription, "KustoSkuDescription", "csharp");
@@clientName(SkuLocationInfoItem, "KustoSkuLocationInfoItem", "csharp");
@@clientName(
  PrincipalsModificationKind,
  "KustoDatabasePrincipalsModificationKind",
  "csharp"
);
@@clientName(
  DefaultPrincipalsModificationKind,
  "KustoDatabaseDefaultPrincipalsModificationKind",
  "csharp"
);
@@clientName(
  TableLevelSharingProperties,
  "KustoDatabaseTableLevelSharingProperties",
  "csharp"
);
@@clientName(
  TrustedExternalTenant,
  "KustoClusterTrustedExternalTenant",
  "csharp"
);
@@clientName(CallerRole, "KustoDatabaseCallerRole", "csharp");
@@clientName(DatabaseShareOrigin, "KustoDatabaseShareOrigin", "csharp");
@@clientName(
  LanguageExtensionImageName,
  "KustoLanguageExtensionImageName",
  "csharp"
);
@@clientName(ResourceSkuCapabilities, "KustoResourceSkuCapabilities", "csharp");
@@clientName(ResourceSkuZoneDetails, "KustoResourceSkuZoneDetails", "csharp");
@@clientName(SkuDescriptionList, "kustoSkuDescriptionList", "csharp");
@@clientName(OutboundAccess, "KustoCalloutPolicyOutboundAccess", "csharp");
@@clientName(ZoneStatus, "KustoClusterZoneStatus", "csharp");
@@clientName(ScriptLevel, "KustoScriptLevel", "csharp");
@@clientName(FollowerDatabaseDefinitionGet, "KustoFollowerDatabase", "csharp");
@@clientName(CalloutPolicy, "KustoCalloutPolicy", "csharp");
@@clientName(CalloutType, "KustoCalloutPolicyCalloutType", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "KustoPrivateEndpointConnection",
  "csharp"
);
@@clientName(PrivateLinkResource, "KustoPrivateLinkResource", "csharp");

// Enum value renames
@@clientName(EventGridDataFormat.APACHEAVRO, "ApacheAvro", "csharp");
@@clientName(EventHubDataFormat.APACHEAVRO, "ApacheAvro", "csharp");
@@clientName(IotHubDataFormat.APACHEAVRO, "ApacheAvro", "csharp");
@@clientName(
  AzureSkuName.`Dev(No SLA)_Standard_D11_v2`,
  "DevNoSlaStandardD11V2",
  "csharp"
);
@@clientName(
  AzureSkuName.`Dev(No SLA)_Standard_E2a_v4`,
  "DevNoSlaStandardE2aV4",
  "csharp"
);
@@clientName(AzureSkuName.Standard_D32d_v4, "StandardD32dV4", "csharp");
@@clientName(AzureSkuName.Standard_D16d_v5, "StandardD16dV5", "csharp");
@@clientName(AzureSkuName.Standard_D32d_v5, "StandardD32dV5", "csharp");
@@clientName(AzureSkuName.Standard_L4s, "StandardL4s", "csharp");
@@clientName(AzureSkuName.Standard_L8s, "StandardL8s", "csharp");
@@clientName(AzureSkuName.Standard_L16s, "StandardL16s", "csharp");
@@clientName(AzureSkuName.Standard_L8s_v2, "StandardL8sV2", "csharp");
@@clientName(AzureSkuName.Standard_L16s_v2, "StandardL16sV2", "csharp");
@@clientName(AzureSkuName.Standard_E64i_v3, "StandardE64iV3", "csharp");
@@clientName(AzureSkuName.Standard_E80ids_v4, "StandardE80idsV4", "csharp");
@@clientName(AzureSkuName.Standard_E2a_v4, "StandardE2aV4", "csharp");
@@clientName(AzureSkuName.Standard_E4a_v4, "StandardE4aV4", "csharp");
@@clientName(AzureSkuName.Standard_E8a_v4, "StandardE8aV4", "csharp");
@@clientName(AzureSkuName.Standard_E16a_v4, "StandardE16aV4", "csharp");
@@clientName(
  AzureSkuName.`Standard_E8as_v4+1TB_PS`,
  "StandardE8asV41TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E8as_v4+2TB_PS`,
  "StandardE8asV42TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16as_v4+3TB_PS`,
  "StandardE16asV43TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16as_v4+4TB_PS`,
  "StandardE16asV44TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E8as_v5+1TB_PS`,
  "StandardE8asV51TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E8as_v5+2TB_PS`,
  "StandardE8asV52TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16as_v5+3TB_PS`,
  "StandardE16asV53TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16as_v5+4TB_PS`,
  "StandardE16asV54TBPS",
  "csharp"
);
@@clientName(AzureSkuName.Standard_E2ads_v5, "StandardE2adsV5", "csharp");
@@clientName(AzureSkuName.Standard_E4ads_v5, "StandardE4adsV5", "csharp");
@@clientName(AzureSkuName.Standard_E8ads_v5, "StandardE8adsV5", "csharp");
@@clientName(AzureSkuName.Standard_E16ads_v5, "StandardE16adsV5", "csharp");
@@clientName(
  AzureSkuName.`Standard_E8s_v4+1TB_PS`,
  "StandardE8sV41TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E8s_v4+2TB_PS`,
  "StandardE8sV42TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16s_v4+3TB_PS`,
  "StandardE16sV43TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16s_v4+4TB_PS`,
  "StandardE16sV44TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E8s_v5+1TB_PS`,
  "StandardE8sV51TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E8s_v5+2TB_PS`,
  "StandardE8sV52TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16s_v5+3TB_PS`,
  "StandardE16sV53TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_E16s_v5+4TB_PS`,
  "StandardE16sV54TBPS",
  "csharp"
);
@@clientName(AzureSkuName.Standard_L8s_v3, "StandardL8sV3", "csharp");
@@clientName(AzureSkuName.Standard_L16s_v3, "StandardL16sV3", "csharp");
@@clientName(AzureSkuName.Standard_L32s_v3, "StandardL32sV3", "csharp");
@@clientName(AzureSkuName.Standard_L8as_v3, "StandardL8asV3", "csharp");
@@clientName(AzureSkuName.Standard_L16as_v3, "StandardL16asV3", "csharp");
@@clientName(AzureSkuName.Standard_L32as_v3, "StandardL32asV3", "csharp");
@@clientName(
  AzureSkuName.`Standard_EC8as_v5+1TB_PS`,
  "StandardEC8asV51TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_EC8as_v5+2TB_PS`,
  "StandardEC8asV52TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_EC16as_v5+3TB_PS`,
  "StandardEC16asV53TBPS",
  "csharp"
);
@@clientName(
  AzureSkuName.`Standard_EC16as_v5+4TB_PS`,
  "StandardEC16asV54TBPS",
  "csharp"
);
@@clientName(AzureSkuName.Standard_EC8ads_v5, "StandardEC8adsV5", "csharp");
@@clientName(AzureSkuName.Standard_EC16ads_v5, "StandardEC16adsV5", "csharp");
@@clientName(AzureSkuName.Standard_E2d_v4, "StandardE2dV4", "csharp");
@@clientName(AzureSkuName.Standard_E4d_v4, "StandardE4dV4", "csharp");
@@clientName(AzureSkuName.Standard_E8d_v4, "StandardE8dV4", "csharp");
@@clientName(AzureSkuName.Standard_E16d_v4, "StandardE16dV4", "csharp");
@@clientName(AzureSkuName.Standard_E2d_v5, "StandardE2dV5", "csharp");
@@clientName(AzureSkuName.Standard_E4d_v5, "StandardE4dV5", "csharp");
@@clientName(AzureSkuName.Standard_E8d_v5, "StandardE8dV5", "csharp");
@@clientName(AzureSkuName.Standard_E16d_v5, "StandardE16dV5", "csharp");
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

// Property renames
@@clientName(ClusterProperties.uri, "ClusterUri", "csharp");
@@clientName(ClusterProperties.enableAutoStop, "IsAutoStopEnabled", "csharp");
@@clientName(
  ClusterProperties.enableDiskEncryption,
  "IsDiskEncryptionEnabled",
  "csharp"
);
@@clientName(
  ClusterProperties.enableDoubleEncryption,
  "IsDoubleEncryptionEnabled",
  "csharp"
);
@@clientName(ClusterProperties.enablePurge, "IsPurgeEnabled", "csharp");
@@clientName(
  ClusterProperties.enableStreamingIngest,
  "IsStreamingIngestEnabled",
  "csharp"
);
@@clientName(
  ClusterPrincipalProperties.principalId,
  "ClusterPrincipalId",
  "csharp"
);
@@clientName(
  DatabasePrincipalProperties.principalId,
  "DatabasePrincipalId",
  "csharp"
);
@@clientName(
  ScriptProperties.continueOnErrors,
  "ShouldContinueOnErrors",
  "csharp"
);
@@clientName(ScriptProperties.scriptUrlSasToken, "ScriptUriSasToken", "csharp");
@@clientName(
  EventGridConnectionProperties.ignoreFirstRecord,
  "IsFirstRecordIgnored",
  "csharp"
);

// Property type adjustments (arm-id/uuid/azure-location)
@@alternateType(
  AttachedDatabaseConfigurationProperties.clusterResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ClusterPrincipalProperties.aadObjectId, uuid, "csharp");
@@alternateType(DatabasePrincipalProperties.aadObjectId, uuid, "csharp");
@@alternateType(
  ManagedPrivateEndpointProperties.privateLinkResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EventGridConnectionProperties.eventGridResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EventGridConnectionProperties.eventHubResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EventGridConnectionProperties.managedIdentityResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EventGridConnectionProperties.storageAccountResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EventGridConnectionProperties.managedIdentityObjectId,
  uuid,
  "csharp"
);
@@alternateType(
  EventHubConnectionProperties.eventHubResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EventHubConnectionProperties.managedIdentityResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EventHubConnectionProperties.managedIdentityObjectId,
  uuid,
  "csharp"
);
@@alternateType(
  CosmosDbDataConnectionProperties.managedIdentityResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  CosmosDbDataConnectionProperties.managedIdentityObjectId,
  uuid,
  "csharp"
);
@@alternateType(
  CosmosDbDataConnectionProperties.cosmosDbAccountResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  FollowerDatabaseDefinition.clusterResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IotHubConnectionProperties.iotHubResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(SkuDescription.locations, azureLocation[], "csharp");
@@alternateType(
  FollowerDatabaseProperties.clusterResourceId,
  armResourceIdentifier,
  "csharp"
);

// Hide operation-results endpoints from the C# client to match the GA Azure.ResourceManager.Kusto surface
// (the previous AutoRest config removed OperationsResults_Get; both share one LRO route and were not public).
@@access(OperationsResultsOperationGroup.get, Access.internal, "csharp");
@@access(
  OperationsResultsOperationGroup.getLocation,
  Access.internal,
  "csharp"
);
@@clientName(
  OperationsResultsOperationGroup.getLocation,
  "GetOperationResultLocation",
  "csharp"
);

// Resource envelope `id` is arm-id in C#. common-types v3 models it as a plain string, so without this
// the generated ResourceData ctors take `string id` and fail to call base(ResourceIdentifier id).
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  armResourceIdentifier,
  "csharp"
);

// Restore the GA check-name `ResourceType` enums for C#. The TypeSpec models each check-name
// request `type` as a constant string literal, but the GA SDK exposed a public extensible enum
// plus a `ResourceType` property; these csharp-only types/decorators keep that surface.
#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union KustoClusterType {
  string,

  /** Microsoft.Kusto/clusters */
  MicrosoftKustoClusters: "Microsoft.Kusto/clusters",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union AttachedDatabaseType {
  string,

  /** Microsoft.Kusto/clusters/attachedDatabaseConfigurations */
  MicrosoftKustoClustersAttachedDatabaseConfigurations: "Microsoft.Kusto/clusters/attachedDatabaseConfigurations",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union KustoScriptType {
  string,

  /** Microsoft.Kusto/clusters/databases/scripts */
  MicrosoftKustoClustersDatabasesScripts: "Microsoft.Kusto/clusters/databases/scripts",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union KustoDataConnectionType {
  string,

  /** Microsoft.Kusto/clusters/databases/dataConnections */
  MicrosoftKustoClustersDatabasesDataConnections: "Microsoft.Kusto/clusters/databases/dataConnections",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union KustoManagedPrivateEndpointsType {
  string,

  /** Microsoft.Kusto/clusters/managedPrivateEndpoints */
  MicrosoftKustoClustersManagedPrivateEndpoints: "Microsoft.Kusto/clusters/managedPrivateEndpoints",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union KustoClusterPrincipalAssignmentType {
  string,

  /** Microsoft.Kusto/clusters/principalAssignments */
  MicrosoftKustoClustersPrincipalAssignments: "Microsoft.Kusto/clusters/principalAssignments",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union KustoDatabasePrincipalAssignmentType {
  string,

  /** Microsoft.Kusto/clusters/databases/principalAssignments */
  MicrosoftKustoClustersDatabasesPrincipalAssignments: "Microsoft.Kusto/clusters/databases/principalAssignments",
}

@@alternateType(ClusterCheckNameRequest.type, KustoClusterType, "csharp");
@@clientName(ClusterCheckNameRequest.type, "ResourceType", "csharp");
@@alternateType(
  AttachedDatabaseConfigurationsCheckNameRequest.type,
  AttachedDatabaseType,
  "csharp"
);
@@clientName(
  AttachedDatabaseConfigurationsCheckNameRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(ScriptCheckNameRequest.type, KustoScriptType, "csharp");
@@clientName(ScriptCheckNameRequest.type, "ResourceType", "csharp");
@@alternateType(
  DataConnectionCheckNameRequest.type,
  KustoDataConnectionType,
  "csharp"
);
@@clientName(DataConnectionCheckNameRequest.type, "ResourceType", "csharp");
@@alternateType(
  ManagedPrivateEndpointsCheckNameRequest.type,
  KustoManagedPrivateEndpointsType,
  "csharp"
);
@@clientName(
  ManagedPrivateEndpointsCheckNameRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(
  ClusterPrincipalAssignmentCheckNameRequest.type,
  KustoClusterPrincipalAssignmentType,
  "csharp"
);
@@clientName(
  ClusterPrincipalAssignmentCheckNameRequest.type,
  "ResourceType",
  "csharp"
);
@@alternateType(
  DatabasePrincipalAssignmentCheckNameRequest.type,
  KustoDatabasePrincipalAssignmentType,
  "csharp"
);
@@clientName(
  DatabasePrincipalAssignmentCheckNameRequest.type,
  "ResourceType",
  "csharp"
);

// ---- Migration compat batch 2: operation/type/enum names to match GA Azure.ResourceManager.Kusto ----

// Operation method names (GA C# names)
@@clientName(
  Clusters.checkNameAvailability,
  "CheckKustoClusterPrincipalAssignmentNameAvailability",
  "csharp"
);
@@clientName(
  Clusters.databasesCheckNameAvailability,
  "CheckKustoDatabaseNameAvailability",
  "csharp"
);
@@clientName(
  Clusters.attachedDatabaseConfigurationsCheckNameAvailability,
  "CheckKustoAttachedDatabaseConfigurationNameAvailability",
  "csharp"
);
@@clientName(
  Clusters.managedPrivateEndpointsCheckNameAvailability,
  "CheckKustoManagedPrivateEndpointNameAvailability",
  "csharp"
);
@@clientName(
  Clusters.sandboxCustomImagesCheckNameAvailability,
  "CheckNameAvailabilitySandboxCustomImage",
  "csharp"
);
@@clientName(Clusters.listSkusByResource, "GetAvailableSkus", "csharp");
@@clientName(
  Databases.checkNameAvailability,
  "CheckKustoDatabasePrincipalAssignmentNameAvailability",
  "csharp"
);
@@clientName(
  Databases.scriptsCheckNameAvailability,
  "CheckKustoScriptNameAvailability",
  "csharp"
);
@@clientName(
  Databases.dataConnectionsCheckNameAvailability,
  "CheckKustoDataConnectionNameAvailability",
  "csharp"
);
@@clientName(
  Databases.dataConnectionValidation,
  "ValidateDataConnection",
  "csharp"
);
@@clientName(Databases.inviteFollower, "InviteFollowerDatabase", "csharp");
@@clientName(
  ClustersOperationGroup.checkNameAvailability,
  "CheckKustoClusterNameAvailability",
  "csharp"
);
@@clientName(ClustersOperationGroup.listSkus, "GetKustoEligibleSkus", "csharp");
@@clientName(SkusOperationGroup.list, "GetSkus", "csharp");

// Type renames
@@clientName(ClusterMigrateRequest, "ClusterMigrateContent", "csharp");
@@clientName(
  DatabaseInviteFollowerRequest,
  "DatabaseInviteFollowerContent",
  "csharp"
);
@@clientName(
  SandboxCustomImagesCheckNameRequest,
  "SandboxCustomImagesCheckNameContent",
  "csharp"
);

// 8th check-name ResourceType enum (sandbox custom images)
#suppress "@azure-tools/typespec-azure-core/documentation-required" "csharp GA compat"
union SandboxCustomImageType {
  string,

  /** Microsoft.Kusto/clusters/sandboxCustomImages */
  MicrosoftKustoClustersSandboxCustomImages: "Microsoft.Kusto/clusters/sandboxCustomImages",
}

@@alternateType(
  SandboxCustomImagesCheckNameRequest.type,
  SandboxCustomImageType,
  "csharp"
);
@@clientName(SandboxCustomImagesCheckNameRequest.type, "ImageType", "csharp");
@@clientName(CheckNameRequest.type, "ResourceType", "csharp");

// DataFormat enum values (GA PascalCase)
@@clientName(EventGridDataFormat.JSON, "Json", "csharp");
@@clientName(EventGridDataFormat.SCSV, "Scsv", "csharp");
@@clientName(EventGridDataFormat.SOHSV, "Sohsv", "csharp");
@@clientName(EventGridDataFormat.AVRO, "Avro", "csharp");
@@clientName(EventGridDataFormat.TSVE, "Tsve", "csharp");
@@clientName(EventGridDataFormat.PARQUET, "Parquet", "csharp");
@@clientName(EventHubDataFormat.JSON, "Json", "csharp");
@@clientName(EventHubDataFormat.SCSV, "Scsv", "csharp");
@@clientName(EventHubDataFormat.SOHSV, "Sohsv", "csharp");
@@clientName(EventHubDataFormat.AVRO, "Avro", "csharp");
@@clientName(EventHubDataFormat.TSVE, "Tsve", "csharp");
@@clientName(EventHubDataFormat.PARQUET, "Parquet", "csharp");
@@clientName(IotHubDataFormat.JSON, "Json", "csharp");
@@clientName(IotHubDataFormat.SCSV, "Scsv", "csharp");
@@clientName(IotHubDataFormat.SOHSV, "Sohsv", "csharp");
@@clientName(IotHubDataFormat.AVRO, "Avro", "csharp");
@@clientName(IotHubDataFormat.TSVE, "Tsve", "csharp");
@@clientName(IotHubDataFormat.PARQUET, "Parquet", "csharp");

// Language extension enum values (GA names)
@@clientName(LanguageExtensionName.PYTHON, "Python", "csharp");

// ---- Migration compat batch 3: property name/type fixes to match GA ----
@@clientName(ScriptProperties.scriptUrl, "ScriptUri", "csharp");
@@alternateType(ScriptProperties.scriptUrl, url, "csharp");
@@alternateType(ClusterProperties.uri, url, "csharp");
@@clientName(ClusterProperties.dataIngestionUri, "DataIngestionUri", "csharp");
@@alternateType(ClusterProperties.dataIngestionUri, url, "csharp");
@@clientName(
  ClusterProperties.allowedIpRangeList,
  "AllowedIPRangeList",
  "csharp"
);
@@clientName(
  CosmosDbDataConnectionProperties.cosmosDbDatabase,
  "CosmosDBDatabase",
  "csharp"
);
@@clientName(
  CosmosDbDataConnectionProperties.cosmosDbContainer,
  "CosmosDBContainer",
  "csharp"
);
@@clientName(
  CosmosDbDataConnectionProperties.cosmosDbAccountResourceId,
  "CosmosDBAccountResourceId",
  "csharp"
);
@@clientName(
  VirtualNetworkConfiguration.enginePublicIpId,
  "EnginePublicIPId",
  "csharp"
);
@@clientName(
  VirtualNetworkConfiguration.dataManagementPublicIpId,
  "DataManagementPublicIPId",
  "csharp"
);

@@alternateType(Cluster.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  Cluster.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(
  ClusterProperties.languageExtensions,
  LanguageExtension[],
  "csharp"
);
@@clientName(
  ClusterProperties.languageExtensions,
  "LanguageExtensionsValue",
  "csharp"
);

@@alternateType(ClusterPrincipalProperties.tenantId, uuid, "csharp");
@@alternateType(DatabasePrincipalProperties.tenantId, uuid, "csharp");
@@alternateType(
  AttachedDatabaseConfiguration.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(DataConnection.location, Azure.Core.azureLocation, "csharp");

@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);
@@alternateType(
  PrivateEndpointProperty.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Database.location, Azure.Core.azureLocation, "csharp");
@@clientName(DatabasePrincipal.type, "PrincipalType", "csharp");
@@clientName(EndpointDetail.ipAddress, "IPAddress", "csharp");
@@usage(EndpointDetail, Usage.input | Usage.output, "csharp");
@@usage(EndpointDependency, Usage.input | Usage.output, "csharp");
@@usage(
  OutboundNetworkDependenciesEndpoint,
  Usage.input | Usage.output,
  "csharp"
);

// Restore GA pageable return type for the database principal add/remove actions.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "csharp GA compat"
@@markAsPageable(Databases.addPrincipals, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "csharp GA compat"
@@markAsPageable(Databases.removePrincipals, "csharp");
@@alternateType(
  ClustersOperationGroup.checkNameAvailability::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  SkusOperationGroup.list::parameters.location,
  Azure.Core.azureLocation,
  "csharp"
);

// PrivateLinkResource is read-only; GA still exposed a public ctor on the data model. Mark it as input
// for C# so the generated KustoPrivateLinkResourceData gets a public constructor (and is not sealed).
@@usage(PrivateLinkResource, Usage.input | Usage.output, "csharp");

/**
 * Class representing an update to a Kusto cluster.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model KustoClusterPatch
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * The SKU of the cluster.
   */
  sku?: AzureSku;

  /**
   * The availability zones of the cluster.
   */
  zones?: string[];

  /**
   * The identity of the cluster, if configured.
   */
  identity?: Identity;

  /**
   * The cluster properties.
   */
  properties?: ClusterProperties;
}
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KustoClusterPatch.properties);
@@alternateType(ClusterUpdate, KustoClusterPatch, "csharp");
