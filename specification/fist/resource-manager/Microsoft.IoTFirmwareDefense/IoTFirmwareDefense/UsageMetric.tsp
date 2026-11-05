import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Firmware.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.IoTFirmwareDefense;
/**
 * The object representing how many firmwares the user has uploaded to the workspace.
 */
@parentResource(Workspace)
model UsageMetric is ProxyResource<UsageMetricProperties> {
  /**
   * The Firmware analysis summary name describing the type of summary.
   */
  @path
  @key("name")
  @segment("usageMetrics")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
interface UsageMetrics {
  @doc("Gets monthly usage information for a workspace.")
  get is ArmResourceRead<UsageMetric>;

  @doc("Lists monthly usage information for a workspace.")
  listByWorkspace is ArmResourceListByParent<UsageMetric>;
}
