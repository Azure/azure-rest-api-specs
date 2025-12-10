import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DatacenterHardware;

@tenantResource
@added(Versions.v2025_12_02_preview)
model HardwareAsset is ProxyResource<HardwareAssetProperties> {
  ...ResourceNameParameter<
    HardwareAsset,
    KeyName = "assetTag",
    SegmentName = "hardwareAssets"
  >;
}

@armResourceOperations
interface HardwareAssets {
  @added(Versions.v2025_12_02_preview)
  get is ArmResourceRead<HardwareAsset>;
  @added(Versions.v2025_12_02_preview)
  list is ArmResourceListByParent<HardwareAsset>;
}
