import "@typespec/versioning";
using TypeSpec.Versioning;

namespace Microsoft.Migrate;

#suppress "@azure-tools/typespec-client-generator-core/csharp-no-request-suffix" "Name kept for backward compatibility"
@doc("Data model of Download URL for wave recommendation report.")
@added(ApiVersions.v2025_12_01_preview)
model GenerateWavePlanRequest {
  @doc("ARM Id of the assessment for which the wave plan report is to be generated.")
  assessmentArmId?: string;

  @doc("Optional. Specify the migration path for which the wave plan report is to be generated. If not specified, the default will be used")
  migrationPath?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-no-response-suffix" "Name kept for backward compatibility"
@doc("Data model of Download URL for wave recommendation report.")
@added(ApiVersions.v2025_12_01_preview)
model GenerateWavePlanResponse {
  @doc("Hyperlink to download report.")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @doc("Expiry date of download url.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
