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

@doc("Read-only status properties of a ZkpRollup partition. In Public Preview, shared service configuration comes from the parent rollup. The partition name and location select the deployment, so no writable service-specific properties are needed. PATCH updates tags only.")
model PartitionProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Operational status of the partition.")
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(Partition)
interface Partitions {
  get is ArmResourceRead<Partition>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Partition>;
  update is ArmCustomPatchSync<Partition>;
  delete is ArmResourceDeleteWithoutOkAsync<Partition>;
  listByParent is ArmResourceListByParent<Partition>;
}
