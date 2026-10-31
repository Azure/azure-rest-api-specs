import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Versioning;
namespace Playwright;

// Models ////////////////////

@doc("Playwright workspace is the parent resource for most of the other service resources.")
@resource("playwrightworkspaces")
model Workspace {
  @key("workspaceId")
  @doc("The workspace ID in GUID format.")
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("The fully-qualified Azure resource id for the workspace.")
  @visibility(Lifecycle.Read)
  resourceId: string;

  @doc("The workspace name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The state of workspace - Active | Inactive")
  @visibility(Lifecycle.Read)
  state: WorkspaceState;

  @doc("The Azure subscription id in GUID format for the workspace.")
  @visibility(Lifecycle.Read)
  subscriptionId: string;

  @doc("The Azure subscription state - Registered | Unregistered | Warned | Suspended | Deleted")
  @visibility(Lifecycle.Read)
  subscriptionState: SubscriptionState;

  @doc("The Azure tenant id in GUID format for the workspace.")
  @visibility(Lifecycle.Read)
  tenantId: string;

  @doc("The workspace resource location in Azure, for eg. eastus, southeastasia.")
  @visibility(Lifecycle.Read)
  location: string;

  @doc("This property sets the connection region for Playwright client workers to cloud-hosted browsers. If enabled, workers connect to browsers in the closest Azure region, ensuring lower latency. If disabled, workers connect to browsers in the Azure region in which the workspace was initially created.")
  @visibility(Lifecycle.Read)
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("When enabled, this feature allows the workspace to use local auth (through service access token) for executing operations.")
  @visibility(Lifecycle.Read)
  localAuth?: EnablementStatus = EnablementStatus.Disabled;

  @doc("When set on Playwright workspace resource, it provides the URI of the Azure storage account used to store workspace artifacts, test results, and reports.")
  @visibility(Lifecycle.Read)
  storageUri?: url;

  @doc("The Azure Key Vault linked with the playwright workspace.")
  @added(Versions.v2026_11_01_preview)
  @visibility(Lifecycle.Read)
  linkedKeyVault?: LinkedKeyVaultProperties;

  @doc("The browser proxy enablement status for the workspace.")
  @added(Versions.v2026_11_01_preview)
  @visibility(Lifecycle.Read)
  browserProxy?: EnablementStatus = EnablementStatus.Enabled;
}

@doc("The linked Azure Key Vault and managed identity for the playwright workspace.")
@added(Versions.v2026_11_01_preview)
model LinkedKeyVaultProperties {
  @doc("The vault's base HTTPS URI. The vault must belong to the workspace tenant. Secret paths, query strings, fragments, user information, and non-default ports are not allowed.")
  @visibility(Lifecycle.Read)
  vaultUri?: url;

  @doc("The workspace managed identity authorized to read secrets from the linked vault.")
  @visibility(Lifecycle.Read)
  vaultIdentity?: LinkedIdentityProperties;
}

@doc("A workspace managed identity used to access a linked Azure resource.")
@added(Versions.v2026_11_01_preview)
model LinkedIdentityProperties {
  @doc("The type of managed identity used to access the linked resource.")
  @visibility(Lifecycle.Read)
  type?: IdentityType;

  @doc("The fully qualified Azure resource ID of the user-assigned managed identity. Required for UserAssigned and omitted for SystemAssigned.")
  @visibility(Lifecycle.Read)
  resourceId?: string;
}

@doc("The type of managed identity used to access a linked Azure resource.")
@added(Versions.v2026_11_01_preview)
union IdentityType {
  string,

  @doc("The workspace's system-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("A user-assigned managed identity assigned to the workspace.")
  UserAssigned: "UserAssigned",
}

@doc("The Playwright workspace state.")
union WorkspaceState {
  string,

  @doc("The workspace is Active.")
  Active: "Active",

  @doc("The workspace is Inactive.")
  Inactive: "Inactive",
}

@doc("The Azure subscription state.")
union SubscriptionState {
  string,

  @doc("The subscription state is Registered.")
  Registered: "Registered",

  @doc("The subscription state is Warned.")
  Warned: "Warned",

  @doc("The subscription state is Suspended.")
  Suspended: "Suspended",

  @doc("The subscription state is Deleted.")
  Deleted: "Deleted",

  @doc("The subscription state is Unregistered.")
  Unregistered: "Unregistered",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is Enabled.")
  Enabled: "Enabled",

  @doc("The feature is Disabled.")
  Disabled: "Disabled",
}

@doc("The operating system to configure for remote script execution.")
union OS {
  string,

  @doc("Linux operating system.")
  Linux: "Linux",

  @doc("Windows operating system.")
  Windows: "Windows",
}

@doc("The browser type to configure for remote script execution.")
union BrowserType {
  string,

  @doc("Chromium browser type.")
  Chromium: "Chromium",

  @doc("Firefox browser type.")
  Firefox: "Firefox",

  @doc("WebKit browser type.")
  Webkit: "Webkit",
}
