import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Blob;

namespace Customizations;

@@clientNamespace(Storage.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.AppendBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.BlockBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.PageBlob, "Azure.Storage.Blobs");

@@clientName(Storage.Blob.Service, "BlobServiceClient", "rust");
@@clientName(Storage.Blob.Container, "BlobContainerClient", "rust");
@@clientName(Storage.Blob.Blob, "BlobClient", "rust");
@@clientName(Storage.Blob.AppendBlob, "AppendBlobClient", "rust");
@@clientName(Storage.Blob.BlockBlob, "BlockBlobClient", "rust");
@@clientName(Storage.Blob.PageBlob, "PageBlobClient", "rust");

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
@@scope(Storage.Blob.BlockBlob.stageBlockFromUrl, "!rust");
@@scope(Storage.Blob.PageBlob.copyIncremental, "!rust");
@@scope(Storage.Blob.PageBlob.getPageRangesDiff, "!rust");
