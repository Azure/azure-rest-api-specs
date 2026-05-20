import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./NetworkSettingsResource.tsp";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

@doc("GitHub.Network Resource Provider REST API")
@armProviderNamespace
@service(#{ title: "GitHub.Network client" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace GitHub.Network;

@doc("The available API versions.")
enum Versions {
  @doc("The 2024-04-01-preview API version for staging environment.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-04-01-preview`,

  @doc("The 2024-04-01 API version for staff US environment.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-04-01`,

  @doc("The 2024-04-02 API version for production US/EU environments.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-04-02`,
}
