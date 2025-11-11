import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DataProtection;

// Fix property name changes (ID -> Id)
@@clientName(DatasourceSet.resourceID, "resourceId", "java");
@@clientName(Datasource.resourceID, "resourceId", "java");
@@clientName(DeletionInfo.deleteActivityID, "deleteActivityId", "java");
@@clientName(RetentionTag.eTag, "etag", "java");
@@clientName(RestoreJobRecoveryPointDetails.recoveryPointID,
  "recoveryPointId",
  "java"
);
@@clientName(AzureBackupJob.activityID, "activityId", "java");
@@clientName(AzureBackupJob.sourceSubscriptionID,
  "sourceSubscriptionId",
  "java"
);
@@clientName(RecoveryPointDataStoreDetails.metaData, "metadata", "java");

// Fix the BCDRSecurityLevel enum name change
@@clientName(BCDRSecurityLevel, "BcdrSecurityLevel", "java");

// Fix method name changes (PIN -> Pin in ResourceGuards)
@@clientLocation(DppBaseResourceOperationGroup.getBackupSecurityPINRequestsObjects,
  "getBackupSecurityPinRequestsObjects",
  "java"
);
@@clientLocation(DppBaseResourceOperationGroup.getDefaultBackupSecurityPINRequestsObject,
  "getDefaultBackupSecurityPinRequestsObject",
  "java"
);
