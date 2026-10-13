import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ComputeLimit;

/** VM family resource representing a virtual machine family and its category. */
@parentResource(SubscriptionLocationResource)
@added(Versions.v2026_04_30)
model VmFamily is Azure.ResourceManager.ProxyResource<VmFamilyProperties> {
  ...ResourceNameParameter<
    Resource = VmFamily,
    KeyName = "vmFamilyName",
    SegmentName = "vmFamilies"
  >;
}

/** Properties of a VM family resource. */
@added(Versions.v2026_04_30)
model VmFamilyProperties {
  /** The category of the VM family (for example, GeneralPurpose, ComputeOptimized). */
  category?: string;

  ...DefaultProvisioningStateProperty;
}

/** Location-scoped operations for VM family resources. */
@armResourceOperations
@added(Versions.v2026_04_30)
interface VmFamilies {
  /** Gets the properties of a VM family. */
  get is ArmResourceRead<VmFamily>;

  /** Lists all VM families for the subscription at the specified location. */
  list is ArmResourceListAtScope<
    VmFamily,
    Parameters = {
      /** The filter to apply to the list operation. Filter can be applied to the 'category' property. Example: $filter=category eq 'generalPurposeCategory'. */
      @query("$filter")
      $filter?: string;
    }
  >;
}
