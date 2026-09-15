import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "./models.tsp";
import "./operations.tsp";

using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Workload Manager" })
@versioned(Versions)
namespace Microsoft.Compute.WorkloadManager;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2026-11-01-preview`,
}
