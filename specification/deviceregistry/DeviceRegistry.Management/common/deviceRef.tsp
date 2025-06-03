import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@doc("Defines which device and endpoint to use for this asset")
@added(Versions.v2025_07_01_preview)
model DeviceRef {
  @doc("Name of the device resource")
  deviceName: string;

  @doc("The name of endpoint to use")
  endpointName: string;
}
