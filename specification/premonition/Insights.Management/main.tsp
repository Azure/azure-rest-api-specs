import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./routes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Premonition.Versions)
@service({
  title: "Microsoft Premonition Insights",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Premonition;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Microsoft Premonition Microsoft,Premonition.Insights service version.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_09_01_preview: "2024-09-01-preview",
}
