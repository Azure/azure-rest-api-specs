import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service({
  title: "ModSimWorkbench Control Plane API",
})
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("Performance tier of chamber storage.")
enum StoragePerformanceTier {
  @doc("Standard tier.")
  Standard,

  @doc("Premium tier.")
  Premium,

  @doc("Ultra tier.")
  Ultra,
}

@doc("Storage properties.")
model StorageProperties {
  ...ProvisioningStateProperty;
  ...CapacityAllocatedProperty;
  ...CapacityUsedProperty;

  @visibility("read")
  @doc("Directory where the chamber storage volume mounted.")
  localMountPath?: string;

  @visibility("read", "create", "update")
  @doc("Performance tier of the chamber storage.")
  performanceTier: StoragePerformanceTier = StoragePerformanceTier.Standard;
}

@doc("Storage tracked resource.")
@parentResource(Chamber)
model Storage is TrackedResource<StorageProperties> {
  @doc("The name of the storage")
  @segment("storages")
  @key("storageName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;
}

@armResourceOperations
interface Storages
  extends NestedResourceOperations<Storage, StorageProperties> {}
