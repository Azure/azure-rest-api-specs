import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./BestPractice.tsp";
import "./ConfigurationProfile.tsp";
import "./ConfigurationProfile.tsp";
import "./ConfigurationProfileAssignment.tsp";
import "./ConfigurationProfileAssignment.tsp";
import "./ConfigurationProfileAssignment.tsp";
import "./Report.tsp";
import "./Report.tsp";
import "./Report.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Automanage Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "AutomanageClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.Automanage;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-05-04 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_05_04: "2022-05-04",
}
