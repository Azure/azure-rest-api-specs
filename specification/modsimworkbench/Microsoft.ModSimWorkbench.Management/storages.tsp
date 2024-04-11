import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armProviderNamespace("Microsoft.ModSimWorkbench")
@service({
  title: "ModSimWorkbench Control Plane API",
})
@armProviderNamespace
@versioned(Microsoft.ModSimWorkbench.Versions)
namespace Microsoft.ModSimWorkbench;

@doc("Performance tier of chamber storage.")
union StoragePerformanceTier {
  string,

  @doc("Standard tier.")
  Standard: "Standard",

  @doc("Ultra tier.")
  Ultra: "Ultra",

  @doc("Premium tier.")
  Premium: "Premium",
}

@doc("Storage properties common between create and update.")
@access(Access.internal)
model StorageBaseProperties {
  ...ProvisioningStateProperty;
  ...CapacityAllocatedProperty;
  ...CapacityUsedProperty;

  @visibility("read")
  @doc("Directory where the chamber storage volume mounted.")
  localMountPath?: string;
}

@doc("Storage  properties.")
model StorageProperties {
  ...StorageBaseProperties;

  @visibility("read", "create", "update")
  @doc("Performance tier of the chamber storage.")
  performanceTier: StoragePerformanceTier = StoragePerformanceTier.Standard;
}

@doc("Storage update properties.")
model StorageUpdateProperties {
  ...StorageBaseProperties;

  @visibility("read", "create", "update")
  @doc("Performance tier of the chamber storage.")
  performanceTier: StoragePerformanceTier;
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
  extends NestedResourceOperations<
      Storage,
      StorageProperties,
      StorageUpdateProperties
    > {}
