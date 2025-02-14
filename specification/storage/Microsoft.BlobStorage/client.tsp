import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Versioning;
using Azure.ClientGenerator.Core;
using Storage.Blob;

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

/** Parameters to be added in client constructors */
model BlobServiceClientParameters {
  ...ContainerNamePathParameter;
  ...BlobPathParameter;
}

@@clientName(Storage.Blob, "ServiceClient");
@@clientInitialization(Storage.Blob.Blob, {parameters: BlobServiceClientParameters, initializedBy: InitializedBy.parent | InitializedBy.individually});
@@clientInitialization(Storage.Blob.Container, {parameters: ContainerNamePathParameter, initializedBy: InitializedBy.parent | InitializedBy.individually});
@@clientInitialization(Storage.Blob.AppendBlob, {parameters: BlobServiceClientParameters, initializedBy: InitializedBy.parent | InitializedBy.individually});
@@clientInitialization(Storage.Blob.BlockBlob, {parameters: BlobServiceClientParameters, initializedBy: InitializedBy.parent | InitializedBy.individually});
@@clientInitialization(Storage.Blob.PageBlob, {parameters: BlobServiceClientParameters, initializedBy: InitializedBy.parent | InitializedBy.individually});
