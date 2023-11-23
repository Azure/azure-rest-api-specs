import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ServicesDescription.tsp";
import "./ServicePrivateEndpointConnection.tsp";
import "./WorkspacePrivateEndpointConnection.tsp";
import "./ServicePrivateLinkResource.tsp";
import "./WorkspacePrivateLinkResource.tsp";
import "./Workspace.tsp";
import "./DicomService.tsp";
import "./IotConnector.tsp";
import "./IotFhirDestination.tsp";
import "./FhirService.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "HealthcareApisManagementClient",
})
@versioned(Versions)
@doc("Azure Healthcare APIs Client")
namespace Microsoft.HealthcareApis;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_06_01: "2022-06-01",
}
