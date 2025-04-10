import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Kusto;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FollowerDatabaseDefinitionGet.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OutboundNetworkDependenciesEndpoint.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationResult.properties);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(OperationResult.error);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReadWriteDatabase.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReadOnlyFollowingDatabase.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventHubDataConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IotHubDataConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EventGridDataConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CosmosDbDataConnection.properties);

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
@@clientName(Clusters.checkNameAvailability::parameters.body,
  "principalAssignmentName"
);
@@clientName(Clusters.databasesCheckNameAvailability::parameters.body,
  "resourceName"
);
@@clientName(Clusters.attachedDatabaseConfigurationsCheckNameAvailability::parameters.body,
  "resourceName"
);
@@clientName(Clusters.managedPrivateEndpointsCheckNameAvailability::parameters.body,
  "resourceName"
);
@@clientName(Clusters.sandboxCustomImagesCheckNameAvailability::parameters.body,
  "resourceName"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterPrincipalAssignment.properties);

@@clientName(Databases.createOrUpdate::parameters.resource, "parameters");
@@clientName(Databases.update::parameters.properties, "parameters");
@@clientName(Databases.addPrincipals::parameters.body,
  "databasePrincipalsToAdd"
);
@@clientName(Databases.removePrincipals::parameters.body,
  "databasePrincipalsToRemove"
);
@@clientName(Databases.inviteFollower::parameters.body, "parameters");
@@clientName(Databases.checkNameAvailability::parameters.body,
  "principalAssignmentName"
);
@@clientName(Databases.scriptsCheckNameAvailability::parameters.body,
  "scriptName"
);
@@clientName(Databases.dataConnectionValidation::parameters.body, "parameters");
@@clientName(Databases.dataConnectionsCheckNameAvailability::parameters.body,
  "dataConnectionName"
);

@@clientName(DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DatabasePrincipalAssignment.properties);

@@clientName(Scripts.createOrUpdate::parameters.resource, "parameters");
@@clientName(Scripts.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Script.properties);

@@clientName(SandboxCustomImages.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(SandboxCustomImages.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SandboxCustomImage.properties);

@@clientName(ManagedPrivateEndpoints.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(ManagedPrivateEndpoints.update::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ManagedPrivateEndpoint.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

@@clientName(AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AttachedDatabaseConfiguration.properties);

@@clientName(DataConnections.createOrUpdate::parameters.resource, "parameters");
@@clientName(DataConnections.update::parameters.properties, "parameters");
