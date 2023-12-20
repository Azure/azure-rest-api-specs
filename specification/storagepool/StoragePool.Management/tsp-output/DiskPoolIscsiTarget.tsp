import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DiskPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.StoragePool;
@doc("Response for iSCSI Target requests.")
@parentResource(DiskPool)
model DiskPoolIscsiTarget is ProxyResource<IscsiTargetProperties> {
  @doc("The name of the iSCSI Target.")
  @path
  @key("iscsiTargetName")
  @segment("iscsiTargets")
  name: string;

  @doc("List of Azure resource ids that manage this resource.")
  @visibility("read")
  managedByExtended?: string[];

  ...Azure.ResourceManager.ManagedBy;
}

@armResourceOperations
interface DiskPoolIscsiTargets {
  @doc("Get an iSCSI Target.")
  get is ArmResourceRead<DiskPoolIscsiTarget>;
  @doc("Create or Update an iSCSI Target.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DiskPoolIscsiTarget>;
  @doc("Update an iSCSI Target.")
  update is ArmResourcePatchAsync<DiskPoolIscsiTarget, IscsiTargetProperties>;
  @doc("Delete an iSCSI Target.")
  delete is ArmResourceDeleteAsync<DiskPoolIscsiTarget>;
  @doc("Get iSCSI Targets in a Disk pool.")
  listByDiskPool is ArmResourceListByParent<DiskPoolIscsiTarget>;
}
