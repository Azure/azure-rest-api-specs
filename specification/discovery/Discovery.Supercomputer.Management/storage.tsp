import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Discovery.Management.Shared/all.tsp";

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

@doc("Key Vault Properties with identity and private link references")
@added(Versions.v2026_02_01_preview)
model StorageKeyVaultProperties is KeyVaultWithIdentityReferenceProperties {
  @doc("The Azure resource ID of the private endpoint to the KeyVault, as is required by NetApp Files")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  keyVaultPrivateEndpointResourceId: PrivateEndpointId;
}

@doc("Storage properties")
model StorageProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Data store properties")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  store: Store;

  @doc("The Azure resource ID of the subnet. The subnetId should match the vnetId of supercomputers which will be used for running the tools that use the shared storage.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  subnetId: SubnetId;

  @doc("Whether or not to use a customer managed key when encrypting data at rest")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2026_02_01_preview)
  // Typically this would be something like "KeySource = 'Microsoft.KeyVault' or 'Microsoft.Discovery'". Encryption is all done by downstream services, so keeping this API simplified.
  customerManagedKeys?: CustomerManagedKeys;

  @doc("The key to use for encrypting data at rest when customer managed keys are enabled")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @added(Versions.v2026_02_01_preview)
  keyVaultProperties?: StorageKeyVaultProperties;

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
