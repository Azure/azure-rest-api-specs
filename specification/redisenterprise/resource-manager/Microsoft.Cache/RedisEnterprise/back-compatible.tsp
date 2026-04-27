import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Cache;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClusterUpdate.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DatabaseUpdate.properties);

@@clientLocation(Clusters.get, "RedisEnterprise");
@@clientLocation(Clusters.create, "RedisEnterprise");
@@clientName(Clusters.create::parameters.resource, "parameters");
@@clientLocation(Clusters.update, "RedisEnterprise");
@@clientName(Clusters.update::parameters.properties, "parameters");
@@clientLocation(Clusters.delete, "RedisEnterprise");
@@clientLocation(Clusters.listByResourceGroup, "RedisEnterprise");
@@clientLocation(Clusters.list, "RedisEnterprise");
@@clientLocation(Clusters.listSkusForScaling, "RedisEnterprise");
@@clientLocation(Clusters.listByCluster, "PrivateLinkResources");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Cluster.properties);

@@clientName(PrivateEndpointConnections.put::parameters.resource, "properties");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateEndpointConnection.properties);

@@clientName(Databases.create::parameters.resource, "parameters");
@@clientName(Databases.update::parameters.properties, "parameters");
@@clientName(Databases.regenerateKey::parameters.body, "parameters");
@@clientName(Databases.`import`::parameters.body, "parameters");
@@clientName(Databases.export::parameters.body, "parameters");
@@clientName(Databases.forceUnlink::parameters.body, "parameters");
@@clientName(Databases.forceLinkToReplicationGroup::parameters.body,
  "parameters"
);
@@clientName(Databases.flush::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Database.properties);

@@clientLocation(AccessPolicyAssignments.get, "AccessPolicyAssignment");
@@clientLocation(AccessPolicyAssignments.createUpdate,
  "AccessPolicyAssignment"
);
@@clientName(AccessPolicyAssignments.createUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(AccessPolicyAssignments.delete, "AccessPolicyAssignment");
@@clientLocation(AccessPolicyAssignments.list, "AccessPolicyAssignment");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AccessPolicyAssignment.properties);

@@clientLocation(Migrations.get, "Migration");
@@clientLocation(Migrations.start, "Migration");
@@clientName(Migrations.start::parameters.resource, "parameters");
@@clientLocation(Migrations.list, "Migration");
@@clientLocation(Migrations.cancel, "Migration");

@@clientLocation(OperationsStatusOperationGroup.get, "OperationsStatus");
