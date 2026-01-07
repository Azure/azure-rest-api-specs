import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SecurityInsights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ActionRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecurityAlert.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HuntingBookmark.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MetadataPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RepositoryAccessProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RepositoryAccessObject.repositoryAccess);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ThreatIntelligenceIndicatorModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CountQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TIObject.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AnalyticsRuleRunTrigger.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MLBehaviorAnalyticsAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MLBehaviorAnalyticsAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FusionAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FusionAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ThreatIntelligenceAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ThreatIntelligenceAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftSecurityIncidentCreationAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftSecurityIncidentCreationAlertRuleTemplate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduledAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NrtAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduledAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NrtAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SapSolutionUsageStatistic.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CustomizableConnectorDefinition.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AADCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AatpCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ASCCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Dynamics365CheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(McasCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MdatpCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MstiCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MtpCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficeATPCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficeIRMCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftPurviewInformationProtectionCheckRequirements.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Office365ProjectCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficePowerBICheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PurviewAuditCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TICheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TiTaxiiCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IoTCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AADDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MstiDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PremiumMicrosoftDefenderForThreatIntelligence.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MTPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AatpDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ASCDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AwsCloudTrailDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AwsS3DataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RestApiPollerDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GCPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(McasDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Dynamics365DataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficeATPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftPurviewInformationProtectionDataConnector.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Office365ProjectDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficePowerBIDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PurviewAuditDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficeIRMDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MdatpDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficeDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TIDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TiTaxiiDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IoTDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CodelessUiDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CodelessApiPollingDataConnector.properties);

@@clientName(InsightQueryItemPropertiesTableQueryQueriesDefinitionsPropertiesItemsItem.Query,
  "query"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ExpansionEntityQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ActivityEntityQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ActivityCustomEntityQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ActivityEntityQueryTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AnomalySecurityMLAnalyticsSettings.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Anomalies.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EyesOn.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EntityAnalytics.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Ueba.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AccountEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AzureResourceEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CloudApplicationEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DnsEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FileEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FileHashEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HostEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IoTDeviceEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IpEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MailboxEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MailClusterEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MailMessageEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MalwareEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ProcessEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RegistryKeyEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RegistryValueEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SecurityGroupEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SubmissionMailEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(UrlEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(NicEntity.properties);

@@clientName(AlertRules.createOrUpdate::parameters.resource, "alertRule");
@@clientLocation(AlertRules.triggerRuleRun, "alertRule");
@@clientName(AlertRules.triggerRuleRun::parameters.body,
  "analyticsRuleRunTriggerParameter"
);

@@clientLocation(ActionResponses.get, "Actions");
@@clientLocation(ActionResponses.createOrUpdate, "Actions");
@@clientName(ActionResponses.createOrUpdate::parameters.resource, "action");
@@clientLocation(ActionResponses.delete, "Actions");
@@clientLocation(ActionResponses.listByAlertRule, "Actions");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ActionResponse.properties);

@@clientName(AutomationRules.createOrUpdate::parameters.resource,
  "automationRuleToUpsert"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AutomationRule.properties);

@@clientName(Bookmarks.createOrUpdate::parameters.resource, "bookmark");
@@clientLocation(Bookmarks.expand, "Bookmark");
@@clientName(Bookmarks.expand::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Bookmark.properties);

@@clientLocation(Relations.get, "BookmarkRelations");
@@clientLocation(Relations.createOrUpdate, "BookmarkRelations");
@@clientName(Relations.createOrUpdate::parameters.resource, "relation");
@@clientLocation(Relations.delete, "BookmarkRelations");
@@clientLocation(Relations.list, "BookmarkRelations");
@@clientLocation(EntityRelations.list, "EntitiesRelations");
@@clientName(IncidentRelations.createOrUpdate::parameters.resource, "relation");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Relation.properties);

@@clientName(Entities.runPlaybook::parameters.body, "requestBody");
@@clientName(Entities.expand::parameters.body, "parameters");
@@clientName(Entities.getInsights::parameters.body, "parameters");
@@clientLocation(Entities.entitiesGetTimelineList, "EntitiesGetTimeline");
@@clientName(Entities.entitiesGetTimelineList, "list");
@@clientName(Entities.entitiesGetTimelineList::parameters.body, "parameters");

@@clientLocation(BusinessApplicationAgentResources.get,
  "BusinessApplicationAgent"
);
@@clientLocation(BusinessApplicationAgentResources.createOrUpdate,
  "BusinessApplicationAgents"
);
@@clientName(BusinessApplicationAgentResources.createOrUpdate::parameters.resource,
  "agentToUpsert"
);
@@clientLocation(BusinessApplicationAgentResources.delete,
  "BusinessApplicationAgents"
);
@@clientLocation(BusinessApplicationAgentResources.list,
  "BusinessApplicationAgents"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BusinessApplicationAgentResource.properties);

@@clientLocation(SystemResources.get, "Systems");
@@clientLocation(SystemResources.createOrUpdate, "Systems");
@@clientName(SystemResources.createOrUpdate::parameters.resource,
  "systemToUpsert"
);
@@clientLocation(SystemResources.delete, "Systems");
@@clientLocation(SystemResources.list, "Systems");
@@clientLocation(SystemResources.listActions, "Systems");
@@clientLocation(SystemResources.undoAction, "Systems");
@@clientName(SystemResources.undoAction::parameters.body, "payload");
@@clientLocation(SystemResources.reportActionStatus, "Systems");
@@clientName(SystemResources.reportActionStatus::parameters.body, "payload");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SystemResource.properties);

@@clientLocation(PackageModels.get, "ContentPackages");
@@clientLocation(PackageModels.install, "ContentPackage");
@@clientName(PackageModels.install::parameters.resource,
  "packageInstallationProperties"
);
@@clientLocation(PackageModels.uninstall, "ContentPackage");
@@clientLocation(PackageModels.list, "ContentPackages");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PackageModel.properties);

@@clientLocation(ProductPackageModels.get, "ProductPackage");
@@clientLocation(ProductPackageModels.list, "ProductPackages");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ProductPackageModel.properties);

@@clientLocation(ProductTemplateModels.get, "ProductTemplate");
@@clientLocation(ProductTemplateModels.list, "ProductTemplates");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ProductTemplateModel.properties);

@@clientLocation(TemplateModels.get, "ContentTemplate");
@@clientLocation(TemplateModels.install, "ContentTemplate");
@@clientName(TemplateModels.install::parameters.resource,
  "templateInstallationProperties"
);
@@clientLocation(TemplateModels.delete, "ContentTemplate");
@@clientLocation(TemplateModels.list, "ContentTemplates");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TemplateModel.properties);

@@clientName(DataConnectorDefinitions.createOrUpdate::parameters.resource,
  "connectorDefinitionInput"
);

@@clientName(DataConnectors.createOrUpdate::parameters.resource,
  "dataConnector"
);
@@clientName(DataConnectors.connect::parameters.body, "connectBody");

@@clientName(EntityQueries.createOrUpdate::parameters.resource, "entityQuery");

@@clientName(FileImports.create::parameters.resource, "fileImport");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FileImport.properties);

@@clientName(Hunts.createOrUpdate::parameters.resource, "hunt");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Hunt.properties);

@@clientName(HuntRelations.createOrUpdate::parameters.resource, "huntRelation");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HuntRelation.properties);

@@clientName(HuntComments.createOrUpdate::parameters.resource, "huntComment");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HuntComment.properties);

@@clientName(Incidents.createOrUpdate::parameters.resource, "incident");
@@clientName(Incidents.runPlaybook::parameters.body, "requestBody");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Incident.properties);

@@clientName(IncidentComments.createOrUpdate::parameters.resource,
  "incidentComment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IncidentComment.properties);

@@clientName(IncidentTasks.createOrUpdate::parameters.resource, "incidentTask");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IncidentTask.properties);

@@clientLocation(MetadataModels.get, "Metadata");
@@clientLocation(MetadataModels.create, "Metadata");
@@clientName(MetadataModels.create::parameters.resource, "metadata");
@@clientLocation(MetadataModels.update, "Metadata");
@@clientName(MetadataModels.update::parameters.properties, "metadataPatch");
@@clientLocation(MetadataModels.delete, "Metadata");
@@clientLocation(MetadataModels.list, "Metadata");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MetadataModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficeConsent.properties);

@@clientName(SentinelOnboardingStates.create::parameters.resource,
  "sentinelOnboardingStateParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SentinelOnboardingState.properties);

@@clientLocation(Recommendations.singleRecommendation, "Get");
@@clientLocation(Recommendations.recommendation, "Update");
@@clientName(Recommendations.recommendation::parameters.properties,
  "recommendationPatch"
);
@@clientLocation(Recommendations.list, "GetRecommendations");
@@clientLocation(Recommendations.reevaluateRecommendation, "Reevaluate");
@@clientName(Recommendations.reevaluateRecommendation, "Recommendation");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Recommendation.properties);

@@clientName(SecurityMLAnalyticsSettings.createOrUpdate::parameters.resource,
  "securityMLAnalyticsSetting"
);

@@clientName(ProductSettings.update::parameters.resource, "settings");

@@clientName(SourceControls.create::parameters.resource, "sourceControl");
@@clientName(SourceControls.delete::parameters.body, "repositoryAccess");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControl.properties);

@@clientLocation(ThreatIntelligenceInformations.get,
  "ThreatIntelligenceIndicator"
);
@@clientLocation(ThreatIntelligenceInformations.create,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceInformations.create::parameters.resource,
  "ThreatIntelligenceProperties"
);
@@clientLocation(ThreatIntelligenceInformations.delete,
  "ThreatIntelligenceIndicator"
);
@@clientLocation(ThreatIntelligenceInformations.list,
  "ThreatIntelligenceIndicators"
);
@@clientLocation(ThreatIntelligenceInformations.appendTags,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceInformations.appendTags::parameters.body,
  "ThreatIntelligenceAppendTags"
);
@@clientLocation(ThreatIntelligenceInformations.replaceTags,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceInformations.replaceTags::parameters.body,
  "ThreatIntelligenceReplaceTags"
);

@@clientLocation(triggeredAnalyticsRuleRun.get, triggeredAnalyticsRuleRun);
@@clientLocation(triggeredAnalyticsRuleRun.list,
  "getTriggeredAnalyticsRuleRuns"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TriggeredAnalyticsRuleRun.properties);

@@clientName(Watchlists.createOrUpdate::parameters.resource, "watchlist");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Watchlist.properties);

@@clientName(WatchlistItems.createOrUpdate::parameters.resource,
  "watchlistItem"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WatchlistItem.properties);

@@clientName(WorkspaceManagerAssignments.createOrUpdate::parameters.resource,
  "workspaceManagerAssignment"
);
@@clientLocation(WorkspaceManagerAssignments.create,
  "WorkspaceManagerAssignmentJobs"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceManagerAssignment.properties);

@@clientLocation(Jobs.get, "WorkspaceManagerAssignmentJobs");
@@clientLocation(Jobs.delete, "WorkspaceManagerAssignmentJobs");
@@clientLocation(Jobs.list, "WorkspaceManagerAssignmentJobs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Job.properties);

@@clientName(WorkspaceManagerConfigurations.createOrUpdate::parameters.resource,
  "workspaceManagerConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceManagerConfiguration.properties);

@@clientName(WorkspaceManagerGroups.createOrUpdate::parameters.resource,
  "workspaceManagerGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceManagerGroup.properties);

@@clientName(WorkspaceManagerMembers.createOrUpdate::parameters.resource,
  "workspaceManagerMember"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkspaceManagerMember.properties);

@@clientLocation(DataConnectorsCheckRequirementsOperationGroup.post,
  "DataConnectorsCheckRequirements"
);

@@clientLocation(SourceControlOperationGroup.listRepositories, "SourceControl");
@@clientName(SourceControlOperationGroup.listRepositories, "listRepositories");

@@clientLocation(ThreatIntelligenceIndicatorOperationGroup.createIndicator,
  "ThreatIntelligenceIndicator"
);
@@clientLocation(ThreatIntelligenceIndicatorOperationGroup.queryIndicators,
  "ThreatIntelligenceIndicator"
);

@@clientLocation(ThreatIntelligenceIndicatorMetricsOperationGroup.list,
  "ThreatIntelligenceIndicatorMetrics"
);

@@clientLocation(ThreatIntelligenceOperationGroup.count, "ThreatIntelligence");
@@clientLocation(ThreatIntelligenceOperationGroup.query, "ThreatIntelligence");
