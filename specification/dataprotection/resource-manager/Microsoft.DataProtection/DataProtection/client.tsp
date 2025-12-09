import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.DataProtection;

// Fix property name changes (ID -> Id)
@@clientName(DatasourceSet.resourceID, "resourceId", "java");
@@clientName(Datasource.resourceID, "resourceId", "java");
@@clientName(DeletionInfo.deleteActivityID, "deleteActivityId", "java");
@@clientName(RetentionTag.eTag, "etag", "java");
@@clientName(BackupVaultResource.eTag, "etag", "java");
@@clientName(ResourceGuardResource.eTag, "etag", "java");
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
@@clientName(DppBaseResourceOperationGroup.getBackupSecurityPINRequestsObjects,
  "getBackupSecurityPinRequestsObjects",
  "java"
);
@@clientName(DppBaseResourceOperationGroup.getDefaultBackupSecurityPINRequestsObject,
  "getDefaultBackupSecurityPinRequestsObject",
  "java"
);

@@clientName(Microsoft.DataProtection, "DataProtectionMgmtClient", "python");

@@clientName(BackupVaultOperationResults.getInResourceGroup,
  "listInResourceGroup",
  "javascript"
);
@@clientName(BackupVaultResources.getInSubscription,
  "listInSubscription",
  "javascript"
);
@@clientName(DppBaseResourceOperationGroup.getBackupSecurityPINRequestsObjects,
  "listBackupSecurityPINRequestsObjects",
  "javascript"
);
@@clientName(DppBaseResourceOperationGroup.getDeleteProtectedItemRequestsObjects,
  "listDeleteProtectedItemRequestsObjects",
  "javascript"
);
@@clientName(ResourceGuards.getDeleteResourceGuardProxyRequestsObjects,
  "listDeleteResourceGuardProxyRequestsObjects",
  "javascript"
);
@@clientName(DppBaseResourceOperationGroup.getDisableSoftDeleteRequestsObjects,
  "listDisableSoftDeleteRequestsObjects",
  "javascript"
);
@@clientName(ResourceGuardResources.getResourcesInResourceGroup,
  "listResourcesInResourceGroup",
  "javascript"
);
@@clientName(ResourceGuardResources.getResourcesInSubscription,
  "listResourcesInSubscription",
  "javascript"
);
@@clientName(DppBaseResourceOperationGroup.getUpdateProtectedItemRequestsObjects,
  "listUpdateProtectedItemRequestsObjects",
  "javascript"
);
@@clientName(DppBaseResourceOperationGroup.getUpdateProtectionPolicyRequestsObjects,
  "listUpdateProtectionPolicyRequestsObjects",
  "javascript"
);
