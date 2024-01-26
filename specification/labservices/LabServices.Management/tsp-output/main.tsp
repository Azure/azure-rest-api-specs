import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Image.tsp";
import "./LabPlan.tsp";
import "./Lab.tsp";
import "./Schedule.tsp";
import "./User.tsp";
import "./VirtualMachine.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * REST API for managing Azure Lab Services images.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "LabServicesClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.LabServices;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-08-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_08_01: "2022-08-01",
}
