using TypeSpec.Versioning;

namespace Microsoft.NetworkAnalytics;

@doc("The status of the current operation.")
enum ProvisioningState {
  /** Represents a succeeded operation. */
  Succeeded,

  /** Represents a failed operation. */
  Failed,

  /** Represents a canceled operation. */
  Canceled,

  /** Represents a pending operation. */
  Provisioning,

  /** Represents a pending operation. */
  Updating,

  /** Represents an operation under deletion. */
  Deleting,

  /** Represents an accepted operation. */
  Accepted,
}

@doc("ManagedResourceGroup related properties")
model ManagedResourceGroupConfiguration {
  @doc("Name of managed resource group")
  name: string;

  @doc("Managed Resource Group location")
  location: string;
}

@doc("The data type state")
@added(Versions.v2023_11_15)
enum ControlState {
  @doc("Field to enable a setting.")
  Enabled,

  @doc("Field to disable a setting.")
  Disabled,
}

@doc("Specifies the default action of allow or deny when no other rules match.")
enum DefaultAction {
  @doc("Represents allow action.")
  Allow,

  @doc("Represents deny action.")
  Deny,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Suppressing casing style warning for iprules for now."
@doc("IP rule with specific IP or IP range in CIDR format.")
@added(Versions.v2022_11_15_preview)
model IPRules {
  @added(Versions.v2022_11_15_preview)
  @removed(Versions.v2024_04_01_preview)
  @renamedFrom(Versions.v2024_04_01_preview, "value")
  @doc("IP Rules Value")
  oldValue?: string;

  @added(Versions.v2024_04_01_preview)
  @doc("IP Rules Value")
  value: string;

  @added(Versions.v2022_11_15_preview)
  @removed(Versions.v2024_04_01_preview)
  @renamedFrom(Versions.v2024_04_01_preview, "action")
  @doc("The action of virtual network rule.")
  oldAction: string;

  @added(Versions.v2024_04_01_preview)
  @doc("The action of IP rule.")
  action?: DefaultAction = DefaultAction.Allow;
}

@doc("Virtual Network Rule")
model VirtualNetworkRule {
  @doc("Resource ID of a subnet")
  id: string;

  @added(Versions.v2022_11_15_preview)
  @removed(Versions.v2024_04_01_preview)
  @renamedFrom(Versions.v2024_04_01_preview, "action")
  @doc("The action of virtual network rule.")
  oldAction?: string;

  @added(Versions.v2024_04_01_preview)
  @doc("The action of virtual network rule.")
  action?: DefaultAction = DefaultAction.Allow;

  @removed(Versions.v2024_04_01_preview)
  @doc("Gets the state of virtual network rule.")
  state?: string;
}
