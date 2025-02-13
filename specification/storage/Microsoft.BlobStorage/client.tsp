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

@@clientInitialization(Storage.Blob.Blob, BlobServiceClientParameters);
@@clientInitialization(Storage.Blob.AppendBlob, BlobServiceClientParameters);
@@clientInitialization(Storage.Blob.BlockBlob, BlobServiceClientParameters);
@@clientInitialization(Storage.Blob.PageBlob, BlobServiceClientParameters);
@@clientInitialization(Storage.Blob.Container, ContainerNamePathParameter);

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
