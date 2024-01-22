import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./HealthMonitor.tsp";
import "./HealthMonitorStateChange.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Workload Monitor API
 */
@armProviderNamespace
@service({
  title: "Workload Monitor API",
})
@versioned(Versions)
namespace Microsoft.WorkloadMonitor;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2020-01-13-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_01_13_preview: "2020-01-13-preview",
}
