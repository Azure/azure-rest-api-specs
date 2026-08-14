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
@@clientName(
  ActivateSaaSParameterRequest,
  "ActivateSaaSParameterContent",
  "csharp"
);
@@clientName(
  BackupProtectionGroupRequest,
  "BackupProtectionGroupContent",
  "csharp"
);
@@clientName(
  CountProtectedItemsRequest,
  "CountProtectedItemsContent",
  "csharp"
);
@@clientName(
  RestoreProtectionItemRequest,
  "RestoreProtectionItemContent",
  "csharp"
);
@@clientName(
  StopBackupProtectionGroupRequest,
  "StopBackupProtectionGroupContent",
  "csharp"
);

// [SUFFIX004] The "Response" suffix is reserved for HTTP protocol types; use "Result"
// (or "Data" for models that derive from ResourceData).
@@clientName(
  BackupProtectionGroupResponse,
  "BackupProtectionGroupResult",
  "csharp"
);
@@clientName(
  CountProtectedItemsResponse,
  "CountProtectedItemsResult",
  "csharp"
);
@@clientName(
  RestoreProtectionItemResponse,
  "RestoreProtectionItemResult",
  "csharp"
);
@@clientName(LatestLinkedSaaSResponse, "LatestLinkedSaaSResult", "csharp");
@@clientName(SaaSResourceDetailsResponse, "SaaSResourceDetailsData", "csharp");

// [AZC0032] Non-resource models must not end with "Data"; give it a descriptive service-specific name.
@@clientName(SaaSData, "CommvaultSaaSDetails", "csharp");

// [SUFFIX003] The "Options" suffix is reserved for client configuration types.
@@clientName(BackupOptions, "BackupConfig", "csharp");

// [BOOL001] Boolean properties require an Is/Can/Has/Should prefix (and corrected "Snapshot" casing).
@@clientName(
  BackupOptions.backupCopyImmediately,
  "ShouldCopyImmediately",
  "csharp"
);
@@clientName(
  BackupOptions.runSnapShotBackup,
  "ShouldRunSnapshotBackup",
  "csharp"
);
@@clientName(
  BackupOptions.notifyUserOnJobCompletion,
  "ShouldNotifyUserOnJobCompletion",
  "csharp"
);
@@clientName(
  RestoreProtectionItemRequest.inPlaceRestore,
  "IsInPlaceRestore",
  "csharp"
);
@@clientName(
  VmInfo.powerOnVmAfterRestore,
  "ShouldPowerOnVmAfterRestore",
  "csharp"
);
@@clientName(VmInfo.attachAndSwapOsDisk, "ShouldAttachAndSwapOsDisk", "csharp");

// [CSPELL] "vmtags" is flagged as an unknown word; use the compound "VmTags"
// so the generated .NET name splits into known words.
@@clientName(VmInfo.vmtags, "VmTags", "csharp");

// [ACRONYM] "BackUp" should be treated as the compound word "Backup".
// [Contextual naming] "BackupType" is too generic; prefix with the RP name.
@@clientName(BackUpType, "CommvaultBackupType", "csharp");

// [Contextual naming] Avoid shadowing the .NET BCL type System.DayOfWeek.
@@clientName(DayOfWeek, "CommvaultDayOfWeek", "csharp");

// [Contextual naming] "Operator" is too generic and collides easily in user code.
@@clientName(Operator, "CommvaultMatchOperator", "csharp");

// The "Equals" union member collides with the generated value-type's Equals(object) method.
@@clientName(Operator.Equals, "Equal", "csharp");

// [RESNAME001] The "Storage" resource trio (StorageCollection/StorageData/StorageResource)
// lacks RP/domain context after stripping reserved suffixes and collides with
// Azure.ResourceManager.Storage types; prefix the whole trio with the RP name.
@@clientName(Storage, "CommvaultStorage", "csharp");

// [Contextual naming] Add RP/domain context to type names that are too generic on their own.
@@clientName(RoleAssignment, "CommvaultRoleAssignment", "csharp");
@@clientName(Rule, "ProtectionGroupRule", "csharp");
@@clientName(Schedule, "CommvaultBackupSchedule", "csharp");
@@clientName(EntityInfo, "CommvaultEntityInfo", "csharp");
@@clientName(PlanProperties, "CommvaultPlanProperties", "csharp");
@@clientName(LiftrBase.OfferDetails, "CommvaultOfferDetails", "csharp");
@@clientName(LiftrBase.UserDetails, "CommvaultUserDetails", "csharp");

// [Contextual naming] Generic/unprefixed type names are unclear in IntelliSense
// without relying on the namespace; add RP/domain-context prefixes.
@@clientName(EntityType, "CommvaultEntityType", "csharp");
@@clientName(Frequency, "CommvaultBackupFrequency", "csharp");
@@clientName(MatchType, "ProtectionGroupMatchType", "csharp");
@@clientName(ProtectionStatus, "CommvaultProtectionStatus", "csharp");
@@clientName(RestoreType, "CommvaultRestoreType", "csharp");
@@clientName(RetentionTime, "CommvaultRetentionTime", "csharp");
@@clientName(RoleName, "CommvaultRoleName", "csharp");
@@clientName(RuleProperty, "ProtectionGroupRuleProperty", "csharp");
@@clientName(StorageClassType, "CommvaultStorageClassType", "csharp");
@@clientName(StoragePlan, "CommvaultStoragePlan", "csharp");
@@clientName(StorageProperties, "CommvaultStorageProperties", "csharp");
@@clientName(StorageType, "CommvaultStorageType", "csharp");
@@clientName(Vendor, "CommvaultVendor", "csharp");

// [TYPE001] Properties that hold ARM resource IDs should be typed as
// Azure.Core.ResourceIdentifier rather than a raw string.
@@alternateType(
  SaaSData.saaSResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LatestLinkedSaaSResponse.saaSResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  SaaSResourceDetailsResponse.saaSResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  LiftrBase.MarketplaceDetails.saasResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// [TYPE003] "location" properties represent Azure region names; type them as AzureLocation.
@@alternateType(PlanProperties.location, Azure.Core.azureLocation, "csharp");
@@alternateType(
  ProtectedItemProperties.location,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(StorageProperties.location, Azure.Core.azureLocation, "csharp");
