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
 * List of unsafe function call results.
 */
@added(Versions.v2026_06_01_preview)
model UnsafeFunctionCallsListResult
  is Azure.Core.Page<UnsafeFunctionCallsResource>;

/**
 * The object representing a firmware analysis unsafe function calls result resource.
 */
@parentResource(Firmware)
@added(Versions.v2026_06_01_preview)
model UnsafeFunctionCallsResource is ProxyResource<UnsafeFunctionCallsResult> {
  /**
   * The id of the unsafe function calls result.
   */
  @path
  @key("unsafeFunctionCallsId")
  @segment("unsafeFunctionCalls")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
@added(Versions.v2026_06_01_preview)
interface UnsafeFunctionCalls {
  /**
   * Lists unsafe function call analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<UnsafeFunctionCallsResource>;
}
