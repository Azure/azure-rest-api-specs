import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DatadogMonitorResource.tsp";
import "./MonitoringTagRules.tsp";
import "./DatadogSingleSignOnResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * // FIXME: (missing-service-description) Add service description
 */
@armProviderNamespace
@service({
  title: "Microsoft Datadog Client",
})
@versioned(Versions)
// FIXME: Common type version v1 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v1)
namespace Microsoft.Datadog;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2021-03-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_03_01: "2021-03-01",
}
