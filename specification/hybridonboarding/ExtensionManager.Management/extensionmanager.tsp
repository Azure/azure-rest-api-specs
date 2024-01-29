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

  @doc("Fabric Id of the vCenter on which extension manager is deployed.")
  fabricId?: string;

  @doc("ARM ID of the custom location resource deployed on the Onboarding Appliance")
  extendedLocation: string;

  @doc("Infra on which the onboarding appliance is deployed.")
  infrastructure?: string;

  @doc("Azure scenario enabled. Ex: Migrate")
  scenarioList?: string[];

  @doc("Extension profile of the extension manager resource")
  @visibility("read", "update")
  extensionProfile?: ExtensionObject[];
}

@doc("Extension object inside the extension profile.")
model ExtensionObject {
  @doc("Name of the extension")
  name: string;

  @visibility("read")
  @doc("Custom Location of the extension")
  customLocation?: string;

  @doc("Flag to enable/disable the extension")
  enabled: boolean;
}

@doc("Properties of a Extension Manager that can be patched.")
model ExtensionManagerPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Patch properties of Extension Manager Resource")
  properties?: ExtensionManagerPatchProperties;
}

@doc("Patch properties of Extension Manager Resource")
model ExtensionManagerPatchProperties {
  @doc("Fabric Id of the vCenter on which extension manager is deployed.")
  fabricId?: string;

  @doc("Extension profile of the extension manager resource")
  extensionProfile?: ExtensionObject[];
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
}
