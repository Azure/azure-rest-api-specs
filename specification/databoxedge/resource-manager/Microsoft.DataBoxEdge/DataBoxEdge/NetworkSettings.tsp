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
 * The network settings of a device.
 */
@singleton("default")
@parentResource(DataBoxEdgeDevice)
model NetworkSettings
  is Azure.ResourceManager.ProxyResource<NetworkSettingsProperties> {
  ...ResourceNameParameter<
    Resource = NetworkSettings,
    KeyName = "networkSetting",
    SegmentName = "networkSettings",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Devices {
  /**
   * Gets the network settings of the specified Data Box Edge/Data Box Gateway device.
   */
  getNetworkSettings is ArmResourceRead<NetworkSettings, Error = CloudError>;
}

@@doc(NetworkSettings.name, "");
@@doc(NetworkSettings.properties,
  "The properties of network settings of a device."
);
