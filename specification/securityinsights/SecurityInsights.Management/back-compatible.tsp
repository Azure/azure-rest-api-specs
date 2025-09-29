import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SecurityInsights;
using Azure.ClientGenerator.Core.Legacy;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ActionRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SecurityAlert.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HuntingBookmark.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MetadataPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RepositoryAccessProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RepositoryAccessObject.repositoryAccess);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ThreatIntelligenceIndicatorModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FusionAlertRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FusionAlertRuleTemplate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MicrosoftSecurityIncidentCreationAlertRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MicrosoftSecurityIncidentCreationAlertRuleTemplate.properties
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduledAlertRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ScheduledAlertRuleTemplate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CustomizableConnectorDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AADDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AATPDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ASCDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AwsCloudTrailDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestApiPollerDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MCASDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MDATPDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TIDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MSTIDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PremiumMicrosoftDefenderForThreatIntelligence.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OfficeDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AnomalySecurityMLAnalyticsSettings.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AccountEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureResourceEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudApplicationEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DnsEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileHashEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(HostEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IoTDeviceEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IpEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MailboxEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MailClusterEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MailMessageEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MalwareEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProcessEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegistryKeyEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegistryValueEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SecurityGroupEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubmissionMailEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UrlEntity.properties);

@@clientName(AlertRules.createOrUpdate::parameters.resource, "alertRule");

@@clientLocation(ActionResponses.get, "Actions");
@@clientLocation(ActionResponses.createOrUpdate, "Actions");
@@clientName(ActionResponses.createOrUpdate::parameters.resource, "action");
@@clientLocation(ActionResponses.delete, "Actions");
@@clientLocation(ActionResponses.listByAlertRule, "Actions");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ActionResponse.properties);

@@clientName(AutomationRules.createOrUpdate::parameters.resource,
  "automationRuleToUpsert"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AutomationRule.properties);

@@clientName(Bookmarks.createOrUpdate::parameters.resource, "bookmark");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Bookmark.properties);

@@clientLocation(PackageModels.get, "ContentPackages");
@@clientLocation(PackageModels.install, "ContentPackage");
@@clientName(PackageModels.install::parameters.resource,
  "packageInstallationProperties"
);
@@clientLocation(PackageModels.uninstall, "ContentPackage");
@@clientLocation(PackageModels.list, "ContentPackages");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PackageModel.properties);

@@clientLocation(ProductPackageModels.get, "ProductPackage");
@@clientLocation(ProductPackageModels.list, "ProductPackages");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductPackageModel.properties);

@@clientLocation(ProductTemplateModels.get, "ProductTemplate");
@@clientLocation(ProductTemplateModels.list, "ProductTemplates");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ProductTemplateModel.properties);

@@clientLocation(TemplateModels.get, "ContentTemplate");
@@clientLocation(TemplateModels.install, "ContentTemplate");
@@clientName(TemplateModels.install::parameters.resource,
  "templateInstallationProperties"
);
@@clientLocation(TemplateModels.delete, "ContentTemplate");
@@clientLocation(TemplateModels.list, "ContentTemplates");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TemplateModel.properties);

@@clientName(DataConnectorDefinitions.createOrUpdate::parameters.resource,
  "connectorDefinitionInput"
);

@@clientName(DataConnectors.createOrUpdate::parameters.resource,
  "dataConnector"
);

@@clientName(Incidents.createOrUpdate::parameters.resource, "incident");
@@clientName(Incidents.runPlaybook::parameters.body, "requestBody");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Incident.properties);

@@clientName(IncidentComments.createOrUpdate::parameters.resource,
  "incidentComment"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IncidentComment.properties);

@@clientLocation(Relations.get, "IncidentRelations");
@@clientLocation(Relations.createOrUpdate, "IncidentRelations");
@@clientName(Relations.createOrUpdate::parameters.resource, "relation");
@@clientLocation(Relations.delete, "IncidentRelations");
@@clientLocation(Relations.list, "IncidentRelations");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Relation.properties);

@@clientName(IncidentTasks.createOrUpdate::parameters.resource, "incidentTask");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IncidentTask.properties);

@@clientLocation(MetadataModels.get, "Metadata");
@@clientLocation(MetadataModels.create, "Metadata");
@@clientName(MetadataModels.create::parameters.resource, "metadata");
@@clientLocation(MetadataModels.update, "Metadata");
@@clientName(MetadataModels.update::parameters.properties, "metadataPatch");
@@clientLocation(MetadataModels.delete, "Metadata");
@@clientLocation(MetadataModels.list, "Metadata");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MetadataModel.properties);

@@clientName(SentinelOnboardingStates.create::parameters.resource,
  "sentinelOnboardingStateParameter"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SentinelOnboardingState.properties);

@@clientName(SecurityMLAnalyticsSettings.createOrUpdate::parameters.resource,
  "securityMLAnalyticsSetting"
);

@@clientName(SourceControls.create::parameters.resource, "sourceControl");
@@clientName(SourceControls.delete::parameters.body, "repositoryAccess");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SourceControl.properties);

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

@@clientName(Watchlists.createOrUpdate::parameters.resource, "watchlist");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Watchlist.properties);

@@clientName(WatchlistItems.createOrUpdate::parameters.resource,
  "watchlistItem"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WatchlistItem.properties);

@@clientLocation(EntitiesOperationGroup.runPlaybook, "Entities");

@@clientLocation(SourceControlOperationGroup.listRepositories, "SourceControl");
@@clientName(SourceControlOperationGroup.listRepositories, "listRepositories");

@@clientLocation(ThreatIntelligenceIndicatorOperationGroup.createIndicator,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceIndicatorOperationGroup.createIndicator::parameters.body,
  "ThreatIntelligenceProperties"
);
@@clientLocation(ThreatIntelligenceIndicatorOperationGroup.queryIndicators,
  "ThreatIntelligenceIndicator"
);
@@clientName(ThreatIntelligenceIndicatorOperationGroup.queryIndicators::parameters.body,
  "ThreatIntelligenceFilteringCriteria"
);

@@clientLocation(ThreatIntelligenceIndicatorMetricsOperationGroup.list,
  "ThreatIntelligenceIndicatorMetrics"
);
