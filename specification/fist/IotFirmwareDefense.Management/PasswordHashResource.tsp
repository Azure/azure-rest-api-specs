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
 * List of password hash results.
 */
model PasswordHashListResult is Azure.Core.Page<PasswordHashResource>;

/**
 * The object representing a firmware analysis password hash result resource
 */
@parentResource(Firmware)
model PasswordHashResource is ProxyResource<PasswordHash> {
  /**
   * The id of the password hash result.
   */
  @path
  @key("passwordHashId")
  @segment("passwordHashes")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
interface PasswordHashes {
  /**
   * Lists password hash analysis results of a firmware.
   */
  listByFirmware is ArmResourceListByParent<PasswordHashResource>;
}
