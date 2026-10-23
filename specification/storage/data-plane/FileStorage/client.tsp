import "./main.tsp";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.File;

namespace Customizations;

@@alternateType(
  FileCreationTimeParameter.fileCreationTime,
  string,
  "python,csharp,javascript,go,java"
);
@@alternateType(
  FileLastWriteTimeParameter.fileLastWriteTime,
  string,
  "python,csharp,javascript,go,java"
);
@@alternateType(
  FileChangeTimeParameter.fileChangeTime,
  string,
  "python,csharp,javascript,go,java"
);
@@alternateType(
  FileCreationTimeResponseHeader.fileCreationTime,
  string,
  "python,csharp"
);
@@alternateType(
  FileLastWriteTimeResponseHeader.fileLastWriteTime,
  string,
  "python,csharp"
);
@@alternateType(
  FileChangeTimeResponseHeader.fileChangeTime,
  string,
  "python,csharp"
);

@@alternateType(KeyInfo.start, string, "python,csharp,javascript,go,java");
@@alternateType(KeyInfo.expiry, string, "python,csharp,javascript,go,java");

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.File,
  },
  "go"
)
interface DirectoryClient extends Storage.File.Directory {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.File,
  },
  "go"
)
interface FileClient extends Storage.File.File {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.File,
  },
  "go"
)
interface ServiceClient extends Storage.File.Service {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.File,
  },
  "go"
)
interface ShareClient extends Storage.File.Share {}

@@access(StorageErrorCode, Access.public, "go");
@@usage(StorageErrorCode, Usage.output, "go");

/** Represents an array of signed identifiers */
@clientName("SignedIdentifiers", "go")
model SignedIdentifiersGo is Array<SignedIdentifier>;

@@alternateType(AccessPolicy.start, utcDateTime, "go");
@@alternateType(AccessPolicy.expiry, utcDateTime, "go");
@@alternateType(ContentCrc64ResponseHeader.contentCrc64, bytes, "go");
@@alternateType(DirectoryItem.name, string, "go");
@@alternateType(FileItem.name, string, "go");
@@alternateType(
  FileChangeTimeResponseHeader.fileChangeTime,
  utcDateTime,
  "go,java"
);
@@alternateType(
  FileCreationTimeResponseHeader.fileCreationTime,
  utcDateTime,
  "go,java"
);
@@alternateType(
  FileLastWriteTimeResponseHeader.fileLastWriteTime,
  utcDateTime,
  "go,java"
);
@@alternateType(HandleItem.path, string, "go");
@@alternateType(
  LeaseResponseHeaders.leaseDuration,
  LeaseDurationType,
  "go,java"
);
@@alternateType(LeaseResponseHeaders.leaseState, LeaseStateType, "go,java");
@@alternateType(LeaseResponseHeaders.leaseStatus, LeaseStatusType, "go,java");
@@alternateType(LinkCountResponseHeader.linkCount, int64, "go");
@@alternateType(ListFilesAndDirectoriesSegmentResponse.prefix, string, "go");
@@alternateType(NfsTimestampResponseHeaders.fileChangeTime, utcDateTime, "go");
@@alternateType(
  NfsTimestampResponseHeaders.fileCreationTime,
  utcDateTime,
  "go"
);
@@alternateType(
  NfsTimestampResponseHeaders.fileLastWriteTime,
  utcDateTime,
  "go"
);
@@alternateType(ShareStats.shareUsageBytes, int64, "go");
@@alternateType(SignedIdentifiers, SignedIdentifiersGo, "go");
@@alternateType(ShareProvisioningResponseHeaders.quota, int64, "go");
@@alternateType(ShareProvisioningResponseHeaders.provisionedIops, int64, "go");
@@alternateType(
  ShareProvisioningResponseHeaders.provisionedBandwidthMibps,
  int64,
  "go"
);
@@alternateType(
  ShareProvisioningResponseHeaders.includedBurstIops,
  int64,
  "go"
);
@@alternateType(ShareQuotaOptionalHeader.quota, int64, "go");
@@clientName(ClientRequestIdParameter.clientRequestId, "RequestID", "go");
@@clientName(CopyStatus, "CopyStatusType", "go");
@@clientName(CorsRule, "CORSRule", "go");
@@clientName(ContentCrc64ResponseHeader.contentCrc64, "XMSContentCRC64", "go");
@@clientName(DirectoryItem, "Directory", "go");
@@clientName(DirectoryItem.fileId, "ID", "go");
@@clientName(
  EnableSmbDirectoryLeaseHeader.enableSmbDirectoryLease,
  "EnableSMBDirectoryLease",
  "go"
);
@@clientName(EtagResponseHeader.etag, "ETag", "go");
@@clientName(FileItem, "File", "go");
@@clientName(FileItem.fileId, "ID", "go");
@@clientName(
  FilesAndDirectoriesListSegment.directoryItems,
  "Directories",
  "go"
);
@@clientName(FilesAndDirectoriesListSegment.fileItems, "Files", "go");
@@clientName(FileSmtPropertyResponseHeaders.fileId, "ID", "go");
@@clientName(FileSmtPropertyResponseHeaders.fileParentId, "ParentID", "go");
@@clientName(HandleItem, "Handle", "go");
@@clientName(HandleItem.handleId, "ID", "go");
@@clientName(KeyInfo.delegatedUserTid, "DelegatedUserTenantID", "go");
@@clientName(ListHandlesResponse.handleList, "Handles", "go");
@@clientName(ListSharesResponse.shareItems, "Shares", "go");
@@clientName(Metrics.includeApis, "includeAPIs", "go");
@@clientName(NfsFileType, "NFSFileType", "go");
@@clientName(NfsResponseHeaders.nfsFileType, "NFSFileType", "go");
@@clientName(NfsTimestampResponseHeaders.fileId, "ID", "go");
@@clientName(NfsTimestampResponseHeaders.fileParentId, "ParentID", "go");
@@clientName(OptionalBody.optionalBody, "Optionalbody", "go");
@@clientName(
  RequestServerEncryptedResponseHeader.requestServerEncrypted,
  "IsServerEncrypted",
  "go"
);
@@clientName(
  ServerEncryptedResponseHeader.serverEncrypted,
  "IsServerEncrypted",
  "go"
);
@@clientName(ShareProtocolSettings.nfs, "NFS", "go");

@@clientName(ShareItemInternal, "Share", "go");
@@clientName(ShareNfsSettings, "ShareNFSSettings", "go");
@@clientName(
  ShareNfsSettingsEncryptionInTransit,
  "ShareNFSSettingsEncryptionInTransit",
  "go"
);
@@clientName(SharePropertiesInternal, "ShareProperties", "go");
@@clientName(
  SharePropertiesInternal.enableSmbDirectoryLease,
  "EnableSMBDirectoryLease",
  "go"
);
@@clientName(ShareProtocolSettings, "ProtocolSettings", "go");
@@clientName(
  ShareSmbSettingsEncryptionInTransit,
  "SMBSettingsEncryptionInTransit",
  "go"
);
@@clientName(
  ShareUsageResponseHeader.shareUsageBytes,
  "FileShareUsageBytes",
  "go"
);
@@clientName(
  ShareSnapshotUsageResponseHeader.shareSnapshotUsageBytes,
  "FileShareSnapshotUsageBytes",
  "go"
);
@@clientName(ShareSmbSettings, "SMBSettings", "go");
@@clientName(
  Storage.File.UserDelegationKey.signedDelegatedUserTid,
  "signedDelegatedUserTenantID",
  "go"
);
@@clientName(SmbMultichannel, "SMBMultichannel", "go");
@@clientName(StorageServiceProperties.cors, "CORS", "go");
@@clientName(UserDelegationKey.signedOid, "SignedOID", "go");
@@clientName(UserDelegationKey.signedTid, "SignedTID", "go");
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(HandleItem, "omitSerdeMethods", "all", "go");
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Directory.listFilesAndDirectoriesSegment,
  "preserveContentTypeHeader",
  true,
  "go"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Directory.listHandles, "preserveContentTypeHeader", true, "go");
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.File.File.download,
  "preserveContentTypeHeader",
  true,
  "go"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.File.File.getProperties,
  "preserveContentTypeHeader",
  true,
  "go"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.File.File.listHandles,
  "preserveContentTypeHeader",
  true,
  "go"
);

@@alternateType(Storage.File.AccessPolicy.start, string, "javascript,python");
@@alternateType(Storage.File.AccessPolicy.expiry, string, "javascript,python");
@@clientName(Storage.File.AccessPolicy.start, "startsOn", "javascript");
@@clientName(Storage.File.AccessPolicy.expiry, "expiresOn", "javascript");
@@clientName(Storage.File.AccessPolicy.permission, "permissions", "javascript");

@@alternateType(
  Storage.File.UserDelegationKey.signedStart,
  string,
  "javascript,python"
);
@@alternateType(
  Storage.File.UserDelegationKey.signedExpiry,
  string,
  "javascript,python"
);
@@clientName(
  Storage.File.UserDelegationKey.signedOid,
  "signedObjectId",
  "javascript"
);
@@clientName(
  Storage.File.UserDelegationKey.signedTid,
  "signedTenantId",
  "javascript"
);
@@clientName(
  Storage.File.UserDelegationKey.signedStart,
  "signedStartsOn",
  "javascript"
);
@@clientName(
  Storage.File.UserDelegationKey.signedExpiry,
  "signedExpiresOn",
  "javascript"
);

@@clientName(Storage.File.Metrics.includeApis, "includeAPIs", "javascript");

@@clientName(
  Storage.File.StorageServiceProperties,
  "FileServiceProperties",
  "javascript"
);

@@clientName(
  Storage.File.TimeoutParameter.timeout,
  "timeoutInSeconds",
  "javascript"
);

@@clientName(
  Storage.File.ShareSnapshotParameter.sharesnapshot,
  "shareSnapshot",
  "javascript"
);

@@clientName(
  Storage.File.MaxResultsParameter.maxresults,
  "maxResults",
  "javascript"
);

@@clientName(
  Storage.File.ListSharesResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(
  Storage.File.ListFilesAndDirectoriesSegmentResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(
  Storage.File.ListHandlesResponse.nextMarker,
  "continuationToken",
  "javascript"
);

@@clientName(Storage.File.EtagResponseHeader.etag, "etag", "javascript,python");
@@clientName(
  Storage.File.SharePropertiesInternal.eTag,
  "etag",
  "javascript,python"
);
@@clientName(Storage.File.FileProperty.eTag, "etag", "javascript,python");

@@clientName(
  Storage.File.FileSmtPropertyRequestHeaders.fileCreationTime,
  "fileCreatedOn",
  "javascript"
);
@@clientName(
  Storage.File.FileSmtPropertyRequestHeaders.fileLastWriteTime,
  "fileLastWriteOn",
  "javascript"
);
@@clientName(
  Storage.File.FileSmtPropertyRequestHeaders.fileChangeTime,
  "fileChangeOn",
  "javascript"
);
@@clientName(
  Storage.File.FileSmtPropertyResponseHeaders.fileCreationTime,
  "fileCreatedOn",
  "javascript"
);
@@clientName(
  Storage.File.FileSmtPropertyResponseHeaders.fileLastWriteTime,
  "fileLastWriteOn",
  "javascript"
);
@@clientName(
  Storage.File.FileSmtPropertyResponseHeaders.fileChangeTime,
  "fileChangeOn",
  "javascript"
);

@@clientName(
  Storage.File.CopyStatusResponseHeaders.copyCompletionTime,
  "copyCompletedOn",
  "javascript"
);

@@clientName(
  Storage.File.LeaseTimeResponseHeader.leaseTime,
  "leaseTimeInSeconds",
  "javascript"
);

@@clientName(Storage.File.OptionalBody.optionalBody, "body", "javascript");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.File.Error,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.File.Error,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.File.MetadataHeaders.metadata,
  "headerCollectionPrefix",
  "x-ms-meta",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File, "includeRootSlash", false, "javascript");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File, "omitSlashFromEmptyRoute", true, "python,csharp");

@@clientName(
  Storage.File.UserDelegationKey.signedDelegatedUserTid,
  "signedDelegatedUserTenantId",
  "javascript"
);

@@clientName(
  Storage.File.ShareUsageResponseHeader.shareUsageBytes,
  "usageBytes",
  "javascript"
);
@@clientName(
  Storage.File.ShareSnapshotUsageResponseHeader.shareSnapshotUsageBytes,
  "snapshotUsageBytes",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(
  Storage.File.Service.listSharesSegment,
  "python,javascript,csharp,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(
  Storage.File.Directory.listFilesAndDirectoriesSegment,
  "python,javascript,csharp,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(
  Storage.File.Directory.listHandles,
  "python,javascript,csharp,go,java"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(
  Storage.File.File.listHandles,
  "python,javascript,csharp,go,java"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(
  Storage.File.File.listAllRanges,
  "python,javascript,csharp,go,java"
);

@@alternateType(Storage.File.FileProperty.creationTime, string, "python");
@@alternateType(Storage.File.FileProperty.lastWriteTime, string, "python");
@@alternateType(Storage.File.FileProperty.changeTime, string, "python");
@@alternateType(Storage.File.FileProperty.lastAccessTime, string, "python");

// csharp customizations
#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model ShareClientParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  fileRequestIntent?: ShareTokenIntent;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model FileClientParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  fileRequestIntent?: ShareTokenIntent;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowTrailingDot?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowSourceTrailingDot?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  fileRangeWriteFromUrl: FileRangeWriteFromUrlType;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
model DirectoryClientParameters {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  fileRequestIntent?: ShareTokenIntent;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowTrailingDot?: boolean;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Custom internal client parameter"
  allowSourceTrailingDot?: boolean;
}

@@clientInitialization(
  Storage.File,
  {
    parameters: ShareClientParameters,
  },
  "csharp"
);

@@clientInitialization(
  Storage.File.Directory,
  {
    parameters: DirectoryClientParameters,
  },
  "csharp"
);

@@clientInitialization(
  Storage.File.File,
  {
    parameters: FileClientParameters,
  },
  "csharp"
);

@@alternateType(AccessPolicy.start, utcDateTime, "csharp,java");
@@alternateType(AccessPolicy.expiry, utcDateTime, "csharp,java");
@@alternateType(MetadataHeaders.metadata, Record<string>, "csharp,java");
@@alternateType(FileProperty.eTag, string, "csharp");
@@alternateType(ShareStats.shareUsageBytes, int64, "csharp");

@@clientName(Storage.File, "ShareClient", "csharp");
@@clientName(AccessPolicy.start, "PolicyStartsOn", "csharp");
@@clientName(AccessPolicy.expiry, "PolicyExpiresOn", "csharp");
@@clientName(AccessPolicy.permission, "Permissions", "csharp");
@@clientName(Directory, "DirectoryRestClient", "csharp");
@@clientName(Storage.File.File, "FileRestClient", "csharp");
@@clientName(Service, "ServiceRestClient", "csharp");
@@clientName(Share, "ShareRestClient", "csharp");
@@clientName(StorageErrorCode, "ShareErrorCode", "csharp");
@@clientName(PermissionCopyModeType, "PermissionCopyMode", "csharp");
@@clientName(FileRangeWriteType, "ShareFileRangeWriteType", "csharp,java");
@@clientName(LeaseDurationType, "ShareLeaseDuration", "csharp");
@@clientName(LeaseStateType, "ShareLeaseState", "csharp");
@@clientName(LeaseStatusType, "ShareLeaseStatus", "csharp");

@@access(FileRangeWriteFromUrlType, Access.internal, "csharp");
@@access(ListSharesIncludeType, Access.internal, "csharp");
@@access(ListFilesIncludeType, Access.internal, "csharp");
@@access(DeleteSnapshotsOptionType, Access.internal, "csharp");
@@access(AccessRight, Access.internal, "csharp");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(
  Storage.File.MetadataHeaders.metadata,
  "collectionHeaderPrefix",
  "x-ms-meta-",
  "csharp,java"
);

// java customizations
// name the service-client impl "AzureFileStorageImpl" to match the historical swagger name
@@clientName(Storage.File, "AzureFileStorage", "java");

// java: carry the storage-wide client parameters on the service client so the generated
// AzureFileStorageImpl constructor matches what the hand-written builders pass (mirrors the csharp
// @clientInitialization blocks above).
/** Storage-wide client parameters carried on the service client. */
model AzureFileStorageClientParameters {
  /** Valid values are 'backup'. */
  fileRequestIntent?: ShareTokenIntent;

  /** If true, the trailing dot will not be trimmed from the target file/directory path. */
  allowTrailingDot?: boolean;

  /** If true, the trailing dot will not be trimmed from the source URI. */
  allowSourceTrailingDot?: boolean;
}

@@clientInitialization(
  Storage.File,
  {
    parameters: AzureFileStorageClientParameters,
  },
  "java"
);

// java: reconcile generated model names with the existing models
@@clientName(AccessPolicy, "ShareAccessPolicy", "java");
@@clientName(AccessRight, "ShareFileHandleAccessRights", "java");
@@clientName(CorsRule, "ShareCorsRule", "java");
@@clientName(Metrics, "ShareMetrics", "java");
@@clientName(RetentionPolicy, "ShareRetentionPolicy", "java");
@@clientName(SignedIdentifier, "ShareSignedIdentifier", "java");
@@clientName(SignedIdentifiers, "ShareSignedIdentifierWrapper", "java");
@@clientName(StorageServiceProperties, "ShareServiceProperties", "java");
@@clientName(
  FileRangeWriteFromUrlType,
  "ShareFileRangeWriteFromUrlType",
  "java"
);
@@clientName(StorageErrorCode, "ShareErrorCode", "java");

// java: reconcile generated model property names with the historical swagger x-ms-client-name
// values so the public API surface stays backward compatible.
@@clientName(AccessPolicy.start, "startsOn", "java");
@@clientName(AccessPolicy.expiry, "expiresOn", "java");
@@clientName(AccessPolicy.permission, "permissions", "java");
@@clientName(UserDelegationKey.signedOid, "signedObjectId", "java");
@@clientName(UserDelegationKey.signedTid, "signedTenantId", "java");
@@clientName(
  UserDelegationKey.signedDelegatedUserTid,
  "signedDelegatedUserTenantId",
  "java"
);
@@clientName(KeyInfo.delegatedUserTid, "delegatedUserTenantId", "java");

// java: match the historical swagger numeric widths that the hand-written wrapper models depend on.
// ShareStats.shareUsageBytes must be int64 (long); the hand-written ModelHelper feeds it into
// new ShareStatistics(long shareUsageInBytes) -- an int would silently bind to the (int GB) ctor.
@@alternateType(ShareStats.shareUsageBytes, int64, "java");

// java: the generated copy-status response header must reference the public CopyStatusType custom-type.
@@clientName(CopyStatus, "CopyStatusType", "java");
// java: emit the public ShareErrorCode enum. In DPG it is otherwise orphaned (the error model isn't
// referenced by a retained typed operation), so tag it public+output to force emission into the
// custom-types (public models) package.
@@access(StorageErrorCode, Access.public, "java");
@@usage(StorageErrorCode, Usage.output, "java");
// @@access(CopyStatus, Access.public, "java");
// @@usage(CopyStatus, Usage.output, "java");

// java: richer client doc for the token-intent enum than the terse spec description (SDK-only; does not change OpenAPI).
@@clientDoc(
  ShareTokenIntent,
  "The request intent specifies requests that are intended for backup/admin type operations, meaning that all file/directory ACLs are bypassed and full permissions are granted. User must also have required RBAC permission.",
  DocumentationMode.replace,
  "java"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option" "Emitter option for response header model synthesis"
namespace JavaResponseHeaderModels {
  @@clientOption(
    Storage.File.File.setMetadata,
    "responseHeadersAsModel",
    true,
    "java"
  );

  @@clientOption(
    Storage.File.Directory.create,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.Directory.forceCloseHandles,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.Directory.getProperties,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.Directory.setMetadata,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.Directory.setProperties,
    "responseHeadersAsModel",
    true,
    "java"
  );

  @@clientOption(
    Storage.File.File.createHardLink,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.create,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.createSymbolicLink,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.forceCloseHandles,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.getProperties,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.getSymbolicLink,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.setHttpHeaders,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.startCopy,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.uploadRangeFromUrl,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.File.uploadRange,
    "responseHeadersAsModel",
    true,
    "java"
  );

  @@clientOption(
    Storage.File.Share.createPermission,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.Share.createSnapshot,
    "responseHeadersAsModel",
    true,
    "java"
  );
  @@clientOption(
    Storage.File.Share.getProperties,
    "responseHeadersAsModel",
    true,
    "java"
  );
}
