import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Machine.tsp";
import "./MachineExtension.tsp";
import "./ExtensionValue.tsp";
import "./MachineRunCommand.tsp";
import "./HybridComputePrivateLinkScope.tsp";
import "./PrivateLinkResource.tsp";
import "./PrivateEndpointConnection.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "HybridComputeManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("The Hybrid Compute Management Client.")
namespace Microsoft.HybridCompute;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-10-03-preview API version.")
  v2023_10_03_preview: "2023-10-03-preview",
}
