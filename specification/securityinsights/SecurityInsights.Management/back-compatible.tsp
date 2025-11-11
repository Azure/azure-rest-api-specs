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
@@Legacy.flattenProperty(FusionAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FusionAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftSecurityIncidentCreationAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MicrosoftSecurityIncidentCreationAlertRuleTemplate.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduledAlertRule.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ScheduledAlertRuleTemplate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(CustomizableConnectorDefinition.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AADDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AatpDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ASCDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AwsCloudTrailDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RestApiPollerDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(McasDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MdatpDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(TIDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MstiDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PremiumMicrosoftDefenderForThreatIntelligence.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(OfficeDataConnector.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AnomalySecurityMLAnalyticsSettings.properties);

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

@@clientName(AlertRules.createOrUpdate::parameters.resource, "alertRule");

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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Bookmark.properties);

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

@@clientName(Incidents.createOrUpdate::parameters.resource, "incident");
@@clientName(Incidents.runPlaybook::parameters.body, "requestBody");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Incident.properties);

@@clientName(IncidentComments.createOrUpdate::parameters.resource,
  "incidentComment"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IncidentComment.properties);

@@clientLocation(Relations.get, "IncidentRelations");
@@clientLocation(Relations.createOrUpdate, "IncidentRelations");
@@clientName(Relations.createOrUpdate::parameters.resource, "relation");
@@clientLocation(Relations.delete, "IncidentRelations");
@@clientLocation(Relations.list, "IncidentRelations");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Relation.properties);

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

@@clientName(SentinelOnboardingStates.create::parameters.resource,
  "sentinelOnboardingStateParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SentinelOnboardingState.properties);

@@clientName(SecurityMLAnalyticsSettings.createOrUpdate::parameters.resource,
  "securityMLAnalyticsSetting"
);

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

@@clientName(Watchlists.createOrUpdate::parameters.resource, "watchlist");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Watchlist.properties);

@@clientName(WatchlistItems.createOrUpdate::parameters.resource,
  "watchlistItem"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WatchlistItem.properties);

@@clientLocation(EntitiesOperationGroup.runPlaybook, "Entities");

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
