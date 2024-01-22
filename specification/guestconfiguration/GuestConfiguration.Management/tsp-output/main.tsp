import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./GuestConfigurationAssignment.tsp";
import "./GuestConfigurationAssignment.tsp";
import "./GuestConfigurationAssignment.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Guest Configuration Client
 */
@armProviderNamespace
@service({
  title: "GuestConfigurationClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.GuestConfiguration;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-01-25 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_01_25: "2022-01-25",
}
