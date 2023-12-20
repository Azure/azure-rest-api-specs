import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CostManagementExport.tsp";
import "./TenantsCostManagementViews.tsp";
import "./CostManagementViews.tsp";
import "./CostManagementAlert.tsp";
import "./TenantScheduledAction.tsp";
import "./ScheduledAction.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "CostManagementClient",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("CostManagement management client provides access to CostManagement resources for Azure Enterprise Subscriptions.")
namespace Azure.ResourceManager.CostManagement;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_03_01: "2023-03-01",
}
