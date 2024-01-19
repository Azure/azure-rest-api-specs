import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Factory.tsp";
import "./IntegrationRuntimeResource.tsp";
import "./LinkedServiceResource.tsp";
import "./DatasetResource.tsp";
import "./PipelineResource.tsp";
import "./TriggerResource.tsp";
import "./DataFlowResource.tsp";
import "./ManagedVirtualNetworkResource.tsp";
import "./ManagedPrivateEndpointResource.tsp";
import "./ManagedIdentityCredentialResource.tsp";
import "./PrivateEndpointConnectionResource.tsp";
import "./GlobalParameterResource.tsp";
import "./ChangeDataCaptureResource.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "DataFactoryManagementClient",
})
@versioned(Versions)
@doc("The Azure Data Factory V2 management API provides a RESTful set of web services that interact with Azure Data Factory V2 services.")
namespace Microsoft.DataFactory;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2018-06-01 API version.")
  v2018_06_01: "2018-06-01",
}
