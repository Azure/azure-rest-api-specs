import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./StorageAccount.tsp";
import "./DeletedAccount.tsp";
import "./StorageAccountManagementPolicy.tsp";
import "./BlobInventoryPolicy.tsp";
import "./StoragePrivateEndpointConnection.tsp";
import "./ObjectReplicationPolicy.tsp";
import "./StorageAccountLocalUser.tsp";
import "./EncryptionScope.tsp";
import "./BlobService.tsp";
import "./BlobContainer.tsp";
import "./ImmutabilityPolicy.tsp";
import "./FileService.tsp";
import "./FileShare.tsp";
import "./QueueService.tsp";
import "./StorageQueue.tsp";
import "./TableService.tsp";
import "./Table.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "StorageManagementClient",
})
@versioned(Versions)
@doc("The Azure Storage Management API.")
namespace Azure.ResourceManager.Storage;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_09_01: "2022-09-01",
}
