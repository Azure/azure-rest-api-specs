import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../Common/Enums/Enums.tsp";

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

@doc("Summarizes the rows and waves represented by a completed wave-plan validation.")
@added(ApiVersions.v2026_09_01_preview)
model ValidationSummary {
  @doc("The total number of rows processed. Always equal to validRowCount plus invalidRowCount.")
  @visibility(Lifecycle.Read)
  validatedRowCount: int32;

  @doc("The number of rows without validation errors.")
  @visibility(Lifecycle.Read)
  validRowCount: int32;

  @doc("The number of rows with one or more validation errors. A single row can produce multiple issues, so this is independent of the length of issues.")
  @visibility(Lifecycle.Read)
  invalidRowCount: int32;

  @doc("The number of distinct valid waves represented by the validated rows.")
  @visibility(Lifecycle.Read)
  numberOfWaves: int32;
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

  @doc("The terminal validation counts.")
  @visibility(Lifecycle.Read)
  validationSummary: ValidationSummary;

  @doc("The validation findings. Always present; empty when the staged wave plan has no findings. Findings do not fail the operation.")
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  issues: Azure.ResourceManager.CommonTypes.ErrorDetail[];
}
