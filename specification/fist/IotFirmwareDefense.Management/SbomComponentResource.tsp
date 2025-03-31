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
 * List of SBOM component results.
 */
model SbomComponentListResult is Azure.Core.Page<SbomComponentResource>;

/**
 * The object representing a firmware analysis SBOM component result resource
 */
@parentResource(Firmware)
model SbomComponentResource is ProxyResource<SbomComponent> {
  /**
   * The id of the SBOM component result.
   */
  @path
  @key("componentId")
  @segment("sbomComponents")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
interface SbomComponents {
  /**
   * Lists sbom analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<SbomComponentResource>;
}
