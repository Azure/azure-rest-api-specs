import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./DataFactory.tsp";
import "./DataFactoryIntegrationRuntime.tsp";
import "./DataFactoryLinkedService.tsp";
import "./DataFactoryDataset.tsp";
import "./DataFactoryPipeline.tsp";
import "./DataFactoryTrigger.tsp";
import "./DataFactoryDataFlow.tsp";
import "./DataFactoryManagedVirtualNetwork.tsp";
import "./DataFactoryPrivateEndpoint.tsp";
import "./DataFactoryManagedIdentityCredential.tsp";
import "./DataFactoryPrivateEndpointConnection.tsp";
import "./DataFactoryGlobalParameter.tsp";
import "./DataFactoryChangeDataCapture.tsp";
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
namespace Azure.ResourceManager.DataFactory;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2018_06_01: "2018-06-01",
}
