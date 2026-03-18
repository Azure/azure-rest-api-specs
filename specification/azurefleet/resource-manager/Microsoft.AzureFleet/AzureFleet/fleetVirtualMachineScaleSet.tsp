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

/** An AzureFleet VirtualMachineScaleSet resource */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineScaleSet is TrackedResource<FleetVirtualMachineScaleSetProperties> {
  /** The name of the VirtualMachineScaleSet */
  @key("vmssName")
  @segment("virtualMachineScaleSets")
  @pattern("^[^_\\W][\\w\\-._]{0,79}(?<![-.])$")
  @path
  name: string;
}

/** Properties of a VirtualMachineScaleSet resource. */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineScaleSetProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The virtual machine scale set sku. */
  sku?: FleetVmsssku;
}

/** Describes a virtual machine scale set sku. */
@added(Versions.v2026_03_01_preview)
model FleetVmsssku {
  /** Specifies the number of virtual machines in the scale set. */
  @minValue(0)
  capacity?: int64;
}

/** The type used for update operations of the VirtualMachineScaleSet. */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineScaleSetUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** RP-specific updatable properties */
  properties?: FleetVirtualMachineScaleSetProperties;
}

/** The response of a VirtualMachineScaleSet list operation. */
@added(Versions.v2026_03_01_preview)
model FleetVirtualMachineScaleSetListResult {
  /** The VirtualMachineScaleSet items on this page */
  @pageItems
  value: Array<FleetVirtualMachineScaleSet>;

  /** The link to the next page of items */
  @nextLink
  nextLink?: url;
}

@armResourceOperations
@added(Versions.v2026_03_01_preview)
interface FleetVirtualMachineScaleSets {
  get is ArmResourceRead<FleetVirtualMachineScaleSet>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetVirtualMachineScaleSet,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<FleetVirtualMachineScaleSet, FleetVirtualMachineScaleSetUpdate>;

  delete is ArmResourceDeleteSync<FleetVirtualMachineScaleSet>;

  listByResourceGroup is ArmResourceListByParent<FleetVirtualMachineScaleSet>;

  listBySubscription is ArmListBySubscription<FleetVirtualMachineScaleSet>;
}
