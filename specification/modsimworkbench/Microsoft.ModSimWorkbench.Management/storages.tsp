import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

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
}

@doc("Storage properties.")
model StorageProperties {
  ...StorageBaseProperties;

  // Notes for ARM reviewers:
  //    1) performanceTier will be part of top-level sku. We don't want duplicate.
  //    2) ARM team strongly advised up NOT to have defaults for properties.
  //    3) Below is an attempt to no longer have performanceTier default in new API version. But it seems to make it not valid in PATCH, error: Additional properties not allowed: performanceTier
  //    4) We don't have an SDK yet. Preview customers exclusively use Portal for creating/updating MSWB resources.

  // @removed(Versions.`2024-05-01-preview`)
  // @renamedFrom(Versions.`2024-05-01-preview`, "performanceTier")
  // @visibility("read", "create")
  // @doc("Performance tier of the chamber storage.")
  // oldPerformanceTier: StoragePerformanceTier = StoragePerformanceTier.Standard;

  // @added(Versions.`2024-05-01-preview`)
  @visibility("read", "create", "update")
  @doc("Performance tier of the chamber storage.")
  performanceTier?: StoragePerformanceTier; // TODO: Deprecated. Use top-level sku.
}

@doc("Storage tracked resource.")
@parentResource(Chamber)
model Storage is TrackedResource<StorageProperties> {
  @doc("The name of the storage")
  @visibility("read", "create")
  @segment("storages")
  @key("storageName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Availability Zones are a valid envelope property"
  @added(Versions.`2024-05-01-preview`)
  @visibility("read", "create")
  @doc("The availability zones.")
  zones?: Array<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Sku is a valid envelope property"
  @added(Versions.`2024-05-01-preview`)
  @visibility("read", "create", "update")
  @doc("The SKU (Stock Keeping Unit) assigned to this resource.")
  sku: StorageSku;
}

@armResourceOperations
interface Storages
  extends NestedResourceOperations<Storage, StorageProperties> {}
