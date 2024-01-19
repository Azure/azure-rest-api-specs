import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./IotHubDescription.tsp";
import "./EventHubConsumerGroupInfo.tsp";
import "./CertificateDescription.tsp";
import "./GroupIdInformation.tsp";
import "./PrivateEndpointConnection.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "iotHubClient",
})
@versioned(Versions)
@doc("Use this API to manage the IoT hubs in your Azure subscription.")
namespace Microsoft.Devices;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2023-06-30 API version.")
  v2023_06_30: "2023-06-30",
}
