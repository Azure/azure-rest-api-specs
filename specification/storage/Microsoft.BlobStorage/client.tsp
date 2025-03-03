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
@@clientNamespace(Storage.Blob.Container.AppendBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container.BlockBlob, "Azure.Storage.Blobs");
@@clientNamespace(Storage.Blob.Container.PageBlob, "Azure.Storage.Blobs");

@@clientName(Storage.Blob, "ServiceClient");

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
@@clientInitialization(Storage.Blob.Container.AppendBlob,
  {
    parameters: BlobServiceClientParameters,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);
@@clientInitialization(Storage.Blob.Container.BlockBlob,
  {
    parameters: BlobServiceClientParameters,
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  }
);
@@clientInitialization(Storage.Blob.Container.PageBlob,
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

@@clientName(MetadataHeaders, "metadata", "rust");
@@clientName(ObjectReplicationHeaders, "objectReplicationHeaders", "rust");

@@alternateType(BlobPropertiesInternal.contentLength, uint64, "rust");
@@alternateType(BlobContentLengthRequired.blobContentLength, uint64, "rust");
@@alternateType(ContentLengthResponseHeader.contentLength, uint64, "rust");
@@alternateType(ContentLengthParameter.contentLength, uint64, "rust");
@@alternateType(StructuredContentLengthParameter.structuredContentLength, uint64, "rust");
@@alternateType(StructuredContentLengthResponseHeader.structuredContentLength, uint64, "rust");
