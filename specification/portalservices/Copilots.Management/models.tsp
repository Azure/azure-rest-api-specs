import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.PortalServices;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The Copilot properties.")
model CopilotProperties {
  @doc("The maximum number of Azure Agent Units (AAUs) that can be consumed by this copilot. This serves as a spending limit to prevent unexpected charges.")
  spendingLimit?: int32;

  @doc("The status of the last provisioning operation performed on the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

// Patch request workaround for Swagger LintDiff.
// TypeSpec Bug: ArmResourcePatchAsync auto-generates update model that extends TrackedResource
@doc("The properties of a Copilot that can be updated.")
model CopilotUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  @doc("The resource-specific properties for this resource.")
  properties?: CopilotProperties;
}
