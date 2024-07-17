using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Available values for the Multi-factor authentication enforcement behavior.")
union MfaEnforcement {
  string,

  @doc("Use the default Multi-factor authentication enforcement behavior.")
  "Default",

  @doc("This tenant is opted out of Multi-factor authentication enforcement.")
  "OptOut",

  @doc("Multi-factor authentication is required.")
  "Enforce",
}

@doc("The Copilot Settings properties.")
model CopilotSettingsProperties {
  @doc("Boolean indicating if role-based access control is enabled for copilot in this tenant.")
  accessControlEnabled: boolean;

  @added(Versions.v2024_07_01_preview)
  @doc("The setting for Multi-Factor Authentication enforcement when signing into this tenant in the Azure Portal.")
  portalMfaEnforcement?: MfaEnforcement;

  @added(Versions.v2024_07_01_preview)
  @doc("Justification for the value set for portalMfaEnforcement. Required when portalMfaEnforcement is set to a value other than 'Default'. Maximum length is 500 characters.")
  portalMfaEnforcementJustification?: string;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}
