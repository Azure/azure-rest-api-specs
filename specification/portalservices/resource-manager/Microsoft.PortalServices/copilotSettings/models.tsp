using Azure.ResourceManager;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Copilot Settings properties.")
model CopilotSettingsProperties {
  @doc("Boolean indicating if role-based access control is enabled for copilot in this tenant.")
  accessControlEnabled: boolean;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}
