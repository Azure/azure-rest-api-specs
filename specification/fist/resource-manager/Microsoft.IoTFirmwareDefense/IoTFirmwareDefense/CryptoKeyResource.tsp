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
 * List of crypto keys.
 */
model CryptoKeyListResult is Azure.Core.Page<CryptoKeyResource>;

/**
 * The object representing a firmware analysis crypto key resource
 */
@parentResource(Firmware)
model CryptoKeyResource is ProxyResource<CryptoKey> {
  /**
   * The id of the crypto key result.
   */
  @path
  @key("cryptoKeyId")
  @segment("cryptoKeys")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
interface CryptoKeys {
  /**
   * Lists crypto key analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<CryptoKeyResource>;
}
