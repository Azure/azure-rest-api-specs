import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./goal.tsp";
import "./recoveryPlans.tsp";
import "./drill.tsp";
import "./drillResource.tsp";
import "./drillRun.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
@versioned(Microsoft.AzureResilienceManagement.Versions)
namespace Microsoft.AzureResilienceManagement;

@doc("Microsoft.AzureResilienceManagement Resource Provider supported API versions.")
enum Versions {
  @doc("Microsoft.AzureResilienceManagement Resource Provider management API version 2025-02-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_02_01_preview: "2025-02-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
