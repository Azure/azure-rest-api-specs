import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./DiskPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.StoragePool;
@doc("Response for iSCSI Target requests.")
@parentResource(DiskPool)
model IscsiTarget is ProxyResource<IscsiTargetProperties> {
  @doc("The name of the iSCSI Target.")
  @key("iscsiTargetName")
  @segment("iscsiTargets")
  name: string;

  @doc("List of Azure resource ids that manage this resource.")
  @visibility("read")
  managedByExtended?: string[];

  ...Azure.ResourceManager.ManagedBy;
}

@armResourceOperations
interface IscsiTargets {
  @doc("Get an iSCSI Target.")
  get is ArmResourceRead<IscsiTarget>;

  @doc("Create or Update an iSCSI Target.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IscsiTarget>;

  @doc("Update an iSCSI Target.")
  update is ArmCustomPatchAsync<IscsiTarget, IscsiTargetUpdate>;

  @doc("Delete an iSCSI Target.")
  delete is ArmResourceDeleteAsync<IscsiTarget>;

  @doc("Get iSCSI Targets in a Disk pool.")
  listByDiskPool is ArmResourceListByParent<IscsiTarget>;
}
