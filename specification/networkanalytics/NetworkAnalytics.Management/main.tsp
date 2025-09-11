import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "./models/common/adxSkuName.tsp";
import "./models/aoi/dataLakeHouse.tsp";
import "./models/aoi/networkAnalyticsProducts.tsp";
import "./models/aoi/dataConnector.tsp";
import "./models/aoi/dataproductsCatalog.tsp";
import "./models/aoi/dataType.tsp";
import "./models/aoi/dataProduct.tsp";
import "./models/common/sharedModels.tsp";
import "./models/emig/metricsIngestionEndpoint.tsp";

using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;
using OpenAPI;

@armProviderNamespace
@service(#{ title: "Microsoft.NetworkAnalytics" })
@versioned(Microsoft.NetworkAnalytics.Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.NetworkAnalytics;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The available API versions for the Microsoft.NetworkAnalytics RP.")
enum Versions {
  @doc("The 2022-11-15-preview version.")
  v2022_11_15_preview: "2022-11-15-preview",

  @doc("The 2023-03-31-preview version.")
  v2023_03_31_preview: "2023-03-31-preview",

  @doc("The 2023-04-30-preview version.")
  v2023_04_30_preview: "2023-04-30-preview",

  @doc("The 2023-11-15 stable version.")
  v2023_11_15: "2023-11-15",

  @doc("The 2024-04-01-preview version.")
  v2024_04_01_preview: "2024-04-01-preview",
}
