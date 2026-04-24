import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CognitiveServices;

@@clientName(Accounts.create::parameters.resource, "account");
@@clientName(Accounts.update::parameters.properties, "account");
@@clientName(Accounts.regenerateKey::parameters.body, "parameters");
@@clientLocation(Accounts.privateLinkResourcesList,
  "PrivateLinkResources",
  "!csharp"
);
@@clientName(Accounts.privateLinkResourcesList, "List");
@@clientLocation(Accounts.createOrUpdate,
  "TestRaiExternalSafetyProvider",
  "!csharp"
);
@@clientName(Accounts.createOrUpdate::parameters.resource, "safetyProvider");
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.provisionManagedNetwork,
  "ManagedNetworkProvisions",
  "!csharp"
);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(Deployments.createOrUpdate::parameters.resource, "deployment");
@@clientName(Deployments.update::parameters.properties, "deployment");

@@clientName(CommitmentPlans.createOrUpdate::parameters.resource,
  "commitmentPlan"
);
@@clientLocation(CommitmentPlanOperationGroup.getPlan,
  CommitmentPlans,
  "!csharp"
);
@@clientLocation(CommitmentPlanOperationGroup.createOrUpdatePlan,
  CommitmentPlans,
  "!csharp"
);
@@clientName(CommitmentPlanOperationGroup.createOrUpdatePlan::parameters.resource,
  "commitmentPlan"
);
@@clientLocation(CommitmentPlanOperationGroup.updatePlan,
  CommitmentPlans,
  "!csharp"
);
@@clientName(CommitmentPlanOperationGroup.updatePlan::parameters.properties,
  "commitmentPlan"
);
@@clientLocation(CommitmentPlanOperationGroup.deletePlan,
  CommitmentPlans,
  "!csharp"
);
@@clientLocation(CommitmentPlanOperationGroup.listPlansByResourceGroup,
  CommitmentPlans,
  "!csharp"
);
@@clientLocation(CommitmentPlanOperationGroup.listPlansBySubscription,
  CommitmentPlans,
  "!csharp"
);

@@clientName(EncryptionScopes.createOrUpdate::parameters.resource,
  "encryptionScope"
);

@@clientName(RaiPolicies.createOrUpdate::parameters.resource, "raiPolicy");
@@clientName(SubscriptionRaiPolicy.createOrUpdate::parameters.resource,
  "raiPolicy"
);

@@clientName(RaiBlocklists.createOrUpdate::parameters.resource, "raiBlocklist");
@@clientLocation(RaiBlocklists.batchAdd, RaiBlocklistItems, "!csharp");
@@clientName(RaiBlocklists.batchAdd::parameters.body, "raiBlocklistItems");
@@clientLocation(RaiBlocklists.batchDelete, RaiBlocklistItems, "!csharp");
@@clientName(RaiBlocklists.batchDelete::parameters.body,
  "raiBlocklistItemsNames"
);

@@clientName(RaiBlocklistItems.createOrUpdate::parameters.resource,
  "raiBlocklistItem"
);

@@clientName(RaiTopics.createOrUpdate::parameters.resource, "raiTopic");

@@clientLocation(RaiExternalSafetyProviderSchemas.get,
  "RaiExternalSafetyProvider",
  "!csharp"
);
@@clientLocation(RaiExternalSafetyProviderSchemas.createOrUpdate,
  "RaiExternalSafetyProvider",
  "!csharp"
);
@@clientName(RaiExternalSafetyProviderSchemas.createOrUpdate::parameters.resource,
  "safetyProvider"
);
@@clientLocation(RaiExternalSafetyProviderSchemas.delete,
  "RaiExternalSafetyProvider",
  "!csharp"
);
@@clientLocation(RaiExternalSafetyProviderSchemas.list,
  "RaiExternalSafetyProviders",
  "!csharp"
);

@@clientName(RaiToolLabels.createOrUpdate::parameters.resource, "raiToolLabel");

@@clientLocation(CommitmentPlanAccountAssociations.getAssociation,
  CommitmentPlans,
  "!csharp"
);
@@clientLocation(CommitmentPlanAccountAssociations.createOrUpdateAssociation,
  CommitmentPlans,
  "!csharp"
);
@@clientName(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "association"
);
@@clientLocation(CommitmentPlanAccountAssociations.deleteAssociation,
  CommitmentPlans,
  "!csharp"
);
@@clientLocation(CommitmentPlanAccountAssociations.listAssociations,
  CommitmentPlans,
  "!csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy usage decorator to flatten CommitmentPlanAccountAssociation.properties for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommitmentPlanAccountAssociation.properties
);

@@clientName(DefenderForAISettings.createOrUpdate::parameters.resource,
  "defenderForAISettings"
);
@@clientName(DefenderForAISettings.update::parameters.properties,
  "defenderForAISettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy usage decorator to flatten DefenderForAISetting.properties for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DefenderForAISetting.properties
);

@@clientName(Projects.create::parameters.resource, "project");
@@clientName(Projects.update::parameters.properties, "project");

@@clientLocation(ConnectionPropertiesV2BasicResources.get,
  "AccountConnections",
  "!csharp"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.create,
  "AccountConnections",
  "!csharp"
);
@@clientName(ConnectionPropertiesV2BasicResources.create::parameters.resource,
  "connection"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.update,
  "AccountConnections",
  "!csharp"
);
@@clientName(ConnectionPropertiesV2BasicResources.update::parameters.properties,
  "connection"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.delete,
  "AccountConnections",
  "!csharp"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.list,
  "AccountConnections",
  "!csharp"
);
@@clientName(ProjectConnections.create::parameters.resource, "connection");
@@clientName(ProjectConnections.update::parameters.properties, "connection");

@@clientLocation(CapabilityHosts.get, "AccountCapabilityHosts", "!csharp");
@@clientLocation(CapabilityHosts.createOrUpdate,
  "AccountCapabilityHosts",
  "!csharp"
);
@@clientName(CapabilityHosts.createOrUpdate::parameters.resource,
  "capabilityHost"
);
@@clientLocation(CapabilityHosts.delete, "AccountCapabilityHosts", "!csharp");
@@clientLocation(CapabilityHosts.list, "AccountCapabilityHosts", "!csharp");

@@clientName(ProjectCapabilityHosts.createOrUpdate::parameters.resource,
  "capabilityHost"
);

@@clientName(QuotaTiers.createOrUpdate::parameters.resource, "tier");
@@clientName(QuotaTiers.update::parameters.properties, "tier");

@@clientLocation(OutboundRuleBasicResources.get, "OutboundRule", "!csharp");
@@clientLocation(OutboundRuleBasicResources.createOrUpdate,
  "OutboundRule",
  "!csharp"
);
@@clientName(OutboundRuleBasicResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(OutboundRuleBasicResources.delete, "OutboundRule", "!csharp");
@@clientLocation(OutboundRuleBasicResources.list, "OutboundRule", "!csharp");

@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.get,
  "ManagedNetworkSettings",
  "!csharp"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.put,
  "ManagedNetworkSettings",
  "!csharp"
);
@@clientName(ManagedNetworkSettingsPropertiesBasicResources.put::parameters.resource,
  "body"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.patch,
  "ManagedNetworkSettings",
  "!csharp"
);
@@clientName(ManagedNetworkSettingsPropertiesBasicResources.patch::parameters.properties,
  "body"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.list,
  "ManagedNetworkSettings",
  "!csharp"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.delete,
  "ManagedNetworkSettings",
  "!csharp"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.post,
  "OutboundRules",
  "!csharp"
);

@@clientName(AgentApplications.createOrUpdate::parameters.resource, "body");

@@clientLocation(AgentDeploymentResources.get, "AgentDeployments", "!csharp");
@@clientLocation(AgentDeploymentResources.createOrUpdate,
  "AgentDeployments",
  "!csharp"
);
@@clientName(AgentDeploymentResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(AgentDeploymentResources.delete,
  "AgentDeployments",
  "!csharp"
);
@@clientLocation(AgentDeploymentResources.list, "AgentDeployments", "!csharp");
@@clientLocation(AgentDeploymentResources.start, "AgentDeployments", "!csharp");
@@clientLocation(AgentDeploymentResources.stop, "AgentDeployments", "!csharp");

@@clientLocation(ResourceSkusOperationGroup.list, "ResourceSkus", "!csharp");

@@clientLocation(UsagesOperationGroup.list, "Usages", "!csharp");

@@clientName(calculateModelCapacity, "calculateModelCapacity");

@@clientLocation(CommitmentTiersOperationGroup.list,
  "CommitmentTiers",
  "!csharp"
);

@@clientLocation(ModelsOperationGroup.list, "Models", "!csharp");

@@clientLocation(LocationBasedModelCapacitiesOperationGroup.list,
  "LocationBasedModelCapacities",
  "!csharp"
);

@@clientLocation(ModelCapacitiesOperationGroup.list,
  "ModelCapacities",
  "!csharp"
);
@@clientName(calculateModelCapacity::parameters.body, "parameters");
@@clientName(checkDomainAvailability::parameters.body, "parameters");
@@clientName(checkSkuAvailability::parameters.body, "parameters");

@@visibility(Project.tags, Lifecycle.Read, Lifecycle.Create, Lifecycle.Update);
@@visibility(CommitmentPlan.tags,
  Lifecycle.Read,
  Lifecycle.Create,
  Lifecycle.Update
);
@@visibility(Account.tags, Lifecycle.Read, Lifecycle.Create, Lifecycle.Update);
@@TypeSpec.Http.header(Azure.ResourceManager.ArmLroLocationHeader.location,
  "location"
);
