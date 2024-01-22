import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CertificateResponse.tsp";
import "./ProvisioningServiceDescription.tsp";
import "./GroupIdInformation.tsp";
import "./PrivateEndpointConnection.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * API for using the Azure IoT Hub Device Provisioning Service features.
 */
@armProviderNamespace
@service({
  title: "iotDpsClient",
})
@versioned(Versions)
// FIXME: Common type version v2 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
namespace Microsoft.Devices;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-02-05 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_02_05: "2022-02-05",
}
