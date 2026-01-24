import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;
using Microsoft.Discovery.Shared;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@removed(Versions.v2026_02_01_preview)
@doc("The kind of the backing data store.")
union StorageKind {
  @doc("Use Azure NetApp.")
  AzureNetApp: "AzureNetApp",

  string,
}

@removed(Versions.v2026_02_01_preview)
@doc("Storage tracked resource")
model Storage is TrackedResource<StorageProperties> {
  ...ResourceNameParameter<Storage>;
}

@removed(Versions.v2026_02_01_preview)
@discriminator("kind")
@doc("An abstract representation of data storage kind.")
model Store {
  @doc("The data storage kind.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: StorageKind;
}

@removed(Versions.v2026_02_01_preview)
@doc("The Azure NetApp properties.")
model AzureNetApp extends Store {
  /** Azure NetApp */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: StorageKind.AzureNetApp;
}

@removed(Versions.v2026_02_01_preview)
@doc("Storage properties")
model StorageProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @removed(Versions.v2026_02_01_preview)
  @doc("Data store properties")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  store: Store;

  @removed(Versions.v2026_02_01_preview)
  @doc("The Azure resource ID of the subnet. The subnetId should match the vnetId of supercomputers which will be used for running the tools that use the shared storage.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  subnetId: SubnetId;

  ...MoboConfigurationWithMrg;
}

@removed(Versions.v2026_02_01_preview)
@armResourceOperations
interface Storages {
  get is ArmResourceRead<Storage>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Storage>;
  update is ArmResourcePatchAsync<Storage, StorageProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Storage>;
  listByResourceGroup is ArmResourceListByParent<Storage>;
  listBySubscription is ArmListBySubscription<Storage>;
}
