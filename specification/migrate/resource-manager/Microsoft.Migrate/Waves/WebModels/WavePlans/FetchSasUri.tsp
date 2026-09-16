import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("The CSV upload workflow a fetchSASUri request is minting a SAS URI for.")
@added(ApiVersions.v2026_09_01_preview)
union UploadType {
  @doc("Upload a wave-plan CSV. Requires assessmentArmId and migrationPath.")
  WavePlan: "WavePlan",

  @doc("Upload a workload configuration CSV. Requires waveArmId.")
  WorkloadConfiguration: "WorkloadConfiguration",

  string,
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Request body for the fetchSASUri action.")
@added(ApiVersions.v2026_06_01_preview)
model FetchSasUriRequest {
  @doc("The upload workflow the SAS URI is minted for. Defaults to WavePlan when omitted. WavePlan requires assessmentArmId and migrationPath; WorkloadConfiguration requires waveArmId.")
  @added(ApiVersions.v2026_09_01_preview)
  uploadType?: UploadType = UploadType.WavePlan;

  @doc("The assessment ARM ID identifying the wave plan to amend.")
  @madeOptional(ApiVersions.v2026_09_01_preview)
  assessmentArmId?: string;

  @doc("The migration path identifying the wave plan to amend.")
  @madeOptional(ApiVersions.v2026_09_01_preview)
  migrationPath?: string;

  @doc("The ARM ID of the wave whose workload configuration is being uploaded. Required when uploadType is WorkloadConfiguration.")
  @added(ApiVersions.v2026_09_01_preview)
  waveArmId?: string;

  @doc("An optional caller-supplied SAS version ID folded into the deterministic staging blob name so concurrent upload sessions stage to distinct blobs.")
  sasVersionId?: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name consistent with existing wave plan action models in this API"
@doc("Response payload for the fetchSASUri action.")
@added(ApiVersions.v2026_06_01_preview)
model FetchSasUriResponse {
  @doc("The write-targeted SAS URI to which the caller should PUT the CSV payload.")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @doc("The UTC expiration timestamp of the returned SAS URI.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
