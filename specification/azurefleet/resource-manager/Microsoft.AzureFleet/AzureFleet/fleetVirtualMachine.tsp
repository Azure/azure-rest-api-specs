import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AzureFleet;

/** An AzureFleet VirtualMachine resource */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachine is TrackedResource<FleetVirtualMachineProperties> {
  /** The name of the VirtualMachine */
  @key("vmName")
  @segment("virtualMachines")
  @pattern("^[^_\\W][\\w\\-._]{0,79}(?<![-.])$")
  @path
  name: string;
}

/** Properties of a VirtualMachine resource. */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Specifies the operating system settings for the virtual machine. */
  osProfile?: FleetVirtualMachineOSProfile;
}

/** Specifies the operating system settings for the virtual machine. */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineOSProfile {
  /** Specifies the computer name of the virtual machine. */
  computerName?: string;
}

/** The type used for update operations of the VirtualMachine. */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** RP-specific updatable properties */
  properties?: FleetVirtualMachineProperties;
}

/** The response of a VirtualMachine list operation. */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineListResult {
  /** The VirtualMachine items on this page */
  @pageItems
  value: Array<FleetVirtualMachine>;

  /** The link to the next page of items */
  @nextLink
  nextLink?: url;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface FleetVirtualMachines {
  get is ArmResourceRead<FleetVirtualMachine>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetVirtualMachine,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<FleetVirtualMachine, FleetVirtualMachineUpdate>;

  delete is ArmResourceDeleteSync<FleetVirtualMachine>;

  listByResourceGroup is ArmResourceListByParent<FleetVirtualMachine>;

  listBySubscription is ArmListBySubscription<FleetVirtualMachine>;
}
