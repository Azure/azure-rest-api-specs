import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.SecurityInsights;
using Azure.ClientGenerator.Core.Legacy;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ActionRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SecurityAlert.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(HuntingBookmark.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MetadataPatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(RepositoryAccessProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(RepositoryAccessObject.repositoryAccess);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ThreatIntelligenceIndicatorModel.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(FusionAlertRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(FusionAlertRuleTemplate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MicrosoftSecurityIncidentCreationAlertRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MicrosoftSecurityIncidentCreationAlertRuleTemplate.properties
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ScheduledAlertRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ScheduledAlertRuleTemplate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(CustomizableConnectorDefinition.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(AADDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(AATPDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ASCDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(AwsCloudTrailDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(RestApiPollerDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MCASDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MDATPDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(TIDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MSTIDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(PremiumMicrosoftDefenderForThreatIntelligence.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(OfficeDataConnector.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(AnomalySecurityMLAnalyticsSettings.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(AccountEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(AzureResourceEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(CloudApplicationEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(DnsEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(FileEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(FileHashEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(HostEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(IoTDeviceEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(IpEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MailboxEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MailClusterEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MailMessageEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MalwareEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ProcessEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(RegistryKeyEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(RegistryValueEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SecurityGroupEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SubmissionMailEntity.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(UrlEntity.properties);

@@clientName(AlertRules.createOrUpdate::parameters.resource, "alertRule");

@@clientLocation(ActionResponses.get, "Actions");
@@clientLocation(ActionResponses.createOrUpdate, "Actions");
@@clientName(ActionResponses.createOrUpdate::parameters.resource, "action");
@@clientLocation(ActionResponses.delete, "Actions");
@@clientLocation(ActionResponses.listByAlertRule, "Actions");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ActionResponse.properties);

@@clientName(AutomationRules.createOrUpdate::parameters.resource,
  "automationRuleToUpsert"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(AutomationRule.properties);

@@clientName(Bookmarks.createOrUpdate::parameters.resource, "bookmark");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Bookmark.properties);

@@clientLocation(PackageModels.get, "ContentPackages");
@@clientLocation(PackageModels.install, "ContentPackage");
@@clientName(PackageModels.install::parameters.resource,
  "packageInstallationProperties"
);
@@clientLocation(PackageModels.uninstall, "ContentPackage");
@@clientLocation(PackageModels.list, "ContentPackages");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(PackageModel.properties);

@@clientLocation(ProductPackageModels.get, "ProductPackage");
@@clientLocation(ProductPackageModels.list, "ProductPackages");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ProductPackageModel.properties);

@@clientLocation(ProductTemplateModels.get, "ProductTemplate");
@@clientLocation(ProductTemplateModels.list, "ProductTemplates");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(ProductTemplateModel.properties);

@@clientLocation(TemplateModels.get, "ContentTemplate");
@@clientLocation(TemplateModels.install, "ContentTemplate");
@@clientName(TemplateModels.install::parameters.resource,
  "templateInstallationProperties"
);
@@clientLocation(TemplateModels.delete, "ContentTemplate");
@@clientLocation(TemplateModels.list, "ContentTemplates");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Incident.properties);

@@clientName(IncidentComments.createOrUpdate::parameters.resource,
  "incidentComment"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(IncidentComment.properties);

@@clientLocation(Relations.get, "IncidentRelations");
@@clientLocation(Relations.createOrUpdate, "IncidentRelations");
@@clientName(Relations.createOrUpdate::parameters.resource, "relation");
@@clientLocation(Relations.delete, "IncidentRelations");
@@clientLocation(Relations.list, "IncidentRelations");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Relation.properties);

@@clientName(IncidentTasks.createOrUpdate::parameters.resource, "incidentTask");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(IncidentTask.properties);

@@clientLocation(MetadataModels.get, "Metadata");
@@clientLocation(MetadataModels.create, "Metadata");
@@clientName(MetadataModels.create::parameters.resource, "metadata");
@@clientLocation(MetadataModels.update, "Metadata");
@@clientName(MetadataModels.update::parameters.properties, "metadataPatch");
@@clientLocation(MetadataModels.delete, "Metadata");
@@clientLocation(MetadataModels.list, "Metadata");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(MetadataModel.properties);

@@clientName(SentinelOnboardingStates.create::parameters.resource,
  "sentinelOnboardingStateParameter"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(SentinelOnboardingState.properties);

@@clientName(SecurityMLAnalyticsSettings.createOrUpdate::parameters.resource,
  "securityMLAnalyticsSetting"
);

@@clientName(SourceControls.create::parameters.resource, "sourceControl");
@@clientName(SourceControls.delete::parameters.body, "repositoryAccess");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(Watchlist.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@clientName(WatchlistItems.createOrUpdate::parameters.resource,
  "watchlistItem"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@flattenProperty(WatchlistItem.properties);

@@clientLocation(EntitiesOperationGroup.runPlaybook, "Entities");
@@clientName(EntitiesOperationGroup.runPlaybook::parameters.body,
  "requestBody"
);

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
