import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageSync;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageSyncServiceCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageSyncServiceUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SyncGroupCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudEndpointCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PostBackupResponse.backupMetadata);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerEndpointCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerEndpointUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegisteredServerCreateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegisteredServerUpdateParameters.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SubscriptionState.properties);

@@clientName(StorageSyncServices.create::parameters.resource, "parameters");
@@clientName(StorageSyncServices.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageSyncService.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(SyncGroups.create::parameters.resource, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SyncGroup.properties);

@@clientName(CloudEndpoints.create::parameters.resource, "parameters");
@@clientName(CloudEndpoints.preBackup::parameters.body, "parameters");
@@clientName(CloudEndpoints.postBackup::parameters.body, "parameters");
@@clientName(CloudEndpoints.preRestore::parameters.body, "parameters");
@@clientName(CloudEndpoints.postRestore::parameters.body, "parameters");
@@clientName(CloudEndpoints.triggerChangeDetection::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudEndpoint.properties);

@@clientName(ServerEndpoints.create::parameters.resource, "parameters");
@@clientName(ServerEndpoints.update::parameters.properties, "parameters");
@@clientName(ServerEndpoints.recallAction::parameters.body, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ServerEndpoint.properties);

@@clientName(RegisteredServers.create::parameters.resource, "parameters");
@@clientName(RegisteredServers.update::parameters.properties, "parameters");
@@clientName(RegisteredServers.triggerRollover::parameters.body, "parameters");
@@clientName(StorageSyncServicesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RegisteredServer.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Workflow.properties);
