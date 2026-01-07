import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./routes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Premonition.Versions)
@service(#{ title: "Microsoft Premonition Insights" })
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Premonition;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Microsoft Premonition Microsoft,Premonition.Insights service version.")
enum Versions {
  v2024_09_01_preview: "2024-09-01-preview",
  v2025_04_01_preview: "2025-04-01-preview",
  v2025_05_01_preview: "2025-05-01-preview",
  v2025_06_01_preview: "2025-06-01-preview",
}
