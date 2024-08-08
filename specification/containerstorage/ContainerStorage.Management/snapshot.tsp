import "@typespec/rest";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ContainerStorage;

@armResourceOperations
interface Snapshots {
  get is ArmResourceRead<Snapshot>;
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Snapshot>;
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
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The status of the resource.")
  @visibility("read")
  status?: ResourceOperationalStatus;

  @doc("Reference to the source volume")
  @minLength(3)
  @maxLength(253)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @visibility("read", "create")
  source: string;
}
