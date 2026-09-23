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

@doc("Data Asset tracked resource")
@removed(Versions.v2026_02_01_preview)
model DataContainer is TrackedResource<DataContainerProperties> {
  ...ResourceNameParameter<DataContainer>;
}

@doc("The kind of the backing data store.")
@removed(Versions.v2026_02_01_preview)
union DataStoreType {
  @doc("The Azure storage blob kind.")
  AzureStorageBlob: "AzureStorageBlob",

  @doc("The Azure storage file kind.")
  AzureStorageFile: "AzureStorageFile",

  @doc("The Discovery storage kind.")
  DiscoveryStorage: "DiscoveryStorage",

  string,
}

@discriminator("kind")
@doc("An abstract representation of data store kind.")
@removed(Versions.v2026_02_01_preview)
model DataStore {
  @doc("The data store kind.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DataStoreType;
}

@doc("The Azure storage blob properties.")
@removed(Versions.v2026_02_01_preview)
model AzureStorageBlob extends DataStore {
  /** Azure Storage Blob */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DataStoreType.AzureStorageBlob;

  ...WithStorageAccountId;
}

@doc("The Discovery storage properties.")
@removed(Versions.v2026_02_01_preview)
model DiscoveryStorage extends DataStore {
  /** Discovery Storage */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DataStoreType.DiscoveryStorage;

  @doc("The associated Discovery storage ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  discoveryStorageId: Microsoft.Discovery.Shared.DiscoveryStorageId;
}

@doc("The Azure storage file properties.")
@removed(Versions.v2026_02_01_preview)
model AzureStorageFile extends DataStore {
  /** Azure Storage File */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DataStoreType.AzureStorageFile;

  ...WithStorageAccountId;

  /** The name of the file share */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fileShareName: string;
}

@doc("Data Asset properties")
@removed(Versions.v2026_02_01_preview)
model DataContainerProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Data store properties")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataStore: DataStore;

  @doc("Credential to access the dataStore.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minItems(1)
  credentials: Credential[];
}

@armResourceOperations
@removed(Versions.v2026_02_01_preview)
interface DataContainers {
  get is ArmResourceRead<DataContainer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataContainer>;
  update is ArmResourcePatchAsync<DataContainer, DataContainerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DataContainer>;
  listByResourceGroup is ArmResourceListByParent<DataContainer>;
  listBySubscription is ArmListBySubscription<DataContainer>;
}
