import "./common.tsp";
import "./catalog.tsp";
import "./image.tsp";
import "./deviceGroup.tsp";
import "./certificate.tsp";
import "./deployment.tsp";
import "./device.tsp";
import "./deviceGroup.tsp";
import "./product.tsp";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "AzureSphereProviderClient",
  version: "2022-09-01-preview",
})
@doc("Azure Sphere resource management API.")
@useDependency(Azure.Core.Versions.v1_0_Preview_1)
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureSphere;
