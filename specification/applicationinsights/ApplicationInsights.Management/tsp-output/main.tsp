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
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@doc("Composite Swagger for Application Insights Management Client")
namespace Microsoft.Insights;
