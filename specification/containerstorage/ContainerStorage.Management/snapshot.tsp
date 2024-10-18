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
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DOT NOT COPY - migrate to LRO apis"
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Snapshot,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
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
