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

@@clientLocation(AppResiliencies.get, "AppResiliencies");
@@clientLocation(AppResiliencies.createOrUpdate, "AppResiliencies");
@@clientName(AppResiliencies.createOrUpdate::parameters.resource,
  "resiliencyEnvelope"
);
@@clientLocation(AppResiliencies.update, "AppResiliencies");
@@clientName(AppResiliencies.update::parameters.properties,
  "resiliencyEnvelope"
);
@@clientLocation(AppResiliencies.delete, "AppResiliencies");
@@clientLocation(AppResiliencies.list, "AppResiliencies");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AppResiliency.properties);

@@clientLocation(ContainerAppsAuthConfigs.get, "ContainerAppsAuthConfigs");
@@clientLocation(ContainerAppsAuthConfigs.createOrUpdate,
  "ContainerAppsAuthConfigs"
);
@@clientName(ContainerAppsAuthConfigs.createOrUpdate::parameters.resource,
  "authConfigEnvelope"
);
@@clientLocation(ContainerAppsAuthConfigs.delete, "ContainerAppsAuthConfigs");
@@clientLocation(ContainerAppsAuthConfigs.listByContainerApp,
  "ContainerAppsAuthConfigs"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AuthConfig.properties);

@@clientLocation(Builders.get, "Builders");
@@clientLocation(Builders.createOrUpdate, "Builders");
@@clientName(Builders.createOrUpdate::parameters.resource, "builderEnvelope");
@@clientLocation(Builders.update, "Builders");
@@clientName(Builders.update::parameters.properties, "builderEnvelope");
@@clientLocation(Builders.delete, "Builders");
@@clientLocation(Builders.listByResourceGroup, "Builders");
@@clientLocation(Builders.listBySubscription, "Builders");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BuilderResource.properties);

@@clientLocation(Builds.get, "Builds");
@@clientLocation(Builds.createOrUpdate, "Builds");
@@clientName(Builds.createOrUpdate::parameters.resource, "buildEnvelope");
@@clientLocation(Builds.delete, "Builds");
@@clientLocation(Builds.list, "BuildsByBuilderResource");
@@clientLocation(Builds.buildAuthTokenList, "BuildAuthToken");
@@clientName(Builds.buildAuthTokenList, "List");
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

@@clientLocation(ConnectedEnvironmentsStorages.get,
  "ConnectedEnvironmentsStorages"
);
@@clientLocation(ConnectedEnvironmentsStorages.createOrUpdate,
  "ConnectedEnvironmentsStorages"
);
@@clientName(ConnectedEnvironmentsStorages.createOrUpdate::parameters.resource,
  "storageEnvelope"
);
@@clientLocation(ConnectedEnvironmentsStorages.delete,
  "ConnectedEnvironmentsStorages"
);
@@clientLocation(ConnectedEnvironmentsStorages.list,
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

@@clientLocation(MaintenanceConfigurations.get, "MaintenanceConfigurations");
@@clientLocation(MaintenanceConfigurations.createOrUpdate,
  "MaintenanceConfigurations"
);
@@clientName(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "maintenanceConfigurationEnvelope"
);
@@clientLocation(MaintenanceConfigurations.delete, "MaintenanceConfigurations");
@@clientLocation(MaintenanceConfigurations.list, "MaintenanceConfigurations");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MaintenanceConfigurationResource.properties);

@@clientLocation(ManagedEnvironmentsStorages.get,
  "ManagedEnvironmentsStorages"
);
@@clientLocation(ManagedEnvironmentsStorages.createOrUpdate,
  "ManagedEnvironmentsStorages"
);
@@clientName(ManagedEnvironmentsStorages.createOrUpdate::parameters.resource,
  "storageEnvelope"
);
@@clientLocation(ManagedEnvironmentsStorages.delete,
  "ManagedEnvironmentsStorages"
);
@@clientLocation(ManagedEnvironmentsStorages.list,
  "ManagedEnvironmentsStorages"
);

@@clientName(Jobs.createOrUpdate::parameters.resource, "JobEnvelope");
@@clientName(Jobs.update::parameters.properties, "JobEnvelope");
@@clientName(Jobs.start::parameters.body, "template");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Job.properties);

@@clientLocation(Jobs.jobExecution, "");
@@clientLocation(Jobs.list, "JobsExecutions");

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

@@clientLocation(ContainerAppsSessionPools.get, "ContainerAppsSessionPools");
@@clientLocation(ContainerAppsSessionPools.createOrUpdate,
  "ContainerAppsSessionPools"
);
@@clientName(ContainerAppsSessionPools.createOrUpdate::parameters.resource,
  "sessionPoolEnvelope"
);
@@clientLocation(ContainerAppsSessionPools.update, "ContainerAppsSessionPools");
@@clientName(ContainerAppsSessionPools.update::parameters.properties,
  "sessionPoolEnvelope"
);
@@clientLocation(ContainerAppsSessionPools.delete, "ContainerAppsSessionPools");
@@clientLocation(ContainerAppsSessionPools.listByResourceGroup,
  "ContainerAppsSessionPools"
);
@@clientLocation(ContainerAppsSessionPools.listBySubscription,
  "ContainerAppsSessionPools"
);
@@clientLocation(ContainerAppsSessionPools.fetchMcpServerCredentials,
  "ContainerAppsSessionPools"
);
@@clientLocation(ContainerAppsSessionPools.rotateMcpServerCredentials,
  "ContainerAppsSessionPools"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SessionPool.properties);

@@clientLocation(ContainerAppsSourceControls.get,
  "ContainerAppsSourceControls"
);
@@clientLocation(ContainerAppsSourceControls.createOrUpdate,
  "ContainerAppsSourceControls"
);
@@clientName(ContainerAppsSourceControls.createOrUpdate::parameters.resource,
  "sourceControlEnvelope"
);
@@clientLocation(ContainerAppsSourceControls.delete,
  "ContainerAppsSourceControls"
);
@@clientLocation(ContainerAppsSourceControls.listByContainerApp,
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

@@clientLocation(ContainerAppsBuilds.get, "ContainerAppsBuilds");
@@clientLocation(ContainerAppsBuilds.delete, "ContainerAppsBuilds");
@@clientLocation(ContainerAppsBuilds.list, "ContainerAppsBuildsByContainerApp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerAppsBuildResource.properties);

@@clientLocation(ContainerAppsFunctions.get, "ContainerAppsRevisionFunctions");
@@clientLocation(ContainerAppsFunctions.list, "ContainerAppsRevisionFunctions");
@@clientLocation(AzureFunctionsOnContainerApps.get, ContainerAppsFunctions);
@@clientLocation(AzureFunctionsOnContainerApps.list, ContainerAppsFunctions);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerAppsFunction.properties);

@@clientLocation(ContainerAppsLabelHistory.getLabelHistory,
  "ContainerAppsLabelHistory"
);
@@clientLocation(ContainerAppsLabelHistory.deleteLabelHistory,
  "ContainerAppsLabelHistory"
);
@@clientLocation(ContainerAppsLabelHistory.listLabelHistory,
  "ContainerAppsLabelHistory"
);

@@clientLocation(ContainerAppsPatches.get, "ContainerAppsPatches");
@@clientLocation(ContainerAppsPatches.delete, "ContainerAppsPatches");
@@clientLocation(ContainerAppsPatches.listByContainerApp,
  "ContainerAppsPatches"
);
@@clientLocation(ContainerAppsPatches.skipConfigure, "ContainerAppsPatches");
@@clientName(ContainerAppsPatches.skipConfigure::parameters.body,
  "patchSkipConfig"
);
@@clientLocation(ContainerAppsPatches.apply, "ContainerAppsPatches");

@@clientLocation(ContainerAppsRevisions.getRevision, "ContainerAppsRevisions");
@@clientLocation(ContainerAppsRevisions.listRevisions,
  "ContainerAppsRevisions"
);
@@clientLocation(ContainerAppsRevisions.activateRevision,
  "ContainerAppsRevisions"
);
@@clientLocation(ContainerAppsRevisions.deactivateRevision,
  "ContainerAppsRevisions"
);
@@clientLocation(ContainerAppsRevisions.restartRevision,
  "ContainerAppsRevisions"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Revision.properties);

@@clientLocation(ContainerAppsRevisionReplicas.getReplica,
  "ContainerAppsRevisionReplicas"
);
@@clientLocation(ContainerAppsRevisionReplicas.listReplicas,
  "ContainerAppsRevisionReplicas"
);
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

@@clientLocation(UsagesOperationGroup.list, "Usages");

@@clientLocation(ManagedEnvironmentUsagesOperationGroup.list,
  "ManagedEnvironmentUsages"
);

@@doc(Operations.list, "Lists all of the available RP operations.");
@@Azure.ResourceManager.identifiers(AvailableOperations.value, #["name"]);
@@Azure.ResourceManager.identifiers(ListUsagesResult.value, #["name"]);
@@clientName(ScheduledEntries.scheduledEntries, "ScheduledEntries");
