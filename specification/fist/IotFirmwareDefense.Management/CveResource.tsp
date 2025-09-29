import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Firmware.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

@versioned(Versions)
namespace Microsoft.IoTFirmwareDefense;
/**
 * List of CVE results.
 */
@added(Versions.v2025_08_02)
model CveListResult is Azure.Core.Page<CveResource>;

/**
 * The object representing a firmware analysis CVE result resource
 */
@parentResource(Firmware)
@added(Versions.v2025_08_02)
model CveResource is ProxyResource<CveResult> {
  /**
   * The id of the CVE result.
   */
  @path
  @key("cveId")
  @segment("cves")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
@added(Versions.v2025_08_02)
interface Cves {
  /**
   * Lists CVE analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<CveResource>;
}
