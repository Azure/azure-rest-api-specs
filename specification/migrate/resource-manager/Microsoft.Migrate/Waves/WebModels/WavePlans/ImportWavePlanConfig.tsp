import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../../Common/Enums/Enums.tsp";
import "./WavePlanCommon.tsp";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Request body for the importWavePlanConfig action.")
@added(ApiVersions.v2026_09_01_preview)
model ImportWavePlanConfigRequest {
  @doc("The assessment ARM ID identifying the wave plan to refresh.")
  assessmentArmId: string;

  @doc("The migration path identifying the wave plan to refresh.")
  migrationPath: string;

  @doc("The storage-account SAS URI locating the staged wave-plan configuration document.")
  sasUri: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Response payload for the importWavePlanConfig action.")
@added(ApiVersions.v2026_09_01_preview)
model ImportWavePlanConfigResponse {
  @doc("The refreshed wave-plan name.")
  @visibility(Lifecycle.Read)
  wavePlanName: string;

  @doc("The provisioning state of the refreshed wave-plan row.")
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @doc("The assessment ARM ID for the refreshed wave plan.")
  @visibility(Lifecycle.Read)
  assessmentArmId: string;

  @doc("The migration path for the refreshed wave plan.")
  @visibility(Lifecycle.Read)
  migrationPath: string;

  @doc("The Artifact Store identity (artifactId, versionId) the refreshed files are committed under, used to resolve time-bound download access.")
  @visibility(Lifecycle.Read)
  artifactProperties: ArtifactProperties;

  @doc("The refreshed plan-level summary (number of waves, risk, confidence).")
  @visibility(Lifecycle.Read)
  summary: WavePlanSummary;
}
