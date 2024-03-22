import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

@useDependency(Azure.Core.Versions.v1_0_Preview_1)
namespace Microsoft.BlobStorage;

@error
/** The error response. */
model StorageError {
  /** The error message. */
  Message: string;
}

/// Parameters

/** The blob append offset response header. */
model BlobAppendOffsetResponseHeader {
  /** This response header is returned only for append operations. It returns the offset at which the block was committed, in bytes. */
  @header
  @clientName("BlobAppendOffset")
  `x-ms-blob-append-offset`: int64;
}

/** The blob condition append position parameter. */
model BlobConditionAppendPosParameter {
  /** Optional conditional header, used only for the Append Block operation. A number indicating the byte offset to compare. Append Block will succeed only if the append position is equal to this number. If it is not, the request will fail with the AppendPositionConditionNotMet error (HTTP status code 412 - Precondition Failed). */
  @header
  @clientName("appendPosition")
  `x-ms-blob-condition-appendpos`: int64;
}

/** The blob condition max size parameter. */
model BlobConditionMaxSizeParameter {
  /** Optional conditional header. The max length in bytes permitted for the append blob. If the Append Block operation would cause the blob to exceed that limit or if the blob size is already greater than the value specified in this header, the request will fail with MaxBlobSizeConditionNotMet error (HTTP status code 412 - Precondition Failed). */
  @header
  @clientName("maxSize")
  `x-ms-blob-condition-maxsize`: int64;
}

/** The sequence number action parameter. */
model SequenceNumberActionParameter {
  /** Required if the x-ms-blob-sequence-number header is set for the request. This property applies to page blobs only. This property indicates how the service should modify the blob's sequence number */
  @clientName("sequenceNumberAction")
  @header `x-ms-sequence-number-action`: SequenceNumberActionType;
}

/** The sequence number actions. */
enum SequenceNumberActionType {
  /** Increment the sequence number. */
  increment,
  /** Set the maximum for the sequence number. */
  max,
  /** Update the sequence number. */
  update
}

/** The sequence number parameter. */
model SequenceNumberParameter {
  /** Set for page blobs only. The sequence number is a user-controlled value that you can use to track requests. The value of the sequence number must be between 0 and 2^63 - 1. */
  @clientName("blobSequenceNumber")
  @header `x-ms-blob-sequence-number`: int64;
}

/** The blob content length required parameter. */
model BlobContentLengthRequired {
  /** This header specifies the maximum size for the page blob, up to 1 TB. The page blob size must be aligned to a 512-byte boundary. */
  @clientName("blobContentLength")
  @header `x-ms-blob-content-length`: int64;
}

/** The previous snapshot parameter. */
model PrevSnapshotParameter {
  /** Optional in version 2015-07-08 and newer. The prevsnapshot parameter is a DateTime value that specifies that the response will contain only pages that were changed between target blob and previous snapshot. Changed pages include both updated and cleared pages. The target blob may be a snapshot, as long as the snapshot specified by prevsnapshot is the older of the two. Note that incremental snapshots are currently supported only for blobs created on or after January 1, 2016. */
  @query
  prevsnapshot: string;
}

/** The previous snapshot URL parameter. */
model PrevSnapshotUrlParameter {
  /** Optional. This header is only supported in service versions 2019-04-19 and after and specifies the URL of a previous snapshot of the target blob. The response will only contain pages that were changed between the target blob and its previous snapshot. */
  @header
  @clientName("prevSnapshotUrl")
  `x-ms-previous-snapshot-url`: string;
}

/** Represnets a page list. */
model PageList {
  /** The page ranges. */
  PageRange: PageRange[];

  /** The clear ranges. */
  ClearRange: ClearRange[];
}

/** The page range. */
model PageRange {
  /** The start of the byte range. */
  Start: int64;

  /** The end of the byte range. */
  End: int64;
}

/** The clear range. */
model ClearRange {
  /** The start of the byte range. */
  Start: int64;

  /** The end of the byte range. */
  End: int64;
}

/** The is immutable storage with versioning enable response header. */
model IsImmutableStorageWithVersioningEnabledResponseHeader {
  /** Indicates whether version level worm is enabled on a container */
  @clientName("IsImmutableStorageWithVersioningEnabled")
  @header `x-ms-immutable-storage-with-versioning-enabled`: boolean;

}

/** The deny encryption scope override response header. */
model DenyEncryptionScopeOverrideResponseHeader {
  /** If a blob has a lease and the lease is of infinite duration then the value of this header is set to true, otherwise it is set to false. */
  @clientName("DenyEncryptionScopeOverride")
  @header `x-ms-deny-encryption-scope-override`: boolean;
}

/** The default encryption scope response header. */
model DefaultEncryptionScopeResponseHeader {
  /** The default encryption scope for the container. */
  @clientName("DefaultEncryptionScope")
  @header `x-ms-default-encryption-scope`: string;
}

/** The has legal hold response header. */
model HasLegalHoldResponseHeader {
  /** Indicates if a blob has a legal hold. */
  @clientName("HasLegalHold")
  @header `x-ms-legal-hold`: boolean;
}

/** The has immutability policy response header. */
model HasImmutabilityPolicyResponseHeader {
  /** Indicates if a blob has an active immutability policy. */
  @clientName("HasImmutabilityPolicy")
  @header `x-ms-has-immutability-policy`: boolean;
}

/** The public access response header. */
model PublicAccessResponseHeader {
  /** The public access setting for the container. */
  @clientName("PublicAccess")
  @header `x-ms-blob-public-access`: PublicAccessType;
}

/** The rehydrate priority response header. */
model RehydratePriorityResponseHeader {
  /** If an object is in rehydrate pending state then this header is returned with priority of rehydrate. Valid values are High and Standard. */
  @clientName("RehydratePriority")
  @header `x-ms-rehydrate-priority`: RehydratePriority;
}

/** The expires on response header. */
model ExpiresOnResponseHeader {
  /** UTC date/time value generated by the service that indicates the time at which the blob will expire. */
  @clientName("ExpiresOn")
  @encode("date-time-rfc1123")
  @header `x-ms-expiry-time`: utcDateTime;
}

/** The access tier change time response header. */
model AccessTierChangeTimeResponseHeader {
  /** The time the tier was changed on the object. This is only returned if the tier on the block blob was ever set. */
  @encode("date-time-rfc1123")
  @clientName("AccessTierChangeTime")
  @header `x-ms-access-tier-change-time`: utcDateTime;
}

/** The archive status response header. */
model ArchiveStatusResponseHeader {
  /** For blob storage LRS accounts, valid values are rehydrate-pending-to-hot/rehydrate-pending-to-cool. If the blob is being rehydrated and is not complete then this header is returned indicating that rehydrate is pending and also tells the destination tier. */
  @clientName("ArchiveStatus")
  @header `x-ms-archive-status`: ArchiveStatus;
}

/** The access tier inferred response header. */
model AccessTierInferredResponseHeader {
  /** For page blobs on a premium storage account only. If the access tier is not explicitly set on the blob, the tier is inferred based on its content length and this header will be returned with true value. */
  @clientName("AccessTierInferred")
  @header `x-ms-access-tier-inferred`: boolean;
}

/** The access tier response header. */
model AccessTierResponseHeader {
  /** The tier of page blob on a premium storage account or tier of block blob on blob storage LRS accounts. For a list of allowed premium page blob tiers, see https://docs.microsoft.com/en-us/azure/virtual-machines/windows/premium-storage#features. For blob storage LRS accounts, valid values are Hot/Cool/Archive. */
  @clientName("AccessTier")
  @header `x-ms-access-tier`: AccessTier;
}

/** The destination snapshot response header. */
model DestinationSnapshotResponseHeader {
  /** Included if the blob is incremental copy blob or incremental copy snapshot, if x-ms-copy-status is success. Snapshot time of the last successful incremental copy snapshot for this blob. */
  @clientName("DestinationSnapshot")
  @header `x-ms-copy-destination-snapshot`: string;
}

/** The is incremental copy response header. */
model IsIncrementalCopyResponseHeader {
  /** Included if the blob is incremental copy blob. */
  @clientName("IsIncrementalCopy")
  @header `x-ms-incremental-copy`: boolean;
}

/** The immutability policy expires on response header. */
model ImmutabilityPolicyExpiresOnResponseHeader {
  /** UTC date/time value generated by the service that indicates the time at which the blob immutability policy will expire. */
  @clientName("ImmutabilityPolicyExpiresOn")
  @encode("date-time-rfc1123")
  @header `x-ms-immutability-policy-until-date`: utcDateTime;
}

/** The last accessed response header. */
model LastAccessedResponseHeader {
  /** UTC date/time value generated by the service that indicates the time at which the blob was last read or written to */
  @clientName("LastAccessed")
  @encode("date-time-rfc1123")
  @header `x-ms-last-access-time`: utcDateTime;
}

/** The is sealed response header. */
model IsSealedResponseHeader {
  /** If this blob has been sealed */
  @clientName("IsSealed")
  @header `x-ms-blob-sealed`: boolean;
}

/** The tag count response header. */
model TagCountResponseHeader {
  /** The number of tags associated with the blob */
  @clientName("TagCount")
  @header `x-ms-tag-count`: int64;
}

/** The blob committed block count response header. */
model BlobCommittedBlockCountResponseHeader {
  /** The number of committed blocks present in the blob. This header is returned only for append blobs. */
  @clientName("BlobCommittedBlockCount")
  @header `x-ms-blob-committed-block-count`: int32;
}

/** The accept ranges response header. */
model AcceptRangesResponseHeader {
  /** Indicates that the service supports requests for partial blob content. */
  @header `Accept-Ranges`: string;
}

/** The is current version response header. */
model IsCurrentVersionResponseHeader {
  /** The value of this header indicates whether version of this blob is a current version, see also x-ms-version-id header. */
  @clientName("IsCurrentVersion")
  @header `x-ms-is-current-version`: boolean;
}

/** The lease status response header. */
model LeaseStatusResponseHeader {
  /** The lease status of the blob. */
  @clientName("LeaseStatus")
  @header `x-ms-lease-status`: LeaseStatus;
}

/** The lease state response header. */
model LeaseStateResponseHeader {
  /** Lease state of the blob. */
  @clientName("LeaseState")
  @header `x-ms-lease-state`: LeaseState;
}

/** The lease duration response header. */
model LeaseDurationResponseHeader {
  /** When a blob is leased, specifies whether the lease is of infinite or fixed duration. */
  @clientName("LeaseDuration")
  @header `x-ms-lease-duration`: LeaseDuration;
}

/** The copy source response header. */
model CopySourceResponseHeader {
  /** URL up to 2 KB in length that specifies the source blob or file used in the last attempted Copy Blob operation where this blob was the destination blob. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
  @clientName("CopySource")
  @header `x-ms-copy-source`: string;
}

/** The copy progress response header. */
model CopyProgressResponseHeader {
  /** Contains the number of bytes copied and the total bytes in the source in the last attempted Copy Blob operation where this blob was the destination blob. Can show between 0 and Content-Length bytes copied. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
  @clientName("CopyProgress")
  @header `x-ms-copy-progress`: string;
}

/** The copy status description response header. */
model CopyStatusDescriptionResponseHeader {
  /** Only appears when x-ms-copy-status is failed or pending. Describes the cause of the last fatal or non-fatal copy operation failure. This header does not appear if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List */
  @clientName("CopyStatusDescription")
  @header `x-ms-copy-status-description`: string;
}

/** The copy completion time response header. */
model CopyCompletionTimeResponseHeader {
  /** Conclusion time of the last attempted Copy Blob operation where this blob was the destination blob. This value can specify the time of a completed, aborted, or failed copy attempt. This header does not appear if a copy is pending, if this blob has never been the destination in a Copy Blob operation, or if this blob has been modified after a concluded Copy Blob operation using Set Blob Properties, Put Blob, or Put Block List. */
  @clientName("CopyCompletionTime")
  @encode("date-time-rfc1123")
  @header `x-ms-copy-completion-time`: utcDateTime;
}

/** The blob type response header. */
model BlobTypeResponseHeader {
  /** The type of the blob. */
  @clientName("BlobType")
  @header `x-ms-blob-type`: BlobType;
}

/** The object replication policy response header. */
model ObjectReplicationPolicyIdResponseHeader {
  /** Optional. Only valid when Object Replication is enabled for the storage container and on the destination blob of the replication. */
  @clientName("ObjectReplicationPolicyId")
  @header `x-ms-or-policy-id`: string;
}

/** The range required put page from URL parameter. */
model RangeRequiredPutPageFromUrlParameter {
  /** Bytes of source data in the specified range. The length of this range should match the ContentLength header and x-ms-range/Range destination range header. */
  @header
  @clientName("range")
  `x-ms-range`: string;
}

/** The source range required put page from URL parameter. */
model SourceRangeRequiredPutPageFromUrlParameter {
  /** Bytes of source data in the specified range. The length of this range should match the ContentLength header and x-ms-range/Range destination range header. */
  @header
  @clientName("sourceRange")
  `x-ms-source-range`: string;
}

/** The if seuqnce number equal to parameter. */
model IfSequenceNumberEqualToParameter {
  /** Specify this header value to operate only on a blob if it has the specified sequence number. */
  @header
  @clientName("ifSequenceNumberEqualTo")
  `x-ms-if-sequence-number-eq`?: int64;
}

/** THe if sequence number less than parameter. */
model IfSequenceNumberLessThanParameter {
  /** Specify this header value to operate only on a blob if it has a sequence number less than the specified. */
  @header
  @clientName("ifSequenceNumberLessThan")
  `x-ms-if-sequence-number-lt`?: int64;
}

/** The if sequence number less than or equal to parameter. */
model IfSequenceNumberLessThanOrEqualToParameter {
  /** Specify this header value to operate only on a blob if it has a sequence number less than or equal to the specified. */
  @header
  @clientName("ifSequenceNumberLessThanOrEqualTo")
  `x-ms-if-sequence-number-le`?: int64;
}

/** The blob content-length response header. */
model BlobContentLengthResponseHeader {
  /** The size of the blob in bytes. */
  @header
  @clientName("blobContentLength")
  `x-ms-blob-content-length`: int64;
}

/** The block list type parameter. */
model BlockListTypeParameter {
  /** Specifies whether to return the list of committed blocks, the list of uncommitted blocks, or both lists together. */
  @query
  @clientName("listType")
  blocklisttype: BlockListType;
}

/** The block list types. */
enum BlockListType {
  /** The list of committed blocks. */
  committed,
  /** The list of uncommitted blocks. */
  uncommitted,
  /** Both lists together. */
  all
}

/** The blob blocks body parameter. */
model BlobBlocksParameter {
  /** Blob Blocks. */
  @body blocks: BlockLookupList;
}

/** The Block lookup list. */
model BlockLookupList {
  // TODO: XML
  /** The committed blocks */
  Committed: string[];
  /** The uncommitted blocks */
  Uncommitted: string[];
  /** The latest blocks */
  Latest: string[];
}

/** The source content CRC64 parameter. */
model SourceContentCrc64Parameter {
  /** Specify the crc64 calculated for the range of bytes that must be read from the copy source. */
  @header
  @clientName("sourceContentCrc64")
  `x-ms-source-content-crc64`?: string;
}

/** The source range parameter. */
model SourceRangeParameter {
  /** Bytes of source data in the specified range. */
  @header
  @clientName("sourceRange")
  `x-ms-source-range`: string;
}

/** The source URL parameter. */
model SourceUrlParameter {
  /** Specify a URL to the copy source. */
  @header
  @clientName("sourceUrl")
  `x-ms-source-url`: string;
}

/** The Block ID parameter. */
model BlockIdParameter {
  /** A valid Base64 string value that identifies the block. Prior to encoding, the string must be less than or equal to 64 bytes in size. For a given blob, the length of the value specified for the blockid parameter must be the same size for each block. */
  @query
  @clientName("blockId")
  blockid: string;
}

/** The is hierarchical namespace enabled response header. */
model IsHierarchicalNamespaceEnabledResponseHeader {
  /** Version 2019-07-07 and newer. Indicates if the account has a hierarchical namespace enabled. */
  @header
  @clientName("IsHierarchicalNamespaceEnabled")
  `x-ms-is-hns-enabled`: boolean;
}

/** The account kind response header. */
model AccountKindResponseHeader {
  /** Identifies the account kind */
  @header
  @clientName("AccountKind")
  `x-ms-account-kind`: AccountKind;
}

/** The SKU name response header. */
model SkuNameResponseHeader {
  /** Identifies the sku name of the account */
  @header
  @clientName("SkuName")
  `x-ms-sku-name`: SkuName;
}

/** The access tier required parameter. */
model AccessTierRequiredParameter {
  /** Indicates the tier to be set on the blob. */
  @header
  @clientName("AccessTier")
  `x-ms-access-tier`: AccessTier;
}

/** The copy ID parameter. */
model CopyIdParameter {
  /** The copy identifier provided in the x-ms-copy-id header of the original Copy Blob operation. */
  @header
  @clientName("CopyId")
  `x-ms-copy-id`: string;
}

/** The content CRC 64 response header. */
model ContentCrc64ResponseHeader {
  /** This response header is returned so that the client can check for the integrity of the copied content. */
  @header
  @clientName("ContentCrc64")
  `x-ms-content-crc64`: string;
}

/** The copy status response header. */
model CopyStatusResponseHeader {
  /** State of the copy operation identified by x-ms-copy-id. */
  @header
  @clientName("CopyStatus")
  `x-ms-copy-status`: CopyStatus;
}

/** The copy ID response header. */
model CopyIdResponseHeader {
  /** String identifier for this copy operation. Use with Get Blob Properties to check the status of this copy operation, or pass to Abort Copy Blob to abort a pending copy. */
  @header
  @clientName("CopyId")
  `x-ms-copy-id`: string;
}

/** The seal blob parameter. */
model SealBlobParameter {
  /** Overrides the sealed state of the destination blob.  Service version 2019-12-12 and newer. */
  @header
  @clientName("SealBlob")
  `x-ms-seal-blob`?: boolean;
}

/** The source if unmodified since parameter. */
model SourceIfUnmodifiedSinceParameter {
  /** Specify this header value to operate only on a blob if it has not been modified since the specified date/time. */
  @header
  @clientName("sourceIfUnmodifiedSince")
  @encode("date-time-rfc1123")
  `x-ms-source-if-unmodified-since`?: utcDateTime;
}

/** The rehydrate priority parameter. */
model RehydratePriorityParameter {
  /** Optional: Indicates the priority with which to rehydrate an archived blob. */
  @clientName("rehydratePriority")
  @header
  `x-ms-rehydrate-priority`?: RehydratePriority;
}

/** The snapshot response header. */
model SnapshotResponseHeader {
  /** Uniquely identifies the snapshot and indicates the snapshot version. It may be used in subsequent requests to access the snapshot. */
  @header
  @clientName("Snapshot")
  `x-ms-snapshot`: string;
}

/** The lease time response header. */
model LeaseTimeResponseHeader {
  /** Approximate time remaining in the lease period, in seconds. */
  @header
  @clientName("LeaseTime")
  `x-ms-lease-time`: int32;
}

/** The lease break period parameter. */
model LeaseBreakPeriodParameter {
  /** For a break operation, proposed duration the lease should continue before it is broken, in seconds, between 0 and 60. This break period is only used if it is shorter than the time remaining on the lease. If longer, the time remaining on the lease is used. A new lease will not be available before the break period has expired, but the lease may be held for longer than the break period. If this header does not appear with a break operation, a fixed-duration lease breaks after the remaining lease period elapses, and an infinite lease breaks immediately. */
  @clientName("breakPeriod")
  @header `x-ms-lease-break-period`?: int32;
}

/** The lease ID required parameter. */
model LeaseIdRequiredParameter {
  /** Required.  A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match. */
  @clientName("leaseId")
  @header `x-ms-lease-id`: string;
}

/** The lease ID response header. */
model LeaseIdResponseHeader {
  /** Uniquely identifies a blobs' lease */
  @header
  @clientName("LeaseId")
  `x-ms-lease-id`: string;
}

/** The encryption scope response header. */
model EncryptionScopeResponseHeader {
  /** If the blob has a MD5 hash, and if request contains range header (Range or x-ms-range), this response header is returned with the value of the whole blob's MD5 value. This value may or may not be equal to the value returned in Content-MD5 header, with the latter calculated from the requested range */
  @clientName("EncryptionScope")
  @header `x-ms-encryption-scope`: string;
}

/** The encryption key SHA256 response header. */
model EncryptionKeySha256ResponseHeader {
  /** The SHA-256 hash of the encryption key used to encrypt the blob. This header is only returned when the blob was encrypted with a customer-provided key. */
  @clientName("EncryptionKeySha256")
  @header `x-ms-encryption-key-sha256`: string;
}

/** The is server encrypted response header. */
model IsServerEncryptedResponseHeader {
  /** The value of this header is set to true if the contents of the request are successfully encrypted using the specified algorithm, and false otherwise. */
  @header
  @clientName("isServerEncrypted")
  `x-ms-request-server-encrypted`?: boolean;
}


// TODO: Collapose Legal Hold?
/** The legal hold response header. */
model LegalHoldResponseHeader {
  /** Specifies the legal hold status to set on the blob. */
  @clientName("legalHold")
  @header `x-ms-legal-hold`: boolean;
}

/** The legal hold required parameter. */
model LegalHoldRequiredParameter {
  /** Required.  Specifies the legal hold status to set on the blob. */
  @clientName("legalHold")
  @header `x-ms-legal-hold`: boolean;
}

/** The immutability policy mode response header. */
model ImmutabilityPolicyModeResponseHeader {
  /** Indicates the immutability policy mode of the blob. */
  @clientName("ImmutabilityPolicyMode")
  @header `x-ms-immutability-policy-mode`: BlobImmutabilityPolicyMode;
}

/** The immutability policy expiration response header. */
model ImmutabilityPolicyExpiryResponseHeader {
  /** Indicates the time the immutability policy will expire. */
  @encode("date-time-rfc1123")
  @clientName("ImmutabilityPolicyExpiry")
  @header `x-ms-immutability-policy-until-date`: utcDateTime;
}

/** The blob sequence number response header. */
model BlobSequenceNumberResponseHeader {
  /** The current sequence number for a page blob. This header is not returned for block blobs or append blobs. */
  @clientName("BlobSequenceNumber")
  @header `x-ms-blob-sequence-number`: int64;
}

/** The blob expiration time parameter. */
model BlobExpiryTimeParameter {
  /** The time to set the blob to expiry. */
  @clientName("ExpiresOn")
  @header `x-ms-expiry-time`: string;
}

/** The blob expiration options parameter. */
model BlobExpiryOptionsParameter {
  /** Required. Indicates mode of the expiry time */
  @clientName("ExpiryOptions")
  @header `x-ms-expiry-option`: BlobExpiryOptions;
}

/** The blob expiration options. */
enum BlobExpiryOptions {
  /** Never expire. */
  NeverExpire,
  /** Relative to creation time. */
  RelativeToCreation,
  /** Relative to now. */
  RelativeToNow,
  /** Absolute time. */
  Absolute
}

/** The Content-Language response header. */
model ContentLanguageResponseHeader {
  /** This header returns the value that was specified for the Content-Language request header. */
  @header `Content-Language`: string;
}

/** The Content-Disposition response header. */
model ContentDispositionResponseHeader {
  /** This header returns the value that was specified for the 'x-ms-blob-content-disposition' header. The Content-Disposition response header field conveys additional information about how to process the response payload, and also can be used to attach additional metadata. For example, if set to attachment, it indicates that the user-agent should not display the response, but instead show a Save As dialog with a filename other than the blob name specified. */
  @header `Content-Disposition`: string;
}

/** The Cache-Control response header. */
model CacheControlResponseHeader {
  /** This header is returned if it was previously specified for the blob. */
  @header `Cache-Control`: string;
}

/** The Content-Encoding response header. */
model ContentEncodingResponseParameter {
  /** This header returns the value that was specified for the Content-Encoding request header */
  @header `Content-Encoding`: string;
}

/** The Content-Range response header. */
model ContentRangeResponseHeader {
  /** Indicates the range of bytes returned in the event that the client requested a subset of the blob by setting the 'Range' request header. */
  @header `Content-Range`: string;
}

/** The Content-MD5 response header. */
model ContentMD5ResponseHeader {
  /** If the blob has an MD5 hash and this operation is to read the full blob, this response header is returned so that the client can check for message content integrity. */
  @header `Content-MD5`: string;
}

/** The Content-Type response header. */
model ContentTypeResponseHeader {
  /** The media type of the body of the response. For batch requests, this is multipart/mixed; boundary=batchresponse_GUID */
  @header `Content-Type`: string;
}

/** The Content-Length response header. */
model ContentLengthResponseHeader {
  /** The number of bytes present in the response body. */
  @header `Content-Length`: int64;
}

/** The version ID response header. */
model VersionIdResponseHeader {
  /** A DateTime value returned by the service that uniquely identifies the blob. The value of this header indicates the blob version, and may be used in subsequent requests to access this version of the blob. */
  @clientName("VersionId")
  @header `x-ms-version-id`: string;
}

/** The version response header. */
model VersionResponseHeader {
  /** Indicates the version of the Blob service used to execute the request. This header is returned for requests made against version 2009-09-19 and above. */
  @clientName("Version")
  @header `x-ms-version`: string;
}

/** The creation time response header. */
model CreationTimeResponseHeader {
  /** Returns the date and time the blob was created. */
  @encode("date-time-rfc1123")
  @clientName("CreationTime")
  @header `x-ms-creation-time`: utcDateTime;
}

/** The last modified response header */
model LastModifiedResponseHeader {
  /** The date/time that the container was last modified. */
  @encode("date-time-rfc1123")
  @header `Last-Modified`: utcDateTime;
}

/** The request ID response header. */
model RequestIdResponseHeader {
  /** This header uniquely identifies the request that was made and can be used for troubleshooting the request. */
  @clientName("RequestId")
  @header `x-ms-request-id`: string;
}

/** The client request ID response header. */
model ClientRequestIdResponseHeader {
  /** If a client request id header is sent in the request, this header will be present in the response with the same value. */
  @clientName("ClientRequestId")
  @header `x-ms-client-request-id`?: string;
}

/** The Date response header */
model DateResponseHeader {
  /** UTC date/time value generated by the service that indicates the time at which the response was initiated */
  @encode("date-time-rfc1123")
  @header Date: utcDateTime;
}

/** The ETag response header */
model ETagResponseHeader {
  /** The ETag contains a value that you can use to perform operations conditionally. */
  @header ETag: string;
}

/** The copy source tags header parameter. */
model CopySourceTagsParameter {
  /** Optional, default 'replace'.  Indicates if source tags should be copied or replaced with the tags specified by x-ms-tags. */
  @clientName("copySourceTags")
  @header `x-ms-copy-source-tags`?: string;
}

/** The blob copy source tags types. */
enum BlobCopySourceTags {
  /** The replace blob source tags option. */
  REPLACE,
  /** The copy blob source tags option. */
  COPY
}

/** The copy source authorization header parameter */
model CopySourceAuthorizationParameter {
  /** Only Bearer type is supported. Credentials should be a valid OAuth access token to copy source. */
  @header
  @clientName("copySourceAuthorization")
  `x-ms-copy-source-authorization`?: string;

}

/** The copy source blob properties parameter. */
model CopySourceBlobPropertiesParameter {
  /** Optional, default is true.  Indicates if properties from the source blob should be copied. */
  @header
  @clientName("copySourceBlobProperties")
  `x-ms-copy-source-blob-properties`?: boolean;
}

/** The copy source header parameter. */
model CopySourceParameter {
  /** Specifies the name of the source page blob snapshot. This value is a URL of up to 2 KB in length that specifies a page blob snapshot. The value should be URL-encoded as it would appear in a request URI. The source blob must either be public or must be authenticated via a shared access signature. */
  @header
  @clientName("copySource")
  `x-ms-copy-source`: string;
}

/** The source content MD5 header parameter. */
model SourceContentMD5Parameter {
  /** Specify the md5 calculated for the range of bytes that must be read from the copy source. */
  @header
  @clientName("sourceContentMD5")
  `x-ms-source-content-md5`?: string;
}

/** The source if tags parameter. */
model SourceIfTagsParameter {
  /** Specify a SQL where clause on blob tags to operate only on blobs with a matching value. */
  @header
  @clientName("sourceIfTags")
  `x-ms-source-if-tags`?: string;
}

/** The source if match parameter. */
model SourceIfMatchParameter {
  /** Specify an ETag value to operate only on blobs with a matching value. */
  @header
  @clientName("sourceIfMatch")
  `x-ms-source-if-match`?: string;
}

/** The source if none match parameter. */
model SourceIfNoneMatchParameter {
  /** Specify this header value to operate only on a blob if it has been modified since the specified date/time. */
  @header
  @clientName("sourceIfNoneMatch")
  `x-ms-source-if-none-match`?: string;
}

/** The source if modified since parameter. */
model SourceIfModifiedSinceParameter {
  /** Specify this header value to operate only on a blob if it has been modified since the specified date/time. */
  @header
  @clientName("sourceIfModifiedSince")
  @encode("date-time-rfc1123")
  `x-ms-source-if-modified-since`?: utcDateTime;
}

/** The content CRC64 parameter. */
model ContentCrc64Parameter {
  /** Specify the transactional crc64 for the body, to be validated by the service. */
  @clientName("transactionalContentCrc64")
  @header `x-ms-content-crc64`?: string;
}

/** The access tier optional parameter. */
model AccessTierOptionalParameter {
  /** Optional.  The tier to be set on the blob. */
  @clientName("tier")
  @header
  `x-ms-access-tier`?: AccessTier;
}

/** The content MD5 parameter. */
model ContentMD5Parameter {
  /** Optional. An MD5 hash of the blob content. Note that this hash is not validated, as the hashes for the individual blocks were validated when each was uploaded. */
  @header
  @clientName("transactionalContentMD5")
  `Content-MD5`?: string;
}

/** The legal hold optional parameter. */
model LegalHoldOptionalParameter {
  /** Specified if a legal hold should be set on the blob. */
  @clientName("legalHold")
  @header `x-ms-legal-hold`?: boolean;
}

/** The immutability policy mode parameter. */
model ImmutabilityPolicyModeParameter {
  /** Specifies the immutability policy mode to set on the blob. */
  @header
  @clientName("immutabilityPolicyMode")
  `x-ms-immutability-policy-mode`?: BlobImmutabilityPolicyMode;
}

/** The immutability policy expiration parameter. */
model ImmutabilityPolicyExpiryParameter {
  /** Specifies the date time when the blobs immutability policy is set to expire. */
  @header
  @clientName("immutabilityPolicyExpiry")
  @encode("date-time-rfc1123")
  `x-ms-immutability-policy-until-date`?: string;
}

/** The blobs tags header parameter. */
model BlobTagsHeaderParameter {
  /** Optional.  Used to set blob tags in various blob operations. */
  @clientName("BlobTagsString")
  @header
  `x-ms-tags`?: string;
}

/** The blob sequence number parameter. */
model BlobSequenceNumberParameter {
  /** Optional.  The sequence number is a user-controlled property that you can use to track requests. The value of the sequence number must be between 0 and 2^63 - 1. The default value is 0. */
  @header
  @clientName("blobSequenceNumber")
  `x-ms-blob-sequence-number`?: int64;
}

/** The blob content length parameter. */
model BlobContentLengthRequiredParameter {
  /** This header specifies the maximum size for the page blob, up to 1 TB. The page blob size must be aligned to a 512-byte boundary. */
  @header
  @clientName("blobContentLength")
  `x-ms-blob-content-length`: int64;
}

/** The encryption scope parameter. */
model EncryptionScopeParameter {
  /** Optional.  Version 2019-07-07 and later.  Specifies the encryption scope to use to encrypt the data provided in the request. If not specified, the request will be encrypted with the root account key. */
  @clientName("encryptionScope")
  @header `x-ms-encryption-scope`?: string;
}

/** The blob content disposition parameter. */
model BlobContentDispositionParameter {
  /** Optional. Sets the blob's content disposition. If specified, this property is stored with the blob and returned with a read request. */
  @header
  @clientName("blobContentDisposition")
  `x-ms-blob-content-disposition`?: string;
}

/** The blob cache control parameter. */
model BlobCacheControlParameter {
  /** Optional. Sets the blob's cache control. If specified, this property is stored with the blob and returned with a read request. */
  @header
  @clientName("blobCacheControl")
  `x-ms-blob-cache-control`?: string;
}

/** The blob content MD5 parameter. */
model BlobContentMD5Parameter {
  /** Optional. An MD5 hash of the blob content. Note that this hash is not validated, as the hashes for the individual blocks were validated when each was uploaded. */
  @clientName("blobContentMD5")
  @header
  `x-ms-blob-content-md5`?: string;
}

/** The blob content type parameter. */
model BlobContentLanguageParameter {
  /** Optional. Set the blob's content language. If specified, this property is stored with the blob and returned with a read request. */
  @header
  @clientName("blobContentLanguage")
  `x-ms-blob-content-language`?: string;
}

/** The blob content type parameter. */
model BlobContentEncodingParameter {
  /** Optional. Sets the blob's content encoding. If specified, this property is stored with the blob and returned with a read request. */
  @clientName("blobContentEncoding")
  @header
  `x-ms-blob-content-encoding`?: string;
}

/** The blob content type parameter. */
model BlobContentTypeParameter {
  /** Optional. Sets the blob's content type. If specified, this property is stored with the blob and returned with a read request. */
  @header
  @clientName("blobContentType")
  `x-ms-blob-content-type`?: string;
}

/** The optional premium page blob access tier parameter. */
model PremiumPageBlobAccessTierOptional {
  /** Optional. Indicates the tier to be set on the page blob. */
  @clientName("tier")
  @header
  `x-ms-access-tier`?: PremiumPageBlobAccessTier;
}

/** The premium page blob access tier types. */
enum PremiumPageBlobAccessTier {
  /** The premium page blob access tier is P4. */
  P4,
  /** The premium page blob access tier is P6. */
  P6,
  /** The premium page blob access tier is P10. */
  P10,
  /** The premium page blob access tier is P15. */
  P15,
  /** The premium page blob access tier is P20. */
  P20,
  /** The premium page blob access tier is P30. */
  P30,
  /** The premium page blob access tier is P40. */
  P40,
  /** The premium page blob access tier is P50. */
  P50,
  /** The premium page blob access tier is P60. */
  P60,
  /** The premium page blob access tier is P70. */
  P70,
  /** The premium page blob access tier is P80. */
  P80
}

/** The blob name parameter. */
model BlobNameParameter {
  /** The name of the blob. */
  @minLength(1)
  @maxLength(1024)
  @pattern("^[a-zA-Z0-9]+(?:/[a-zA-Z0-9]+)*(?:\\.[a-zA-Z0-9]+){0,1}$")
  @path
  blobName: string;
}

/** The blob delete type parameter. */
model BlobDeleteTypeParameter {
  /** Optional.  Only possible value is 'permanent', which specifies to permanently delete a blob if blob soft delete is enabled. */
  @query
  @clientName("blobDeleteType")
  deletetype?: DeleteSnapshotsOptionType;
}

/** The type of blob deletions. */
enum BlobDeleteType {
  /** Permanently delete the blob. */
  Permanent,
}

/** The delete snapshot parameter. */
model DeleteSnapshotsParameter {
  /** Required if the blob has associated snapshots. Specify one of the following two options: include: Delete the base blob and all of its snapshots. only: Delete only the blob's snapshots and not the blob itself */
  @clientName("deleteSnapshots")
  @header
  `x-ms-delete-snapshots`?: DeleteSnapshotsOptionType;
}

/** The delete snapshots option type. */
enum DeleteSnapshotsOptionType {
  /** The delete snapshots include option is not specified. */
  none,
  /** The delete snapshots include option is include. */
  include,
}

/** The encryption algorithm parameter. */
model EncryptionAlgorithmParameter {
  /** Optional.  Version 2019-07-07 and later.  Specifies the algorithm to use for encryption. If not specified, the default is AES256. */
  @clientName("encryptionAlgorithm")
  @header `x-ms-encryption-algorithm`?: string;
}

/** The encryption key SHA256 hash parameter. */
model EncryptionKeySha256Parameter {
  /** Optional.  Version 2019-07-07 and later.  Specifies the SHA256 hash of the encryption key used to encrypt the data provided in the request. This header is only used for encryption with a customer-provided key. If the request is authenticated with a client token, this header should be specified using the SHA256 hash of the encryption key. */
  @clientName("encryptionKeySha256")
  @header `x-ms-encryption-key-sha256`?: string;
}


/** The encryption key parameter. */
model EncryptionKeyParameter {
  /** Optional.  Version 2019-07-07 and later.  Specifies the encryption key to use to encrypt the data provided in the request. If not specified, the request will be encrypted with the root account key. */
  @clientName("encryptionKey")
  @header `x-ms-encryption-key`?: string;
}

/** The If-Tags parameters. */
model IfTagsParameter {
  /** Specify a SQL where clause on blob tags to operate only on blobs with a matching value. */
  @clientName("ifTags")
  @header `x-ms-if-tags`?: string;
}

/** The If-Match parameter. */
model IfMatchParameter {
  /** A condition that must be met in order for the request to be processed. */
  @header
  @clientName("ifMatch")
  `If-Match`?: string;
}

/** The If-None-Match parameter. */
model IfNoneMatchParameter {
  /** A condition that must be met in order for the request to be processed. */
  @header
  @clientName("ifNoneMatch")
  `If-None-Match`?: string;
}

/** The get range content CRC64 parameter. */
model GetRangeContentCRC64 {
  /** Optional.  When this header is set to true and specified together with the Range header, the service returns the CRC64 hash for the range, as long as the range is less than or equal to 4 MB in size. */
  @header `x-ms-range-get-content-crc64`?: boolean;
}

/** The get range content MD5 parameter. */
model GetRangeContentMD5 {
  /** Optional.  When this header is set to true and specified together with the Range header, the service returns the MD5 hash for the range, as long as the range is less than or equal to 4 MB in size. */
  @header `x-ms-range-get-content-md5`?: boolean;
}

/** The range parameter. */
model RangeParameter {
  /** Return only the bytes of the blob in the specified range. */
  @header
  @clientName("range")
  `x-ms-range`: string;
}

/** The version ID parameter. */
model VersionIdParameter {
  /** The version id parameter is an opaque DateTime value that, when present, specifies the version of the blob to operate on. It's for service version 2019-10-10 and newer. */
  @header
  @clientName("versionId")
  versionid: string;
}

/** The snapshot parameter. */
model SnapshotParameter {
  @doc("The snapshot parameter is an opaque DateTime value that, when present, specifies the blob snapshot to retrieve. For more information on working with blob snapshots, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/creating-a-snapshot-of-a-blob\">Creating a Snapshot of a Blob.</a>")
  @query
  snapshot?: string;
}

/** An enumeration of blobs */
model ListBlobsHierarchySegmentResponse {
  /** The service endpoint. */
  ServiceEndpoint: string; // TODO: XML Attribute

  /** The container name. */
  ContainerName: string; // TODO: XML Attribute

  /** The delimiter of the blobs. */
  Delimiter?: string;

  /** The prefix of the blobs. */
  Prefix?: string;

  /** The marker of the blobs. */
  Marker?: string;

  /** The max results of the blobs. */
  MaxResults?: int32;

  /** The blob segment. */
  Segment: BlobItem[]; // TODO: XML Serialization

  /** The next marker of the blobs. */
  NextMarker?: string;
}

/** The delimiter parameter. */
model DelimiterParameter {
  /** When the request includes this parameter, the operation returns a BlobPrefix element in the response body that acts as a placeholder for all blobs whose names begin with the same substring up to the appearance of the delimiter character. The delimiter may be a single character or a string. */
  @query delimiter: string;
}

/** The list blob includes parameter. */
model ListBlobsInclude {
  /** Include this parameter to specify one or more datasets to include in the response. */
  @query({ format: "csv" }) include?: ListBlobsIncludes[];
}

/** The list blob includes parameter values. */
enum ListBlobsIncludes {
  /** The include copies. */
  copies,
  /** The include deleted blobs. */
  deleted,
  /** The include metadata. */
  metadata,
  /** The include snapshots. */
  snapshots,
  /** The include uncommitted blobs. */
  uncommittedblobs,
  /** The include versions. */
  versions,
  /** The include tags. */
  tags,
  /** The include immutable policy. */
  immutabilitypolicy,
  /** The include legal hold. */
  legalhold,
  /** The include deleted with versions. */
  deletedwithversions
}

/** The lease duration parameter. */
model LeaseDurationParameter {
  /** Specifies the duration of the lease, in seconds, or negative one (-1) for a lease that never expires. A non-infinite lease can be between 15 and 60 seconds. A lease duration cannot be changed using renew or change. */
  @clientName("duration")
  @header
  `x-ms-lease-duration`: int32;
}

/** The source lease ID header parameter. */
model SourceLeaseId {
  /** A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match. */
  @clientName("sourceLeaseId")
  @header `x-ms-source-lease-id`?: string;
}

/** The source container name header parameter. */
model SourceContainerName {
  /** Required.  Specifies the name of the container to rename. */
  @clientName("SourceContainerName")
  @header `x-ms-source-container-name`: string;
}

/** The deleted container name header. */
model DeletedContainerName {
  /** Optional.  Version 2019-12-12 and later.  Specifies the name of the deleted container to restore. */
  @clientName("DeletedContainerName")
  @header `x-ms-deleted-container-name`?: string;
}

/** The deleted container version header. */
model DeletedContainerVersion {
  /** Optional.  Version 2019-12-12 and later.  Specifies the version of the deleted container to restore. */
  @clientName("DeletedContainerVersion")
  @header `x-ms-deleted-container-version`?: string;

}

/** The container ACL parameter. */
model ContainerAcl {
  /** The access control list for the container. */
  @body
  acl: SignedIdentifiers;
}

/** The container name header */
model ContainerNameParameter {
  /** The name of the container. */
  @header
  @path
  containerName: string;
}

/** The If-Unmodified-Since header. */
model IfUnmodifiedSince {
  /** A date-time value. A request is made under the condition that the resource has not been modified since the specified date-time. */
  @header
  @encode("date-time-rfc1123")
  @clientName("ifUnmodifiedSince")
  `If-Unmodified-Since`?: utcDateTime;
}

/** The If-Modified-Since header. */
model IfModifiedSince {
  /** A date-time value. A request is made under the condition that the resource has been modified since the specified date-time. */
  @header
  @encode("date-time-rfc1123")
  @clientName("ifModifiedSince")
  `If-Modified-Since`?: utcDateTime;
}

/** The lease ID parameter. */
model LeaseIdOptional {
  /** If specified, the operation only succeeds if the resource's lease is active and matches this ID. */
  @header
  `x-ms-lease-id`?: string;
}

/** The deny encryption scope override parameter. */
model DenyEncryptionScopeOverride {
  /** Optional.  Version 2019-07-07 and later.  Specifies that the request will fail if the target container does not have the same encryption scope as the source container. */
  @header `x-ms-deny-encryption-scope-override`?: boolean;
}

/** The default encryption scope parameter. */
model DefaultEncryptionScope {
  /** Optional.  Version 2019-07-07 and later.  Specifies the default encryption scope to set on the container and use for all future writes. */
  @header `x-ms-default-encryption-scope`?: string;
}

/** The blob public access parameter. */
model BlobPublicAccess {
  /** Specifies whether data in the container may be accessed publicly and the level of access. Possible values include: 'container', 'blob'. */
  @clientName("access")
  @header `x-ms-blob-public-access`?: PublicAccessType;
}

/** The metadata parameter. */
model MetadataParameter is Record<string> {
  /** Optional. Specifies a user-defined name-value pair associated with the blob. If no name-value pairs are specified, the operation will copy the metadata from the source blob or file to the destination blob. If one or more name-value pairs are specified, the destination blob is created with the specified metadata, and metadata is not copied from the source blob or file. Note that beginning with version 2009-09-19, metadata names must adhere to the naming rules for C# identifiers. See Naming and Referencing Containers, Blobs, and Metadata for more information. */
  @header
  `x-ms-meta`?: string; // TODO: Figure out how to better represent this
}

/** The filter blobs include parameter. */
model FilterBlobsInclude {
  /** Include this parameter to specify one or more datasets to include in the response. */
  @query({ format: "csv" }) include?: FilterBlobsIncludes[];
}

/** The filter blobs where parameter. */
model FilterBlobsWhere {
  /** Filters the results to return only to return only blobs whose tags match the specified expression. */
  @query
  where?: string;
}

/** The Content-Length header. */
model ContentLengthHeader {
  /** The length of the request. */
  @header
  `Content-Length`: int64;
}

/** The Content-Type header for multi-part requests. */
model MultipartContentType {
  /** Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID> */
  @clientName("multipartContentType")
  @header
  `Content-Type`: string;
}

/** The max results parameter. */
model MaxResultsParameter {
  /** Specifies the maximum number of containers to return. If the request does not specify maxresults, or specifies a value greater than 5000, the server will return up to 5000 items. */
  @query maxresults?: int32;
}

/** The marker parameter. */
model MarkerParameter {
  /** A string value that identifies the portion of the list of containers to be returned with the next listing operation. The operation returns the NextMarker value within the response body if the listing operation did not return all containers remaining to be listed with the current page. The NextMarker value can be used as the value for the marker parameter in a subsequent call to request the next page of list items. The marker value is opaque to the client. */
  @query marker?: string;
}

/** The prefix parameter. */
model PrefixParameter {
  /** Filters the results to return only containers whose name begins with the specified prefix. */
  @query prefix?: string;
}

/** The client request ID parameter. */
model ClientRequestIdParameter {
  /** Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled. */
  @clientName("requestId")
  @header
  `x-ms-client-request-id`?: string;
}

/** The timeout parameter. */
model TimeoutParameter {
  @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
  @query timeout?: int32;
}

/** The API version parameter. */
model ApiVersionParameter {
  /** Specifies the version of the operation to use for this request. */
  @header("x-ms-version")
  version: string;
}

/** The lease break period header. */
model LeaseBreakPeriod {
  /** For a break operation, proposed duration the lease should continue before it is broken, in seconds, between 0 and 60. This break period is only used if it is shorter than the time remaining on the lease. If longer, the time remaining on the lease is used. A new lease will not be available before the break period has expired, but the lease may be held for longer than the break period. If this header does not appear with a break operation, a fixed-duration lease breaks after the remaining lease period elapses, and an infinite lease breaks immediately. */
  @header
  @clientName("breakPeriod")
  `x-ms-lease-break-period`?: int32;
}

/** The required lease ID header. */
model ProposedLeaseIdRequired {
  /** Required.  The proposed lease ID for the container. */
  @header `x-ms-proposed-lease-id`: string;
}

/** The optional lease ID header. */
model ProposedLeaseIdOptional {
  /** Optional.  The proposed lease ID for the container. */
  @header `x-ms-proposed-lease-id`?: string;
}

/** The lease ID required header. */
model LeaseIdRequired {
  /** Required.  A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match. */
  @clientName("leaseId")
  @header `x-ms-lease-id`: string;
}

/// Models

/** Represents an array of signed identifiers */
model SignedIdentifiers is Array<SignedIdentifier>;

/** The signed identifier. */
model SignedIdentifier {
  /** The unique ID for the signed identifier. */
  Id: string;
  /** The access policy for the signed identifier. */
  AccessPolicy: AccessPolicy;
}

/** The result of a Filter Blobs API call */
model FilterBlobSegment {
  /** The service endpoint. */
  ServiceEndpoint: string; // TODO: XML Attribute

  /** The filter for the blobs. */
  Where: string;

  /** The blob segment. */
  Blobs: BlobItem[]; // TODO: XML Serialization

  /** The next marker of the blobs. */
  NextMarker?: string;
}

/** The filter blobs includes. */
enum FilterBlobsIncludes {
  /** The filter includes no versions. */
  none,
  /** The filter includes n versions. */
  versions
}

/** The account kind. */
enum AccountKind {
  /** The storage account is a general-purpose account. */
  Storage,
  /** The storage account is a blob storage account. */
  BlobStorage,
  /** The storage account is a storage V2 account. */
  StorageV2,
  /** The storage account is a file storage account. */
  FileStorage,
  /** The storage account is a block blob storage account. */
  BlockBlobStorage
}

/** The SKU types */
enum SkuName {
  /** The standard LRS SKU. */
  Standard_LRS,
  /** The standard GRS SKU. */
  Standard_GRS,
  /** The standard RAGRS SKU. */
  Standard_RAGRS,
  /** The standard ZRS SKU. */
  Standard_ZRS,
  /** The premium LRS SKU. */
  Premium_LRS
}

model ListContainersSegmentResponse {
  /** The service endpoint. */
  ServiceEndpoint: string; // TODO: XML Attribute

  /** The prefix of the containers. */
  Prefix?: string;

  /** The marker of the containers. */
  Marker?: string;

  /** The max results of the containers. */
  MaxResults?: int32;

  /** The container segment. */
  Segment: ContainerItem[]; // TODO: XML Serialization

  /** The next marker of the containers. */
  NextMarker?: string;
}

/** An Azure Storage container. */
model ContainerItem {
  /** The name of the container. */
  Name: string;

  /** The properties of the container. */
  Properties: ContainerProperties;

  /** The metadata of the container. */
  Metadata?: ContainerMetadata;
}

/** The properties of a container. */
model ContainerProperties {
  /** The date-time the container was created in RFC1123 format. */
  @encode("date-time-rfc1123")
  `Creation-Time`?: utcDateTime;

  /** The date-time the container was last modified in RFC1123 format. */
  @encode("date-time-rfc1123")
  `Last-Modified`: utcDateTime;

  /** The ETag of the container. */
  ETag: string;

  /** The lease status of the container. */
  LeaseStatus?: LeaseStatus;

  /** The lease state of the container. */
  LeaseState?: LeaseState;

  /** The lease duration of the container. */
  LeaseDuration?: LeaseDuration;

  /** The public access type of the container. */
  PublicAccess?: PublicAccessType;
}

/** The metadata of a container. */
model ContainerMetadata is Record<string> {
  // @xml.attribute(true)
  Encrypted: string;
}

/** Stats for the storage service. */
model StorageServiceStats {
  /** The geo replication stats. */
  GeoReplication: GeoReplication;
}

/** The geo replication status. */
model GeoReplication {
  Status: GeoReplicationStatus;
  LastSyncTime: string;
}

/** The geo replication status. */
enum GeoReplicationStatus {
  /** The geo replication is live. */
  live,
  /** The geo replication is bootstrap. */
  bootstrap,
  /** The geo replication is unavailable. */
  unavailable
}

/** Key information */
model KeyInfo {
  /** The date-time the key is active. */
  Start: string;
  
  /** The date-time the key expires. */
  Expiry: string;
}

/** A user delegation key. */
model UserDelegationKey {
  /** The Azure Active Directory object ID in GUID format. */
  SignedOid: uuid;

  /** The Azure Active Directory tenant ID in GUID format. */
  SignedTid: uuid;

  /** The date-time the key is active. */
  SignedStart: string;

  /** The date-time the key expires. */
  SignedExpiry: string;

  /** Abbreviation of the Azure Storage service that accepts the key. */
  SignedService: string;

  /** The service version that created the key. */
  SignedVersion: string;

  /** The key as a base64 string. */
  Value: string;
}

/** The public access types. */
enum PublicAccessType {
  /** Blob access. */
  blob,
  /** Container access. */
  container,
}

/** The copy status. */
enum CopyStatus {
  /** The copy operation is pending. */
  pending,
  /** The copy operation succeeded. */
  success,
  /** The copy operation failed. */
  failed,
  /** The copy operation is aborted. */
  aborted,
}

/** The lease duration. */
enum LeaseDuration {
  /** The lease is of infinite duration. */
  infinite,
  /** The lease is of fixed duration. */
  fixed,
}

/** The lease state. */
enum LeaseState {
  /** The lease is available. */
  available,
  /** The lease is currently leased. */
  leased,
  /** The lease is expired. */
  expired,
  /** The lease is breaking. */
  breaking,
  /** The lease is broken. */
  broken,
}

/** The lease status. */
enum LeaseStatus {
  /** The lease is unlocked. */
  unlocked,
  /** The lease is locked. */
  locked,
}

/** Represents an access policy. */
model AccessPolicy {
  /** The date-time the policy is active. */
  Start: utcDateTime;
  
  /** The date-time the policy expires. */
  Expiry: utcDateTime;
  
  /** The permissions for acl the policy. */
  Permission: string;
}

/** The access tiers. */
enum AccessTier {
  /** The hot P4 tier. */
  P4,
  /** The hot P6 tier. */
  P6,
  /** The hot P10 tier. */
  P10,
  /** The hot P15 tier. */
  P15,
  /** The hot P20 tier. */
  P20,
  /** The hot P30 tier. */
  P30,
  /** The hot P40 tier. */
  P40,
  /** The hot P50 tier. */
  P50,
  /** The hot P60 tier. */
  P60,
  /** The hot P70 tier. */
  P70,
  /** The hot P80 tier. */
  P80,
  /** The hot access tier. */
  Hot,
  /** The cool access tier. */
  Cool,
  /** The archive access tier. */
  Archive,
}

/** The archive status. */
enum ArchiveStatus {
  /** The archive status is rehydrating pending to hot. */
  `rehydrate-pending-to-hot`,
  /** The archive status is rehydrating pending to cool. */
  `rehydrate-pending-to-cool`,
  /** The archive status is rehydrating pending to archive. */
  `rehydrate-pending-to-archive`,
  /** The archive status is rehydrating pending to expired. */
  `rehydrate-pending-to-expired`,
}

/** An Azure Storage Blob */
model BlobItem {
  // TODO: Add XML attribute of Encoded
  /** The name of the blob. */
  Name: string;

  /** Whether the blob is deleted. */
  Deleted: boolean;

  /** The snapshot of the blob. */
  Snapshot: string;

  /** The version id of the blob. */
  VersionId?: string;

  /** Whether the blob is the current version. */
  IsCurrentVersion?: boolean;

  /** The properties of the blob. */
  Properties: BlobProperties;

  /** The metadata of the blob. */
  Metadata?: BlobMetadata;

  /** The tags of the blob. */
  Tags?: BlobTag[];

  /** The object replication metadata of the blob. */
  ObjectReplicationMetadata?: ObjectReplicationMetadata;

  /** Whether the blog has versions only. */
  HasVersionsOnly?: boolean;
}

/** The properties of a blob. */
model BlobProperties {
  /** The date-time the blob was created in RFC1123 format. */
  @encode("date-time-rfc1123")
  `Creation-Time`?: utcDateTime;

  /** The date-time the blob was last modified in RFC1123 format. */
  @encode("date-time-rfc1123")
  `Last-Modified`: utcDateTime;

  /** The blog ETag. */
  ETag: string;

  /** The content length of the blob. */
  `Content-Length`?: int64;

  /** The content type of the blob. */
  `Content-Type`?: string;

  /** The content encoding of the blob. */
  `Content-Encoding`?: string;

  /** The content language of the blob. */
  `Content-Language`?: string;

  /** The content MD5 of the blob. */
  `Content-MD5`?: string;

  /** The content disposition of the blob. */
  `Content-Disposition`?: string;

  /** The cache control of the blob. */
  `Cache-Control`?: string;

  /** The sequence number of the blob. */
  `x-ms-blob-sequence-number`?: int64;

  /** The blob type. */
  BlobType?: BlobType;

  /** The lease status of the blob. */
  LeaseStatus?: LeaseStatus;

  /** The lease state of the blob. */
  LeaseState?: LeaseState;

  /** The lease duration of the blob. */
  LeaseDuration?: LeaseDuration;

  /** The copy ID of the blob. */
  CopyId?: string;

  /** The copy status of the blob. */
  CopyStatus?: CopyStatus;

  /** The copy source of the blob. */
  CopySource?: string;

  /** The copy progress of the blob. */
  CopyProgress?: string;

  /** The copy completion time of the blob. */
  @encode("date-time-rfc1123")
  CopyCompletionTime?: utcDateTime;

  /** The copy status description of the blob. */
  CopyStatusDescription?: string;

  /** Whether the blog is encrypted on the server. */
  ServerEncrypted?: boolean;

  /** Whether the blog is incremental copy. */
  IncrementalCopy?: boolean;

  /** The name of the desination snapshot. */
  DestinationSnapshot?: string;

  /** The time the blob was deleted. */
  DeletedTime?: utcDateTime;

  /** The remaining retention days of the blob. */
  RemainingRetentionDays?: int32;

  /** The access tier of the blob. */
  AccessTier?: AccessTier;

  /** Whether the access tier is inferred. */
  AccessTierInferred?: boolean;

  /** The archive status of the blob. */
  ArchiveStatus?: ArchiveStatus;

  /** The encryption scope of the blob. */
  EncryptionScope?: string;

  /** The access tier change time of the blob. */
  @encode("date-time-rfc1123")
  AccessTierChangeTime?: utcDateTime;

  /** The number of tags for the blob. */
  TagCount?: int32;

  @clientName("ExpiresOn")
  /** The expire time of the blob. */
  @encode("date-time-rfc1123")
  `Expiry-Time`?: utcDateTime;

  @clientName("IsSealed")
  /** Whether the blob is sealed. */
  Sealed?: boolean;

  /** The rehydrate priority of the blob. */
  RehydratePriority?: RehydratePriority;

  /** The last access time of the blob. */
  @encode("date-time-rfc1123")
  LastAccessTime?: utcDateTime;

  @clientName("ImmutabilityPolicyExpiresOn")
  /** The immutability policy until time of the blob. */
  @encode("date-time-rfc1123")
  ImmutabilityPolicyUntilDate?: utcDateTime;

  /** The immutability policy mode of the blob. */
  ImmutabilityPolicyMode?: BlobImmutabilityPolicyMode;

  /** Whether the blob is under legal hold. */
  LegalHold?: boolean;
}

/** The immutability policy mode. */
enum BlobImmutabilityPolicyMode {
  /** The immutability policy is mutable. */
  Mutable,
  /** The immutability policy is locked. */
  Locked,
  /** The immutability policy is unlocked. */
  Unlocked
}

/** The blob type. */
enum BlobType {
  /** The blob is a block blob. */
  BlockBlob,
  /** The blob is a page blob. */
  PageBlob,
  /** The blob is an append blob. */
  AppendBlob
}

/** The rehydrate priority. */
enum RehydratePriority {
  /** The rehydrate priority is high. */
  High,
  /** The rehydrate priority is standard. */
  Standard
}

/** The blob metadata. */
model BlobMetadata is Record<string> {
  // @xml.attribute(true)
  Encrypted: string;
}

/** The blob tags. */
model BlobTag {
  /** The key of the tag. */
  Key: string;
  /** The value of the tag. */
  Value: string;
}

/** The object replication metadata. */
model ObjectReplicationMetadata is Record<string>;

/// Service Properties

/** The service properties. */
model StorageServiceProperties {
  /** The logging properties. */
  Logging?: Logging;
  /** The hour metrics properties. */
  HourMetrics?: Metrics;
  /** The minute metrics properties. */
  MinuteMetrics?: Metrics;
  /** The CORS properties. */
  Cors?: CorsRule[];
  /** The default service version. */
  DefaultServiceVersion?: string;
  /** The delete retention policy. */
  DeleteRetentionPolicy?: RetentionPolicy;
  /** The static website properties. */
  StaticWebsite?: StaticWebsite;
}

/** The static website properties. */
model StaticWebsite {
  /** The index document. */
  IndexDocument?: string;
  /** The error document. */
  ErrorDocument?: string;
}

/** The CORS rule. */
model CorsRule {
  /** The allowed origins. */
  AllowedOrigins: string;
  /** The allowed methods. */
  AllowedMethods: string;
  /** The allowed headers. */
  AllowedHeaders: string;
  /** The exposed headers. */
  ExposedHeaders: string;
  /** The maximum age in seconds. */
  MaxAgeInSeconds: int32;
}

/** The metrics properties. */
model Metrics {
  /** The version of the metrics properties. */
  Version?: string;
  /** Whether it is enabled. */
  Enabled: boolean;
  /** Whether to include API in the metrics. */
  IncludeAPIs?: boolean;
  /** The retention policy of the metrics. */
  RetentionPolicy?: RetentionPolicy;
  /** The service properties of the metrics. */
  ServiceProperties?: MetricsServiceProperties;
}

/** The metrics service properties. */
model MetricsServiceProperties {
  /** The hour metrics properties. */
  HourMetrics: MetricsProperties;
  /** The minute metrics properties. */
  MinuteMetrics: MetricsProperties;
}

/** The metrics properties. */
model MetricsProperties {
  /** Whether to include API in the metrics. */
  Enabled: boolean;
  /** The version of the metrics properties. */
  Version: string;
  /** The retention policy of the metrics. */
  RetentionPolicy: RetentionPolicy;
}

/** The logging properties. */
model Logging {
  /** The version of the logging properties. */
  Version: string;
  /** Whether delete operation is logged. */
  Delete: boolean;
  /** Whether read operation is logged. */
  Read: boolean;
  /** Whether write operation is logged. */
  Write: boolean;
  /** The retention policy of the logs. */
  RetentionPolicy: RetentionPolicy;
}

/** The retention policy. */
model RetentionPolicy {
  /** Whether to enable the retention policy. */
  Enabled: boolean;
  /** The number of days to retain the logs. */
  Days: int32;
  /** Whether to allow permanent delete. */
  AllowPermanentDelete: boolean;
}

// List Blobs

/** An enumeration of blobs. */
model ListBlobsFlatSegmentResponse {
  /** The service endpoint. */
  ServiceEndpoint: string; // TODO: XML Attribute

  /** The container name. */
  ContainerName: string; // TODO: XML Attribute

  /** The prefix of the blobs. */
  Prefix?: string;

  /** The marker of the blobs. */
  Marker?: string;

  /** The max results of the blobs. */
  MaxResults?: int32;

  /** The blob segment. */
  Segment: BlobItem[]; // TODO: XML Serialization

  /** The next marker of the blobs. */
  NextMarker?: string;
}
