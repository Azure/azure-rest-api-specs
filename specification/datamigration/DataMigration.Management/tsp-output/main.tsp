import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DatabaseMigrationSqlDb.tsp";
import "./DatabaseMigrationSqlMi.tsp";
import "./DatabaseMigrationSqlVm.tsp";
import "./SqlMigrationService.tsp";
import "./DataMigrationService.tsp";
import "./ProjectTask.tsp";
import "./ProjectTask.tsp";
import "./Project.tsp";
import "./ProjectFile.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Data Migration Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "DataMigrationManagementClient",
})
@versioned(Versions)
namespace Microsoft.DataMigration;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-03-30-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_03_30_preview: "2022-03-30-preview",
}
