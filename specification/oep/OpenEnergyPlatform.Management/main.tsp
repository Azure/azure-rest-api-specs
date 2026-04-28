import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./EnergyService.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Open Energy Platform Management Service APIs")
@armProviderNamespace("Microsoft.OpenEnergyPlatform")
@service(#{ title: "Open Energy Platform Management Service APIs" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
namespace Microsoft.OpenEnergyPlatform;

@doc("The available API versions.")
enum Versions {
  @doc("The 2022-04-04-preview API version.")
  v2022_04_04_preview: "2022-04-04-preview",
}

@doc("Operations for Microsoft.OpenEnergyPlatform resource provider.")
interface Operations extends Azure.ResourceManager.Operations {}
