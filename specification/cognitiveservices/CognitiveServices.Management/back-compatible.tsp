import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.CognitiveServices;

@@clientName(Accounts.create::parameters.resource, "account");
@@clientName(Accounts.update::parameters.properties, "account");
@@clientName(Accounts.regenerateKey::parameters.body, "parameters");
@@clientLocation(Accounts.privateLinkResourcesList, "PrivateLinkResources");
@@clientName(Accounts.privateLinkResourcesList, "List");
@@clientLocation(Accounts.createOrUpdate, "TestRaiExternalSafetyProvider");
@@clientName(Accounts.createOrUpdate::parameters.resource, "safetyProvider");
@@clientLocation(Accounts.provisionManagedNetwork, "ManagedNetworkProvisions");

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "properties"
);

@@clientName(Deployments.createOrUpdate::parameters.resource, "deployment");
@@clientName(Deployments.update::parameters.properties, "deployment");

@@clientName(CommitmentPlans.createOrUpdate::parameters.resource,
  "commitmentPlan"
);
@@clientLocation(CommitmentPlanOperationGroup.getPlan, CommitmentPlans);
@@clientLocation(CommitmentPlanOperationGroup.createOrUpdatePlan,
  CommitmentPlans
);
@@clientName(CommitmentPlanOperationGroup.createOrUpdatePlan::parameters.resource,
  "commitmentPlan"
);
@@clientLocation(CommitmentPlanOperationGroup.updatePlan, CommitmentPlans);
@@clientName(CommitmentPlanOperationGroup.updatePlan::parameters.properties,
  "commitmentPlan"
);
@@clientLocation(CommitmentPlanOperationGroup.deletePlan, CommitmentPlans);
@@clientLocation(CommitmentPlanOperationGroup.listPlansByResourceGroup,
  CommitmentPlans
);
@@clientLocation(CommitmentPlanOperationGroup.listPlansBySubscription,
  CommitmentPlans
);

@@clientName(EncryptionScopes.createOrUpdate::parameters.resource,
  "encryptionScope"
);

@@clientName(RaiPolicies.createOrUpdate::parameters.resource, "raiPolicy");
@@clientName(SubscriptionRaiPolicy.createOrUpdate::parameters.resource,
  "raiPolicy"
);

@@clientName(RaiBlocklists.createOrUpdate::parameters.resource, "raiBlocklist");
@@clientLocation(RaiBlocklists.batchAdd, RaiBlocklistItems);
@@clientName(RaiBlocklists.batchAdd::parameters.body, "raiBlocklistItems");
@@clientLocation(RaiBlocklists.batchDelete, RaiBlocklistItems);
@@clientName(RaiBlocklists.batchDelete::parameters.body,
  "raiBlocklistItemsNames"
);

@@clientName(RaiBlocklistItems.createOrUpdate::parameters.resource,
  "raiBlocklistItem"
);

@@clientName(RaiTopics.createOrUpdate::parameters.resource, "raiTopic");

@@clientLocation(RaiExternalSafetyProviderSchemas.get,
  "RaiExternalSafetyProvider"
);
@@clientLocation(RaiExternalSafetyProviderSchemas.createOrUpdate,
  "RaiExternalSafetyProvider"
);
@@clientName(RaiExternalSafetyProviderSchemas.createOrUpdate::parameters.resource,
  "safetyProvider"
);
@@clientLocation(RaiExternalSafetyProviderSchemas.delete,
  "RaiExternalSafetyProvider"
);
@@clientLocation(RaiExternalSafetyProviderSchemas.list,
  "RaiExternalSafetyProviders"
);

@@clientName(RaiToolLabels.createOrUpdate::parameters.resource, "raiToolLabel");

@@clientLocation(CommitmentPlanAccountAssociations.getAssociation,
  CommitmentPlans
);
@@clientLocation(CommitmentPlanAccountAssociations.createOrUpdateAssociation,
  CommitmentPlans
);
@@clientName(CommitmentPlanAccountAssociations.createOrUpdateAssociation::parameters.resource,
  "association"
);
@@clientLocation(CommitmentPlanAccountAssociations.deleteAssociation,
  CommitmentPlans
);
@@clientLocation(CommitmentPlanAccountAssociations.listAssociations,
  CommitmentPlans
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CommitmentPlanAccountAssociation.properties
);

@@clientName(DefenderForAISettings.createOrUpdate::parameters.resource,
  "defenderForAISettings"
);
@@clientName(DefenderForAISettings.update::parameters.properties,
  "defenderForAISettings"
);
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DefenderForAISetting.properties
);

@@clientName(Projects.create::parameters.resource, "project");
@@clientName(Projects.update::parameters.properties, "project");

@@clientLocation(ConnectionPropertiesV2BasicResources.get,
  "AccountConnections"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.create,
  "AccountConnections"
);
@@clientName(ConnectionPropertiesV2BasicResources.create::parameters.resource,
  "connection"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.update,
  "AccountConnections"
);
@@clientName(ConnectionPropertiesV2BasicResources.update::parameters.properties,
  "connection"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.delete,
  "AccountConnections"
);
@@clientLocation(ConnectionPropertiesV2BasicResources.list,
  "AccountConnections"
);
@@clientName(ProjectConnections.create::parameters.resource, "connection");
@@clientName(ProjectConnections.update::parameters.properties, "connection");

@@clientLocation(CapabilityHosts.get, "AccountCapabilityHosts");
@@clientLocation(CapabilityHosts.createOrUpdate, "AccountCapabilityHosts");
@@clientName(CapabilityHosts.createOrUpdate::parameters.resource,
  "capabilityHost"
);
@@clientLocation(CapabilityHosts.delete, "AccountCapabilityHosts");
@@clientLocation(CapabilityHosts.list, "AccountCapabilityHosts");

@@clientName(ProjectCapabilityHosts.createOrUpdate::parameters.resource,
  "capabilityHost"
);

@@clientName(QuotaTiers.createOrUpdate::parameters.resource, "tier");
@@clientName(QuotaTiers.update::parameters.properties, "tier");

@@clientLocation(OutboundRuleBasicResources.get, "OutboundRule");
@@clientLocation(OutboundRuleBasicResources.createOrUpdate, "OutboundRule");
@@clientName(OutboundRuleBasicResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(OutboundRuleBasicResources.delete, "OutboundRule");
@@clientLocation(OutboundRuleBasicResources.list, "OutboundRule");

@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.get,
  "ManagedNetworkSettings"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.put,
  "ManagedNetworkSettings"
);
@@clientName(ManagedNetworkSettingsPropertiesBasicResources.put::parameters.resource,
  "body"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.patch,
  "ManagedNetworkSettings"
);
@@clientName(ManagedNetworkSettingsPropertiesBasicResources.patch::parameters.properties,
  "body"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.list,
  "ManagedNetworkSettings"
);
@@clientLocation(ManagedNetworkSettingsPropertiesBasicResources.post,
  "OutboundRules"
);

@@clientName(AgentApplications.createOrUpdate::parameters.resource, "body");

@@clientLocation(AgentDeploymentResources.get, "AgentDeployments");
@@clientLocation(AgentDeploymentResources.createOrUpdate, "AgentDeployments");
@@clientName(AgentDeploymentResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(AgentDeploymentResources.delete, "AgentDeployments");
@@clientLocation(AgentDeploymentResources.list, "AgentDeployments");
@@clientLocation(AgentDeploymentResources.start, "AgentDeployments");
@@clientLocation(AgentDeploymentResources.stop, "AgentDeployments");

@@clientLocation(DeletedAccountsOperationGroup.list, DeletedAccounts);

@@clientLocation(ResourceSkusOperationGroup.list, "ResourceSkus");

@@clientLocation(UsagesOperationGroup.list, "Usages");

@@clientName(calculateModelCapacity, "calculateModelCapacity");

@@clientLocation(CommitmentTiersOperationGroup.list, "CommitmentTiers");

@@clientLocation(ModelsOperationGroup.list, "Models");

@@clientLocation(LocationBasedModelCapacitiesOperationGroup.list,
  "LocationBasedModelCapacities"
);

@@clientLocation(ModelCapacitiesOperationGroup.list, "ModelCapacities");
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

@@clientName(AgentApplicationResource, "AgentApplication");
@@clientName(CapabilityHost, "CapabilityHostProperties");
@@clientName(CapabilityHostResource, "CapabilityHost");
@@clientName(ProjectCapabilityHostResource, "ProjectCapabilityHost");
@@clientName(ProjectCapabilityHost, "ProjectCapabilityHostProperties");

//@@clientName(AgentDeploymentResource, "AgentDeployment");
//@@clientName(AgentReferenceResource, "AgentReference");
