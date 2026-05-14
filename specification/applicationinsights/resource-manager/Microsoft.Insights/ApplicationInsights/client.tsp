import "./AnalyticsItems/main.tsp";
import "./ComponentAPIs/main.tsp";
import "./ComponentLinkedStorageAccountApi/main.tsp";
import "./Components/main.tsp";
import "./DeletedWorkbookApi/main.tsp";
import "./Favorites/main.tsp";
import "./LiveTokenApi/main.tsp";
import "./WebTestLocation/main.tsp";
import "./WebTestsApi/main.tsp";
import "./WorkBookOperations/main.tsp";
import "./WorkbooksApi/main.tsp";
import "./WorkbookTemplatesApi/main.tsp";

using AnalyticsItems;
using ComponentAPIs;
using ComponentLinkedStorageAccountApi;
using Components;
using DeletedWorkbookApi;
using Favorites;
using LiveTokenApi;
using WebTestLocation;
using WebTestsApi;
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
    WebTestsApi,
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

@@clientName(ComponentAPIs.APIKeysOperationGroup.create::parameters.body,
  "apiKeyProperties",
  "java"
);

@@clientName(WebTestsApi.WebTestPropertiesValidationRules.SSLCheck,
  "sslCheck",
  "java"
);
@@clientName(WebTestsApi.WebTestPropertiesValidationRules.SSLCertRemainingLifetimeCheck,
  "sslCertRemainingLifetimeCheck",
  "java"
);
@@clientName(WebTestsApi.WebTestPropertiesValidationRules.SSLCheck,
  "sSLCheck",
  "javascript"
);
@@clientName(WebTestsApi.WebTestPropertiesValidationRules.SSLCertRemainingLifetimeCheck,
  "sSLCertRemainingLifetimeCheck",
  "javascript"
);
@@clientName(AnalyticsItems.AnalyticsItemsOperationGroup.list::parameters.type,
  "$DO_NOT_NORMALIZE$type",
  "javascript"
);
@@clientName(Workbooks.revisionsList, "listRevisionsList", "javascript");

@@clientLocation(webTestLocationsOperationGroup.list,
  "WebTestLocations",
  "python"
);
