import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@added(Versions.v2026_02_01_preview)
@doc("The snapshot resource definition.")
@extension("x-ms-azure-resource", true)
model Snapshot is TrackedResource<SnapshotProperties> {
  @doc("Name of the snapshot")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @path
  @key("snapshotName")
  @segment("snapshots")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The extendedLocation of the resource.")
  extendedLocation?: ExtendedLocation;
}

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface Snapshots {
  @doc("Gets a snapshot")
  get is ArmResourceRead<Snapshot>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("The operation to create or update a snapshot. Please note some properties can be set only during snapshot creation.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Snapshot,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("The operation to update a snapshot.")
  @patch(#{ implicitOptionality: false })
  @sharedRoute
  update is ArmTagsPatchAsync<Snapshot>;

  @doc("The operation to delete a snapshot.")
  delete is ArmResourceDeleteWithoutOkAsync<Snapshot>;

  @doc("Lists all of the snapshots in the specified resource group. Use the nextLink property in the response to get the next page of snapshots.")
  listByResourceGroup is ArmResourceListByParent<Snapshot>;

  @doc("Lists all of the snapshots in the specified subscription. Use the nextLink property in the response to get the next page of snapshots.")
  listAll is ArmListBySubscription<Snapshot>;
}
