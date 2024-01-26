import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Controller.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Dev Spaces Client
 */
@armProviderNamespace
@service({
  title: "DevSpacesManagementClient",
})
@versioned(Versions)
namespace Microsoft.DevSpaces;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2019-04-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_04_01: "2019-04-01",
}
