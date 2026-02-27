import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./operation.tsp";
import "./hardwareAsset.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Microsoft.DatacenterHardware Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.DatacenterHardware management service" })
@versioned(Microsoft.DatacenterHardware.Versions)
namespace Microsoft.DatacenterHardware;

/** The available API versions. */
enum Versions {
  /** 2025-10-06-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_10_06_preview: "2025-10-06-preview",

  /** 2025-12-02-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_12_02_preview: "2025-12-02-preview",
}

/** Asset properties */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This resource represents physical datacenter hardware, not Azure-provisioned resources"
@added(Versions.v2025_12_02_preview)
model HardwareAssetProperties {
  /** The unique identifier for the asset */
  @visibility(Lifecycle.Read)
  assetId: int32;

  /** The asset tag associated with the asset */
  @key
  @visibility(Lifecycle.Read)
  assetTag: string;

  /** The serial number associated with the asset */
  @visibility(Lifecycle.Read)
  serialNumber: string;

  /** The name of the asset */
  @visibility(Lifecycle.Read)
  assetName: string;

  /** The location of the asset */
  @visibility(Lifecycle.Read)
  location: string;

  /** The data center code where the asset is located */
  @visibility(Lifecycle.Read)
  dataCenterCode: string;

  /** The colocation the asset is in */
  @visibility(Lifecycle.Read)
  colocation: string;

  /** The tile the asset is located at */
  @visibility(Lifecycle.Read)
  tile: string;

  /** The BOM SKU MSF for the asset */
  @visibility(Lifecycle.Read)
  bomSkuMsf: string;

  /** The discrete SKU MSF for the asset */
  @visibility(Lifecycle.Read)
  discreteSkuMsf: string;

  /** The item SKU MSF for the asset */
  @visibility(Lifecycle.Read)
  itemSkuMsf: string;

  /** The item type for the asset */
  @visibility(Lifecycle.Read)
  itemType: string;

  /** The network device type for the asset */
  @visibility(Lifecycle.Read)
  networkDeviceType?: string;

  /** The property group for the asset */
  @visibility(Lifecycle.Read)
  propertyGroup: string;

  /** The property dimension for the asset */
  @visibility(Lifecycle.Read)
  propertyDimension: string;

  /** The creation date of the asset */
  @visibility(Lifecycle.Read)
  created: utcDateTime;

  /** The maximum warranty date of the asset */
  @visibility(Lifecycle.Read)
  maxWarrantyDate: utcDateTime;

  /** The device state of the asset */
  @visibility(Lifecycle.Read)
  deviceState: string;

  /** The environment of the asset */
  @visibility(Lifecycle.Read)
  environment: string;
}
