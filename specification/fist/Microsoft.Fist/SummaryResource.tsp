import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Firmware.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.IoTFirmwareDefense;
/**
 * The object representing a firmware analysis summary resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Firmware)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SummaryResourceProperties)
model SummaryResource extends ProxyResourceBase {
  /**
   * The Firmware analysis summary name describing the type of summary.
   */
  @path
  @key("summaryName")
  @segment("summaries")
  @visibility("read")
  name: SummaryName;

  /**
   * Properties of an analysis summary.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SummaryResourceProperties;
}

@armResourceOperations
interface SummaryResources {
  /**
   * Get an analysis result summary of a firmware by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Summaries_Get")
  get is ArmResourceRead<SummaryResource>;

  /**
   * Lists analysis result summary names of a firmware. To fetch the full summary data, get that summary by name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Summaries_ListByFirmware")
  listByFirmware is ArmResourceListByParent<SummaryResource>;
}
