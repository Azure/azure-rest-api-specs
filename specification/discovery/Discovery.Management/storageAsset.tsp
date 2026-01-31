import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./storageContainer.tsp";
import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Storage Asset properties")
@added(Versions.v2026_02_01_preview)
model StorageAssetProperties {
  ...Microsoft.Discovery.Shared.WithDescription;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The path to the data within its parent container.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  path?: string;
}

@doc("Storage Asset tracked resource")
@parentResource(StorageContainer)
@added(Versions.v2026_02_01_preview)
model StorageAsset is TrackedResource<StorageAssetProperties> {
  ...ResourceNameParameter<StorageAsset>;
}

@armResourceOperations
@added(Versions.v2026_02_01_preview)
interface StorageAssets {
  get is ArmResourceRead<StorageAsset>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageAsset>;
  update is ArmResourcePatchAsync<StorageAsset, StorageAssetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<StorageAsset>;
  listByStorageContainer is ArmResourceListByParent<StorageAsset>;
}
