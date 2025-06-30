import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DBforPostgreSQL;

@@clientName(Clusters.promoteReadReplica::parameters.body, "promoteRequest");

@@clientName(NodeConfigurations.updateOnNode::parameters.resource,
  "parameters"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Configuration.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerConfiguration.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FirewallRule.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Role.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterServer.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ClusterForUpdate.properties, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RoleProperties.externalIdentity, "go");

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SimplePrivateEndpointConnection.properties, "go");

@@clientLocation(NodeConfigurations.updateOnNode, Configurations);
@@clientLocation(NodeConfigurations.getNode, Configurations);
@@clientLocation(CoordinatorConfigurations.getCoordinator, Configurations);
@@clientLocation(CoordinatorConfigurations.updateOnCoordinator, Configurations);
