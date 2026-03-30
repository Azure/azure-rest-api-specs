import "./AnalyticsItems/main.tsp";
import "./ComponentAPIs/main.tsp";
import "./ComponentLinkedStorageAccounts/main.tsp";
import "./Components/main.tsp";
import "./DeletedWorkbooks/main.tsp";
import "./Favorites/main.tsp";
import "./Livetoken/main.tsp";
import "./WebTestLocation/main.tsp";
import "./WebTests/main.tsp";
import "./WorkbookOperations/main.tsp";
import "./Workbooks/main.tsp";
import "./WorkbookTemplates/main.tsp";

using AnalyticsItems;
using ComponentAPIs;
using ComponentLinkedStorageAccountApi;
using Components;
using DeletedWorkbookApi;
using Favorites;
using LiveTokenApi;
using WebTestLocation;
using Microsoft.Insights;
using WorkBookOperations;
using WorkbooksApi;
using WorkbookTemplatesApi;

using Azure.ClientGenerator.Core;

@client({
  name: "ApplicationInsightsManagementClient",
  service: [
    AnalyticsItems,
    ComponentAPIs,
    ComponentLinkedStorageAccountApi,
    Components,
    DeletedWorkbookApi,
    Favorites,
    LiveTokenApi,
    WebTestLocation,
    Microsoft.Insights,
    WorkBookOperations,
    WorkbooksApi,
    WorkbookTemplatesApi
  ],
  autoMergeService: true,
})
namespace ApplicationInsightsManagementClient;

@@clientName(ComponentAPIs.ApplicationInsightsComponentAPIKey,
  "ApplicationInsightsComponentApiKey",
  "java"
);
@@clientName(ComponentAPIs.APIKeyRequest, "ApiKeyRequest", "java");

@@clientLocation(ComponentAPIs.APIKeysOperationGroup.list, "ApiKeys", "java");
@@clientLocation(ComponentAPIs.APIKeysOperationGroup.create, "ApiKeys", "java");
@@clientLocation(ComponentAPIs.APIKeysOperationGroup.delete, "ApiKeys", "java");
@@clientLocation(ComponentAPIs.APIKeysOperationGroup.get, "ApiKeys", "java");

@@clientName(Microsoft.Insights.WebTestPropertiesValidationRules.SSLCheck,
  "sslCheck",
  "java"
);
@@clientName(Microsoft.Insights.WebTestPropertiesValidationRules.SSLCertRemainingLifetimeCheck,
  "sslCertRemainingLifetimeCheck",
  "java"
);
@@clientName(Microsoft.Insights.WebTestPropertiesValidationRules.SSLCheck,
  "sSLCheck",
  "javascript"
);
@@clientName(Microsoft.Insights.WebTestPropertiesValidationRules.SSLCertRemainingLifetimeCheck,
  "sSLCertRemainingLifetimeCheck",
  "javascript"
);
@@clientName(Workbooks.revisionsList, "listRevisionsList", "javascript");
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op replaceListByComponent(
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  componentName: string,
  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
  body: void,
): Microsoft.Insights.webTestListResult;

@@override(WebTestsOperationGroup.listByComponent,
  replaceListByComponent,
  "go"
);
