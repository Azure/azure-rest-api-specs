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

@doc("Performance tier of shared storage.")
union SharedStoragePerformanceTier {
  string,

  @doc("Standard tier.")
  Standard: "Standard",

  @doc("Ultra tier.")
  Ultra: "Ultra",
}

@doc("List of chambers connected to a shared storage.")
model ConnectedChamber {
  @doc("Fully qualified resource ID for the chamber resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id: string; // TODO: Change to chamberId
}

@doc("Shared storage properties.")
model SharedStorageProperties {
  ...ProvisioningStateProperty;
  ...CapacityAllocatedProperty;
  ...CapacityUsedProperty;

  @visibility("read")
  @doc("Directory where the shared storage volume mounted.")
  localMountPath?: string;

  @visibility("read", "create", "update")
  @doc("Performance tier of the shared storage.")
  performanceTier: SharedStoragePerformanceTier = SharedStoragePerformanceTier.Standard;

  @visibility("read", "create", "update")
  @doc("List of Chambers connected to the shared storage.")
  chambers: Array<ConnectedChamber>;
}

@doc("Shared storage tracked resource.")
@parentResource(Workbench)
model SharedStorage is TrackedResource<SharedStorageProperties> {
  @doc("The name of the shared storage")
  @segment("sharedStorages")
  @key("sharedStorageName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;
}

@armResourceOperations
interface SharedStorages
  extends NestedResourceOperations<SharedStorage, SharedStorageProperties> {}
