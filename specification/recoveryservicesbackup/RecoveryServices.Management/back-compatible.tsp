import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientName(BackupResourceStorageConfigsNonCRR.update::parameters.resource,
  "parameters"
);
@@clientName(BackupResourceStorageConfigsNonCRR.patch::parameters.properties,
  "parameters"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bMSPrepareDataMove::parameters.body,
  "parameters"
);
@@clientName(BackupResourceStorageConfigsNonCRR.bMSTriggerDataMove::parameters.body,
  "parameters"
);

@@clientName(ProtectionIntentResources.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(BackupResourceVaultConfigs.put::parameters.resource, "parameters");
@@clientName(BackupResourceVaultConfigs.update::parameters.properties,
  "parameters"
);

@@clientName(BackupResourceEncryptionConfigs.update::parameters.resource,
  "parameters"
);

@@clientName(PrivateEndpointConnectionResources.put::parameters.resource,
  "parameters"
);

@@clientName(ProtectedItems.createOrUpdate::parameters.resource, "parameters");
@@clientName(Backups.trigger::parameters.body, "parameters");
@@clientName(RecoveryPointsRecommendedForMove.list::parameters.body,
  "parameters"
);

@@clientName(RecoveryPoints.moveRecoveryPoint::parameters.body, "parameters");
@@clientName(Restores.trigger::parameters.body, "parameters");
@@clientName(ItemLevelRecoveryConnections.provision::parameters.body,
  "parameters"
);

@@clientName(ProtectionPolicies.createOrUpdate::parameters.resource,
  "parameters"
);

@@clientName(ProtectionContainers.register::parameters.resource, "parameters");

@@clientName(ResourceGuardProxy.put::parameters.resource, "parameters");
@@clientName(ResourceGuardProxy.unlockDelete::parameters.body, "parameters");

@@clientLocation(BackupResourceStorageConfigsNonCRR.bMSPrepareDataMove,
  Microsoft.RecoveryServices
);
@@clientLocation(BackupResourceStorageConfigsNonCRR.bMSTriggerDataMove,
  Microsoft.RecoveryServices
);
@@clientLocation(BackupResourceConfigOperationStatuses.getOperationStatus,
  Microsoft.RecoveryServices
);

@@clientLocation(PrivateEndpointConnectionResources.get,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnectionResources.put,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointConnectionResources.delete,
  "PrivateEndpointConnection"
);
@@clientLocation(PrivateEndpointOperationStatuses.getOperationStatus,
  "PrivateEndpoint"
);

@@clientLocation(ProtectionIntentResources.get, "ProtectionIntent");
@@clientLocation(ProtectionIntentResources.createOrUpdate, "ProtectionIntent");
@@clientLocation(ProtectionIntentResources.delete, "ProtectionIntent");

@@clientLocation(RecoveryPoints.moveRecoveryPoint, Microsoft.RecoveryServices);

@@clientLocation(ProtectionContainersOperationGroup.refresh,
  ProtectionContainers
);

@@clientLocation(ProtectionIntentOperationGroup.validate, "ProtectionIntent");

@@clientLocation(OperationOperationGroup.validate, "Operation");
