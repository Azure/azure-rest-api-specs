import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforPostgreSQL;

@@clientName(Clusters.promoteReadReplica::parameters.body, "promoteRequest");
@@clientName(Clusters.create::parameters.resource, "parameters");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientName(ClustersOperationGroup.checkNameAvailability::parameters.body,
  "nameAvailabilityRequest"
);
@@clientName(FirewallRules.createOrUpdate::parameters.resource, "parameters");
@@clientName(CoordinatorConfigurations.updateOnCoordinator::parameters.resource,
  "parameters"
);
@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(Roles.create::parameters.resource, "parameters");

@@clientName(NodeConfigurations.updateOnNode::parameters.resource,
  "parameters"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Configuration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerConfiguration.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallRule.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Role.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Cluster.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterServer.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterForUpdate.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RoleProperties.externalIdentity);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SimplePrivateEndpointConnection.properties);

@@clientLocation(NodeConfigurations.updateOnNode, Configurations);
@@clientLocation(NodeConfigurations.getNode, Configurations);
@@clientLocation(CoordinatorConfigurations.getCoordinator, Configurations);
@@clientLocation(CoordinatorConfigurations.updateOnCoordinator, Configurations);
@@clientLocation(ClustersOperationGroup.checkNameAvailability, Clusters);
