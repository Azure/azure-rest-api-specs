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
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Confirmed overload operations: Annotations list/get both map to the GA GetAnnotations method as distinct overloads (different parameters)."
@@clientName(
  ComponentAPIs.AnnotationsOperationGroup.list,
  "GetAnnotations",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Confirmed overload operations: Annotations list/get both map to the GA GetAnnotations method as distinct overloads (different parameters)."
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
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Restore the distinct GA C# resource names for the workbook and its revision, which share the Workbook model."
@@clientOption(
  WorkbooksApi.Workbooks.get,
  "resource-name",
  "ApplicationInsightsWorkbook",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/client-option" "Restore the distinct GA C# resource names for the workbook and its revision, which share the Workbook model."
@@clientOption(
  WorkbooksApi.WorkbookOperationGroup.revisionGet,
  "resource-name",
  "ApplicationInsightsWorkbookRevision",
  "csharp"
);

// ---- Property/enum/operation renames + type hints porting the remaining AutoRest
// rename-mapping to match the GA (1.1.0) public surface. ----

// Boolean/property name renames (Is* prefixes, *InSeconds, *On).
@@clientName(
  Components.ApplicationInsightsComponentProperties.DisableIpMasking,
  "IsDisableIPMasking",
  "csharp"
);
@@clientName(
  Components.ApplicationInsightsComponentProperties.ImmediatePurgeDataOn30Days,
  "IsImmediatePurgeDataOn30Days",
  "csharp"
);
@@clientName(
  Components.ApplicationInsightsComponentProperties.DisableLocalAuth,
  "IsDisableLocalAuth",
  "csharp"
);
@@clientName(
  Components.ApplicationInsightsComponentProperties.ForceCustomerStorageForProfiler,
  "IsForceCustomerStorageForProfiler",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentDataVolumeCap.StopSendNotificationWhenHitThreshold,
  "IsStopSendNotificationWhenHitThreshold",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentDataVolumeCap.StopSendNotificationWhenHitCap,
  "IsStopSendNotificationWhenHitCap",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentProactiveDetectionConfiguration.enabled,
  "IsEnabled",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentProactiveDetectionConfiguration.lastUpdatedTime,
  "LastUpdatedOn",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentFeatureCapabilities.SupportExportData,
  "IsExportDataSupported",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions.SupportsEmailNotifications,
  "IsEmailNotificationsSupported",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentExportConfiguration.NotificationQueueEnabled,
  "IsNotificationQueueEnabled",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentExportConfiguration.LastUserUpdate,
  "LastUserUpdatedOn",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentExportConfiguration.LastSuccessTime,
  "LastSucceededOn",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentExportConfiguration.LastGapTime,
  "LastGappedOn",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentExportRequest.NotificationQueueEnabled,
  "IsNotificationQueueEnabled",
  "csharp"
);
@@clientName(ComponentAPIs.Annotation.EventTime, "EventOccurredOn", "csharp");
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentAPIKey.createdDate,
  "CreatedOn",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentFeature.ResouceId,
  "ResourceId",
  "csharp"
);
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentQuotaStatus.ExpirationTime,
  "ExpireOn",
  "csharp"
);
@@clientName(
  ComponentAPIs.WorkItemCreateConfiguration.ValidateOnly,
  "IsValidateOnly",
  "csharp"
);
@@clientName(
  Favorites.ApplicationInsightsComponentFavorite.TimeModified,
  "ModifiedOn",
  "csharp"
);
@@clientName(WebTestsApi.WebTestProperties.Enabled, "IsEnabled", "csharp");
@@clientName(
  WebTestsApi.WebTestProperties.Frequency,
  "FrequencyInSeconds",
  "csharp"
);
@@clientName(
  WebTestsApi.WebTestProperties.Timeout,
  "TimeoutInSeconds",
  "csharp"
);
@@clientName(
  WebTestsApi.WebTestProperties.RetryEnabled,
  "IsRetryEnabled",
  "csharp"
);
@@clientName(
  WebTestsApi.WebTestPropertiesValidationRules.SSLCheck,
  "CheckSsl",
  "csharp"
);
@@clientName(
  WebTestsApi.WebTestPropertiesValidationRules.SSLCertRemainingLifetimeCheck,
  "SslCertRemainingLifetimeCheck",
  "csharp"
);
@@clientName(
  AnalyticsItems.ApplicationInsightsComponentAnalyticsItem.TimeCreated,
  "CreatedOn",
  "csharp"
);
@@clientName(
  AnalyticsItems.ApplicationInsightsComponentAnalyticsItem.TimeModified,
  "ModifiedOn",
  "csharp"
);
@@clientName(
  AnalyticsItems.ApplicationInsightsComponentAnalyticsItem.Type,
  "ComponentItemType",
  "csharp"
);
@@clientName(
  WorkbooksApi.WorkbookProperties.timeModified,
  "ModifiedOn",
  "csharp"
);
@@clientName(WorkbooksApi.WorkbookProperties.sourceId, "SourceId", "csharp");
@@clientName(
  WorkbooksApi.WorkbookProperties.storageUri,
  "StorageUri",
  "csharp"
);
@@clientName(
  WorkbookTemplatesApi.WorkbookTemplateGallery.type,
  "WorkbookType",
  "csharp"
);
@@clientName(Components.ApplicationInsightsComponent.etag, "ETag", "csharp");
@@clientName(WorkbooksApi.Workbook.etag, "ETag", "csharp");
@@clientName(
  ComponentAPIs.ApplicationInsightsComponentAPIKey,
  "ApplicationInsightsComponentApiKey",
  "csharp"
);

// Enum member renames.
@@clientName(WebTestsApi.WebTestKind.multistep, "MultiStep", "csharp");
@@clientName(ApplicationInsightsCommonTypes.CategoryType.TSG, "Tsg", "csharp");
@@clientName(
  AnalyticsItems.ItemScopePath.myanalyticsItems,
  "MyAnalyticsItems",
  "csharp"
);

// Operation method-name renames (component convenience list ops + live token).
@@clientName(
  WebTestsApi.WebTestsOperationGroup.listByComponent,
  "GetWebTests",
  "csharp"
);
@@clientName(
  WebTestLocation.webTestLocationsOperationGroup.list,
  "GetWebTestLocations",
  "csharp"
);
@@clientName(
  LiveTokenApi.LiveTokenOperationGroup.get,
  "GetLiveToken",
  "csharp"
);

// Type hints: string -> DateTimeOffset (utcDateTime), ARM id, Guid, Uri, ETag.
@@alternateType(
  ComponentAPIs.ApplicationInsightsComponentProactiveDetectionConfiguration.lastUpdatedTime,
  utcDateTime,
  "csharp"
);
@@alternateType(
  ComponentAPIs.ApplicationInsightsComponentExportConfiguration.LastUserUpdate,
  utcDateTime,
  "csharp"
);
@@alternateType(
  ComponentAPIs.ApplicationInsightsComponentExportConfiguration.LastSuccessTime,
  utcDateTime,
  "csharp"
);
@@alternateType(
  ComponentAPIs.ApplicationInsightsComponentExportConfiguration.LastGapTime,
  utcDateTime,
  "csharp"
);
@@alternateType(
  ComponentAPIs.ApplicationInsightsComponentAPIKey.createdDate,
  utcDateTime,
  "csharp"
);
@@alternateType(
  ComponentAPIs.ApplicationInsightsComponentQuotaStatus.ExpirationTime,
  utcDateTime,
  "csharp"
);
@@alternateType(
  Favorites.ApplicationInsightsComponentFavorite.TimeModified,
  utcDateTime,
  "csharp"
);
@@alternateType(
  AnalyticsItems.ApplicationInsightsComponentAnalyticsItem.TimeCreated,
  utcDateTime,
  "csharp"
);
@@alternateType(
  AnalyticsItems.ApplicationInsightsComponentAnalyticsItem.TimeModified,
  utcDateTime,
  "csharp"
);
@@alternateType(
  Components.ApplicationInsightsComponentProperties.WorkspaceResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ComponentAPIs.ApplicationInsightsComponentFeature.ResouceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  WorkbooksApi.WorkbookProperties.sourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  Components.ApplicationInsightsComponentProperties.TenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(WorkbooksApi.WorkbookProperties.storageUri, url, "csharp");
@@alternateType(
  Components.ApplicationInsightsComponent.etag,
  Azure.Core.eTag,
  "csharp"
);
@@alternateType(WorkbooksApi.Workbook.etag, Azure.Core.eTag, "csharp");

// Workbook identity: GA exposes the standard ManagedServiceIdentity envelope, not the
// converted custom WorkbookResourceIdentity model.
@@alternateType(
  WorkbooksApi.Workbook.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);

// ===== Mgmt SDK review-comment resolutions (pullrequestreview-4816674351) =====
// [RESNAME001] DeletedWorkbookResource derives from TrackedResource, so it must use the
// `Data` suffix, not `Resource` (which is reserved for ArmResource subclasses).
@@clientName(
  DeletedWorkbookApi.DeletedWorkbookResource,
  "DeletedWorkbookData",
  "csharp"
);
// [TYPE002] etag should surface as the Azure.ETag struct, matching the Component/Workbook etag.
@@clientName(DeletedWorkbookApi.DeletedWorkbookResource.etag, "ETag", "csharp");
@@alternateType(
  DeletedWorkbookApi.DeletedWorkbookResource.etag,
  Azure.Core.eTag,
  "csharp"
);
// [CONTEXT] StorageType is too generic; add ApplicationInsights linked-storage context.
@@clientName(
  ComponentLinkedStorageAccountApi.StorageType,
  "ApplicationInsightsLinkedStorageType",
  "csharp"
);
// [DATE001] DateTimeOffset property should end with `On` (matches WorkbookProperties.timeModified).
@@clientName(
  DeletedWorkbookApi.DeletedWorkbookProperties.timeModified,
  "ModifiedOn",
  "csharp"
);
// [TYPE] sourceId -> ResourceIdentifier, storageUri -> Uri (matches WorkbookProperties).
@@alternateType(
  DeletedWorkbookApi.DeletedWorkbookProperties.sourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DeletedWorkbookApi.DeletedWorkbookProperties.storageUri,
  url,
  "csharp"
);
