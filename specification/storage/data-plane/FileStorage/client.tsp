import "./main.tsp";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.File;

namespace Customizations;

@@alternateType(FileCreationTimeParameter.fileCreationTime,
  string,
  "python,csharp,javascript,go"
);
@@alternateType(FileLastWriteTimeParameter.fileLastWriteTime,
  string,
  "python,csharp,javascript,go"
);
@@alternateType(FileChangeTimeParameter.fileChangeTime,
  string,
  "python,csharp,javascript,go"
);
@@alternateType(FileCreationTimeResponseHeader.fileCreationTime,
  string,
  "python,csharp,javascript"
);
@@alternateType(FileLastWriteTimeResponseHeader.fileLastWriteTime,
  string,
  "python,csharp,javascript"
);
@@alternateType(FileChangeTimeResponseHeader.fileChangeTime,
  string,
  "python,csharp,javascript"
);

@@clientNamespace(Storage.File,
  "Azure.Storage.Files.Shares",
  "!csharp,!python,!go"
);
@@clientNamespace(Storage.File.Service,
  "Azure.Storage.Files.Shares",
  "!csharp,!python,!go"
);
@@clientNamespace(Storage.File.Share,
  "Azure.Storage.Files.Shares",
  "!csharp,!python,!go"
);
@@clientNamespace(Storage.File.Directory,
  "Azure.Storage.Files.Shares",
  "!csharp,!python,!go"
);
@@clientNamespace(Storage.File.File,
  "Azure.Storage.Files.Shares",
  "!csharp,!python,!go"
);

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

/** Represents an array of signed identifiers */
@clientName("SignedIdentifiers", "go")
model SignedIdentifiersGo is Array<SignedIdentifier>;

@@alternateType(AccessPolicy.start, utcDateTime, "go");
@@alternateType(AccessPolicy.expiry, utcDateTime, "go");
@@alternateType(ContentCrc64ResponseHeader.contentCrc64, bytes, "go");
@@alternateType(CopyStatusResponseHeaders.copyCompletionTime,
  utcDateTime,
  "go"
);
@@alternateType(DirectoryItem.name, string, "go");
@@alternateType(FileItem.name, string, "go");
@@alternateType(FileChangeTimeResponseHeader.fileChangeTime, utcDateTime, "go");
@@alternateType(FileCreationTimeResponseHeader.fileCreationTime,
  utcDateTime,
  "go"
);
@@alternateType(FileLastWriteTimeResponseHeader.fileLastWriteTime,
  utcDateTime,
  "go"
);
@@alternateType(FileProperty.changeTime, utcDateTime, "go");
@@alternateType(FileProperty.creationTime, utcDateTime, "go");
@@alternateType(FileProperty.lastAccessTime, utcDateTime, "go");
@@alternateType(FileProperty.lastWriteTime, utcDateTime, "go");
@@alternateType(HandleItem.path, string, "go");
@@alternateType(LeaseResponseHeaders.leaseDuration, LeaseDurationType, "go");
@@alternateType(LeaseResponseHeaders.leaseState, LeaseStateType, "go");
@@alternateType(LeaseResponseHeaders.leaseStatus, LeaseStatusType, "go");
@@alternateType(LinkCountResponseHeader.linkCount, int64, "go");
@@alternateType(ListFilesAndDirectoriesSegmentResponse.prefix, string, "go");
@@alternateType(NfsTimestampResponseHeaders.fileChangeTime, utcDateTime, "go");
@@alternateType(NfsTimestampResponseHeaders.fileCreationTime,
  utcDateTime,
  "go"
);
@@alternateType(NfsTimestampResponseHeaders.fileLastWriteTime,
  utcDateTime,
  "go"
);
@@alternateType(ShareStats.shareUsageBytes, int64, "go");
@@alternateType(SignedIdentifiers, SignedIdentifiersGo, "go");
@@alternateType(ShareProvisioningResponseHeaders.quota, int64, "go");
@@alternateType(ShareProvisioningResponseHeaders.provisionedIops, int64, "go");
@@alternateType(ShareProvisioningResponseHeaders.provisionedBandwidthMibps,
  int64,
  "go"
);
@@alternateType(ShareProvisioningResponseHeaders.includedBurstIops,
  int64,
  "go"
);
@@alternateType(ShareQuotaOptionalHeader.quota, int64, "go");
@@clientName(CopyStatus, "CopyStatusType", "go");
@@clientName(CorsRule, "CORSRule", "go");
@@clientName(ContentCrc64ResponseHeader.contentCrc64, "XMSContentCRC64", "go");
@@clientName(DirectoryItem, "Directory", "go");
@@clientName(DirectoryItem.fileId, "ID", "go");
@@clientName(EnableSmbDirectoryLeaseHeader.enableSmbDirectoryLease,
  "EnableSMBDirectoryLease",
  "go"
);
@@clientName(EtagResponseHeader.etag, "ETag", "go");
@@clientName(FileItem, "File", "go");
@@clientName(FileItem.fileId, "ID", "go");
@@clientName(FilesAndDirectoriesListSegment.directoryItems,
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
@@clientName(RequestServerEncryptedResponseHeader.requestServerEncrypted,
  "IsServerEncrypted",
  "go"
);
@@clientName(ServerEncryptedResponseHeader.serverEncrypted,
  "IsServerEncrypted",
  "go"
);
@@clientName(ShareProtocolSettings.nfs, "NFS", "go");

@@clientName(ShareItemInternal, "Share", "go");
@@clientName(ShareNfsSettings, "ShareNFSSettings", "go");
@@clientName(SharePropertiesInternal, "ShareProperties", "go");
@@clientName(SharePropertiesInternal.enableSmbDirectoryLease,
  "EnableSMBDirectoryLease",
  "go"
);
@@clientName(ShareProtocolSettings, "ProtocolSettings", "go");
@@clientName(ShareSmbSettingsEncryptionInTransit,
  "SMBEncryptionInTransit",
  "go"
);
@@clientName(ShareUsageResponseHeader.shareUsageBytes,
  "FileShareUsageBytes",
  "go"
);
@@clientName(ShareSnapshotUsageResponseHeader.shareSnapshotUsageBytes,
  "FileShareSnapshotUsageBytes",
  "go"
);
@@clientName(ShareSmbSettings, "SMBSettings", "go");
@@clientName(SmbMultichannel, "SMBMultichannel", "go");
@@clientName(StorageServiceProperties.cors, "CORS", "go");
@@clientName(UserDelegationKey.signedOid, "SignedOID", "go");
@@clientName(UserDelegationKey.signedTid, "SignedTID", "go");
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(HandleItem, "omitSerdeMethods", "all", "go");

@@alternateType(Storage.File.AccessPolicy.start, string, "javascript,python");
@@alternateType(Storage.File.AccessPolicy.expiry, string, "javascript,python");
@@clientName(Storage.File.AccessPolicy.start, "startsOn", "javascript");
@@clientName(Storage.File.AccessPolicy.expiry, "expiresOn", "javascript");
@@clientName(Storage.File.AccessPolicy.permission, "permissions", "javascript");

@@alternateType(Storage.File.UserDelegationKey.signedStart,
  string,
  "javascript,python"
);
@@alternateType(Storage.File.UserDelegationKey.signedExpiry,
  string,
  "javascript,python"
);
@@clientName(Storage.File.UserDelegationKey.signedOid,
  "signedObjectId",
  "javascript"
);
@@clientName(Storage.File.UserDelegationKey.signedTid,
  "signedTenantId",
  "javascript"
);
@@clientName(Storage.File.UserDelegationKey.signedStart,
  "signedStartsOn",
  "javascript"
);
@@clientName(Storage.File.UserDelegationKey.signedExpiry,
  "signedExpiresOn",
  "javascript"
);

@@clientName(Storage.File.Metrics.includeApis, "includeAPIs", "javascript");

@@clientName(Storage.File.StorageServiceProperties,
  "FileServiceProperties",
  "javascript"
);

@@clientName(Storage.File.TimeoutParameter.timeout,
  "timeoutInSeconds",
  "javascript"
);

@@clientName(Storage.File.ShareSnapshotParameter.sharesnapshot,
  "shareSnapshot",
  "javascript"
);

@@clientName(Storage.File.MaxResultsParameter.maxresults,
  "maxResults",
  "javascript"
);

@@clientName(Storage.File.ListSharesResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(Storage.File.ListFilesAndDirectoriesSegmentResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(Storage.File.ListHandlesResponse.nextMarker,
  "continuationToken",
  "javascript"
);

@@clientName(Storage.File.EtagResponseHeader.etag, "etag", "javascript,python");
@@clientName(Storage.File.SharePropertiesInternal.eTag,
  "etag",
  "javascript,python"
);
@@clientName(Storage.File.FileProperty.eTag, "etag", "javascript,python");

@@clientName(Storage.File.FileSmtPropertyRequestHeaders.fileCreationTime,
  "fileCreatedOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyRequestHeaders.fileLastWriteTime,
  "fileLastWriteOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyRequestHeaders.fileChangeTime,
  "fileChangeOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyResponseHeaders.fileCreationTime,
  "fileCreatedOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyResponseHeaders.fileLastWriteTime,
  "fileLastWriteOn",
  "javascript"
);
@@clientName(Storage.File.FileSmtPropertyResponseHeaders.fileChangeTime,
  "fileChangeOn",
  "javascript"
);

@@clientName(Storage.File.CopyStatusResponseHeaders.copyCompletionTime,
  "copyCompletedOn",
  "javascript"
);

@@clientName(Storage.File.LeaseTimeResponseHeader.leaseTime,
  "leaseTimeInSeconds",
  "javascript"
);

@@clientName(Storage.File.OptionalBody.optionalBody, "body", "javascript");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.Error,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.Error,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.MetadataHeaders.metadata,
  "headerCollectionPrefix",
  "x-ms-meta",
  "javascript"
);

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File, "includeRootSlash", false, "javascript");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File, "omitSlashFromEmptyRoute", true, "python,csharp");

@@clientName(Storage.File.UserDelegationKey.signedDelegatedUserTid,
  "signedDelegatedUserTenantId",
  "javascript"
);

@@clientName(Storage.File.ShareUsageResponseHeader.shareUsageBytes,
  "usageBytes",
  "javascript"
);
@@clientName(Storage.File.ShareSnapshotUsageResponseHeader.shareSnapshotUsageBytes,
  "snapshotUsageBytes",
  "javascript"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.Service.listSharesSegment,
  "python,javascript,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.Directory.listFilesAndDirectoriesSegment,
  "python,javascript,csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.Directory.listHandles,
  "python,javascript,csharp,go"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "This is for legacy compatibility"
@@Legacy.disablePageable(Storage.File.File.listHandles,
  "python,javascript,csharp,go"
);

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

@@clientInitialization(Storage.File,
  {
    parameters: ShareClientParameters,
  },
  "csharp"
);

@@clientInitialization(Storage.File.Directory,
  {
    parameters: DirectoryClientParameters,
  },
  "csharp"
);

@@clientInitialization(Storage.File.File,
  {
    parameters: FileClientParameters,
  },
  "csharp"
);

@@alternateType(AccessPolicy.start, utcDateTime, "csharp");
@@alternateType(AccessPolicy.expiry, utcDateTime, "csharp");
@@alternateType(MetadataHeaders.metadata, Record<string>, "csharp");
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
@@clientName(FileRangeWriteType, "ShareFileRangeWriteType", "csharp");
@@clientName(LeaseDurationType, "ShareLeaseDuration", "csharp");
@@clientName(LeaseStateType, "ShareLeaseState", "csharp");
@@clientName(LeaseStatusType, "ShareLeaseStatus", "csharp");

@@access(FileRangeWriteFromUrlType, Access.internal, "csharp");
@@access(ListSharesIncludeType, Access.internal, "csharp");
@@access(ListFilesIncludeType, Access.internal, "csharp");
@@access(DeleteSnapshotsOptionType, Access.internal, "csharp");
@@access(AccessRight, Access.internal, "csharp");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(Storage.File.MetadataHeaders.metadata,
  "collectionHeaderPrefix",
  "x-ms-meta-",
  "csharp"
);

// ===== Rust SDK customizations: required metadata overrides =====

/** Metadata headers with metadata as required (for Rust overrides). */
alias MetadataHeadersRequired = {
  /** The metadata headers. */
  @header("x-ms-meta")
  metadata: Record<string>;
};

/** Sets one or more user-defined name-value pairs for the specified share (Rust override with required metadata). */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?restype=share&comp=metadata")
op setMetadataRequiredMetadataShare is StorageOperationNoBody<
  {
    ...TimeoutParameter;
    ...MetadataHeadersRequired;
    ...LeaseIdOptionalParameter;
    ...FileRequestIntentParameter;
  },
  {
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
  }
>;

@@override(Share.setMetadata, setMetadataRequiredMetadataShare, "rust");

/** Sets one or more user-defined name-value pairs for the specified directory (Rust override with required metadata). */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?restype=directory&comp=metadata")
op setMetadataRequiredMetadataDirectory is StorageOperationNoBody<
  {
    ...TimeoutParameter;
    ...MetadataHeadersRequired;
    ...AllowTrailingDotParameter;
    ...FileRequestIntentParameter;
  },
  {
    ...EtagResponseHeader;
    ...RequestServerEncryptedResponseHeader;
  }
>;

@@override(Directory.setMetadata, setMetadataRequiredMetadataDirectory, "rust");

/** Sets one or more user-defined name-value pairs for the specified file (Rust override with required metadata). */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?comp=metadata")
op setMetadataRequiredMetadataFile is StorageOperationNoBody<
  {
    ...TimeoutParameter;
    ...MetadataHeadersRequired;
    ...LeaseIdOptionalParameter;
    ...FileRequestIntentParameter;
    ...AllowTrailingDotParameter;
  },
  {
    ...EtagResponseHeader;
    ...RequestServerEncryptedResponseHeader;
  }
>;

@@override(Storage.File.File.setMetadata,
  setMetadataRequiredMetadataFile,
  "rust"
);

// ===== Rust SDK customizations: required ACL body override =====

/** Sets stored access policies for the share (Rust override with required shareAcl). */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?restype=share&comp=acl")
op setAccessPolicyRequiredShareAcl is StorageOperationNoBody<
  {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType?: "application/xml";

    ...TimeoutParameter;
    ...LeaseIdOptionalParameter;
    ...FileRequestIntentParameter;

    /** The ACL for the share. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
    @body shareAcl: SignedIdentifiers;
  },
  {
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
  }
>;

@@override(Share.setAccessPolicy, setAccessPolicyRequiredShareAcl, "rust");
