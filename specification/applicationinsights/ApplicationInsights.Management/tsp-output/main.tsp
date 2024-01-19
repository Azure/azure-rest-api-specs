import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ApplicationInsightsComponent.tsp";
import "./WebTest.tsp";
import "./WorkbookTemplate.tsp";
import "./MyWorkbook.tsp";
import "./Workbook.tsp";
import "./Workbook.tsp";
import "./ComponentLinkedStorageAccounts.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "ApplicationInsightsManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Composite Swagger for Application Insights Management Client")
namespace Microsoft.Insights;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2020-02-02 API version.")
  v2020_02_02: "2020-02-02",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2015-05-01 API version.")
  v2015_05_01: "2015-05-01",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-06-15 API version.")
  v2022_06_15: "2022-06-15",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2021-03-08 API version.")
  v2021_03_08: "2021-03-08",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2020-11-20 API version.")
  v2020_11_20: "2020-11-20",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2022-04-01 API version.")
  v2022_04_01: "2022-04-01",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2021-10-14 API version.")
  v2021_10_14: "2021-10-14",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @doc("The 2020-03-01-preview API version.")
  v2020_03_01_preview: "2020-03-01-preview",
}
