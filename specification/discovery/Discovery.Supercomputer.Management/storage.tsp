import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using Microsoft.Discovery.Shared;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("The kind of the backing data store.")
union StorageKind {
  @doc("Use Azure NetApp.")
  AzureNetApp: "AzureNetApp",

  string,
}

@doc("Storage tracked resource")
model Storage is TrackedResource<StorageProperties> {
  ...ResourceNameParameter<Storage>;
}

@discriminator("kind")
@doc("An abstract representation of data storage kind.")
model Store {
  @doc("The data storage kind.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: StorageKind;
}

@doc("The Azure NetApp properties.")
model AzureNetApp extends Store {
  /** Azure NetApp */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: StorageKind.AzureNetApp;
}

@doc("Storage properties")
model StorageProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Data store properties")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  store: Store;

  @doc("The ARM resource ID of the subnet. The subnetId should match the vnetId of supercomputers which will be used for running the tools that use the shared storage.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  subnetId: SubnetId;

  ...MoboConfigurationWithMrg;
}

@armResourceOperations
interface Storages {
  get is ArmResourceRead<Storage>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Storage>;
  update is ArmResourcePatchAsync<Storage, StorageProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Storage>;
  listByResourceGroup is ArmResourceListByParent<Storage>;
  listBySubscription is ArmListBySubscription<Storage>;
}
