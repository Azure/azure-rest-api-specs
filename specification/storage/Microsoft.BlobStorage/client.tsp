import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Blob;

namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust"
)
interface BlobServiceClient extends Storage.Blob.Service {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust"
)
interface BlobContainerClient extends Storage.Blob.Container {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust"
)
interface BlobClient extends Storage.Blob.Blob {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust"
)
interface AppendBlobClient extends Storage.Blob.AppendBlob {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust"
)
interface BlockBlobClient extends Storage.Blob.BlockBlob {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Blob,
  },
  "rust"
)
interface PageBlobClient extends Storage.Blob.PageBlob {}

@@clientInitialization(BlobServiceClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@clientInitialization(BlobContainerClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@clientInitialization(BlobClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@clientInitialization(AppendBlobClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@clientInitialization(BlockBlobClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@clientInitialization(PageBlobClient,
  {
    initializedBy: InitializedBy.customizeCode,
  }
);

@@usage(BlobName, Usage.output, "rust");

@@access(Error, Access.internal, "rust");

@@alternateType(BlobItem.name, string, "rust");
@@alternateType(BlobPrefix.name, string, "rust");

@@clientOption(BlobItem.name,
  "deserialize_with",
  "crate::models::blob_name::option::deserialize",
  "rust"
);
@@clientOption(BlobPrefix.name,
  "deserialize_with",
  "crate::models::blob_name::option::deserialize",
  "rust"
);

@@clientNamespace(Storage.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.AppendBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.BlockBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.PageBlob, "Azure.Storage.Blobs");
@@clientNamespace(BlobServiceClient, "Azure.Storage.Blobs");
@@clientNamespace(BlobContainerClient, "Azure.Storage.Blobs");
@@clientNamespace(BlobClient, "Azure.Storage.Blobs");
@@clientNamespace(AppendBlobClient, "Azure.Storage.Blobs");
@@clientNamespace(BlockBlobClient, "Azure.Storage.Blobs");
@@clientNamespace(PageBlobClient, "Azure.Storage.Blobs");

@@clientName(Storage.Blob.BlockBlob.upload, "upload_internal", "rust");
@@clientName(Storage.Blob.Blob.download, "download_internal", "rust");

@@clientName(ContainerProperties.denyEncryptionScopeOverride,
  "PreventEncryptionScopeOverride"
);
@@clientName(ContainerProperties.immutableStorageWithVersioningEnabled,
  "IsImmutableStorageWithVersioningEnabled"
);
@@clientName(BlobProperties.expiryTime, "ExpiresOn");
@@clientName(BlobProperties.sealed, "IsSealed");
@@clientName(BlobProperties.lastAccessTime, "LastAccessedOn");
@@clientName(BlobProperties.immutabilityPolicyUntilDate,
  "ImmutabilityPolicyExpiresOn"
);
@@clientName(MetadataHeaders.metadata, "metadata", "rust");
@@clientName(ObjectReplicationHeaders.objectReplicationRules,
  "objectReplicationRules",
  "rust"
);
@@clientName(ImmutabilityPolicyExpiryRequiredParameter.immutabilityPolicyExpiry,
  "expiry"
);
@@alternateType(BlobProperties.contentLength, uint64, "rust");
@@alternateType(BlobContentLengthRequired.size, uint64, "rust");
@@alternateType(ContentLengthResponseHeader.contentLength, uint64, "rust");
@@alternateType(ContentLengthParameter.contentLength, uint64, "rust");
// @@alternateType(StructuredContentLengthParameter.structuredContentLength,
//   uint64,
//   "rust"
// );
// @@alternateType(StructuredContentLengthResponseHeader.structuredContentLength,
//   uint64,
//   "rust"
// );

@@scope(Storage.Blob.Container.submitBatch, "!rust");
@@scope(Storage.Blob.Service.submitBatch, "!rust");
@@scope(Storage.Blob.Service.getUserDelegationKey, "!rust");
@@scope(Storage.Blob.Container.listBlobHierarchySegment, "!rust");
@@scope(Storage.Blob.Container.rename, "!rust");
@@scope(Storage.Blob.Container.restore, "!rust");
@@scope(Storage.Blob.Blob.abortCopyFromUrl, "!rust");
@@scope(Storage.Blob.Blob.copyFromUrl, "!rust");
@@scope(Storage.Blob.Blob.setExpiry, "!rust");
@@scope(Storage.Blob.Blob.startCopyFromUrl, "!rust");
@@scope(Storage.Blob.BlockBlob.query, "!rust");
@@scope(Storage.Blob.PageBlob.copyIncremental, "!rust");
@@scope(Storage.Blob.PageBlob.getPageRangesDiff, "!rust");

/** ----- This section overrides the setMetadata operations for Rust to require the metadata headers ----- */
alias MetadataHeadersRequired = {
  /** The metadata headers. */
  @alternateType(Record<string>, "rust")
  @header("x-ms-meta")
  metadata: string;
};

/** operation sets one or more user-defined name-value pairs for the specified container. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@sharedRoute
@route("?restype=container&comp=metadata")
op setMetadataRequiredMetadataContainer is StorageOperationNoBody<
  {
    ...TimeoutParameter;
    ...LeaseIdOptionalParameter;
    ...MetadataHeadersRequired;
    ...IfModifiedSinceParameter;
  },
  {
    ...EtagResponseHeaderPrivate;
    ...LastModifiedResponseHeaderPrivate;
  }
>;

@@override(Container.setMetadata, setMetadataRequiredMetadataContainer, "rust");

/** The Set Metadata operation sets user-defined metadata for the specified blob as one or more name-value pairs. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?comp=metadata")
op setMetadataRequiredMetadataBlob is StorageOperationNoBody<
  {
    ...TimeoutParameter;
    ...MetadataHeadersRequired;
    ...LeaseIdOptionalParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...IfModifiedSinceParameter;
    ...IfUnmodifiedSinceParameter;
    ...IfNoneMatchParameter;
    ...IfMatchParameter;
    ...IfTagsParameter;
  },
  {
    ...EtagResponseHeaderPrivate;
    ...LastModifiedResponseHeaderPrivate;
    ...VersionIdResponseHeaderPrivate;
    ...RequestServerEncryptedResponseHeaderPrivate;
    ...EncryptionKeySha256ResponseHeaderPrivate;
    ...EncryptionScopeResponseHeaderPrivate;
  }
>;

@@override(Blob.setMetadata, setMetadataRequiredMetadataBlob, "rust");

/** ----- This section overrides the setAccessPolicy operation for Rust to require the container ACL body ----- */
/** Sets the permissions for the specified container. The permissions indicate whether blobs in a container may be accessed publicly. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@sharedRoute
@route("?restype=container&comp=acl")
op setAccessPolicyRequiredAcl is StorageOperationNoBody<
  {
    /** The media type of the request body */
    @header("Content-Type")
    contentType: "application/xml";

    /** The access control list for the container. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
    @body
    containerAcl: SignedIdentifiers;

    ...TimeoutParameter;
    ...LeaseIdOptionalParameter;
    ...BlobPublicAccess;
    ...IfModifiedSinceParameter;
    ...IfUnmodifiedSinceParameter;
  },
  {
    ...EtagResponseHeaderPrivate;
    ...LastModifiedResponseHeaderPrivate;
  }
>;

@@override(Container.setAccessPolicy, setAccessPolicyRequiredAcl, "rust");

// TODO: Need better mechanism than full-overrides for this scenario (omitting an optional parameter)

/** ----- This section overrides structured-body operations for Rust to omit the internal structured-message request parameters ----- */
/** The Upload Pages operation writes a range of pages to a page blob (Rust: omits structured-body request params) */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
#suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
@put
@sharedRoute
@route("?comp=page")
op uploadPagesRust is StorageOperationRequestBody<
  {
    ...BodyParameter;
    ...ContentLengthParameter;
    ...ContentMd5Parameter;
    ...ContentCrc64Parameter;
    ...TimeoutParameter;

    /** Bytes of data in the specified range. */
    @header("Range")
    range: string;

    ...LeaseIdOptionalParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...IfSequenceNumberLessThanOrEqualToParameter;
    ...IfSequenceNumberLessThanParameter;
    ...IfSequenceNumberEqualToParameter;
    ...IfModifiedSinceParameter;
    ...IfUnmodifiedSinceParameter;
    ...IfNoneMatchParameter;
    ...IfMatchParameter;
    ...IfTagsParameter;
    ...PageWriteParameter<"update">;
  },
  {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...BlobSequenceNumberResponseHeader;
    ...RequestServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    ...StructuredBodyTypeResponseHeader;
  },
  "application/octet-stream"
>;

@@override(PageBlob.uploadPages, uploadPagesRust, "rust");

/** The Append Block operation commits a new block of data to the end of an append blob (Rust: omits structured-body request params) */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
#suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
@put
@sharedRoute
@route("?comp=appendblock")
op appendBlockRust is StorageOperationRequestBody<
  {
    ...BodyParameter;
    ...TimeoutParameter;
    ...ContentLengthParameter;
    ...ContentMd5Parameter;
    ...ContentCrc64Parameter;
    ...LeaseIdOptionalParameter;
    ...BlobConditionMaxSizeParameter;
    ...BlobConditionAppendPosParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...IfModifiedSinceParameter;
    ...IfUnmodifiedSinceParameter;
    ...IfNoneMatchParameter;
    ...IfMatchParameter;
    ...IfTagsParameter;
  },
  {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...BlobAppendOffsetResponseHeader;
    ...BlobCommittedBlockCountResponseHeader;
    ...RequestServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    ...StructuredBodyTypeResponseHeader;
  },
  "application/octet-stream"
>;

@@override(AppendBlob.appendBlock, appendBlockRust, "rust");

/** The Upload Block Blob operation updates the content of an existing block blob (Rust: omits structured-body request params) */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
#suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
@put
@sharedRoute
op uploadBlockBlobRust is StorageOperationRequestBody<
  {
    ...MetadataHeaders;
    ...BodyParameter;
    ...TimeoutParameter;
    ...ContentMd5Parameter;
    ...ContentLengthParameter;
    ...BlobContentTypeParameter;
    ...BlobContentEncodingParameter;
    ...BlobContentLanguageParameter;
    ...BlobContentMd5Parameter;
    ...BlobCacheControlParameter;
    ...LeaseIdOptionalParameter;
    ...BlobContentDispositionParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
    ...AccessTierHeader;
    ...IfModifiedSinceParameter;
    ...IfUnmodifiedSinceParameter;
    ...IfNoneMatchParameter;
    ...IfMatchParameter;
    ...IfTagsParameter;
    ...BlobTagsHeaderParameter;
    ...ImmutabilityPolicyExpiryParameter;
    ...ImmutabilityPolicyModeParameter;
    ...LegalHoldOptionalParameter;
    ...ContentCrc64Parameter;

    /** The type of the blob. */
    @header("x-ms-blob-type")
    blobType: "BlockBlob";
  },
  {
    @statusCode statusCode: 201;
    ...EtagResponseHeader;
    ...LastModifiedResponseHeader;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...VersionIdResponseHeader;
    ...RequestServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    ...StructuredBodyTypeResponseHeader;
  },
  "application/octet-stream"
>;

@@override(BlockBlob.upload, uploadBlockBlobRust, "rust");

/** The Stage Block operation creates a new block to be committed as part of a blob (Rust: omits structured-body request params) */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
#suppress "@azure-tools/typespec-azure-core/byos" "Existing API"
@put
@sharedRoute
@route("?comp=block")
op stageBlockRust is StorageOperationRequestBody<
  {
    ...BlockIdParameter;
    ...ContentLengthParameter;
    ...ContentMd5Parameter;
    ...ContentCrc64Parameter;
    ...BodyParameter;
    ...TimeoutParameter;
    ...LeaseIdOptionalParameter;
    ...EncryptionKeyParameter;
    ...EncryptionKeySha256Parameter;
    ...EncryptionAlgorithmParameter;
    ...EncryptionScopeParameter;
  },
  {
    @statusCode statusCode: 201;
    ...ContentMd5ResponseHeader;
    ...ContentCrc64ResponseHeader;
    ...RequestServerEncryptedResponseHeader;
    ...EncryptionKeySha256ResponseHeader;
    ...EncryptionScopeResponseHeader;
    ...StructuredBodyTypeResponseHeader;
  },
  "application/octet-stream"
>;

@@override(BlockBlob.stageBlock, stageBlockRust, "rust");
