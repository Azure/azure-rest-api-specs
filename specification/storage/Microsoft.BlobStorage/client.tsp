import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Blob;

namespace Customizations;

/** Parameters to be added in client constructors */
model BlobServiceClientParameters {
  ...ContainerNamePathParameter;
  ...BlobPathParameter;
}

@@clientNamespace(Storage.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container.Blob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container.Blob.AppendBlob,
  "Azure.Storage.Blobs"
);
@@clientNamespace(Storage.Blob.Container.Blob.BlockBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container.Blob.PageBlob, "Azure.Storage.Blobs");

@@clientName(Storage.Blob, "BlobServiceClient", "rust");
@@clientName(Storage.Blob.Container, "BlobContainerClient", "rust");
@@clientName(Storage.Blob.Container.Blob, "BlobClient", "rust");
@@clientName(Storage.Blob.Container.Blob.AppendBlob,
  "AppendBlobClient",
  "rust"
);
@@clientName(Storage.Blob.Container.Blob.BlockBlob, "BlockBlobClient", "rust");
@@clientName(Storage.Blob.Container.Blob.PageBlob, "PageBlobClient", "rust");

@@clientInitialization(Storage.Blob.Container,
  {
    parameters: ContainerNamePathParameter,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);
@@clientInitialization(Storage.Blob.Container.Blob,
  {
    parameters: BlobServiceClientParameters,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);
@@clientInitialization(Storage.Blob.Container.Blob.AppendBlob,
  {
    parameters: BlobServiceClientParameters,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);
@@clientInitialization(Storage.Blob.Container.Blob.BlockBlob,
  {
    parameters: BlobServiceClientParameters,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);
@@clientInitialization(Storage.Blob.Container.Blob.PageBlob,
  {
    parameters: BlobServiceClientParameters,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);

@@clientName(ContainerProperties.denyEncryptionScopeOverride,
  "PreventEncryptionScopeOverride"
);
@@clientName(ContainerProperties.immutableStorageWithVersioningEnabled,
  "IsImmutableStorageWithVersioningEnabled"
);
@@clientName(BlobPropertiesInternal.expiryTime, "ExpiresOn");
@@clientName(BlobPropertiesInternal.sealed, "IsSealed");
@@clientName(BlobPropertiesInternal.lastAccessTime, "LastAccessedOn");
@@clientName(BlobPropertiesInternal.immutabilityPolicyUntilDate,
  "ImmutabilityPolicyExpiresOn"
);

@@clientName(MetadataHeaders.metadata, "metadata", "rust");
@@clientName(ObjectReplicationHeaders.objectReplicationRules,
  "objectReplicationRules",
  "rust"
);

@@alternateType(BlobPropertiesInternal.contentLength, uint64, "rust");
@@alternateType(BlobContentLengthRequired.blobContentLength, uint64, "rust");
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
@@scope(Storage.Blob.submitBatch, "!rust");
