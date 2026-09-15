import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "./models.tsp";
import "./operations.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Already exists outside this subservice"
@armProviderNamespace("Microsoft.Compute")
@service(#{ title: "Workload Manager resource management API" })
@versioned(Versions)
namespace Microsoft.Compute.WorkloadManager;

/** The available API versions. */
enum Versions {
  /** The 2026-11-01-preview API version. */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @previewVersion
  v2026_11_01_preview: "2026-11-01-preview",
}
