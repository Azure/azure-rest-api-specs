import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Playwright.Management;

// Tracked Resource PlaywrightWorkspace Models ////////////////////

@doc("Playwright workspace resource.")
model PlaywrightWorkspace is TrackedResource<PlaywrightWorkspaceProperties> {
  ...ResourceNameParameter<PlaywrightWorkspace>;
  ...ManagedServiceIdentityProperty;
}

@@added(PlaywrightWorkspace.identity, Versions.v2026_02_01_preview);

@doc("Playwright workspace resource properties.")
model PlaywrightWorkspaceProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last resource operation.")
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("The API endpoint for workspace data plane operations.")
  dataplaneUri?: url;

  @doc("Specifies where client workers connect to cloud-hosted browsers. When Enabled, workers connect to browsers in the nearest Azure region to reduce latency. When Disabled, workers connect to browsers in the workspace's Azure region.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("Specifies whether service access tokens can be used to authenticate workspace operations.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;

  @visibility(Lifecycle.Read)
  @doc("The workspace ID in GUID format.")
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  workspaceId?: string;

  @added(Versions.v2026_02_01_preview)
  @doc("Specifies whether test reporting is enabled for the workspace.")
  reporting?: EnablementStatus = EnablementStatus.Disabled;

  @added(Versions.v2026_01_01_preview)
  @doc("The URI of the Azure Storage account used to store workspace artifacts, test results, reports and browser profiles.")
  storageUri?: url;

  @added(Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The Azure Resource Manager resource ID of the subnet used for private network connectivity. Before creating the workspace, ensure the subnet meets the virtual network prerequisites at https://aka.ms/pww/docs/vnet. Format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/virtualNetworks/{virtualNetwork}/subnets/{subnet}. This value cannot be changed after workspace creation.")
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @added(Versions.v2026_10_01_preview)
  @doc("Specifies whether session artifact recording is enabled for the workspace.")
  sessionArtifacts?: EnablementStatus = EnablementStatus.Disabled;

  @added(Versions.v2026_10_01_preview)
  @doc("The managed identity used to manage session artifacts in the storage account.")
  storageIdentity?: ManagedIdentity;

  @added(Versions.v2026_11_01_preview)
  @doc("Specifies whether the browser proxy is enabled for the workspace.")
  browserProxy?: EnablementStatus = EnablementStatus.Enabled;

  @added(Versions.v2026_11_10_preview)
  @doc("Specifies whether the browser profile is enabled for the workspace.")
  browserProfile?: EnablementStatus = EnablementStatus.Enabled;

  @added(Versions.v2026_11_10_preview)
  @doc("The Web Bot Authentication settings for the workspace.")
  webBotAuth?: WebBotAuthSettings;
}

@doc("The status of the last resource operation.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource creation is in progress.")
  Creating: "Creating",

  @doc("Resource deletion is in progress.")
  Deleting: "Deleting",

  @doc("Request has been accepted for processing.")
  Accepted: "Accepted",
}

@doc("The enablement status of a feature.")
union EnablementStatus {
  string,

  @doc("The feature is enabled.")
  Enabled: "Enabled",

  @doc("The feature is disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2026_11_10_preview)
@doc("The Web Bot Authentication settings for a workspace.")
model WebBotAuthSettings {
  @doc("Controls whether Web Bot Authentication is enabled for the workspace.")
  status?: EnablementStatus;

  @doc("The signing key used for Web Bot Authentication. If omitted, the service defaults to Microsoft.")
  signingKey?: WebBotAuthSigningKey = WebBotAuthSigningKey.Microsoft;

  @visibility(Lifecycle.Read)
  @doc("The URI of the public key directory used for HTTP message signature verification. This property is returned only when signingKey is Workspace.")
  publicKeyDirectoryUri?: url;
}

@added(Versions.v2026_11_10_preview)
@doc("The Web Bot Authentication settings that can be updated for a workspace.")
model WebBotAuthSettingsUpdate {
  ...OmitProperties<
    OmitDefaults<PickProperties<WebBotAuthSettings, "status" | "signingKey">>,
    "signingKey"
  >;

  @doc("The signing key used for Web Bot Authentication. If omitted, the existing signing key selection is preserved.")
  signingKey?: WebBotAuthSigningKey;
}

@added(Versions.v2026_11_10_preview)
@doc("The workspace properties that can be updated.")
model PlaywrightWorkspacePatchProperties {
  ...OmitProperties<PlaywrightWorkspaceProperties, "webBotAuth">;

  @doc("The Web Bot Authentication settings for the workspace.")
  webBotAuth?: WebBotAuthSettingsUpdate;
}

@added(Versions.v2026_11_10_preview)
@doc("The signing key used for Web Bot Authentication.")
union WebBotAuthSigningKey {
  string,

  @doc("Use a Microsoft-managed regional signing key common to all workspaces.")
  Microsoft: "Microsoft",

  @doc("Use a workspace-specific signing key.")
  Workspace: "Workspace",
}

@doc("Managed identity properties for accessing Azure resources.")
model ManagedIdentity {
  @doc("The managed identity type: SystemAssigned or UserAssigned.")
  type?: IdentityType;

  @doc("The Azure Resource Manager resource ID of the user-assigned managed identity. Required when type is UserAssigned. Omit when type is SystemAssigned.")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("The type of managed identity used to access Azure resources.")
union IdentityType {
  string,

  @doc("System-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed identity.")
  UserAssigned: "UserAssigned",
}
