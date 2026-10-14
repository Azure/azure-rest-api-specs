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
  @doc("The workspace data plane service API URI.")
  dataplaneUri?: url;

  @doc("Controls the connection region for client workers to cloud-hosted browsers. When enabled, workers connect to browsers in the closest Azure region for lower latency. When disabled, workers connect to browsers in the Azure region where the workspace was created.")
  regionalAffinity?: EnablementStatus = EnablementStatus.Enabled;

  @doc("Enables the workspace to use local authentication through service access tokens for operations.")
  localAuth?: EnablementStatus = EnablementStatus.Disabled;

  @visibility(Lifecycle.Read)
  @doc("The workspace ID in GUID format.")
  @maxLength(36)
  @minLength(3)
  @pattern("[A-Za-z0-9]+(-[A-Za-z0-9]+)+")
  workspaceId?: string;

  @added(Versions.v2026_02_01_preview)
  @doc("Indicates whether reporting is enabled for the workspace. When set to true, reports will be generated and available for the workspace.")
  reporting?: EnablementStatus = EnablementStatus.Disabled;

  @added(Versions.v2026_01_01_preview)
  @doc("The URI of the Azure storage account used to store workspace artifacts, test results, and reports.")
  storageUri?: url;

  @added(Versions.v2026_08_01_preview)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @doc("The ARM resource ID of the virtual network subnet to inject the workspace into for private network connectivity. This is of the form '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Network/virtualNetworks/{virtualNetwork}/subnets/{subnet}'. This value cannot be changed after the workspace is created.")
  subnetId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;

  @added(Versions.v2026_11_01_preview)
  @doc("Indicates whether browser proxy is enabled for the workspace. When set to true, browser proxy can be used for the workspace.")
  browserProxy?: EnablementStatus = EnablementStatus.Disabled;

  @added(Versions.v2026_11_01_preview)
  @doc("Indicates whether browser proxy is enabled for the workspace. When set to true, browser proxy can be used for the workspace.")
  linkedKeyVault?: LinkedKeyVaultProperties;
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

@doc("Linked Key Vault properties for the Playwright workspace.")
model LinkedKeyVaultProperties {
  @doc("The URI of the linked Key Vault.")
  vaultUri?: url;

  @doc("The identity used to access the linked Key Vault.")
  vaultIdentity?: ManagedIdentityProperties;
}

@doc("Managed identity properties for accessing Azure resources.")
model ManagedIdentityProperties {
  @doc("The type of the managed identity, either SystemAssigned or UserAssigned.")
  type?: ManagedIdentityType;

  @doc("The resource ID of the user-assigned managed identity.")
  resourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("The type of the managed identity.")
union ManagedIdentityType {
  string,

  @doc("System-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed identity.")
  UserAssigned: "UserAssigned",
}
