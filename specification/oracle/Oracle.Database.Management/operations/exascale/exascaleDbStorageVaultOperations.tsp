import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exascale/exascaleDbStorageVault.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using Autorest;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
@armResourceOperations
interface ExascaleDbStorageVaults {
  get is ArmResourceRead<ExascaleDbStorageVault>;
  create is ArmResourceCreateOrUpdateAsync<ExascaleDbStorageVault>;
  update is ArmTagsPatchAsync<ExascaleDbStorageVault>;
  delete is ArmResourceDeleteWithoutOkAsync<ExascaleDbStorageVault>;
  listByResourceGroup is ArmResourceListByParent<ExascaleDbStorageVault>;
  listBySubscription is ArmListBySubscription<ExascaleDbStorageVault>;
}
