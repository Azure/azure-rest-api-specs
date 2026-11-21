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

/** A RegionMix Fleet resource that groups virtual machine scale sets across regions. */
@added(Versions.v2026_06_01_preview)
@removed(Versions.v2026_08_01)
model RegionMixFleet is TrackedResource<RegionMixFleetProperties> {
  ...ResourceNameParameter<
    Resource = RegionMixFleet,
    KeyName = "regionMixFleetName",
    SegmentName = "regionMixFleets",
    NamePattern = "^[^_\\W][\\w\\-._]{0,79}(?<![-.])$"
  >;
}

/** Details of the RegionMix Fleet. */
@added(Versions.v2026_06_01_preview)
@removed(Versions.v2026_08_01)
model RegionMixFleetProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The virtual machine scale sets that are part of the RegionMix Fleet. */
  @identifiers(#["virtualMachineScaleSet/id"])
  virtualMachineScaleSets?: RegionMixFleetVirtualMachineScaleSet[];
}

/** A virtual machine scale set that is part of a RegionMix Fleet. */
@added(Versions.v2026_06_01_preview)
@removed(Versions.v2026_08_01)
model RegionMixFleetVirtualMachineScaleSet {
  /** Reference to the Microsoft.Compute virtual machine scale set resource. */
  virtualMachineScaleSet: ApiEntityReference;
}

/** RegionMix Fleet update model. */
@added(Versions.v2026_06_01_preview)
@removed(Versions.v2026_08_01)
model RegionMixFleetUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** RP-specific updatable properties. */
  properties?: RegionMixFleetProperties;
}

@added(Versions.v2026_06_01_preview)
@removed(Versions.v2026_08_01)
@armResourceOperations
interface RegionMixFleets {
  get is ArmResourceRead<RegionMixFleet>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<RegionMixFleet>;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<RegionMixFleet, RegionMixFleetUpdate>;

  delete is ArmResourceDeleteWithoutOkAsync<RegionMixFleet>;

  listByResourceGroup is ArmResourceListByParent<RegionMixFleet>;

  listBySubscription is ArmListBySubscription<RegionMixFleet>;
}
