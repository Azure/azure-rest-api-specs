import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

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
}

@doc("The properties of Extension Manager resource")
model ExtensionManagerProperties {
  @doc("Provisioning state of Extension Manager resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("ARM ID of the custom location resource deployed on the Onboarding Appliance")
  extendedLocation: string;

  @doc("Extension profile of the extension manager resource")
  @visibility("read")
  extensionProfile?: ExtensionObject[];

  @doc("Scenario profile of the extension manager resource")
  scenarioProfile?: ScenarioObject[];
}

@doc("Extension object inside the extension profile.")
model ExtensionObject {
  @doc("Name of the extension")
  name: string;

  @doc("Extension details of an extension in extension profile.")
  extensionDetails: ExtensionDetails[];

  @doc("Flag to enable/disable the extension")
  enabled: boolean;
}

@doc("Extension details of an extension in extension profile.")
model ExtensionDetails {
  @visibility("read")
  @doc("Custom Location of the extension")
  customLocation?: string;

  @doc("Infra on which extension is deployed.")
  infrastructure: string;

  @doc("Azure scenario enabled. Ex: Migrate")
  scenario: string;
}

@doc("Scenario object inside the scenario profile.")
model ScenarioObject {
  @doc("Infra on which extension is deployed.")
  infrastructure: string;

  @doc("Azure scenario enabled. Ex: Migrate")
  scenario: string;
}

@doc("Properties of a Extension Manager that can be patched.")
model ExtensionManagerPatch {
  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("Provisioning state of the resource")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState, //standard terminal values
  @doc("creating")
  Creating,
  @doc("updating")
  Updating,
  @doc("deleting")
  Deleting,
  @doc("accepted")
  Accepted
}

@doc("Request body details for enabling extensions POST action")
model EnableExtensionsRequestDetails {
  @doc("Name of the extension")
  name: string;

  @doc("Infra on which the extension will be enabled.")
  infrastructure: string;

  @doc("Azure scenario enabled. Ex: Migrate")
  scenario: string;

  @doc("Number of additional custome locations required for the extension")
  additionalCustomLocationCount: int64;
}

@doc("Request body details for disabling extensions POST action")
model DisableExtensionsRequestDetails {
  @doc("Name of the extension")
  name: string;

  @doc("Infra on which the extension will be disabled.")
  infrastructure: string;

  @doc("Azure scenario enabled. Ex: Migrate")
  scenario: string;
}

@doc("Request body for adding new fabric/scenario/infra POST action")
model AddFabricRequestDetails {
  @doc("Infra of new fabric.")
  infrastructure: string;

  @doc("Azure scenario enabled. Ex: Migrate")
  scenario: string;
}

@doc("Request body for removing a fabric/scenario/infra POST action")
model RemoveFabricRequestDetails {
  @doc("Infra of fabric to be removed.")
  infrastructure: string;

  @doc("Azure scenario enabled. Ex: Migrate")
  scenario: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface ExtensionManagers {
  get is ArmResourceRead<ExtensionManager>;
  //create is ArmResourceCreateOrUpdateAsync<ExtensionManager>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ExtensionManager>;
  update is ArmCustomPatchAsync<ExtensionManager, ExtensionManagerPatch>;
  delete is ArmResourceDeleteAsync<ExtensionManager>;
  listByResourceGroup is ArmResourceListByParent<ExtensionManager>;
  listBySubscription is ArmListBySubscription<ExtensionManager>;
  @doc("Enable extensions on the extension manager resource")
  enableExtensions is ArmResourceActionAsync<ExtensionManager, EnableExtensionsRequestDetails[], ExtensionManager>;
  @doc("Disable extensions on the extension manager resource")
  disableExtensions is ArmResourceActionAsync<ExtensionManager, DisableExtensionsRequestDetails[], ExtensionManager>;
  @doc("Add new fabric/infra/scenario on the extension manager resource")
  addNewFabric is ArmResourceActionAsync<ExtensionManager, AddFabricRequestDetails, ExtensionManager>;
  @doc("Remove a fabric/infra/scenario on the extension manager resource")
  removeFabric is ArmResourceActionAsync<ExtensionManager, RemoveFabricRequestDetails, ExtensionManager>;
}
