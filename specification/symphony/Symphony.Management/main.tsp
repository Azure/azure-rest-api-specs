import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./solutions.tsp";
import "./targets.tsp";
import "./instances.tsp";
import "./campaigns.tsp";
import "./activations.tsp";
import "./catalogs.tsp";
import "./solutionVersions.tsp";
import "./targetVersions.tsp";
import "./instanceVersions.tsp";
import "./catalogVersions.tsp";
import "./campaignVersions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Azure Symphony",
})
@versioned(Versions)
@doc("Azure Symphony Resource Provider.")
@Azure.ResourceManager.armCommonTypesVersion("v5")
namespace Microsoft.Symphony;

@doc("Versions info.")
enum Versions {
  /** 2024-04-01-preview preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-04-01-preview`,
}