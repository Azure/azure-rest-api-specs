import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.HybridOnboarding;

@doc("Extension Manager Resource")
model ExtensionManager is TrackedResource<ExtensionManagerProperties> {
  @key("extensionManagerName")
  @segment("extensionManagers")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @doc("Extension Manager resource")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Managed Identity of extension manager resource")
  identity: ManagedIdentity;
}

@doc("Managed Identity of extension manager resource")
model ManagedIdentity {
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @doc("The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  @format("uuid")
  principalId?: string;

  #suppress "@azure-tools/typespec-azure-core/no-format"
  @doc("The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  @format("uuid")
  tenantId?: string;

  @doc("Type of managed service identity")
  type: ManagedIdentityType;
}

@doc("Type of managed service identity")
enum ManagedIdentityType {
  @doc("System Assigned Managed Identity")
  SystemAssigned,
}

@doc("The properties of Extension Manager resource")
model ExtensionManagerProperties {
  @doc("Provisioning state of Extension Manager resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("ARM ID of the custom location resource deployed on the Onboarding Appliance")
  extendedLocation: string;

  @doc("ARM ID of the host associated with the extended location")
  @visibility("read")
  hostResourceId?: string;

  @doc("Scenario profile of the extension manager resource.")
  @extension("x-ms-identifiers", [])
  scenarioProfile?: ScenarioProfileObject[];

  @doc("Extension profile of the extension manager resource")
  @visibility("read")
  @extension("x-ms-identifiers", ["name"])
  extensionProfile?: ExtensionObject[];
}

@doc("Scenario profile object of the extension manager resource.")
model ScenarioProfileObject {
  @doc("Infrastructure associated with extension manager resource.")
  infrastructure: string;

  @doc("Scenario associated with extension manager resource.")
  scenario: string;
}

@doc("Extension object inside the extension profile.")
model ExtensionObject {
  @doc("Name of the extension")
  name: string;

  @doc("List of custom locations associated with the extension. All entries will be unique.")
  @visibility("read")
  customLocations?: string[];

  @doc("Flag to enable/disable the extension")
  state: ExtensionState;

  @doc("Configuration settings, as name-value pairs for configuring this extension.")
  @extension("x-nullable", true)
  configurationSettings?: Record<string>;

  @extension("x-nullable", true)
  @extension("x-ms-secret", true)
  @doc("Configuration settings that are sensitive, as name-value pairs for configuring this extension.")
  configurationProtectedSettings?: Record<string>;
}

@doc("Properties of a Extension Manager that can be patched.")
model ExtensionManagerPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Managed Identity of extension manager resource")
  identity?: ManagedIdentity;
}

@doc("Provisioning state of the resource")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState, //standard terminal values

  @doc("creating provisioning state")
  Creating,

  @doc("updating provisioning state")
  Updating,

  @doc("deleting provisioning state")
  Deleting,

  @doc("accepted provisioning state")
  Accepted,
}

@doc("State of the extension")
enum ExtensionState {
  @doc("Extension is enabled")
  Enabled,

  @doc("Extension is disabled")
  Disabled,
}

@doc("Request body details for enabling extension POST action")
model EnableExtensionsRequestDetails {
  @doc("Name of the extension")
  name: string;

  @doc("Configuration settings, as name-value pairs for configuring this extension.")
  @extension("x-nullable", true)
  configurationSettings?: Record<string>;

  @extension("x-nullable", true)
  @extension("x-ms-secret", true)
  @doc("Configuration settings that are sensitive, as name-value pairs for configuring this extension.")
  configurationProtectedSettings?: Record<string>;
}

@doc("Request body details for disabling extension POST action")
model DisableExtensionsRequestDetails {
  @doc("Name of the extension")
  name: string;
}

@doc("Request body for adding new custom location to an extension.")
model AddCustomLocationDetails {
  @doc("Name of the extension")
  name: string;
}

@doc("Request body for removing custom location from extension.")
model RemoveCustomLocationDetails {
  @doc("Name of the extension")
  name: string;

  @doc("ARM ID of the custom location")
  customLocationId: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface ExtensionManagers {
  get is ArmResourceRead<ExtensionManager>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExtensionManager>;
  update is ArmCustomPatchAsync<ExtensionManager, ExtensionManagerPatch>;
  delete is ArmResourceDeleteWithoutOkAsync<ExtensionManager>;
  listByResourceGroup is ArmResourceListByParent<ExtensionManager>;
  listBySubscription is ArmListBySubscription<ExtensionManager>;
  @doc("Enable extension(s) on the extension manager resource")
  enableExtensions is ArmResourceActionAsync<
    ExtensionManager,
    EnableExtensionsRequestDetails[],
    ExtensionManager
  >;
  @doc("Disable extension(s) on the extension manager resource")
  disableExtensions is ArmResourceActionAsync<
    ExtensionManager,
    DisableExtensionsRequestDetails[],
    ExtensionManager
  >;
  @doc("Add a new custom location on extension(s)")
  addCustomLocation is ArmResourceActionAsync<
    ExtensionManager,
    AddCustomLocationDetails[],
    ExtensionManager
  >;
  @doc("Remove a custom location from extension(s)")
  removeCustomLocation is ArmResourceActionAsync<
    ExtensionManager,
    RemoveCustomLocationDetails[],
    ExtensionManager
  >;
}
