import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ComponentAPIs;

// @@clientName(Annotation.AnnotationName, "annotationName");
// @@clientName(Annotation.Category, "category");
// @@clientName(Annotation.EventTime, "eventTime");
// @@clientName(Annotation.Id, "id");
// @@clientName(Annotation.Properties, "properties");
// @@clientName(Annotation.RelatedAnnotation, "relatedAnnotation");

// @@clientName(ApplicationInsightsComponentExportConfiguration.ExportId,
//   "exportId"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.InstrumentationKey,
//   "instrumentationKey"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.RecordTypes,
//   "recordTypes"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.ApplicationName,
//   "applicationName"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.SubscriptionId,
//   "subscriptionId"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.ResourceGroup,
//   "resourceGroup"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.DestinationStorageSubscriptionId,
//   "destinationStorageSubscriptionId"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.DestinationStorageLocationId,
//   "destinationStorageLocationId"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.DestinationAccountId,
//   "destinationAccountId"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.DestinationType,
//   "destinationType"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.LastUserUpdate,
//   "lastUserUpdate"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.NotificationQueueEnabled,
//   "notificationQueueEnabled"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.ExportStatus,
//   "exportStatus"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.LastSuccessTime,
//   "lastSuccessTime"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.LastGapTime,
//   "lastGapTime"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.PermanentErrorReason,
//   "permanentErrorReason"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.StorageName,
//   "storageName"
// );
// @@clientName(ApplicationInsightsComponentExportConfiguration.ContainerName,
//   "containerName"
// );

// @@clientName(ApplicationInsightsComponentExportRequest.RecordTypes,
//   "recordTypes"
// );
// @@clientName(ApplicationInsightsComponentExportRequest.DestinationType,
//   "destinationType"
// );
// @@clientName(ApplicationInsightsComponentExportRequest.DestinationAddress,
//   "destinationAddress"
// );
// @@clientName(ApplicationInsightsComponentExportRequest.NotificationQueueEnabled,
//   "notificationQueueEnabled"
// );
// @@clientName(ApplicationInsightsComponentExportRequest.NotificationQueueUri,
//   "notificationQueueUri"
// );
// @@clientName(ApplicationInsightsComponentExportRequest.DestinationStorageSubscriptionId,
//   "destinationStorageSubscriptionId"
// );
// @@clientName(ApplicationInsightsComponentExportRequest.DestinationStorageLocationId,
//   "destinationStorageLocationId"
// );
// @@clientName(ApplicationInsightsComponentExportRequest.DestinationAccountId,
//   "destinationAccountId"
// );

// @@clientName(ApplicationInsightsComponentBillingFeatures.DataVolumeCap,
//   "dataVolumeCap"
// );
// @@clientName(ApplicationInsightsComponentBillingFeatures.CurrentBillingFeatures,
//   "currentBillingFeatures"
// );

// @@clientName(ApplicationInsightsComponentDataVolumeCap.Cap, "cap");
// @@clientName(ApplicationInsightsComponentDataVolumeCap.ResetTime, "resetTime");
// @@clientName(ApplicationInsightsComponentDataVolumeCap.WarningThreshold,
//   "warningThreshold"
// );
// @@clientName(ApplicationInsightsComponentDataVolumeCap.StopSendNotificationWhenHitThreshold,
//   "stopSendNotificationWhenHitThreshold"
// );
// @@clientName(ApplicationInsightsComponentDataVolumeCap.StopSendNotificationWhenHitCap,
//   "stopSendNotificationWhenHitCap"
// );
// @@clientName(ApplicationInsightsComponentDataVolumeCap.MaxHistoryCap,
//   "maxHistoryCap"
// );

// @@clientName(ApplicationInsightsComponentQuotaStatus.AppId, "appId");
// @@clientName(ApplicationInsightsComponentQuotaStatus.ShouldBeThrottled,
//   "shouldBeThrottled"
// );
// @@clientName(ApplicationInsightsComponentQuotaStatus.ExpirationTime,
//   "expirationTime"
// );

// @@clientName(ApplicationInsightsComponentFeatureCapabilities.SupportExportData,
//   "supportExportData"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.BurstThrottlePolicy,
//   "burstThrottlePolicy"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.MetadataClass,
//   "metadataClass"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.LiveStreamMetrics,
//   "liveStreamMetrics"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.ApplicationMap,
//   "applicationMap"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.WorkItemIntegration,
//   "workItemIntegration"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.PowerBIIntegration,
//   "powerBIIntegration"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.OpenSchema,
//   "openSchema"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.ProactiveDetection,
//   "proactiveDetection"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.AnalyticsIntegration,
//   "analyticsIntegration"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.MultipleStepWebTest,
//   "multipleStepWebTest"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.ApiAccessLevel,
//   "apiAccessLevel"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.TrackingType,
//   "trackingType"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.DailyCap,
//   "dailyCap"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.DailyCapResetTime,
//   "dailyCapResetTime"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapabilities.ThrottleRate,
//   "throttleRate"
// );

// @@clientName(ApplicationInsightsComponentAvailableFeatures.Result, "result");

// @@clientName(ApplicationInsightsComponentFeature.FeatureName, "featureName");
// @@clientName(ApplicationInsightsComponentFeature.MeterId, "meterId");
// @@clientName(ApplicationInsightsComponentFeature.MeterRateFrequency,
//   "meterRateFrequency"
// );
// @@clientName(ApplicationInsightsComponentFeature.ResouceId, "resouceId");
// @@clientName(ApplicationInsightsComponentFeature.Capabilities, "capabilities");
// @@clientName(ApplicationInsightsComponentFeature.Title, "title");
// @@clientName(ApplicationInsightsComponentFeature.SupportedAddonFeatures,
//   "supportedAddonFeatures"
// );

// @@clientName(ApplicationInsightsComponentFeatureCapability.Name, "name");
// @@clientName(ApplicationInsightsComponentFeatureCapability.Description,
//   "description"
// );
// @@clientName(ApplicationInsightsComponentFeatureCapability.Value, "value");
// @@clientName(ApplicationInsightsComponentFeatureCapability.Unit, "unit");
// @@clientName(ApplicationInsightsComponentFeatureCapability.MeterId, "meterId");
// @@clientName(ApplicationInsightsComponentFeatureCapability.MeterRateFrequency,
//   "meterRateFrequency"
// );

// @@clientName(ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions.Name,
//   "name"
// );
// @@clientName(ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions.DisplayName,
//   "displayName"
// );
// @@clientName(ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions.Description,
//   "description"
// );
// @@clientName(ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions.HelpUrl,
//   "helpUrl"
// );
// @@clientName(ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions.SupportsEmailNotifications,
//   "supportsEmailNotifications"
// );

// @@clientName(WorkItemConfiguration.ConnectorId, "connectorId");
// @@clientName(WorkItemConfiguration.ConfigDisplayName, "configDisplayName");
// @@clientName(WorkItemConfiguration.Id, "id");
// @@clientName(WorkItemConfiguration.ConfigProperties, "configProperties");

// @@clientName(WorkItemCreateConfiguration.ConnectorId, "connectorId");
// @@clientName(WorkItemCreateConfiguration.ConnectorDataConfiguration,
//   "connectorDataConfiguration"
// );
// @@clientName(WorkItemCreateConfiguration.ValidateOnly, "validateOnly");
// @@clientName(WorkItemCreateConfiguration.WorkItemProperties,
//   "workItemProperties"
// );

@@clientLocation(AnnotationsOperationGroup.list, "Annotations");
@@clientLocation(AnnotationsOperationGroup.create, "Annotations");
@@clientLocation(AnnotationsOperationGroup.delete, "Annotations");
@@clientLocation(AnnotationsOperationGroup.get, "Annotations");

@@clientLocation(APIKeysOperationGroup.list, "APIKeys");
@@clientLocation(APIKeysOperationGroup.create, "APIKeys");
@@clientLocation(APIKeysOperationGroup.delete, "APIKeys");
@@clientLocation(APIKeysOperationGroup.get, "APIKeys");

@@clientLocation(ExportConfigurationsOperationGroup.list,
  "ExportConfigurations"
);
@@clientLocation(ExportConfigurationsOperationGroup.create,
  "ExportConfigurations"
);
@@clientLocation(ExportConfigurationsOperationGroup.delete,
  "ExportConfigurations"
);
@@clientLocation(ExportConfigurationsOperationGroup.get,
  "ExportConfigurations"
);
@@clientLocation(ExportConfigurationsOperationGroup.update,
  "ExportConfigurations"
);

@@clientLocation(ComponentCurrentBillingFeaturesOperationGroup.get,
  "ComponentCurrentBillingFeatures"
);
@@clientLocation(ComponentCurrentBillingFeaturesOperationGroup.update,
  "ComponentCurrentBillingFeatures"
);

@@clientLocation(ComponentQuotaStatusOperationGroup.get,
  "ComponentQuotaStatus"
);

@@clientLocation(ComponentFeatureCapabilitiesOperationGroup.get,
  "ComponentFeatureCapabilities"
);

@@clientLocation(ComponentAvailableFeaturesOperationGroup.get,
  "ComponentAvailableFeatures"
);

@@clientLocation(ProactiveDetectionConfigurationsOperationGroup.list,
  "ProactiveDetectionConfigurations"
);
@@clientLocation(ProactiveDetectionConfigurationsOperationGroup.get,
  "ProactiveDetectionConfigurations"
);
@@clientLocation(ProactiveDetectionConfigurationsOperationGroup.update,
  "ProactiveDetectionConfigurations"
);

@@clientLocation(WorkItemConfigurationsOperationGroup.list,
  "WorkItemConfigurations"
);
@@clientLocation(WorkItemConfigurationsOperationGroup.create,
  "WorkItemConfigurations"
);
@@clientLocation(WorkItemConfigurationsOperationGroup.getDefault,
  "WorkItemConfigurations"
);
@@clientLocation(WorkItemConfigurationsOperationGroup.delete,
  "WorkItemConfigurations"
);
@@clientLocation(WorkItemConfigurationsOperationGroup.getItem,
  "WorkItemConfigurations"
);
@@clientLocation(WorkItemConfigurationsOperationGroup.updateItem,
  "WorkItemConfigurations"
);
@@clientName(AnnotationsOperationGroup.create::parameters.body,
  "AnnotationProperties"
);
@@clientName(APIKeysOperationGroup.create::parameters.body, "APIKeyProperties");
@@clientName(ComponentCurrentBillingFeaturesOperationGroup.update::parameters.body,
  "BillingFeaturesProperties"
);
@@clientName(ExportConfigurationsOperationGroup.create::parameters.body,
  "ExportProperties"
);
@@clientName(WorkItemConfigurationsOperationGroup.create::parameters.body,
  "WorkItemConfigurationProperties"
);
