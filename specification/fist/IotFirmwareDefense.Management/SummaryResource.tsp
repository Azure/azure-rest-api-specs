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
 * The object representing a firmware analysis summary resource.
 */
@parentResource(Firmware)
model SummaryResource is ProxyResource<SummaryResourceProperties> {
  /**
   * The Firmware analysis summary name describing the type of summary.
   */
  @path
  @key("summaryType")
  @segment("summaries")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: SummaryType;
}

@armResourceOperations
interface Summaries {
  /**
   * Get an analysis result summary of a firmware by name.
   */
  get is ArmResourceRead<SummaryResource>;

  /**
   * Lists analysis result summary names of a firmware. To fetch the full summary data, get that summary by name.
   */
  listByFirmware is ArmResourceListByParent<SummaryResource>;
}
