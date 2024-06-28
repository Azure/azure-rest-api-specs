import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./resources/DynamicConfigurations.tsp";
import "./resources/CapabilityLists.tsp";
import "./resources/DeploymentInstances.tsp";
import "./resources/DeploymentTargets.tsp";
import "./resources/TargetBindings.tsp";
import "./resources/UseCases.tsp";
import "./resources/Versions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Edge Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "HCI itself is a short form."
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"

@armProviderNamespace
@service({
  title: "Microsoft.Edge - Config Manager",
})
@versioned(Versions)
namespace Microsoft.Edge;

/** The available API versions. */
enum Versions {
  /** 2021-10-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}
