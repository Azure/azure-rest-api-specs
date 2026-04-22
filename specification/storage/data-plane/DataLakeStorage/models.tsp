import "@typespec/rest";
import "@typespec/http";
import "@typespec/xml";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace Storage.DataLake;

// ============================================================================
// Enums & Unions
// ============================================================================

/** The value must be "account" for all account operations. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum AccountResourceType {
  /** The account resource type. */
  account: "account",
}

/** The value must be "filesystem" for all filesystem operations. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum FileSystemResourceType {
  /** The filesystem resource type. */
  filesystem: "filesystem",
}

/** Required only for Create File and Create Directory. The value must be "file" or "directory". */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum PathResourceType {
  /** A directory resource type. */
  directory: "directory",

  /** A file resource type. */
  file: "file",
}

/** The rename mode. The value must be "legacy" or "posix". */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum PathRenameMode {
  /** Legacy rename mode. */
  legacy: "legacy",

  /** POSIX rename mode. */
  posix: "posix",
}

/** The action to perform on the path during update. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum PathUpdateAction {
  /** Append data to the file. */
  append: "append",

  /** Flush previously uploaded data to a file. */
  flush: "flush",

  /** Set the properties of a file or directory. */
  setProperties: "setProperties",

  /** Set the access control for a file or directory. */
  setAccessControl: "setAccessControl",

  /** Set the access control list for a directory recursively. */
  setAccessControlRecursive: "setAccessControlRecursive",
}

/** The lease action for Path_Lease. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum PathLeaseAction {
  /** Acquire a new lease. */
  acquire: "acquire",

  /** Break an existing lease. */
  break: "break",

  /** Change the lease ID of an active lease. */
  change: "change",

  /** Renew an existing lease. */
  renew: "renew",

  /** Release a lease. */
  release: "release",
}

/** The action for Path_GetProperties. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum PathGetPropertiesAction {
  /** Get access control list. */
  getAccessControl: "getAccessControl",

  /** Get status. */
  getStatus: "getStatus",
}

/** The mode for recursive access control operations. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum PathSetAccessControlRecursiveMode {
  /** Set POSIX access control rights. */
  set: "set",

  /** Modify POSIX access control rights. */
  modify: "modify",

  /** Remove POSIX access control rights. */
  remove: "remove",
}

/** The lease action for append and flush operations. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum LeaseAction {
  /** Acquire a lease. */
  acquire: "acquire",

  /** Auto-renew the lease. */
  `auto-renew`: "auto-renew",

  /** Release the lease only on flush. */
  release: "release",

  /** Acquire, complete the operation, and release the lease. */
  `acquire-release`: "acquire-release",
}

/** The encryption algorithm type. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum EncryptionAlgorithmType {
  /** The AES256 encryption algorithm. */
  AES256: "AES256",
}

/** The path expiry options. */
union PathExpiryOptions {
  /** Never expire. */
  NeverExpire: "NeverExpire",

  /** Relative to creation time. */
  RelativeToCreation: "RelativeToCreation",

  /** Relative to now. */
  RelativeToNow: "RelativeToNow",

  /** Absolute time. */
  Absolute: "Absolute",

  /** Extensible */
  string,
}

/** Include this parameter to specify one or more datasets to include in the response. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ListBlobsIncludeItem {
  /** Include copy information. */
  copy: "copy",

  /** Include deleted blobs. */
  deleted: "deleted",

  /** Include metadata. */
  metadata: "metadata",

  /** Include snapshots. */
  snapshots: "snapshots",

  /** Include uncommitted blobs. */
  uncommittedblobs: "uncommittedblobs",

  /** Include versions. */
  versions: "versions",

  /** Include tags. */
  tags: "tags",
}

/** The show only filter for list blobs. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ListBlobsShowOnly {
  /** Show only deleted blobs. */
  deleted: "deleted",
}

// ============================================================================
// Error Model
// ============================================================================

/** The storage error response. */
@error
model StorageError {
  /** The error code. */
  @header("x-ms-error-code")
  errorCode?: string;

  /** The service error response object. */
  error?: StorageErrorBody;
}

/** The service error response body. */
model StorageErrorBody {
  /** The service error code. */
  @Xml.name("Code")
  code?: string;

  /** The service error message. */
  @Xml.name("Message")
  message?: string;
}

// ============================================================================
// Data Models
// ============================================================================

/** Represents a filesystem. */
model FileSystemItem {
  /** The filesystem name. */
  name?: string;

  /** The last modified time. */
  lastModified?: string;

  /** The entity tag. */
  eTag?: eTag;
}

/** A list of filesystems. */
model FileSystemList {
  /** The list of filesystems. */
  filesystems?: FileSystemItem[];
}

/** Represents a path in a filesystem. */
model PathItem {
  /** The path name. */
  name?: string;

  /** Whether the path is a directory. */
  isDirectory?: boolean = false;

  /** The last modified time. */
  lastModified?: string;

  /** The entity tag. */
  eTag?: eTag;

  /** The content length. */
  contentLength?: int64;

  /** The owner of the path. */
  owner?: string;

  /** The owning group of the path. */
  group?: string;

  /** The POSIX access permissions. */
  permissions?: string;

  /** The name of the encryption scope under which the blob is encrypted. */
  @encodedName("application/json", "EncryptionScope")
  encryptionScope?: string;

  /** The creation time. */
  creationTime?: string;

  /** The expiry time. */
  expiryTime?: string;

  /** The encryption context. */
  @encodedName("application/json", "EncryptionContext")
  encryptionContext?: string;
}

/** A list of paths. */
model PathList {
  /** The list of paths. */
  paths?: PathItem[];
}

/** An ACL failed entry. */
model AclFailedEntry {
  /** The name of the entry. */
  name?: string;

  /** The type of the entry. */
  type?: string;

  /** The error message. */
  errorMessage?: string;
}

/** The response for set access control recursive operations. */
model SetAccessControlRecursiveResponse {
  /** The number of directories successfully processed. */
  directoriesSuccessful?: int32;

  /** The number of files successfully processed. */
  filesSuccessful?: int32;

  /** The number of failures. */
  failureCount?: int32;

  /** The list of failed entries. */
  failedEntries?: AclFailedEntry[];
}

// List Blobs Hierarchy models (XML)

/** An enumeration of blobs. */
@Xml.name("EnumerationResults")
model ListBlobsHierarchySegmentResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The container name. */
  @Xml.attribute
  @Xml.name("ContainerName")
  containerName: string;

  /** The prefix filter. */
  @Xml.name("Prefix")
  prefix?: string;

  /** The marker for pagination. */
  @Xml.name("Marker")
  marker?: string;

  /** The maximum number of results. */
  @Xml.name("MaxResults")
  maxResults?: int32;

  /** The delimiter used for hierarchy. */
  @Xml.name("Delimiter")
  delimiter?: string;

  /** The blob segment. */
  @Xml.name("Blobs")
  segment: BlobHierarchyListSegment;

  /** The next marker for pagination. */
  @Xml.name("NextMarker")
  nextMarker?: string;
}

/** A segment of blob hierarchy items. */
@Xml.name("Blobs")
model BlobHierarchyListSegment {
  /** The blob prefixes. */
  @Xml.name("BlobPrefix")
  @Xml.unwrapped
  blobPrefixes?: BlobPrefix[];

  /** The blob items. */
  @Xml.name("Blob")
  @Xml.unwrapped
  blobItems: BlobItemInternal[];
}

/** A blob prefix. */
model BlobPrefix {
  /** The prefix name. */
  @Xml.name("Name")
  name: string;
}

/** An Azure Storage blob. */
@Xml.name("Blob")
model BlobItemInternal {
  /** The blob name. */
  @Xml.name("Name")
  name: string;

  /** Whether the blob is deleted. */
  @Xml.name("Deleted")
  deleted: boolean;

  /** The snapshot. */
  @Xml.name("Snapshot")
  snapshot: string;

  /** The version ID. */
  @Xml.name("VersionId")
  versionId?: string;

  /** Whether this is the current version. */
  @Xml.name("IsCurrentVersion")
  isCurrentVersion?: boolean;

  /** The blob properties. */
  @Xml.name("Properties")
  properties: BlobPropertiesInternal;

  /** The deletion ID. */
  @Xml.name("DeletionId")
  deletionId?: string;
}

/** Properties of a blob. */
@Xml.name("Properties")
model BlobPropertiesInternal {
  /** The creation time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("Creation-Time")
  creationTime?: utcDateTime;

  /** The last modified time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("Last-Modified")
  lastModified: utcDateTime;

  /** The entity tag. */
  @Xml.name("Etag")
  etag: eTag;

  /** Size in bytes. */
  @Xml.name("Content-Length")
  contentLength?: int64;

  /** The content type. */
  @Xml.name("Content-Type")
  contentType?: string;

  /** The content encoding. */
  @Xml.name("Content-Encoding")
  contentEncoding?: string;

  /** The content language. */
  @Xml.name("Content-Language")
  contentLanguage?: string;

  /** The content MD5 hash. */
  @Xml.name("Content-MD5")
  contentMd5?: bytes;

  /** The content disposition. */
  @Xml.name("Content-Disposition")
  contentDisposition?: string;

  /** The cache control. */
  @Xml.name("Cache-Control")
  cacheControl?: string;

  /** The blob sequence number. */
  @Xml.name("x-ms-blob-sequence-number")
  blobSequenceNumber?: int64;

  /** The copy ID. */
  @Xml.name("CopyId")
  copyId?: string;

  /** The copy source. */
  @Xml.name("CopySource")
  copySource?: string;

  /** The copy progress. */
  @Xml.name("CopyProgress")
  copyProgress?: string;

  /** The copy completion time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("CopyCompletionTime")
  copyCompletionTime?: utcDateTime;

  /** The copy status description. */
  @Xml.name("CopyStatusDescription")
  copyStatusDescription?: string;

  /** Whether the server is encrypted. */
  @Xml.name("ServerEncrypted")
  serverEncrypted?: boolean;

  /** Whether it is an incremental copy. */
  @Xml.name("IncrementalCopy")
  incrementalCopy?: boolean;

  /** The destination snapshot. */
  @Xml.name("DestinationSnapshot")
  destinationSnapshot?: string;

  /** The deleted time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("DeletedTime")
  deletedTime?: utcDateTime;

  /** The remaining retention days. */
  @Xml.name("RemainingRetentionDays")
  remainingRetentionDays?: int32;

  /** Whether the access tier is inferred. */
  @Xml.name("AccessTierInferred")
  accessTierInferred?: boolean;

  /** The customer-provided key SHA256 hash. */
  @Xml.name("CustomerProvidedKeySha256")
  customerProvidedKeySha256?: string;

  /** The name of the encryption scope under which the blob is encrypted. */
  @Xml.name("EncryptionScope")
  encryptionScope?: string;

  /** The access tier change time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("AccessTierChangeTime")
  accessTierChangeTime?: utcDateTime;

  /** The tag count. */
  @Xml.name("TagCount")
  tagCount?: int32;

  /** The expiry time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("Expiry-Time")
  expiresOn?: utcDateTime;

  /** Whether the blob is sealed. */
  @Xml.name("Sealed")
  isSealed?: boolean;

  /** The last accessed time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("LastAccessTime")
  lastAccessedOn?: utcDateTime;

  /** The delete time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("DeleteTime")
  deleteTime?: utcDateTime;
}

// ============================================================================
// Parameter & Header Aliases
// ============================================================================

// --- Common Request Headers ---

/** The API version header parameter. */
alias ApiVersionHeader = {
  /** Specifies the version of the operation to use for this request. */
  @apiVersion
  @access(Access.internal)
  @header("x-ms-version")
  version: string;
};

/** The client request ID header parameter. */
alias ClientRequestIdHeader = {
  /** Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled. */
  @access(Access.internal)
  @header("x-ms-client-request-id")
  clientRequestId?: string;
};

/** The timeout query parameter. */
alias TimeoutParameter = {
  @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
  @query
  @minValue(0)
  timeout?: int32;
};

/** The Content-Length header parameter. */
alias ContentLengthParameter = {
  /** Required for "Append Data" and "Flush Data". Must be 0 for "Flush Data". Must be the length of the request content in bytes for "Append Data". */
  @header("Content-Length")
  contentLength?: int64;
};

// --- Conditional Headers ---

/** The If-Match header parameter. */
alias IfMatchParameter = {
  /** Specify an ETag value to operate only on blobs with a matching value. */
  @header("If-Match")
  ifMatch?: eTag;
};

/** The If-None-Match header parameter. */
alias IfNoneMatchParameter = {
  /** Specify an ETag value to operate only on blobs without a matching value. */
  @header("If-None-Match")
  ifNoneMatch?: eTag;
};

/** The If-Modified-Since header parameter. */
alias IfModifiedSinceParameter = {
  /** Specify this header value to operate only on a blob if it has been modified since the specified date/time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("If-Modified-Since")
  ifModifiedSince?: utcDateTime;
};

/** The If-Unmodified-Since header parameter. */
alias IfUnmodifiedSinceParameter = {
  /** Specify this header value to operate only on a blob if it has not been modified since the specified date/time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("If-Unmodified-Since")
  ifUnmodifiedSince?: utcDateTime;
};

/** The source If-Match header parameter. */
alias SourceIfMatchParameter = {
  /** Specify an ETag value to operate only on blobs with a matching value. */
  @header("x-ms-source-if-match")
  sourceIfMatch?: eTag;
};

/** The source If-None-Match header parameter. */
alias SourceIfNoneMatchParameter = {
  /** Specify an ETag value to operate only on blobs without a matching value. */
  @header("x-ms-source-if-none-match")
  sourceIfNoneMatch?: eTag;
};

/** The source If-Modified-Since header parameter. */
alias SourceIfModifiedSinceParameter = {
  /** Specify this header value to operate only on a blob if it has been modified since the specified date/time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("x-ms-source-if-modified-since")
  sourceIfModifiedSince?: utcDateTime;
};

/** The source If-Unmodified-Since header parameter. */
alias SourceIfUnmodifiedSinceParameter = {
  /** Specify this header value to operate only on a blob if it has not been modified since the specified date/time. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("x-ms-source-if-unmodified-since")
  sourceIfUnmodifiedSince?: utcDateTime;
};

// --- Lease Parameters ---

/** The optional lease ID header parameter. */
alias LeaseIdOptionalParameter = {
  /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
  @header("x-ms-lease-id")
  leaseId?: string;
};

/** The required lease ID header parameter. */
alias LeaseIdRequiredParameter = {
  /** Specifies the current lease ID on the resource. */
  @header("x-ms-lease-id")
  leaseId: string;
};

/** The optional proposed lease ID header parameter. */
alias ProposedLeaseIdOptionalParameter = {
  /** Proposed lease ID, in a GUID string format. */
  @header("x-ms-proposed-lease-id")
  proposedLeaseId?: string;
};

/** The lease duration header parameter (int32, for Path_Lease). */
alias LeaseDurationParameter = {
  /** The lease duration is required to acquire a lease, and specifies the duration of the lease in seconds. The lease duration must be between 15 and 60 seconds or -1 for infinite lease. */
  @header("x-ms-lease-duration")
  leaseDuration?: int32;
};

/** The lease duration header parameter (int64, for method-level operations). */
alias LeaseDurationMethodParameter = {
  /** The lease duration is required to acquire a lease, and specifies the duration of the lease in seconds. The lease duration must be between 15 and 60 seconds or -1 for infinite lease. */
  @header("x-ms-lease-duration")
  leaseDuration?: int64;
};

/** The lease action header parameter for append/flush operations. */
alias LeaseActionParameter = {
  /** Optional. If "acquire" it will acquire the lease. If "auto-renew" it will renew the lease. If "release" it will release the lease only on flush. If "acquire-release" it will acquire & complete the operation & release the lease once operation is done. */
  @header("x-ms-lease-action")
  leaseAction?: LeaseAction;
};

// --- Content Headers (path-HTTP-headers group) ---

/** The cache control header parameter. */
alias CacheControlParameter = {
  /** Optional. Sets the blob's cache control. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-cache-control")
  cacheControl?: string;
};

/** The content disposition header parameter. */
alias ContentDispositionParameter = {
  /** Optional. Sets the blob's Content-Disposition header. */
  @header("x-ms-content-disposition")
  contentDisposition?: string;
};

/** The content encoding header parameter. */
alias ContentEncodingParameter = {
  /** Optional. Sets the blob's content encoding. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-content-encoding")
  contentEncoding?: string;
};

/** The content language header parameter. */
alias ContentLanguageParameter = {
  /** Optional. Set the blob's content language. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-content-language")
  contentLanguage?: string;
};

/** The content type header parameter. */
alias ContentTypeParameter = {
  /** Optional. Sets the blob's content type. If specified, this property is stored with the blob and returned with a read request. */
  @header("x-ms-content-type")
  contentType?: string;
};

/** The content MD5 header parameter. */
alias ContentMD5Parameter = {
  /** Specify the transactional md5 for the body, to be validated by the service. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API"
  @header("x-ms-content-md5")
  contentMD5?: bytes;
};

/** The transactional content MD5 header parameter. */
alias TransactionalContentMD5Parameter = {
  /** Specify the transactional md5 for the body, to be validated by the service. */
  @header("Content-MD5")
  transactionalContentHash?: bytes;
};

/** The transactional content CRC64 header parameter. */
alias ContentCrc64Parameter = {
  /** Specify the transactional crc64 for the body, to be validated by the service. */
  @header("x-ms-content-crc64")
  transactionalContentCrc64?: bytes;
};

// --- Encryption Parameters ---

/** The encryption key header parameter. */
alias EncryptionKeyParameter = {
  /** Optional. Specifies the encryption key to use to encrypt the data provided in the request. If not specified, encryption is performed with the root account encryption key. */
  @header("x-ms-encryption-key")
  encryptionKey?: string;
};

/** The encryption key SHA256 header parameter. */
alias EncryptionKeySha256Parameter = {
  /** The SHA-256 hash of the provided encryption key. Must be provided if the x-ms-encryption-key header is provided. */
  @header("x-ms-encryption-key-sha256")
  encryptionKeySha256?: string;
};

/** The encryption algorithm header parameter. */
alias EncryptionAlgorithmParameter = {
  /** The algorithm used to produce the encryption key hash. Currently, the only accepted value is "AES256". Must be provided if the x-ms-encryption-key header is provided. */
  @header("x-ms-encryption-algorithm")
  encryptionAlgorithm?: EncryptionAlgorithmType;
};

/** The encryption context header parameter. */
alias EncryptionContextParameter = {
  /** Specifies the encryption context to set on the file. */
  @header("x-ms-encryption-context")
  encryptionContext?: string;
};

// --- ACL/Ownership Parameters ---

/** The owner header parameter. */
alias OwnerParameter = {
  /** Optional. The owner of the blob or directory. */
  @header("x-ms-owner")
  owner?: string;
};

/** The group header parameter. */
alias GroupParameter = {
  /** Optional. The owning group of the blob or directory. */
  @header("x-ms-group")
  group?: string;
};

/** The ACL header parameter. */
alias AclParameter = {
  /** Sets POSIX access control rights on files and directories. The value is a comma-separated list of access control entries. Each access control entry (ACE) consists of a scope, a type, a user or group identifier, and permissions in the format "[scope:][type]:[id]:[permissions]". */
  @header("x-ms-acl")
  acl?: string;
};

/** The permissions header parameter. */
alias PermissionsParameter = {
  /** Optional and only valid if Hierarchical Namespace is enabled for the account. Sets POSIX access permissions for the file owner, the file owning group, and others. Each class may be granted read, write, or execute permission. The sticky bit is also supported. Both symbolic (rwxrw-rw-) and 4-digit octal notation (e.g. 0766) are supported. */
  @header("x-ms-permissions")
  permissions?: string;
};

/** The umask header parameter. */
alias UmaskParameter = {
  /** Optional and only valid if Hierarchical Namespace is enabled for the account. When creating a file or directory and the parent folder does not have a default ACL, the umask restricts the permissions of the file or directory to be created. The resulting permission is given by p bitwise and not u, where p is the permission and u is the umask. For example, if p is 0777 and u is 0057, then the resulting permission is 0720. The default permission is 0777 for a directory and 0666 for a file. The default umask is 0027. The umask must be specified in 4-digit octal notation (e.g. 0766). */
  @header("x-ms-umask")
  umask?: string;
};

// --- Other Request Parameters ---

/** The prefix query parameter. */
alias PrefixParameter = {
  /** Filters results to filesystems within the specified prefix. */
  @query prefix?: string;
};

/** The continuation query parameter. */
alias ContinuationParameter = {
  /** Optional. When deleting a directory, the number of paths that are deleted with each invocation is limited. If the number of paths to be deleted exceeds this limit, a continuation token is returned in this response header. When a continuation token is returned in the response, it must be specified in a subsequent invocation of the delete operation to continue deleting the directory. */
  @query continuation?: string;
};

/** The max results query parameter. */
alias MaxResultsParameter = {
  /** An optional value that specifies the maximum number of items to return. If omitted or greater than 5,000, the response will include up to 5,000 items. */
  @query
  @minValue(1)
  maxResults?: int32;
};

/** The recursive required query parameter. */
alias RecursiveRequiredParameter = {
  /** Required */
  @query recursive: boolean;
};

/** The recursive optional query parameter. */
alias RecursiveOptionalParameter = {
  /** Required */
  @query recursive?: boolean;
};

/** The directory query parameter. */
alias DirectoryParameter = {
  /** Optional. Filters results to paths within the specified directory. An error occurs if the directory does not exist. */
  @query("directory")
  path?: string;
};

/** The upn query parameter. */
alias UpnParameter = {
  /** Optional. Valid only when Hierarchical Namespace is enabled for the account. If "true", the user identity values returned in the x-ms-owner, x-ms-group, and x-ms-acl response headers will be transformed from Azure Active Directory Object IDs to User Principal Names. If "false", the values will be returned as Azure Active Directory Object IDs. The default value is false. Note that group and application Object IDs are not translated because they do not have unique friendly names. */
  @query upn?: boolean;
};

/** The position query parameter. */
alias PositionParameter = {
  /** This parameter allows the caller to upload data in parallel and control the order in which it is appended to the file. It is required when uploading data to be appended to the file and when flushing previously uploaded data to the file. The value must be the position where the data is to be appended. Uploaded data is not immediately flushed, or written, to the file. To flush, the previously uploaded data must be contiguous, the position parameter must be specified and equal to the length of the file after all data has been written, and there must not be a request entity body included with the request. */
  @query position?: int64;
};

/** The retainUncommittedData query parameter. */
alias RetainUncommittedDataParameter = {
  /** Valid only for flush operations. If "true", uncommitted data is retained after the flush operation completes; otherwise, the uncommitted data is deleted after the flush operation. The default is false. Data at offsets less than the specified position are written to the file when flush succeeds, but this optional parameter allows data after the flush position to be retained for a future flush operation. */
  @query retainUncommittedData?: boolean;
};

/** The close query parameter. */
alias CloseParameter = {
  /** Azure Storage Events allow applications to receive notifications when files change. When Azure Storage Events are enabled, a file changed event is raised. This event has a property indicating whether this is the final change to distinguish the difference between an intermediate flush to a file stream and the final close of a file stream. The close query parameter is valid only when the action is "flush" and change notifications are enabled. If the value of close is "true" and the flush operation completes successfully, the service raises a file change notification with a property indicating that this is the final update (the file stream has been closed). If "false" a change notification is raised indicating the file has changed. The default is false. This query parameter is set to true by the Hadoop ABFS driver to indicate that the file stream has been closed. */
  @query close?: boolean;
};

/** The forceFlag query parameter. */
alias ForceFlagParameter = {
  /** Optional. Valid for "SetAccessControlRecursive" operation. If set to false, the operation will terminate quickly on encountering user errors (4XX). If true, the operation will ignore user errors and proceed with the operation on other sub-entities of the directory. Continuation token will only be returned when forceFlag is true in case of user errors. If not set the default value is false for this. */
  @query forceFlag?: boolean;
};

/** The flush query parameter. */
alias FlushParameter = {
  /** If file should be flushed after the append. */
  @query flush?: boolean;
};

/** The paginated query parameter. */
alias PaginatedParameter = {
  /** If true, paginated behavior will be seen. Pagination is for the recursive ACL checks as a POSIX requirement in the server and Delete in an atomic operation once the ACL checks are completed. If false or missing, normal default behavior will kick in, which may timeout in case of very large directories due to recursive ACL checks. This new parameter is introduced for backward compatibility. */
  @query paginated?: boolean;
};

/** The beginFrom query parameter. */
alias BeginFromParameter = {
  /** Optional. A relative path within the specified directory where the listing will start from. */
  @query beginFrom?: string;
};

/** The rename source header parameter. */
alias RenameSourceParameter = {
  /** An optional file or directory to be renamed. The value must have the following format: "/{filesystem}/{path}". If "x-ms-properties" is specified, the properties will overwrite the existing properties; otherwise, the existing properties will be preserved. This value must be a URL percent-encoded string. Note that the string may only contain ASCII characters in the ISO-8859-1 character set. */
  @header("x-ms-rename-source")
  renameSource?: string;
};

/** The source lease ID header parameter. */
alias SourceLeaseIdParameter = {
  /** A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match. */
  @header("x-ms-source-lease-id")
  sourceLeaseId?: string;
};

/** The properties header parameter. */
alias PropertiesParameter = {
  /** Optional. User-defined properties to be stored with the filesystem, in the format of a comma-separated list of name and value pairs "n1=v1, n2=v2, ...", where each value is a base64 encoded string. Note that the string may only contain ASCII characters in the ISO-8859-1 character set. If the filesystem exists, any properties not included in the list will be removed. All properties are removed if the header is omitted. To merge new and existing properties, first get all existing properties and the current E-Tag, then make a conditional request with the E-Tag and include values for all properties. */
  @header("x-ms-properties")
  properties?: string;
};

/** The body parameter. */
alias BodyParameter = {
  /** Initial data. */
  @body body: bytes;
};

/** The structured body header parameter. */
alias StructuredBodyParameter = {
  /** Required if the request body is a structured message. Specifies the message schema version and properties. */
  @header("x-ms-structured-body")
  structuredBodyType?: string;
};

/** The structured content length header parameter. */
alias StructuredContentLengthParameter = {
  /** Required if the request body is a structured message. Specifies the length of the blob/file content inside the message body. Will always be smaller than Content-Length. */
  @header("x-ms-structured-content-length")
  structuredContentLength?: int64;
};

/** The required path expiry options header parameter. */
alias PathExpiryOptionsRequiredParameter = {
  /** Required. Indicates mode of the expiry time. */
  @header("x-ms-expiry-option")
  expiryOptions: PathExpiryOptions;
};

/** The optional path expiry options header parameter. */
alias PathExpiryOptionsOptionalParameter = {
  /** Required. Indicates mode of the expiry time. */
  @header("x-ms-expiry-option")
  expiryOptions?: PathExpiryOptions;
};

/** The path expiry time header parameter. */
alias PathExpiryTimeParameter = {
  /** The time to set the blob to expiry. */
  @header("x-ms-expiry-time")
  expiresOn?: string;
};

/** The undelete source header parameter. */
alias UndeleteSourceParameter = {
  /** Only for hierarchical namespace enabled accounts. Optional. The path of the soft deleted blob to undelete. */
  @header("x-ms-undelete-source")
  undeleteSource?: string;
};

/** The marker query parameter. */
alias MarkerParameter = {
  /** A string value that identifies the portion of the list of containers to be returned with the next listing operation. The operation returns the NextMarker value within the response body if the listing operation did not return all containers remaining to be listed with the current page. The NextMarker value can be used as the value for the marker parameter in a subsequent call to request the next page of list items. The marker value is opaque to the client. */
  @query marker?: string;
};

/** The delimiter query parameter. */
alias DelimiterParameter = {
  /** When the request includes this parameter, the operation returns a BlobPrefix element in the response body that acts as a placeholder for all blobs whose names begin with the same substring up to the appearance of the delimiter character. The delimiter may be a single character or a string. */
  @query delimiter?: string;
};

/** The list blobs include query parameter. */
alias ListBlobsIncludeParameter = {
  /** Include this parameter to specify one or more datasets to include in the response. */
  @query include?: ListBlobsIncludeItem[];
};

/** The list blobs show only query parameter. */
alias ListBlobsShowOnlyParameter = {
  /** Include this parameter to specify one or more datasets to include in the response. */
  @query showonly?: ListBlobsShowOnly;
};

// --- Common Response Headers ---

/** The Date response header. */
alias DateResponseHeader = {
  /** A UTC date/time value generated by the service that indicates the time at which the response was initiated. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("Date")
  date: utcDateTime;
};

/** The ETag response header. */
alias EtagResponseHeader = {
  /** An HTTP entity tag associated with the resource. */
  @header("ETag")
  eTag: eTag;
};

/** The Last-Modified response header. */
alias LastModifiedResponseHeader = {
  /** The data and time the resource was last modified. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("Last-Modified")
  lastModified: utcDateTime;
};

/** The request ID response header. */
alias RequestIdResponseHeader = {
  /** A server-generated UUID recorded in the analytics logs for troubleshooting and correlation. */
  @access(Access.internal)
  @visibility(Lifecycle.Read)
  @header("x-ms-request-id")
  requestId?: string;
};

/** The continuation response header. */
alias ContinuationResponseHeader = {
  /** If the number of paths to be listed exceeds the maxResults limit, a continuation token is returned in this response header. When a continuation token is returned in the response, it must be specified in a subsequent invocation of the list operation to continue listing the paths. */
  @header("x-ms-continuation")
  continuation?: string;
};

/** The namespace enabled response header. */
alias NamespaceEnabledResponseHeader = {
  /** A bool string indicates whether the namespace feature is enabled. If "true", the namespace is enabled for the filesystem. */
  @header("x-ms-namespace-enabled")
  namespaceEnabled?: string;
};

/** The properties response header. */
alias PropertiesResponseHeader = {
  /** The user-defined properties associated with the file or directory, in the format of a comma-separated list of name and value pairs "n1=v1, n2=v2, ...", where each value is a base64 encoded string. Note that the string may only contain ASCII characters in the ISO-8859-1 character set. */
  @header("x-ms-properties")
  properties?: string;
};

/** The resource type response header. */
alias ResourceTypeResponseHeader = {
  /** The type of the resource. The value may be "file" or "directory". If not set, the value is "file". */
  @header("x-ms-resource-type")
  resourceType?: string;
};

/** The lease ID response header. */
alias LeaseIdResponseHeader = {
  /** A successful lease action returns the lease ID. */
  @header("x-ms-lease-id")
  leaseId?: string;
};

/** The lease time response header. */
alias LeaseTimeResponseHeader = {
  /** The time remaining in the lease period in seconds. */
  @header("x-ms-lease-time")
  leaseTime?: string;
};

/** The lease duration response header. */
alias LeaseDurationResponseHeader = {
  /** When a resource is leased, specifies whether the lease is of infinite or fixed duration. */
  @header("x-ms-lease-duration")
  leaseDuration?: string;
};

/** The lease state response header. */
alias LeaseStateResponseHeader = {
  /** Lease state of the resource. */
  @header("x-ms-lease-state")
  leaseState?: string;
};

/** The lease status response header. */
alias LeaseStatusResponseHeader = {
  /** The lease status of the resource. */
  @header("x-ms-lease-status")
  leaseStatus?: string;
};

/** The is server encrypted response header (x-ms-request-server-encrypted). */
alias IsServerEncryptedResponseHeader = {
  /** The value of this header is set to true if the contents of the request are successfully encrypted using the specified algorithm, and false otherwise. */
  @header("x-ms-request-server-encrypted")
  isServerEncrypted?: boolean;
};

/** The is server encrypted response header (x-ms-server-encrypted, alternate form). */
alias IsServerEncryptedAltResponseHeader = {
  /** The value of this header is set to true if the directory metadata is completely encrypted using the specified algorithm. Otherwise, the value is set to false. */
  @header("x-ms-server-encrypted")
  isServerEncrypted?: boolean;
};

/** The encryption key SHA256 response header. */
alias EncryptionKeySha256ResponseHeader = {
  /** The SHA-256 hash of the encryption key used to encrypt the blob. This header is only returned when the blob was encrypted with a customer-provided key. */
  @header("x-ms-encryption-key-sha256")
  encryptionKeySha256?: string;
};

/** The encryption context response header. */
alias EncryptionContextResponseHeader = {
  /** The encryption context used to encrypt the blob. This header is only returned when the blob was encrypted with a customer-provided key. */
  @header("x-ms-encryption-context")
  encryptionContext?: string;
};

/** The encryption scope response header. */
alias EncryptionScopeResponseHeader = {
  /** Returns the name of the encryption scope used to encrypt the blob contents and application metadata. Note that the absence of this header implies use of the default account encryption scope. */
  @header("x-ms-encryption-scope")
  encryptionScope?: string;
};

/** The deletion ID response header. */
alias DeletionIdResponseHeader = {
  /** Returned only for hierarchical namespace space enabled accounts when soft delete is enabled. A unique identifier for the entity that can be used to restore it. */
  @header("x-ms-deletion-id")
  deletionId?: string;
};

/** The creation time response header. */
alias CreationTimeResponseHeader = {
  /** Returns the date and time the blob was created. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("x-ms-creation-time")
  creationTime: utcDateTime;
};

/** The expiry time response header. */
alias ExpiryTimeResponseHeader = {
  /** The time this blob will expire. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("x-ms-expiry-time")
  expiresOn: utcDateTime;
};

/** The Accept-Ranges response header. */
alias AcceptRangesResponseHeader = {
  /** Indicates that the service supports requests for partial file content. */
  @header("Accept-Ranges")
  acceptRanges?: string;
};

/** The Cache-Control response header. */
alias CacheControlResponseHeader = {
  /** If the Cache-Control request header has previously been set for the resource, that value is returned in this header. */
  @header("Cache-Control")
  cacheControl?: string;
};

/** The Content-Disposition response header. */
alias ContentDispositionResponseHeader = {
  /** If the Content-Disposition request header has previously been set for the resource, that value is returned in this header. */
  @header("Content-Disposition")
  contentDisposition?: string;
};

/** The Content-Encoding response header. */
alias ContentEncodingResponseHeader = {
  /** If the Content-Encoding request header has previously been set for the resource, that value is returned in this header. */
  @header("Content-Encoding")
  contentEncoding?: string;
};

/** The Content-Language response header. */
alias ContentLanguageResponseHeader = {
  /** If the Content-Language request header has previously been set for the resource, that value is returned in this header. */
  @header("Content-Language")
  contentLanguage?: string;
};

/** The Content-Length response header. */
alias ContentLengthResponseHeader = {
  /** The size of the resource in bytes. */
  @header("Content-Length")
  contentLength?: int64;
};

/** The Content-Range response header. */
alias ContentRangeResponseHeader = {
  /** Indicates the range of bytes returned in the event that the client requested a subset of the file by setting the Range request header. */
  @header("Content-Range")
  contentRange?: string;
};

/** The Content-Type response header. */
alias ContentTypeResponseHeader = {
  /** The content type specified for the resource. If no content type was specified, the default content type is application/octet-stream. */
  @header("Content-Type")
  contentType?: string;
};

/** The Content-MD5 response header. */
alias ContentMD5ResponseHeader = {
  /** The MD5 hash of the content. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing API"
  @header("Content-MD5")
  contentMD5?: bytes;
};

/** The x-ms-content-md5 response header (full file MD5). */
alias XMsContentMD5ResponseHeader = {
  /** The MD5 hash of complete file stored in storage. */
  @header("x-ms-content-md5")
  xMsContentMD5?: bytes;
};

/** The Owner response header. */
alias OwnerResponseHeader = {
  /** The owner of the file or directory. Included in the response if Hierarchical Namespace is enabled for the account. */
  @header("x-ms-owner")
  owner?: string;
};

/** The Group response header. */
alias GroupResponseHeader = {
  /** The owning group of the file or directory. Included in the response if Hierarchical Namespace is enabled for the account. */
  @header("x-ms-group")
  group?: string;
};

/** The Permissions response header. */
alias PermissionsResponseHeader = {
  /** The POSIX access permissions for the file owner, the file owning group, and others. Included in the response if Hierarchical Namespace is enabled for the account. */
  @header("x-ms-permissions")
  permissions?: string;
};

/** The ACL response header. */
alias AclResponseHeader = {
  /** The POSIX access control list for the file or directory. Included in the response only if the action is "getAccessControl" and Hierarchical Namespace is enabled for the account. */
  @header("x-ms-acl")
  acl?: string;
};

/** The lease renewed response header. */
alias LeaseRenewedResponseHeader = {
  /** If the lease was auto-renewed with this request. */
  @header("x-ms-lease-renewed")
  leaseRenewed?: boolean;
};

/** The structured body type response header. */
alias StructuredBodyTypeResponseHeader = {
  /** Indicates the structured message body was accepted and mirrors back the message schema version and properties. */
  @header("x-ms-structured-body")
  structuredBodyType?: string;
};

/** The x-ms-content-crc64 response header. */
alias ContentCrc64ResponseHeader = {
  /** This header is returned so that the client can check for message content integrity. The value of this header is computed by the Blob service; it is not necessarily the same value specified in the request headers. */
  @header("x-ms-content-crc64")
  contentCrc64?: bytes;
};
