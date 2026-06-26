import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.SecurityInsights;
using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;

@@clientName(Microsoft.SecurityInsights,
  "SecurityInsightsMgmtClient",
  "python"
);

@@clientName(Azure.ResourceManager.CommonTypes.ActionType,
  "OperationActionType",
  "java"
);
@@clientName(MCASDataConnector, "McasDataConnector", "java");
@@clientName(ASCDataConnector, "AscDataConnector", "java");
@@clientName(MDATPDataConnector, "MdatpDataConnector", "java");
@@clientName(AADDataConnector, "AadDataConnector", "java");
@@clientName(AATPDataConnector, "AatpDataConnector", "java");
@@clientName(MCASDataConnectorDataTypes, "McasDataConnectorDataTypes", "java");
@@clientName(ScheduledAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "lastUpdatedDateUtc",
  "java"
);
@@clientName(ScheduledAlertRuleTemplateProperties.createdDateUTC,
  "createdDateUtc",
  "java"
);
@@clientName(FusionAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "lastUpdatedDateUtc",
  "java"
);
@@clientName(FusionAlertRuleTemplateProperties.createdDateUTC,
  "createdDateUtc",
  "java"
);
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "lastUpdatedDateUtc",
  "java"
);
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties.createdDateUTC,
  "createdDateUtc",
  "java"
);
@@clientName(MailMessageEntityProperties.senderIP, "senderIp", "java");
@@clientName(HostEntityProperties.omsAgentID, "omsAgentId", "java");
@@clientName(HostEntityProperties.azureID, "azureId", "java");
@@clientName(HostEntityProperties.hostName, "hostname", "java");
@@clientName(IncidentEntitiesResponse.metaData, "metadata", "java");

@@clientLocation(AlertRules.triggerRuleRun, "AlertRule", "python");
@@clientLocation(triggeredAnalyticsRuleRun.get,
  "TriggeredAnalyticsRuleRun",
  "python"
);
@@clientLocation(triggeredAnalyticsRuleRun.list,
  "GetTriggeredAnalyticsRuleRuns",
  "python"
);
@@clientName(FileHashAlgorithm.SHA256AC, "SHA256_AC", "python");
@@clientName(MstiDataConnectorDataTypesMicrosoftEmergingThreatFeed,
  "MSTIDataConnectorDataTypesMicrosoftEmergingThreatFeed",
  "go,python"
);
@@clientLocation(listGeodataByIp, "SecurityInsightsClient", "go");
@@clientLocation(listWhoisByDomain, "SecurityInsightsClient", "go");

@@clientName(EntityKindEnum, "EntityKind", "python");
@@clientName(ThreatIntelligenceResourceInnerKind,
  "ThreatIntelligenceResourceKindEnum",
  "python"
);
@@clientName(ThreatIntelligenceSortingOrder,
  "ThreatIntelligenceSortingCriteriaEnum",
  "python"
);

// ---- C# rename decorators (ported from autorest.md rename-mapping) ----
@@clientName(AADDataConnector, "SecurityInsightsAadDataConnector", "csharp");
@@clientName(AATPDataConnector, "SecurityInsightsAatpDataConnector", "csharp");
@@clientName(AccountEntity, "SecurityInsightsAccountEntity", "csharp");
@@clientName(ActionResponse, "SecurityInsightsAlertRuleAction", "csharp");
@@clientName(ActivityEntityQueriesProperties.createdTimeUtc,
  "CreatedOn",
  "csharp"
);
@@clientName(ActivityEntityQueriesProperties.enabled, "IsEnabled", "csharp");
@@clientName(ActivityEntityQueriesProperties.lastModifiedTimeUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(ActivityEntityQueryTemplatePropertiesQueryDefinitions,
  "ActivityEntityQueryDefinition",
  "csharp"
);
@@clientName(ActivityTimelineItem.bucketEndTimeUTC, "BucketEndOn", "csharp");
@@clientName(ActivityTimelineItem.bucketStartTimeUTC,
  "BucketStartOn",
  "csharp"
);
@@clientName(ActivityTimelineItem.firstActivityTimeUTC,
  "FirstActivityOn",
  "csharp"
);
@@clientName(ActivityTimelineItem.lastActivityTimeUTC,
  "LastActivityOn",
  "csharp"
);
@@clientName(AlertDetail, "SecurityInsightsAlertDetail", "csharp");
@@clientName(AlertDetailsOverride,
  "SecurityInsightsAlertDetailsOverride",
  "csharp"
);
@@clientName(AlertProperty, "SecurityInsightsAlertProperty", "csharp");
@@clientName(AlertPropertyMapping,
  "SecurityInsightsAlertPropertyMapping",
  "csharp"
);
@@clientName(AlertRule, "SecurityInsightsAlertRule", "csharp");
@@clientName(AlertRuleTemplate, "SecurityInsightsAlertRuleTemplate", "csharp");
@@clientName(AlertsDataTypeOfDataConnector,
  "SecurityInsightsAlertsDataTypeOfDataConnector",
  "csharp"
);
@@clientName(AlertSeverity, "SecurityInsightsAlertSeverity", "csharp");
@@clientName(AlertStatus, "SecurityInsightsAlertStatus", "csharp");
@@clientName(AnalyticsRuleRunTriggerProperties.executionTimeUtc,
  "ExecuteOn",
  "csharp"
);
@@clientName(Anomalies, "SecurityInsightsSettingAnomaliesKind", "csharp");
@@clientName(AnomalySecurityMLAnalyticsSettingsProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(AnomalySecurityMLAnalyticsSettingsProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(AnomalyTimelineItem.endTimeUtc, "EndOn", "csharp");
@@clientName(AnomalyTimelineItem.startTimeUtc, "StartOn", "csharp");
@@clientName(AnomalyTimelineItem.timeGenerated, "GeneratedOn", "csharp");
@@clientName(ApiKeyAuthModel, "SecurityInsightsApiKeyAuthModel", "csharp");
@@clientName(ASCCheckRequirements, "AscCheckRequirements", "csharp");
@@clientName(ASCDataConnector, "SecurityInsightsAscDataConnector", "csharp");
@@clientName(AssignmentItem, "WorkspaceManagerAssignmentItem", "csharp");
@@clientName(AttackPattern, "ThreatIntelligenceAttackPattern", "csharp");
@@clientName(AttackTactic, "SecurityInsightsAttackTactic", "csharp");
@@clientName(AutomationRuleProperties.createdTimeUtc, "CreatedOn", "csharp");
@@clientName(AutomationRuleProperties.lastModifiedTimeUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(AutomationRule, "SecurityInsightsAutomationRule", "csharp");
@@clientName(AutomationRuleAction,
  "SecurityInsightsAutomationRuleAction",
  "csharp"
);
@@clientName(AutomationRuleCondition,
  "SecurityInsightsAutomationRuleCondition",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.AccountUPNSuffix,
  "AccountUpnSuffix",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.AccountPUID,
  "AccountPuid",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.DNSDomainName,
  "DnsDomainName",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.HostAzureID,
  "HostAzureId",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.IoTDeviceId,
  "IotDeviceId",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.IoTDeviceModel,
  "IotDeviceModel",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.IoTDeviceName,
  "IotDeviceName",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.IoTDeviceOperatingSystem,
  "IotDeviceOperatingSystem",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.IoTDeviceType,
  "IotDeviceType",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.IoTDeviceVendor,
  "IotDeviceVendor",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.MailboxUPN,
  "MailboxUpn",
  "csharp"
);
@@clientName(AutomationRulePropertyConditionSupportedProperty.Url,
  "Uri",
  "csharp"
);
@@clientName(AutomationRuleTriggeringLogic.expirationTimeUtc,
  "ExpireOn",
  "csharp"
);
@@clientName(AutomationRuleTriggeringLogic,
  "SecurityInsightsAutomationRuleTriggeringLogic",
  "csharp"
);
@@clientName(Availability, "ConnectorAvailability", "csharp");
// (removed) AvailabilityStatus has no named enum in TypeSpec (Availability.status is a constant)
@@clientName(AWSAuthModel, "AwsAuthModel", "csharp");
@@clientName(AwsCloudTrailDataConnector,
  "SecurityInsightsAwsCloudTrailDataConnector",
  "csharp"
);
@@clientName(AzureResourceEntity,
  "SecurityInsightsAzureResourceEntity",
  "csharp"
);
@@clientName(BillingStatistic, "SecurityInsightsBillingStatistic", "csharp");
@@clientName(BookmarkProperties.created, "CreatedOn", "csharp");
@@clientName(BookmarkProperties.updated, "UpdatedOn", "csharp");
@@clientName(Bookmark, "SecurityInsightsBookmark", "csharp");
@@clientName(BookmarkExpandResponse, "BookmarkExpandResult", "csharp");
@@clientName(BookmarkTimelineItem.endTimeUtc, "EndOn", "csharp");
@@clientName(BookmarkTimelineItem.startTimeUtc, "StartOn", "csharp");
@@clientName(CcpResponseConfig.convertChildPropertiesToArray,
  "IsConvertChildPropertiesToArray",
  "csharp"
);
@@clientName(ClientInfo, "SecurityInsightsClientInfo", "csharp");
@@clientName(CloudApplicationEntity,
  "SecurityInsightsCloudApplicationEntity",
  "csharp"
);
@@clientName(ConditionClause,
  "ThreatIntelligenceQueryConditionClause",
  "csharp"
);
@@clientName(ConditionProperties,
  "ThreatIntelligenceQueryConditionProperties",
  "csharp"
);
@@clientName(ConfidenceLevel, "SecurityInsightsAlertConfidenceLevel", "csharp");
@@clientName(ConfidenceScoreStatus,
  "SecurityInsightsAlertConfidenceScoreStatus",
  "csharp"
);
@@clientName(Connective, "ThreatIntelligenceQueryConnective", "csharp");
@@clientName(ConnectivityCriteria, "ConnectorConnectivityCriteria", "csharp");
@@clientName(ConnectivityCriterion, "ConnectorConnectivityCriterion", "csharp");
@@clientName(ConnectivityType, "ConnectorConnectivityType", "csharp");
@@clientName(ConnectedEntity, "BookmarkConnectedEntity", "csharp");
@@clientName(ContentType, "SourceControlContentType", "csharp");
@@clientName(CustomizableConnectorDefinitionProperties.createdTimeUtc,
  "CreatedOn",
  "csharp"
);
@@clientName(CustomizableConnectorDefinitionProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(CustomizableConnectorDefinition,
  "CustomizableConnectorDefinitionData",
  "csharp"
);
@@clientName(Customs, "ConnectorCustoms", "csharp");
@@clientName(CustomsPermission, "ConnectorCustomsPermission", "csharp");
@@clientName(DataConnector, "SecurityInsightsDataConnector", "csharp");
@@clientName(DataConnectorConnectBody, "DataConnectorConnectContent", "csharp");
@@clientName(DataConnectorDefinition,
  "SecurityInsightsDataConnectorDefinition",
  "csharp"
);
@@clientName(DataTypeState,
  "SecurityInsightsDataTypeConnectionState",
  "csharp"
);
@@clientName(DCRConfiguration, "DcrConfiguration", "csharp");
@@clientName(DeleteStatus, "SecurityInsightsFileDeleteStatus", "csharp");
@@clientName(DeliveryAction,
  "SecurityInsightsMailMessageDeliveryAction",
  "csharp"
);
@@clientName(DeliveryLocation,
  "SecurityInsightsMailMessageDeliveryLocation",
  "csharp"
);
@@clientName(Deployment, "SourceControlDeployment", "csharp");
@@clientName(DeploymentFetchStatus,
  "SourceControlDeploymentFetchStatus",
  "csharp"
);
@@clientName(DeploymentInfo, "SourceControlDeploymentInfo", "csharp");
@@clientName(DeploymentResult, "SourceControlDeploymentResult", "csharp");
@@clientName(DeploymentState, "SourceControlDeploymentState", "csharp");
@@clientName(DnsEntity, "SecurityInsightsDnsEntity", "csharp");
@@clientName(DnsEntityProperties.dnsServerIpEntityId,
  "DnsServerIPEntityId",
  "csharp"
);
@@clientName(DnsEntityProperties.hostIpAddressEntityId,
  "HostIPAddressEntityId",
  "csharp"
);
@@clientName(DnsEntityProperties.ipAddressEntityIds,
  "IPAddressEntityIds",
  "csharp"
);
@@clientName(ElevationToken, "SecurityInsightsProcessElevationToken", "csharp");
@@clientName(EnrichmentDomainBody, "EnrichmentDomainContent", "csharp");
@@clientName(EnrichmentDomainWhois.expires, "ExpireOn", "csharp");
@@clientName(EnrichmentDomainWhois.updated, "UpdatedOn", "csharp");
@@clientName(EnrichmentIpAddressBody, "EnrichmentIPAddressContent", "csharp");
@@clientName(Entity, "SecurityInsightsEntity", "csharp");
@@clientName(EntityExpandResponse, "EntityExpandResult", "csharp");
@@clientName(EntityGetInsightsParameters.addDefaultExtendedTimeRange,
  "IsDefaultExtendedTimeRangeAdded",
  "csharp"
);
@@clientName(EntityKindEnum.Url, "Uri", "csharp");
@@clientName(EntityKindEnum.Ip, "IP", "csharp");
@@clientName(EntityKindEnum.IoTDevice, "IotDevice", "csharp");
@@clientName(EntityKindEnum, "SecurityInsightsEntityKind", "csharp");
@@clientName(EntityManualTriggerRequestBody,
  "EntityManualTriggerRequestContent",
  "csharp"
);
@@clientName(EntityMapping, "SecurityInsightsAlertRuleEntityMapping", "csharp");
@@clientName(EntityMappingType.DNS, "Dns", "csharp");
@@clientName(EntityMappingType.URL, "Uri", "csharp");
@@clientName(EntityMappingType,
  "SecurityInsightsAlertRuleEntityMappingType",
  "csharp"
);
@@clientName(EntityQuery, "SecurityInsightsEntityQuery", "csharp");
@@clientName(EntityQueryTemplate,
  "SecurityInsightsEntityQueryTemplate",
  "csharp"
);
@@clientName(EntityType, "SecurityInsightsEntityType", "csharp");
// (removed) Enum22 has no TypeSpec counterpart
@@clientName(Error, "PublicationFailedError", "csharp");
@@clientName(EyesOn, "SecurityInsightsEyesOn", "csharp");
@@clientName(FieldMapping, "SecurityInsightsFieldMapping", "csharp");
@@clientName(FileEntity, "SecurityInsightsFileEntity", "csharp");
@@clientName(FileFormat, "SecurityInsightsFileFormat", "csharp");
@@clientName(FileFormat.CSV, "Csv", "csharp");
@@clientName(FileHashAlgorithm.SHA1, "Sha1", "csharp");
@@clientName(FileHashAlgorithm.SHA256, "Sha256", "csharp");
@@clientName(FileHashAlgorithm.SHA256AC, "Sha256AC", "csharp");
@@clientName(FileHashAlgorithm, "SecurityInsightsFileHashAlgorithm", "csharp");
@@clientName(FileHashEntity, "SecurityInsightsFileHashEntity", "csharp");
@@clientName(FileImportProperties.createdTimeUTC, "CreatedOn", "csharp");
@@clientName(FileImportProperties.filesValidUntilTimeUTC,
  "FilesValidUntil",
  "csharp"
);
@@clientName(FileImportProperties.importValidUntilTimeUTC,
  "ImportValidUntil",
  "csharp"
);
@@clientName(FileImport, "SecurityInsightsFileImport", "csharp");
@@clientName(FileImportContentType,
  "SecurityInsightsFileImportContentType",
  "csharp"
);
@@clientName(FileImportState, "SecurityInsightsFileImportState", "csharp");
@@clientName(FileMetadata, "SecurityInsightsFileMetadata", "csharp");
@@clientName(Flag, "SecurityInsightsMetadataFlag", "csharp");
@@clientName(FusionAlertRuleProperties.enabled, "IsEnabled", "csharp");
@@clientName(FusionAlertRuleProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(FusionAlertRule, "SecurityInsightsFusionAlertRule", "csharp");
@@clientName(FusionAlertRuleTemplateProperties.createdDateUTC,
  "CreatedOn",
  "csharp"
);
@@clientName(FusionAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(FusionAlertRuleTemplate,
  "SecurityInsightsFusionAlertRuleTemplate",
  "csharp"
);
@@clientName(FusionSourceSettings.enabled, "IsEnabled", "csharp");
@@clientName(FusionSourceSubTypeSetting.enabled, "IsEnabled", "csharp");
@@clientName(FusionSubTypeSeverityFiltersItem.enabled, "IsEnabled", "csharp");
@@clientName(GCPAuthModel, "GcpAuthModel", "csharp");
@@clientName(GCPAuthProperties, "GcpAuthProperties", "csharp");
@@clientName(GCPDataConnector, "GcpDataConnector", "csharp");
@@clientName(GCPRequestProperties, "GcpRequestProperties", "csharp");
@@clientName(GeoLocation, "SecurityInsightsIPEntityGeoLocation", "csharp");
@@clientName(GroupingConfiguration.enabled, "IsEnabled", "csharp");
@@clientName(GroupingConfiguration.reopenClosedIncident,
  "IsClosedIncidentReopened",
  "csharp"
);
@@clientName(GroupingConfiguration,
  "SecurityInsightsGroupingConfiguration",
  "csharp"
);
@@clientName(ConnectorInstructionModelBase.type,
  "settingType",
  "csharp"
);
@@clientName(HostEntity, "SecurityInsightsHostEntity", "csharp");
@@clientName(HostEntityProperties.azureID, "AzureId", "csharp");
@@clientName(HostEntityProperties.omsAgentID, "OmsAgentId", "csharp");
@@clientName(HostEntityProperties.osFamily, "OSFamily", "csharp");
@@clientName(HostEntityProperties.osVersion, "OSVersion", "csharp");
@@clientName(HttpMethodVerb, "ConnectorHttpMethodVerb", "csharp");
@@clientName(HttpMethodVerb.DELETE, "Delete", "csharp");
@@clientName(HttpMethodVerb.POST, "Post", "csharp");
@@clientName(HttpMethodVerb.GET, "Get", "csharp");
@@clientName(HttpMethodVerb.PUT, "Put", "csharp");
@@clientName(Hunt, "SecurityInsightsHunt", "csharp");
@@clientName(HuntComment, "SecurityInsightsHuntComment", "csharp");
@@clientName(HuntingBookmarkProperties.created, "CreatedOn", "csharp");
@@clientName(HuntingBookmarkProperties.updated, "UpdatedOn", "csharp");
@@clientName(HuntingBookmark, "SecurityInsightsHuntingBookmark", "csharp");
@@clientName(HuntList, "SecurityInsightsHuntList", "csharp");
@@clientName(HuntOwner, "SecurityInsightsHuntOwner", "csharp");
@@clientName(HuntRelation, "SecurityInsightsHuntRelation", "csharp");
@@clientName(Identity, "ThreatIntelligenceIdentity", "csharp");
@@clientName(IncidentProperties.additionalData, "AdditionalInfo", "csharp");
@@clientName(IncidentProperties.createdTimeUtc, "CreatedOn", "csharp");
@@clientName(IncidentProperties.firstActivityTimeUtc,
  "FirstActivityOn",
  "csharp"
);
@@clientName(IncidentProperties.lastActivityTimeUtc,
  "LastActivityOn",
  "csharp"
);
@@clientName(IncidentProperties.lastModifiedTimeUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(Incident, "SecurityInsightsIncident", "csharp");
@@clientName(IncidentAdditionalData,
  "SecurityInsightsIncidentAdditionalInfo",
  "csharp"
);
@@clientName(IncidentClassification,
  "SecurityInsightsIncidentClassification",
  "csharp"
);
@@clientName(IncidentClassificationReason,
  "SecurityInsightsIncidentClassificationReason",
  "csharp"
);
@@clientName(IncidentCommentProperties.createdTimeUtc, "CreatedOn", "csharp");
@@clientName(IncidentCommentProperties.lastModifiedTimeUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(IncidentComment, "SecurityInsightsIncidentComment", "csharp");
@@clientName(IncidentConfiguration.createIncident,
  "IsIncidentCreated",
  "csharp"
);
@@clientName(IncidentConfiguration,
  "SecurityInsightsIncidentConfiguration",
  "csharp"
);
@@clientName(IncidentEntitiesResponse,
  "SecurityInsightsIncidentEntitiesResult",
  "csharp"
);
@@clientName(IncidentEntitiesResultsMetadata,
  "SecurityInsightsIncidentEntitiesMetadata",
  "csharp"
);
@@clientName(IncidentInfo, "SecurityInsightsBookmarkIncidentInfo", "csharp");
@@clientName(IncidentLabel, "SecurityInsightsIncidentLabel", "csharp");
@@clientName(IncidentLabelType, "SecurityInsightsIncidentLabelType", "csharp");
@@clientName(IncidentOwnerInfo, "SecurityInsightsIncidentOwnerInfo", "csharp");
@@clientName(IncidentPropertiesAction,
  "SecurityInsightsIncidentActionConfiguration",
  "csharp"
);
@@clientName(IncidentSeverity, "SecurityInsightsIncidentSeverity", "csharp");
@@clientName(IncidentStatus, "SecurityInsightsIncidentStatus", "csharp");
@@clientName(IncidentTaskProperties.createdTimeUtc, "CreatedOn", "csharp");
@@clientName(IncidentTaskProperties.lastModifiedTimeUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(IncidentTask, "SecurityInsightsIncidentTask", "csharp");
@@clientName(Indicator, "ThreatIntelligenceIndicator", "csharp");
@@clientName(InsightQueryItemPropertiesTableQueryColumnsDefinitionsItem.supportDeepLink,
  "IsDeepLinkSupported",
  "csharp"
);
@@clientName(IoTDeviceEntity, "SecurityInsightsIotDeviceEntity", "csharp");
@@clientName(IoTDeviceEntityProperties.ipAddressEntityId,
  "IPAddressEntityId",
  "csharp"
);
@@clientName(IpEntity, "SecurityInsightsIPEntity", "csharp");
@@alternateType(IpEntityProperties.address, Azure.Core.ipV4Address, "csharp");
@@clientName(Job, "WorkspaceManagerAssignmentJob", "csharp");
@@clientName(KillChainIntent, "SecurityInsightsKillChainIntent", "csharp");
@@clientName(MailboxEntity, "SecurityInsightsMailboxEntity", "csharp");
@@clientName(MailClusterEntity, "SecurityInsightsMailClusterEntity", "csharp");
@@clientName(MailMessageEntityProperties.senderIP, "SenderIP", "csharp");
@@alternateType(MailMessageEntityProperties.senderIP,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(MailMessageEntityProperties.urls, "Uris", "csharp");
@@clientName(MailMessageEntity, "SecurityInsightsMailMessageEntity", "csharp");
@@clientName(MalwareEntity, "SecurityInsightsMalwareEntity", "csharp");
@@clientName(MatchingMethod,
  "SecurityInsightsGroupingMatchingMethod",
  "csharp"
);
@@clientName(MetadataAuthor, "SecurityInsightsMetadataAuthor", "csharp");
@@clientName(MetadataCategories,
  "SecurityInsightsMetadataCategories",
  "csharp"
);
@@clientName(MetadataDependencies,
  "SecurityInsightsMetadataDependencies",
  "csharp"
);
@@clientName(MetadataSource, "SecurityInsightsMetadataSource", "csharp");
@@clientName(MetadataSupport, "SecurityInsightsMetadataSupport", "csharp");
@@clientName(MetadataModel, "SecurityInsightsMetadata", "csharp");
@@clientName(MCASDataConnector, "McasDataConnector", "csharp");
@@clientName(MCASDataConnectorDataTypes,
  "McasDataConnectorDataTypes",
  "csharp"
);
@@clientName(MDATPDataConnector, "MdatpDataConnector", "csharp");
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties.createdDateUTC,
  "CreatedOn",
  "csharp"
);
@@clientName(MicrosoftSecurityIncidentCreationAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(MLBehaviorAnalyticsAlertRuleProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(MLBehaviorAnalyticsAlertRuleProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(MLBehaviorAnalyticsAlertRuleTemplateProperties.createdDateUTC,
  "CreatedOn",
  "csharp"
);
@@clientName(MLBehaviorAnalyticsAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(Mode, "WorkspaceManagerConfigurationMode", "csharp");
@@clientName(MTPDataConnector, "MtpDataConnector", "csharp");
@@clientName(NrtAlertRuleProperties.enabled, "IsEnabled", "csharp");
@@clientName(NrtAlertRuleProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(NrtAlertRuleProperties.suppressionEnabled,
  "IsSuppressionEnabled",
  "csharp"
);
@@clientName(AlertRuleTemplatePropertiesBase.createdDateUTC,
  "CreatedOn",
  "csharp"
);
@@clientName(AlertRuleTemplatePropertiesBase.lastUpdatedDateUTC,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(OfficeConsent, "SecurityInsightsOfficeConsent", "csharp");
@@clientName(OfficeDataConnector,
  "SecurityInsightsOfficeDataConnector",
  "csharp"
);
@@clientName(OfficeDataConnectorDataTypes,
  "SecurityInsightsOfficeDataConnectorDataTypes",
  "csharp"
);
@@alternateType(OfficeDataConnectorDataTypes.exchange,
  DataConnectorDataTypeCommon,
  "csharp"
);
@@alternateType(OfficeDataConnectorDataTypes.sharePoint,
  DataConnectorDataTypeCommon,
  "csharp"
);
@@alternateType(OfficeDataConnectorDataTypes.teams,
  DataConnectorDataTypeCommon,
  "csharp"
);
@@alternateType(DataConnectorTenantId.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(Operator, "ThreatIntelligenceQueryOperator", "csharp");
@@clientName(OSFamily.IOS, "Ios", "csharp");
@@clientName(OSFamily, "SecurityInsightsHostOSFamily", "csharp");
@@clientName(OutputType, "InsightsColumnOutputType", "csharp");
@@clientName(OwnerType, "SecurityInsightsIncidentOwnerType", "csharp");
@@clientName(PackageKind, "SecurityInsightsMetadataPackageKind", "csharp");
@@clientName(PackageModel, "SecurityInsightsPackage", "csharp");
@@clientName(Permissions, "ConnectorPermissions", "csharp");
@@clientName(PlaybookActionProperties,
  "AutomationRuleRunPlaybookActionProperties",
  "csharp"
);
@@clientName(ProcessEntityProperties.creationTimeUtc, "CreatedOn", "csharp");
@@clientName(ProcessEntity, "SecurityInsightsProcessEntity", "csharp");
@@clientName(ProductPackageModel, "SecurityInsightsProductPackage", "csharp");
@@clientName(ProductTemplateModel, "SecurityInsightsProductTemplate", "csharp");
@@clientName(PropertyArrayChangedConditionProperties,
  "SecurityInsightsPropertyArrayChangedConditionProperties",
  "csharp"
);
@@clientName(PropertyChangedConditionProperties,
  "SecurityInsightsPropertyChangedConditionProperties",
  "csharp"
);
@@clientName(PropertyConditionProperties,
  "SecurityInsightsPropertyConditionProperties",
  "csharp"
);
@@clientName(ProviderName, "ConnectorProviderName", "csharp");
@@clientName(ProvisioningState,
  "TriggeredAnalyticsRuleRunProvisioningState",
  "csharp"
);
@@clientName(PullRequest, "PullRequestInfo", "csharp");
@@clientName(GraphQueries, "ConnectorGraphQueries", "csharp");
@@clientName(GraphQuery, "ConnectorGraphQuery", "csharp");
@@clientName(OfficeATPCheckRequirements,
  "OfficeAtpCheckRequirements",
  "csharp"
);
@@clientName(OfficeATPDataConnector, "OfficeAtpDataConnector", "csharp");
@@clientName(OfficeIRMCheckRequirements,
  "OfficeIrmCheckRequirements",
  "csharp"
);
@@clientName(OfficeIRMDataConnector, "OfficeIrmDataConnector", "csharp");
@@clientName(QueryCondition, "ThreatIntelligenceQueryCondition", "csharp");
@@clientName(Microsoft.SecurityInsights.Query,
  "ThreatIntelligenceQuery",
  "csharp"
);
@@clientName(QuerySortBy, "ThreatIntelligenceQuerySortBy", "csharp");
@@clientName(RecommendationProperties.creationTimeUtc, "CreatedOn", "csharp");
@@clientName(RecommendationProperties.lastEvaluatedTimeUtc,
  "LastEvaluatedOn",
  "csharp"
);
@@clientName(RecommendationProperties.lastModifiedTimeUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(Recommendation, "SecurityInsightsRecommendation", "csharp");
@@clientName(ReevaluateResponse.lastEvaluatedTimeUtc,
  "LastEvaluatedOn",
  "csharp"
);
@@clientName(ReevaluateResponse, "ReevaluateResult", "csharp");
@@clientName(RegistryHive, "SecurityInsightsRegistryHive", "csharp");
@@clientName(RegistryHive.HKEY_A, "HkeyA", "csharp");
@@clientName(RegistryHive.HKEY_CLASSES_ROOT, "HkeyClassesRoot", "csharp");
@@clientName(RegistryHive.HKEY_CURRENT_CONFIG, "HkeyCurrentConfig", "csharp");
@@clientName(RegistryHive.HKEY_CURRENT_USER, "HkeyCurrentUser", "csharp");
@@clientName(RegistryHive.HKEY_CURRENT_USER_LOCAL_SETTINGS,
  "HkeyCurrentUserLocalSettings",
  "csharp"
);
@@clientName(RegistryHive.HKEY_LOCAL_MACHINE,
  "HkeyLocalMachine",
  "csharp"
);
@@clientName(RegistryHive.HKEY_PERFORMANCE_DATA,
  "HkeyPerformanceData",
  "csharp"
);
@@clientName(RegistryHive.HKEY_PERFORMANCE_NLSTEXT,
  "HkeyPerformanceNlstext",
  "csharp"
);
@@clientName(RegistryHive.HKEY_PERFORMANCE_TEXT,
  "HkeyPerformanceText",
  "csharp"
);
@@clientName(RegistryHive.HKEY_USERS, "HkeyUsers", "csharp");
@@clientName(RegistryKeyEntity, "SecurityInsightsRegistryKeyEntity", "csharp");
@@clientName(RegistryValueEntity,
  "SecurityInsightsRegistryValueEntity",
  "csharp"
);
@@clientName(RegistryValueKind, "SecurityInsightsRegistryValueKind", "csharp");
@@clientName(Relation, "SecurityInsightsIncidentRelation", "csharp");
@@clientName(Relationship, "ThreatIntelligenceRelationship", "csharp");
@@clientName(Repo, "SourceControlRepo", "csharp");
@@clientName(RepoType, "SourceControlRepoType", "csharp");
@@clientName(Repository, "SourceControlRepository", "csharp");
@@clientName(RequiredPermissions, "ConnectorRequiredPermissions", "csharp");
@@clientName(RequiredPermissions.action, "IsCustomAction", "csharp");
@@clientName(RequiredPermissions.delete, "IsDeleteAction", "csharp");
@@clientName(RequiredPermissions.read, "IsReadAction", "csharp");
@@clientName(RequiredPermissions.write, "IsWriteAction", "csharp");
@@clientName(ResourceProvider, "ConnectorResourceProvider", "csharp");
@@clientName(ResourceProviderRequiredPermissions,
  "ConnectorResourceProviderRequiredPermissions",
  "csharp"
);
@@clientName(ResourceProviderRequiredPermissions.action,
  "IsCustomAction",
  "csharp"
);
@@clientName(ResourceProviderRequiredPermissions.delete,
  "IsDeleteAction",
  "csharp"
);
@@clientName(ResourceProviderRequiredPermissions.read,
  "IsReadAction",
  "csharp"
);
@@clientName(ResourceProviderRequiredPermissions.write,
  "IsWriteAction",
  "csharp"
);
@@clientName(SampleQueries, "SourceControlSampleQueries", "csharp");
@@clientName(ScheduledAlertRuleProperties.enabled, "IsEnabled", "csharp");
@@clientName(ScheduledAlertRuleProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(ScheduledAlertRuleProperties.suppressionEnabled,
  "IsSuppressionEnabled",
  "csharp"
);
@@clientName(ScheduledAlertRule,
  "SecurityInsightsScheduledAlertRule",
  "csharp"
);
@@clientName(SecurityAlertProperties.endTimeUtc, "EndOn", "csharp");
@@clientName(SecurityAlertProperties.startTimeUtc, "StartOn", "csharp");
@@clientName(SecurityAlertProperties.timeGenerated,
  "AlertGeneratedOn",
  "csharp"
);
@@clientName(SecurityAlert, "SecurityInsightsAlert", "csharp");
@@clientName(SecurityAlertPropertiesConfidenceReasonsItem,
  "SecurityInsightsAlertConfidenceReason",
  "csharp"
);
@@clientName(SecurityAlertTimelineItem.endTimeUtc, "EndOn", "csharp");
@@clientName(SecurityAlertTimelineItem.startTimeUtc, "StartOn", "csharp");
@@clientName(SecurityAlertTimelineItem.timeGenerated, "GeneratedOn", "csharp");
@@clientName(SecurityGroupEntity, "SecurityInsightsGroupEntity", "csharp");
@@clientName(SentinelOnboardingStateProperties.customerManagedKey,
  "IsCustomerManagedKeySet",
  "csharp"
);
@@clientName(SentinelOnboardingState,
  "SecurityInsightsSentinelOnboardingState",
  "csharp"
);
@@clientName(ServicePrincipal, "SourceControlServicePrincipal", "csharp");
@@clientName(SettingList, "SecurityInsightsSettingList", "csharp");
@@clientName(Settings, "SecurityInsightsSetting", "csharp");
@@clientName(SettingsStatus,
  "AnomalySecurityMLAnalyticsSettingsStatus",
  "csharp"
);
@@clientName(SettingType, "ConnectorSettingType", "csharp");
@@clientName(Status, "SecurityInsightsContentStatus", "csharp");
@@clientName(SortingDirection,
  "ThreatIntelligenceQuerySortingDirection",
  "csharp"
);
@@clientName(SourceControl, "SecurityInsightsSourceControl", "csharp");
@@clientName(SourceControlProperties.id, "SourceControlId", "csharp");
@@clientName(SourceKind, "SecurityInsightsSourceKind", "csharp");
@@clientName(SourceType, "WatchlistSourceType", "csharp");
@@clientName(State, "RecommendationState", "csharp");
@@clientName(SubmissionMailEntityProperties.submissionDate,
  "SubmitOn",
  "csharp"
);
@@clientName(SubmissionMailEntityProperties.senderIp, "SenderIP", "csharp");
@@alternateType(SubmissionMailEntityProperties.senderIp,
  Azure.Core.ipV4Address,
  "csharp"
);
@@clientName(SubmissionMailEntityProperties.timestamp,
  "MessageReceivedOn",
  "csharp"
);
@@clientName(SubmissionMailEntity,
  "SecurityInsightsSubmissionMailEntity",
  "csharp"
);
@@clientName(SupportTier, "SecurityInsightsSupportTier", "csharp");
@@clientName(TemplateModel, "SecurityInsightsTemplate", "csharp");
@@clientName(TemplateProperties,
  "SecurityInsightsContentTemplateProperties",
  "csharp"
);
@@clientName(TemplateStatus,
  "SecurityInsightsAlertRuleTemplateStatus",
  "csharp"
);
@@clientName(ThreatActor, "ThreatIntelligenceThreatActor", "csharp");
@@clientName(ThreatIntelligence,
  "SecurityInsightsThreatIntelligence",
  "csharp"
);
@@clientName(ThreatIntelligenceAlertRuleProperties.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(ThreatIntelligenceAlertRuleProperties.lastModifiedUtc,
  "LastModifiedOn",
  "csharp"
);
@@clientName(ThreatIntelligenceAlertRuleTemplateProperties.createdDateUTC,
  "CreatedOn",
  "csharp"
);
@@clientName(ThreatIntelligenceAlertRuleTemplateProperties.lastUpdatedDateUTC,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(ThreatIntelligenceFilteringCriteria.includeDisabled,
  "IsIncludeDisabled",
  "csharp"
);
@@clientName(ThreatIntelligenceGranularMarkingModel,
  "ThreatIntelligenceGranularMarkingEntity",
  "csharp"
);
@@clientName(ThreatIntelligenceIndicatorProperties.created,
  "CreatedOn",
  "csharp"
);
@@clientName(ThreatIntelligenceIndicatorProperties.defanged,
  "IsDefanged",
  "csharp"
);
@@clientName(ThreatIntelligenceIndicatorProperties.externalLastUpdatedTimeUtc,
  "ExternalLastUpdatedOn",
  "csharp"
);
@@clientName(ThreatIntelligenceIndicatorProperties.lastUpdatedTimeUtc,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(ThreatIntelligenceIndicatorProperties.revoked,
  "IsRevoked",
  "csharp"
);
@@clientName(ThreatIntelligenceIndicatorModel,
  "SecurityInsightsThreatIntelligenceIndicatorData",
  "csharp"
);
@@clientName(ThreatIntelligenceInformation,
  "SecurityInsightsThreatIntelligenceIndicatorBase",
  "csharp"
);
@@clientName(CountQuery, "ThreatIntelligenceCountQuery", "csharp");
@@alternateType(ThreatIntelligenceIndicatorProperties.created, utcDateTime, "csharp");
@@alternateType(ThreatIntelligenceIndicatorProperties.externalLastUpdatedTimeUtc, utcDateTime, "csharp");
@@alternateType(ThreatIntelligenceIndicatorProperties.lastUpdatedTimeUtc, utcDateTime, "csharp");
@@alternateType(ThreatIntelligenceIndicatorProperties.validFrom, utcDateTime, "csharp");
@@alternateType(ThreatIntelligenceIndicatorProperties.validUntil, utcDateTime, "csharp");
@@clientName(ThreatIntelligenceMetric.lastUpdatedTimeUtc,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(TICheckRequirements,
  "ThreatIntelligenceCheckRequirements",
  "csharp"
);
@@clientName(TIDataConnectorProperties.tipLookbackPeriod,
  "TipLookbackOn",
  "csharp"
);
@@clientName(TIDataConnector, "SecurityInsightsTIDataConnector", "csharp");
@@clientName(TIObject, "ThreatIntelligenceObject", "csharp");
@@clientName(TIObjectCommonProperties.firstIngestedTimeUtc,
  "FirstIngestedOn",
  "csharp"
);
@@clientName(TIObjectCommonProperties.lastIngestedTimeUtc,
  "LastIngestedOn",
  "csharp"
);
@@clientName(TIObjectCommonProperties.lastUpdatedDateTimeUtc,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(TiTaxiiCheckRequirements,
  "ThreatIntelligenceTaxiiCheckRequirements",
  "csharp"
);
@@clientName(TiTaxiiDataConnector,
  "ThreatIntelligenceTaxiiDataConnector",
  "csharp"
);
@@clientName(TiType, "ThreatIntelligenceType", "csharp");
@@clientName(TriggeredAnalyticsRuleRunProperties.executionTimeUtc,
  "ExecuteOn",
  "csharp"
);
@@clientName(TriggerOperator,
  "SecurityInsightsAlertRuleTriggerOperator",
  "csharp"
);
@@clientName(Ueba, "UebaSettings", "csharp");
@@clientName(UrlEntity, "SecurityInsightsUriEntity", "csharp");
@@clientName(UrlEntityProperties.url, "UriString", "csharp");
@@clientName(UserInfo, "SecurityInsightsUserInfo", "csharp");
@@clientName(ValidationError, "SecurityInsightsFileValidationError", "csharp");
@@clientName(Version, "SourceControlVersion", "csharp");
@@clientName(Warning, "SourceControlOperationWarning", "csharp");
@@clientName(WarningBody, "SourceControlOperationWarningBody", "csharp");
@@clientName(WarningCode, "SourceControlOperationWarningCode", "csharp");
@@clientName(WatchlistProperties.created, "CreatedOn", "csharp");
@@clientName(WatchlistProperties.source, "SourceString", "csharp");
@@clientName(WatchlistProperties.updated, "UpdatedOn", "csharp");
@@clientName(Watchlist, "SecurityInsightsWatchlist", "csharp");
@@clientName(WatchlistItemProperties.created, "CreatedOn", "csharp");
@@clientName(WatchlistItemProperties.entityMapping,
  "EntityMappingDictionary",
  "csharp"
);
@@clientName(WatchlistItemProperties.itemsKeyValue,
  "ItemsKeyValueDictionary",
  "csharp"
);
@@alternateType(WatchlistItemProperties.itemsKeyValue,
  Record<unknown>,
  "csharp"
);
@@alternateType(WatchlistItemProperties.entityMapping,
  Record<unknown>,
  "csharp"
);
@@clientName(WatchlistItemProperties.updated, "UpdatedOn", "csharp");
@@clientName(WatchlistItem, "SecurityInsightsWatchlistItem", "csharp");
@@clientName(Webhook.rotateWebhookSecret, "IsWebhookSecretRotated", "csharp");
@@clientName(Webhook, "SourceControlWebhook", "csharp");

// ---- C# enum member + operation renames (ported from autorest.md) ----
@@clientName(Operator.Equals, "EqualsValue", "csharp");
@@clientName(AutomationRulePropertyConditionSupportedOperator.Equals,
  "EqualsValue",
  "csharp"
);
@@clientName(listWhoisByDomain, "GetDomainWhoisInformation", "csharp");
@@clientName(Incidents.listEntities, "GetEntitiesResult", "csharp");
@@clientName(ThreatIntelligenceIndicatorOperationGroup.queryIndicators,
  "QueryThreatIntelligenceIndicators",
  "csharp"
);
@@clientName(ThreatIntelligenceIndicatorMetricsOperationGroup.list,
  "GetAllThreatIntelligenceIndicatorMetrics",
  "csharp"
);

// ---- C# request/response model renames to satisfy AZC0030 (ported from autorest mgmt naming conventions) ----
@@clientName(ActionRequest,
  "SecurityInsightsAlertRuleActionCreateOrUpdateContent",
  "csharp"
);
@@clientName(BookmarkExpandParameters, "BookmarkExpandContent", "csharp");
@@clientName(EntityExpandParameters, "EntityExpandContent", "csharp");
@@clientName(EntityGetInsightsParameters, "EntityGetInsightsContent", "csharp");
@@clientName(EntityTimelineParameters, "EntityTimelineContent", "csharp");

// ---- Mark insights/timeline action operations as pageable to match GA Pageable<T> surface ----
// EntityGetInsightsResponse / EntityTimelineResponse wrappers already carry @pageItems on `value`.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration: restore GA pageable surface"
@@markAsPageable(Entities.getInsights, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration: restore GA pageable surface"
@@markAsPageable(Entities.entitiesGetTimelineList, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration: restore GA pageable surface"
@@markAsPageable(SentinelOnboardingStates.list, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration: restore GA pageable surface"
@@markAsPageable(Incidents.listAlerts, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration: restore GA pageable surface"
@@markAsPageable(Incidents.listBookmarks, "csharp");

// ---- Rename TAXII data type model so it does not end in "Client" (AZC0005/AZC0007). ----
@@clientName(TiTaxiiDataConnectorDataTypesTaxiiClient,
  "TiTaxiiDataConnectorDataTypesTaxiiClientInfo",
  "csharp"
);

@@clientName(AADCheckRequirements, "AadCheckRequirements", "csharp");
@@clientName(EntityProviders, "EntityProvider", "csharp");

// ---- Restore GA settable model properties that became output-only in TypeSpec generation. ----
@@usage(ActionRequest, Usage.input, "csharp");
@@usage(ActionRequestProperties, Usage.input, "csharp");
@@usage(ActionPropertiesBase, Usage.input, "csharp");
@@usage(ActionResponse, Usage.input, "csharp");
@@usage(ActivityEntityQuery, Usage.input, "csharp");
@@usage(ActivityEntityQueryTemplate, Usage.input, "csharp");
@@usage(ActivityEntityQueryTemplatePropertiesQueryDefinitions, Usage.input, "csharp");
@@usage(AccountEntity, Usage.input, "csharp");
@@usage(AlertRuleTemplateDataSource, Usage.input, "csharp");
@@usage(AzureResourceEntity, Usage.input, "csharp");
@@usage(CloudApplicationEntity, Usage.input, "csharp");
@@usage(ConditionClause, Usage.input, "csharp");
@@usage(ConditionProperties, Usage.input, "csharp");
@@usage(DataTypeDefinitions, Usage.input, "csharp");
@@usage(DnsEntity, Usage.input, "csharp");
@@usage(EntityQuery, Usage.input, "csharp");
@@usage(Error, Usage.input, "csharp");
@@usage(ExpansionEntityQuery, Usage.input, "csharp");
@@usage(FileEntity, Usage.input, "csharp");
@@usage(FileHashEntity, Usage.input, "csharp");
@@usage(FusionAlertRuleTemplate, Usage.input, "csharp");
@@usage(FusionTemplateSourceSetting, Usage.input, "csharp");
@@usage(FusionTemplateSourceSubType, Usage.input, "csharp");
@@usage(FusionTemplateSubTypeSeverityFilter, Usage.input, "csharp");
@@usage(HostEntity, Usage.input, "csharp");
@@usage(HuntingBookmark, Usage.input, "csharp");
@@usage(IndicatorObservablesItem, Usage.input, "csharp");
@@usage(IoTDeviceEntity, Usage.input, "csharp");
@@usage(IpEntity, Usage.input, "csharp");
@@usage(Job, Usage.input, "csharp");
@@usage(JobItem, Usage.input, "csharp");
@@clientName(JobItem, "SecurityInsightsContentJobItem", "csharp");
@@usage(MailboxEntity, Usage.input, "csharp");
@@usage(MailClusterEntity, Usage.input, "csharp");
@@usage(MailMessageEntity, Usage.input, "csharp");
@@usage(MalwareEntity, Usage.input, "csharp");
@@usage(MicrosoftSecurityIncidentCreationAlertRuleTemplate, Usage.input, "csharp");
@@usage(MLBehaviorAnalyticsAlertRuleTemplate, Usage.input, "csharp");
@@usage(MTPDataConnector, Usage.input, "csharp");
@@usage(MTPDataConnectorProperties, Usage.input, "csharp");
@@usage(MtpFilteredProviders, Usage.input, "csharp");
@@usage(NicEntity, Usage.input, "csharp");
@@usage(NrtAlertRuleTemplate, Usage.input, "csharp");
@@usage(OfficeConsent, Usage.input, "csharp");
@@usage(ProcessEntity, Usage.input, "csharp");
@@usage(ProductPackageModel, Usage.input, "csharp");
@@usage(ProductTemplateModel, Usage.input, "csharp");
@@usage(Recommendation, Usage.input, "csharp");
@@usage(RecommendationProperties, Usage.input, "csharp");
@@usage(RecommendedSuggestion, Usage.input, "csharp");
@@usage(RegistryKeyEntity, Usage.input, "csharp");
@@usage(RegistryValueEntity, Usage.input, "csharp");
@@usage(RepositoryAccess, Usage.input, "csharp");
@@usage(RepositoryAccessObject, Usage.input, "csharp");
@@usage(RepositoryAccessProperties, Usage.input, "csharp");
@@usage(ScheduledAlertRuleTemplate, Usage.input, "csharp");
@@usage(SecurityAlert, Usage.input, "csharp");
@@usage(SecurityGroupEntity, Usage.input, "csharp");
@@usage(SubmissionMailEntity, Usage.input, "csharp");
@@usage(ThreatIntelligenceAlertRuleTemplate, Usage.input, "csharp");
@@usage(TriggeredAnalyticsRuleRun, Usage.input, "csharp");
@@usage(TriggeredAnalyticsRuleRunProperties, Usage.input, "csharp");
@@usage(UrlEntity, Usage.input, "csharp");

@@alternateType(ActionResponse.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(AlertRule.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(AutomationRule.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(BillingStatistic.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Bookmark.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(DataConnector.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(DataConnectorDefinition.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(EntityQuery.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Hunt.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(HuntComment.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Incident.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(IncidentComment.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(IncidentTask.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Job.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(MetadataModel.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(PackageModel.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(ProductPackageModel.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(ProductTemplateModel.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(Recommendation.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(Relation.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(ResourceWithEtag.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(SecurityMLAnalyticsSetting.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(SentinelOnboardingState.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(Settings.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(SourceControl.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(TemplateModel.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(ThreatIntelligenceInformation.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(TriggeredAnalyticsRuleRun.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(Watchlist.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(WatchlistItem.etag, Azure.Core.EtagProperty.etag, "csharp");
@@alternateType(WorkspaceManagerAssignment.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(WorkspaceManagerConfiguration.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(WorkspaceManagerGroup.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);
@@alternateType(WorkspaceManagerMember.etag,
  Azure.Core.EtagProperty.etag,
  "csharp"
);

@@alternateType(AnomalyTimelineItem.azureResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ActionRequestProperties.triggerUri, url, "csharp");
@@alternateType(BookmarkTimelineItem.azureResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(HostEntityProperties.azureID, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(IncidentProperties.incidentUrl, url, "csharp");
@@alternateType(FileMetadata.fileContentUri, url, "csharp");
@@alternateType(MailMessageEntityProperties.urls, url[], "csharp");
@@clientName(IncidentAdditionalData.providerIncidentUrl,
  "ProviderIncidentUri",
  "csharp"
);
@@alternateType(IncidentAdditionalData.providerIncidentUrl, url, "csharp");
@@alternateType(RelationProperties.relatedResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RelationProperties.relatedResourceType,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(HuntRelationProperties.relatedResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(OfficeConsentProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(SourceControlProperties.id, Azure.Core.uuid, "csharp");
@@alternateType(WatchlistProperties.watchlistId, Azure.Core.uuid, "csharp");
@@alternateType(WatchlistProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(WatchlistItemProperties.tenantId, Azure.Core.uuid, "csharp");

@@alternateType(ActionPropertiesBase.logicAppResourceId, Azure.Core.armResourceIdentifier, "csharp");
@@clientName(AlertRules.triggerRuleRun, "TriggerRuleRunAlertRule", "csharp");
@@clientName(
  ThreatIntelligenceIndicatorOperationGroup.queryIndicators,
  "listQueryIndicators",
  "javascript"
);
