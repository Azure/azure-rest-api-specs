import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Service.tsp";
import "./MetadataSchema.tsp";
import "./Workspace.tsp";
import "./Api.tsp";
import "./ApiVersion.tsp";
import "./ApiDefinition.tsp";
import "./Deployment.tsp";
import "./Environment.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Azure API Center",
})
@versioned(Versions)
@doc("Azure API Center Resource Provider.")
namespace Microsoft.ApiCenter;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_03_01: "2024-03-01",
}
