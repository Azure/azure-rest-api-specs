import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ServicesDescription.tsp";
import "./PrivateEndpointConnectionDescription.tsp";
import "./PrivateEndpointConnectionDescription.tsp";
import "./PrivateLinkResourceDescription.tsp";
import "./PrivateLinkResourceDescription.tsp";
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
/**
 * Azure Healthcare APIs Client
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["https://management.azure.com/.default"]>)
@service({
  title: "HealthcareApisManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.HealthcareApis;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-11-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_11_01: "2023-11-01",
}
