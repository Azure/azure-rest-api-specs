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

@@clientName(AppResiliencies.createOrUpdate::parameters.resource,
  "resiliencyEnvelope"
);
@@clientName(AppResiliencies.update::parameters.properties,
  "resiliencyEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AppResiliency.properties);

@@clientName(ContainerAppsAuthConfigs.createOrUpdate::parameters.resource,
  "authConfigEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AuthConfig.properties);

@@clientName(Builders.createOrUpdate::parameters.resource, "builderEnvelope");

@@clientName(Builders.update::parameters.properties, "builderEnvelope");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(BuilderResource.properties);

@@clientName(Builds.createOrUpdate::parameters.resource, "buildEnvelope");
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

@@clientName(Certificates.getCertificates, "Get");
@@clientName(Certificates.listCertificates, "List");
@@clientName(Certificates.deleteCertificates, "Delete");
@@clientName(Certificates.createOrUpdateCertificates, "CreateOrUpdate");
@@clientName(Certificates.updateCertificates, "Update");
@@clientName(Certificates.createOrUpdateCertificates::parameters.resource,
  "certificateEnvelope"
);
@@clientName(Certificates.updateCertificates::parameters.properties,
  "certificateEnvelope"
);

@@clientName(DaprComponents.createOrUpdate::parameters.resource,
  "daprComponentEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DaprComponent.properties);

@@clientName(ConnectedEnvironmentsStorages.createOrUpdate::parameters.resource,
  "storageEnvelope"
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

@@clientName(MaintenanceConfigurations.createOrUpdate::parameters.resource,
  "maintenanceConfigurationEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MaintenanceConfigurationResource.properties);

@@clientName(ManagedEnvironmentsStorages.createOrUpdate::parameters.resource,
  "storageEnvelope"
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

@@clientName(ContainerAppsSessionPools.createOrUpdate::parameters.resource,
  "sessionPoolEnvelope"
);

@@clientName(ContainerAppsSessionPools.update::parameters.properties,
  "sessionPoolEnvelope"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SessionPool.properties);

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

@@clientLocation(ContainerAppsBuilds.list, "ContainerAppsBuildsByContainerApp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerAppsBuildResource.properties);

@@clientLocation(ContainerAppsFunctions.get, "ContainerAppsRevisionFunctions");
@@clientLocation(ContainerAppsFunctions.list, "ContainerAppsRevisionFunctions");

@@clientName(ContainerAppsFunctions.getAzureFunctionsOnContainerApps, "get");
@@clientName(ContainerAppsFunctions.listAzureFunctionsOnContainerApps, "list");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ContainerAppsFunction.properties);

@@clientName(ContainerAppsPatches.skipConfigure::parameters.body,
  "patchSkipConfig"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Revision.properties);

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

@@clientLocation(ManagedEnvironmentsDiagnostics.listDetectors,
  "ManagedEnvironmentDiagnostics"
);
@@clientLocation(ManagedEnvironmentsDiagnostics.getDetector,
  "ManagedEnvironmentDiagnostics"
);

@@clientLocation(AppResiliencies.createOrUpdate, "AppResiliency");
@@clientLocation(AppResiliencies.update, "AppResiliency");
@@clientLocation(AppResiliencies.list, "AppResiliency");
@@clientLocation(AppResiliencies.delete, "AppResiliency");
@@clientLocation(AppResiliencies.get, "AppResiliency");
