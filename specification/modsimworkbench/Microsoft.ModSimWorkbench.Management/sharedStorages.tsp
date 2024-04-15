import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using OpenAPI;

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
  @visibility("read", "create", "update")
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ModSimWorkbench/chamber";
    }
  ]>;
}

@doc("Shared storage properties common between create and update.")
@access(Access.internal)
model SharedStorageBaseProperties {
  ...ProvisioningStateProperty;
  ...CapacityAllocatedProperty;
  ...CapacityUsedProperty;

  @visibility("read")
  @doc("Directory where the shared storage volume mounted.")
  localMountPath?: string;

  @visibility("read", "create", "update")
  @doc("List of Chambers connected to the shared storage.")
  @extension("x-ms-identifiers", ["id"])
  chambers: Array<ConnectedChamber>;
}

@doc("Shared storage properties.")
model SharedStorageProperties {
  ...SharedStorageBaseProperties;

  @visibility("read", "create")
  @doc("Performance tier of the shared storage.")
  performanceTier: SharedStoragePerformanceTier = SharedStoragePerformanceTier.Standard;
}

@doc("Shared storage update properties.")
model SharedStorageUpdateProperties {
  ...SharedStorageBaseProperties;

  @visibility("update")
  @doc("Performance tier of the shared storage.")
  performanceTier: SharedStoragePerformanceTier;
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
  extends NestedResourceOperations<
      SharedStorage,
      SharedStorageProperties,
      SharedStorageUpdateProperties
    > {}
