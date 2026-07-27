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

@@clientName(
  ComponentAPIs.ApplicationInsightsComponentAPIKey,
  "ApplicationInsightsComponentApiKey",
  "java"
);
@@clientName(ComponentAPIs.APIKeyRequest, "ApiKeyRequest", "java");

@@clientLocation(ComponentAPIs.APIKeysOperationGroup.list, "ApiKeys", "java");
@@clientLocation(ComponentAPIs.APIKeysOperationGroup.create, "ApiKeys", "java");
@@clientLocation(ComponentAPIs.APIKeysOperationGroup.delete, "ApiKeys", "java");
@@clientLocation(ComponentAPIs.APIKeysOperationGroup.get, "ApiKeys", "java");

@@clientName(
  ComponentAPIs.APIKeysOperationGroup.create::parameters.body,
  "apiKeyProperties",
  "java"
);

@@clientName(
  WebTestsApi.WebTestPropertiesValidationRules.SSLCheck,
  "sslCheck",
  "java"
);
@@clientName(
  WebTestsApi.WebTestPropertiesValidationRules.SSLCertRemainingLifetimeCheck,
  "sslCertRemainingLifetimeCheck",
  "java"
);
@@clientName(
  WebTestsApi.WebTestPropertiesValidationRules.SSLCheck,
  "sSLCheck",
  "javascript"
);
@@clientName(
  WebTestsApi.WebTestPropertiesValidationRules.SSLCertRemainingLifetimeCheck,
  "sSLCertRemainingLifetimeCheck",
  "javascript"
);
@@clientName(
  AnalyticsItems.AnalyticsItemsOperationGroup.list::parameters.type,
  "$DO_NOT_NORMALIZE$type",
  "javascript"
);
@@clientName(Workbooks.revisionsList, "listRevisionsList", "javascript");

@@clientLocation(
  webTestLocationsOperationGroup.list,
  "WebTestLocations",
  "python"
);

// ===== C# (csharp) customizations for the .NET mgmt SDK migration =====
// Operation method-name overrides preserve the GA (1.1.0) public surface and avoid
// Get/Delete/Create overload collisions when multiple operation groups project onto
// ApplicationInsightsComponentResource (all share the /components/{resourceName} path).
@@clientName(
  AnalyticsItems.AnalyticsItemsOperationGroup.list,
  "GetAnalyticsItems",
  "csharp"
);
@@clientName(
  AnalyticsItems.AnalyticsItemsOperationGroup.get,
  "GetAnalyticsItem",
  "csharp"
);
@@clientName(
  AnalyticsItems.AnalyticsItemsOperationGroup.put,
  "AddOrUpdateAnalyticsItem",
  "csharp"
);
@@clientName(
  AnalyticsItems.AnalyticsItemsOperationGroup.delete,
  "DeleteAnalyticsItem",
  "csharp"
);
@@clientName(
  ComponentAPIs.AnnotationsOperationGroup.list,
  "GetAnnotations",
  "csharp"
);
@@clientName(
  ComponentAPIs.AnnotationsOperationGroup.get,
  "GetAnnotations",
  "csharp"
);
@@clientName(
  ComponentAPIs.AnnotationsOperationGroup.create,
  "CreateAnnotations",
  "csharp"
);
@@clientName(
  ComponentAPIs.AnnotationsOperationGroup.delete,
  "DeleteAnnotation",
  "csharp"
);
@@clientName(ComponentAPIs.APIKeysOperationGroup.list, "GetApiKeys", "csharp");
@@clientName(ComponentAPIs.APIKeysOperationGroup.get, "GetApiKey", "csharp");
@@clientName(
  ComponentAPIs.APIKeysOperationGroup.create,
  "CreateApiKey",
  "csharp"
);
@@clientName(
  ComponentAPIs.APIKeysOperationGroup.delete,
  "DeleteApiKey",
  "csharp"
);
@@clientName(
  ComponentAPIs.ExportConfigurationsOperationGroup.list,
  "GetExportConfigurations",
  "csharp"
);
@@clientName(
  ComponentAPIs.ExportConfigurationsOperationGroup.get,
  "GetExportConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.ExportConfigurationsOperationGroup.create,
  "CreateExportConfigurations",
  "csharp"
);
@@clientName(
  ComponentAPIs.ExportConfigurationsOperationGroup.delete,
  "DeleteExportConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.ExportConfigurationsOperationGroup.update,
  "UpdateExportConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.ComponentCurrentBillingFeaturesOperationGroup.get,
  "GetComponentCurrentBillingFeature",
  "csharp"
);
@@clientName(
  ComponentAPIs.ComponentCurrentBillingFeaturesOperationGroup.update,
  "UpdateComponentCurrentBillingFeature",
  "csharp"
);
@@clientName(
  ComponentAPIs.ComponentQuotaStatusOperationGroup.get,
  "GetComponentQuotaStatus",
  "csharp"
);
@@clientName(
  ComponentAPIs.ComponentFeatureCapabilitiesOperationGroup.get,
  "GetComponentFeatureCapability",
  "csharp"
);
@@clientName(
  ComponentAPIs.ComponentAvailableFeaturesOperationGroup.get,
  "GetComponentAvailableFeature",
  "csharp"
);
@@clientName(
  ComponentAPIs.ProactiveDetectionConfigurationsOperationGroup.list,
  "GetProactiveDetectionConfigurations",
  "csharp"
);
@@clientName(
  ComponentAPIs.ProactiveDetectionConfigurationsOperationGroup.get,
  "GetProactiveDetectionConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.ProactiveDetectionConfigurationsOperationGroup.update,
  "UpdateProactiveDetectionConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.WorkItemConfigurationsOperationGroup.list,
  "GetWorkItemConfigurations",
  "csharp"
);
@@clientName(
  ComponentAPIs.WorkItemConfigurationsOperationGroup.create,
  "CreateWorkItemConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.WorkItemConfigurationsOperationGroup.getDefault,
  "GetDefaultWorkItemConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.WorkItemConfigurationsOperationGroup.delete,
  "DeleteWorkItemConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.WorkItemConfigurationsOperationGroup.getItem,
  "GetItemWorkItemConfiguration",
  "csharp"
);
@@clientName(
  ComponentAPIs.WorkItemConfigurationsOperationGroup.updateItem,
  "UpdateItemWorkItemConfiguration",
  "csharp"
);
@@clientName(Favorites.FavoritesOperationGroup.list, "GetFavorites", "csharp");
@@clientName(Favorites.FavoritesOperationGroup.get, "GetFavorite", "csharp");
@@clientName(Favorites.FavoritesOperationGroup.add, "AddFavorite", "csharp");
@@clientName(
  Favorites.FavoritesOperationGroup.update,
  "UpdateFavorite",
  "csharp"
);
@@clientName(
  Favorites.FavoritesOperationGroup.delete,
  "DeleteFavorite",
  "csharp"
);

// Enum/model renames port the AutoRest rename-mapping + prepend-rp-prefix so the
// generated type names match the shipped GA (1.1.0) surface. Several of these also
// resolve property-name == type-name collisions on the owning models.
@@clientName(Favorites.FavoriteType, "ComponentFavoriteType", "csharp");
@@clientName(AnalyticsItems.ItemScope, "ComponentItemScope", "csharp");
@@clientName(AnalyticsItems.ItemType, "ComponentItemType", "csharp");
@@clientName(Components.IngestionMode, "ComponentIngestionMode", "csharp");
@@clientName(Components.FlowType, "ComponentFlowType", "csharp");
@@clientName(Components.RequestSource, "ComponentRequestSource", "csharp");
@@clientName(
  Components.PublicNetworkAccessType,
  "ApplicationInsightsPublicNetworkAccessType",
  "csharp"
);
@@clientName(
  Components.ApplicationType,
  "ApplicationInsightsApplicationType",
  "csharp"
);
@@clientName(
  Components.PrivateLinkScopedResource,
  "PrivateLinkScopedResourceReference",
  "csharp"
);

// Property renames that resolve name == base-member collisions on flattened
// tracked-resource models (match the GA auto-disambiguated names).
@@clientName(
  Components.ApplicationInsightsComponentProperties.Name,
  "NamePropertiesName",
  "csharp"
);
@@clientName(
  WorkbooksApi.WorkbookProperties.tags,
  "TagsPropertiesTags",
  "csharp"
);
@@clientName(
  WorkbooksApi.WorkbookPropertiesUpdateParameters.tags,
  "TagsPropertiesTags",
  "csharp"
);
@@clientName(
  DeletedWorkbookApi.DeletedWorkbookProperties.tags,
  "TagsPropertiesTags",
  "csharp"
);

// Model/resource renames porting AutoRest prepend-rp-prefix + rename-mapping so the
// generated type names match the shipped GA (1.1.0) public surface (verified against
// sdk/.../api/Azure.ResourceManager.ApplicationInsights.net8.0.cs).
@@clientName(
  ComponentAPIs.Annotation,
  "ApplicationInsightsAnnotation",
  "csharp"
);
@@clientName(WebTestsApi.WebTest, "ApplicationInsightsWebTest", "csharp");
@@clientName(WorkbooksApi.Workbook, "ApplicationInsightsWorkbook", "csharp");
@@clientName(
  WorkbookTemplatesApi.WorkbookTemplate,
  "ApplicationInsightsWorkbookTemplate",
  "csharp"
);
@@clientName(
  ApplicationInsightsCommonTypes.CategoryType,
  "WorkbookCategoryType",
  "csharp"
);
@@clientName(
  ApplicationInsightsCommonTypes.TagsResource,
  "WebTestComponentTag",
  "csharp"
);
@@clientName(
  ComponentAPIs.APIKeyRequest,
  "ApplicationInsightsApiKeyContent",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentExportRequest,
  "ApplicationInsightsComponentExportContent",
  "csharp"
);
@@clientName(Components.ComponentPurgeBody, "ComponentPurgeContent", "csharp");
@@clientName(
  Components.ComponentPurgeBodyFilters,
  "ComponentPurgeFilters",
  "csharp"
);
@@clientName(
  Components.ComponentPurgeResponse,
  "ComponentPurgeResult",
  "csharp"
);
@@clientName(
  Components.ComponentPurgeStatusResponse,
  "ComponentPurgeStatusResult",
  "csharp"
);
@@clientName(Components.PurgeState, "ComponentPurgeState", "csharp");
@@clientName(WebTestsApi.HeaderField, "WebTestRequestHeaderField", "csharp");
@@clientName(WebTestsApi.WebTestPropertiesRequest, "WebTestRequest", "csharp");
@@clientName(
  WebTestsApi.WebTestPropertiesValidationRules,
  "WebTestValidationRules",
  "csharp"
);
@@clientName(
  WebTestsApi.WebTestPropertiesValidationRulesContentValidation,
  "WebTestContentValidation",
  "csharp"
);
@@clientName(AnalyticsItems.ItemScopePath, "AnalyticsItemScopePath", "csharp");
@@clientName(
  AnalyticsItems.ItemTypeParameter,
  "AnalyticsItemTypeContent",
  "csharp"
);
@@clientName(LiveTokenApi.LiveTokenResponse, "LiveTokenResult", "csharp");

// Resource (SDK class) name overrides. The workbook and its revision share the
// same `Workbook` model, so the emitter names both `WorkbookResource` (duplicate
// accessor). Set an explicit resource-name on each Read op to give them distinct
// GA names and split them into two resources.
@@clientOption(WorkbooksApi.Workbooks.get,
  "resource-name",
  "ApplicationInsightsWorkbook",
  "csharp"
);
@@clientOption(WorkbooksApi.WorkbookOperationGroup.revisionGet,
  "resource-name",
  "ApplicationInsightsWorkbookRevision",
  "csharp"
);

// The Component and WebTest resources were converted as ARM "custom resources" that
// extend a hand-written envelope whose `id` is a plain string (not TrackedResource),
// so the generated resource ctor `: this(client, data.Id)` cannot bind a string to
// the (ArmClient, ResourceIdentifier) ctor. Type `id` as an ARM resource id.
@@alternateType(Components.ComponentsResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(WebTestsApi.WebtestsResource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
