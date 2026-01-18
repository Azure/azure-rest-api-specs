import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.Core;
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

@@clientName(AbsoluteDeleteOption,
  "DataProtectionBackupAbsoluteDeleteSetting",
  "csharp"
);
@@clientName(AbsoluteMarker, "BackupAbsoluteMarker", "csharp");
@@clientName(AdHocBackupRuleOptions, "AdhocBackupRules", "csharp");
@@clientName(AdHocBackupRuleOptions.triggerOption, "BackupTrigger", "csharp");
@@clientName(AdhocBackupTriggerOption, "AdhocBackupTriggerSetting", "csharp");
@@clientName(AdhocBasedTaggingCriteria,
  "AdhocBasedBackupTaggingCriteria",
  "csharp"
);
@@clientName(AdhocBasedTriggerContext,
  "AdhocBasedBackupTriggerContext",
  "csharp"
);
@@clientName(AdhocBasedTriggerContext.taggingCriteria,
  "AdhocBackupRetention",
  "csharp"
);
@@clientName(AdlsBlobBackupDatasourceParameters,
  "AdlsBlobBackupDataSourceSettings",
  "csharp"
);
@@clientName(AKSVolumeTypes, "DataProtectionAksVolumeType", "csharp");
@@clientName(AlertsState, "AzureMonitorAlertsState", "csharp");
@@clientName(AuthCredentials, "DataProtectionBackupAuthCredentials", "csharp");
@@clientName(AzureBackupDiscreteRecoveryPoint,
  "DataProtectionBackupDiscreteRecoveryPointProperties",
  "csharp"
);
@@clientName(AzureBackupDiscreteRecoveryPoint.expiryTime, "ExpireOn", "csharp");
@@clientName(AzureBackupDiscreteRecoveryPoint.recoveryPointTime,
  "RecoverOn",
  "csharp"
);
@@clientName(AzureBackupFindRestorableTimeRangesRequest,
  "BackupFindRestorableTimeRangeContent",
  "csharp"
);
@@alternateType(AzureBackupFindRestorableTimeRangesRequest.endTime,
  utcDateTime,
  "csharp"
);
@@alternateType(AzureBackupFindRestorableTimeRangesRequest.startTime,
  utcDateTime,
  "csharp"
);
@@clientName(AzureBackupFindRestorableTimeRangesResponse,
  "BackupFindRestorableTimeRangeResultProperties",
  "csharp"
);
@@clientName(AzureBackupFindRestorableTimeRangesResponseResource,
  "BackupFindRestorableTimeRangeResult",
  "csharp"
);
@@clientName(AzureBackupJob, "DataProtectionBackupJobProperties", "csharp");
@@alternateType(AzureBackupJob.backupInstanceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(AzureBackupJob.dataSourceId, armResourceIdentifier, "csharp");
@@alternateType(AzureBackupJob.dataSourceLocation, azureLocation, "csharp");
@@alternateType(AzureBackupJob.duration, duration, "csharp");
@@alternateType(AzureBackupJob.policyId, armResourceIdentifier, "csharp");
@@clientName(AzureBackupJob.progressEnabled, "IsProgressEnabled", "csharp");
@@clientName(AzureBackupJobResource, "DataProtectionBackupJob", "csharp");
@@clientName(AzureBackupParams, "DataProtectionBackupSettings", "csharp");
@@clientName(AzureBackupRecoveryPoint,
  "DataProtectionBackupRecoveryPointProperties",
  "csharp"
);
@@clientName(AzureBackupRecoveryPointBasedRestoreRequest,
  "BackupRecoveryPointBasedRestoreContent",
  "csharp"
);
@@clientName(AzureBackupRecoveryPointResource,
  "DataProtectionBackupRecoveryPoint",
  "csharp"
);
@@clientName(AzureBackupRecoveryTimeBasedRestoreRequest,
  "BackupRecoveryTimeBasedRestoreContent",
  "csharp"
);
@@alternateType(AzureBackupRecoveryTimeBasedRestoreRequest.recoveryPointTime,
  utcDateTime,
  "csharp"
);
@@clientName(AzureBackupRehydrationRequest,
  "BackupRehydrationContent",
  "csharp"
);
@@alternateType(AzureBackupRehydrationRequest.rehydrationRetentionDuration,
  duration,
  "csharp"
);
@@clientName(AzureBackupRestoreRequest, "BackupRestoreContent", "csharp");
@@alternateType(AzureBackupRestoreRequest.sourceResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureBackupRestoreWithRehydrationRequest,
  "BackupRestoreWithRehydrationContent",
  "csharp"
);
@@alternateType(AzureBackupRestoreWithRehydrationRequest.rehydrationRetentionDuration,
  duration,
  "csharp"
);
@@clientName(AzureBackupRule, "DataProtectionBackupRule", "csharp");
@@clientName(AzureMonitorAlertSettings.alertsForAllJobFailures,
  "AlertSettingsForAllJobFailures",
  "csharp"
);
@@clientName(AzureOperationalStoreParameters,
  "OperationalDataStoreSettings",
  "csharp"
);
@@alternateType(AzureOperationalStoreParameters.resourceGroupId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(AzureRetentionRule, "DataProtectionRetentionRule", "csharp");
@@clientName(BackupCriteria, "DataProtectionBackupCriteria", "csharp");
@@clientName(BackupDatasourceParameters, "BackupDataSourceSettings", "csharp");
@@clientName(BackupInstance,
  "DataProtectionBackupInstanceProperties",
  "csharp"
);
@@clientName(BackupInstance.datasourceAuthCredentials,
  "DataSourceAuthCredentials",
  "csharp"
);
@@clientName(BackupInstanceResource, "DataProtectionBackupInstance", "csharp");
@@clientName(BackupParameters, "DataProtectionBackupSettingsBase", "csharp");
@@clientName(BackupPolicy, "RuleBasedBackupPolicy", "csharp");
@@clientName(BackupSchedule, "DataProtectionBackupSchedule", "csharp");
@@clientName(BackupVault, "DataProtectionBackupVaultProperties", "csharp");
@@alternateType(BackupVault.replicatedRegions, azureLocation, "csharp");
@@clientName(BackupVaultResource, "DataProtectionBackupVault", "csharp");
@@clientName(BaseBackupPolicy,
  "DataProtectionBackupPolicyPropertiesBase",
  "csharp"
);
@@clientName(BaseBackupPolicy.datasourceTypes, "DataSourceTypes", "csharp");
@@clientName(BaseBackupPolicyResource, "DataProtectionBackupPolicy", "csharp");
@@clientName(BasePolicyRule, "DataProtectionBasePolicyRule", "csharp");
@@clientName(BlobBackupDatasourceParameters,
  "BlobBackupDataSourceSettings",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequest,
  "DataProtectionBackupNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityRequest.type, "-", "csharp");
@@clientName(CheckNameAvailabilityResult,
  "DataProtectionBackupNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@alternateType(ClientDiscoveryForLogSpecification.blobDuration,
  duration,
  "csharp"
);
@@clientName(CmkKekIdentity, "BackupVaultCmkKekIdentity", "csharp");
@@clientName(CopyOnExpiryOption, "CopyOnExpirySetting", "csharp");
@@clientName(CopyOption, "DataProtectionBackupCopySetting", "csharp");
@@alternateType(CrossRegionRestoreDetails.sourceBackupInstanceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CrossRegionRestoreDetails.sourceRegion,
  azureLocation,
  "csharp"
);
@@alternateType(CrossRegionRestoreJobRequest.jobId, uuid, "csharp");
@@alternateType(CrossRegionRestoreJobRequest.sourceBackupVaultId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CrossRegionRestoreJobRequest.sourceRegion,
  azureLocation,
  "csharp"
);
@@alternateType(CrossRegionRestoreJobsRequest.sourceBackupVaultId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CrossRegionRestoreJobsRequest.sourceRegion,
  azureLocation,
  "csharp"
);
@@clientName(CrossSubscriptionRestoreState,
  "DataProtectionBackupCrossSubscriptionRestoreState",
  "csharp"
);
@@clientName(CustomCopyOption, "CustomCopySetting", "csharp");
@@alternateType(CustomCopyOption.duration, duration, "csharp");
@@clientName(Datasource, "DataSourceInfo", "csharp");
@@clientName(Datasource.datasourceType, "DataSourceType", "csharp");
@@alternateType(Datasource.resourceID, armResourceIdentifier, "csharp");
@@alternateType(Datasource.resourceLocation, azureLocation, "csharp");
@@clientName(Datasource.resourceType, "-", "csharp");
@@clientName(Datasource.resourceUri, "ResourceUriString", "csharp");
@@clientName(DatasourceSet, "DataSourceSetInfo", "csharp");
@@clientName(DatasourceSet.datasourceType, "DataSourceType", "csharp");
@@alternateType(DatasourceSet.resourceID, armResourceIdentifier, "csharp");
@@alternateType(DatasourceSet.resourceLocation, azureLocation, "csharp");
@@clientName(DatasourceSet.resourceType, "-", "csharp");
@@clientName(DatasourceSet.resourceUri, "ResourceUriString", "csharp");
@@clientName(DataStoreParameters, "DataStoreSettings", "csharp");
@@clientName(Day, "DataProtectionBackupDay", "csharp");
@@clientName(DayOfWeek, "DataProtectionBackupDayOfWeek", "csharp");
@@clientName(DeletedBackupInstance,
  "DeletedDataProtectionBackupInstanceProperties",
  "csharp"
);
@@clientName(DeletedBackupInstanceResource,
  "DeletedDataProtectionBackupInstance",
  "csharp"
);
@@clientName(DeleteOption, "DataProtectionBackupDeleteSetting", "csharp");
@@alternateType(DeleteOption.duration, duration, "csharp");
@@clientName(DeletionInfo, "BackupInstanceDeletionInfo", "csharp");
@@alternateType(DeletionInfo.billingEndDate, utcDateTime, "csharp");
@@alternateType(DeletionInfo.deletionTime, utcDateTime, "csharp");
@@alternateType(DeletionInfo.scheduledPurgeTime, utcDateTime, "csharp");
@@clientName(EncryptionSettings, "BackupVaultEncryptionSettings", "csharp");
@@clientName(EncryptionState, "BackupVaultEncryptionState", "csharp");
@@clientName(ExistingResourcePolicy,
  "KubernetesClusterRestoreExistingResourcePolicy",
  "csharp"
);
@@clientName(FeatureSettings, "BackupVaultFeatureSettings", "csharp");
@@clientName(FeatureType, "BackupSupportedFeatureType", "csharp");
@@clientName(FeatureValidationRequest,
  "BackupFeatureValidationContent",
  "csharp"
);
@@clientName(FeatureValidationRequestBase,
  "BackupFeatureValidationContentBase",
  "csharp"
);
@@clientName(FeatureValidationResponse,
  "BackupFeatureValidationResult",
  "csharp"
);
@@clientName(FeatureValidationResponseBase,
  "BackupFeatureValidationResultBase",
  "csharp"
);
@@alternateType(FetchSecondaryRPsRequestParameters.sourceBackupInstanceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(FetchSecondaryRPsRequestParameters.sourceRegion,
  azureLocation,
  "csharp"
);
@@clientName(IdentityDetails, "DataProtectionIdentityDetails", "csharp");
@@alternateType(IdentityDetails.userAssignedIdentityArmUrl,
  armResourceIdentifier,
  "csharp"
);
@@clientName(IdentityType, "BackupVaultCmkKekIdentityType", "csharp");
@@clientName(ImmediateCopyOption, "ImmediateCopySetting", "csharp");
@@clientName(ImmutabilityState, "BackupVaultImmutabilityState", "csharp");
@@clientName(InfrastructureEncryptionState,
  "BackupVaultInfrastructureEncryptionState",
  "csharp"
);
@@clientName(JobExtendedInfo, "BackupJobExtendedInfo", "csharp");
@@clientName(JobSubTask, "BackupJobSubTask", "csharp");
@@clientName(KubernetesClusterBackupDatasourceParameters,
  "KubernetesClusterBackupDataSourceSettings",
  "csharp"
);
@@clientName(KubernetesClusterBackupDatasourceParameters.includeClusterScopeResources,
  "IsClusterScopeResourcesIncluded",
  "csharp"
);
@@clientName(KubernetesClusterBackupDatasourceParameters.snapshotVolumes,
  "IsSnapshotVolumesEnabled",
  "csharp"
);
@@clientName(KubernetesClusterRestoreCriteria.includeClusterScopeResources,
  "IsClusterScopeResourcesIncluded",
  "csharp"
);
@@clientName(Month, "DataProtectionBackupMonth", "csharp");
@@clientName(NamespacedNameResource, "NamespacedName", "csharp");
@@clientName(OperationExtendedInfo,
  "DataProtectionOperationExtendedInfo",
  "csharp"
);
@@clientName(OperationJobExtendedInfo,
  "DataProtectionOperationJobExtendedInfo",
  "csharp"
);
@@clientName(OperationJobExtendedInfo.jobId, "JobIdentifier", "csharp");
@@clientName(PatchBackupVaultInput,
  "DataProtectionBackupVaultPatchProperties",
  "csharp"
);
@@clientName(PolicyInfo, "BackupInstancePolicyInfo", "csharp");
@@alternateType(PolicyInfo.policyId, armResourceIdentifier, "csharp");
@@clientName(PolicyParameters, "BackupInstancePolicySettings", "csharp");
@@clientName(PolicyParameters.backupDatasourceParametersList,
  "BackupDataSourceParametersList",
  "csharp"
);
@@clientName(ProtectionStatusDetails,
  "BackupInstanceProtectionStatusDetails",
  "csharp"
);
@@clientName(ProvisioningState,
  "DataProtectionBackupProvisioningState",
  "csharp"
);
@@clientName(RecoveryOption, "RecoverySetting", "csharp");
@@clientName(RecoveryPointCompletionState,
  "DataProtectionBackupRecoveryPointCompletionState",
  "csharp"
);
@@clientName(RecoveryPointDataStoreDetails,
  "RecoveryPointDataStoreDetail",
  "csharp"
);
@@clientName(RecoveryPointDataStoreDetails.expiryTime, "ExpireOn", "csharp");
@@alternateType(RecoveryPointDataStoreDetails.id, uuid, "csharp");
@@clientName(RecoveryPointDataStoreDetails.metaData, "Metadata", "csharp");
@@clientName(RecoveryPointDataStoreDetails.rehydrationExpiryTime,
  "RehydrationExpireOn",
  "csharp"
);
@@clientName(RecoveryPointDataStoreDetails.type,
  "RecoveryPointDataStoreType",
  "csharp"
);
@@clientName(RecoveryPointDataStoreDetails.visible, "IsVisible", "csharp");
@@clientName(RehydrationPriority, "BackupRehydrationPriority", "csharp");
@@clientName(RehydrationStatus,
  "RecoveryPointDataStoreRehydrationStatus",
  "csharp"
);
@@clientName(RehydrationStatus.CREATE_IN_PROGRESS,
  "CreateInProgress",
  "csharp"
);
@@clientName(RehydrationStatus.DELETE_IN_PROGRESS,
  "DeleteInProgress",
  "csharp"
);
@@clientName(ResourceGuard, "ResourceGuardProperties", "csharp");
@@clientName(ResourceGuard.allowAutoApprovals,
  "IsAutoApprovalsAllowed",
  "csharp"
);
@@clientName(ResourceGuardOperation, "ResourceGuardOperationDetails", "csharp");
@@clientName(ResourceGuardOperation.requestResourceType, "-", "csharp");
@@clientName(ResourceGuardResource, "ResourceGuard", "csharp");
@@clientName(ResourceMoveDetails, "BackupVaultResourceMoveDetails", "csharp");
@@alternateType(ResourceMoveDetails.completionTimeUtc, utcDateTime, "csharp");
@@alternateType(ResourceMoveDetails.startTimeUtc, utcDateTime, "csharp");
@@clientName(ResourceMoveState, "BackupVaultResourceMoveState", "csharp");
@@clientName(ResourceMoveState.CommitTimedout, "CommitTimedOut", "csharp");
@@clientName(ResourceMoveState.PrepareTimedout, "PrepareTimedOut", "csharp");
@@alternateType(RestorableTimeRange.endTime, utcDateTime, "csharp");
@@alternateType(RestorableTimeRange.startTime, utcDateTime, "csharp");
@@clientName(RestoreJobRecoveryPointDetails.recoveryPointTime,
  "RecoverOn",
  "csharp"
);
@@clientName(RestoreTargetInfo.datasourceAuthCredentials,
  "DataSourceAuthCredentials",
  "csharp"
);
@@clientName(RestoreTargetInfo.datasourceInfo, "DataSourceInfo", "csharp");
@@clientName(RestoreTargetInfo.datasourceSetInfo,
  "DataSourceSetInfo",
  "csharp"
);
@@clientName(RestoreTargetInfoBase.recoveryOption, "RecoverySetting", "csharp");
@@alternateType(RestoreTargetInfoBase.restoreLocation, azureLocation, "csharp");
@@clientName(RetentionTag, "DataProtectionBackupRetentionTag", "csharp");
@@clientName(ScheduleBasedBackupCriteria.daysOfTheWeek, "DaysOfWeek", "csharp");
@@clientName(ScheduleBasedBackupCriteria.weeksOfTheMonth,
  "WeeksOfMonth",
  "csharp"
);
@@clientName(ScheduleBasedTriggerContext,
  "ScheduleBasedBackupTriggerContext",
  "csharp"
);
@@clientName(ScheduleBasedTriggerContext.taggingCriteria,
  "TaggingCriteriaList",
  "csharp"
);
@@clientName(SecretStoreResource, "SecretStoreResourceInfo", "csharp");
@@clientName(SecureScoreLevel, "BackupVaultSecureScoreLevel", "csharp");
@@clientName(SecuritySettings, "BackupVaultSecuritySettings", "csharp");
@@clientName(SoftDeleteSettings, "BackupVaultSoftDeleteSettings", "csharp");
@@clientName(SoftDeleteState, "BackupVaultSoftDeleteState", "csharp");
@@clientName(Status, "BackupInstanceProtectionStatus", "csharp");
@@clientName(StorageSetting, "DataProtectionBackupStorageSetting", "csharp");
@@clientName(StorageSetting.datastoreType, "DataStoreType", "csharp");
@@clientName(SupportedFeature, "BackupSupportedFeature", "csharp");
@@clientName(SyncBackupInstanceRequest, "BackupInstanceSyncContent", "csharp");
@@clientName(SyncType, "BackupInstanceSyncType", "csharp");
@@clientName(TaggingCriteria, "DataProtectionBackupTaggingCriteria", "csharp");
@@clientName(TargetDetails, "RestoreFilesTargetDetails", "csharp");
@@alternateType(TargetDetails.targetResourceArmId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(TriggerBackupRequest, "AdhocBackupTriggerContent", "csharp");
@@clientName(TriggerBackupRequest.backupRuleOptions, "BackupRules", "csharp");
@@clientName(TriggerContext, "DataProtectionBackupTriggerContext", "csharp");
@@clientName(UnlockDeleteRequest,
  "DataProtectionUnlockDeleteContent",
  "csharp"
);
@@clientName(UnlockDeleteResponse,
  "DataProtectionUnlockDeleteResult",
  "csharp"
);
@@clientName(ValidateForBackupRequest, "AdhocBackupValidateContent", "csharp");
@@clientName(ValidateRestoreRequestObject,
  "BackupValidateRestoreContent",
  "csharp"
);
@@clientName(ValidationType, "BackupValidationType", "csharp");
@@clientName(WeekNumber, "DataProtectionBackupWeekNumber", "csharp");
