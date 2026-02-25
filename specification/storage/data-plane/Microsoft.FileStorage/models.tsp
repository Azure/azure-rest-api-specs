import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace AzureFileStorage;

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

union ShareTokenIntent {
  string,

  /**
   * backup
   */
  backup: "backup",
}

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
  Start?: utcDateTime;

  /**
   * The date-time the policy expires.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  Expiry?: utcDateTime;

  /**
   * The permissions for the ACL policy.
   */
  Permission?: string;
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
  AllowedOrigins: string;

  /**
   * The methods (HTTP request verbs) that the origin domain may use for a CORS
   * request. (comma separated)
   */
  AllowedMethods: string;

  /**
   * The request headers that the origin domain may specify on the CORS request.
   */
  AllowedHeaders: string;

  /**
   * The response headers that may be sent in the response to the CORS request and
   * exposed by the browser to the request issuer.
   */
  ExposedHeaders: string;

  /**
   * The maximum amount time that a browser should cache the preflight OPTIONS
   * request.
   */
  MaxAgeInSeconds: int32;
}

/**
 * Abstract for entries that can be listed from Directory.
 */
model FilesAndDirectoriesListSegment {
  DirectoryItems: DirectoryItem[];
  FileItems: FileItem[];
}

/**
 * A listed directory item.
 */
model DirectoryItem {
  Name: StringEncoded;
  FileId?: string;

  /**
   * File properties.
   */
  Properties?: FileProperty;

  Attributes?: string;
  PermissionKey?: string;
}

model StringEncoded {
  Encoded?: boolean;
  content?: string;
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
  `Content-Length`: int64;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  CreationTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  LastAccessTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  LastWriteTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  ChangeTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  `Last-Modified`?: utcDateTime;

  Etag?: string;
}

/**
 * A listed file item.
 */
model FileItem {
  Name: StringEncoded;
  FileId?: string;

  /**
   * File properties.
   */
  Properties: FileProperty;

  Attributes?: string;
  PermissionKey?: string;
}

/**
 * A listed Azure Storage handle item.
 */
model HandleItem {
  /**
   * XSMB service handle ID
   */
  HandleId: string;

  Path: StringEncoded;

  /**
   * FileId uniquely identifies the file or directory.
   */
  FileId: string;

  /**
   * ParentId uniquely identifies the parent directory of the object.
   */
  ParentId?: string;

  /**
   * SMB session ID in context of which the file handle was opened
   */
  SessionId: string;

  /**
   * Client IP that opened the handle
   */
  ClientIp: string;

  /**
   * Name of the client machine where the share is being mounted
   */
  ClientName: string;

  /**
   * Time when the session that previously opened the handle has last been
   * reconnected. (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  OpenTime: utcDateTime;

  /**
   * Time handle was last connected to (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  LastReconnectTime?: utcDateTime;

  AccessRightList?: AccessRight[];
}

/**
 * An enumeration of directories and files.
 */
model ListFilesAndDirectoriesSegmentResponse {
  ServiceEndpoint: string;
  ShareName: string;
  ShareSnapshot?: string;
  Encoded?: boolean;
  DirectoryPath: string;
  Prefix: StringEncoded;
  Marker?: string;
  MaxResults?: int32;

  /**
   * Abstract for entries that can be listed from Directory.
   */
  Segment: FilesAndDirectoriesListSegment;

  NextMarker: string;
  DirectoryId?: string;
}

/**
 * An enumeration of handles.
 */
model ListHandlesResponse {
  HandleList?: HandleItem[];
  NextMarker: string;
}

/**
 * An enumeration of shares.
 */
model ListSharesResponse {
  ServiceEndpoint: string;
  Prefix?: string;
  Marker?: string;
  MaxResults?: int32;
  ShareItems?: ShareItemInternal[];
  NextMarker: string;
}

/**
 * A listed Azure Storage share item.
 */
model ShareItemInternal {
  Name: string;
  Snapshot?: string;
  Deleted?: boolean;
  Version?: string;

  /**
   * Properties of a share.
   */
  Properties: SharePropertiesInternal;

  /**
   * Dictionary of <string>
   */
  Metadata?: Record<string>;
}

/**
 * Properties of a share.
 */
model SharePropertiesInternal {
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  `Last-Modified`: utcDateTime;

  Etag: string;
  Quota: int32;
  ProvisionedIops?: int32;
  ProvisionedIngressMBps?: int32;
  ProvisionedEgressMBps?: int32;
  ProvisionedBandwidthMiBps?: int32;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  NextAllowedQuotaDowngradeTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  DeletedTime?: utcDateTime;

  RemainingRetentionDays?: int32;
  AccessTier?: string;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  AccessTierChangeTime?: utcDateTime;

  AccessTierTransitionState?: string;

  /**
   * The current lease status of the share.
   */
  LeaseStatus?: LeaseStatusType;

  /**
   * Lease state of the share.
   */
  LeaseState?: LeaseStateType;

  /**
   * When a share is leased, specifies whether the lease is of infinite or fixed
   * duration.
   */
  LeaseDuration?: LeaseDurationType;

  EnabledProtocols?: string;
  RootSquash?: ShareRootSquash;
  EnableSnapshotVirtualDirectoryAccess?: boolean;
  PaidBurstingEnabled?: boolean;
  PaidBurstingMaxIops?: int64;
  PaidBurstingMaxBandwidthMibps?: int64;
  IncludedBurstIops?: int64;
  MaxBurstCreditsForIops?: int64;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  NextAllowedProvisionedIopsDowngradeTime?: utcDateTime;

  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  NextAllowedProvisionedBandwidthDowngradeTime?: utcDateTime;

  EnableSmbDirectoryLease?: boolean;
}

/**
 * Storage Analytics metrics for file service.
 */
model Metrics {
  /**
   * The version of Storage Analytics to configure.
   */
  Version: string;

  /**
   * Indicates whether metrics are enabled for the File service.
   */
  Enabled: boolean;

  /**
   * Indicates whether metrics should generate summary statistics for called API
   * operations.
   */
  IncludeAPIs?: boolean;

  /**
   * The retention policy.
   */
  RetentionPolicy?: RetentionPolicy;
}

/**
 * The retention policy.
 */
model RetentionPolicy {
  /**
   * Indicates whether a retention policy is enabled for the File service. If false,
   * metrics data is retained, and the user is responsible for deleting it.
   */
  Enabled: boolean;

  /**
   * Indicates the number of days that metrics data should be retained. All data
   * older than this value will be deleted. Metrics data is deleted on a best-effort
   * basis after the retention period expires.
   */
  @maxValue(365)
  @minValue(1)
  Days?: int32;
}

/**
 * Settings for SMB multichannel
 */
model SmbMultichannel {
  /**
   * If SMB multichannel is enabled.
   */
  Enabled?: boolean;
}

/**
 * An Azure Storage file range.
 */
model FileRange {
  /**
   * Start of the range.
   */
  Start: int64;

  /**
   * End of the range.
   */
  End: int64;
}

model ClearRange {
  Start: int64;
  End: int64;
}

/**
 * Protocol settings
 */
model ShareProtocolSettings {
  /**
   * Settings for SMB protocol.
   */
  Smb?: ShareSmbSettings;

  /**
   * Settings for NFS protocol.
   */
  Nfs?: ShareNfsSettings;
}

/**
 * Settings for SMB protocol.
 */
model ShareSmbSettings {
  /**
   * Settings for SMB Multichannel.
   */
  Multichannel?: SmbMultichannel;

  /**
   * Enable or disable encryption in transit.
   */
  EncryptionInTransit?: ShareSmbSettingsEncryptionInTransit;
}

/**
 * Enable or disable encryption in transit.
 */
model ShareSmbSettingsEncryptionInTransit {
  /**
   * If encryption in transit is required
   */
  Required?: boolean;
}

/**
 * Settings for SMB protocol.
 */
model ShareNfsSettings {
  /**
   * Enable or disable encryption in transit.
   */
  EncryptionInTransit?: ShareNfsSettingsEncryptionInTransit;
}

/**
 * Enable or disable encryption in transit.
 */
model ShareNfsSettingsEncryptionInTransit {
  /**
   * If encryption in transit is required
   */
  Required?: boolean;
}

/**
 * The list of file ranges
 */
model ShareFileRangeList {
  Ranges?: FileRange[];
  ClearRanges?: ClearRange[];
}

@error
model StorageError {
  @statusCode statusCode: 400 | 403 | 404 | 409 | 500;
  @header("x-ms-error-code") errorCode?: string;
  Message?: string;
  CopySourceStatusCode?: int64;
  CopySourceErrorCode?: string;
  CopySourceErrorMessage?: string;
  AuthenticationErrorDetail?: string;
}

/**
 * Stats for the share.
 */
model ShareStats {
  /**
   * The approximate size of the data stored in bytes. Note that this value may not
   * include all recently created or recently resized files.
   */
  ShareUsageBytes: int32;
}

/**
 * Signed identifier.
 */
model SignedIdentifier {
  /**
   * A unique id.
   */
  Id: string;

  /**
   * The access policy.
   */
  AccessPolicy?: AccessPolicy;
}

/**
 * Storage service properties.
 */
model StorageServiceProperties {
  /**
   * A summary of request statistics grouped by API in hourly aggregates for files.
   */
  HourMetrics?: Metrics;

  /**
   * A summary of request statistics grouped by API in minute aggregates for files.
   */
  MinuteMetrics?: Metrics;

  /**
   * The set of CORS rules.
   */
  Cors?: CorsRule[];

  /**
   * Protocol settings
   */
  Protocol?: ShareProtocolSettings;
}

/**
 * A permission (a security descriptor) at the share level.
 */
model SharePermission {
  /**
   * The permission in the Security Descriptor Definition Language (SDDL).
   */
  permission: string;

  format?: FilePermissionFormat;
}

/**
 * Key information
 */
model KeyInfo {
  /**
   * The date-time the key is active in ISO 8601 UTC time
   */
  Start?: string;

  /**
   * The date-time the key expires in ISO 8601 UTC time
   */
  Expiry: string;

  /**
   * The delegated user tenant id in Azure AD
   */
  DelegatedUserTid?: string;
}

/**
 * A user delegation key
 */
model UserDelegationKey {
  /**
   * The Azure Active Directory object ID in GUID format.
   */
  SignedOid: string;

  /**
   * The Azure Active Directory tenant ID in GUID format
   */
  SignedTid: string;

  /**
   * The date-time the key is active
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  SignedStart: utcDateTime;

  /**
   * The date-time the key expires
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  SignedExpiry: utcDateTime;

  /**
   * Abbreviation of the Azure Storage service that accepts the key
   */
  SignedService: string;

  /**
   * The service version that created the key
   */
  SignedVersion: string;

  /**
   * The delegated user tenant id in Azure AD. Return if DelegatedUserTid is
   * specified.
   */
  SignedDelegatedUserTid?: string;

  /**
   * The key as a base64 string
   */
  Value: string;
}

//
// Common Parameter Aliases
//

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
  lastModified: string;
};

/** Date response header. */
alias DateResponseHeader = {
  /** A GMT date/time value generated by the service that indicates the time the response was initiated. */
  @header("Date")
  date: string;
};

/** Content length parameter. */
alias ContentLengthParameter = {
  /** The number of bytes of data in the request body. */
  @header("Content-Length")
  contentLength: int64;
};

/** Content type header. */
alias ContentTypeHeader = {
  /** Specifies the content type of the data. */
  @header("Content-Type")
  contentType?: string;
};

/** Range header for partial content requests. */
alias RangeHeader = {
  /** The byte range to be written, specified as start-end (inclusive). */
  @header("Range")
  range?: string;
};

/** Lease ID parameter. */
alias LeaseIdParameter = {
  /** If specified, the lease ID must match the lease ID of the file. */
  @header("x-ms-lease-id")
  leaseId?: string;
};

alias ShareQuotaOptionalHeader = {
  /** Specifies the maximum size of the share, in gigabytes. */
  @header("x-ms-share-quota") shareQuota?: int32;
};

//
// Common Response Headers
//

/** Standard File Storage success response headers. */
alias FileStorageResponseHeaders = ApiVersionHeader &
  RequestIdResponseHeader &
  DateResponseHeader;

/** Standard File Storage response with ETag and Last-Modified. */
alias FileStorageResourceHeaders = FileStorageResponseHeaders &
  EtagResponseHeader &
  LastModifiedResponseHeader;
