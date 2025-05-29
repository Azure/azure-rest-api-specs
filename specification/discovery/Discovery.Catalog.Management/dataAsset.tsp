import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./dataContainer.tsp";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Data Asset properties")
model DataAssetProperties {
  ...Microsoft.Discovery.Shared.WithDescription;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The path to the data within its parent container.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  path?: string;
}

@doc("Data Asset tracked resource")
@parentResource(DataContainer)
model DataAsset is TrackedResource<DataAssetProperties> {
  ...ResourceNameParameter<DataAsset>;
}

@armResourceOperations
interface DataAssets {
  get is ArmResourceRead<DataAsset>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataAsset>;
  update is ArmResourcePatchAsync<DataAsset, DataAssetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DataAsset>;
  listByDataContainer is ArmResourceListByParent<DataAsset>;
  listBySubscription is ArmListBySubscription<DataAsset>;
}
