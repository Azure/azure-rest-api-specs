import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Request body for the fetchSASUri action.")
@added(ApiVersions.v2026_06_01_preview)
model FetchSasUriRequest {
  @doc("The assessment ARM ID identifying the wave plan to amend.")
  assessmentArmId: string;

  @doc("The migration path identifying the wave plan to amend.")
  migrationPath: string;

  @doc("An optional caller-supplied SAS version ID folded into the deterministic staging blob name so concurrent upload sessions stage to distinct blobs.")
  sasVersionId?: string;
}

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
