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

@@clientName(Components.TagsResource, "ComponentTagsResource", "java");
@@clientName(LiveTokenApi.ErrorResponseLinkedStorage,
  "LiveTokenErrorResponseLinkedStorage",
  "java"
);
@@clientName(LiveTokenApi.ErrorResponseLinkedStorageError,
  "LiveTokenErrorResponseLinkedStorageError",
  "java"
);
@@clientName(DeletedWorkbookApi.CategoryType,
  "DeletedWorkbookCategoryType",
  "java"
);
@@clientName(DeletedWorkbookApi.WorkbookSharedTypeKind,
  "DeletedWorkbookSharedTypeKind",
  "java"
);

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
