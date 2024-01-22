import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./StorageMover.tsp";
import "./Agent.tsp";
import "./Endpoint.tsp";
import "./Project.tsp";
import "./JobDefinition.tsp";
import "./JobRun.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * The Azure Storage Mover REST API.
 */
@armProviderNamespace
@service({
  title: "StorageMoverClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.StorageMover;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-10-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_10_01: "2023-10-01",
}
