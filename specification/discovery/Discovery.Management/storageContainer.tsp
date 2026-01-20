import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Storage Container tracked resource")
@added(Versions.v2026_02_01_preview)
model StorageContainer is TrackedResource<StorageContainerProperties> {
  ...ResourceNameParameter<StorageContainer>;
}

@doc("The kind of the backing storage store.")
@added(Versions.v2026_02_01_preview)
union StorageStoreType {
  @doc("The Azure storage blob kind.")
  AzureStorageBlob: "AzureStorageBlob",

  @doc("The Azure NetApp Files kind.")
  AzureNetAppFiles: "AzureNetAppFiles",

  string,
}

@discriminator("kind")
@doc("An abstract representation of storage store kind.")
@added(Versions.v2026_02_01_preview)
model StorageStore {
  @doc("The storage store kind.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: StorageStoreType;
}

@doc("The Azure storage blob properties.")
@added(Versions.v2026_02_01_preview)
model AzureStorageBlobStore extends StorageStore {
  /** Azure Storage Blob */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: StorageStoreType.AzureStorageBlob;

  ...WithStorageAccountId;
}

@doc("The Azure NetApp Files properties.")
@added(Versions.v2026_02_01_preview)
model AzureNetAppFilesStore extends StorageStore {
  /** Azure NetApp Files */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: StorageStoreType.AzureNetAppFiles;

  ...WithNetAppVolumeId;
}

@doc("Storage Container properties")
@added(Versions.v2026_02_01_preview)
model StorageContainerProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Storage store properties")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageStore: StorageStore;
}

@armResourceOperations
@added(Versions.v2026_02_01_preview)
interface StorageContainers {
  get is ArmResourceRead<StorageContainer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageContainer>;
  update is ArmResourcePatchAsync<StorageContainer, StorageContainerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<StorageContainer>;
  listByResourceGroup is ArmResourceListByParent<StorageContainer>;
  listBySubscription is ArmListBySubscription<StorageContainer>;
}
