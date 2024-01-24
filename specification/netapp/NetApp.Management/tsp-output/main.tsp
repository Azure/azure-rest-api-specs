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
/**
 * Microsoft NetApp Files Azure Resource Provider specification
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "NetAppManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.NetApp;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-05-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_05_01: "2023-05-01",
}
