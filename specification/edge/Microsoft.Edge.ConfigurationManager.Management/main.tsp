import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./CapabilityList.tsp";
import "./DeploymentTarget.tsp";
import "./Schema.tsp";
import "./SchemaVersion.tsp";
import "./SchemaReference.tsp";
import "./Solution.tsp";
import "./SolutionBinding.tsp";
import "./SolutionBindingConfiguration.tsp";
import "./SolutionInstance.tsp";
import "./SolutionVersion.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Edge Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@service({
  title: "Microsoft.Edge",
})
@versioned(Versions)
namespace Microsoft.Edge;

/** The available API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}
