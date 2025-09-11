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

// Migration mappings added to mitigate Java SDK breaking changes after TypeSpec migration
@@clientName(Microsoft.RecoveryServices.IaaSVMContainer,
  "IaaSvmContainer",
  "java"
);
@@clientName(Microsoft.RecoveryServices.AzureIaaSVMProtectedItem,
  "AzureIaaSvmProtectedItem",
  "java"
);
@@alternateType(Microsoft.RecoveryServices.InquiryValidation.protectableItemCount,
  unknown,
  "java"
);
