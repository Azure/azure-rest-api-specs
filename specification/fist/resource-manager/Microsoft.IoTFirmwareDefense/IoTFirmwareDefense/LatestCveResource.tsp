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
 * Details of a CVE rescan result, including how it changed relative to the prior CVE analysis.
 */
@added(Versions.v2026_10_01_preview)
model LatestCveResult {
  ...CveResult;

  /**
   * Describes how this CVE changed relative to the prior CVE analysis.
   */
  changeStatus?: ChangeStatus;

  /**
   * The fields that changed relative to the prior CVE analysis.
   */
  @Azure.ResourceManager.identifiers(#["fieldName"])
  modifications?: CveModification[];
}

/**
 * List of CVE rescan results.
 */
@added(Versions.v2026_10_01_preview)
model LatestCveListResult is Azure.Core.Page<LatestCveResource>;

/**
 * The object representing a firmware analysis CVE rescan result resource.
 */
@parentResource(Firmware)
@added(Versions.v2026_10_01_preview)
model LatestCveResource is ProxyResource<LatestCveResult> {
  /**
   * The id of the CVE rescan result.
   */
  @path
  @key("cveId")
  @segment("latestCves")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
@added(Versions.v2026_10_01_preview)
interface LatestCves {
  /**
   * Lists the latest CVE analysis results of a firmware, including how each CVE changed relative to the prior CVE analysis.
   */
  listByFirmware is ArmResourceListByParent<LatestCveResource>;
}
