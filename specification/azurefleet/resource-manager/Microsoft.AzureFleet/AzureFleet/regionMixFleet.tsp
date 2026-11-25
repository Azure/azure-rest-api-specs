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
@added(Versions.v2026_12_01_preview)
model RegionMixFleet is TrackedResource<RegionMixFleetProperties> {
  ...ResourceNameParameter<
    Resource = RegionMixFleet,
    KeyName = "regionMixFleetName",
    SegmentName = "regionMixFleets",
    NamePattern = "^[A-Za-z0-9](?:[A-Za-z0-9_.-]{0,78}[A-Za-z0-9_])?$"
  >;
}

/** Details of the RegionMix Fleet. */
@added(Versions.v2026_12_01_preview)
model RegionMixFleetProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The virtual machine scale sets that are part of the RegionMix Fleet. */
  @identifiers(#["virtualMachineScaleSet/id"])
  virtualMachineScaleSets?: RegionMixFleetVirtualMachineScaleSet[];
}

/** A virtual machine scale set that is part of a RegionMix Fleet. */
@added(Versions.v2026_12_01_preview)
model RegionMixFleetVirtualMachineScaleSet {
  /** Reference to the Microsoft.Compute virtual machine scale set resource. */
  virtualMachineScaleSet: ApiEntityReference;
}

/** RegionMix Fleet update model. */
@added(Versions.v2026_12_01_preview)
model RegionMixFleetUpdate {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** RP-specific updatable properties. */
  properties?: RegionMixFleetUpdateProperties;
}

/** RegionMix Fleet updatable properties. */
@added(Versions.v2026_12_01_preview)
model RegionMixFleetUpdateProperties {
  /** The virtual machine scale sets that are part of the RegionMix Fleet. */
  @identifiers(#["virtualMachineScaleSet/id"])
  virtualMachineScaleSets?: RegionMixFleetVirtualMachineScaleSet[];
}

@added(Versions.v2026_12_01_preview)
@armResourceOperations
interface RegionMixFleets {
  get is ArmResourceRead<RegionMixFleet>;

  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    RegionMixFleet,
    Response =
      | (ArmResourceUpdatedResponse<RegionMixFleet> &
          ArmAsyncOperationHeader<FinalResult = RegionMixFleet> &
          Azure.Core.Foundations.RetryAfterHeader)
      | ArmResourceCreatedResponse<
          RegionMixFleet,
          ArmAsyncOperationHeader<FinalResult = RegionMixFleet> &
            Azure.Core.Foundations.RetryAfterHeader
        >
  >;

  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    RegionMixFleet,
    RegionMixFleetUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = RegionMixFleet> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    RegionMixFleet,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  listByResourceGroup is ArmResourceListByParent<
    RegionMixFleet,
    Response = ArmResponse<RegionMixFleetListResult>
  >;

  listBySubscription is ArmListBySubscription<
    RegionMixFleet,
    Response = ArmResponse<RegionMixFleetListResult>
  >;
}

/** The response of a RegionMixFleet list operation. */
@added(Versions.v2026_12_01_preview)
model RegionMixFleetListResult {
  /** The RegionMixFleet items on this page */
  @pageItems
  value: RegionMixFleet[];

  /** The link to the next page of items */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: url;
}
