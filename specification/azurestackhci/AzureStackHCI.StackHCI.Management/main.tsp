import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./edgeDeviceJobs.tsp";
import "./clusterJobs.tsp";
import "./cluster.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
#suppress "@azure-tools/typespec-azure-core/casing-style" "HCI itself is a short form."
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@doc("Azure Stack HCI service")
@armProviderNamespace
@service({
  title: "Microsoft.AzureStackHCI",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AzureStackHCI;

@doc("The available API versions.")
enum Versions {
  /**
   * The 2024-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_07_01_preview: "2024-07-01-preview",
}
