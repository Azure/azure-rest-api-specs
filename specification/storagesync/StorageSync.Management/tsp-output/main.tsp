import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./StorageSyncService.tsp";
import "./StorageSyncPrivateEndpointConnection.tsp";
import "./StorageSyncGroup.tsp";
import "./CloudEndpoint.tsp";
import "./StorageSyncServerEndpoint.tsp";
import "./StorageSyncRegisteredServer.tsp";
import "./StorageSyncWorkflow.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Microsoft Storage Sync",
})
@versioned(Versions)
@doc("Microsoft Storage Sync Service API")
namespace Azure.ResourceManager.StorageSync;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_06_01: "2022-06-01",
}
