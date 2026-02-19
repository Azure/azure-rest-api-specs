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

@@clientOption(BlobItem.name,
  "deserialize_with",
  "crate::models::deserialize_blob_name",
  "rust"
);
@@clientOption(BlobPrefix.name,
  "deserialize_with",
  "crate::models::deserialize_blob_name",
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
