import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
/**
 * Object for Capturing DeviceCapacityInfo
 */
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model DeviceCapacityInfo
  is Azure.ResourceManager.ProxyResource<DeviceCapacityInfoProperties> {
  ...ResourceNameParameter<
    Resource = DeviceCapacityInfo,
    KeyName = "deviceCapacityInfo",
    SegmentName = "deviceCapacityInfo",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeviceCapacityInfos {
  /**
   * Gets the properties of the specified device capacity info.
   */
  getDeviceCapacityInfo is ArmResourceRead<
    DeviceCapacityInfo,
    Error = CloudError
  >;
}

@@doc(DeviceCapacityInfo.name, "");
@@doc(DeviceCapacityInfo.properties, "The device capacity properties.");
