import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Blob;

// namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Pre-existing API"
@clientName("ServiceClient")
@clientNamespace("Azure.Storage.Blob")
namespace Customizations {
  interface ServiceClient extends Service {}

  @clientNamespace("Azure.Storage.Blob")
  @clientInitialization({
    initializedBy: InitializedBy.parent | InitializedBy.individually,
  })
  namespace ContainerClient {
    interface ContainerClient extends Container {}

    @clientNamespace("Azure.Storage.Blob")
    namespace BlobClient {
      interface BlobClient extends Storage.Blob.Blob {}
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
