import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.MachineLearningServices;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  ClusterUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  RegistryPrivateEndpointConnection.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  SharedPrivateLinkResource.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  WorkspaceUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateLinkResource.properties
);

@@clientLocation(ComputeResources.get, "Compute");
@@clientLocation(ComputeResources.createOrUpdate, "Compute");
@@clientName(
  ComputeResources.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(ComputeResources.update, "Compute");
@@clientName(ComputeResources.update::parameters.properties, "parameters");
@@clientLocation(ComputeResources.delete, "Compute");
@@clientLocation(ComputeResources.list, "Compute");
@@clientLocation(ComputeResources.updateCustomServices, "Compute");
@@clientName(
  ComputeResources.updateCustomServices::parameters.body,
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
@@clientName(
  ComputeResources.updateIdleShutdownSetting::parameters.body,
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
@@clientName(
  CodeContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(CodeContainerOperationGroup.delete, CodeContainers);
@@clientLocation(CodeContainerOperationGroup.list, CodeContainers);

@@clientLocation(CodeVersions.get, "RegistryCodeVersions");
@@clientLocation(CodeVersions.createOrUpdate, "RegistryCodeVersions");
@@clientName(CodeVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(CodeVersions.delete, "RegistryCodeVersions");
@@clientLocation(CodeVersions.list, "RegistryCodeVersions");
@@clientLocation(
  CodeVersions.createOrGetStartPendingUpload,
  "RegistryCodeVersions"
);
@@clientLocation(CodeVersionOperationGroup.get, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.createOrUpdate, CodeVersions);
@@clientName(
  CodeVersionOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(CodeVersionOperationGroup.delete, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.list, CodeVersions);
@@clientLocation(CodeVersionOperationGroup.publish, CodeVersions);
@@clientLocation(
  CodeVersionOperationGroup.createOrGetStartPendingUpload,
  CodeVersions
);

@@clientLocation(ComponentContainers.get, "RegistryComponentContainers");
@@clientLocation(
  ComponentContainers.createOrUpdate,
  "RegistryComponentContainers"
);
@@clientName(ComponentContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(ComponentContainers.delete, "RegistryComponentContainers");
@@clientLocation(ComponentContainers.list, "RegistryComponentContainers");
@@clientLocation(ComponentContainerOperationGroup.get, ComponentContainers);
@@clientLocation(
  ComponentContainerOperationGroup.createOrUpdate,
  ComponentContainers
);
@@clientName(
  ComponentContainerOperationGroup.createOrUpdate::parameters.resource,
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
@@clientLocation(
  ComponentVersionOperationGroup.createOrUpdate,
  ComponentVersions
);
@@clientName(
  ComponentVersionOperationGroup.createOrUpdate::parameters.resource,
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
@@clientName(
  DataContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(DataContainerOperationGroup.delete, DataContainers);
@@clientLocation(DataContainerOperationGroup.list, DataContainers);

@@clientLocation(DataVersionBases.get, "RegistryDataVersions");
@@clientLocation(DataVersionBases.createOrUpdate, "RegistryDataVersions");
@@clientName(DataVersionBases.createOrUpdate::parameters.resource, "body");
@@clientLocation(DataVersionBases.delete, "RegistryDataVersions");
@@clientLocation(DataVersionBases.list, "RegistryDataVersions");
@@clientLocation(
  DataVersionBases.createOrGetStartPendingUpload,
  "RegistryDataVersions"
);
@@clientName(DataVersions.createOrUpdate::parameters.resource, "body");

@@clientLocation(EnvironmentContainers.get, "RegistryEnvironmentContainers");
@@clientLocation(
  EnvironmentContainers.createOrUpdate,
  "RegistryEnvironmentContainers"
);
@@clientName(EnvironmentContainers.createOrUpdate::parameters.resource, "body");
@@clientLocation(EnvironmentContainers.delete, "RegistryEnvironmentContainers");
@@clientLocation(EnvironmentContainers.list, "RegistryEnvironmentContainers");
@@clientLocation(EnvironmentContainerOperationGroup.get, EnvironmentContainers);
@@clientLocation(
  EnvironmentContainerOperationGroup.createOrUpdate,
  EnvironmentContainers
);
@@clientName(
  EnvironmentContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(
  EnvironmentContainerOperationGroup.delete,
  EnvironmentContainers
);
@@clientLocation(
  EnvironmentContainerOperationGroup.list,
  EnvironmentContainers
);

@@clientLocation(EnvironmentVersions.get, "RegistryEnvironmentVersions");
@@clientLocation(
  EnvironmentVersions.createOrUpdate,
  "RegistryEnvironmentVersions"
);
@@clientName(EnvironmentVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(EnvironmentVersions.delete, "RegistryEnvironmentVersions");
@@clientLocation(EnvironmentVersions.list, "RegistryEnvironmentVersions");
@@clientLocation(EnvironmentVersionOperationGroup.get, EnvironmentVersions);
@@clientLocation(
  EnvironmentVersionOperationGroup.createOrUpdate,
  EnvironmentVersions
);
@@clientName(
  EnvironmentVersionOperationGroup.createOrUpdate::parameters.resource,
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
@@clientName(
  ModelContainerOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(ModelContainerOperationGroup.delete, ModelContainers);
@@clientLocation(ModelContainerOperationGroup.list, ModelContainers);

@@clientLocation(ModelVersions.get, "RegistryModelVersions");
@@clientLocation(ModelVersions.createOrUpdate, "RegistryModelVersions");
@@clientName(ModelVersions.createOrUpdate::parameters.resource, "body");
@@clientLocation(ModelVersions.delete, "RegistryModelVersions");
@@clientLocation(ModelVersions.list, "RegistryModelVersions");
@@clientLocation(
  ModelVersions.createOrGetStartPendingUpload,
  "RegistryModelVersions"
);
@@clientLocation(ModelVersionOperationGroup.get, ModelVersions);
@@clientLocation(ModelVersionOperationGroup.createOrUpdate, ModelVersions);
@@clientName(
  ModelVersionOperationGroup.createOrUpdate::parameters.resource,
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

@@clientName(
  FeaturestoreEntityContainers.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(
  FeaturestoreEntityVersions.createOrUpdate::parameters.resource,
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

@@clientName(
  MarketplaceSubscriptions.createOrUpdate::parameters.resource,
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
@@clientName(Workspaces.list, "GetWorkspaceFeatures", "csharp");
@@clientLocation(Workspaces.getAllModels, "Connection");
@@clientLocation(Workspaces.getInWorkspace, EndpointDeployment);
@@clientLocation(Workspaces.privateLinkResourcesList, "PrivateLinkResources");
@@clientName(
  Workspaces.privateLinkResourcesList,
  "GetPrivateLinkResources",
  "csharp"
);
@@clientLocation(
  Workspaces.provisionManagedNetwork,
  "ManagedNetworkProvisions"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workspace.properties);

@@clientName(
  PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Required for backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  PrivateEndpointConnection.properties
);

@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.get,
  "WorkspaceConnections"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.create,
  "WorkspaceConnections"
);
@@clientName(
  WorkspaceConnectionPropertiesV2BasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.update,
  "WorkspaceConnections"
);
@@clientName(
  WorkspaceConnectionPropertiesV2BasicResources.update::parameters.properties,
  "body"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.delete,
  "WorkspaceConnections"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.list,
  "WorkspaceConnections"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.listSecrets,
  "WorkspaceConnections"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.testConnection,
  "WorkspaceConnections"
);
@@clientLocation(
  WorkspaceConnectionPropertiesV2BasicResources.getModels,
  "Connection"
);

@@clientLocation(
  EndpointDeploymentResourcePropertiesBasicResources.getDeployment,
  "Connection"
);
@@clientLocation(
  EndpointDeploymentResourcePropertiesBasicResources.createOrUpdateDeployment,
  "Connection"
);
@@clientName(
  EndpointDeploymentResourcePropertiesBasicResources.createOrUpdateDeployment::parameters.resource,
  "body"
);
@@clientLocation(
  EndpointDeploymentResourcePropertiesBasicResources.deleteDeployment,
  "Connection"
);
@@clientLocation(
  EndpointDeploymentResourcePropertiesBasicResources.listDeployments,
  "Connection"
);
@@clientName(EndpointDeployment.createOrUpdate::parameters.resource, "body");

@@clientLocation(
  RaiBlocklistPropertiesBasicResources.get,
  "ConnectionRaiBlocklist"
);
@@clientLocation(
  RaiBlocklistPropertiesBasicResources.create,
  "ConnectionRaiBlocklist"
);
@@clientName(
  RaiBlocklistPropertiesBasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(
  RaiBlocklistPropertiesBasicResources.delete,
  "ConnectionRaiBlocklist"
);
@@clientLocation(
  RaiBlocklistPropertiesBasicResources.list,
  "ConnectionRaiBlocklists"
);
@@clientLocation(
  RaiBlocklistPropertiesBasicResources.addBulk,
  "ConnectionRaiBlocklistItem"
);
@@clientLocation(
  RaiBlocklistPropertiesBasicResources.deleteBulk,
  "ConnectionRaiBlocklistItem"
);

@@clientLocation(
  RaiBlocklistItemPropertiesBasicResources.get,
  "ConnectionRaiBlocklistItem"
);
@@clientLocation(
  RaiBlocklistItemPropertiesBasicResources.create,
  "ConnectionRaiBlocklistItem"
);
@@clientName(
  RaiBlocklistItemPropertiesBasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(
  RaiBlocklistItemPropertiesBasicResources.delete,
  "ConnectionRaiBlocklistItem"
);
@@clientLocation(
  RaiBlocklistItemPropertiesBasicResources.list,
  "ConnectionRaiBlocklistItems"
);

@@clientLocation(RaiPolicyPropertiesBasicResources.get, "ConnectionRaiPolicy");
@@clientLocation(
  RaiPolicyPropertiesBasicResources.create,
  "ConnectionRaiPolicy"
);
@@clientName(
  RaiPolicyPropertiesBasicResources.create::parameters.resource,
  "body"
);
@@clientLocation(
  RaiPolicyPropertiesBasicResources.delete,
  "ConnectionRaiPolicy"
);
@@clientLocation(
  RaiPolicyPropertiesBasicResources.list,
  "ConnectionRaiPolicies"
);
@@clientName(RaiPolicy.create::parameters.resource, "body");
@@clientLocation(RaiPolicy.list, "RaiPolicies");

@@clientLocation(EndpointResourcePropertiesBasicResources.get, "Endpoint");
@@clientLocation(
  EndpointResourcePropertiesBasicResources.createOrUpdate,
  "Endpoint"
);
@@clientName(
  EndpointResourcePropertiesBasicResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(EndpointResourcePropertiesBasicResources.list, "Endpoint");
@@clientLocation(EndpointResourcePropertiesBasicResources.listKeys, "Endpoint");
@@clientLocation(
  EndpointResourcePropertiesBasicResources.getModels,
  "Endpoint"
);
@@clientLocation(
  EndpointResourcePropertiesBasicResources.regenerateKeys,
  "Endpoint"
);

@@clientLocation(OutboundRuleBasicResources.get, "ManagedNetworkSettingsRule");
@@clientLocation(
  OutboundRuleBasicResources.createOrUpdate,
  "ManagedNetworkSettingsRule"
);
@@clientName(
  OutboundRuleBasicResources.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(
  OutboundRuleBasicResources.delete,
  "ManagedNetworkSettingsRule"
);
@@clientLocation(OutboundRuleBasicResources.list, "ManagedNetworkSettingsRule");
@@clientLocation(OutboundRuleBasicResourceOperationGroup.get, "OutboundRule");
@@clientLocation(
  OutboundRuleBasicResourceOperationGroup.createOrUpdate,
  "OutboundRule"
);
@@clientName(
  OutboundRuleBasicResourceOperationGroup.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(
  OutboundRuleBasicResourceOperationGroup.delete,
  "OutboundRule"
);
@@clientLocation(OutboundRuleBasicResourceOperationGroup.list, "OutboundRule");

@@clientLocation(
  ManagedNetworkSettingsPropertiesBasicResources.get,
  "ManagedNetworkSettings"
);
@@clientLocation(
  ManagedNetworkSettingsPropertiesBasicResources.put,
  "ManagedNetworkSettings"
);
@@clientName(
  ManagedNetworkSettingsPropertiesBasicResources.put::parameters.resource,
  "body"
);
@@clientLocation(
  ManagedNetworkSettingsPropertiesBasicResources.patch,
  "ManagedNetworkSettings"
);
@@clientName(
  ManagedNetworkSettingsPropertiesBasicResources.patch::parameters.properties,
  "body"
);
@@clientLocation(
  ManagedNetworkSettingsPropertiesBasicResources.list,
  "ManagedNetworkSettings"
);
@@clientLocation(
  ManagedNetworkSettingsPropertiesBasicResources.post,
  "OutboundRules"
);

@@clientLocation(UsagesOperationGroup.list, "Usages");
@@clientName(UsagesOperationGroup.list, "GetMachineLearningUsages", "csharp");

@@clientLocation(VirtualMachineSizesOperationGroup.list, "VirtualMachineSizes");
@@clientName(
  VirtualMachineSizesOperationGroup.list,
  "GetMachineLearningVmSizes",
  "csharp"
);

@@clientLocation(QuotasOperationGroup.update, "Quotas");
@@clientLocation(QuotasOperationGroup.list, "Quotas");
@@clientName(QuotasOperationGroup.list, "GetMachineLearningQuotas", "csharp");

@@clientLocation(PTUQuotaOperationGroup.listAvailable, "PTUQuota");
@@clientLocation(PTUQuotaOperationGroup.getAvailable, "PTUQuota");
@@clientLocation(PTUQuotaOperationGroup.list, "PTUQuota");

@@clientName(QuotasOperationGroup.update::parameters.body, "parameters");
@@clientName(FqdnEndpointsPropertyBag, "FQDNEndpointsPropertyBag");
@@clientName(FqdnEndpoint, "MachineLearningFqdnEndpoint");
@@clientName(FqdnEndpointDetail, "MachineLearningFqdnEndpointDetail");
@@clientName(FqdnEndpoints, "MachineLearningFqdnEndpoints");

// Fix duplicate property names in C# - property and type have same name after PascalCase
@@clientName(
  ComputeInstanceProperties.setupScripts,
  "SetupScriptsSettings",
  "csharp"
);
@@clientName(
  SystemCreatedAcrAccount.armResourceId,
  "ArmResourceIdentifier",
  "csharp"
);
@@clientName(
  SystemCreatedStorageAccount.armResourceId,
  "ArmResourceIdentifier",
  "csharp"
);

// C# type renames to preserve backward compatibility with shipped API surface
@@clientName(AllocationState, "MachineLearningAllocationState", "csharp");
@@clientName(ConnectionCategory, "MachineLearningConnectionCategory", "csharp");
@@clientName(
  DatastoreCredentials,
  "MachineLearningDatastoreCredentials",
  "csharp"
);
@@clientName(
  EndpointProvisioningState,
  "MachineLearningEndpointProvisioningState",
  "csharp"
);
@@clientName(
  IdentityConfiguration,
  "MachineLearningIdentityConfiguration",
  "csharp"
);
@@clientName(JobInput, "MachineLearningJobInput", "csharp");
@@clientName(JobOutput, "MachineLearningJobOutput", "csharp");
@@clientName(
  JobResourceConfiguration,
  "MachineLearningJobResourceConfiguration",
  "csharp"
);
@@clientName(JobService, "MachineLearningJobService", "csharp");
@@clientName(JobStatus, "MachineLearningJobStatus", "csharp");
@@clientName(LogVerbosity, "MachineLearningLogVerbosity", "csharp");
@@clientName(NodeState, "MachineLearningNodeState", "csharp");
@@clientName(NodeStateCounts, "MachineLearningNodeStateCounts", "csharp");
@@clientName(OsType, "MachineLearningOSType", "csharp");
@@clientName(OutboundRule, "MachineLearningOutboundRule", "csharp");
@@clientName(
  RemoteLoginPortPublicAccess,
  "MachineLearningRemoteLoginPortPublicAccess",
  "csharp"
);
@@clientName(
  ServiceDataAccessAuthIdentity,
  "MachineLearningServiceDataAccessAuthIdentity",
  "csharp"
);
@@clientName(MLTableJobInput, "MachineLearningTableJobInput", "csharp");
@@clientName(UsageName, "MachineLearningUsageName", "csharp");
@@clientName(UsageUnit, "MachineLearningUsageUnit", "csharp");
@@clientName(
  UserAccountCredentials,
  "MachineLearningUserAccountCredentials",
  "csharp"
);
@@clientName(VmPriority, "MachineLearningVmPriority", "csharp");
@@clientName(ScaleSettings, "AmlComputeScaleSettings", "csharp");
@@clientName(
  ClassificationMultilabelPrimaryMetrics,
  "ClassificationMultilabelPrimaryMetric",
  "csharp"
);
@@clientName(
  ClassificationPrimaryMetrics,
  "ClassificationPrimaryMetric",
  "csharp"
);
@@clientName(Endpoint, "ContainerEndpoint", "csharp");
@@clientName(Collection, "DataCollectionConfiguration", "csharp");
@@clientName(ConnectionGroup, "WorkspaceConnectionGroup", "csharp");
@@clientName(RegressionModels, "AutoMLVerticalRegressionModel", "csharp");
@@clientName(BlockedTransformers, "BlockedTransformer", "csharp");
@@clientName(ClassificationModels, "ClassificationModel", "csharp");
@@clientName(ForecastingModels, "ForecastingModel", "csharp");
@@clientName(Nodes, "JobNodes", "csharp");
@@clientName(Webhook, "MachineLearningWebhook", "csharp");
@@clientName(AcrDetails, "RegistryAcrDetails", "csharp");

// Additional C# type renames to preserve backward compatibility with shipped API surface
@@clientName(BatchDeployment, "MachineLearningBatchDeployment", "csharp");
@@clientName(BatchEndpoint, "MachineLearningBatchEndpoint", "csharp");
@@clientName(CodeContainer, "MachineLearningCodeContainer", "csharp");
@@clientName(CodeVersion, "MachineLearningCodeVersion", "csharp");
@@clientName(ComponentContainer, "MachineLearningComponentContainer", "csharp");
@@clientName(ComponentVersion, "MachineLearningComponentVersion", "csharp");
@@clientName(Compute, "MachineLearningComputeProperties", "csharp");
@@clientName(DataContainer, "MachineLearningDataContainer", "csharp");
@@clientName(Datastore, "MachineLearningDatastore", "csharp");
@@clientName(
  EnvironmentContainer,
  "MachineLearningEnvironmentContainer",
  "csharp"
);
@@clientName(EnvironmentVersion, "MachineLearningEnvironmentVersion", "csharp");
@@clientName(Feature, "MachineLearningFeature", "csharp");
@@clientName(
  FeaturesetContainer,
  "MachineLearningFeatureSetContainer",
  "csharp"
);
@@clientName(FeaturesetVersion, "MachineLearningFeatureSetVersion", "csharp");
@@clientName(
  FeaturestoreEntityContainer,
  "MachineLearningFeatureStoreEntityContainer",
  "csharp"
);
@@clientName(
  FeaturestoreEntityVersion,
  "MachineLearningFeaturestoreEntityVersion",
  "csharp"
);
@@clientName(
  MarketplaceSubscription,
  "MachineLearningMarketplaceSubscription",
  "csharp"
);
@@clientName(ModelContainer, "MachineLearningModelContainer", "csharp");
@@clientName(ModelVersion, "MachineLearningModelVersion", "csharp");
@@clientName(OnlineDeployment, "MachineLearningOnlineDeployment", "csharp");
@@clientName(OnlineEndpoint, "MachineLearningOnlineEndpoint", "csharp");
@@clientName(
  PrivateEndpointConnection,
  "MachineLearningPrivateEndpointConnection",
  "csharp"
);
@@clientName(Registry, "MachineLearningRegistry", "csharp");
@@clientName(Schedule, "MachineLearningSchedule", "csharp");
@@clientName(ServerlessEndpoint, "MachineLearningServerlessEndpoint", "csharp");
@@clientName(Workspace, "MachineLearningWorkspace", "csharp");
@@clientName(
  AADAuthTypeWorkspaceConnectionProperties,
  "AadAuthTypeWorkspaceConnectionProperties",
  "csharp"
);
@@clientName(
  AccountKeyDatastoreCredentials,
  "MachineLearningAccountKeyDatastoreCredentials",
  "csharp"
);
@@clientName(
  AccountKeyDatastoreSecrets,
  "MachineLearningAccountKeyDatastoreSecrets",
  "csharp"
);
@@clientName(AksComputeSecrets, "MachineLearningAksComputeSecrets", "csharp");
@@clientName(
  AksNetworkingConfiguration,
  "MachineLearningAksNetworkingConfiguration",
  "csharp"
);
@@clientName(AllFeatures, "MachineLearningAllFeatures", "csharp");
@@clientName(AssetBase, "MachineLearningAssetBase", "csharp");
@@clientName(AssetContainer, "MachineLearningAssetContainer", "csharp");
@@clientName(
  AutoPauseProperties,
  "MachineLearningAutoPauseProperties",
  "csharp"
);
@@clientName(
  AutoScaleProperties,
  "MachineLearningAutoScaleProperties",
  "csharp"
);
@@clientName(AzureBlobDatastore, "MachineLearningAzureBlobDatastore", "csharp");
@@clientName(
  AzureDataLakeGen1Datastore,
  "MachineLearningAzureDataLakeGen1Datastore",
  "csharp"
);
@@clientName(
  AzureDataLakeGen2Datastore,
  "MachineLearningAzureDataLakeGen2Datastore",
  "csharp"
);
@@clientName(AzureFileDatastore, "MachineLearningAzureFileDatastore", "csharp");
@@clientName(
  BatchDeploymentProperties,
  "MachineLearningBatchDeploymentProperties",
  "csharp"
);
@@clientName(
  BatchEndpointProperties,
  "MachineLearningBatchEndpointProperties",
  "csharp"
);
@@clientName(BatchRetrySettings, "MachineLearningBatchRetrySettings", "csharp");
@@clientName(BuildContext, "MachineLearningBuildContext", "csharp");
@@clientName(
  CertificateDatastoreSecrets,
  "MachineLearningCertificateDatastoreSecrets",
  "csharp"
);
@@clientName(CodeConfiguration, "MachineLearningCodeConfiguration", "csharp");
@@clientName(
  CodeContainerProperties,
  "MachineLearningCodeContainerProperties",
  "csharp"
);
@@clientName(
  CodeVersionProperties,
  "MachineLearningCodeVersionProperties",
  "csharp"
);
@@clientName(CommandJob, "MachineLearningCommandJob", "csharp");
@@clientName(CommandJobLimits, "MachineLearningCommandJobLimits", "csharp");
@@clientName(
  ComponentContainerProperties,
  "MachineLearningComponentContainerProperties",
  "csharp"
);
@@clientName(
  ComponentVersionProperties,
  "MachineLearningComponentVersionProperties",
  "csharp"
);
@@clientName(ComputeInstance, "MachineLearningComputeInstance", "csharp");
@@clientName(
  ComputeInstanceApplication,
  "MachineLearningComputeInstanceApplication",
  "csharp"
);
@@clientName(
  ComputeInstanceConnectivityEndpoints,
  "MachineLearningComputeInstanceConnectivityEndpoints",
  "csharp"
);
@@clientName(
  ComputeInstanceContainer,
  "MachineLearningComputeInstanceContainer",
  "csharp"
);
@@clientName(
  ComputeInstanceCreatedBy,
  "MachineLearningComputeInstanceCreatedBy",
  "csharp"
);
@@clientName(
  ComputeInstanceDataDisk,
  "MachineLearningComputeInstanceDataDisk",
  "csharp"
);
@@clientName(
  ComputeInstanceDataMount,
  "MachineLearningComputeInstanceDataMount",
  "csharp"
);
@@clientName(
  ComputeInstanceEnvironmentInfo,
  "MachineLearningComputeInstanceEnvironmentInfo",
  "csharp"
);
@@clientName(
  ComputeInstanceLastOperation,
  "MachineLearningComputeInstanceLastOperation",
  "csharp"
);
@@clientName(
  ComputeInstanceProperties,
  "MachineLearningComputeInstanceProperties",
  "csharp"
);
@@clientName(
  ComputeInstanceSshSettings,
  "MachineLearningComputeInstanceSshSettings",
  "csharp"
);
@@clientName(
  ComputeRecurrenceSchedule,
  "MachineLearningComputeRecurrenceSchedule",
  "csharp"
);
@@clientName(
  ContainerResourceRequirements,
  "MachineLearningContainerResourceRequirements",
  "csharp"
);
@@clientName(
  ContainerResourceSettings,
  "MachineLearningContainerResourceSettings",
  "csharp"
);
@@clientName(
  CustomModelJobInput,
  "MachineLearningCustomModelJobInput",
  "csharp"
);
@@clientName(
  CustomModelJobOutput,
  "MachineLearningCustomModelJobOutput",
  "csharp"
);
@@clientName(
  DataContainerProperties,
  "MachineLearningDataContainerProperties",
  "csharp"
);
@@clientName(DataLakeAnalytics, "MachineLearningDataLakeAnalytics", "csharp");
@@clientName(
  DataPathAssetReference,
  "MachineLearningDataPathAssetReference",
  "csharp"
);
@@clientName(
  DatabricksComputeSecrets,
  "MachineLearningDatabricksComputeSecrets",
  "csharp"
);
@@clientName(
  DatabricksProperties,
  "MachineLearningDatabricksProperties",
  "csharp"
);
@@clientName(
  DefaultScaleSettings,
  "MachineLearningDefaultScaleSettings",
  "csharp"
);
@@clientName(DeploymentLogs, "MachineLearningDeploymentLogs", "csharp");
@@clientName(
  DeploymentResourceConfiguration,
  "MachineLearningDeploymentResourceConfiguration",
  "csharp"
);
@@clientName(DiagnoseResult, "MachineLearningDiagnoseResult", "csharp");
@@clientName(EndpointAuthKeys, "MachineLearningEndpointAuthKeys", "csharp");
@@clientName(EndpointAuthToken, "MachineLearningEndpointAuthToken", "csharp");
@@clientName(
  EndpointScheduleAction,
  "MachineLearningEndpointScheduleAction",
  "csharp"
);
@@clientName(
  EnvironmentContainerProperties,
  "MachineLearningEnvironmentContainerProperties",
  "csharp"
);
@@clientName(
  EnvironmentVersionProperties,
  "MachineLearningEnvironmentVersionProperties",
  "csharp"
);
@@clientName(EstimatedVMPrice, "MachineLearningEstimatedVmPrice", "csharp");
@@clientName(EstimatedVMPrices, "MachineLearningEstimatedVmPrices", "csharp");
@@clientName(FeatureProperties, "MachineLearningFeatureProperties", "csharp");
@@clientName(
  FeaturesetContainerProperties,
  "MachineLearningFeatureSetContainerProperties",
  "csharp"
);
@@clientName(
  FeaturesetVersionProperties,
  "MachineLearningFeatureSetVersionProperties",
  "csharp"
);
@@clientName(
  FeaturestoreEntityContainerProperties,
  "MachineLearningFeatureStoreEntityContainerProperties",
  "csharp"
);
@@clientName(
  FeaturestoreEntityVersionProperties,
  "MachineLearningFeatureStoreEntityVersionProperties",
  "csharp"
);
@@clientName(
  FeaturizationSettings,
  "MachineLearningFeaturizationSettings",
  "csharp"
);
@@clientName(FlavorData, "MachineLearningFlavorData", "csharp");
@@clientName(Forecasting, "MachineLearningForecasting", "csharp");
@@clientName(
  HDInsightProperties,
  "MachineLearningHDInsightProperties",
  "csharp"
);
@@clientName(IdAssetReference, "MachineLearningIdAssetReference", "csharp");
@@clientName(
  InferenceContainerProperties,
  "MachineLearningInferenceContainerProperties",
  "csharp"
);
@@clientName(InstanceTypeSchema, "MachineLearningInstanceTypeSchema", "csharp");
@@clientName(
  InstanceTypeSchemaResources,
  "MachineLearningInstanceTypeSchemaResources",
  "csharp"
);
@@clientName(JobScheduleAction, "MachineLearningJobScheduleAction", "csharp");
@@clientName(
  KubernetesOnlineDeployment,
  "MachineLearningKubernetesOnlineDeployment",
  "csharp"
);
@@clientName(
  KubernetesProperties,
  "MachineLearningKubernetesProperties",
  "csharp"
);
@@clientName(LiteralJobInput, "MachineLearningLiteralJobInput", "csharp");
@@clientName(ManagedIdentity, "MachineLearningManagedIdentity", "csharp");
@@clientName(
  ManagedOnlineDeployment,
  "MachineLearningManagedOnlineDeployment",
  "csharp"
);
@@clientName(MarketplacePlan, "MachineLearningMarketplacePlan", "csharp");
@@clientName(
  MarketplaceSubscriptionProperties,
  "MachineLearningMarketplaceSubscriptionProperties",
  "csharp"
);
@@clientName(
  ModelContainerProperties,
  "MachineLearningModelContainerProperties",
  "csharp"
);
@@clientName(
  ModelVersionProperties,
  "MachineLearningModelVersionProperties",
  "csharp"
);
@@clientName(
  NoneDatastoreCredentials,
  "MachineLearningNoneDatastoreCredentials",
  "csharp"
);
@@clientName(
  NotebookPreparationError,
  "MachineLearningNotebookPreparationError",
  "csharp"
);
@@clientName(
  NotebookResourceInfo,
  "MachineLearningNotebookResourceInfo",
  "csharp"
);
@@clientName(
  OnlineEndpointProperties,
  "MachineLearningOnlineEndpointProperties",
  "csharp"
);
@@clientName(
  OnlineRequestSettings,
  "MachineLearningOnlineRequestSettings",
  "csharp"
);
@@clientName(
  OutputPathAssetReference,
  "MachineLearningOutputPathAssetReference",
  "csharp"
);
@@clientName(PipelineJob, "MachineLearningPipelineJob", "csharp");
@@clientName(ProbeSettings, "MachineLearningProbeSettings", "csharp");
@@clientName(RecurrenceSchedule, "MachineLearningRecurrenceSchedule", "csharp");
@@clientName(RecurrenceTrigger, "MachineLearningRecurrenceTrigger", "csharp");
@@clientName(ResourceBase, "MachineLearningResourceBase", "csharp");
@@clientName(
  ResourceConfiguration,
  "MachineLearningResourceConfiguration",
  "csharp"
);
@@clientName(ResourceName, "MachineLearningResourceName", "csharp");
@@clientName(ResourceQuota, "MachineLearningResourceQuota", "csharp");
@@clientName(
  SasDatastoreCredentials,
  "MachineLearningSasDatastoreCredentials",
  "csharp"
);
@@clientName(
  SasDatastoreSecrets,
  "MachineLearningSasDatastoreSecrets",
  "csharp"
);
@@clientName(ScheduleBase, "MachineLearningScheduleBase", "csharp");
@@clientName(ScriptReference, "MachineLearningScriptReference", "csharp");
@@clientName(ScriptsToExecute, "MachineLearningScriptsToExecute", "csharp");
@@clientName(
  ServicePrincipalDatastoreSecrets,
  "MachineLearningServicePrincipalDatastoreSecrets",
  "csharp"
);
@@clientName(
  PrivateLinkResource,
  "MachineLearningPrivateLinkResource",
  "csharp"
);
@@clientName(
  SharedPrivateLinkResource,
  "MachineLearningSharedPrivateLinkResource",
  "csharp"
);
@@clientName(SkuCapacity, "MachineLearningSkuCapacity", "csharp");
@@clientName(SkuSetting, "MachineLearningSkuSetting", "csharp");
@@clientName(SslConfiguration, "MachineLearningSslConfiguration", "csharp");
@@clientName(
  StackEnsembleSettings,
  "MachineLearningStackEnsembleSettings",
  "csharp"
);
@@clientName(SweepJobLimits, "MachineLearningSweepJobLimits", "csharp");
@@clientName(SynapseSpark, "MachineLearningSynapseSpark", "csharp");
@@clientName(
  SynapseSparkProperties,
  "MachineLearningSynapseSparkProperties",
  "csharp"
);
@@clientName(
  TargetUtilizationScaleSettings,
  "MachineLearningTargetUtilizationScaleSettings",
  "csharp"
);
@@clientName(TrainingSettings, "MachineLearningTrainingSettings", "csharp");
@@clientName(TrialComponent, "MachineLearningTrialComponent", "csharp");
@@clientName(
  TritonModelJobInput,
  "MachineLearningTritonModelJobInput",
  "csharp"
);
@@clientName(
  TritonModelJobOutput,
  "MachineLearningTritonModelJobOutput",
  "csharp"
);
@@clientName(UriFileDataVersion, "MachineLearningUriFileDataVersion", "csharp");
@@clientName(UriFileJobInput, "MachineLearningUriFileJobInput", "csharp");
@@clientName(UriFileJobOutput, "MachineLearningUriFileJobOutput", "csharp");
@@clientName(
  UriFolderDataVersion,
  "MachineLearningUriFolderDataVersion",
  "csharp"
);
@@clientName(UriFolderJobInput, "MachineLearningUriFolderJobInput", "csharp");
@@clientName(UriFolderJobOutput, "MachineLearningUriFolderJobOutput", "csharp");
@@clientName(UserIdentity, "MachineLearningUserIdentity", "csharp");
@@clientName(
  VirtualMachineSecrets,
  "MachineLearningVirtualMachineSecrets",
  "csharp"
);
@@clientName(
  WorkspaceConnectionManagedIdentity,
  "MachineLearningWorkspaceConnectionManagedIdentity",
  "csharp"
);
@@clientName(
  WorkspaceConnectionUsernamePassword,
  "MachineLearningWorkspaceConnectionUsernamePassword",
  "csharp"
);
@@clientName(SASCredential, "SasCredential", "csharp");
@@clientName(SASCredentialDto, "SasCredentialDto", "csharp");
@@clientName(WorkspaceUpdateParameters, "WorkspacePatch", "csharp");
@@clientName(PublicNetworkAccessType, "PublicNetworkAccess", "csharp");
@@clientName(WeekDay, "MachineLearningDayOfWeek", "csharp");
@@clientName(ComputeWeekDay, "MachineLearningComputeWeekDay", "csharp");
@@clientName(ProvisioningState, "MachineLearningProvisioningState", "csharp");
@@clientName(QuotaUnit, "MachineLearningQuotaUnit", "csharp");

// Additional C# model renames to restore legacy public types.
@@clientName(Regression, "AutoMLVerticalRegression", "csharp");
@@clientName(
  RegressionPrimaryMetrics,
  "AutoMLVerticalRegressionPrimaryMetric",
  "csharp"
);
@@clientName(
  GetBlobReferenceSASRequestDto,
  "BlobReferenceSasContent",
  "csharp"
);
@@clientName(
  GetBlobReferenceSASResponseDto,
  "BlobReferenceSasResult",
  "csharp"
);
@@clientName(Classification, "ClassificationTask", "csharp");
@@clientName(Cron, "ComputeStartStopCronSchedule", "csharp");
@@clientName(Recurrence, "ComputeStartStopRecurrenceSchedule", "csharp");
@@clientName(Protocol, "ContainerCommunicationProtocol", "csharp");
@@clientName(DestinationAsset, "DestinationAssetContent", "csharp");
@@clientName(Docker, "DockerSetting", "csharp");
@@clientName(
  FeaturesetVersionBackfillRequest,
  "FeatureSetVersionBackfillContent",
  "csharp"
);
@@clientName(ForecastingPrimaryMetrics, "ForecastingPrimaryMetric", "csharp");
@@clientName(Seasonality, "ForecastingSeasonality", "csharp");
@@clientName(Image, "ImageSetting", "csharp");
@@clientName(
  InstanceSegmentationPrimaryMetrics,
  "InstanceSegmentationPrimaryMetric",
  "csharp"
);
@@clientName(AllNodes, "JobAllNodes", "csharp");
@@clientName(AKS, "MachineLearningAksCompute", "csharp");
@@clientName(AmlComputeProperties, "AmlComputeProperties", "csharp");
@@clientName(AmlComputeProperties.osType, "OSType", "csharp");
@@clientName(
  AmlComputeProperties.enableNodePublicIp,
  "EnableNodePublicIP",
  "csharp"
);
@@clientName(
  AKSSchemaProperties,
  "MachineLearningAksComputeProperties",
  "csharp"
);
@@clientName(
  ComputeInstanceProperties.enableNodePublicIp,
  "EnableNodePublicIP",
  "csharp"
);
@@clientName(
  ComputeInstanceProperties.osImageMetadata,
  "OSImageMetadata",
  "csharp"
);
@@clientName(EnvironmentVersionProperties.osType, "OSType", "csharp");
@@clientName(EstimatedVMPrice.osType, "OSType", "csharp");
@@clientName(
  VirtualMachineSize.estimatedVMPrices,
  "EstimatedVmPrices",
  "csharp"
);
@@clientName(Caching, "MachineLearningCachingType", "csharp");
@@access(EncryptionKeyVaultUpdateProperties, Access.public, "csharp");
@@access(TriggerType, Access.public, "csharp");
@@clientName(
  DataVersionBaseProperties,
  "MachineLearningDataVersionProperties",
  "csharp"
);
@@clientName(JobBaseProperties, "MachineLearningJobProperties", "csharp");
@@clientName(
  PartialMinimalTrackedResource,
  "MachineLearningResourcePatch",
  "csharp"
);
@@clientName(
  PartialMinimalTrackedResourceWithIdentity,
  "MachineLearningResourcePatchWithIdentity",
  "csharp"
);
@@clientName(
  PartialMinimalTrackedResourceWithSku,
  "MachineLearningOnlineDeploymentPatch",
  "csharp"
);
@@clientName(
  PartialMinimalTrackedResourceWithSkuAndIdentity,
  "MachineLearningServerlessEndpointPatch",
  "csharp"
);
@@clientName(PartialSku, "MachineLearningSkuPatch", "csharp");
@@clientName(Route, "MachineLearningInferenceContainerRoute", "csharp");
@@clientName(
  VirtualMachineSchemaProperties,
  "MachineLearningVirtualMachineProperties",
  "csharp"
);
@@alternateType(WorkspaceProperties.discoveryUrl, url, "csharp");
@@alternateType(
  WorkspaceProperties.hubResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(WorkspaceProperties.mlFlowTrackingUri, url, "csharp");
@@alternateType(WorkspaceProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(RegistryProperties.discoveryUrl, url, "csharp");
@@alternateType(RegistryProperties.mlFlowRegistryUri, url, "csharp");
@@alternateType(
  ArmResourceId.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AssetJobInput.uri, url, "csharp");
@@alternateType(AssetJobOutput.uri, url, "csharp");
@@alternateType(AssignedUser.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(
  AksNetworkingConfiguration.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  BlobReferenceForConsumptionDto.storageAccountArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(BuildContext.contextUri, url, "csharp");
@@alternateType(CertificateDatastoreCredentials.authorityUrl, url, "csharp");
@@alternateType(CertificateDatastoreCredentials.resourceUrl, url, "csharp");
@@alternateType(CodeVersionProperties.codeUri, url, "csharp");
@@alternateType(ComputeInstanceApplication.endpointUri, url, "csharp");
@@alternateType(
  CodeConfiguration.codeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DatabricksProperties.workspaceUrl, url, "csharp");
@@alternateType(DataVersionBaseProperties.dataUri, url, "csharp");
@@alternateType(HDInsightProperties.address, Azure.Core.ipV4Address, "csharp");
@@alternateType(
  IdAssetReference.assetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(CommandJob.codeId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  CommandJob.environmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(Compute.resourceId, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  JobBaseProperties.componentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  JobBaseProperties.computeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  KeyVaultProperties.keyVaultArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ManagedIdentity.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ModelVersionProperties.modelUri, url, "csharp");
@@alternateType(MonitoringInputDataBase.uri, url, "csharp");
@@alternateType(
  OutputPathAssetReference.jobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PipelineJob.sourceJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PrivateEndpointResource.subnetArmId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SharedPrivateLinkResourceProperty.privateLinkResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RegistryPrivateEndpointConnection.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RegistryPrivateEndpointConnection.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  RegistryRegionArmDetails.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(ResourceId.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(
  ServicePrincipalDatastoreCredentials.authorityUrl,
  url,
  "csharp"
);
@@alternateType(
  ServicePrincipalDatastoreCredentials.resourceUrl,
  url,
  "csharp"
);
@@alternateType(
  TrialComponent.codeId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TrialComponent.environmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VirtualMachineSchemaProperties.address,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(
  WorkspaceConnectionManagedIdentity.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(WorkspaceConnectionOAuth2.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(
  WorkspaceConnectionServicePrincipal.tenantId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(WorkspaceProperties.hbiWorkspace, "IsHbiWorkspace", "csharp");
@@clientName(
  WorkspaceProperties.storageHnsEnabled,
  "IsStorageHnsEnabled",
  "csharp"
);
@@clientName(WorkspaceProperties.v1LegacyMode, "IsV1LegacyMode", "csharp");
@@clientName(
  WorkspacePropertiesUpdateParameters.v1LegacyMode,
  "IsV1LegacyMode",
  "csharp"
);
@@clientName(
  WorkspacePropertiesUpdateParameters.publicNetworkAccess,
  "PublicNetworkAccessType",
  "csharp"
);
@@clientName(
  DeploymentLogsRequest,
  "MachineLearningDeploymentLogsContent",
  "csharp"
);
@@clientName(
  EndpointServiceConnectionStatus,
  "EndpointServiceConnectionStatus",
  "csharp"
);
@@clientName(
  ManagedNetworkProvisionOptions,
  "ManagedNetworkProvisionContent",
  "csharp"
);
@@clientName(VirtualMachineSize, "MachineLearningVmSize", "csharp");
@@clientName(
  AssignedUser,
  "MachineLearningComputeInstanceAssignedUser",
  "csharp"
);
@@clientName(Autosave, "MachineLearningComputeInstanceAutosave", "csharp");
@@clientName(ClusterUpdateParameters, "MachineLearningComputePatch", "csharp");
@@clientName(
  ProvisioningStatus,
  "MachineLearningComputeProvisioningStatus",
  "csharp"
);
@@clientName(SystemService, "MachineLearningComputeSystemService", "csharp");
@@clientName(DataFactory, "MachineLearningDataFactoryCompute", "csharp");
@@clientName(Databricks, "MachineLearningDatabricksCompute", "csharp");
@@clientName(
  DiagnoseResponseResultValue,
  "MachineLearningDiagnoseResultValue",
  "csharp"
);
@@clientName(
  EncryptionKeyVaultUpdateProperties,
  "EncryptionKeyVaultUpdateProperties",
  "csharp"
);
@@clientName(
  EndpointDeploymentPropertiesBase,
  "MachineLearningEndpointDeploymentProperties",
  "csharp"
);
@@clientName(
  RegenerateEndpointKeysRequest,
  "MachineLearningEndpointKeyRegenerateContent",
  "csharp"
);
@@clientName(
  EndpointPropertiesBase,
  "MachineLearningEndpointProperties",
  "csharp"
);
@@clientName(FeatureLags, "MachineLearningFeatureLag", "csharp");
@@clientName(MLFlowModelJobInput, "MachineLearningFlowModelJobInput", "csharp");
@@clientName(
  MLFlowModelJobOutput,
  "MachineLearningFlowModelJobOutput",
  "csharp"
);
@@clientName(HDInsight, "MachineLearningHDInsightCompute", "csharp");
@@clientName(Kubernetes, "MachineLearningKubernetesCompute", "csharp");
@@clientName(
  ManagedIdentityAuthTypeWorkspaceConnectionProperties,
  "MachineLearningManagedIdentityAuthTypeWorkspaceConnection",
  "csharp"
);
@@clientName(
  NoneAuthTypeWorkspaceConnectionProperties,
  "MachineLearningNoneAuthTypeWorkspaceConnection",
  "csharp"
);
@@clientName(
  PATAuthTypeWorkspaceConnectionProperties,
  "MachineLearningPatAuthTypeWorkspaceConnection",
  "csharp"
);
@@clientName(Password, "MachineLearningPasswordDetail", "csharp");
@@clientName(QuotaBaseProperties, "MachineLearningQuotaProperties", "csharp");
@@clientName(
  QuotaUpdateParameters,
  "MachineLearningQuotaUpdateContent",
  "csharp"
);
@@alternateType(
  QuotaUpdateParameters.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(
  SASAuthTypeWorkspaceConnectionProperties,
  "MachineLearningSasAuthTypeWorkspaceConnection",
  "csharp"
);
@@clientName(ScheduleActionBase, "MachineLearningScheduleAction", "csharp");
@@clientName(SkuResource, "MachineLearningSkuDetail", "csharp");
@@clientName(MLTableData, "MachineLearningTable", "csharp");
@@clientName(MLTableJobOutput, "MachineLearningTableJobOutput", "csharp");
@@clientName(AmlUserFeature, "MachineLearningUserFeature", "csharp");
@@clientName(
  UsernamePasswordAuthTypeWorkspaceConnectionProperties,
  "MachineLearningUsernamePasswordAuthTypeWorkspaceConnection",
  "csharp"
);
@@clientName(VirtualMachine, "MachineLearningVirtualMachineCompute", "csharp");
@@clientName(
  VirtualMachineSshCredentials,
  "MachineLearningVmSshCredentials",
  "csharp"
);
@@clientName(
  WorkspaceConnectionPropertiesV2,
  "MachineLearningWorkspaceConnectionProperties",
  "csharp"
);
@@clientName(
  DiagnoseWorkspaceParameters,
  "MachineLearningWorkspaceDiagnoseContent",
  "csharp"
);
@@clientName(
  DiagnoseRequestProperties,
  "MachineLearningWorkspaceDiagnoseProperties",
  "csharp"
);
@@clientName(
  DiagnoseResponseResult,
  "MachineLearningWorkspaceDiagnoseResult",
  "csharp"
);
@@clientName(
  ListWorkspaceKeysResult,
  "MachineLearningWorkspaceGetKeysResult",
  "csharp"
);
@@clientName(
  ListNotebookKeysResult,
  "MachineLearningWorkspaceGetNotebookKeysResult",
  "csharp"
);
@@clientName(
  ListStorageAccountKeysResult,
  "MachineLearningWorkspaceGetStorageAccountKeysResult",
  "csharp"
);
@@clientName(
  NotebookAccessTokenResult,
  "MachineLearningWorkspaceNotebookAccessTokenResult",
  "csharp"
);
@@clientName(Status, "MachineLearningWorkspaceQuotaStatus", "csharp");
@@clientName(
  UpdateWorkspaceQuotasResult,
  "MachineLearningWorkspaceQuotaStatusResult",
  "csharp"
);
@@clientName(
  UpdateWorkspaceQuotas,
  "MachineLearningWorkspaceQuotaUpdate",
  "csharp"
);
@@clientName(BindOptions, "MountBindOptions", "csharp");
@@clientName(Mpi, "MpiDistributionConfiguration", "csharp");
@@clientName(RuleAction, "NetworkingRuleAction", "csharp");
@@clientName(
  ObjectDetectionPrimaryMetrics,
  "ObjectDetectionPrimaryMetric",
  "csharp"
);
@@clientName(RuleCategory, "OutboundRuleCategory", "csharp");
@@clientName(RuleStatus, "OutboundRuleStatus", "csharp");
@@clientName(PrivateEndpointResource, "PrivateEndpointBase", "csharp");
@@clientName(PyTorch, "PyTorchDistributionConfiguration", "csharp");
@@clientName(TensorFlow, "TensorFlowDistributionConfiguration", "csharp");
@@clientName(
  AssetProvisioningState,
  "RegistryAssetProvisioningState",
  "csharp"
);
@@clientName(DataType, "MachineLearningDataType", "csharp");
@@clientName(EnvironmentType, "MachineLearningEnvironmentType", "csharp");
@@clientName(
  OperatingSystemType,
  "MachineLearningOperatingSystemType",
  "csharp"
);
@@clientName(EndpointAuthMode, "MachineLearningEndpointAuthMode", "csharp");
@@clientName(BatchLoggingLevel, "MachineLearningBatchLoggingLevel", "csharp");
@@clientName(AssetReferenceBase, "MachineLearningAssetReferenceBase", "csharp");
@@clientName(BatchOutputAction, "MachineLearningBatchOutputAction", "csharp");
@@clientName(
  DeploymentProvisioningState,
  "MachineLearningDeploymentProvisioningState",
  "csharp"
);
@@clientName(
  OnlineDeploymentProperties,
  "MachineLearningOnlineDeploymentProperties",
  "csharp"
);
@@clientName(SkuScaleType, "MachineLearningSkuScaleType", "csharp");
@@clientName(SourceType, "MachineLearningSourceType", "csharp");
@@clientName(MountAction, "MachineLearningMountAction", "csharp");
@@clientName(MountState, "MachineLearningMountState", "csharp");
@@clientName(
  DistributionConfiguration,
  "MachineLearningDistributionConfiguration",
  "csharp"
);
@@clientName(
  OnlineScaleSettings,
  "MachineLearningOnlineScaleSettings",
  "csharp"
);
@@clientName(
  EgressPublicNetworkAccessType,
  "MachineLearningEgressPublicNetworkAccessType",
  "csharp"
);
@@clientName(
  EncryptionKeyVaultUpdateProperties,
  "EncryptionKeyVaultUpdateProperties",
  "csharp"
);
@@clientName(
  ApplicationSharingPolicy,
  "MachineLearningApplicationSharingPolicy",
  "csharp"
);
@@clientName(BillingCurrency, "MachineLearningBillingCurrency", "csharp");
@@clientName(ClusterPurpose, "MachineLearningClusterPurpose", "csharp");
@@clientName(
  ComputeInstanceAuthorizationType,
  "MachineLearningComputeInstanceAuthorizationType",
  "csharp"
);
@@clientName(
  ComputeInstanceState,
  "MachineLearningComputeInstanceState",
  "csharp"
);
@@clientName(ComputePowerAction, "MachineLearningComputePowerAction", "csharp");
@@clientName(
  ComputeRecurrenceFrequency,
  "MachineLearningComputeRecurrenceFrequency",
  "csharp"
);
@@clientName(ComputeSecrets, "MachineLearningComputeSecrets", "csharp");
@@clientName(ContainerType, "MachineLearningContainerType", "csharp");
@@clientName(
  DatastoreProperties,
  "MachineLearningDatastoreProperties",
  "csharp"
);
@@clientName(DatastoreSecrets, "MachineLearningDatastoreSecrets", "csharp");
@@clientName(
  DiagnoseResultLevel,
  "MachineLearningDiagnoseResultLevel",
  "csharp"
);
@@clientName(
  EarlyTerminationPolicy,
  "MachineLearningEarlyTerminationPolicy",
  "csharp"
);
@@clientName(EncryptionStatus, "MachineLearningEncryptionStatus", "csharp");
@@clientName(
  EndpointComputeType,
  "MachineLearningEndpointComputeType",
  "csharp"
);
@@clientName(FeaturizationMode, "MachineLearningFeaturizationMode", "csharp");
@@clientName(Goal, "MachineLearningGoal", "csharp");
@@clientName(InputDeliveryMode, "MachineLearningInputDeliveryMode", "csharp");
@@clientName(JobLimits, "MachineLearningJobLimits", "csharp");
@@clientName(KeyType, "MachineLearningKeyType", "csharp");
@@clientName(ListViewType, "MachineLearningListViewType", "csharp");
@@clientName(LoadBalancerType, "MachineLearningLoadBalancerType", "csharp");
@@clientName(ModelSize, "MachineLearningModelSize", "csharp");
@@clientName(Network, "MachineLearningNetwork", "csharp");
@@clientName(OperationName, "MachineLearningOperationName", "csharp");
@@clientName(OperationStatus, "MachineLearningOperationStatus", "csharp");
@@clientName(OperationTrigger, "MachineLearningOperationTrigger", "csharp");
@@clientName(OrderString, "MachineLearningOrderString", "csharp");
@@clientName(
  OutboundRuleBasicResource,
  "MachineLearningOutboundRuleBasicResource",
  "csharp"
);
@@clientName(OutputDeliveryMode, "MachineLearningOutputDeliveryMode", "csharp");
@@clientName(
  RecurrenceFrequency,
  "MachineLearningRecurrenceFrequency",
  "csharp"
);
@@clientName(ScheduleProperties, "MachineLearningScheduleProperties", "csharp");
@@clientName(
  ScheduleListViewType,
  "MachineLearningScheduleListViewType",
  "csharp"
);
@@clientName(
  ScheduleProvisioningState,
  "MachineLearningScheduleProvisioningState",
  "csharp"
);
@@clientName(
  ScheduleProvisioningStatus,
  "MachineLearningScheduleProvisioningStatus",
  "csharp"
);
@@clientName(ScheduleStatus, "MachineLearningScheduleStatus", "csharp");
@@clientName(
  ShortSeriesHandlingConfiguration,
  "MachineLearningShortSeriesHandlingConfiguration",
  "csharp"
);
@@clientName(SshPublicAccess, "MachineLearningSshPublicAccess", "csharp");
@@clientName(SslConfigStatus, "MachineLearningSslConfigStatus", "csharp");
@@clientName(
  StackMetaLearnerType,
  "MachineLearningStackMetaLearnerType",
  "csharp"
);
@@clientName(StorageAccountType, "MachineLearningStorageAccountType", "csharp");
@@clientName(TriggerBase, "MachineLearningTriggerBase", "csharp");
@@clientName(TriggerType, "MachineLearningTriggerType", "csharp");
@@clientName(
  UnderlyingResourceAction,
  "MachineLearningUnderlyingResourceAction",
  "csharp"
);
@@clientName(UnitOfMeasure, "MachineLearningUnitOfMeasure", "csharp");
@@clientName(UseStl, "MachineLearningUseStl", "csharp");
@@clientName(VMPriceOSType, "MachineLearningVmPriceOSType", "csharp");
@@clientName(VMTier, "MachineLearningVmTier", "csharp");
