import "@typespec/versioning";
import "../Enums/Enums.tsp";
import "./WavePlanCommon.tsp";

using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@doc("Data model of Download URL for wave recommendation report.")
@added(ApiVersions.v2025_12_01_preview)
model GenerateWavePlanRequest {
  @doc("ARM Id of the assessment for which the wave plan report is to be generated.")
  assessmentArmId?: string;

  @doc("Optional. Specify the migration path for which the wave plan report is to be generated. If not specified, the default will be used")
  migrationPath?: string;
}

@doc("Data model of Download URL for wave recommendation report.")
@added(ApiVersions.v2025_12_01_preview)
model GenerateWavePlanResponse {
  @removed(ApiVersions.v2026_06_01_preview)
  @doc("Hyperlink to download report.")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @removed(ApiVersions.v2026_06_01_preview)
  @doc("Expiry date of download url.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;

  @doc("The deterministic wave-plan resource name matching the persisted row's wavePlanName.")
  @added(ApiVersions.v2026_06_01_preview)
  @visibility(Lifecycle.Read)
  wavePlanName: string;

  @doc("The provisioning state of the persisted wave-plan row.")
  @added(ApiVersions.v2026_06_01_preview)
  @visibility(Lifecycle.Read)
  provisioningState: ProvisioningState;

  @doc("The plan source (SystemGenerated for all generated runs).")
  @added(ApiVersions.v2026_06_01_preview)
  @visibility(Lifecycle.Read)
  planSource: PlanSource;

  @doc("The assessment ARM ID this plan was generated for.")
  @added(ApiVersions.v2026_06_01_preview)
  @visibility(Lifecycle.Read)
  assessmentArmId: string;

  @doc("The canonical migration-path string this plan was generated for.")
  @added(ApiVersions.v2026_06_01_preview)
  @visibility(Lifecycle.Read)
  migrationPath: string;

  @doc("The Artifact Store identity (artifactId, versionId) this run's files are committed under, used to resolve time-bound download access.")
  @added(ApiVersions.v2026_06_01_preview)
  @visibility(Lifecycle.Read)
  artifactProperties: ArtifactProperties;
}
