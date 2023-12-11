import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./LogAnalyticsQueryPack.tsp";
import "./LogAnalyticsQuery.tsp";
import "./OperationalInsightsDataExport.tsp";
import "./OperationalInsightsDataSource.tsp";
import "./OperationalInsightsLinkedService.tsp";
import "./OperationalInsightsLinkedStorageAccounts.tsp";
import "./StorageInsight.tsp";
import "./OperationalInsightsSavedSearch.tsp";
import "./OperationalInsightsCluster.tsp";
import "./OperationalInsightsWorkspace.tsp";
import "./OperationalInsightsTable.tsp";
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
@doc("Operational Insights Client")
namespace Azure.ResourceManager.OperationalInsights;
