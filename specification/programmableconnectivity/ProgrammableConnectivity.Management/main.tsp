import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Gateway.tsp";
import "./OperatorApiConnection.tsp";
import "./OperatorApiPlan.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure Programmable Connectivity Provider management API.
 */
@armProviderNamespace
@service({
  title: "ProgrammableConnectivity",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.ProgrammableConnectivity;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2024-01-15-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_01_15_preview: "2024-01-15-preview",
}
