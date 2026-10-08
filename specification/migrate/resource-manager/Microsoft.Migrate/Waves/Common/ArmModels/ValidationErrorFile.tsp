import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Migrate;

@doc("Time-bound download access to the error CSV describing validation findings.")
@added(ApiVersions.v2026_09_01_preview)
model ValidationErrorFile {
  @doc("The read-only SAS URI of the error CSV describing the validation findings.")
  @secret
  @visibility(Lifecycle.Read)
  sasUri: string;

  @doc("The UTC expiration timestamp of the error CSV SAS URI.")
  @visibility(Lifecycle.Read)
  expirationTime: utcDateTime;
}
