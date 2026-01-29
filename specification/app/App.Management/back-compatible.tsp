import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.App;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HttpRetryPolicy.retryBackOff);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HttpRetryPolicy.matches);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(HeaderMatch.match);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BuilderResourceUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EnvironmentAuthToken.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientLocation(AppResiliencies.get, "AppResiliency");
@@clientLocation(AppResiliencies.createOrUpdate, "AppResiliency");
@@clientName(AppResiliencies.createOrUpdate::parameters.resource,
  "resiliencyEnvelope"
);
@@clientLocation(AppResiliencies.update, "AppResiliency");
@@clientName(AppResiliencies.update::parameters.properties,
  "resiliencyEnvelope"
);
@@clientLocation(AppResiliencies.delete, "AppResiliency");
@@clientLocation(AppResiliencies.list, "AppResiliency");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AppResiliency.properties);

@@clientLocation(AuthConfigs.get, "ContainerAppsAuthConfigs");
@@clientLocation(AuthConfigs.createOrUpdate, "ContainerAppsAuthConfigs");
@@clientName(AuthConfigs.createOrUpdate::parameters.resource,
  "authConfigEnvelope"
);
@@clientLocation(AuthConfigs.delete, "ContainerAppsAuthConfigs");
@@clientLocation(AuthConfigs.listByContainerApp, "ContainerAppsAuthConfigs");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AuthConfig.properties);

@@clientLocation(BuilderResources.get, "Builders");
@@clientLocation(BuilderResources.createOrUpdate, "Builders");
@@clientName(BuilderResources.createOrUpdate::parameters.resource,
  "builderEnvelope"
);
@@clientLocation(BuilderResources.update, "Builders");
@@clientName(BuilderResources.update::parameters.properties, "builderEnvelope");
@@clientLocation(BuilderResources.delete, "Builders");
@@clientLocation(BuilderResources.listByResourceGroup, "Builders");
@@clientLocation(BuilderResources.listBySubscription, "Builders");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BuilderResource.properties);

@@clientLocation(BuildResources.get, "Builds");
@@clientLocation(BuildResources.createOrUpdate, "Builds");
@@clientName(BuildResources.createOrUpdate::parameters.resource,
  "buildEnvelope"
);
@@clientLocation(BuildResources.delete, "Builds");
@@clientLocation(BuildResources.list, "BuildsByBuilderResource");
@@clientLocation(BuildResources.buildAuthTokenList, "BuildAuthToken");
@@clientName(BuildResources.buildAuthTokenList, "List");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BuildResource.properties);

@@clientName(ConnectedEnvironments.createOrUpdate::parameters.resource,
  "environmentEnvelope"
);
@@clientName(ConnectedEnvironments.update::parameters.properties,
  "environmentEnvelope"
);
@@clientName(ConnectedEnvironments.checkNameAvailability::parameters.body,
  "checkNameAvailabilityRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ConnectedEnvironment.properties);

@@clientLocation(Certificates.get, "ConnectedEnvironmentsCertificates");
@@clientLocation(Certificates.createOrUpdate,
  "ConnectedEnvironmentsCertificates"
);
@@clientName(Certificates.createOrUpdate::parameters.resource,
  "certificateEnvelope"
);
@@clientLocation(Certificates.update, "ConnectedEnvironmentsCertificates");
@@clientName(Certificates.update::parameters.properties, "certificateEnvelope");
@@clientLocation(Certificates.delete, "ConnectedEnvironmentsCertificates");
@@clientLocation(Certificates.list, "ConnectedEnvironmentsCertificates");
@@clientLocation(CertificateOperationGroup.get, Certificates);
@@clientLocation(CertificateOperationGroup.createOrUpdate, Certificates);
@@clientName(CertificateOperationGroup.createOrUpdate::parameters.resource,
  "certificateEnvelope"
);
@@clientLocation(CertificateOperationGroup.update, Certificates);
@@clientName(CertificateOperationGroup.update::parameters.properties,
  "certificateEnvelope"
);
@@clientLocation(CertificateOperationGroup.delete, Certificates);
@@clientLocation(CertificateOperationGroup.list, Certificates);

@@clientLocation(DaprComponents.get, "ConnectedEnvironmentsDaprComponents");
@@clientLocation(DaprComponents.createOrUpdate,
  "ConnectedEnvironmentsDaprComponents"
);
@@clientName(DaprComponents.createOrUpdate::parameters.resource,
  "daprComponentEnvelope"
);
@@clientLocation(DaprComponents.delete, "ConnectedEnvironmentsDaprComponents");
@@clientLocation(DaprComponents.list, "ConnectedEnvironmentsDaprComponents");
@@clientLocation(DaprComponents.listSecrets,
  "ConnectedEnvironmentsDaprComponents"
);
@@clientLocation(DaprComponentOperationGroup.get, DaprComponents);
@@clientLocation(DaprComponentOperationGroup.createOrUpdate, DaprComponents);
@@clientName(DaprComponentOperationGroup.createOrUpdate::parameters.resource,
  "daprComponentEnvelope"
);
@@clientLocation(DaprComponentOperationGroup.delete, DaprComponents);
@@clientLocation(DaprComponentOperationGroup.list, DaprComponents);
@@clientLocation(DaprComponentOperationGroup.listSecrets, DaprComponents);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DaprComponent.properties);

@@clientLocation(ConnectedEnvironmentStorages.get,
  "ConnectedEnvironmentsStorages"
);
@@clientLocation(ConnectedEnvironmentStorages.createOrUpdate,
  "ConnectedEnvironmentsStorages"
);
@@clientName(ConnectedEnvironmentStorages.createOrUpdate::parameters.resource,
  "storageEnvelope"
);
@@clientLocation(ConnectedEnvironmentStorages.delete,
  "ConnectedEnvironmentsStorages"
);
@@clientLocation(ConnectedEnvironmentStorages.list,
  "ConnectedEnvironmentsStorages"
);

@@clientName(ManagedEnvironments.createOrUpdate::parameters.resource,
  "environmentEnvelope"
);
@@clientName(ManagedEnvironments.update::parameters.properties,
  "environmentEnvelope"
);
@@clientLocation(ManagedEnvironments.checkNameAvailability, "Namespaces");
@@clientName(ManagedEnvironments.checkNameAvailability::parameters.body,
  "checkNameAvailabilityRequest"
);
@@clientLocation(ManagedEnvironments.list,
  "ManagedEnvironmentPrivateLinkResources"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ManagedEnvironment.properties);

@@clientLocation(PrivateEndpointConnections.get,
  "ManagedEnvironmentPrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.createOrUpdate,
  "ManagedEnvironmentPrivateEndpointConnections"
);
@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnectionEnvelope"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "ManagedEnvironmentPrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.list,
  "ManagedEnvironmentPrivateEndpointConnections"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ManagedCertificates.createOrUpdate::parameters.resource,
  "managedCertificateEnvelope"
);
@@clientName(ManagedCertificates.update::parameters.properties,
  "managedCertificateEnvelope"
);

@@clientName(DaprComponentResiliencyPolicies.createOrUpdate::parameters.resource,
  "daprComponentResiliencyPolicyEnvelope"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DaprComponentResiliencyPolicy.properties);

@@clientName(DaprSubscriptions.createOrUpdate::parameters.resource,
  "daprSubscriptionEnvelope"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DaprSubscription.properties);

@@clientLocation(HttpRouteConfigs.get, "HttpRouteConfig");
@@clientLocation(HttpRouteConfigs.createOrUpdate, "HttpRouteConfig");
@@clientName(HttpRouteConfigs.createOrUpdate::parameters.resource,
  "httpRouteConfigEnvelope"
);
@@clientLocation(HttpRouteConfigs.update, "HttpRouteConfig");
@@clientName(HttpRouteConfigs.update::parameters.properties,
  "httpRouteConfigEnvelope"
);
@@clientLocation(HttpRouteConfigs.delete, "HttpRouteConfig");
@@clientLocation(HttpRouteConfigs.list, "HttpRouteConfig");

@@clientLocation(MaintenanceConfigurationResources.get,
  "MaintenanceConfigurations"
);
@@clientLocation(MaintenanceConfigurationResources.createOrUpdate,
  "MaintenanceConfigurations"
);
@@clientName(MaintenanceConfigurationResources.createOrUpdate::parameters.resource,
  "maintenanceConfigurationEnvelope"
);
@@clientLocation(MaintenanceConfigurationResources.delete,
  "MaintenanceConfigurations"
);
@@clientLocation(MaintenanceConfigurationResources.list,
  "MaintenanceConfigurations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MaintenanceConfigurationResource.properties);

@@clientLocation(ManagedEnvironmentStorages.get, "ManagedEnvironmentsStorages");
@@clientLocation(ManagedEnvironmentStorages.createOrUpdate,
  "ManagedEnvironmentsStorages"
);
@@clientName(ManagedEnvironmentStorages.createOrUpdate::parameters.resource,
  "storageEnvelope"
);
@@clientLocation(ManagedEnvironmentStorages.delete,
  "ManagedEnvironmentsStorages"
);
@@clientLocation(ManagedEnvironmentStorages.list,
  "ManagedEnvironmentsStorages"
);

@@clientName(Jobs.createOrUpdate::parameters.resource, "JobEnvelope");
@@clientName(Jobs.update::parameters.properties, "JobEnvelope");
@@clientName(Jobs.start::parameters.body, "template");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Job.properties);

@@clientLocation(JobExecutions.jobExecution, "");
@@clientLocation(JobExecutions.list, "JobsExecutions");
@@clientLocation(JobExecutions.stopExecution, Jobs);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(JobExecution.properties);

@@clientLocation(AvailableWorkloadProfilesOperationGroup.get,
  "AvailableWorkloadProfiles"
);

@@clientLocation(BillingMetersOperationGroup.get, "BillingMeters");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SessionPoolUpdatableProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerAppAuthToken.properties);

@@clientLocation(SessionPools.get, "ContainerAppsSessionPools");
@@clientLocation(SessionPools.createOrUpdate, "ContainerAppsSessionPools");
@@clientName(SessionPools.createOrUpdate::parameters.resource,
  "sessionPoolEnvelope"
);
@@clientLocation(SessionPools.update, "ContainerAppsSessionPools");
@@clientName(SessionPools.update::parameters.properties, "sessionPoolEnvelope");
@@clientLocation(SessionPools.delete, "ContainerAppsSessionPools");
@@clientLocation(SessionPools.listByResourceGroup, "ContainerAppsSessionPools");
@@clientLocation(SessionPools.listBySubscription, "ContainerAppsSessionPools");
@@clientLocation(SessionPools.fetchMcpServerCredentials,
  "ContainerAppsSessionPools"
);
@@clientLocation(SessionPools.rotateMcpServerCredentials,
  "ContainerAppsSessionPools"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SessionPool.properties);

@@clientLocation(SourceControls.get, "ContainerAppsSourceControls");
@@clientLocation(SourceControls.createOrUpdate, "ContainerAppsSourceControls");
@@clientName(SourceControls.createOrUpdate::parameters.resource,
  "sourceControlEnvelope"
);
@@clientLocation(SourceControls.delete, "ContainerAppsSourceControls");
@@clientLocation(SourceControls.listByContainerApp,
  "ContainerAppsSourceControls"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SourceControl.properties);

@@clientName(ContainerApps.createOrUpdate::parameters.resource,
  "containerAppEnvelope"
);
@@clientName(ContainerApps.update::parameters.properties,
  "containerAppEnvelope"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerApp.properties);

@@clientLocation(ContainerAppsBuildResources.get, "ContainerAppsBuilds");
@@clientLocation(ContainerAppsBuildResources.delete, "ContainerAppsBuilds");
@@clientLocation(ContainerAppsBuildResources.list,
  "ContainerAppsBuildsByContainerApp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerAppsBuildResource.properties);

@@clientLocation(ContainerAppsFunctions.get, "ContainerAppsRevisionFunctions");
@@clientLocation(ContainerAppsFunctions.list, "ContainerAppsRevisionFunctions");
@@clientLocation(ContainerAppsFunctionOperationGroup.get,
  ContainerAppsFunctions
);
@@clientLocation(ContainerAppsFunctionOperationGroup.list,
  ContainerAppsFunctions
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerAppsFunction.properties);

@@clientLocation(LabelHistories.getLabelHistory, "ContainerAppsLabelHistory");
@@clientLocation(LabelHistories.deleteLabelHistory,
  "ContainerAppsLabelHistory"
);
@@clientLocation(LabelHistories.listLabelHistory, "ContainerAppsLabelHistory");

@@clientLocation(ContainerAppsPatchResources.get, "ContainerAppsPatches");
@@clientLocation(ContainerAppsPatchResources.delete, "ContainerAppsPatches");
@@clientLocation(ContainerAppsPatchResources.listByContainerApp,
  "ContainerAppsPatches"
);
@@clientLocation(ContainerAppsPatchResources.skipConfigure,
  "ContainerAppsPatches"
);
@@clientName(ContainerAppsPatchResources.skipConfigure::parameters.body,
  "patchSkipConfig"
);
@@clientLocation(ContainerAppsPatchResources.apply, "ContainerAppsPatches");

@@clientLocation(Revisions.getRevision, "ContainerAppsRevisions");
@@clientLocation(Revisions.listRevisions, "ContainerAppsRevisions");
@@clientLocation(Revisions.activateRevision, "ContainerAppsRevisions");
@@clientLocation(Revisions.deactivateRevision, "ContainerAppsRevisions");
@@clientLocation(Revisions.restartRevision, "ContainerAppsRevisions");
@@clientLocation(Revisions.invokeFunctionsHost, "FunctionsExtension");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Revision.properties);

@@clientLocation(Replicas.getReplica, "ContainerAppsRevisionReplicas");
@@clientLocation(Replicas.listReplicas, "ContainerAppsRevisionReplicas");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Replica.properties);

@@clientName(DotNetComponents.createOrUpdate::parameters.resource,
  "dotNetComponentEnvelope"
);
@@clientName(DotNetComponents.update::parameters.properties,
  "dotNetComponentEnvelope"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DotNetComponent.properties);

@@clientName(JavaComponents.createOrUpdate::parameters.resource,
  "javaComponentEnvelope"
);
@@clientName(JavaComponents.update::parameters.properties,
  "javaComponentEnvelope"
);

@@clientName(LogicApps.deployWorkflowArtifacts::parameters.body,
  "workflowArtifacts"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(LogicApp.properties);

@@clientLocation(WorkflowEnvelopes.getWorkflow, LogicApps);
@@clientLocation(WorkflowEnvelopes.listWorkflows, LogicApps);

@@clientLocation(UsagesOperationGroup.list, "Usages");

@@clientLocation(ManagedEnvironmentUsagesOperationGroup.list,
  "ManagedEnvironmentUsages"
);
