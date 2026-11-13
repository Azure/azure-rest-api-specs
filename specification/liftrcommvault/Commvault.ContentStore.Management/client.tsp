import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Commvault.ContentStore;

// Preserve the public request name and documentation when using the ARM action template.
@@clientName(ProtectionGroups.stopBackup::parameters.body, "request");
@@doc(
  ProtectionGroups.stopBackup::parameters.body,
  "The body type of the operation request."
);

@@clientName(
  Commvault.ContentStore,
  "CommvaultContentStoreMgmtClient",
  "python"
);

// [SUFFIX002] The "Request" suffix is reserved for HTTP protocol types; use "Content" for request-body models.
@@clientName(
  ActivateSaaSParameterRequest,
  "CommvaultSaasActivationContent",
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
@@clientName(LatestLinkedSaaSResponse, "LatestLinkedSaasResult", "csharp");
@@clientName(SaaSResourceDetailsResponse, "SaasResourceDetailsData", "csharp");

// [AZC0032] Non-resource models must not end with "Data"; give it a descriptive service-specific name.
@@clientName(SaaSData, "CommvaultSaasDetails", "csharp");

// [SUFFIX003] The "Options" suffix is reserved for client configuration types.
@@clientName(BackupOptions, "CommvaultBackupConfiguration", "csharp");

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

@@clientName(VmInfo.vmtags, "Tags", "csharp");

// [ACRONYM] "BackUp" should be treated as the compound word "Backup".
// [Contextual naming] "BackupType" is too generic; prefix with the RP name.
@@clientName(BackUpType, "CommvaultBackupType", "csharp");

// [Contextual naming] Avoid shadowing the .NET BCL type System.DayOfWeek.
@@clientName(DayOfWeek, "CommvaultDayOfWeek", "csharp");

// [Contextual naming] "Operator" is too generic and collides easily in user code.
@@clientName(Operator, "CommvaultMatchOperator", "csharp");

// The "Equals" union member collides with the generated value-type's Equals(object) method.
@@clientName(Operator.Equals, "Equal", "csharp");
@@clientName(Operator.DoesNotContains, "DoesNotContain", "csharp");

// [RESNAME001] The "Storage" resource trio (StorageCollection/StorageData/StorageResource)
// lacks RP/domain context after stripping reserved suffixes and collides with
// Azure.ResourceManager.Storage types; prefix the whole trio with the RP name.
@@clientName(Storage, "CommvaultStorage", "csharp");

// [Contextual naming] Add RP/domain context to type names that are too generic on their own.
@@clientName(RoleAssignment, "CommvaultRoleAssignment", "csharp");
@@clientName(Rule, "ProtectionGroupRule", "csharp");
@@clientName(Schedule, "CommvaultBackupSchedule", "csharp");
@@clientName(EntityInfo, "CommvaultRolePrincipal", "csharp");
@@clientName(PlanProperties, "CommvaultPlanProperties", "csharp");
@@clientName(LiftrBase.OfferDetails, "CommvaultOfferDetails", "csharp");
@@clientName(LiftrBase.UserDetails, "CommvaultUserDetails", "csharp");

// [Contextual naming] Generic/unprefixed type names are unclear in IntelliSense
// without relying on the namespace; add RP/domain-context prefixes.
@@clientName(EntityType, "CommvaultRolePrincipalType", "csharp");
@@clientName(Frequency, "CommvaultBackupFrequency", "csharp");
@@clientName(MatchType, "ProtectionGroupMatchType", "csharp");
@@clientName(ProtectionStatus, "CommvaultProtectionStatus", "csharp");
@@clientName(RestoreType, "CommvaultRestoreType", "csharp");
@@clientName(RetentionTime, "CommvaultRetentionInterval", "csharp");
@@clientName(RoleName, "CommvaultRoleName", "csharp");
@@clientName(RuleProperty, "ProtectionGroupRuleProperty", "csharp");
@@clientName(StorageClassType, "CommvaultStorageClassType", "csharp");
@@clientName(StoragePlan, "CommvaultStoragePlan", "csharp");
@@clientName(StorageProperties, "CommvaultStorageProperties", "csharp");
@@clientName(StorageType, "CommvaultStorageType", "csharp");
@@clientName(Vendor, "CommvaultVendor", "csharp");

// [TYPE001] Properties that hold ARM resource IDs should be typed as
// Azure.Core.ResourceIdentifier rather than a raw string.
@@clientName(SaaSData.saaSResourceId, "SaasResourceId", "csharp");
@@alternateType(
  SaaSData.saaSResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  LatestLinkedSaaSResponse.saaSResourceId,
  "SaasResourceId",
  "csharp"
);
@@alternateType(
  LatestLinkedSaaSResponse.saaSResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(LatestLinkedSaaSResponse.isHiddenSaaS, "IsHiddenSaas", "csharp");
@@clientName(
  SaaSResourceDetailsResponse.saaSResourceId,
  "SaasResourceId",
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

@@clientName(ActivateSaaSParameterRequest.saasGuid, "SaaSGUID", "go");
@@clientName(ActivateSaaSRequestParam.saasResourceId, "SaaSResourceID", "go");
@@clientName(
  CloudAccountProperties.roleAssignmentsOnCcaCreate,
  "RoleAssignmentsOnCCACreate",
  "go"
);

// [PR63699-1] "SaasActivationDetails" is more descriptive than the raw wire-name-derived
// "ActivateSaaSRequestParam"; the property that carries it is renamed similarly, while
// the wire name "activateSaaSRequestParam" is preserved for serialization.
@@clientName(ActivateSaaSRequestParam, "SaasActivationDetails", "csharp");
@@clientName(
  ActivateSaaSParameterRequest.activateSaaSRequestParam,
  "ActivationDetails",
  "csharp"
);

// [PR63699-2] The service parses saasResourceId as a full ARM resource id
// (subscription/resourceGroup/resourceName), not a GUID or short name; type it accordingly.
// Remains optional.
@@alternateType(
  ActivateSaaSRequestParam.saasResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// [PR63699-3] The service requires saasGuid as a GUID (CommvaultActivateSaaSRequest.SaasGuid
// is a .NET Guid on the backend); map it to the actual GUID wire value. Required/wire name preserved.
@@alternateType(
  ActivateSaaSParameterRequest.saasGuid,
  Azure.Core.uuid,
  "csharp"
);

// [PR63699-4] "roleAssignmentsOnCcaCreate" is an awkward abbreviation; rename for readability
// while preserving create-only visibility and the wire name.
@@clientName(
  CloudAccountProperties.roleAssignmentsOnCcaCreate,
  "RoleAssignmentsOnCreate",
  "csharp"
);

// [PR63699-5] "BackUp" should read as the compound word "Backup"; keep the read-only
// int64 wire type and wire name unchanged.
@@clientName(
  ProtectionGroupProperties.lastBackUpTime,
  "LastBackupTime",
  "csharp"
);
@@clientName(
  ProtectedItemProperties.lastBackUpTime,
  "LastBackupTime",
  "csharp"
);

// Use descriptive names consistently for related models and operations.
@@clientName(BackupLevel, "CommvaultBackupLevel", "csharp");
@@clientName(BackupRuleType, "CommvaultBackupRuleType", "csharp");
@@clientName(CloudAccountIdentityUpdate, "CloudAccountIdentityPatch", "csharp");
@@clientName(
  CloudAccountMarketplaceUpdate,
  "CloudAccountMarketplacePatch",
  "csharp"
);
@@clientName(
  CloudAccountOfferDetailsUpdate,
  "CloudAccountOfferDetailsPatch",
  "csharp"
);
@@clientName(CloudAccountUserUpdate, "CloudAccountUserPatch", "csharp");
@@clientName(CompanyProfile, "CommvaultCompanyProfile", "csharp");
@@clientName(
  LiftrBase.MarketplaceDetails,
  "CommvaultMarketplaceDetails",
  "csharp"
);
@@clientName(
  ExtendedRetentionTime,
  "CommvaultExtendedRetentionPolicy",
  "csharp"
);
@@clientName(
  ProtectionGroupResources,
  "ProtectionGroupResourceSelection",
  "csharp"
);
@@clientName(RestorePoints, "ProtectedItemRestorePoints", "csharp");
@@clientName(VmInfo, "CommvaultVmRestoreSettings", "csharp");
@@clientName(VmListItem, "CommvaultVmReference", "csharp");
@@clientName(VmTag, "CommvaultVmTag", "csharp");
@@clientName(WeeklyDays, "CommvaultScheduleDayOfWeek", "csharp");

@@clientName(
  SaaSOperationGroup.activateResource,
  "ActivateSaasResource",
  "csharp"
);
@@clientName(CloudAccounts.latestLinkedSaaS, "GetLatestLinkedSaas", "csharp");
@@clientName(CloudAccounts.linkSaaS, "LinkSaas", "csharp");
@@clientName(
  ProtectedItemsOperationGroup.countByProtectionGroups,
  "CountProtectedItems",
  "csharp"
);

@@clientName(
  BackupProtectionGroupRequest.backupOptions,
  "BackupConfiguration",
  "csharp"
);
@@clientName(BackupProtectionGroupRequest.vmList, "VmList", "csharp");
@@clientName(
  ProtectionGroupProperties.resources,
  "ResourceSelection",
  "csharp"
);
@@clientName(
  ProtectionGroupProperties.numberOfProtectedItems,
  "ProtectedItemCount",
  "csharp"
);
@@clientName(
  ProtectionGroupResources.manual,
  "ManuallySelectedItems",
  "csharp"
);
@@clientName(RoleMappingProperties.roles, "RoleAssignments", "csharp");
@@clientName(RoleAssignment.entities, "Principals", "csharp");
@@clientName(EntityInfo.entityType, "PrincipalType", "csharp");
@@clientName(Retention.numberOfSnapshots, "SnapshotCount", "csharp");
@@clientName(Schedule.runsEvery, "Interval", "csharp");
@@clientName(Schedule.weeklyDays, "DaysOfWeek", "csharp");
@@clientName(StoragePlan.retentionTime, "RetentionInterval", "csharp");
@@clientName(
  ExtendedRetentionTime.retentionTime,
  "RetentionInterval",
  "csharp"
);
@@clientName(
  StoragePlan.extendedRetention,
  "ExtendedRetentionPolicies",
  "csharp"
);
@@clientName(StorageProperties.class, "StorageClass", "csharp");
@@clientName(
  ProtectedItemProperties.resourceGroup,
  "ResourceGroupName",
  "csharp"
);
@@clientName(VmListItem.vmGuid, "VmGuid", "csharp");
@@clientName(VmInfo.sourceVmGuid, "SourceVmGuid", "csharp");
@@clientName(VmInfo.targetVmGuid, "TargetVmGuid", "csharp");
@@clientName(VmInfo.resourceGroup, "ResourceGroupName", "csharp");
@@clientName(VmInfo.networkId, "VirtualNetworkId", "csharp");
@@clientName(
  RestoreProtectionItemRequest.vmDestinationInfo,
  "VmDestinationInfo",
  "csharp"
);
@@clientName(VmDestinationInfo.vmInfoList, "VmInfoList", "csharp");
@@clientName(RestoreProtectionItemRequest.toTime, "RestorePointTime", "csharp");
@@clientName(LiftrBase.UserDetails.upn, "UserPrincipalName", "csharp");
@@clientName(CloudAccountUserUpdate.upn, "UserPrincipalName", "csharp");
@@clientName(ActivateSaaSParameterRequest.saasGuid, "SaasGuid", "csharp");
@@clientName(
  ActivateSaaSRequestParam.saasResourceId,
  "SaasResourceId",
  "csharp"
);
@@clientName(
  LiftrBase.MarketplaceDetails.saasResourceId,
  "SaasResourceId",
  "csharp"
);
@@clientName(
  CloudAccountMarketplaceUpdate.saasResourceId,
  "SaasResourceId",
  "csharp"
);

@@clientName(RoleName.BackupAdmin, "BackupAdministrator", "csharp");
@@clientName(RoleName.SecurityAdmin, "SecurityAdministrator", "csharp");
@@clientName(BackupRuleType.AllFulls, "AllFullBackups", "csharp");
@@clientName(BackupRuleType.HourlyFulls, "HourlyFullBackups", "csharp");
@@clientName(BackupRuleType.DailyFulls, "DailyFullBackups", "csharp");
@@clientName(BackupRuleType.WeeklyFulls, "WeeklyFullBackups", "csharp");
@@clientName(BackupRuleType.MonthlyFulls, "MonthlyFullBackups", "csharp");
@@clientName(BackupRuleType.QuarterlyFulls, "QuarterlyFullBackups", "csharp");
@@clientName(BackupRuleType.HalfYearlyFulls, "HalfYearlyFullBackups", "csharp");
@@clientName(BackupRuleType.YearlyFulls, "YearlyFullBackups", "csharp");
