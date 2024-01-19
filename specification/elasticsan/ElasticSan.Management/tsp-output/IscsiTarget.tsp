import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DiskPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StoragePool;
@doc("Response for iSCSI Target requests.")
@parentResource(DiskPool)
model IscsiTarget is ProxyResource<IscsiTargetProperties> {
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
interface IscsiTargets {
  @doc("Get an iSCSI Target.")
  get is ArmResourceRead<IscsiTarget>;

  @doc("Create or Update an iSCSI Target.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    IscsiTarget,
    BaseParameters<IscsiTarget>,
    ArmAsyncOperationHeader
  >;

  @doc("Update an iSCSI Target.")
  update is ArmCustomPatchAsync<
    IscsiTarget,
    IscsiTargetUpdate,
    BaseParameters<IscsiTarget>,
    ArmAsyncOperationHeader
  >;

  @doc("Delete an iSCSI Target.")
  delete is ArmResourceDeleteAsync<
    IscsiTarget,
    BaseParameters<IscsiTarget>,
    ArmAsyncOperationHeader
  >;

  @doc("Get iSCSI Targets in a Disk pool.")
  listByDiskPool is ArmResourceListByParent<IscsiTarget>;
}

@@projectedName(IscsiTargets.createOrUpdate::parameters.resource,
  "json",
  "iscsiTargetCreatePayload"
);
@@extension(IscsiTargets.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "iscsiTargetCreatePayload"
);
@@doc(IscsiTargets.createOrUpdate::parameters.resource,
  "Request payload for iSCSI Target create operation."
);
@@projectedName(IscsiTargets.update::parameters.properties,
  "json",
  "iscsiTargetUpdatePayload"
);
@@extension(IscsiTargets.update::parameters.properties,
  "x-ms-client-name",
  "iscsiTargetUpdatePayload"
);
@@doc(IscsiTargets.update::parameters.properties,
  "Request payload for iSCSI Target update operation."
);
