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
@doc("The error response.")
model StorageError {
  @doc("The error message.")
  Message: string;
}

/// Parameters

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

@doc("The source if none match parameter.")
model SourceIfNoneMatchParameter {
  @doc("Specify this header value to operate only on a blob if it has been modified since the specified date/time.")
  @header
  @clientName("sourceIfNoneMatch")
  `x-ms-source-if-none-match`?: string;
}

@doc("The source if modified since parameter.")
model SourceIfModifiedSinceParameter {
  @doc("Specify this header value to operate only on a blob if it has been modified since the specified date/time.")
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

@doc("The access tier optional parameter.")
model AccessTierOptionalParameter {
  @doc("Optional.  The tier to be set on the blob.")
  @clientName("tier")
  @header
  `x-ms-access-tier`?: AccessTier;
}

@doc("The content MD5 parameter.")
model ContentMD5Parameter {
  @doc("Optional. An MD5 hash of the blob content. Note that this hash is not validated, as the hashes for the individual blocks were validated when each was uploaded.")
  @header
  @clientName("transactionalContentMD5")
  `Content-MD5`?: string;
}

@doc("The legal hold optional parameter.")
model LegalHoldOptionalParameter {
  @doc("Specified if a legal hold should be set on the blob.")
  @clientName("legalHold")
  @header `x-ms-legal-hold`?: boolean;
}

@doc("The immutability policy mode parameter.")
model ImmutabilityPolicyModeParameter {
  @doc("Specifies the immutability policy mode to set on the blob.")
  @header
  @clientName("immutabilityPolicyMode")
  `x-ms-immutability-policy-mode`?: BlobImmutabilityPolicyMode;
}

@doc("The immutability policy expiration parameter.")
model ImmutabilityPolicyExpiryParameter {
  @doc("Specifies the date time when the blobs immutability policy is set to expire.")
  @header
  @clientName("immutabilityPolicyExpiry")
  @encode("date-time-rfc1123")
  `x-ms-immutability-policy-until-date`?: string;
}

@doc("The blobs tags header parameter.")
model BlobTagsHeaderParameter {
  @doc("Optional.  Used to set blob tags in various blob operations.")
  @clientName("BlobTagsString")
  @header
  `x-ms-tags`?: string;
}

@doc("The blob sequence number parameter.")
model BlobSequenceNumberParameter {
  @doc("Optional.  The sequence number is a user-controlled property that you can use to track requests. The value of the sequence number must be between 0 and 2^63 - 1. The default value is 0.")
  @header
  @clientName("blobSequenceNumber")
  `x-ms-blob-sequence-number`?: int64;
}

@doc("The blob content length parameter.")
model BlobContentLengthRequiredParameter {
  @doc("This header specifies the maximum size for the page blob, up to 1 TB. The page blob size must be aligned to a 512-byte boundary.")
  @header
  @clientName("blobContentLength")
  `x-ms-blob-content-length`: int64;
}

@doc("The encryption scope parameter.")
model EncryptionScopeParameter {
  @doc("Optional.  Version 2019-07-07 and later.  Specifies the encryption scope to use to encrypt the data provided in the request. If not specified, the request will be encrypted with the root account key.")
  @clientName("encryptionScope")
  @header `x-ms-encryption-scope`?: string;
}

@doc("The blob content disposition parameter.")
model BlobContentDispositionParameter {
  @doc("Optional. Sets the blob's content disposition. If specified, this property is stored with the blob and returned with a read request.")
  @header
  @clientName("blobContentDisposition")
  `x-ms-blob-content-disposition`?: string;
}

@doc("The blob cache control parameter.")
model BlobCacheControlParameter {
  @doc("Optional. Sets the blob's cache control. If specified, this property is stored with the blob and returned with a read request.")
  @header
  @clientName("blobCacheControl")
  `x-ms-blob-cache-control`?: string;
}

@doc("The blob content MD5 parameter.")
model BlobContentMD5Parameter {
  @doc("Optional. An MD5 hash of the blob content. Note that this hash is not validated, as the hashes for the individual blocks were validated when each was uploaded.")
  @clientName("blobContentMD5")
  @header
  `x-ms-blob-content-md5`?: string;
}

@doc("The blob content type parameter.")
model BlobContentLanguageParameter {
  @doc("Optional. Set the blob's content language. If specified, this property is stored with the blob and returned with a read request.")
  @header
  @clientName("blobContentLanguage")
  `x-ms-blob-content-language`?: string;
}

@doc("The blob content type parameter.")
model BlobContentEncodingParameter {
  @doc("Optional. Sets the blob's content encoding. If specified, this property is stored with the blob and returned with a read request.")
  @clientName("blobContentEncoding")
  @header
  `x-ms-blob-content-encoding`?: string;
}

@doc("The blob content type parameter.")
model BlobContentTypeParameter {
  @doc("Optional. Sets the blob's content type. If specified, this property is stored with the blob and returned with a read request.")
  @header
  @clientName("blobContentType")
  `x-ms-blob-content-type`?: string;
}

@doc("The optional premium page blob access tier parameter.")
model PremiumPageBlobAccessTierOptional {
  @doc("Optional. Indicates the tier to be set on the page blob.")
  @clientName("tier")
  @header
  `x-ms-access-tier`?: PremiumPageBlobAccessTier;
}

@doc("The premium page blob access tier types.")
enum PremiumPageBlobAccessTier {
  @doc("The premium page blob access tier is P4.")
  P4,
  @doc("The premium page blob access tier is P6.")
  P6,
  @doc("The premium page blob access tier is P10.")
  P10,
  @doc("The premium page blob access tier is P15.")
  P15,
  @doc("The premium page blob access tier is P20.")
  P20,
  @doc("The premium page blob access tier is P30.")
  P30,
  @doc("The premium page blob access tier is P40.")
  P40,
  @doc("The premium page blob access tier is P50.")
  P50,
  @doc("The premium page blob access tier is P60.")
  P60,
  @doc("The premium page blob access tier is P70.")
  P70,
  @doc("The premium page blob access tier is P80.")
  P80
}

@doc("The blob name parameter.")
model BlobNameParameter {
  @doc("The name of the blob.")
  @minLength(1)
  @maxLength(1024)
  @pattern("^[a-zA-Z0-9]+(?:/[a-zA-Z0-9]+)*(?:\\.[a-zA-Z0-9]+){0,1}$")
  @path
  blobName: string;
}

@doc("The blob delete type parameter.")
model BlobDeleteTypeParameter {
  @doc("Optional.  Only possible value is 'permanent', which specifies to permanently delete a blob if blob soft delete is enabled.")
  @query
  @clientName("blobDeleteType")
  deletetype?: DeleteSnapshotsOptionType;
}

@doc("The type of blob deletions.")
enum BlobDeleteType {
  @doc("Permanently delete the blob.")
  Permanent,
}

@doc("The delete snapshot parameter.")
model DeleteSnapshotsParameter {
  @doc("Required if the blob has associated snapshots. Specify one of the following two options: include: Delete the base blob and all of its snapshots. only: Delete only the blob's snapshots and not the blob itself")
  @clientName("deleteSnapshots")
  @header
  `x-ms-delete-snapshots`?: DeleteSnapshotsOptionType;
}

@doc("The delete snapshots option type.")
enum DeleteSnapshotsOptionType {
  @doc("The delete snapshots include option is not specified.")
  none,
  @doc("The delete snapshots include option is include.")
  include,
}

@doc("The encryption algorithm parameter.")
model EncryptionAlgorithmParameter {
  @doc("Optional.  Version 2019-07-07 and later.  Specifies the algorithm to use for encryption. If not specified, the default is AES256.")
  @clientName("encryptionAlgorithm")
  @header `x-ms-encryption-algorithm`?: string;
}

@doc("The encryption key SHA256 hash parameter.")
model EncryptionKeySha256Parameter {
  @doc("Optional.  Version 2019-07-07 and later.  Specifies the SHA256 hash of the encryption key used to encrypt the data provided in the request. This header is only used for encryption with a customer-provided key. If the request is authenticated with a client token, this header should be specified using the SHA256 hash of the encryption key.")
  @clientName("encryptionKeySha256")
  @header `x-ms-encryption-key-sha256`?: string;
}


@doc("The encryption key parameter.")
model EncryptionKeyParameter {
  @doc("Optional.  Version 2019-07-07 and later.  Specifies the encryption key to use to encrypt the data provided in the request. If not specified, the request will be encrypted with the root account key.")
  @clientName("encryptionKey")
  @header `x-ms-encryption-key`?: string;
}

@doc("The If-Tags parameters.")
model IfTagsParameter {
  @doc("Specify a SQL where clause on blob tags to operate only on blobs with a matching value.")
  @clientName("ifTags")
  @header `x-ms-if-tags`?: string;
}

@doc("The If-Match parameter.")
model IfMatchParameter {
  @doc("A condition that must be met in order for the request to be processed.")
  @header
  @clientName("ifMatch")
  `If-Match`?: string;
}

@doc("The If-None-Match parameter.")
model IfNoneMatchParameter {
  @doc("A condition that must be met in order for the request to be processed.")
  @header
  @clientName("ifNoneMatch")
  `If-None-Match`?: string;
}

@doc("The get range content CRC64 parameter.")
model GetRangeContentCRC64 {
  @doc("Optional.  When this header is set to true and specified together with the Range header, the service returns the CRC64 hash for the range, as long as the range is less than or equal to 4 MB in size.")
  @header `x-ms-range-get-content-crc64`?: boolean;
}

@doc("The get range content MD5 parameter.")
model GetRangeContentMD5 {
  @doc("Optional.  When this header is set to true and specified together with the Range header, the service returns the MD5 hash for the range, as long as the range is less than or equal to 4 MB in size.")
  @header `x-ms-range-get-content-md5`?: boolean;
}

@doc("The range parameter.")
model RangeParameter {
  @doc("Return only the bytes of the blob in the specified range.")
  @header
  @clientName("range")
  `x-ms-range`: string;
}

@doc("The version ID parameter.")
model VersionIdParameter {
  @doc("The version id parameter is an opaque DateTime value that, when present, specifies the version of the blob to operate on. It's for service version 2019-10-10 and newer.")
  @header
  @clientName("versionId")
  versionid: string;
}

@doc("The snapshot parameter.")
model SnapshotParameter {
  @doc("The snapshot parameter is an opaque DateTime value that, when present, specifies the blob snapshot to retrieve. For more information on working with blob snapshots, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/creating-a-snapshot-of-a-blob\">Creating a Snapshot of a Blob.</a>")
  @query
  snapshot?: string;
}

@doc("An enumeration of blobs")
model ListBlobsHierarchySegmentResponse {
  @doc("The service endpoint.")
  ServiceEndpoint: string; // TODO: XML Attribute

  @doc("The container name.")
  ContainerName: string; // TODO: XML Attribute

  @doc("The delimiter of the blobs.")
  Delimiter?: string;

  @doc("The prefix of the blobs.")
  Prefix?: string;

  @doc("The marker of the blobs.")
  Marker?: string;

  @doc("The max results of the blobs.")
  MaxResults?: int32;

  @doc("The blob segment.")
  Segment: BlobItem[]; // TODO: XML Serialization

  @doc("The next marker of the blobs.")
  NextMarker?: string;
}

@doc("The delimiter parameter.")
model DelimiterParameter {
  @doc("When the request includes this parameter, the operation returns a BlobPrefix element in the response body that acts as a placeholder for all blobs whose names begin with the same substring up to the appearance of the delimiter character. The delimiter may be a single character or a string.")
  @query delimiter: string;
}

@doc("The list blob includes parameter.")
model ListBlobsInclude {
  @doc("Include this parameter to specify one or more datasets to include in the response.")
  @query({ format: "csv" }) include?: ListBlobsIncludes[];
}

@doc("The list blob includes parameter values.")
enum ListBlobsIncludes {
  @doc("The include copies.")
  copies,
  @doc("The include deleted blobs.")
  deleted,
  @doc("The include metadata.")
  metadata,
  @doc("The include snapshots.")
  snapshots,
  @doc("The include uncommitted blobs.")
  uncommittedblobs,
  @doc("The include versions.")
  versions,
  @doc("The include tags.")
  tags,
  @doc("The include immutable policy.")
  immutabilitypolicy,
  @doc("The include legal hold.")
  legalhold,
  @doc("The include deleted with versions.")
  deletedwithversions
}

@doc("The lease duration parameter.")
model LeaseDurationParameter {
  @doc("Specifies the duration of the lease, in seconds, or negative one (-1) for a lease that never expires. A non-infinite lease can be between 15 and 60 seconds. A lease duration cannot be changed using renew or change.")
  @clientName("duration")
  @header
  `x-ms-lease-duration`: int32;
}

@doc("The source lease ID header parameter.")
model SourceLeaseId {
  @doc("A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match.")
  @clientName("sourceLeaseId")
  @header `x-ms-source-lease-id`?: string;
}

@doc("The source container name header parameter.")
model SourceContainerName {
  @doc("Required.  Specifies the name of the container to rename.")
  @clientName("SourceContainerName")
  @header `x-ms-source-container-name`: string;
}

@doc("The deleted container name header.")
model DeletedContainerName {
  @doc("Optional.  Version 2019-12-12 and later.  Specifies the name of the deleted container to restore.")
  @clientName("DeletedContainerName")
  @header `x-ms-deleted-container-name`?: string;
}

@doc("The deleted container version header.")
model DeletedContainerVersion {
  @doc("Optional.  Version 2019-12-12 and later.  Specifies the version of the deleted container to restore.")
  @clientName("DeletedContainerVersion")
  @header `x-ms-deleted-container-version`?: string;

}

@doc("The container ACL parameter.")
model ContainerAcl {
  @doc("The access control list for the container.")
  @body
  acl: SignedIdentifiers;
}

@doc("The container name header")
model ContainerNameParameter {
  @doc("The name of the container.")
  @header
  @path
  containerName: string;
}

@doc("The If-Unmodified-Since header.")
model IfUnmodifiedSince {
  @doc("A date-time value. A request is made under the condition that the resource has not been modified since the specified date-time.")
  @header
  @encode("date-time-rfc1123")
  @clientName("ifUnmodifiedSince")
  `If-Unmodified-Since`?: utcDateTime;
}

@doc("The If-Modified-Since header.")
model IfModifiedSince {
  @doc("A date-time value. A request is made under the condition that the resource has been modified since the specified date-time.")
  @header
  @encode("date-time-rfc1123")
  @clientName("ifModifiedSince")
  `If-Modified-Since`?: utcDateTime;
}

@doc("The lease ID parameter.")
model LeaseIdOptional {
  @doc("If specified, the operation only succeeds if the resource's lease is active and matches this ID.")
  @header
  `x-ms-lease-id`?: string;
}

@doc("The deny encryption scope override parameter.")
model DenyEncryptionScopeOverride {
  @doc("Optional.  Version 2019-07-07 and later.  Specifies that the request will fail if the target container does not have the same encryption scope as the source container.")
  @header `x-ms-deny-encryption-scope-override`?: boolean;
}

@doc("The default encryption scope parameter.")
model DefaultEncryptionScope {
  @doc("Optional.  Version 2019-07-07 and later.  Specifies the default encryption scope to set on the container and use for all future writes.")
  @header `x-ms-default-encryption-scope`?: string;
}

@doc("The blob public access parameter.")
model BlobPublicAccess {
  @doc("Specifies whether data in the container may be accessed publicly and the level of access. Possible values include: 'container', 'blob'.")
  @clientName("access")
  @header `x-ms-blob-public-access`?: PublicAccessType;
}

@doc("The metadata parameter.")
model MetadataParameter is Record<string> {
  @doc("Optional. Specifies a user-defined name-value pair associated with the blob. If no name-value pairs are specified, the operation will copy the metadata from the source blob or file to the destination blob. If one or more name-value pairs are specified, the destination blob is created with the specified metadata, and metadata is not copied from the source blob or file. Note that beginning with version 2009-09-19, metadata names must adhere to the naming rules for C# identifiers. See Naming and Referencing Containers, Blobs, and Metadata for more information.")
  @header
  `x-ms-meta`?: string; // TODO: Figure out how to better represent this
}

@doc("The filter blobs include parameter.")
model FilterBlobsInclude {
  @doc("Include this parameter to specify one or more datasets to include in the response.")
  @query({ format: "csv" }) include?: FilterBlobsIncludes[];
}

@doc("The filter blobs where parameter.")
model FilterBlobsWhere {
  @doc("Filters the results to return only to return only blobs whose tags match the specified expression.")
  @query
  where?: string;
}

@doc("The Content-Length header.")
model ContentLengthHeader {
  @doc("The length of the request.")
  @header
  `Content-Length`: int64;
}

@doc("The Content-Type header for multi-part requests.")
model MultipartContentType {
  @doc("Required. The value of this header must be multipart/mixed with a batch boundary. Example header value: multipart/mixed; boundary=batch_<GUID>")
  @clientName("multipartContentType")
  @header
  `Content-Type`: string;
}

@doc("The max results parameter.")
model MaxResultsParameter {
  @doc("Specifies the maximum number of containers to return. If the request does not specify maxresults, or specifies a value greater than 5000, the server will return up to 5000 items.")
  @query maxresults?: int32;
}

@doc("The marker parameter.")
model MarkerParameter {
  @doc("A string value that identifies the portion of the list of containers to be returned with the next listing operation. The operation returns the NextMarker value within the response body if the listing operation did not return all containers remaining to be listed with the current page. The NextMarker value can be used as the value for the marker parameter in a subsequent call to request the next page of list items. The marker value is opaque to the client.")
  @query marker?: string;
}

@doc("The prefix parameter.")
model PrefixParameter {
  @doc("Filters the results to return only containers whose name begins with the specified prefix.")
  @query prefix?: string;
}

@doc("The client request ID parameter.")
model ClientRequestIdParameter {
  @doc("Provides a client-generated, opaque value with a 1 KB character limit that is recorded in the analytics logs when storage analytics logging is enabled.")
  @clientName("requestId")
  @header
  `x-ms-client-request-id`?: string;
}

@doc("The timeout parameter.")
model TimeoutParameter {
  @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://docs.microsoft.com/en-us/rest/api/storageservices/fileservices/setting-timeouts-for-blob-service-operations\">Setting Timeouts for Blob Service Operations.</a>")
  @query timeout?: int32;
}

@doc("The API version parameter.")
model ApiVersionParameter {
  @doc("Specifies the version of the operation to use for this request.")
  @header("x-ms-version")
  version: string;
}

@doc("The lease break period header.")
model LeaseBreakPeriod {
  @doc("For a break operation, proposed duration the lease should continue before it is broken, in seconds, between 0 and 60. This break period is only used if it is shorter than the time remaining on the lease. If longer, the time remaining on the lease is used. A new lease will not be available before the break period has expired, but the lease may be held for longer than the break period. If this header does not appear with a break operation, a fixed-duration lease breaks after the remaining lease period elapses, and an infinite lease breaks immediately.")
  @header
  @clientName("breakPeriod")
  `x-ms-lease-break-period`?: int32;
}

@doc("The required lease ID header.")
model ProposedLeaseIdRequired {
  @doc("Required.  The proposed lease ID for the container.")
  @header `x-ms-proposed-lease-id`: string;
}

@doc("The optional lease ID header.")
model ProposedLeaseIdOptional {
  @doc("Optional.  The proposed lease ID for the container.")
  @header `x-ms-proposed-lease-id`?: string;
}

@doc("The lease ID required header.")
model LeaseIdRequired {
  @doc("Required.  A lease ID for the source path. If specified, the source path must have an active lease and the lease ID must match.")
  @clientName("leaseId")
  @header `x-ms-lease-id`: string;
}

/// Models

@doc("Represents an array of signed identifiers")
model SignedIdentifiers is Array<SignedIdentifier>;

@doc("The signed identifier.")
model SignedIdentifier {
  @doc("The unique ID for the signed identifier.")
  Id: string;
  @doc("The access policy for the signed identifier.")
  AccessPolicy: AccessPolicy;
}

@doc("The result of a Filter Blobs API call")
model FilterBlobSegment {
  @doc("The service endpoint.")
  ServiceEndpoint: string; // TODO: XML Attribute

  @doc("The filter for the blobs.")
  Where: string;

  @doc("The blob segment.")
  Blobs: BlobItem[]; // TODO: XML Serialization

  @doc("The next marker of the blobs.")
  NextMarker?: string;
}

@doc("The filter blobs includes.")
enum FilterBlobsIncludes {
  @doc("The filter includes no versions.")
  none,
  @doc("The filter includes n versions.")
  versions
}

@doc("The account kind.")
enum AccountKind {
  @doc("The storage account is a general-purpose account.")
  Storage,
  @doc("The storage account is a blob storage account.")
  BlobStorage,
  @doc("The storage account is a storage V2 account.")
  StorageV2,
  @doc("The storage account is a file storage account.")
  FileStorage,
  @doc("The storage account is a block blob storage account.")
  BlockBlobStorage
}

@doc("The SKU types")
enum SkuName {
  @doc("The standard LRS SKU.")
  Standard_LRS,
  @doc("The standard GRS SKU.")
  Standard_GRS,
  @doc("The standard RAGRS SKU.")
  Standard_RAGRS,
  @doc("The standard ZRS SKU.")
  Standard_ZRS,
  @doc("The premium LRS SKU.")
  Premium_LRS
}

model ListContainersSegmentResponse {
  @doc("The service endpoint.")
  ServiceEndpoint: string; // TODO: XML Attribute

  @doc("The prefix of the containers.")
  Prefix?: string;

  @doc("The marker of the containers.")
  Marker?: string;

  @doc("The max results of the containers.")
  MaxResults?: int32;

  @doc("The container segment.")
  Segment: ContainerItem[]; // TODO: XML Serialization

  @doc("The next marker of the containers.")
  NextMarker?: string;
}

@doc("An Azure Storage container.")
model ContainerItem {
  @doc("The name of the container.")
  Name: string;

  @doc("The properties of the container.")
  Properties: ContainerProperties;

  @doc("The metadata of the container.")
  Metadata?: ContainerMetadata;
}

@doc("The properties of a container.")
model ContainerProperties {
  @doc("The date-time the container was created in RFC1123 format.")
  @encode("date-time-rfc1123")
  `Creation-Time`?: utcDateTime;

  @doc("The date-time the container was last modified in RFC1123 format.")
  @encode("date-time-rfc1123")
  `Last-Modified`: utcDateTime;

  @doc("The ETag of the container.")
  ETag: string;

  @doc("The lease status of the container.")
  LeaseStatus?: LeaseStatus;

  @doc("The lease state of the container.")
  LeaseState?: LeaseState;

  @doc("The lease duration of the container.")
  LeaseDuration?: LeaseDuration;

  @doc("The public access type of the container.")
  PublicAccess?: PublicAccessType;
}

@doc("The metadata of a container.")
model ContainerMetadata is Record<string> {
  // @xml.attribute(true)
  Encrypted: string;
}

@doc("Stats for the storage service.")
model StorageServiceStats {
  @doc("The geo replication stats.")
  GeoReplication: GeoReplication;
}

@doc("The geo replication status.")
model GeoReplication {
  Status: GeoReplicationStatus;
  LastSyncTime: string;
}

@doc("The geo replication status.")
enum GeoReplicationStatus {
  @doc("The geo replication is live.")
  live,
  @doc("The geo replication is bootstrap.")
  bootstrap,
  @doc("The geo replication is unavailable.")
  unavailable
}

@doc("Key information")
model KeyInfo {
  @doc("The date-time the key is active.")
  Start: string;
  
  @doc("The date-time the key expires.")
  Expiry: string;
}

@doc("A user delegation key.")
model UserDelegationKey {
  @doc("The Azure Active Directory object ID in GUID format.")
  SignedOid: uuid;

  @doc("The Azure Active Directory tenant ID in GUID format.")
  SignedTid: uuid;

  @doc("The date-time the key is active.")
  SignedStart: string;

  @doc("The date-time the key expires.")
  SignedExpiry: string;

  @doc("Abbreviation of the Azure Storage service that accepts the key.")
  SignedService: string;

  @doc("The service version that created the key.")
  SignedVersion: string;

  @doc("The key as a base64 string.")
  Value: string;
}

@doc("The public access types.")
enum PublicAccessType {
  @doc("Blob access.")
  blob,
  @doc("Container access.")
  container,
}

@doc("The copy status.")
enum CopyStatus {
  @doc("The copy operation is pending.")
  pending,
  @doc("The copy operation succeeded.")
  success,
  @doc("The copy operation failed.")
  failed,
  @doc("The copy operation is aborted.")
  aborted,
}

@doc("The lease duration.")
enum LeaseDuration {
  @doc("The lease is of infinite duration.")
  infinite,
  @doc("The lease is of fixed duration.")
  fixed,
}

@doc("The lease state.")
enum LeaseState {
  @doc("The lease is available.")
  available,
  @doc("The lease is currently leased.")
  leased,
  @doc("The lease is expired.")
  expired,
  @doc("The lease is breaking.")
  breaking,
  @doc("The lease is broken.")
  broken,
}

@doc("The lease status.")
enum LeaseStatus {
  @doc("The lease is unlocked.")
  unlocked,
  @doc("The lease is locked.")
  locked,
}

@doc("Represents an access policy.")
model AccessPolicy {
  @doc("The date-time the policy is active.")
  Start: utcDateTime;
  
  @doc("The date-time the policy expires.")
  Expiry: utcDateTime;
  
  @doc("The permissions for acl the policy.")
  Permission: string;
}

@doc("The access tiers.")
enum AccessTier {
  @doc("The hot P4 tier.")
  P4,
  @doc("The hot P6 tier.")
  P6,
  @doc("The hot P10 tier.")
  P10,
  @doc("The hot P15 tier.")
  P15,
  @doc("The hot P20 tier.")
  P20,
  @doc("The hot P30 tier.")
  P30,
  @doc("The hot P40 tier.")
  P40,
  @doc("The hot P50 tier.")
  P50,
  @doc("The hot P60 tier.")
  P60,
  @doc("The hot P70 tier.")
  P70,
  @doc("The hot P80 tier.")
  P80,
  @doc("The hot access tier.")
  Hot,
  @doc("The cool access tier.")
  Cool,
  @doc("The archive access tier.")
  Archive,
}

@doc("The archive status.")
enum ArchiveStatus {
  @doc("The archive status is rehydrating pending to hot.")
  `rehydrate-pending-to-hot`,
  @doc("The archive status is rehydrating pending to cool.")
  `rehydrate-pending-to-cool`,
  @doc("The archive status is rehydrating pending to archive.")
  `rehydrate-pending-to-archive`,
  @doc("The archive status is rehydrating pending to expired.")
  `rehydrate-pending-to-expired`,
}

@doc("An Azure Storage Blob")
model BlobItem {
  // TODO: Add XML attribute of Encoded
  @doc("The name of the blob.")
  Name: string;

  @doc("Whether the blob is deleted.")
  Deleted: boolean;

  @doc("The snapshot of the blob.")
  Snapshot: string;

  @doc("The version id of the blob.")
  VersionId?: string;

  @doc("Whether the blob is the current version.")
  IsCurrentVersion?: boolean;

  @doc("The properties of the blob.")
  Properties: BlobProperties;

  @doc("The metadata of the blob.")
  Metadata?: BlobMetadata;

  @doc("The tags of the blob.")
  Tags?: BlobTag[];

  @doc("The object replication metadata of the blob.")
  ObjectReplicationMetadata?: ObjectReplicationMetadata;

  @doc("Whether the blog has versions only.")
  HasVersionsOnly?: boolean;
}

@doc("The properties of a blob.")
model BlobProperties {
  @doc("The date-time the blob was created in RFC1123 format.")
  @encode("date-time-rfc1123")
  `Creation-Time`?: utcDateTime;

  @doc("The date-time the blob was last modified in RFC1123 format.")
  @encode("date-time-rfc1123")
  `Last-Modified`: utcDateTime;

  @doc("The blog ETag.")
  ETag: string;

  @doc("The content length of the blob.")
  `Content-Length`?: int64;

  @doc("The content type of the blob.")
  `Content-Type`?: string;

  @doc("The content encoding of the blob.")
  `Content-Encoding`?: string;

  @doc("The content language of the blob.")
  `Content-Language`?: string;

  @doc("The content MD5 of the blob.")
  `Content-MD5`?: string;

  @doc("The content disposition of the blob.")
  `Content-Disposition`?: string;

  @doc("The cache control of the blob.")
  `Cache-Control`?: string;

  @doc("The sequence number of the blob.")
  `x-ms-blob-sequence-number`?: int64;

  @doc("The blob type.")
  BlobType?: BlobType;

  @doc("The lease status of the blob.")
  LeaseStatus?: LeaseStatus;

  @doc("The lease state of the blob.")
  LeaseState?: LeaseState;

  @doc("The lease duration of the blob.")
  LeaseDuration?: LeaseDuration;

  @doc("The copy ID of the blob.")
  CopyId?: string;

  @doc("The copy status of the blob.")
  CopyStatus?: CopyStatus;

  @doc("The copy source of the blob.")
  CopySource?: string;

  @doc("The copy progress of the blob.")
  CopyProgress?: string;

  @doc("The copy completion time of the blob.")
  @encode("date-time-rfc1123")
  CopyCompletionTime?: utcDateTime;

  @doc("The copy status description of the blob.")
  CopyStatusDescription?: string;

  @doc("Whether the blog is encrypted on the server.")
  ServerEncrypted?: boolean;

  @doc("Whether the blog is incremental copy.")
  IncrementalCopy?: boolean;

  @doc("The name of the desination snapshot.")
  DestinationSnapshot?: string;

  @doc("The time the blob was deleted.")
  DeletedTime?: utcDateTime;

  @doc("The remaining retention days of the blob.")
  RemainingRetentionDays?: int32;

  @doc("The access tier of the blob.")
  AccessTier?: AccessTier;

  @doc("Whether the access tier is inferred.")
  AccessTierInferred?: boolean;

  @doc("The archive status of the blob.")
  ArchiveStatus?: ArchiveStatus;

  @doc("The encryption scope of the blob.")
  EncryptionScope?: string;

  @doc("The access tier change time of the blob.")
  @encode("date-time-rfc1123")
  AccessTierChangeTime?: utcDateTime;

  @doc("The number of tags for the blob.")
  TagCount?: int32;

  @clientName("ExpiresOn")
  @doc("The expire time of the blob.")
  @encode("date-time-rfc1123")
  `Expiry-Time`?: utcDateTime;

  @clientName("IsSealed")
  @doc("Whether the blob is sealed.")
  Sealed?: boolean;

  @doc("The rehydrate priority of the blob.")
  RehydratePriority?: RehydratePriority;

  @doc("The last access time of the blob.")
  @encode("date-time-rfc1123")
  LastAccessTime?: utcDateTime;

  @clientName("ImmutabilityPolicyExpiresOn")
  @doc("The immutability policy until time of the blob.")
  @encode("date-time-rfc1123")
  ImmutabilityPolicyUntilDate?: utcDateTime;

  @doc("The immutability policy mode of the blob.")
  ImmutabilityPolicyMode?: BlobImmutabilityPolicyMode;

  @doc("Whether the blob is under legal hold.")
  LegalHold?: boolean;
}

@doc("The immutability policy mode.")
enum BlobImmutabilityPolicyMode {
  @doc("The immutability policy is mutable.")
  Mutable,
  @doc("The immutability policy is locked.")
  Locked,
  @doc("The immutability policy is unlocked.")
  Unlocked
}

@doc("The blob type.")
enum BlobType {
  @doc("The blob is a block blob.")
  BlockBlob,
  @doc("The blob is a page blob.")
  PageBlob,
  @doc("The blob is an append blob.")
  AppendBlob
}

@doc("The rehydrate priority.")
enum RehydratePriority {
  @doc("The rehydrate priority is high.")
  High,
  @doc("The rehydrate priority is standard.")
  Standard
}

@doc("The blob metadata.")
model BlobMetadata is Record<string> {
  // @xml.attribute(true)
  Encrypted: string;
}

@doc("The blob tags.")
model BlobTag {
  @doc("The key of the tag.")
  Key: string;
  @doc("The value of the tag.")
  Value: string;
}

@doc("The object replication metadata.")
model ObjectReplicationMetadata is Record<string>;

/// Service Properties

@doc("The service properties.")
model StorageServiceProperties {
  @doc("The logging properties.")
  Logging?: Logging;
  @doc("The hour metrics properties.")
  HourMetrics?: Metrics;
  @doc("The minute metrics properties.")
  MinuteMetrics?: Metrics;
  @doc("The CORS properties.")
  Cors?: CorsRule[];
  @doc("The default service version.")
  DefaultServiceVersion?: string;
  @doc("The delete retention policy.")
  DeleteRetentionPolicy?: RetentionPolicy;
  @doc("The static website properties.")
  StaticWebsite?: StaticWebsite;
}

@doc("The static website properties.")
model StaticWebsite {
  @doc("The index document.")
  IndexDocument?: string;
  @doc("The error document.")
  ErrorDocument?: string;
}

@doc("The CORS rule.")
model CorsRule {
  @doc("The allowed origins.")
  AllowedOrigins: string;
  @doc("The allowed methods.")
  AllowedMethods: string;
  @doc("The allowed headers.")
  AllowedHeaders: string;
  @doc("The exposed headers.")
  ExposedHeaders: string;
  @doc("The maximum age in seconds.")
  MaxAgeInSeconds: int32;
}

@doc("The metrics properties.")
model Metrics {
  @doc("The version of the metrics properties.")
  Version?: string;
  @doc("Whether it is enabled.")
  Enabled: boolean;
  @doc("Whether to include API in the metrics.")
  IncludeAPIs?: boolean;
  @doc("The retention policy of the metrics.")
  RetentionPolicy?: RetentionPolicy;
  @doc("The service properties of the metrics.")
  ServiceProperties?: MetricsServiceProperties;
}

@doc("The metrics service properties.")
model MetricsServiceProperties {
  @doc("The hour metrics properties.")
  HourMetrics: MetricsProperties;
  @doc("The minute metrics properties.")
  MinuteMetrics: MetricsProperties;
}

@doc("The metrics properties.")
model MetricsProperties {
  @doc("Whether to include API in the metrics.")
  Enabled: boolean;
  @doc("The version of the metrics properties.")
  Version: string;
  @doc("The retention policy of the metrics.")
  RetentionPolicy: RetentionPolicy;
}

@doc("The logging properties.")
model Logging {
  @doc("The version of the logging properties.")
  Version: string;
  @doc("Whether delete operation is logged.")
  Delete: boolean;
  @doc("Whether read operation is logged.")
  Read: boolean;
  @doc("Whether write operation is logged.")
  Write: boolean;
  @doc("The retention policy of the logs.")
  RetentionPolicy: RetentionPolicy;
}

@doc("The retention policy.")
model RetentionPolicy {
  @doc("Whether to enable the retention policy.")
  Enabled: boolean;
  @doc("The number of days to retain the logs.")
  Days: int32;
  @doc("Whether to allow permanent delete.")
  AllowPermanentDelete: boolean;
}

// List Blobs

@doc("An enumeration of blobs.")
model ListBlobsFlatSegmentResponse {
  @doc("The service endpoint.")
  ServiceEndpoint: string; // TODO: XML Attribute

  @doc("The container name.")
  ContainerName: string; // TODO: XML Attribute

  @doc("The prefix of the blobs.")
  Prefix?: string;

  @doc("The marker of the blobs.")
  Marker?: string;

  @doc("The max results of the blobs.")
  MaxResults?: int32;

  @doc("The blob segment.")
  Segment: BlobItem[]; // TODO: XML Serialization

  @doc("The next marker of the blobs.")
  NextMarker?: string;
}
