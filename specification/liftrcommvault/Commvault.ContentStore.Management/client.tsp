import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Commvault.ContentStore;

@@clientName(
  Commvault.ContentStore,
  "CommvaultContentStoreMgmtClient",
  "python"
);

// [SUFFIX002] The "Request" suffix is reserved for HTTP protocol types; use "Content" for request-body models.
@@clientName(ActivateSaaSParameterRequest, "ActivateSaaSParameterContent", "csharp");
@@clientName(BackupProtectionGroupRequest, "BackupProtectionGroupContent", "csharp");
@@clientName(CountProtectedItemsRequest, "CountProtectedItemsContent", "csharp");
@@clientName(RestoreProtectionItemRequest, "RestoreProtectionItemContent", "csharp");
@@clientName(StopBackupProtectionGroupRequest, "StopBackupProtectionGroupContent", "csharp");

// [SUFFIX004] The "Response" suffix is reserved for HTTP protocol types; use "Result"
// (or "Data" for models that derive from ResourceData).
@@clientName(BackupProtectionGroupResponse, "BackupProtectionGroupResult", "csharp");
@@clientName(CountProtectedItemsResponse, "CountProtectedItemsResult", "csharp");
@@clientName(RestoreProtectionItemResponse, "RestoreProtectionItemResult", "csharp");
@@clientName(LatestLinkedSaaSResponse, "LatestLinkedSaaSResult", "csharp");
@@clientName(SaaSResourceDetailsResponse, "SaaSResourceDetailsData", "csharp");

// [AZC0032] Non-resource models must not end with "Data"; give it a descriptive service-specific name.
@@clientName(SaaSData, "CommvaultSaaSDetails", "csharp");

// [SUFFIX003] The "Options" suffix is reserved for client configuration types.
@@clientName(BackupOptions, "BackupConfig", "csharp");

// [BOOL001] Boolean properties require an Is/Can/Has/Should prefix (and corrected "Snapshot" casing).
@@clientName(BackupOptions.backupCopyImmediately, "ShouldCopyImmediately", "csharp");
@@clientName(BackupOptions.runSnapShotBackup, "ShouldRunSnapshotBackup", "csharp");
@@clientName(BackupOptions.notifyUserOnJobCompletion, "ShouldNotifyUserOnJobCompletion", "csharp");

// [ACRONYM] "BackUp" should be treated as the compound word "Backup".
@@clientName(BackUpType, "BackupType", "csharp");

// [Contextual naming] Avoid shadowing the .NET BCL type System.DayOfWeek.
@@clientName(DayOfWeek, "CommvaultDayOfWeek", "csharp");

// [Contextual naming] "Operator" is too generic and collides easily in user code.
@@clientName(Operator, "CommvaultMatchOperator", "csharp");

// The "Equals" union member collides with the generated value-type's Equals(object) method.
@@clientName(Operator.Equals, "Equal", "csharp");
