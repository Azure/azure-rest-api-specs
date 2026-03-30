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

@@alternateType(BlobItem.name, string, "rust");
@@alternateType(BlobPrefix.name, string, "rust");

#suppress "@azure-tools/typespec-client-generator-core/client-option"
@@clientOption(BlobItem.name,
  "deserialize_with",
  "crate::models::blob_name::option::deserialize",
  "rust"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option"
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

@@clientName(Storage.Blob.BlockBlob.upload, "upload_internal", "rust");
@@clientName(Storage.Blob.Blob.download, "download_internal", "rust");

@@clientName(MetadataHeaders.metadata, "metadata", "rust");
@@clientName(ObjectReplicationHeaders.objectReplicationRules,
  "objectReplicationRules",
  "rust"
);
@@alternateType(BlobProperties.contentLength, uint64, "rust");
@@alternateType(BlobContentLengthRequired.size, uint64, "rust");
@@alternateType(ContentLengthResponseHeader.contentLength, uint64, "rust");
@@alternateType(ContentLengthParameter.contentLength, uint64, "rust");
@@alternateType(StructuredContentLengthParameter.structuredContentLength,
  uint64,
  "rust"
);
@@alternateType(StructuredContentLengthResponseHeader.structuredContentLength,
  uint64,
  "rust"
);

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

/** ----- This section overrides the setAccessPolicy operation for Rust to require the containerAcl body ----- */
/** Sets the permissions for the specified container. The permissions indicate whether blobs in a container may be accessed publicly. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/no-response-body" "Existing API"
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?restype=container&comp=acl")
op setAccessPolicyRequiredContainerAcl is StorageOperationNoBody<
  {
    /** The media type of the requestbody */
    @header("Content-Type")
    contentType?: "application/xml";

    /** The access control list for the container. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
    @body
    containerAcl: SignedIdentifiers;

    ...TimeoutParameter;
    ...LeaseIdOptionalParameter;
    ...BlobPublicAccessParameter;
    ...IfModifiedSinceParameter;
    ...IfUnmodifiedSinceParameter;
  },
  {
    ...EtagResponseHeaderPrivate;
    ...LastModifiedResponseHeaderPrivate;
  }
>;

@@override(Container.setAccessPolicy,
  setAccessPolicyRequiredContainerAcl,
  "rust"
);
