import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;

namespace Microsoft.HealthcareInterop;

@added(Versions.v2025_06_01_preview)
@doc("The Listener Configuration to be used for dicom connector configuration.")
model DicomListenerConfiguration {
  @doc("The port number that will be exposed to receive DICOM images.")
  @minValue(1)
  @maxValue(65535)
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  port: int32;
}
