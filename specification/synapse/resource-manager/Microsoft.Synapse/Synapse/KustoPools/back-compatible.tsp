import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace KustoPools;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(KustoPoolUpdate.properties);

@@clientName(
  FollowerDatabaseDefinition.clusterResourceId,
  "kustoPoolResourceId"
);

@@clientName(
  AttachedDatabaseConfigurationProperties.clusterResourceId,
  "kustoPoolResourceId"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(KustoPoolPrivateLinkResources.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ReadWriteDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ReadOnlyFollowingDatabase.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EventHubDataConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(IotHubDataConnection.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EventGridDataConnection.properties);

@@clientName(KustoPools.createOrUpdate::parameters.resource, "parameters");
@@clientName(KustoPools.update::parameters.properties, "parameters");
@@clientName(
  KustoPools.addLanguageExtensions::parameters.body,
  "languageExtensionsToAdd"
);
@@clientName(
  KustoPools.removeLanguageExtensions::parameters.body,
  "languageExtensionsToRemove"
);
@@clientName(
  KustoPools.detachFollowerDatabases::parameters.body,
  "followerDatabaseToRemove"
);
@@clientLocation(KustoPools.checkNameAvailability, "KustoPoolChildResource");
@@clientName(KustoPools.checkNameAvailability::parameters.body, "resourceName");
@@clientLocation(
  KustoPools.kustoPoolPrincipalAssignmentsCheckNameAvailability,
  "KustoPoolPrincipalAssignments"
);
@@clientName(
  KustoPools.kustoPoolPrincipalAssignmentsCheckNameAvailability,
  "CheckNameAvailability"
);
@@clientName(
  KustoPools.kustoPoolPrincipalAssignmentsCheckNameAvailability::parameters.body,
  "principalAssignmentName"
);
@@clientLocation(KustoPools.list, "KustoPoolPrivateLinkResources");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(KustoPool.properties);

@@clientLocation(
  AttachedDatabaseConfigurations.get,
  "KustoPoolAttachedDatabaseConfigurations"
);
@@clientLocation(
  AttachedDatabaseConfigurations.createOrUpdate,
  "KustoPoolAttachedDatabaseConfigurations"
);
@@clientName(
  AttachedDatabaseConfigurations.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  AttachedDatabaseConfigurations.delete,
  "KustoPoolAttachedDatabaseConfigurations"
);
@@clientLocation(
  AttachedDatabaseConfigurations.listByKustoPool,
  "KustoPoolAttachedDatabaseConfigurations"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AttachedDatabaseConfiguration.properties);

@@clientLocation(Databases.get, "KustoPoolDatabases");
@@clientLocation(Databases.createOrUpdate, "KustoPoolDatabases");
@@clientName(Databases.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(Databases.update, "KustoPoolDatabases");
@@clientName(Databases.update::parameters.properties, "parameters");
@@clientLocation(Databases.delete, "KustoPoolDatabases");
@@clientLocation(Databases.listByKustoPool, "KustoPoolDatabases");
@@clientLocation(Databases.checkNameAvailability, "KustoPoolDataConnections");
@@clientName(
  Databases.checkNameAvailability::parameters.body,
  "dataConnectionName"
);
@@clientLocation(
  Databases.dataConnectionValidation,
  "KustoPoolDataConnections"
);
@@clientName(Databases.dataConnectionValidation, "dataConnectionValidation");
@@clientName(Databases.dataConnectionValidation::parameters.body, "parameters");
@@clientLocation(
  Databases.kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability,
  "KustoPoolDatabasePrincipalAssignments"
);
@@clientName(
  Databases.kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability,
  "CheckNameAvailability"
);
@@clientName(
  Databases.kustoPoolDatabasePrincipalAssignmentsCheckNameAvailability::parameters.body,
  "principalAssignmentName"
);

@@clientLocation(DataConnections.get, "KustoPoolDataConnections");
@@clientLocation(DataConnections.createOrUpdate, "KustoPoolDataConnections");
@@clientName(DataConnections.createOrUpdate::parameters.resource, "parameters");
@@clientLocation(DataConnections.update, "KustoPoolDataConnections");
@@clientName(DataConnections.update::parameters.properties, "parameters");
@@clientLocation(DataConnections.delete, "KustoPoolDataConnections");
@@clientLocation(DataConnections.listByDatabase, "KustoPoolDataConnections");

@@clientLocation(
  ClusterPrincipalAssignments.get,
  "KustoPoolPrincipalAssignments"
);
@@clientLocation(
  ClusterPrincipalAssignments.createOrUpdate,
  "KustoPoolPrincipalAssignments"
);
@@clientName(
  ClusterPrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  ClusterPrincipalAssignments.delete,
  "KustoPoolPrincipalAssignments"
);
@@clientLocation(
  ClusterPrincipalAssignments.list,
  "KustoPoolPrincipalAssignments"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ClusterPrincipalAssignment.properties);

@@clientLocation(
  DatabasePrincipalAssignments.get,
  "KustoPoolDatabasePrincipalAssignments"
);
@@clientLocation(
  DatabasePrincipalAssignments.createOrUpdate,
  "KustoPoolDatabasePrincipalAssignments"
);
@@clientName(
  DatabasePrincipalAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientLocation(
  DatabasePrincipalAssignments.delete,
  "KustoPoolDatabasePrincipalAssignments"
);
@@clientLocation(
  DatabasePrincipalAssignments.list,
  "KustoPoolDatabasePrincipalAssignments"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(DatabasePrincipalAssignment.properties);

@@clientLocation(KustoOperationsOperationGroup.list, "KustoOperations");

@@clientLocation(KustoPoolsOperationGroup.listSkus, KustoPools);
@@clientLocation(KustoPoolsOperationGroup.checkNameAvailability, KustoPools);
@@clientName(
  KustoPoolsOperationGroup.checkNameAvailability::parameters.body,
  "kustoPoolName"
);
