import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";
import "./systemdata.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Playwright;

@doc("A reusable browser profile containing saved browser state.")
@added(Versions.v2026_12_01_preview)
@resource("browser-profiles")
model BrowserProfile {
  @doc("The browser profile ID in GUID format.")
  @key("browserProfileId")
  @visibility(Lifecycle.Read)
  id: Azure.Core.uuid;

  @minLength(3)
  @maxLength(24)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$")
  @doc("The name of the browser profile.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  name: string;

  @doc("A description of the purpose of the browser profile.")
  @maxLength(200)
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description?: string;

  @doc("The browser type associated with the browser profile. Defaults to Chromium when omitted on creation. Cannot be changed after creation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  browserType?: BrowserType;

  @doc("The operating system associated with the browser profile. Defaults to Linux when omitted on creation. Cannot be changed after creation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystem?: OS;

  @doc("The UTC date and time when the browser profile state was last saved. Absent until the profile state is first saved.")
  @visibility(Lifecycle.Read)
  lastSavedAt?: utcDateTime;

  @doc("The ID of the browser session that last saved the browser profile state. Absent until the profile state is first saved.")
  @visibility(Lifecycle.Read)
  lastSavedSessionId?: string;

  @doc("The URI for downloading the most recently saved browser profile archive. Absent until the profile state is first saved.")
  @visibility(Lifecycle.Read)
  archiveUri?: url;

  @doc("The SHA-256 hash of the browser profile archive. Absent until the profile state is first saved.")
  @visibility(Lifecycle.Read)
  archiveSha256?: string;

  @doc("The read-only creation and modification metadata.")
  @visibility(Lifecycle.Read)
  systemData: SystemData;
}

@doc("Operations for managing browser profiles at the service endpoint.")
@added(Versions.v2026_12_01_preview)
interface BrowserProfiles {
  @doc("Creates or updates a browser profile with the specified ID. Omitted properties remain unchanged on update.")
  createOrUpdate is Operations.ResourceCreateOrUpdate<BrowserProfile>;

  @doc("Gets the browser profile with the specified ID.")
  get is Operations.ResourceRead<BrowserProfile>;

  @doc("Lists browser profiles. Follow the nextLink URL in the response to retrieve the next page.")
  list is Operations.ResourceList<BrowserProfile>;

  @doc("Deletes the browser profile with the specified ID.")
  delete is Operations.ResourceDelete<BrowserProfile>;
}
