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
@removed(Versions.v2025_08_02)
@renamedFrom(Versions.v2025_08_02, "CveListResult")
model LegacyCveListResult is Azure.Core.Page<LegacyCveResource>;

/**
 * The object representing a firmware analysis CVE result resource
 */
@removed(Versions.v2025_08_02)
@renamedFrom(Versions.v2025_08_02, "CveResource")
@parentResource(Firmware)
model LegacyCveResource is ProxyResource<CveResult> {
  /**
   * The id of the CVE result.
   */
  @path
  @key("cveId")
  @segment("commonVulnerabilitiesAndExposures")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
@removed(Versions.v2025_08_02)
@renamedFrom(Versions.v2025_08_02, "Cves")
interface LegacyCves {
  /**
   * Lists CVE analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<LegacyCveResource>;
}
