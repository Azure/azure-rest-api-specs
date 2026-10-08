import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./WavePlanCommon.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Request body for the refreshWavePlanStatus action.")
@added(ApiVersions.v2026_09_01_preview)
model RefreshWavePlanStatusRequest {
  @doc("The assessment ARM ID identifying the wave plan whose status is refreshed.")
  assessmentArmId: string;

  @doc("The migration path identifying the wave plan whose status is refreshed.")
  migrationPath: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Response payload for the refreshWavePlanStatus action.")
@added(ApiVersions.v2026_09_01_preview)
model RefreshWavePlanStatusResponse {
  @doc("The wave-plan name whose status was refreshed.")
  @visibility(Lifecycle.Read)
  wavePlanName: string;

  @doc("The assessment ARM ID the plan belongs to.")
  @visibility(Lifecycle.Read)
  assessmentArmId: string;

  @doc("The migration path the plan was generated for.")
  @visibility(Lifecycle.Read)
  migrationPath: string;

  ...WavePlanOutdatedStatus;
}
