import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Versioning;
using Azure.ClientGenerator.Core;
using Storage.Blob;

// namespace Customizations;

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


#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API"
@useDependency(Storage.Blob.Versions.v2025_01_05)
@clientName("ServiceClient")
@clientNamespace("Azure.Storage.Blob")
namespace ServiceClient {
  op setProperties is Service.setProperties;
  op getProperties is Service.getProperties;

  @clientNamespace("Azure.Storage.Blob")
  @clientInitialization({
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  })
  namespace ContainerClient {
    op create is Container.create;
    op getProperties is Container.getProperties;

    @clientInitialization({
      initializedBy: InitializedBy.parent | InitializedBy.individually,
    })
    @clientNamespace("Azure.Storage.Blob")
    namespace BlobClient {
      op download is Blob.download;
      op getProperties is Blob.getProperties;
    }
  }
}

// /** Parameters to be added in client constructors */
// model BlobServiceClientParameters {
//   ...ContainerNamePathParameter;
//   ...BlobPathParameter;
// }

// @@clientInitialization(Storage.Blob.Blob, BlobServiceClientParameters);
// @@clientInitialization(Storage.Blob.AppendBlob, BlobServiceClientParameters);
// @@clientInitialization(Storage.Blob.BlockBlob, BlobServiceClientParameters);
// @@clientInitialization(Storage.Blob.PageBlob, BlobServiceClientParameters);
// @@clientInitialization(Storage.Blob.Container, ContainerNamePathParameter);
