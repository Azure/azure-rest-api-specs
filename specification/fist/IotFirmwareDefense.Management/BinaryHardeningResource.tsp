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
 * List of binary hardening results.
 */
model BinaryHardeningListResult is Azure.Core.Page<BinaryHardeningResource>;

/**
 * The object representing a firmware analysis binary hardening result resource
 */
@parentResource(Firmware)
model BinaryHardeningResource is ProxyResource<BinaryHardeningResult> {
  /**
   * The id of the binary hardening result.
   */
  @path
  @key("binaryHardeningId")
  @segment("binaryHardeningResults")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
interface BinaryHardening {
  /**
   * Lists binary hardening analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<BinaryHardeningResource>;
}
