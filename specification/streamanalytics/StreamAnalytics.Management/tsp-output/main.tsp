import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Function.tsp";
import "./Input.tsp";
import "./Output.tsp";
import "./StreamingJob.tsp";
import "./Transformation.tsp";
import "./Cluster.tsp";
import "./PrivateEndpoint.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Stream Analytics Management Client",
})
@doc("Stream Analytics Client")
namespace Azure.ResourceManager.StreamAnalytics;
