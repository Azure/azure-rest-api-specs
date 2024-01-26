import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Spacecraft.tsp";
import "./Contact.tsp";
import "./ContactProfile.tsp";
import "./AvailableGroundStation.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure Orbital service.
 */
@armProviderNamespace
@service({
  title: "Azure Orbital",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.Orbital;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-03-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_03_01: "2022-03-01",
}
