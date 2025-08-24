import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AttestationProvider.tsp";
import "./AttestationManagementClientPrivateEndpointConnection.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "AttestationManagementClient",
})
@versioned(Versions)
@doc("Various APIs for managing resources in attestation service. This primarily encompasses per-provider management.")
namespace Microsoft.Attestation;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_06_01: "2021-06-01",
}
