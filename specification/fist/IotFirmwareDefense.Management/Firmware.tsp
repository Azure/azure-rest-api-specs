import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.IoTFirmwareDefense;
/**
 * Firmware definition
 */
@parentResource(Workspace)
model Firmware is ProxyResource<FirmwareProperties> {
  /**
   * The id of the firmware.
   */
  @path
  @key("firmwareId")
  @segment("firmwares")
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  name: string;
}

@armResourceOperations
interface Firmwares {
  /**
   * Get firmware.
   */
  get is ArmResourceRead<Firmware>;

  /**
   * The operation to create a firmware.
   */
  create is ArmResourceCreateOrReplaceSync<Firmware>;

  /**
   * The operation to update firmware.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Firmware, FirmwareUpdateDefinition>;

  /**
   * The operation to delete a firmware.
   */
  delete is ArmResourceDeleteSync<Firmware>;

  /**
   * Lists all of firmwares inside a workspace.
   */
  listByWorkspace is ArmResourceListByParent<Firmware>;
}

@@doc(Firmwares.create::parameters.resource,
  "Details of the firmware being created or updated."
);
@@doc(Firmwares.update::parameters.properties,
  "Details of the firmware being created or updated."
);
