import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./OrbitalSpacecraft.tsp";
import "./OrbitalContact.tsp";
import "./OrbitalContactProfile.tsp";
import "./AvailableGroundStation.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "Azure Orbital",
})
@versioned(Versions)
@doc("Azure Orbital service.")
namespace Azure.ResourceManager.Orbital;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_03_01: "2022-03-01",
}
