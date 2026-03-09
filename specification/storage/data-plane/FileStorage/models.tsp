import "@typespec/rest";
import "@typespec/http";
import "@typespec/xml";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Storage.File;

/**
 * Error codes returned by the service
 */
union StorageErrorCode {
  string,

  /**
   * AccountAlreadyExists
   */
  AccountAlreadyExists: "AccountAlreadyExists",

  /**
   * AccountBeingCreated
   */
  AccountBeingCreated: "AccountBeingCreated",

  /**
   * AccountIsDisabled
   */
  AccountIsDisabled: "AccountIsDisabled",

  /**
   * AuthenticationFailed
   */
  AuthenticationFailed: "AuthenticationFailed",

  /**
   * AuthorizationFailure
   */
  AuthorizationFailure: "AuthorizationFailure",

  /**
   * ConditionHeadersNotSupported
   */
  ConditionHeadersNotSupported: "ConditionHeadersNotSupported",

  /**
   * ConditionNotMet
   */
  ConditionNotMet: "ConditionNotMet",

  /**
   * EmptyMetadataKey
   */
  EmptyMetadataKey: "EmptyMetadataKey",

  /**
   * FileShareProvisionedBandwidthDowngradeNotAllowed
   */
  FileShareProvisionedBandwidthDowngradeNotAllowed: "FileShareProvisionedBandwidthDowngradeNotAllowed",

  /**
   * FileShareProvisionedIopsDowngradeNotAllowed
   */
  FileShareProvisionedIopsDowngradeNotAllowed: "FileShareProvisionedIopsDowngradeNotAllowed",

  /**
   * InsufficientAccountPermissions
   */
  InsufficientAccountPermissions: "InsufficientAccountPermissions",

  /**
   * InternalError
   */
  InternalError: "InternalError",

  /**
   * InvalidAuthenticationInfo
   */
  InvalidAuthenticationInfo: "InvalidAuthenticationInfo",

  /**
   * InvalidHeaderValue
   */
  InvalidHeaderValue: "InvalidHeaderValue",

  /**
   * InvalidHttpVerb
   */
  InvalidHttpVerb: "InvalidHttpVerb",

  /**
   * InvalidInput
   */
  InvalidInput: "InvalidInput",

  /**
   * InvalidMd5
   */
  InvalidMd5: "InvalidMd5",

  /**
   * InvalidMetadata
   */
  InvalidMetadata: "InvalidMetadata",

  /**
   * InvalidQueryParameterValue
   */
  InvalidQueryParameterValue: "InvalidQueryParameterValue",

  /**
   * InvalidRange
   */
  InvalidRange: "InvalidRange",

  /**
   * InvalidResourceName
   */
  InvalidResourceName: "InvalidResourceName",

  /**
   * InvalidUri
   */
  InvalidUri: "InvalidUri",

  /**
   * InvalidXmlDocument
   */
  InvalidXmlDocument: "InvalidXmlDocument",

  /**
   * InvalidXmlNodeValue
   */
  InvalidXmlNodeValue: "InvalidXmlNodeValue",

  /**
   * Md5Mismatch
   */
  Md5Mismatch: "Md5Mismatch",

  /**
   * MetadataTooLarge
   */
  MetadataTooLarge: "MetadataTooLarge",

  /**
   * MissingContentLengthHeader
   */
  MissingContentLengthHeader: "MissingContentLengthHeader",

  /**
   * MissingRequiredQueryParameter
   */
  MissingRequiredQueryParameter: "MissingRequiredQueryParameter",

  /**
   * MissingRequiredHeader
   */
  MissingRequiredHeader: "MissingRequiredHeader",

  /**
   * MissingRequiredXmlNode
   */
  MissingRequiredXmlNode: "MissingRequiredXmlNode",

  /**
   * MultipleConditionHeadersNotSupported
   */
  MultipleConditionHeadersNotSupported: "MultipleConditionHeadersNotSupported",

  /**
   * OperationTimedOut
   */
  OperationTimedOut: "OperationTimedOut",

  /**
   * OutOfRangeInput
   */
  OutOfRangeInput: "OutOfRangeInput",

  /**
   * OutOfRangeQueryParameterValue
   */
  OutOfRangeQueryParameterValue: "OutOfRangeQueryParameterValue",

  /**
   * RequestBodyTooLarge
   */
  RequestBodyTooLarge: "RequestBodyTooLarge",

  /**
   * ResourceTypeMismatch
   */
  ResourceTypeMismatch: "ResourceTypeMismatch",

  /**
   * RequestUrlFailedToParse
   */
  RequestUrlFailedToParse: "RequestUrlFailedToParse",

  /**
   * ResourceAlreadyExists
   */
  ResourceAlreadyExists: "ResourceAlreadyExists",

  /**
   * ResourceNotFound
   */
  ResourceNotFound: "ResourceNotFound",

  /**
   * ServerBusy
   */
  ServerBusy: "ServerBusy",

  /**
   * UnsupportedHeader
   */
  UnsupportedHeader: "UnsupportedHeader",

  /**
   * UnsupportedXmlNode
   */
  UnsupportedXmlNode: "UnsupportedXmlNode",

  /**
   * UnsupportedQueryParameter
   */
  UnsupportedQueryParameter: "UnsupportedQueryParameter",

  /**
   * UnsupportedHttpVerb
   */
  UnsupportedHttpVerb: "UnsupportedHttpVerb",

  /**
   * CannotDeleteFileOrDirectory
   */
  CannotDeleteFileOrDirectory: "CannotDeleteFileOrDirectory",

  /**
   * ClientCacheFlushDelay
   */
  ClientCacheFlushDelay: "ClientCacheFlushDelay",

  /**
   * DeletePending
   */
  DeletePending: "DeletePending",

  /**
   * DirectoryNotEmpty
   */
  DirectoryNotEmpty: "DirectoryNotEmpty",

  /**
   * FileLockConflict
   */
  FileLockConflict: "FileLockConflict",

  /**
   * InvalidFileOrDirectoryPathName
   */
  InvalidFileOrDirectoryPathName: "InvalidFileOrDirectoryPathName",

  /**
   * ParentNotFound
   */
  ParentNotFound: "ParentNotFound",

  /**
   * ReadOnlyAttribute
   */
  ReadOnlyAttribute: "ReadOnlyAttribute",

  /**
   * ShareAlreadyExists
   */
  ShareAlreadyExists: "ShareAlreadyExists",

  /**
   * ShareBeingDeleted
   */
  ShareBeingDeleted: "ShareBeingDeleted",

  /**
   * ShareDisabled
   */
  ShareDisabled: "ShareDisabled",

  /**
   * ShareNotFound
   */
  ShareNotFound: "ShareNotFound",

  /**
   * SharingViolation
   */
  SharingViolation: "SharingViolation",

  /**
   * ShareSnapshotInProgress
   */
  ShareSnapshotInProgress: "ShareSnapshotInProgress",

  /**
   * ShareSnapshotCountExceeded
   */
  ShareSnapshotCountExceeded: "ShareSnapshotCountExceeded",

  /**
   * ShareSnapshotOperationNotSupported
   */
  ShareSnapshotOperationNotSupported: "ShareSnapshotOperationNotSupported",

  /**
   * ShareHasSnapshots
   */
  ShareHasSnapshots: "ShareHasSnapshots",

  /**
   * PreviousSnapshotNotFound
   */
  PreviousSnapshotNotFound: "PreviousSnapshotNotFound",

  /**
   * ContainerQuotaDowngradeNotAllowed
   */
  ContainerQuotaDowngradeNotAllowed: "ContainerQuotaDowngradeNotAllowed",

  /**
   * AuthorizationSourceIPMismatch
   */
  AuthorizationSourceIPMismatch: "AuthorizationSourceIPMismatch",

  /**
   * AuthorizationProtocolMismatch
   */
  AuthorizationProtocolMismatch: "AuthorizationProtocolMismatch",

  /**
   * AuthorizationPermissionMismatch
   */
  AuthorizationPermissionMismatch: "AuthorizationPermissionMismatch",

  /**
   * AuthorizationServiceMismatch
   */
  AuthorizationServiceMismatch: "AuthorizationServiceMismatch",

  /**
   * AuthorizationResourceTypeMismatch
   */
  AuthorizationResourceTypeMismatch: "AuthorizationResourceTypeMismatch",

  /**
   * FeatureVersionMismatch
   */
  FeatureVersionMismatch: "FeatureVersionMismatch",

  /**
   * ShareSnapshotNotFound
   */
  ShareSnapshotNotFound: "ShareSnapshotNotFound",

  /**
   * FileShareProvisionedIopsInvalid
   */
  FileShareProvisionedIopsInvalid: "FileShareProvisionedIopsInvalid",

  /**
   * FileShareProvisionedBandwidthInvalid
   */
  FileShareProvisionedBandwidthInvalid: "FileShareProvisionedBandwidthInvalid",

  /**
   * FileShareProvisionedStorageInvalid
   */
  FileShareProvisionedStorageInvalid: "FileShareProvisionedStorageInvalid",

  /**
   * TotalSharesProvisionedCapacityExceedsAccountLimit
   */
  TotalSharesProvisionedCapacityExceedsAccountLimit: "TotalSharesProvisionedCapacityExceedsAccountLimit",

  /**
   * TotalSharesProvisionedIopsExceedsAccountLimit
   */
  TotalSharesProvisionedIopsExceedsAccountLimit: "TotalSharesProvisionedIopsExceedsAccountLimit",

  /**
   * TotalSharesProvisionedBandwidthExceedsAccountLimit
   */
  TotalSharesProvisionedBandwidthExceedsAccountLimit: "TotalSharesProvisionedBandwidthExceedsAccountLimit",

  /**
   * TotalSharesCountExceedsAccountLimit
   */
  TotalSharesCountExceedsAccountLimit: "TotalSharesCountExceedsAccountLimit",
}

/** The access tier of the share. */
union ShareAccessTier {
  string,

  /**
   * TransactionOptimized
   */
  TransactionOptimized: "TransactionOptimized",

  /**
   * Hot
   */
  Hot: "Hot",

  /**
   * Cool
   */
  Cool: "Cool",

  /**
   * Premium
   */
  Premium: "Premium",
}

/** The share token intent. */
union ShareTokenIntent {
  string,

  /**
   * backup
   */
  backup: "backup",
}

/** The NFS file type. */
union NfsFileType {
  string,

  /**
   * Regular
   */
  Regular: "Regular",

  /**
   * Directory
   */
  Directory: "Directory",

  /**
   * SymLink
   */
  SymLink: "SymLink",
}

/** The file property semantics. */
union FilePropertySemantics {
  string,

  /**
   * New
   */
  New: "New",

  /**
   * Restore
   */
  Restore: "Restore",
}

/**
 * Access rights of the access policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum AccessRight {
  /**
   * Read
   */
  Read,

  /**
   * Write
   */
  Write,

  /**
   * Delete
   */
  Delete,
}

/**
 * The current lease status of the share.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum LeaseStatusType {
  /**
   * locked
   */
  locked,

  /**
   * unlocked
   */
  unlocked,
}

/**
 * Lease state of the share.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum LeaseStateType {
  /**
   * available
   */
  available,

  /**
   * leased
   */
  leased,

  /**
   * expired
   */
  expired,

  /**
   * breaking
   */
  breaking,

  /**
   * broken
   */
  broken,
}

/**
 * When a share is leased, specifies whether the lease is of infinite or fixed
 * duration.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum LeaseDurationType {
  /**
   * infinite
   */
  infinite,

  /**
   * fixed
   */
  fixed,
}

/** The root squash setting for the share. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ShareRootSquash {
  /**
   * NoRootSquash
   */
  NoRootSquash,

  /**
   * RootSquash
   */
  RootSquash,

  /**
   * AllSquash
   */
  AllSquash,
}

/** The file permission format. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum FilePermissionFormat {
  /**
   * Sddl
   */
  Sddl,

  /**
   * Binary
   */
  Binary,
}

/** The type of file information to include in the listing. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ListFilesIncludeType {
  /**
   * Timestamps
   */
  Timestamps,

  /**
   * Etag
   */
  Etag,

  /**
   * Attributes
   */
  Attributes,

  /**
   * PermissionKey
   */
  PermissionKey,
}

/** The type of share information to include in the listing. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ListSharesIncludeType {
  /**
   * snapshots
   */
  snapshots,

  /**
   * metadata
   */
  metadata,

  /**
   * deleted
   */
  deleted,
}

/** The permission copy mode type. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum PermissionCopyModeType {
  /**
   * source
   */
  source,

  /**
   * override
   */
  override,
}

/** The mode copy mode. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ModeCopyMode {
  /**
   * source
   */
  source,

  /**
   * override
   */
  override,
}

/** The owner copy mode. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum OwnerCopyMode {
  /**
   * source
   */
  source,

  /**
   * override
   */
  override,
}

/** The delete snapshots option type. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum DeleteSnapshotsOptionType {
  /**
   * include
   */
  include,

  /**
   * include-leased
   */
  `include-leased`,
}

/** The file last written mode. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum FileLastWrittenMode {
  /**
   * Now
   */
  Now,

  /**
   * Preserve
   */
  Preserve,
}

/**
 * An Access policy.
 */
model AccessPolicy {
  /**
   * The date-time the policy is active.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("Start") start?: utcDateTime;

  /**
   * The date-time the policy expires.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("Expiry") expiry?: utcDateTime;

  /**
   * The permissions for the ACL policy.
   */
  @Xml.name("Permission") permission?: string;
}

/**
 * CORS is an HTTP feature that enables a web application running under one domain
 * to access resources in another domain. Web browsers implement a security
 * restriction known as same-origin policy that prevents a web page from calling
 * APIs in a different domain; CORS provides a secure way to allow one domain (the
 * origin domain) to call APIs in another domain.
 */
model CorsRule {
  /**
   * The origin domains that are permitted to make a request against the storage
   * service via CORS. The origin domain is the domain from which the request
   * originates. Note that the origin must be an exact case-sensitive match with the
   * origin that the user age sends to the service. You can also use the wildcard
   * character '*' to allow all origin domains to make requests via CORS.
   */
  @Xml.name("AllowedOrigins") allowedOrigins: string;

  /**
   * The methods (HTTP request verbs) that the origin domain may use for a CORS
   * request. (comma separated)
   */
  @Xml.name("AllowedMethods") allowedMethods: string;

  /**
   * The request headers that the origin domain may specify on the CORS request.
   */
  @Xml.name("AllowedHeaders") allowedHeaders: string;

  /**
   * The response headers that may be sent in the response to the CORS request and
   * exposed by the browser to the request issuer.
   */
  @Xml.name("ExposedHeaders") exposedHeaders: string;

  /**
   * The maximum amount time that a browser should cache the preflight OPTIONS
   * request.
   */
  @Xml.name("MaxAgeInSeconds") maxAgeInSeconds: int32;
}

/**
 * Abstract for entries that can be listed from Directory.
 */
@Xml.name("Entries")
model FilesAndDirectoriesListSegment {
  /** The directory items. */
  @Xml.unwrapped
  @Xml.name("DirectoryItems")
  directoryItems: DirectoryItem[];

  /** The file items. */
  @Xml.unwrapped
  @Xml.name("FileItems")
  fileItems: FileItem[];
}

/**
 * A listed directory item.
 */
@Xml.name("Directory")
model DirectoryItem {
  /** The directory name. */
  @Xml.name("Name") name: StringEncoded;

  /** The file ID. */
  @Xml.name("FileId") fileId?: string;

  /**
   * File properties.
   */
  @Xml.name("Properties") properties?: FileProperty;

  /** The file attributes. */
  @Xml.name("Attributes") attributes?: string;

  /** The permission key. */
  @Xml.name("PermissionKey") permissionKey?: string;
}

/** An encoded string value. */
model StringEncoded {
  /** Whether the value is encoded. */
  @Xml.attribute
  @Xml.name("Encoded")
  encoded?: boolean;

  /** The string content. */
  @Xml.unwrapped content?: string;
}

/**
 * File properties.
 */
model FileProperty {
  /**
   * Content length of the file. This value may not be up-to-date since an SMB
   * client may have modified the file locally. The value of Content-Length may not
   * reflect that fact until the handle is closed or the op-lock is broken. To
   * retrieve current property values, call Get File Properties.
   */
  @Xml.name("Content-Length") contentLength: int64;

  /** The creation time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("CreationTime") creationTime?: utcDateTime;

  /** The last access time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("LastAccessTime") lastAccessTime?: utcDateTime;

  /** The last write time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("LastWriteTime") lastWriteTime?: utcDateTime;

  /** The change time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("ChangeTime") changeTime?: utcDateTime;

  /** The last modified time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("Last-Modified") lastModified?: utcDateTime;

  /** The ETag of the file. */
  @Xml.name("Etag") eTag?: string;
}

/**
 * A listed file item.
 */
@Xml.name("File")
model FileItem {
  /** The file name. */
  @Xml.name("Name") name: StringEncoded;

  /** The file ID. */
  @Xml.name("FileId") fileId?: string;

  /**
   * File properties.
   */
  @Xml.name("Properties") properties: FileProperty;

  /** The file attributes. */
  @Xml.name("Attributes") attributes?: string;

  /** The permission key. */
  @Xml.name("PermissionKey") permissionKey?: string;
}

/**
 * A listed Azure Storage handle item.
 */
@Xml.name("Handle")
model HandleItem {
  /**
   * XSMB service handle ID
   */
  @Xml.name("HandleId") handleId: string;

  /** The path. */
  @Xml.name("Path") path: StringEncoded;

  /**
   * FileId uniquely identifies the file or directory.
   */
  @Xml.name("FileId") fileId: string;

  /**
   * ParentId uniquely identifies the parent directory of the object.
   */
  @Xml.name("ParentId") parentId?: string;

  /**
   * SMB session ID in context of which the file handle was opened
   */
  @Xml.name("SessionId") sessionId: string;

  /**
   * Client IP that opened the handle
   */
  @Xml.name("ClientIp") clientIp: string;

  /**
   * Name of the client machine where the share is being mounted
   */
  @Xml.name("ClientName") clientName: string;

  /**
   * Time when the session that previously opened the handle has last been
   * reconnected. (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("OpenTime") openTime: utcDateTime;

  /**
   * Time handle was last connected to (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("LastReconnectTime") lastReconnectTime?: utcDateTime;

  /** The access rights. */
  @Xml.name("AccessRightList") accessRightList?: AccessRight[];
}

/**
 * An enumeration of directories and files.
 */
@Xml.name("EnumerationResults")
model ListFilesAndDirectoriesSegmentResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The share name. */
  @Xml.attribute
  @Xml.name("ShareName")
  shareName: string;

  /** The share snapshot. */
  @Xml.attribute
  @Xml.name("ShareSnapshot")
  shareSnapshot?: string;

  /** Whether the listing is encoded. */
  @Xml.attribute
  @Xml.name("Encoded")
  encoded?: boolean;

  /** The directory path. */
  @Xml.attribute
  @Xml.name("DirectoryPath")
  directoryPath: string;

  /** The prefix. */
  @Xml.name("Prefix") prefix: StringEncoded;

  /** The marker. */
  @Xml.name("Marker") marker?: string;

  /** The max results. */
  @Xml.name("MaxResults") maxResults?: int32;

  /**
   * Abstract for entries that can be listed from Directory.
   */
  @Xml.name("Segment") segment: FilesAndDirectoriesListSegment;

  /** The next marker. */
  @Xml.name("NextMarker") nextMarker: string;

  /** The directory ID. */
  @Xml.name("DirectoryId") directoryId?: string;
}

/**
 * An enumeration of handles.
 */
@Xml.name("EnumerationResults")
model ListHandlesResponse {
  /** The handle list. */
  @Xml.name("Entries") handleList?: HandleItem[];

  /** The next marker. */
  @Xml.name("NextMarker") nextMarker: string;
}

/**
 * An enumeration of shares.
 */
@Xml.name("EnumerationResults")
model ListSharesResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The prefix. */
  @Xml.name("Prefix") prefix?: string;

  /** The marker. */
  @Xml.name("Marker") marker?: string;

  /** The max results. */
  @Xml.name("MaxResults") maxResults?: int32;

  /** The share items. */
  @pageItems
  @Xml.name("Shares")
  shareItems?: ShareItemInternal[];

  /** The next marker. */
  @continuationToken
  @Xml.name("NextMarker")
  nextMarker: string;
}

/**
 * A listed Azure Storage share item.
 */
@Xml.name("Share")
model ShareItemInternal {
  /** The share name. */
  @Xml.name("Name") name: string;

  /** The share snapshot. */
  @Xml.name("Snapshot") snapshot?: string;

  /** Whether the share is deleted. */
  @Xml.name("Deleted") deleted?: boolean;

  /** The share version. */
  @Xml.name("Version") version?: string;

  /**
   * Properties of a share.
   */
  @Xml.name("Properties") properties: SharePropertiesInternal;

  /**
   * Dictionary of <string>
   */
  @Xml.name("Metadata") metadata?: Record<string>;
}

/**
 * Properties of a share.
 */
model SharePropertiesInternal {
  /** The last modified time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("Last-Modified") lastModified: utcDateTime;

  /** The ETag of the share. */
  @Xml.name("Etag") eTag: string;

  /** The share quota. */
  @Xml.name("Quota") quota: int32;

  /** The provisioned IOPS. */
  @Xml.name("ProvisionedIops") provisionedIops?: int32;

  /** The provisioned ingress in MBps. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API. The casing is correct."
  @Xml.name("ProvisionedIngressMBps") provisionedIngressMBps?: int32;

  /** The provisioned egress in MBps. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API. The casing is correct."
  @Xml.name("ProvisionedEgressMBps") provisionedEgressMBps?: int32;

  /** The provisioned bandwidth in MiBps. */
  @Xml.name("ProvisionedBandwidthMiBps") provisionedBandwidthMiBps?: int32;

  /** The next allowed quota downgrade time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("NextAllowedQuotaDowngradeTime")
  nextAllowedQuotaDowngradeTime?: utcDateTime;

  /** The deleted time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("DeletedTime") deletedTime?: utcDateTime;

  /** The remaining retention days. */
  @Xml.name("RemainingRetentionDays") remainingRetentionDays?: int32;

  /** The access tier. */
  @Xml.name("AccessTier") accessTier?: string;

  /** The access tier change time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("AccessTierChangeTime") accessTierChangeTime?: utcDateTime;

  /** The access tier transition state. */
  @Xml.name("AccessTierTransitionState") accessTierTransitionState?: string;

  /**
   * The current lease status of the share.
   */
  @Xml.name("LeaseStatus") leaseStatus?: LeaseStatusType;

  /**
   * Lease state of the share.
   */
  @Xml.name("LeaseState") leaseState?: LeaseStateType;

  /**
   * When a share is leased, specifies whether the lease is of infinite or fixed
   * duration.
   */
  @Xml.name("LeaseDuration") leaseDuration?: LeaseDurationType;

  /** The enabled protocols. */
  @Xml.name("EnabledProtocols") enabledProtocols?: string;

  /** The root squash setting. */
  @Xml.name("RootSquash") rootSquash?: ShareRootSquash;

  /** Whether snapshot virtual directory access is enabled. */
  @Xml.name("EnableSnapshotVirtualDirectoryAccess")
  enableSnapshotVirtualDirectoryAccess?: boolean;

  /** Whether paid bursting is enabled. */
  @Xml.name("PaidBurstingEnabled") paidBurstingEnabled?: boolean;

  /** The maximum IOPS for paid bursting. */
  @Xml.name("PaidBurstingMaxIops") paidBurstingMaxIops?: int64;

  /** The maximum bandwidth for paid bursting in MiBps. */
  @Xml.name("PaidBurstingMaxBandwidthMibps")
  paidBurstingMaxBandwidthMibps?: int64;

  /** The included burst IOPS. */
  @Xml.name("IncludedBurstIops") includedBurstIops?: int64;

  /** The maximum burst credits for IOPS. */
  @Xml.name("MaxBurstCreditsForIops") maxBurstCreditsForIops?: int64;

  /** The next allowed provisioned IOPS downgrade time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("NextAllowedProvisionedIopsDowngradeTime")
  nextAllowedProvisionedIopsDowngradeTime?: utcDateTime;

  /** The next allowed provisioned bandwidth downgrade time. */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("NextAllowedProvisionedBandwidthDowngradeTime")
  nextAllowedProvisionedBandwidthDowngradeTime?: utcDateTime;

  /** Whether SMB directory lease is enabled. */
  @Xml.name("EnableSmbDirectoryLease") enableSmbDirectoryLease?: boolean;
}

/**
 * Storage Analytics metrics for file service.
 */
model Metrics {
  /**
   * The version of Storage Analytics to configure.
   */
  @Xml.name("Version") version: string;

  /**
   * Indicates whether metrics are enabled for the File service.
   */
  @Xml.name("Enabled") enabled: boolean;

  /**
   * Indicates whether metrics should generate summary statistics for called API
   * operations.
   */
  @Xml.name("IncludeAPIs") includeApis?: boolean;

  /**
   * The retention policy.
   */
  @Xml.name("RetentionPolicy") retentionPolicy?: RetentionPolicy;
}

/**
 * The retention policy.
 */
model RetentionPolicy {
  /**
   * Indicates whether a retention policy is enabled for the File service. If false,
   * metrics data is retained, and the user is responsible for deleting it.
   */
  @Xml.name("Enabled") enabled: boolean;

  /**
   * Indicates the number of days that metrics data should be retained. All data
   * older than this value will be deleted. Metrics data is deleted on a best-effort
   * basis after the retention period expires.
   */
  @Xml.name("Days")
  @maxValue(365)
  @minValue(1)
  days?: int32;
}

/**
 * Settings for SMB multichannel
 */
@Xml.name("Multichannel")
model SmbMultichannel {
  /**
   * If SMB multichannel is enabled.
   */
  @Xml.name("Enabled") enabled?: boolean;
}

/**
 * An Azure Storage file range.
 */
@Xml.name("Range")
model FileRange {
  /**
   * Start of the range.
   */
  @Xml.name("Start") start: int64;

  /**
   * End of the range.
   */
  @Xml.name("End") end: int64;
}

/** A clear range. */
@Xml.name("ClearRange")
model ClearRange {
  /** Start of the range. */
  @Xml.name("Start") start: int64;

  /** End of the range. */
  @Xml.name("End") end: int64;
}

/**
 * Protocol settings
 */
@Xml.name("ProtocolSettings")
model ShareProtocolSettings {
  /**
   * Settings for SMB protocol.
   */
  @Xml.name("Smb") smb?: ShareSmbSettings;

  /**
   * Settings for NFS protocol.
   */
  @Xml.name("Nfs") nfs?: ShareNfsSettings;
}

/**
 * Settings for SMB protocol.
 */
@Xml.name("SMB")
model ShareSmbSettings {
  /**
   * Settings for SMB Multichannel.
   */
  @Xml.name("Multichannel") multichannel?: SmbMultichannel;

  /**
   * Enable or disable encryption in transit.
   */
  @Xml.name("EncryptionInTransit")
  encryptionInTransit?: ShareSmbSettingsEncryptionInTransit;
}

/**
 * Enable or disable encryption in transit.
 */
model ShareSmbSettingsEncryptionInTransit {
  /**
   * If encryption in transit is required
   */
  @Xml.name("Required") required?: boolean;
}

/**
 * Settings for SMB protocol.
 */
@Xml.name("NFS")
model ShareNfsSettings {
  /**
   * Enable or disable encryption in transit.
   */
  @Xml.name("EncryptionInTransit")
  encryptionInTransit?: ShareNfsSettingsEncryptionInTransit;
}

/**
 * Enable or disable encryption in transit.
 */
model ShareNfsSettingsEncryptionInTransit {
  /**
   * If encryption in transit is required
   */
  @Xml.name("Required") required?: boolean;
}

/**
 * The list of file ranges
 */
model ShareFileRangeList {
  /** The file ranges. */
  @Xml.unwrapped
  @Xml.name("Ranges")
  ranges?: FileRange[];

  /** The clear ranges. */
  @Xml.unwrapped
  @Xml.name("ClearRanges")
  clearRanges?: ClearRange[];
}

/**
 * The error response.
 *
 * This defines the wire format only. Language SDKs wrap this in idiomatic error types.
 */
@error
@mediaTypeHint("application/xml")
model Error {
  /** The error code. */
  @header("x-ms-error-code")
  errorCode?: string;

  /** The error code for the copy source. */
  @header("x-ms-copy-source-error-code")
  xMsCopySourceErrorCode?: string;

  /** The status code for the copy source. */
  @header("x-ms-copy-source-status-code")
  xMsCopySourceStatusCode?: int32;

  /** The error code. */
  @Xml.name("Code") code?: StorageErrorCode;

  /** The error message. */
  @Xml.name("Message") message?: string;

  /** Copy source status code */
  @Xml.name("CopySourceStatusCode") copySourceStatusCode?: int32;

  /** Copy source error code */
  @Xml.name("CopySourceErrorCode") copySourceErrorCode?: string;

  /** Copy source error message */
  @Xml.name("CopySourceErrorMessage") copySourceErrorMessage?: string;
}

/**
 * Stats for the share.
 */
model ShareStats {
  /**
   * The approximate size of the data stored in bytes. Note that this value may not
   * include all recently created or recently resized files.
   */
  @Xml.name("ShareUsageBytes") shareUsageBytes: int32;
}

/**
 * Signed identifier.
 */
model SignedIdentifier {
  /**
   * A unique id.
   */
  @Xml.name("Id") id: string;

  /**
   * The access policy.
   */
  @Xml.name("AccessPolicy") accessPolicy?: AccessPolicy;
}

/**
 * Storage service properties.
 */
model StorageServiceProperties {
  /**
   * A summary of request statistics grouped by API in hourly aggregates for files.
   */
  @Xml.name("HourMetrics") hourMetrics?: Metrics;

  /**
   * A summary of request statistics grouped by API in minute aggregates for files.
   */
  @Xml.name("MinuteMetrics") minuteMetrics?: Metrics;

  /**
   * The set of CORS rules.
   */
  @Xml.name("Cors") cors?: CorsRule[];

  /**
   * Protocol settings
   */
  @Xml.name("Protocol") protocol?: ShareProtocolSettings;
}

/**
 * A permission (a security descriptor) at the share level.
 */
model SharePermission {
  /**
   * The permission in the Security Descriptor Definition Language (SDDL).
   */
  permission: string;

  /** The permission format. */
  format?: FilePermissionFormat;
}

/**
 * Key information
 */
model KeyInfo {
  /**
   * The date-time the key is active in ISO 8601 UTC time
   */
  @Xml.name("Start") start?: string;

  /**
   * The date-time the key expires in ISO 8601 UTC time
   */
  @Xml.name("Expiry") expiry: string;

  /**
   * The delegated user tenant id in Azure AD
   */
  @Xml.name("DelegatedUserTid") delegatedUserTid?: string;
}

/**
 * A user delegation key
 */
model UserDelegationKey {
  /**
   * The Azure Active Directory object ID in GUID format.
   */
  @Xml.name("SignedOid") signedOid: string;

  /**
   * The Azure Active Directory tenant ID in GUID format
   */
  @Xml.name("SignedTid") signedTid: string;

  /**
   * The date-time the key is active
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("SignedStart") signedStart: utcDateTime;

  /**
   * The date-time the key expires
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @Xml.name("SignedExpiry") signedExpiry: utcDateTime;

  /**
   * Abbreviation of the Azure Storage service that accepts the key
   */
  @Xml.name("SignedService") signedService: string;

  /**
   * The service version that created the key
   */
  @Xml.name("SignedVersion") signedVersion: string;

  /**
   * The delegated user tenant id in Azure AD. Return if DelegatedUserTid is
   * specified.
   */
  @Xml.name("SignedDelegatedUserTid") signedDelegatedUserTid?: string;

  /**
   * The key as a base64 string
   */
  @Xml.name("Value") value: string;
}

//
/** Specify one of the following options: - Update: Writes the bytes specified by the request body into the specified range. - Clear: Clears the specified range and releases the space used in storage for that range. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum FileRangeWriteType {
  /** Writes the bytes specified by the request body into the specified range. */
  update: "update",

  /** Clears the specified range and releases the space used in storage for that range. */
  clear: "clear",
}

/** Only update is supported: - Update: Writes the bytes downloaded from the source url into the specified range. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum FileRangeWriteFromUrlType {
  /** Writes the bytes specified by the source URL into the specified range. */
  update: "update",
}

/** Share name path parameter. */
alias ShareNamePathParameter = {
  /** The name of the target share. */
  @path shareName: string;
};

/** Directory path parameter. */
alias DirectoryPathParameter = {
  /** The path of the target directory. */
  @path directory: string;
};

/** File name path parameter. */
alias FileNamePathParameter = {
  /** The path of the target file. */
  @path fileName: string;
};

/** API version header alias */
alias ApiVersionHeader = {
  /** Specifies the version of the operation to use for this request. */
  @apiVersion
  @header("x-ms-version")
  apiVersion: string;
};

/** The timeout parameter. */
alias TimeoutParameter = {
  @doc("The timeout parameter is expressed in seconds.")
  @query
  @minValue(0)
  timeout?: int32;
};

/** The marker parameter for pagination. */
alias MarkerParameter = {
  /** A string value that identifies the portion of the list to be returned with the next listing operation. */
  @query
  @continuationToken
  marker?: string;
};

/** The max results parameter. */
alias MaxResultsParameter = {
  /** Specifies the maximum number of items to return. */
  @query
  @minValue(1)
  maxresults?: int32;
};

/** The prefix parameter for filtering. */
alias PrefixParameter = {
  /** Filters the results to return only items whose name begins with the specified prefix. */
  @query
  prefix?: string;
};

/** Client request ID header. */
alias ClientRequestIdHeader = {
  /** An opaque, globally-unique, client-generated string identifier for the request. */
  @header("x-ms-client-request-id")
  clientRequestId?: string;
};

/** Request ID response header. */
alias RequestIdResponseHeader = {
  /** An opaque, globally-unique, server-generated string identifier for the request. */
  @header("x-ms-request-id")
  requestId: string;
};

/** File request intent parameter. */
alias FileRequestIntentParameter = {
  /** Valid values are 'backup'. */
  @header("x-ms-file-request-intent")
  fileRequestIntent?: ShareTokenIntent;
};

/** Allow trailing dot parameter. */
alias AllowTrailingDotParameter = {
  /** If true, the trailing dot will not be trimmed from the target file/directory path. */
  @header("x-ms-allow-trailing-dot")
  allowTrailingDot?: boolean;
};

/** Source allow trailing dot parameter. */
alias SourceAllowTrailingDotParameter = {
  /** If true, the trailing dot will not be trimmed from the source URI. */
  @header("x-ms-source-allow-trailing-dot")
  sourceAllowTrailingDot?: boolean;
};

/** Share snapshot parameter. */
alias ShareSnapshotParameter = {
  /** The snapshot parameter is an opaque DateTime value that specifies a share snapshot. */
  @query
  sharesnapshot?: string;
};

/** Common metadata headers. */
alias MetadataHeaders = {
  /** Optional. User-defined metadata for the resource. */
  @header("x-ms-meta")
  metadata?: string;
};

/** ETag response header. */
alias EtagResponseHeader = {
  /** The ETag contains a value that represents the version of the resource. */
  @header("ETag")
  etag: string;
};

/** Last modified response header. */
alias LastModifiedResponseHeader = {
  /** Returns the date and time the resource was last modified. */
  @header("Last-Modified")
  @encode("rfc7231")
  lastModified: utcDateTime;
};

/** Date response header. */
alias DateResponseHeader = {
  /** A GMT date/time value generated by the service that indicates the time the response was initiated. */
  @access(Access.internal)
  @header("Date")
  @encode("rfc7231")
  date: utcDateTime;
};

/** Content length parameter (standard Content-Length). */
alias ContentLengthParameter = {
  /** The number of bytes of data in the request body. */
  @header("Content-Length")
  contentLength: int64;
};

/** Range header. */
alias RangeHeader = {
  /** Return file data only from the specified byte range. */
  @header("Range")
  range?: string;
};

/** Lease ID parameter. */
alias LeaseIdOptionalParameter = {
  /** If specified, the lease ID must match the lease ID of the file. */
  @header("x-ms-lease-id")
  leaseId?: string;
};

alias LeaseIdRequiredParameter = {
  /** Specifies the current lease ID on the resource. */
  @header("x-ms-lease-id")
  leaseId: string;
};

/** Share quota optional header. */
alias ShareQuotaOptionalHeader = {
  /** Specifies the maximum size of the share, in gigabytes. */
  @header("x-ms-share-quota") shareQuota?: int32;
};

/** Recursive parameter (header). */
alias RecursiveParameter = {
  /** Specifies operation should apply to the directory specified in the URI, its files, its subdirectories and their files. */
  @header("x-ms-recursive")
  recursive?: boolean;
};

//
// SMB/NFS File Property Headers (shared across many operations)
//

/** SMB file property request headers for setting file/directory attributes. */
alias FileSmtPropertyRequestHeaders = {
  /** If specified the permission (security descriptor) shall be set for the directory/file. This header can be used if Permission size is <= 8KB, else x-ms-file-permission-key header shall be used. Default value: Inherit. If SDDL is specified as input, it must have owner, group and dacl. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
  @header("x-ms-file-permission") filePermission?: string;

  /** Key of the permission to be set for the directory/file. Note: Only one of the x-ms-file-permission or x-ms-file-permission-key should be specified. */
  @header("x-ms-file-permission-key") filePermissionKey?: string;

  /** If specified, the provided file attributes shall be set. Default value: 'Archive' for file and 'Directory' for directory. 'None' can also be specified as default. */
  @header("x-ms-file-attributes") fileAttributes?: string;

  /** Creation time for the file/directory. Default value: Now. */
  @header("x-ms-file-creation-time") fileCreationTime?: string;

  /** Last write time for the file/directory. Default value: Now. */
  @header("x-ms-file-last-write-time") fileLastWriteTime?: string;

  /** Change time for the file/directory. Default value: Now. */
  @header("x-ms-file-change-time") fileChangeTime?: string;
};

/** File permission format parameter. */
alias FilePermissionFormatParameter = {
  /** Optional. Used to set permission format. */
  @header("x-ms-file-permission-format")
  filePermissionFormat?: FilePermissionFormat;
};

/** SMB file property response headers returned from file/directory operations. */
alias FileSmtPropertyResponseHeaders = {
  /** Key of the permission set for the directory/file. */
  @header("x-ms-file-permission-key") filePermissionKey?: string;

  /** Attributes set for the file/directory. */
  @header("x-ms-file-attributes") fileAttributes?: string;

  /** Creation time for the file/directory. */
  @header("x-ms-file-creation-time")
  @encode("rfc7231")
  fileCreationTime?: utcDateTime;

  /** Last write time for the file/directory. */
  @header("x-ms-file-last-write-time")
  @encode("rfc7231")
  fileLastWriteTime?: utcDateTime;

  /** Change time for the file/directory. */
  @header("x-ms-file-change-time")
  @encode("rfc7231")
  fileChangeTime?: utcDateTime;

  /** The fileId of the directory/file. */
  @header("x-ms-file-id") fileId?: string;

  /** The parent fileId of the directory/file. */
  @header("x-ms-file-parent-id") fileParentId?: string;
};

/** NFS property request headers (owner, group, mode). */
alias NfsRequestHeaders = {
  /** Optional, NFS only. The owner of the file or directory. */
  @header("x-ms-owner") owner?: string;

  /** Optional, NFS only. The owning group of the file or directory. */
  @header("x-ms-group") group?: string;

  /** Optional, NFS only. The file mode of the file or directory. */
  @header("x-ms-mode") mode?: string;
};

/** NFS property response headers. */
alias NfsResponseHeaders = {
  /** NFS only. The file mode. */
  @header("x-ms-mode") mode?: string;

  /** NFS only. The owner. */
  @header("x-ms-owner") owner?: string;

  /** NFS only. The owning group. */
  @header("x-ms-group") group?: string;

  /** NFS only. The file type. */
  @header("x-ms-file-file-type") nfsFileType?: NfsFileType;
};

//
// File Content Headers (x-ms-content-* for setting file HTTP properties)
//

/** File content request headers for setting file HTTP properties. */
alias FileContentRequestHeaders = {
  /** Sets the MIME content type of the file. The default type is 'application/octet-stream'. */
  @header("x-ms-content-type") fileContentType?: string;

  /** Specifies which content encodings have been applied to the file. */
  @header("x-ms-content-encoding") fileContentEncoding?: string;

  /** Specifies the natural languages used by this resource. */
  @header("x-ms-content-language") fileContentLanguage?: string;

  /** Sets the file's cache control. The File service stores this value but does not use or modify it. */
  @header("x-ms-cache-control") fileCacheControl?: string;

  /** An MD5 hash of the file content. This hash is used to verify the integrity of the file during transport. */
  @header("x-ms-content-md5") fileContentMd5?: string;

  /** Sets the file's Content-Disposition header. */
  @header("x-ms-content-disposition") fileContentDisposition?: string;
};

//
// Share Paid Bursting Headers
//

/** Paid bursting request headers for share operations. */
alias PaidBurstingRequestHeaders = {
  /** Optional. Boolean. Default if not specified is false. This property enables paid bursting. */
  @header("x-ms-share-paid-bursting-enabled") paidBurstingEnabled?: boolean;

  /** Optional. Integer. Default if not specified is the maximum IOPS the file share can support. Current maximum for a file share is 102,400 IOPS. */
  @header("x-ms-share-paid-bursting-max-iops") paidBurstingMaxIops?: int64;

  /** Optional. Integer. Default if not specified is the maximum throughput the file share can support. Current maximum for a file share is 10,340 MiB/sec. */
  @header("x-ms-share-paid-bursting-max-bandwidth-mibps")
  paidBurstingMaxBandwidthMibps?: int64;
};

/** Paid bursting response headers for share get properties. */
alias PaidBurstingResponseHeaders = {
  /** Whether paid bursting is enabled. */
  @header("x-ms-share-paid-bursting-enabled") paidBurstingEnabled?: boolean;

  /** The maximum IOPS for paid bursting. */
  @header("x-ms-share-paid-bursting-max-iops") paidBurstingMaxIops?: int64;

  /** The maximum bandwidth for paid bursting. */
  @header("x-ms-share-paid-bursting-max-bandwidth-mibps")
  paidBurstingMaxBandwidthMibps?: int64;

  /** The included burst IOPS. */
  @header("x-ms-share-included-burst-iops") includedBurstIops?: int64;

  /** The maximum burst credits for IOPS. */
  @header("x-ms-share-max-burst-credits-for-iops")
  maxBurstCreditsForIops?: int64;
};

//
// Copy Status Response Headers
//

/** Copy status response headers. */
alias CopyStatusResponseHeaders = {
  /** Conclusion time of the last attempted Copy File operation. */
  @header("x-ms-copy-completion-time") copyCompletionTime?: string;

  /** Only appears when x-ms-copy-status is failed or pending. */
  @header("x-ms-copy-status-description") copyStatusDescription?: string;

  /** String identifier for the last attempted Copy File operation. */
  @header("x-ms-copy-id") copyId?: string;

  /** Contains the number of bytes copied and the total bytes in the source. */
  @header("x-ms-copy-progress") copyProgress?: string;

  /** URL up to 2 KB in length that specifies the source blob or file. */
  @header("x-ms-copy-source") copySource?: string;

  /** State of the copy operation identified by x-ms-copy-id. */
  @header("x-ms-copy-status") copyStatus?: string;
};

/** Lease response headers. */
alias LeaseResponseHeaders = {
  /** The lease duration. */
  @header("x-ms-lease-duration") leaseDuration?: string;

  /** The lease state. */
  @header("x-ms-lease-state") leaseState?: string;

  /** The lease status. */
  @header("x-ms-lease-status") leaseStatus?: string;
};

/** Request server encrypted response header. */
alias RequestServerEncryptedResponseHeader = {
  /** The value of this header is set to true if the contents of the request are successfully encrypted. */
  @header("x-ms-request-server-encrypted") requestServerEncrypted?: boolean;
};

/** Rename request headers (shared by File_Rename and Directory_Rename). */
alias RenameRequestHeaders = {
  /** Required. Specifies the URI-style path of the source file, up to 2 KB in length. */
  @header("x-ms-file-rename-source") renameSource: string;

  /** Boolean. Default value is false. Set to true to indicate that the destination should be overwritten. */
  @header("x-ms-file-rename-replace-if-exists")
  renameReplaceIfExists?: boolean;

  /** Boolean. Default value is false. Set to true to overwrite the destination even if it has the read-only attribute set. */
  @header("x-ms-file-rename-ignore-readonly")
  renameIgnoreReadOnly?: boolean;

  /** Required if the source file has an active lease. */
  @header("x-ms-source-lease-id") sourceLeaseId?: string;
};

//
// Common Response Header Compositions
//

/** Standard File Storage success response headers. */
alias FileStorageResponseHeaders = ApiVersionHeader &
  RequestIdResponseHeader &
  DateResponseHeader;

/** Standard File Storage response with ETag and Last-Modified. */
alias FileStorageResourceHeaders = FileStorageResponseHeaders &
  EtagResponseHeader &
  LastModifiedResponseHeader;

alias OptionalBody = {
  /** Initial data. */
  @bodyRoot
  optionalBody?: bytes;
};

alias FileTypeParameter = {
  /** Dummy type header, must be "file". */
  @header("x-ms-type") fileType: "file";
};

alias ProposeLeaseIdParameter = {
  /** Proposed lease ID, in a GUID string format. The File service returns 400 (Invalid request) if the proposed lease ID is not in the correct format. See Guid Constructor (String) for a list of valid GUID string formats. */
  @header("x-ms-proposed-lease-id") proposedLeaseId?: string;
};
