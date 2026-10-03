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
@doc("Request body for the validateWavePlan action.")
@added(ApiVersions.v2026_09_01_preview)
model ValidateWavePlanRequest {
  @doc("The assessment ARM ID identifying the staged wave plan.")
  assessmentArmId: string;

  @doc("The migration path identifying the staged wave plan.")
  migrationPath: string;

  @doc("The SAS version ID used to locate the uploaded CSV. Must match the value passed to fetchSASUri when the CSV was staged.")
  sasVersionId: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Response payload for the validateWavePlan action.")
@added(ApiVersions.v2026_09_01_preview)
model ValidateWavePlanResponse {
  @doc("The assessment ARM ID that was validated.")
  @visibility(Lifecycle.Read)
  assessmentArmId?: string;

  @doc("The migration path that was validated.")
  @visibility(Lifecycle.Read)
  migrationPath?: string;

  @doc("The wave-plan name resolved during validation.")
  @visibility(Lifecycle.Read)
  wavePlanName?: string;

  @doc("The provisioning state of the validated wave-plan row.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The terminal validation status.")
  @visibility(Lifecycle.Read)
  status: ValidationStatus;

  @doc("Download access to the error CSV describing the validation findings. Present only when findings were produced.")
  @visibility(Lifecycle.Read)
  validationErrorFile?: ValidationErrorFile;
}
