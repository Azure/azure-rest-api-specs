import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./EdgeMachine.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureStackHCI;

/** Storage pool reported by an Edge Machine. */
@added(Versions.v2027_01_15_preview)
@parentResource(EdgeMachine)
model EdgeMachineStoragePool
  is Azure.ResourceManager.ProxyResource<EdgeMachineStoragePoolProperties> {
  ...ResourceNameParameter<
    Resource = EdgeMachineStoragePool,
    KeyName = "storagePoolName",
    SegmentName = "storagePools",
    NamePattern = "^[A-Za-z0-9_-]{3,63}$"
  >;
}

/** Read-only operations for storage pools on an Edge Machine. */
@added(Versions.v2027_01_15_preview)
@armResourceOperations
interface EdgeMachineStoragePools {
  /** Get a storage pool on an Edge Machine. */
  get is ArmResourceRead<EdgeMachineStoragePool>;

  /** List storage pools on an Edge Machine. */
  list is ArmResourceListByParent<EdgeMachineStoragePool>;
}
