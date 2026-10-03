using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.DigitalAssets;

@doc("A deployable partition of a ZkpRollup.")
@parentResource(ZkpRollup)
model Partition is TrackedResource<PartitionProperties> {
  @doc("The name of the partition.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("partitionName")
  @segment("partitions")
  @path
  name: string;
}

@doc("Properties of a ZkpRollup partition. The partition properties are not patchable at this point in the Private Preview.")
model PartitionProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(Partition)
interface Partitions {
  get is ArmResourceRead<Partition>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Partition>;
  update is ArmCustomPatchSync<Partition>;
  delete is ArmResourceDeleteWithoutOkAsync<Partition>;
  listByParent is ArmResourceListByParent<Partition>;
}
