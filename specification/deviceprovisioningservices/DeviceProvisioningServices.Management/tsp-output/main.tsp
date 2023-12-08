import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DeviceProvisioningServicesCertificate.tsp";
import "./DeviceProvisioningService.tsp";
import "./DeviceProvisioningServicesPrivateLinkResource.tsp";
import "./DeviceProvisioningServicesPrivateEndpointConnection.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "iotDpsClient",
})
@versioned(Versions)
@doc("API for using the Azure IoT Hub Device Provisioning Service features.")
namespace Azure.ResourceManager.DeviceProvisioningServices;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_02_05: "2022-02-05",
}
