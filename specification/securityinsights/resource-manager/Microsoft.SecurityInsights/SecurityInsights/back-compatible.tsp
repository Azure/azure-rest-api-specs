import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SecurityInsights;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActionRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityAlert.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HuntingBookmark.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MetadataPatch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RepositoryAccessProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RepositoryAccessObject.repositoryAccess);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThreatIntelligenceIndicatorModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CountQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TIObject.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AnalyticsRuleRunTrigger.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MLBehaviorAnalyticsAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MLBehaviorAnalyticsAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FusionAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FusionAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThreatIntelligenceAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ThreatIntelligenceAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MicrosoftSecurityIncidentCreationAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MicrosoftSecurityIncidentCreationAlertRuleTemplate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ScheduledAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NrtAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ScheduledAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(NrtAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SapSolutionUsageStatistic.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CustomizableConnectorDefinition.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AADCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AatpCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ASCCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Dynamics365CheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(McasCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MdatpCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MstiCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MtpCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficeATPCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficeIRMCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MicrosoftPurviewInformationProtectionCheckRequirements.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Office365ProjectCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficePowerBICheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PurviewAuditCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TICheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TiTaxiiCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IoTCheckRequirements.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AADDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MstiDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PremiumMicrosoftDefenderForThreatIntelligence.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MTPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AATPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ASCDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AwsCloudTrailDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AwsS3DataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RestApiPollerDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GCPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MCASDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Dynamics365DataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficeATPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MicrosoftPurviewInformationProtectionDataConnector.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Office365ProjectDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficePowerBIDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PurviewAuditDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficeIRMDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MDATPDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficeDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TIDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TiTaxiiDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IoTDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CodelessUiDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CodelessApiPollingDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ExpansionEntityQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActivityEntityQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActivityCustomEntityQuery.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActivityEntityQueryTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AnomalySecurityMLAnalyticsSettings.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Anomalies.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EyesOn.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EntityAnalytics.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Ueba.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AccountEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AzureResourceEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CloudApplicationEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DnsEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FileEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FileHashEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HostEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IoTDeviceEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IpEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MailboxEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MailClusterEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MailMessageEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MalwareEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ProcessEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RegistryKeyEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RegistryValueEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SecurityGroupEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SubmissionMailEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(UrlEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ActionResponse.properties);

@@clientName(AutomationRules.createOrUpdate::parameters.resource,
  "automationRuleToUpsert"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AutomationRule.properties);

@@clientName(Bookmarks.createOrUpdate::parameters.resource, "bookmark");
@@clientLocation(Bookmarks.expand, "Bookmark");
@@clientName(Bookmarks.expand::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Bookmark.properties);

@@clientName(Relations.createOrUpdate::parameters.resource, "relation");
@@clientLocation(EntityRelations.list, "EntitiesRelations");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Relation.properties);

@@clientName(Entities.runPlaybook::parameters.body, "requestBody");
@@clientName(Entities.expand::parameters.body, "parameters");
@@clientName(Entities.getInsights::parameters.body, "parameters");
@@clientLocation(Entities.entitiesGetTimelineList, "EntitiesGetTimeline");
@@clientName(Entities.entitiesGetTimelineList, "list");
@@clientName(Entities.entitiesGetTimelineList::parameters.body, "parameters");

@@clientLocation(PackageModels.get, "ContentPackages");
@@clientLocation(PackageModels.install, "ContentPackage");
@@clientName(PackageModels.install::parameters.resource,
  "packageInstallationProperties"
);
@@clientLocation(PackageModels.uninstall, "ContentPackage");
@@clientLocation(PackageModels.list, "ContentPackages");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PackageModel.properties);

@@clientLocation(ProductPackageModels.get, "ProductPackage");
@@clientLocation(ProductPackageModels.list, "ProductPackages");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ProductPackageModel.properties);

@@clientLocation(ProductTemplateModels.get, "ProductTemplate");
@@clientLocation(ProductTemplateModels.list, "ProductTemplates");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ProductTemplateModel.properties);

@@clientLocation(TemplateModels.get, "ContentTemplate");
@@clientLocation(TemplateModels.install, "ContentTemplate");
@@clientName(TemplateModels.install::parameters.resource,
  "templateInstallationProperties"
);
@@clientLocation(TemplateModels.delete, "ContentTemplate");
@@clientLocation(TemplateModels.list, "ContentTemplates");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FileImport.properties);

@@clientName(Hunts.createOrUpdate::parameters.resource, "hunt");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Hunt.properties);

@@clientName(HuntRelations.createOrUpdate::parameters.resource, "huntRelation");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HuntRelation.properties);

@@clientName(HuntComments.createOrUpdate::parameters.resource, "huntComment");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(HuntComment.properties);

@@clientName(Incidents.createOrUpdate::parameters.resource, "incident");
@@clientName(Incidents.runPlaybook::parameters.body, "requestBody");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Incident.properties);

@@clientName(IncidentComments.createOrUpdate::parameters.resource,
  "incidentComment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IncidentComment.properties);

@@clientLocation(Relations.get, "IncidentRelations");
@@clientLocation(Relations.createOrUpdate, "IncidentRelations");

@@clientLocation(Relations.delete, "IncidentRelations");
@@clientLocation(Relations.list, "IncidentRelations");

@@clientName(IncidentTasks.createOrUpdate::parameters.resource, "incidentTask");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IncidentTask.properties);

@@clientLocation(MetadataModels.get, "Metadata");
@@clientLocation(MetadataModels.create, "Metadata");
@@clientName(MetadataModels.create::parameters.resource, "metadata");
@@clientLocation(MetadataModels.update, "Metadata");
@@clientName(MetadataModels.update::parameters.properties, "metadataPatch");
@@clientLocation(MetadataModels.delete, "Metadata");
@@clientLocation(MetadataModels.list, "Metadata");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MetadataModel.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OfficeConsent.properties);

@@clientName(SentinelOnboardingStates.create::parameters.resource,
  "sentinelOnboardingStateParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SentinelOnboardingState.properties);

@@clientLocation(Recommendations.singleRecommendation, "Get");
@@clientLocation(Recommendations.recommendation, "Update");
@@clientName(Recommendations.recommendation::parameters.properties,
  "recommendationPatch"
);
@@clientLocation(Recommendations.list, "GetRecommendations");
@@clientLocation(Recommendations.reevaluateRecommendation, "Reevaluate");
@@clientName(Recommendations.reevaluateRecommendation, "Recommendation");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Recommendation.properties);

@@clientName(SecurityMLAnalyticsSettings.createOrUpdate::parameters.resource,
  "securityMLAnalyticsSetting"
);

@@clientName(ProductSettings.update::parameters.resource, "settings");

@@clientName(SourceControls.create::parameters.resource, "sourceControl");
@@clientName(SourceControls.delete::parameters.body, "repositoryAccess");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SourceControl.properties);

@@clientLocation(ThreatIntelligenceInformationOperations.get,
  "ThreatIntelligenceIndicator"
);
@@clientLocation(ThreatIntelligenceInformationOperations.create,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceInformationOperations.create::parameters.resource,
  "ThreatIntelligenceProperties"
);
@@clientLocation(ThreatIntelligenceInformationOperations.delete,
  "ThreatIntelligenceIndicator"
);
@@clientLocation(ThreatIntelligenceInformationOperations.list,
  "ThreatIntelligenceIndicators"
);
@@clientLocation(ThreatIntelligenceInformationOperations.appendTags,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceInformationOperations.appendTags::parameters.body,
  "ThreatIntelligenceAppendTags"
);
@@clientLocation(ThreatIntelligenceInformationOperations.replaceTags,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceInformationOperations.replaceTags::parameters.body,
  "ThreatIntelligenceReplaceTags"
);

@@clientLocation(triggeredAnalyticsRuleRun.get, triggeredAnalyticsRuleRun);
@@clientLocation(triggeredAnalyticsRuleRun.list,
  "getTriggeredAnalyticsRuleRuns"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TriggeredAnalyticsRuleRun.properties);

@@clientName(Watchlists.createOrUpdate::parameters.resource, "watchlist");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Watchlist.properties);

@@clientName(WatchlistItems.createOrUpdate::parameters.resource,
  "watchlistItem"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WatchlistItem.properties);

@@clientName(WorkspaceManagerAssignments.createOrUpdate::parameters.resource,
  "workspaceManagerAssignment"
);
@@clientLocation(WorkspaceManagerAssignments.create,
  "WorkspaceManagerAssignmentJobs"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkspaceManagerAssignment.properties);

@@clientLocation(Jobs.get, "WorkspaceManagerAssignmentJobs");
@@clientLocation(Jobs.delete, "WorkspaceManagerAssignmentJobs");
@@clientLocation(Jobs.list, "WorkspaceManagerAssignmentJobs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Job.properties);

@@clientName(WorkspaceManagerConfigurations.createOrUpdate::parameters.resource,
  "workspaceManagerConfiguration"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkspaceManagerConfiguration.properties);

@@clientName(WorkspaceManagerGroups.createOrUpdate::parameters.resource,
  "workspaceManagerGroup"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkspaceManagerGroup.properties);

@@clientName(WorkspaceManagerMembers.createOrUpdate::parameters.resource,
  "workspaceManagerMember"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
@@clientName(ThreatIntelligenceIndicatorOperationGroup.createIndicator::parameters.body,
  "ThreatIntelligenceProperties"
);

@@clientName(PackageList, "packageList");
@@clientName(PackageModel, "packageModel");
@@clientName(ProductPackageList, "productPackageList");
@@clientName(ProductPackageModel, "productPackageModel");
@@clientName(ProductTemplateList, "productTemplateList");
@@clientName(ProductTemplateModel, "productTemplateModel");
@@clientName(ProductTemplateProperties, "productTemplateProperties");
@@clientName(MetadataPatch, "metadataPatch");
@@clientName(MetadataPropertiesPatch, "metadataPropertiesPatch");
@@clientName(TemplateList, "templateList");
@@clientName(TemplateModel, "templateModel");
@@clientName(TemplateProperties, "templateProperties");
@@clientName(ThreatIntelligence, "threatIntelligence");
@@clientName(TemplateAdditionalProperties, "templateAdditionalProperties");
@@clientName(MetadataSource, "metadataSource");
@@clientName(MetadataAuthor, "metadataAuthor");
@@clientName(MetadataSupport, "metadataSupport");
@@clientName(MetadataDependencies, "metadataDependencies");
@@clientName(MetadataCategories, "metadataCategories");
@@clientName(MetadataProperties, "metadataProperties");
@@clientName(PackageBaseProperties, "packageBaseProperties");
@@clientName(ProductPackageProperties, "productPackageProperties");
@@clientName(PackageProperties, "packageProperties");
@@clientName(ProductPackageAdditionalProperties,
  "productPackageAdditionalProperties"
);

@@visibility(Azure.ResourceManager.Legacy.PolymorphicResourceKindProperty.kind,
  Lifecycle.Read
);
@@visibility(Azure.ResourceManager.Legacy.PolymorphicResourceKindProperty.kind,
  Lifecycle.Create
);
@@visibility(Azure.ResourceManager.Legacy.PolymorphicResourceKindProperty.kind,
  Lifecycle.Update
);
@@visibility(Azure.ResourceManager.Legacy.PolymorphicResourceKindProperty.kind,
  Lifecycle.Delete
);
@@visibility(Azure.ResourceManager.Legacy.PolymorphicResourceKindProperty.kind,
  Lifecycle.Query
);
@@pattern(Azure.ResourceManager.Legacy.PolymorphicResourceKindProperty.kind,
  ""
);

@@doc(IncidentComments.get, "Gets an incident comment.");
@@doc(Relations.createOrUpdate, "Creates or updates the incident relation.");

@@doc(AADDataConnector,
  "Represents AADIP (Azure Active Directory Identity Protection) data connector."
);
@@doc(AADDataConnector.properties,
  "AADIP (Azure Active Directory Identity Protection) data connector properties."
);
@@doc(EntityManualTriggerRequestBody.incidentArmId, "Incident ARM id.");
@@doc(EntityQueryTemplate.kind, "The kind of the entity query template.");
@@doc(FusionAlertRuleTemplateProperties,
  "Fusion alert rule template properties"
);
@@doc(FusionAlertRuleTemplateProperties.alertRulesCreatedByTemplateCount,
  "The number of alert rules that were created by this template"
);
@@doc(FusionAlertRuleTemplateProperties.techniques,
  "The techniques of the alert rule"
);
@@doc(Azure.Core.armResourceIdentifier, "Related Analytic rule resource id");
@@doc(MetadataProperties.firstPublishDate,
  "first publish date of solution content item"
);
@@doc(MetadataProperties.lastPublishDate,
  "last publish date of solution content item"
);
@@doc(MetadataPropertiesPatch.contentId,
  "Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Can be optionally set for user created content to define dependencies.  If an active content item is made from a template, both will have the same contentId."
);
@@doc(MetadataPropertiesPatch.firstPublishDate,
  "first publish date of solution content item"
);
@@doc(MetadataPropertiesPatch.lastPublishDate,
  "last publish date of solution content item"
);
@@doc(MetadataProperties.contentId,
  "Static ID for the content.  Used to identify dependencies and content from solutions or community.  Hard-coded/static for out of the box content and solutions. Can be optionally set for user created content to define dependencies.  If an active content item is made from a template, both will have the same contentId."
);

@@clientName(OutputType, "outputType");
@@clientName(JobItem, "jobItem");
@@clientName(McasCheckRequirements, "MCASCheckRequirements");
@@clientName(McasCheckRequirementsProperties,
  "MCASCheckRequirementsProperties"
);
@@clientName(MdatpCheckRequirements, "MDATPCheckRequirements");
@@clientName(MdatpCheckRequirementsProperties,
  "MDATPCheckRequirementsProperties"
);
@@clientName(MstiCheckRequirements, "MSTICheckRequirements");
@@clientName(MstiCheckRequirementsProperties,
  "MSTICheckRequirementsProperties"
);
@@clientName(MstiDataConnector, "MSTIDataConnector");
@@clientName(MstiDataConnectorProperties, "MSTIDataConnectorProperties");
@@clientName(MstiDataConnectorDataTypes, "MSTIDataConnectorDataTypes");
@@clientName(AssignmentItem, "assignmentItem");
@@clientName(Error, "error");
@@clientName(ProductTemplateAdditionalProperties,
  "productTemplateAdditionalProperties"
);
@@visibility(RelationList.nextLink, Lifecycle.Read);
@@clientName(ThreatIntelligenceIndicatorOperationGroup.queryIndicators::parameters.body,
  "ThreatIntelligenceFilteringCriteria"
);
@@clientName(AatpCheckRequirements, "AATPCheckRequirements");
@@clientName(AatpCheckRequirementsProperties,
  "AATPCheckRequirementsProperties"
);
@@clientName(BookmarkRelations.createOrUpdate::parameters.resource, "relation");
