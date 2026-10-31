import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Playwright;

@doc("Read-only metadata identifying who created and last modified a resource, and when.")
@added(Versions.v2026_11_01_preview)
model SystemData {
  @doc("The resource creation timestamp in UTC. Preserved on replacement and update.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The Microsoft Entra caller's ID at creation. Preserved on replacement and update.")
  @visibility(Lifecycle.Read)
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  createdBy: string;

  @doc("The resource's last modification timestamp in UTC, including its initial creation.")
  @visibility(Lifecycle.Read)
  lastModifiedAt: utcDateTime;

  @doc("The Microsoft Entra caller's ID for the last modification, including initial creation.")
  @visibility(Lifecycle.Read)
  @minLength(3)
  @maxLength(36)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  lastModifiedBy: string;
}
