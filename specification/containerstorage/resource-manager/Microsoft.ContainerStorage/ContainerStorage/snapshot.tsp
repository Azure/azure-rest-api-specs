import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ContainerStorage;

@armResourceOperations
interface Snapshots {
  get is ArmResourceRead<Snapshot>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Snapshot,
    LroHeaders = ArmLroLocationHeader<FinalResult = Snapshot> &
      ArmAsyncOperationHeader<FinalResult = Snapshot> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Snapshot>;
  listByPool is ArmResourceListByParent<Snapshot>;
}

@parentResource(Pool)
model Snapshot is ProxyResource<SnapshotProperties> {
  @doc("Volume Snapshot Resource")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @key("snapshotName")
  @path
  @segment("snapshots")
  name: string;
}

@doc("Volume Snapshot Properties")
model SnapshotProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The status of the resource.")
  @visibility(Lifecycle.Read)
  status?: ResourceOperationalStatus;

  @doc("Reference to the source volume")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  source: string;
}
