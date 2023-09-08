import "./LiftrBase.Storage/main.tsp";

@armProviderNamespace
@useLibraryNamespace(LiftrBase.Storage, LiftrBase)
@service({
  title: "PureStorage.Block",
})
@versioned(PureStorage.Block.Versions)
namespace PureStorage.Block;

using Azure.ResourceManager;
using LiftrBase;
using LiftrBase.Storage;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Supported versions for PureStorage.Block.")
enum Versions {
  @doc("Version 1 preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(LiftrBase.Versions.v1_preview)
  @useDependency(LiftrBase.Storage.Versions.v1_preview)
  v1_preview: "2023-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Reservations extends LiftrBase.Storage.Reservations {}

@doc("Storage Pool resource type.")
model StoragePool is TrackedResource<StoragePoolProperties> {
  @doc("Name of the Storage Pool.")
  @segment("storagePools")
  @key("storagePoolName")
  @visibility("read")
  @path
  @minLength(4)
  @maxLength(20)
  name: string;
}

@doc("Properties of a Storage Pool resource.")
model StoragePoolProperties {
  @doc("ID of StoragePool in Pure Storage systems.")
  @visibility("read")
  storagePoolId: string;

  @doc("Azure Availability Zone the Pool is located in.")
  availabilityZone: string;

  @doc("Describes parameters for Virtual Network to deploy to (VNet injection).")
  vnetInjection: VnetInjection;

  @doc("How long a deleted object is kept before eradication (time in seconds).")
  @visibility("read")
  dataRetentionPeriod: int64;

  @doc("if true, VASA support is enabled and the AVS configuration parameters below may be passed to change the current password. if false, VASA support will be disabled (but previous password configuration is not lost).")
  avsEnabled: boolean;

  @doc("Total bandwidth provisioned for the pool (in MB/s).")
  provisionedBandwidthMbPerSec: int64;

  @doc("Presented if avsEnabled is true.")
  avs?: AzureVmwareService;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("Resource id of the reservation resource. The RP should make sure this is a valid resource before allowing StoragePool creation to continue.")
  reservationResourceId: string;
}

@doc("Azure VmWare Service properties. VASA is vSphere Storage APIs for Storage Awareness.")
model AzureVmwareService {
  @doc("Internal VMware id identifying this StoragePool as a storage provider.")
  storageProviderId: string;

  @doc("Resource id pointing at the AVS SDDC the pool is configured with (used by AVS Resource Provider to keep track of attached pools).")
  sddc?: string;

  @doc("Password for VASA service login, disabled if omitted or set to null.")
  @visibility("create", "update")
  @secret
  vasaProviderPassword?: string;
}

@armResourceOperations
interface StoragePools {
  get is ArmResourceRead<StoragePool>;
  create is ArmResourceCreateOrUpdateAsync<StoragePool>;
  update is ArmResourcePatchAsync<StoragePool, StoragePoolProperties>;
  delete is ArmResourceDeleteAsync<StoragePool>;
  listByResourceGroup is ArmResourceListByParent<StoragePool>;
  listBySubscription is ArmListBySubscription<StoragePool>;
}

@doc("The AVS Storage Container resource type.")
@parentResource(StoragePool)
model AvsStorageContainer is ProxyResource<AvsStorageContainerProperties> {
  @doc("The name of the storage container.")
  @segment("avsStorageContainers")
  @key("storageContainerName")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z\\-_]{1,32}$")
  name: string;
}

@doc("The properties of an AVS Storage Container resource.")
model AvsStorageContainerProperties {
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface AvsStorageContainers {
  create is ArmResourceCreateOrUpdateSync<AvsStorageContainer>;
  get is ArmResourceRead<AvsStorageContainer>;
  delete is ArmResourceDeleteAsync<AvsStorageContainer>;
  listByParent is ArmResourceListByParent<AvsStorageContainer>;
}
