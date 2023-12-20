import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./HealthcareApisService.tsp";
import "./HealthcareApisServicePrivateEndpointConnection.tsp";
import "./HealthcareApisWorkspacePrivateEndpointConnection.tsp";
import "./HealthcareApisServicePrivateLinkResource.tsp";
import "./HealthcareApisWorkspacePrivateLinkResource.tsp";
import "./HealthcareApisWorkspace.tsp";
import "./DicomService.tsp";
import "./HealthcareApisIotConnector.tsp";
import "./HealthcareApisIotFhirDestination.tsp";
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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Azure Healthcare APIs Client")
namespace Azure.ResourceManager.HealthcareApis;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_11_01: "2023-11-01",
}
