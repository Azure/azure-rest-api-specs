import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.Migrate;

@added(ApiVersions.v2026_06_01_preview)
@doc("Response body for the fetchSASUri action.")
model FetchSasUriResponse {
  @doc("Write-targeted short-lived SAS URL pointing into the server-managed CSV staging container. Callers PUT their wave-plan CSV payload to this URL and then pass the same URL verbatim as the sasUri field on importWavePlan.")
  @visibility(Lifecycle.Read)
  sasUri: string;

  @doc("UTC instant after which sasUri ceases to be valid.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
