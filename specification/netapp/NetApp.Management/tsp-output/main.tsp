import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./NetAppAccount.tsp";
import "./CapacityPool.tsp";
import "./Volume.tsp";
import "./Snapshot.tsp";
import "./SnapshotPolicy.tsp";
import "./BackupPolicy.tsp";
import "./VolumeQuotaRule.tsp";
import "./VolumeGroupDetails.tsp";
import "./SubvolumeInfo.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "NetAppManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Microsoft NetApp Files Azure Resource Provider specification")
namespace Azure.ResourceManager.NetApp;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_05_01: "2023-05-01",
}
