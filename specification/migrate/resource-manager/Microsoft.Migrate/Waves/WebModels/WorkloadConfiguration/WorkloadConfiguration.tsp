import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../Common/Enums/Enums.tsp";
import "../../Common/ArmModels/ValidationErrorFile.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Response payload for the exportWorkloadConfiguration action.")
@added(ApiVersions.v2026_09_01_preview)
model ExportWorkloadConfigurationResponse {
  @doc("The read-only SAS URI from which the exported workload configuration CSV can be downloaded.")
  @secret
  @visibility(Lifecycle.Read)
  downloadSasUri: string;

  @doc("The UTC expiration timestamp of the returned download SAS URI.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Response payload for the validateWorkloadConfiguration action.")
@added(ApiVersions.v2026_09_01_preview)
model ValidateWorkloadConfigurationResponse {
  @doc("The terminal validation status.")
  @visibility(Lifecycle.Read)
  status: ValidationStatus;

  @doc("Download access to the error CSV describing the validation findings. Present only when findings were produced.")
  @visibility(Lifecycle.Read)
  validationErrorFile?: ValidationErrorFile;
}
