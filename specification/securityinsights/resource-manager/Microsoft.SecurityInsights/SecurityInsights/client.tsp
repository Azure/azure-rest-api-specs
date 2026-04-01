import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.SecurityInsights;
using Azure.ClientGenerator.Core;

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
  "go"
);
@@clientLocation(listGeodataByIp, "SecurityInsightsClient", "go");
@@clientLocation(listWhoisByDomain, "SecurityInsightsClient", "go");

// C# backward-compat type renames (from autorest.md rename-mapping)
@@clientName(Microsoft.SecurityInsights.AADDataConnector, "SecurityInsightsAadDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.ASCCheckRequirements, "AscCheckRequirements", "csharp");
@@clientName(Microsoft.SecurityInsights.ASCDataConnector, "SecurityInsightsAscDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.AWSAuthModel, "AwsAuthModel", "csharp");
@@clientName(Microsoft.SecurityInsights.AccountEntity, "SecurityInsightsAccountEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.ActionResponse, "SecurityInsightsAlertRuleAction", "csharp");
@@clientName(Microsoft.SecurityInsights.ActivityEntityQueryTemplatePropertiesQueryDefinitions, "ActivityEntityQueryDefinition", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertDetail, "SecurityInsightsAlertDetail", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertDetailsOverride, "SecurityInsightsAlertDetailsOverride", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertProperty, "SecurityInsightsAlertProperty", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertPropertyMapping, "SecurityInsightsAlertPropertyMapping", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertRule, "SecurityInsightsAlertRule", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertRuleTemplate, "SecurityInsightsAlertRuleTemplate", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertSeverity, "SecurityInsightsAlertSeverity", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertStatus, "SecurityInsightsAlertStatus", "csharp");
@@clientName(Microsoft.SecurityInsights.AlertsDataTypeOfDataConnector, "SecurityInsightsAlertsDataTypeOfDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.Anomalies, "SecurityInsightsSettingAnomaliesKind", "csharp");
@@clientName(Microsoft.SecurityInsights.ApiKeyAuthModel, "SecurityInsightsApiKeyAuthModel", "csharp");
@@clientName(Microsoft.SecurityInsights.AttackPattern, "ThreatIntelligenceAttackPattern", "csharp");
@@clientName(Microsoft.SecurityInsights.AttackTactic, "SecurityInsightsAttackTactic", "csharp");
@@clientName(Microsoft.SecurityInsights.AutomationRule, "SecurityInsightsAutomationRule", "csharp");
@@clientName(Microsoft.SecurityInsights.AutomationRuleAction, "SecurityInsightsAutomationRuleAction", "csharp");
@@clientName(Microsoft.SecurityInsights.AutomationRuleCondition, "SecurityInsightsAutomationRuleCondition", "csharp");
@@clientName(Microsoft.SecurityInsights.AutomationRuleTriggeringLogic, "SecurityInsightsAutomationRuleTriggeringLogic", "csharp");
@@clientName(Microsoft.SecurityInsights.Availability, "ConnectorAvailability", "csharp");
@@clientName(Microsoft.SecurityInsights.AwsCloudTrailDataConnector, "SecurityInsightsAwsCloudTrailDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.AzureResourceEntity, "SecurityInsightsAzureResourceEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.BillingStatistic, "SecurityInsightsBillingStatistic", "csharp");
@@clientName(Microsoft.SecurityInsights.Bookmark, "SecurityInsightsBookmark", "csharp");
@@clientName(Microsoft.SecurityInsights.BookmarkExpandResponse, "BookmarkExpandResult", "csharp");
@@clientName(Microsoft.SecurityInsights.ClientInfo, "SecurityInsightsClientInfo", "csharp");
@@clientName(Microsoft.SecurityInsights.CloudApplicationEntity, "SecurityInsightsCloudApplicationEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.ConditionClause, "ThreatIntelligenceQueryConditionClause", "csharp");
@@clientName(Microsoft.SecurityInsights.ConditionProperties, "ThreatIntelligenceQueryConditionProperties", "csharp");
@@clientName(Microsoft.SecurityInsights.ConfidenceLevel, "SecurityInsightsAlertConfidenceLevel", "csharp");
@@clientName(Microsoft.SecurityInsights.ConfidenceScoreStatus, "SecurityInsightsAlertConfidenceScoreStatus", "csharp");
@@clientName(Microsoft.SecurityInsights.ConnectedEntity, "BookmarkConnectedEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.Connective, "ThreatIntelligenceQueryConnective", "csharp");
@@clientName(Microsoft.SecurityInsights.ConnectivityCriteria, "ConnectorConnectivityCriteria", "csharp");
@@clientName(Microsoft.SecurityInsights.ConnectivityCriterion, "ConnectorConnectivityCriterion", "csharp");
@@clientName(Microsoft.SecurityInsights.ConnectivityType, "ConnectorConnectivityType", "csharp");
@@clientName(Microsoft.SecurityInsights.ContentType, "SourceControlContentType", "csharp");
@@clientName(Microsoft.SecurityInsights.CustomizableConnectorDefinition, "CustomizableConnectorDefinitionData", "csharp");
@@clientName(Microsoft.SecurityInsights.Customs, "ConnectorCustoms", "csharp");
@@clientName(Microsoft.SecurityInsights.CustomsPermission, "ConnectorCustomsPermission", "csharp");
@@clientName(Microsoft.SecurityInsights.DCRConfiguration, "DcrConfiguration", "csharp");
@@clientName(Microsoft.SecurityInsights.DataConnector, "SecurityInsightsDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.DataConnectorConnectBody, "DataConnectorConnectContent", "csharp");
@@clientName(Microsoft.SecurityInsights.DataConnectorDefinition, "SecurityInsightsDataConnectorDefinition", "csharp");
@@clientName(Microsoft.SecurityInsights.DataTypeState, "SecurityInsightsDataTypeConnectionState", "csharp");
@@clientName(Microsoft.SecurityInsights.DeleteStatus, "SecurityInsightsFileDeleteStatus", "csharp");
@@clientName(Microsoft.SecurityInsights.DeliveryAction, "SecurityInsightsMailMessageDeliveryAction", "csharp");
@@clientName(Microsoft.SecurityInsights.DeliveryLocation, "SecurityInsightsMailMessageDeliveryLocation", "csharp");
@@clientName(Microsoft.SecurityInsights.Deployment, "SourceControlDeployment", "csharp");
@@clientName(Microsoft.SecurityInsights.DeploymentFetchStatus, "SourceControlDeploymentFetchStatus", "csharp");
@@clientName(Microsoft.SecurityInsights.DeploymentInfo, "SourceControlDeploymentInfo", "csharp");
@@clientName(Microsoft.SecurityInsights.DeploymentResult, "SourceControlDeploymentResult", "csharp");
@@clientName(Microsoft.SecurityInsights.DeploymentState, "SourceControlDeploymentState", "csharp");
@@clientName(Microsoft.SecurityInsights.DnsEntity, "SecurityInsightsDnsEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.ElevationToken, "SecurityInsightsProcessElevationToken", "csharp");
@@clientName(Microsoft.SecurityInsights.EnrichmentDomainBody, "EnrichmentDomainContent", "csharp");
@@clientName(Microsoft.SecurityInsights.EnrichmentIpAddressBody, "EnrichmentIPAddressContent", "csharp");
@@clientName(Microsoft.SecurityInsights.Entity, "SecurityInsightsEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityExpandResponse, "EntityExpandResult", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityKindEnum, "SecurityInsightsEntityKind", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityManualTriggerRequestBody, "EntityManualTriggerRequestContent", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityMapping, "SecurityInsightsAlertRuleEntityMapping", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityMappingType, "SecurityInsightsAlertRuleEntityMappingType", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityQuery, "SecurityInsightsEntityQuery", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityQueryTemplate, "SecurityInsightsEntityQueryTemplate", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityType, "SecurityInsightsEntityType", "csharp");
@@clientName(Microsoft.SecurityInsights.EyesOn, "SecurityInsightsEyesOn", "csharp");
@@clientName(Microsoft.SecurityInsights.FieldMapping, "SecurityInsightsFieldMapping", "csharp");
@@clientName(Microsoft.SecurityInsights.FileEntity, "SecurityInsightsFileEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.FileFormat, "SecurityInsightsFileFormat", "csharp");
@@clientName(Microsoft.SecurityInsights.FileHashAlgorithm, "SecurityInsightsFileHashAlgorithm", "csharp");
@@clientName(Microsoft.SecurityInsights.FileHashEntity, "SecurityInsightsFileHashEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.FileImport, "SecurityInsightsFileImport", "csharp");
@@clientName(Microsoft.SecurityInsights.FileImportContentType, "SecurityInsightsFileImportContentType", "csharp");
@@clientName(Microsoft.SecurityInsights.FileImportState, "SecurityInsightsFileImportState", "csharp");
@@clientName(Microsoft.SecurityInsights.FileMetadata, "SecurityInsightsFileMetadata", "csharp");
@@clientName(Microsoft.SecurityInsights.Flag, "SecurityInsightsMetadataFlag", "csharp");
@@clientName(Microsoft.SecurityInsights.FusionAlertRule, "SecurityInsightsFusionAlertRule", "csharp");
@@clientName(Microsoft.SecurityInsights.FusionAlertRuleTemplate, "SecurityInsightsFusionAlertRuleTemplate", "csharp");
@@clientName(Microsoft.SecurityInsights.GCPAuthModel, "GcpAuthModel", "csharp");
@@clientName(Microsoft.SecurityInsights.GCPAuthProperties, "GcpAuthProperties", "csharp");
@@clientName(Microsoft.SecurityInsights.GCPDataConnector, "GcpDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.GCPRequestProperties, "GcpRequestProperties", "csharp");
@@clientName(Microsoft.SecurityInsights.GeoLocation, "SecurityInsightsIPEntityGeoLocation", "csharp");
@@clientName(Microsoft.SecurityInsights.GraphQueries, "ConnectorGraphQueries", "csharp");
@@clientName(Microsoft.SecurityInsights.GraphQuery, "ConnectorGraphQuery", "csharp");
@@clientName(Microsoft.SecurityInsights.GroupingConfiguration, "SecurityInsightsGroupingConfiguration", "csharp");
@@clientName(Microsoft.SecurityInsights.HostEntity, "SecurityInsightsHostEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.HttpMethodVerb, "ConnectorHttpMethodVerb", "csharp");
@@clientName(Microsoft.SecurityInsights.Hunt, "SecurityInsightsHunt", "csharp");
@@clientName(Microsoft.SecurityInsights.HuntComment, "SecurityInsightsHuntComment", "csharp");
@@clientName(Microsoft.SecurityInsights.HuntList, "SecurityInsightsHuntList", "csharp");
@@clientName(Microsoft.SecurityInsights.HuntOwner, "SecurityInsightsHuntOwner", "csharp");
@@clientName(Microsoft.SecurityInsights.HuntRelation, "SecurityInsightsHuntRelation", "csharp");
@@clientName(Microsoft.SecurityInsights.HuntingBookmark, "SecurityInsightsHuntingBookmark", "csharp");
@@clientName(Microsoft.SecurityInsights.Identity, "ThreatIntelligenceIdentity", "csharp");
@@clientName(Microsoft.SecurityInsights.Incident, "SecurityInsightsIncident", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentAdditionalData, "SecurityInsightsIncidentAdditionalInfo", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentClassification, "SecurityInsightsIncidentClassification", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentClassificationReason, "SecurityInsightsIncidentClassificationReason", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentComment, "SecurityInsightsIncidentComment", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentConfiguration, "SecurityInsightsIncidentConfiguration", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentEntitiesResponse, "SecurityInsightsIncidentEntitiesResult", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentEntitiesResultsMetadata, "SecurityInsightsIncidentEntitiesMetadata", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentInfo, "SecurityInsightsBookmarkIncidentInfo", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentLabel, "SecurityInsightsIncidentLabel", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentLabelType, "SecurityInsightsIncidentLabelType", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentOwnerInfo, "SecurityInsightsIncidentOwnerInfo", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentPropertiesAction, "SecurityInsightsIncidentActionConfiguration", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentSeverity, "SecurityInsightsIncidentSeverity", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentStatus, "SecurityInsightsIncidentStatus", "csharp");
@@clientName(Microsoft.SecurityInsights.IncidentTask, "SecurityInsightsIncidentTask", "csharp");
@@clientName(Microsoft.SecurityInsights.Indicator, "ThreatIntelligenceIndicator", "csharp");
@@clientName(Microsoft.SecurityInsights.IoTDeviceEntity, "SecurityInsightsIotDeviceEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.IpEntity, "SecurityInsightsIPEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.Job, "WorkspaceManagerAssignmentJob", "csharp");
@@clientName(Microsoft.SecurityInsights.KillChainIntent, "SecurityInsightsKillChainIntent", "csharp");
@@clientName(Microsoft.SecurityInsights.MTPDataConnector, "MtpDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.MailClusterEntity, "SecurityInsightsMailClusterEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.MailMessageEntity, "SecurityInsightsMailMessageEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.MailboxEntity, "SecurityInsightsMailboxEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.MalwareEntity, "SecurityInsightsMalwareEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.MatchingMethod, "SecurityInsightsGroupingMatchingMethod", "csharp");
@@clientName(Microsoft.SecurityInsights.MetadataModel, "SecurityInsightsMetadata", "csharp");
@@clientName(Microsoft.SecurityInsights.Mode, "WorkspaceManagerConfigurationMode", "csharp");
@@clientName(Microsoft.SecurityInsights.OSFamily, "SecurityInsightsHostOSFamily", "csharp");
@@clientName(Microsoft.SecurityInsights.OfficeATPCheckRequirements, "OfficeAtpCheckRequirements", "csharp");
@@clientName(Microsoft.SecurityInsights.OfficeATPDataConnector, "OfficeAtpDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.OfficeConsent, "SecurityInsightsOfficeConsent", "csharp");
@@clientName(Microsoft.SecurityInsights.OfficeDataConnector, "SecurityInsightsOfficeDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.OfficeDataConnectorDataTypes, "SecurityInsightsOfficeDataConnectorDataTypes", "csharp");
@@clientName(Microsoft.SecurityInsights.OfficeIRMCheckRequirements, "OfficeIrmCheckRequirements", "csharp");
@@clientName(Microsoft.SecurityInsights.OfficeIRMDataConnector, "OfficeIrmDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.Operator, "ThreatIntelligenceQueryOperator", "csharp");
@@clientName(Microsoft.SecurityInsights.PackageKind, "SecurityInsightsMetadataPackageKind", "csharp");
@@clientName(Microsoft.SecurityInsights.Permissions, "ConnectorPermissions", "csharp");
@@clientName(Microsoft.SecurityInsights.PlaybookActionProperties, "AutomationRuleRunPlaybookActionProperties", "csharp");
@@clientName(Microsoft.SecurityInsights.ProcessEntity, "SecurityInsightsProcessEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.PropertyArrayChangedConditionProperties, "SecurityInsightsPropertyArrayChangedConditionProperties", "csharp");
@@clientName(Microsoft.SecurityInsights.PropertyChangedConditionProperties, "SecurityInsightsPropertyChangedConditionProperties", "csharp");
@@clientName(Microsoft.SecurityInsights.PropertyConditionProperties, "SecurityInsightsPropertyConditionProperties", "csharp");
@@clientName(Microsoft.SecurityInsights.ProviderName, "ConnectorProviderName", "csharp");
@@clientName(Microsoft.SecurityInsights.ProvisioningState, "TriggeredAnalyticsRuleRunProvisioningState", "csharp");
@@clientName(Microsoft.SecurityInsights.PullRequest, "PullRequestInfo", "csharp");
@@clientName(Microsoft.SecurityInsights.QueryCondition, "ThreatIntelligenceQueryCondition", "csharp");
@@clientName(Microsoft.SecurityInsights.QuerySortBy, "ThreatIntelligenceQuerySortBy", "csharp");
@@clientName(Microsoft.SecurityInsights.Recommendation, "SecurityInsightsRecommendation", "csharp");
@@clientName(Microsoft.SecurityInsights.ReevaluateResponse, "ReevaluateResult", "csharp");
@@clientName(Microsoft.SecurityInsights.RegistryHive, "SecurityInsightsRegistryHive", "csharp");
@@clientName(Microsoft.SecurityInsights.RegistryKeyEntity, "SecurityInsightsRegistryKeyEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.RegistryValueEntity, "SecurityInsightsRegistryValueEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.RegistryValueKind, "SecurityInsightsRegistryValueKind", "csharp");
@@clientName(Microsoft.SecurityInsights.Relation, "SecurityInsightsIncidentRelation", "csharp");
@@clientName(Microsoft.SecurityInsights.Relationship, "ThreatIntelligenceRelationship", "csharp");
@@clientName(Microsoft.SecurityInsights.Repo, "SourceControlRepo", "csharp");
@@clientName(Microsoft.SecurityInsights.RepoType, "SourceControlRepoType", "csharp");
@@clientName(Microsoft.SecurityInsights.Repository, "SourceControlRepository", "csharp");
@@clientName(Microsoft.SecurityInsights.RequiredPermissions, "ConnectorRequiredPermissions", "csharp");
@@clientName(Microsoft.SecurityInsights.ResourceProvider, "ConnectorResourceProvider", "csharp");
@@clientName(Microsoft.SecurityInsights.ResourceProviderRequiredPermissions, "ConnectorResourceProviderRequiredPermissions", "csharp");
@@clientName(Microsoft.SecurityInsights.SampleQueries, "SourceControlSampleQueries", "csharp");
@@clientName(Microsoft.SecurityInsights.ScheduledAlertRule, "SecurityInsightsScheduledAlertRule", "csharp");
@@clientName(Microsoft.SecurityInsights.SecurityAlert, "SecurityInsightsAlert", "csharp");
@@clientName(Microsoft.SecurityInsights.SecurityAlertPropertiesConfidenceReasonsItem, "SecurityInsightsAlertConfidenceReason", "csharp");
@@clientName(Microsoft.SecurityInsights.SecurityGroupEntity, "SecurityInsightsGroupEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.SentinelOnboardingState, "SecurityInsightsSentinelOnboardingState", "csharp");
@@clientName(Microsoft.SecurityInsights.ServicePrincipal, "SourceControlServicePrincipal", "csharp");
@@clientName(Microsoft.SecurityInsights.SettingList, "SecurityInsightsSettingList", "csharp");
@@clientName(Microsoft.SecurityInsights.SettingType, "ConnectorSettingType", "csharp");
@@clientName(Microsoft.SecurityInsights.Settings, "SecurityInsightsSettings", "csharp");
@@clientName(Microsoft.SecurityInsights.SettingsStatus, "AnomalySecurityMLAnalyticsSettingsStatus", "csharp");
@@clientName(Microsoft.SecurityInsights.SortingDirection, "ThreatIntelligenceQuerySortingDirection", "csharp");
@@clientName(Microsoft.SecurityInsights.SourceControl, "SecurityInsightsSourceControl", "csharp");
@@clientName(Microsoft.SecurityInsights.SourceKind, "SecurityInsightsSourceKind", "csharp");
@@clientName(Microsoft.SecurityInsights.SourceType, "WatchlistSourceType", "csharp");
@@clientName(Microsoft.SecurityInsights.State, "RecommendationState", "csharp");
@@clientName(Microsoft.SecurityInsights.SubmissionMailEntity, "SecurityInsightsSubmissionMailEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.SupportTier, "SecurityInsightsSupportTier", "csharp");
@@clientName(Microsoft.SecurityInsights.TICheckRequirements, "ThreatIntelligenceCheckRequirements", "csharp");
@@clientName(Microsoft.SecurityInsights.TIDataConnector, "SecurityInsightsTIDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.TIObject, "ThreatIntelligenceObject", "csharp");
@@clientName(Microsoft.SecurityInsights.TemplateStatus, "SecurityInsightsAlertRuleTemplateStatus", "csharp");
@@clientName(Microsoft.SecurityInsights.ThreatActor, "ThreatIntelligenceThreatActor", "csharp");
@@clientName(Microsoft.SecurityInsights.ThreatIntelligenceGranularMarkingModel, "ThreatIntelligenceGranularMarkingEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.ThreatIntelligenceIndicatorModel, "SecurityInsightsThreatIntelligenceIndicatorData", "csharp");
@@clientName(Microsoft.SecurityInsights.ThreatIntelligenceInformation, "SecurityInsightsThreatIntelligenceIndicatorBase", "csharp");
@@clientName(Microsoft.SecurityInsights.TiTaxiiCheckRequirements, "ThreatIntelligenceTaxiiCheckRequirements", "csharp");
@@clientName(Microsoft.SecurityInsights.TiTaxiiDataConnector, "ThreatIntelligenceTaxiiDataConnector", "csharp");
@@clientName(Microsoft.SecurityInsights.TiType, "ThreatIntelligenceType", "csharp");
@@clientName(Microsoft.SecurityInsights.TriggerOperator, "SecurityInsightsAlertRuleTriggerOperator", "csharp");
@@clientName(Microsoft.SecurityInsights.Ueba, "UebaSettings", "csharp");
@@clientName(Microsoft.SecurityInsights.UrlEntity, "SecurityInsightsUriEntity", "csharp");
@@clientName(Microsoft.SecurityInsights.UserInfo, "SecurityInsightsUserInfo", "csharp");
@@clientName(Microsoft.SecurityInsights.ValidationError, "SecurityInsightsFileValidationError", "csharp");
@@clientName(Microsoft.SecurityInsights.Version, "SourceControlVersion", "csharp");
@@clientName(Microsoft.SecurityInsights.Warning, "SourceControlOperationWarning", "csharp");
@@clientName(Microsoft.SecurityInsights.WarningBody, "SourceControlOperationWarningBody", "csharp");
@@clientName(Microsoft.SecurityInsights.WarningCode, "SourceControlOperationWarningCode", "csharp");
@@clientName(Microsoft.SecurityInsights.Watchlist, "SecurityInsightsWatchlist", "csharp");
@@clientName(Microsoft.SecurityInsights.WatchlistItem, "SecurityInsightsWatchlistItem", "csharp");
@@clientName(Microsoft.SecurityInsights.Webhook, "SourceControlWebhook", "csharp");

// C# member-level renames for backward compat
@@clientName(Microsoft.SecurityInsights.Operator.Equals, "EqualsValue", "csharp");
@@clientName(Microsoft.SecurityInsights.AutomationRulePropertyConditionSupportedOperator.Equals, "EqualsValue", "csharp");
@@clientName(Microsoft.SecurityInsights.SourceControlProperties.id, "SourceControlId", "csharp");
@@clientName(Microsoft.SecurityInsights.ThreatIntelligence, "SecurityInsightsThreatIntelligence", "csharp");

// C# renames for AZC0030 forbidden suffixes
@@clientName(Microsoft.SecurityInsights.ActionRequest, "SecurityInsightsAlertRuleActionCreateOrUpdateContent", "csharp");
@@clientName(Microsoft.SecurityInsights.BookmarkExpandParameters, "BookmarkExpandContent", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityExpandParameters, "EntityExpandContent", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityGetInsightsParameters, "EntityGetInsightsContent", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityGetInsightsResponse, "EntityGetInsightsResult", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityTimelineParameters, "EntityTimelineContent", "csharp");
@@clientName(Microsoft.SecurityInsights.EntityTimelineResponse, "EntityTimelineResult", "csharp");
