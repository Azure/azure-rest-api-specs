import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./LogAnalyticsQueryPack.tsp";
import "./LogAnalyticsQueryPackQuery.tsp";
import "./DataExport.tsp";
import "./DataSource.tsp";
import "./LinkedService.tsp";
import "./LinkedStorageAccountsResource.tsp";
import "./StorageInsight.tsp";
import "./SavedSearch.tsp";
import "./Cluster.tsp";
import "./Workspace.tsp";
import "./Table.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "OperationalInsightsManagementClient",
})
// FIXME: Common type version v2 is not supportted for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Operational Insights Client")
namespace Azure.ResourceManager.OperationalInsights;
