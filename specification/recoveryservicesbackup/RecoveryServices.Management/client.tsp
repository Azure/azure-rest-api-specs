import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.RecoveryServices;

@@clientLocation(BackupResourceStorageConfigsNonCRR.bMSPrepareDataMove,
  "Client",
  "go"
);
@@clientLocation(BackupResourceStorageConfigsNonCRR.bMSTriggerDataMove,
  "Client",
  "go"
);
@@clientLocation(BackupResourceConfigOperationStatuses.getOperationStatus,
  "Client",
  "go"
);

@@clientLocation(RecoveryPoints.moveRecoveryPoint, "Client", "go");
