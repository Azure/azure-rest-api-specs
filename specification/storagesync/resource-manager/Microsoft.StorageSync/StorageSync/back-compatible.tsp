import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageSync;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageSyncServiceCreateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageSyncServiceUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SyncGroupCreateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudEndpointCreateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PostBackupResponse.backupMetadata
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServerEndpointCreateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServerEndpointUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RegisteredServerCreateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RegisteredServerUpdateParameters.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SubscriptionState.properties
);

@@clientName(StorageSyncServices.create::parameters.resource, "parameters");
@@clientName(StorageSyncServices.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageSyncService.properties
);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties
);

@@clientName(SyncGroups.create::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SyncGroup.properties);

@@clientName(CloudEndpoints.create::parameters.resource, "parameters");
@@clientName(CloudEndpoints.preBackup::parameters.body, "parameters");
@@clientName(CloudEndpoints.postBackup::parameters.body, "parameters");
@@clientName(CloudEndpoints.preRestore::parameters.body, "parameters");
@@clientName(CloudEndpoints.postRestore::parameters.body, "parameters");
@@clientName(CloudEndpoints.triggerChangeDetection::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudEndpoint.properties);

@@clientName(ServerEndpoints.create::parameters.resource, "parameters");
@@clientName(ServerEndpoints.update::parameters.properties, "parameters");
@@clientName(ServerEndpoints.recallAction::parameters.body, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ServerEndpoint.properties);

@@clientName(RegisteredServers.create::parameters.resource, "parameters");
@@clientName(RegisteredServers.update::parameters.properties, "parameters");
@@clientName(RegisteredServers.triggerRollover::parameters.body, "parameters");
@@clientName(StorageSyncServicesOperationGroup.checkNameAvailability::parameters.body,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(RegisteredServer.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Workflow.properties);

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
