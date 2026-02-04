import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using AzureFileStorage;

@@clientName(AccessPolicy.Start, "start");
@@clientName(AccessPolicy.Expiry, "expiry");
@@clientName(AccessPolicy.Permission, "permission");

@@clientName(CorsRule.AllowedOrigins, "allowedOrigins");
@@clientName(CorsRule.AllowedMethods, "allowedMethods");
@@clientName(CorsRule.AllowedHeaders, "allowedHeaders");
@@clientName(CorsRule.ExposedHeaders, "exposedHeaders");
@@clientName(CorsRule.MaxAgeInSeconds, "maxAgeInSeconds");

@@clientName(FilesAndDirectoriesListSegment.DirectoryItems, "directoryItems");
@@clientName(FilesAndDirectoriesListSegment.FileItems, "fileItems");

@@clientName(DirectoryItem.Name, "name");
@@clientName(DirectoryItem.FileId, "fileId");
@@clientName(DirectoryItem.Properties, "properties");
@@clientName(DirectoryItem.Attributes, "attributes");
@@clientName(DirectoryItem.PermissionKey, "permissionKey");

@@clientName(StringEncoded.Encoded, "encoded");

@@clientName(FileProperty.`Content-Length`, "contentLength");
@@clientName(FileProperty.CreationTime, "creationTime");
@@clientName(FileProperty.LastAccessTime, "lastAccessTime");
@@clientName(FileProperty.LastWriteTime, "lastWriteTime");
@@clientName(FileProperty.ChangeTime, "changeTime");
@@clientName(FileProperty.`Last-Modified`, "lastModified");
@@clientName(FileProperty.Etag, "etag");

@@clientName(FileItem.Name, "name");
@@clientName(FileItem.FileId, "fileId");
@@clientName(FileItem.Properties, "properties");
@@clientName(FileItem.Attributes, "attributes");
@@clientName(FileItem.PermissionKey, "permissionKey");

@@clientName(HandleItem.HandleId, "handleId");
@@clientName(HandleItem.Path, "path");
@@clientName(HandleItem.FileId, "fileId");
@@clientName(HandleItem.ParentId, "parentId");
@@clientName(HandleItem.SessionId, "sessionId");
@@clientName(HandleItem.ClientIp, "clientIp");
@@clientName(HandleItem.ClientName, "clientName");
@@clientName(HandleItem.OpenTime, "openTime");
@@clientName(HandleItem.LastReconnectTime, "lastReconnectTime");
@@clientName(HandleItem.AccessRightList, "accessRightList");

@@clientName(ListFilesAndDirectoriesSegmentResponse.ServiceEndpoint,
  "serviceEndpoint"
);
@@clientName(ListFilesAndDirectoriesSegmentResponse.ShareName, "shareName");
@@clientName(ListFilesAndDirectoriesSegmentResponse.ShareSnapshot,
  "shareSnapshot"
);
@@clientName(ListFilesAndDirectoriesSegmentResponse.Encoded, "encoded");
@@clientName(ListFilesAndDirectoriesSegmentResponse.DirectoryPath,
  "directoryPath"
);
@@clientName(ListFilesAndDirectoriesSegmentResponse.Prefix, "prefix");
@@clientName(ListFilesAndDirectoriesSegmentResponse.Marker, "marker");
@@clientName(ListFilesAndDirectoriesSegmentResponse.MaxResults, "maxResults");
@@clientName(ListFilesAndDirectoriesSegmentResponse.Segment, "segment");
@@clientName(ListFilesAndDirectoriesSegmentResponse.NextMarker, "nextMarker");
@@clientName(ListFilesAndDirectoriesSegmentResponse.DirectoryId, "directoryId");

@@clientName(ListHandlesResponse.HandleList, "handleList");
@@clientName(ListHandlesResponse.NextMarker, "nextMarker");

@@clientName(ListSharesResponse.ServiceEndpoint, "serviceEndpoint");
@@clientName(ListSharesResponse.Prefix, "prefix");
@@clientName(ListSharesResponse.Marker, "marker");
@@clientName(ListSharesResponse.MaxResults, "maxResults");
@@clientName(ListSharesResponse.ShareItems, "shareItems");
@@clientName(ListSharesResponse.NextMarker, "nextMarker");

@@clientName(ShareItemInternal.Name, "name");
@@clientName(ShareItemInternal.Snapshot, "snapshot");
@@clientName(ShareItemInternal.Deleted, "deleted");
@@clientName(ShareItemInternal.Version, "version");
@@clientName(ShareItemInternal.Properties, "properties");
@@clientName(ShareItemInternal.Metadata, "metadata");

@@clientName(SharePropertiesInternal.`Last-Modified`, "lastModified");
@@clientName(SharePropertiesInternal.Etag, "etag");
@@clientName(SharePropertiesInternal.Quota, "quota");
@@clientName(SharePropertiesInternal.ProvisionedIops, "provisionedIops");
@@clientName(SharePropertiesInternal.ProvisionedIngressMBps,
  "provisionedIngressMBps"
);
@@clientName(SharePropertiesInternal.ProvisionedEgressMBps,
  "provisionedEgressMBps"
);
@@clientName(SharePropertiesInternal.ProvisionedBandwidthMiBps,
  "provisionedBandwidthMiBps"
);
@@clientName(SharePropertiesInternal.NextAllowedQuotaDowngradeTime,
  "nextAllowedQuotaDowngradeTime"
);
@@clientName(SharePropertiesInternal.DeletedTime, "deletedTime");
@@clientName(SharePropertiesInternal.RemainingRetentionDays,
  "remainingRetentionDays"
);
@@clientName(SharePropertiesInternal.AccessTier, "accessTier");
@@clientName(SharePropertiesInternal.AccessTierChangeTime,
  "accessTierChangeTime"
);
@@clientName(SharePropertiesInternal.AccessTierTransitionState,
  "accessTierTransitionState"
);
@@clientName(SharePropertiesInternal.LeaseStatus, "leaseStatus");
@@clientName(SharePropertiesInternal.LeaseState, "leaseState");
@@clientName(SharePropertiesInternal.LeaseDuration, "leaseDuration");
@@clientName(SharePropertiesInternal.EnabledProtocols, "enabledProtocols");
@@clientName(SharePropertiesInternal.RootSquash, "rootSquash");
@@clientName(SharePropertiesInternal.EnableSnapshotVirtualDirectoryAccess,
  "enableSnapshotVirtualDirectoryAccess"
);
@@clientName(SharePropertiesInternal.PaidBurstingEnabled,
  "paidBurstingEnabled"
);
@@clientName(SharePropertiesInternal.PaidBurstingMaxIops,
  "paidBurstingMaxIops"
);
@@clientName(SharePropertiesInternal.PaidBurstingMaxBandwidthMibps,
  "paidBurstingMaxBandwidthMibps"
);
@@clientName(SharePropertiesInternal.IncludedBurstIops, "includedBurstIops");
@@clientName(SharePropertiesInternal.MaxBurstCreditsForIops,
  "maxBurstCreditsForIops"
);
@@clientName(SharePropertiesInternal.NextAllowedProvisionedIopsDowngradeTime,
  "nextAllowedProvisionedIopsDowngradeTime"
);
@@clientName(SharePropertiesInternal.NextAllowedProvisionedBandwidthDowngradeTime,
  "nextAllowedProvisionedBandwidthDowngradeTime"
);
@@clientName(SharePropertiesInternal.EnableSmbDirectoryLease,
  "enableSmbDirectoryLease"
);

@@clientName(Metrics.Version, "version");
@@clientName(Metrics.Enabled, "enabled");
@@clientName(Metrics.IncludeAPIs, "includeAPIs");
@@clientName(Metrics.RetentionPolicy, "retentionPolicy");

@@clientName(RetentionPolicy.Enabled, "enabled");
@@clientName(RetentionPolicy.Days, "days");

@@clientName(SmbMultichannel.Enabled, "enabled");

@@clientName(FileRange.Start, "start");
@@clientName(FileRange.End, "end");

@@clientName(ClearRange.Start, "start");
@@clientName(ClearRange.End, "end");

@@clientName(ShareProtocolSettings.Smb, "smb");
@@clientName(ShareProtocolSettings.Nfs, "nfs");

@@clientName(ShareSmbSettings.Multichannel, "multichannel");
@@clientName(ShareSmbSettings.EncryptionInTransit, "encryptionInTransit");

@@clientName(ShareSmbSettingsEncryptionInTransit.Required, "required");

@@clientName(ShareNfsSettings.EncryptionInTransit, "encryptionInTransit");

@@clientName(ShareNfsSettingsEncryptionInTransit.Required, "required");

@@clientName(ShareFileRangeList.Ranges, "ranges");
@@clientName(ShareFileRangeList.ClearRanges, "clearRanges");

@@clientName(StorageError.Message, "message");
@@clientName(StorageError.CopySourceStatusCode, "copySourceStatusCode");
@@clientName(StorageError.CopySourceErrorCode, "copySourceErrorCode");
@@clientName(StorageError.CopySourceErrorMessage, "copySourceErrorMessage");
@@clientName(StorageError.AuthenticationErrorDetail,
  "authenticationErrorDetail"
);

@@clientName(ShareStats.ShareUsageBytes, "shareUsageBytes");

@@clientName(SignedIdentifier.Id, "id");
@@clientName(SignedIdentifier.AccessPolicy, "accessPolicy");

@@clientName(StorageServiceProperties.HourMetrics, "hourMetrics");
@@clientName(StorageServiceProperties.MinuteMetrics, "minuteMetrics");
@@clientName(StorageServiceProperties.Cors, "cors");
@@clientName(StorageServiceProperties.Protocol, "protocol");

@@clientName(KeyInfo.Start, "start");
@@clientName(KeyInfo.Expiry, "expiry");
@@clientName(KeyInfo.DelegatedUserTid, "delegatedUserTid");

@@clientName(UserDelegationKey.SignedOid, "signedOid");
@@clientName(UserDelegationKey.SignedTid, "signedTid");
@@clientName(UserDelegationKey.SignedStart, "signedStart");
@@clientName(UserDelegationKey.SignedExpiry, "signedExpiry");
@@clientName(UserDelegationKey.SignedService, "signedService");
@@clientName(UserDelegationKey.SignedVersion, "signedVersion");
@@clientName(UserDelegationKey.SignedDelegatedUserTid,
  "signedDelegatedUserTid"
);
@@clientName(UserDelegationKey.Value, "value");
