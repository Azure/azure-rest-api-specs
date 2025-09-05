import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageSync;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageSyncServiceCreateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageSyncServiceUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SyncGroupCreateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CloudEndpointCreateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PostBackupResponse.backupMetadata);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ServerEndpointCreateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ServerEndpointUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RegisteredServerCreateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RegisteredServerUpdateParameters.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SubscriptionState.properties);

@@clientName(StorageSyncServices.create::parameters.resource, "parameters");
@@clientName(StorageSyncServices.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageSyncService.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(SyncGroups.create::parameters.resource, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SyncGroup.properties);

@@clientName(CloudEndpoints.create::parameters.resource, "parameters");
@@clientName(CloudEndpoints.preBackup::parameters.body, "parameters");
@@clientName(CloudEndpoints.postBackup::parameters.body, "parameters");
@@clientName(CloudEndpoints.preRestore::parameters.body, "parameters");
@@clientName(CloudEndpoints.postRestore::parameters.body, "parameters");
@@clientName(CloudEndpoints.triggerChangeDetection::parameters.body,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CloudEndpoint.properties);

@@clientName(ServerEndpoints.create::parameters.resource, "parameters");
@@clientName(ServerEndpoints.update::parameters.properties, "parameters");
@@clientName(ServerEndpoints.recallAction::parameters.body, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ServerEndpoint.properties);

@@clientName(RegisteredServers.create::parameters.resource, "parameters");
@@clientName(RegisteredServers.update::parameters.properties, "parameters");
@@clientName(RegisteredServers.triggerRollover::parameters.body, "parameters");
@@clientName(StorageSyncServicesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(RegisteredServer.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Workflow.properties);

@@clientLocation(OperationStatusOperationGroup.get,
  "OperationStatus",
  "!csharp"
);
@@clientLocation(StorageSyncServices.listByStorageSyncService,
  "PrivateLinkResources",
  "!csharp"
);
@@clientLocation(StorageSyncServicesOperationGroup.checkNameAvailability,
  StorageSyncServices,
  "!csharp"
);
@@clientName(locationOperationStatusGet, "LocationOperationStatus", "!csharp");

@@clientName(CloudEndpoints.restoreheartbeat, "restoreHeartbeat", "!csharp");
@@clientName(RegisteredServers.triggerRollover, "triggerRollover", "!csharp");
@@clientName(ServerEndpoints.recallAction, "recallAction", "!csharp");

@@clientLocation(locationOperationStatusGet, "MicrosoftStorageSync", "go");
@@clientName(CloudEndpoints.restoreheartbeat, "restoreheartbeat", "go");
@@alternateType(CheckNameAvailabilityParameters.type, "string", "go");
