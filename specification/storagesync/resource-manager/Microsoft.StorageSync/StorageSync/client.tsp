import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;
using Microsoft.StorageSync;

@@scope(locationOperationStatusGet, "!csharp");
@@scope(OperationStatusOperationGroup.get, "!csharp");
@@scope(Operations.list, "!csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Azure.ResourceManager.CommonTypes.PrivateLinkResource.properties,
  "csharp"
);

@@clientName(RestoreFileSpec.isdir, "IsDirectory", "csharp");
@@clientName(CloudEndpointProperties.backupEnabled,
  "IsBackupEnabled",
  "csharp"
);
@@alternateType(CloudEndpointProperties.storageAccountResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CloudEndpointProperties.storageAccountTenantId, uuid, "csharp");
@@clientName(PostBackupResponse, "CloudEndpointPostBackupResult", "csharp");
@@clientName(BackupRequest, "CloudEndpointBackupContent", "csharp");
@@clientName(SyncGroup, "StorageSyncGroup", "csharp");
@@alternateType(SyncGroupProperties.uniqueId, uuid, "csharp");
@@clientName(CheckNameAvailabilityParameters,
  "StorageSyncNameAvailabilityContent",
  "csharp"
);
@@clientName(CheckNameAvailabilityParameters.type, "ResourceType", "csharp");
@@clientName(CheckNameAvailabilityResult,
  "StorageSyncNameAvailabilityResult",
  "csharp"
);
@@clientName(CheckNameAvailabilityResult.nameAvailable,
  "IsNameAvailable",
  "csharp"
);
@@clientName(NameAvailabilityReason,
  "StorageSyncNameUnavailableReason",
  "csharp"
);
@@clientName(Type, "StorageSyncResourceType", "csharp");
@@clientName(CloudEndpointChangeEnumerationActivity.totalSizeBytes,
  "TotalSizeInBytes",
  "csharp"
);
@@clientName(CloudEndpointChangeEnumerationStatus.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(CloudEndpointChangeEnumerationActivity.startedTimestamp,
  "StartedOn",
  "csharp"
);
@@clientName(CloudEndpointChangeEnumerationActivity.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(ServerEndpointBackgroundDataDownloadActivity.startedTimestamp,
  "StartedOn",
  "csharp"
);
@@clientName(CloudEndpointLastChangeEnumerationStatus.namespaceSizeBytes,
  "NamespaceSizeInBytes",
  "csharp"
);
@@clientName(CloudEndpointLastChangeEnumerationStatus.startedTimestamp,
  "StartedOn",
  "csharp"
);
@@clientName(CloudEndpointLastChangeEnumerationStatus.completedTimestamp,
  "CompletedOn",
  "csharp"
);
@@clientName(CloudTieringSpaceSavings.volumeSizeBytes,
  "VolumeSizeInBytes",
  "csharp"
);
@@clientName(CloudTieringSpaceSavings.cachedSizeBytes,
  "CachedSizeInBytes",
  "csharp"
);
@@clientName(CloudTieringSpaceSavings.spaceSavingsBytes,
  "SpaceSavingsInBytes",
  "csharp"
);
@@clientName(CloudTieringSpaceSavings.totalSizeCloudBytes,
  "CloudTotalSizeInBytes",
  "csharp"
);
@@clientName(ServerEndpointCloudTieringStatus.healthLastUpdatedTimestamp,
  "HealthLastUpdatedOn",
  "csharp"
);
@@clientName(ServerAuthType, "StorageSyncServerAuthType", "csharp");
@@clientName(ServerProvisioningStatus,
  "StorageSyncServerProvisioningStatus",
  "csharp"
);
@@clientName(ServerEndpointProvisioningStatus,
  "StorageSyncServerEndpointProvisioningStatus",
  "csharp"
);
@@clientName(RegisteredServerProperties.agentVersionExpirationDate,
  "AgentVersionExpireOn",
  "csharp"
);
@@clientName(WorkflowProperties.createdTimestamp, "CreatedOn", "csharp");
@@clientName(WorkflowProperties.lastStatusTimestamp,
  "LastStatusUpdatedOn",
  "csharp"
);
@@clientName(ServerEndpointCloudTieringStatus.healthLastUpdatedTimestamp,
  "HealthLastUpdatedOn",
  "csharp"
);
@@clientName(RegisteredServerProperties.identity, "UseIdentity", "csharp");
@@alternateType(RegisteredServerProperties.applicationId, uuid, "csharp");
@@alternateType(RegisteredServerProperties.latestApplicationId, uuid, "csharp");
@@clientName(RegisteredServerCreateParametersProperties.identity,
  "UseIdentity",
  "csharp"
);
@@alternateType(RegisteredServerCreateParametersProperties.applicationId,
  uuid,
  "csharp"
);
@@clientName(RegisteredServerUpdateProperties.identity,
  "UseIdentity",
  "csharp"
);
@@alternateType(RegisteredServerUpdateProperties.applicationId, uuid, "csharp");
@@clientName(PrivateEndpointConnection,
  "StorageSyncPrivateEndpointConnection",
  "csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

@@clientName(Workflow, "StorageSyncWorkflow", "csharp");
@@alternateType(WorkflowProperties.lastOperationId, uuid, "csharp");
@@clientName(WorkflowStatus, "StorageSyncWorkflowStatus", "csharp");
@@clientName(FeatureStatus, "StorageSyncFeatureStatus", "csharp");
@@clientName(OperationDirection, "StorageSyncOperationDirection", "csharp");
@@clientName(RegisteredServer, "StorageSyncRegisteredServer", "csharp");
@@clientName(RegisteredServerProperties.lastHeartBeat,
  "LastHeartbeat",
  "csharp"
);
@@alternateType(RegisteredServerProperties.clusterId, uuid, "csharp");
@@alternateType(RegisteredServerProperties.serverId, uuid, "csharp");
@@alternateType(RegisteredServerProperties.storageSyncServiceUid,
  uuid,
  "csharp"
);
@@alternateType(RegisteredServerProperties.discoveryEndpointUri, url, "csharp");
@@alternateType(RegisteredServerProperties.managementEndpointUri,
  url,
  "csharp"
);
@@alternateType(RegisteredServerProperties.monitoringEndpointUri,
  url,
  "csharp"
);
@@alternateType(RegisteredServerProperties.serverCertificate,
  unknown,
  "csharp"
);
@@alternateType(RegisteredServerProperties.resourceLocation,
  azureLocation,
  "csharp"
);
@@alternateType(RegisteredServerProperties.serviceLocation,
  azureLocation,
  "csharp"
);
@@clientName(ServerEndpoint, "StorageSyncServerEndpoint", "csharp");
@@alternateType(ServerEndpointProperties.offlineDataTransferStorageAccountResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(ServerEndpointProperties.offlineDataTransferStorageAccountTenantId,
  uuid,
  "csharp"
);
@@alternateType(ServerEndpointProperties.serverResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageSyncServiceProperties.storageSyncServiceUid,
  uuid,
  "csharp"
);
@@clientName(RegisteredServerCreateParameters,
  "StorageSyncRegisteredServerCreateOrUpdateContent",
  "csharp"
);
@@clientName(RegisteredServerCreateParametersProperties.lastHeartBeat,
  "LastHeartbeat",
  "csharp"
);
@@alternateType(RegisteredServerCreateParametersProperties.clusterId,
  uuid,
  "csharp"
);
@@alternateType(RegisteredServerCreateParametersProperties.serverCertificate,
  unknown,
  "csharp"
);
@@alternateType(RegisteredServerCreateParametersProperties.serverId,
  uuid,
  "csharp"
);
@@clientName(ServerEndpointCreateParameters,
  "StorageSyncServerEndpointCreateOrUpdateContent",
  "csharp"
);
@@alternateType(ServerEndpointCreateParametersProperties.serverResourceId,
  armResourceIdentifier,
  "csharp"
);
@@clientName(CloudEndpointCreateParameters,
  "CloudEndpointCreateOrUpdateContent",
  "csharp"
);
@@alternateType(CloudEndpointCreateParametersProperties.storageAccountResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(CloudEndpointCreateParametersProperties.storageAccountTenantId,
  uuid,
  "csharp"
);
@@clientName(PostRestoreRequest, "PostRestoreContent", "csharp");
@@alternateType(PostRestoreRequest.azureFileShareUri, url, "csharp");
@@alternateType(PostRestoreRequest.sourceAzureFileShareUri, url, "csharp");
@@clientName(PreRestoreRequest, "PreRestoreContent", "csharp");
@@alternateType(PreRestoreRequest.azureFileShareUri, url, "csharp");
@@alternateType(PreRestoreRequest.sourceAzureFileShareUri, url, "csharp");
@@clientName(TriggerChangeDetectionParameters,
  "TriggerChangeDetectionContent",
  "csharp"
);
@@clientName(RecallActionParameters, "RecallActionContent", "csharp");
@@clientName(StorageSyncServiceCreateParameters,
  "StorageSyncServiceCreateOrUpdateContent",
  "csharp"
);
@@clientName(TriggerRolloverRequest, "TriggerRolloverContent", "csharp");
@@alternateType(TriggerRolloverRequest.serverCertificate, unknown, "csharp");
@@clientName(SyncGroupCreateParameters,
  "StorageSyncGroupCreateOrUpdateContent",
  "csharp"
);
@@clientName(CloudEndpoints.restoreheartbeat, "RestoreHeartbeat", "csharp");
@@clientName(CloudTieringCachePerformance.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(CloudTieringDatePolicyStatus.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(CloudTieringFilesNotTiering.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(CloudTieringLowDiskMode.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(CloudTieringSpaceSavings.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(CloudTieringVolumeFreeSpacePolicyStatus.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(ServerEndpointCloudTieringStatus.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(ServerEndpointRecallStatus.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(ServerEndpointSyncStatus.lastUpdatedTimestamp,
  "LastUpdatedOn",
  "csharp"
);

@@clientName(CloudEndpoints.postBackup::parameters.body, "content", "csharp");
@@clientName(CloudEndpoints.postRestore::parameters.body, "content", "csharp");
@@clientName(CloudEndpoints.preBackup::parameters.body, "content", "csharp");
@@clientName(CloudEndpoints.preRestore::parameters.body, "content", "csharp");
@@clientName(CloudEndpoints.triggerChangeDetection::parameters.body,
  "content",
  "csharp"
);
@@clientName(CloudEndpoints.create::parameters.resource, "content", "csharp");
@@clientName(StorageSyncServices.create::parameters.resource,
  "content",
  "csharp"
);
@@clientName(SyncGroups.create::parameters.resource, "content", "csharp");
@@clientName(StorageSyncServicesOperationGroup.checkNameAvailability::parameters.body,
  "content",
  "csharp"
);
@@clientName(RegisteredServers.create::parameters.resource,
  "content",
  "csharp"
);
@@clientName(RegisteredServers.update::parameters.properties,
  "content",
  "csharp"
);
@@clientName(RegisteredServers.triggerRollover::parameters.body,
  "content",
  "csharp"
);
@@clientName(ServerEndpoints.create::parameters.resource, "content", "csharp");
@@clientName(ServerEndpoints.recallAction::parameters.body,
  "content",
  "csharp"
);
@@clientName(ServerEndpoints.update::parameters.properties,
  "content",
  "csharp"
);
@@clientName(StorageSyncServices.update::parameters.properties,
  "content",
  "csharp"
);

@@clientName(StorageSyncServicesOperationGroup.checkNameAvailability,
  "CheckStorageSyncNameAvailability",
  "csharp"
);

@@usage(ServerEndpoint, Usage.input, "csharp");
@@usage(CloudEndpoint, Usage.input, "csharp");
@@usage(RegisteredServer, Usage.input, "csharp");
@@usage(StorageSyncService, Usage.input, "csharp");
@@usage(Workflow, Usage.input, "csharp");
