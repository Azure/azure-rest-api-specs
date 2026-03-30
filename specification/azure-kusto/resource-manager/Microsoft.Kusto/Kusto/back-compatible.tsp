import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kusto;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FollowerDatabaseDefinitionGet.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OutboundNetworkDependenciesEndpoint.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OperationResult.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(OperationResult.error);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReadWriteDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ReadOnlyFollowingDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EventHubDataConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(IotHubDataConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EventGridDataConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CosmosDbDataConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EventHubDataConnectionWithManagedIdentity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EventGridDataConnectionWithManagedIdentity.properties);

@@clientName(Clusters.createOrUpdate::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientName(Clusters.migrate::parameters.body, "clusterMigrateRequest");
@@clientName(Clusters.detachFollowerDatabases::parameters.body,
  "followerDatabaseToRemove"
);
@@clientName(Clusters.addCalloutPolicies::parameters.body, "calloutPolicies");
@@clientName(Clusters.removeCalloutPolicy::parameters.body, "calloutPolicy");
@@clientName(Clusters.addLanguageExtensions::parameters.body,
  "languageExtensionsToAdd"
);
@@clientName(Clusters.removeLanguageExtensions::parameters.body,
  "languageExtensionsToRemove"
);
@@clientLocation(Clusters.checkNameAvailability, ClusterPrincipalAssignments);
@@clientName(Clusters.checkNameAvailability::parameters.body,
  "principalAssignmentName"
);
@@clientLocation(Clusters.databasesCheckNameAvailability, Databases);
@@clientName(Clusters.databasesCheckNameAvailability, "CheckNameAvailability");
@@clientName(Clusters.databasesCheckNameAvailability::parameters.body,
  "resourceName"
);
@@clientLocation(Clusters.attachedDatabaseConfigurationsCheckNameAvailability,
  AttachedDatabaseConfigurations
);
@@clientName(Clusters.attachedDatabaseConfigurationsCheckNameAvailability,
  "CheckNameAvailability"
);
@@clientName(Clusters.attachedDatabaseConfigurationsCheckNameAvailability::parameters.body,
  "resourceName"
);
@@clientLocation(Clusters.managedPrivateEndpointsCheckNameAvailability,
  ManagedPrivateEndpoints
);
@@clientName(Clusters.managedPrivateEndpointsCheckNameAvailability,
  "CheckNameAvailability"
);
@@clientName(Clusters.managedPrivateEndpointsCheckNameAvailability::parameters.body,
  "resourceName"
);
@@clientLocation(Clusters.sandboxCustomImagesCheckNameAvailability,
  SandboxCustomImages
);
@@clientName(Clusters.sandboxCustomImagesCheckNameAvailability,
  "CheckNameAvailability"
);
@@clientName(Clusters.sandboxCustomImagesCheckNameAvailability::parameters.body,
  "resourceName"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cluster.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterPrincipalAssignment.properties);

@@clientName(Databases.createOrUpdate::parameters.resource, "parameters");
@@clientName(Databases.update::parameters.properties, "parameters");
@@clientName(Databases.addPrincipals::parameters.body,
  "databasePrincipalsToAdd"
);
@@clientName(Databases.removePrincipals::parameters.body,
  "databasePrincipalsToRemove"
);
@@clientLocation(Databases.inviteFollower, "Database");
@@clientName(Databases.inviteFollower::parameters.body, "parameters");
@@clientLocation(Databases.checkNameAvailability, DatabasePrincipalAssignments);
@@clientName(Databases.checkNameAvailability::parameters.body,
  "principalAssignmentName"
);
@@clientLocation(Databases.scriptsCheckNameAvailability, Scripts);
@@clientName(Databases.scriptsCheckNameAvailability, "CheckNameAvailability");
@@clientName(Databases.scriptsCheckNameAvailability::parameters.body,
  "scriptName"
);
@@clientLocation(Databases.dataConnectionValidation, DataConnections);
@@clientName(Databases.dataConnectionValidation, "dataConnectionValidation");
@@clientName(Databases.dataConnectionValidation::parameters.body, "parameters");
@@clientLocation(Databases.dataConnectionsCheckNameAvailability,
  DataConnections
);
@@clientName(Databases.dataConnectionsCheckNameAvailability,
  "CheckNameAvailability"
);
@@clientName(Databases.dataConnectionsCheckNameAvailability::parameters.body,
  "dataConnectionName"
);

@@clientName(DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabasePrincipalAssignment.properties);

@@clientName(Scripts.createOrUpdate::parameters.resource, "parameters");
@@clientName(Scripts.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Script.properties);

@@clientName(SandboxCustomImages.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SandboxCustomImages.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SandboxCustomImage.properties);

@@clientName(ManagedPrivateEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedPrivateEndpoints.update::parameters.properties,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ManagedPrivateEndpoint.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateLinkResource.properties);

@@clientName(AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AttachedDatabaseConfiguration.properties);

@@clientName(DataConnections.createOrUpdate::parameters.resource, "parameters");
@@clientName(DataConnections.update::parameters.properties, "parameters");

@@clientLocation(ClustersOperationGroup.listSkus, Clusters);
@@clientLocation(ClustersOperationGroup.checkNameAvailability, Clusters);

@@clientLocation(SkusOperationGroup.list, "Skus");

@@clientLocation(OperationsResultsOperationGroup.get, "OperationsResults");
@@clientLocation(OperationsResultsOperationGroup.getLocation,
  "OperationsResultsLocation"
);
@@clientName(OperationsResultsOperationGroup.getLocation, "Get");

@@clientName(ClustersOperationGroup.checkNameAvailability::parameters.body,
  "clusterName"
);
@@summary(CalloutPoliciesList.nextLink,
  "The URL to get the next set of callout policies list results if there are any."
);
@@clientName(KeyVaultProperties.keyName, "KeyName");
@@clientName(KeyVaultProperties.keyVersion, "KeyVersion");
@@clientName(KeyVaultProperties.keyVaultUri, "KeyVaultUri");
@@clientName(KeyVaultProperties.userIdentity, "UserIdentity");
@@clientName(KeyVaultProperties.federatedIdentityClientId,
  "FederatedIdentityClientId"
);
