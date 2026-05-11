import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ClusterUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RegistryPrivateEndpointConnection.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SharedPrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(WorkspaceUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateLinkResource.properties
);

@@clientLocation(ComputeResources.get, "Compute");
@@clientLocation(ComputeResources.createOrUpdate, "Compute");
@@clientName(ComputeResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ComputeResources.update, "Compute");
@@clientName(ComputeResources.update::parameters.properties, "parameters");
@@clientLocation(ComputeResources.delete, "Compute");
@@clientLocation(ComputeResources.list, "Compute");
@@clientLocation(ComputeResources.updateCustomServices, "Compute");
@@clientName(ComputeResources.updateCustomServices::parameters.body,
  "customServices"
);
@@clientLocation(ComputeResources.listNodes, "Compute");
@@clientLocation(ComputeResources.listKeys, "Compute");
@@clientLocation(ComputeResources.updateDataMounts, "Compute");
@@clientName(ComputeResources.updateDataMounts::parameters.body, "dataMounts");
@@clientLocation(ComputeResources.start, "Compute");
@@clientLocation(ComputeResources.stop, "Compute");
@@clientLocation(ComputeResources.restart, "Compute");
@@clientLocation(ComputeResources.updateIdleShutdownSetting, "Compute");
@@clientName(ComputeResources.updateIdleShutdownSetting::parameters.body,
  "parameters"
);
@@clientLocation(ComputeResources.getAllowedResizeSizes, "Compute");
@@clientName(ComputeResources.getAllowedResizeSizes, "getAllowedResizeSizes");
@@clientLocation(ComputeResources.resize, "Compute");
@@clientName(ComputeResources.resize::parameters.body, "parameters");

@@clientLocation(CodeContainers.get, "RegistryCodeContainers");
@@clientLocation(CodeContainers.createOrUpdate, "RegistryCodeContainers");
@@clientName(CodeContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(CodeContainers.delete, "RegistryCodeContainers");
@@clientLocation(CodeContainers.list, "RegistryCodeContainers");
@@clientLocation(CodeContainerOperationGroup.get, CodeContainers);
@@clientLocation(CodeContainerOperationGroup.createOrUpdate, CodeContainers);
@@clientName(CodeContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(CodeContainerOperationGroup.delete, CodeContainers);
@@clientLocation(CodeContainerOperationGroup.list, CodeContainers);

@@clientLocation(CodeVersions.get, "RegistryCodeVersions");
@@clientLocation(CodeVersions.createOrUpdate, "RegistryCodeVersions");
@@clientName(CodeVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(CodeVersions.delete, "RegistryCodeVersions");
@@clientLocation(CodeVersions.list, "RegistryCodeVersions");
@@clientLocation(CodeVersions.createOrGetStartPendingUpload,
  "RegistryCodeVersions"
);
@@clientLocation(CodeVersionOperationGroup.get, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.createOrUpdate, CodeVersions);
@@clientName(CodeVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(CodeVersionOperationGroup.delete, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.list, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.publish, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.createOrGetStartPendingUpload,
  CodeVersions
);

@@clientLocation(ComponentContainers.get, "RegistryComponentContainers");
@@clientLocation(ComponentContainers.createOrUpdate,
  "RegistryComponentContainers"
);
@@clientName(ComponentContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(ComponentContainers.delete, "RegistryComponentContainers");
@@clientLocation(ComponentContainers.list, "RegistryComponentContainers");
@@clientLocation(ComponentContainerOperationGroup.get, ComponentContainers);
@@clientLocation(ComponentContainerOperationGroup.createOrUpdate,
  ComponentContainers
);
@@clientName(ComponentContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ComponentContainerOperationGroup.delete, ComponentContainers);
@@clientLocation(ComponentContainerOperationGroup.list, ComponentContainers);

@@clientLocation(ComponentVersions.get, "RegistryComponentVersions");
@@clientLocation(ComponentVersions.createOrUpdate, "RegistryComponentVersions");
@@clientName(ComponentVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(ComponentVersions.delete, "RegistryComponentVersions");
@@clientLocation(ComponentVersions.list, "RegistryComponentVersions");
@@clientLocation(ComponentVersionOperationGroup.get, ComponentVersions);
@@clientLocation(ComponentVersionOperationGroup.createOrUpdate,
  ComponentVersions
);
@@clientName(ComponentVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ComponentVersionOperationGroup.delete, ComponentVersions);
@@clientLocation(ComponentVersionOperationGroup.list, ComponentVersions);
@@clientLocation(ComponentVersionOperationGroup.publish, ComponentVersions);

@@clientLocation(DataContainers.get, "RegistryDataContainers");
@@clientLocation(DataContainers.createOrUpdate, "RegistryDataContainers");
@@clientName(DataContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(DataContainers.delete, "RegistryDataContainers");
@@clientLocation(DataContainers.list, "RegistryDataContainers");
@@clientLocation(DataContainerOperationGroup.get, DataContainers);
@@clientLocation(DataContainerOperationGroup.createOrUpdate, DataContainers);
@@clientName(DataContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(DataContainerOperationGroup.delete, DataContainers);
@@clientLocation(DataContainerOperationGroup.list, DataContainers);

@@clientLocation(DataVersionBases.get, "RegistryDataVersions");
@@clientLocation(DataVersionBases.createOrUpdate, "RegistryDataVersions");
@@clientName(DataVersionBases.createOrUpdate::parameters.resource, "body");
@@clientLocation(DataVersionBases.delete, "RegistryDataVersions");
@@clientLocation(DataVersionBases.list, "RegistryDataVersions");
@@clientLocation(DataVersionBases.createOrGetStartPendingUpload,
  "RegistryDataVersions"
);
@@clientName(DataVersions.createOrUpdate::parameters.resource, "body");

@@clientLocation(EnvironmentContainers.get, "RegistryEnvironmentContainers");
@@clientLocation(EnvironmentContainers.createOrUpdate,
  "RegistryEnvironmentContainers"
);
@@clientName(EnvironmentContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(EnvironmentContainers.delete, "RegistryEnvironmentContainers");
@@clientLocation(EnvironmentContainers.list, "RegistryEnvironmentContainers");
@@clientLocation(EnvironmentContainerOperationGroup.get, EnvironmentContainers);
@@clientLocation(EnvironmentContainerOperationGroup.createOrUpdate,
  EnvironmentContainers
);
@@clientName(EnvironmentContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(EnvironmentContainerOperationGroup.delete,
  EnvironmentContainers
);
@@clientLocation(EnvironmentContainerOperationGroup.list,
  EnvironmentContainers
);

@@clientLocation(EnvironmentVersions.get, "RegistryEnvironmentVersions");
@@clientLocation(EnvironmentVersions.createOrUpdate,
  "RegistryEnvironmentVersions"
);
@@clientName(EnvironmentVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(EnvironmentVersions.delete, "RegistryEnvironmentVersions");
@@clientLocation(EnvironmentVersions.list, "RegistryEnvironmentVersions");
@@clientLocation(EnvironmentVersionOperationGroup.get, EnvironmentVersions);
@@clientLocation(EnvironmentVersionOperationGroup.createOrUpdate,
  EnvironmentVersions
);
@@clientName(EnvironmentVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(EnvironmentVersionOperationGroup.delete, EnvironmentVersions);
@@clientLocation(EnvironmentVersionOperationGroup.list, EnvironmentVersions);
@@clientLocation(EnvironmentVersionOperationGroup.publish, EnvironmentVersions);

@@clientLocation(ModelContainers.get, "RegistryModelContainers");
@@clientLocation(ModelContainers.createOrUpdate, "RegistryModelContainers");
@@clientName(ModelContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(ModelContainers.delete, "RegistryModelContainers");
@@clientLocation(ModelContainers.list, "RegistryModelContainers");
@@clientLocation(ModelContainerOperationGroup.get, ModelContainers);
@@clientLocation(ModelContainerOperationGroup.createOrUpdate, ModelContainers);
@@clientName(ModelContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ModelContainerOperationGroup.delete, ModelContainers);
@@clientLocation(ModelContainerOperationGroup.list, ModelContainers);

@@clientLocation(ModelVersions.get, "RegistryModelVersions");
@@clientLocation(ModelVersions.createOrUpdate, "RegistryModelVersions");
@@clientName(ModelVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(ModelVersions.delete, "RegistryModelVersions");
@@clientLocation(ModelVersions.list, "RegistryModelVersions");
@@clientLocation(ModelVersions.createOrGetStartPendingUpload,
  "RegistryModelVersions"
);
@@clientLocation(ModelVersionOperationGroup.get, ModelVersions);
@@clientLocation(ModelVersionOperationGroup.createOrUpdate, ModelVersions);
@@clientName(ModelVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ModelVersionOperationGroup.delete, ModelVersions);
@@clientLocation(ModelVersionOperationGroup.list, ModelVersions);
@@clientLocation(ModelVersionOperationGroup.publish, ModelVersions);

@@clientName(BatchEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(BatchEndpoints.update::parameters.properties, "body");

@@clientName(BatchDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(BatchDeployments.update::parameters.properties, "body");

@@clientName(CapabilityHosts.createOrUpdate::parameters.resource, "body");

@@clientName(Datastores.createOrUpdate::parameters.resource, "body");

@@clientName(FeaturesetContainers.createOrUpdate::parameters.resource, "body");

@@clientName(FeaturesetVersions.createOrUpdate::parameters.resource, "body");

@@clientName(FeaturestoreEntityContainers.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(FeaturestoreEntityVersions.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(InferencePools.createOrUpdate::parameters.resource, "body");
@@clientName(InferencePools.update::parameters.properties, "body");

@@clientName(InferenceEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(InferenceEndpoints.update::parameters.properties, "body");

@@clientName(InferenceGroups.createOrUpdate::parameters.resource, "body");
@@clientName(InferenceGroups.update::parameters.properties, "body");

@@clientLocation(JobBases.get, "Jobs");
@@clientLocation(JobBases.createOrUpdate, "Jobs");
@@clientName(JobBases.createOrUpdate::parameters.resource, "body");
@@clientLocation(JobBases.delete, "Jobs");
@@clientLocation(JobBases.list, "Jobs");
@@clientLocation(JobBases.cancel, "Jobs");

@@clientName(MarketplaceSubscriptions.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(OnlineEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(OnlineEndpoints.update::parameters.properties, "body");

@@clientName(OnlineDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(OnlineDeployments.update::parameters.properties, "body");

@@clientName(Schedules.createOrUpdate::parameters.resource, "body");

@@clientName(ServerlessEndpoints.createOrUpdate::parameters.resource, "body");
@@clientName(ServerlessEndpoints.update::parameters.properties, "body");

@@clientName(Registries.createOrUpdate::parameters.resource, "body");
@@clientName(Registries.update::parameters.properties, "body");
@@clientLocation(Registries.getBlobReferenceSAS, "RegistryDataReferences");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Registry.properties);

@@clientName(Workspaces.createOrUpdate::parameters.resource, "body");
@@clientName(Workspaces.update::parameters.properties, "body");
@@clientLocation(Workspaces.list, "WorkspaceFeatures");
@@clientLocation(Workspaces.getAllModels, "Connection");
@@clientLocation(Workspaces.getInWorkspace, EndpointDeployment);
@@clientLocation(Workspaces.privateLinkResourcesList, "PrivateLinkResources");
@@clientName(Workspaces.privateLinkResourcesList, "List");
@@clientLocation(Workspaces.provisionManagedNetwork,
  "ManagedNetworkProvisions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workspace.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.get,
  "WorkspaceConnections"
);
@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.create,
  "WorkspaceConnections"
);
@@clientName(WorkspaceConnectionPropertiesV2BasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.update,
  "WorkspaceConnections"
);
@@clientName(WorkspaceConnectionPropertiesV2BasicResources.update::parameters.properties,
  "body"
);
@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.delete,
  "WorkspaceConnections"
);
@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.list,
  "WorkspaceConnections"
);
@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.listSecrets,
  "WorkspaceConnections"
);
@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.testConnection,
  "WorkspaceConnections"
);
@@clientLocation(WorkspaceConnectionPropertiesV2BasicResources.getModels,
  "Connection"
);

@@clientLocation(EndpointDeploymentResourcePropertiesBasicResources.getDeployment,
  "Connection"
);
@@clientLocation(EndpointDeploymentResourcePropertiesBasicResources.createOrUpdateDeployment,
  "Connection"
);
@@clientName(EndpointDeploymentResourcePropertiesBasicResources.createOrUpdateDeployment::parameters.resource,
  "body"
);
@@clientLocation(EndpointDeploymentResourcePropertiesBasicResources.deleteDeployment,
  "Connection"
);
@@clientLocation(EndpointDeploymentResourcePropertiesBasicResources.listDeployments,
  "Connection"
);
@@clientName(EndpointDeployment.createOrUpdate::parameters.resource, "body");

@@clientLocation(RaiBlocklistPropertiesBasicResources.get,
  "ConnectionRaiBlocklist"
);
@@clientLocation(RaiBlocklistPropertiesBasicResources.create,
  "ConnectionRaiBlocklist"
);
@@clientName(RaiBlocklistPropertiesBasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(RaiBlocklistPropertiesBasicResources.delete,
  "ConnectionRaiBlocklist"
);
@@clientLocation(RaiBlocklistPropertiesBasicResources.list,
  "ConnectionRaiBlocklists"
);
@@clientLocation(RaiBlocklistPropertiesBasicResources.addBulk,
  "ConnectionRaiBlocklistItem"
);
@@clientLocation(RaiBlocklistPropertiesBasicResources.deleteBulk,
  "ConnectionRaiBlocklistItem"
);

@@clientLocation(RaiBlocklistItemPropertiesBasicResources.get,
  "ConnectionRaiBlocklistItem"
);
@@clientLocation(RaiBlocklistItemPropertiesBasicResources.create,
  "ConnectionRaiBlocklistItem"
);
@@clientName(RaiBlocklistItemPropertiesBasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(RaiBlocklistItemPropertiesBasicResources.delete,
  "ConnectionRaiBlocklistItem"
);
@@clientLocation(RaiBlocklistItemPropertiesBasicResources.list,
  "ConnectionRaiBlocklistItems"
);

@@clientLocation(RaiPolicyPropertiesBasicResources.get, "ConnectionRaiPolicy");
@@clientLocation(RaiPolicyPropertiesBasicResources.create,
  "ConnectionRaiPolicy"
);
@@clientName(RaiPolicyPropertiesBasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(RaiPolicyPropertiesBasicResources.delete,
  "ConnectionRaiPolicy"
);
@@clientLocation(RaiPolicyPropertiesBasicResources.list,
  "ConnectionRaiPolicies"
);
@@clientName(RaiPolicy.create::parameters.resource, "body");
@@clientLocation(RaiPolicy.list, "RaiPolicies");

@@clientLocation(EndpointResourcePropertiesBasicResources.get, "Endpoint");
@@clientLocation(EndpointResourcePropertiesBasicResources.createOrUpdate,
  "Endpoint"
);
@@clientName(EndpointResourcePropertiesBasicResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(EndpointResourcePropertiesBasicResources.list, "Endpoint");
@@clientLocation(EndpointResourcePropertiesBasicResources.listKeys, "Endpoint");
@@clientLocation(EndpointResourcePropertiesBasicResources.getModels,
  "Endpoint"
);
@@clientLocation(EndpointResourcePropertiesBasicResources.regenerateKeys,
  "Endpoint"
);

@@clientLocation(OutboundRuleBasicResources.get, "ManagedNetworkSettingsRule");
@@clientLocation(OutboundRuleBasicResources.createOrUpdate,
  "ManagedNetworkSettingsRule"
);
@@clientName(OutboundRuleBasicResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(OutboundRuleBasicResources.delete,
  "ManagedNetworkSettingsRule"
);
@@clientLocation(OutboundRuleBasicResources.list, "ManagedNetworkSettingsRule");
@@clientLocation(OutboundRuleBasicResourceOperationGroup.get, "OutboundRule");
@@clientLocation(OutboundRuleBasicResourceOperationGroup.createOrUpdate,
  "OutboundRule"
);
@@clientName(OutboundRuleBasicResourceOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(OutboundRuleBasicResourceOperationGroup.delete,
  "OutboundRule"
);
@@clientLocation(OutboundRuleBasicResourceOperationGroup.list, "OutboundRule");

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

@@clientLocation(UsagesOperationGroup.list, "Usages");

@@clientLocation(VirtualMachineSizesOperationGroup.list, "VirtualMachineSizes");

@@clientLocation(QuotasOperationGroup.update, "Quotas");
@@clientLocation(QuotasOperationGroup.list, "Quotas");

@@clientLocation(PTUQuotaOperationGroup.listAvailable, "PTUQuota");
@@clientLocation(PTUQuotaOperationGroup.getAvailable, "PTUQuota");
@@clientLocation(PTUQuotaOperationGroup.list, "PTUQuota");

@@clientName(QuotasOperationGroup.update::parameters.body, "parameters");
@@clientName(FqdnEndpointsPropertyBag, "FQDNEndpointsPropertyBag");
@@clientName(FqdnEndpoint, "FQDNEndpoint");
@@clientName(FqdnEndpointDetail, "FQDNEndpointDetail");
@@clientName(FqdnEndpoints, "FQDNEndpoints");
