import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ComponentAPIs;

/**
 * Annotations list result.
 */
model AnnotationsListResult {
  /**
   * An array of annotations.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["Id"])
  value?: Annotation[];

  /** The url to the next page of results. */
  @nextLink
  nextLink?: string;
}

/**
 * Annotation associated with an application insights resource.
 */
model Annotation {
  /**
   * Name of annotation
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AnnotationName?: string;

  /**
   * Category of annotation, free form
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Category?: string;

  /**
   * Time when event occurred
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  EventTime?: utcDateTime;

  /**
   * Unique Id for annotation
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Id?: string;

  /**
   * Serialized JSON object for detailed properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Properties?: string;

  /**
   * Related parent annotation if any
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RelatedAnnotation?: string = "null";
}

/**
 * Error associated with trying to create annotation with Id that already exist
 */
@error
model AnnotationError {
  /**
   * Error detail code and explanation
   */
  code?: string;

  /**
   * Error message
   */
  message?: string;

  /**
   * Inner error
   */
  innererror?: InnerError;
}

/**
 * Inner error
 */
model InnerError {
  /**
   * Provides correlation for request
   */
  diagnosticcontext?: string;

  /**
   * Request time
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

/**
 * Describes the list of API Keys of an Application Insights Component.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationInsightsComponentAPIKeyListResult {
  /**
   * List of API Key definitions.
   */
  @pageItems
  value: ApplicationInsightsComponentAPIKey[];

  /** The url to the next page of results. */
  @nextLink
  nextLink?: string;
}

/**
 * Properties that define an API key of an Application Insights Component.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ApplicationInsightsComponentAPIKey {
  /**
   * The unique ID of the API key inside an Application Insights component. It is auto generated when the API key is created.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The API key value. It will be only return once when the API Key was created.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  apiKey?: string;

  /**
   * The create date of this API key.
   */
  createdDate?: string;

  /**
   * The name of the API key.
   */
  name?: string;

  /**
   * The read access rights of this API Key.
   */
  linkedReadProperties?: string[];

  /**
   * The write access rights of this API Key.
   */
  linkedWriteProperties?: string[];
}

/**
 * An Application Insights component API Key creation request definition.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model APIKeyRequest {
  /**
   * The name of the API Key.
   */
  name?: string;

  /**
   * The read access rights of this API Key.
   */
  linkedReadProperties?: string[];

  /**
   * The write access rights of this API Key.
   */
  linkedWriteProperties?: string[];
}

/**
 * Properties that define a Continuous Export configuration.
 */
model ApplicationInsightsComponentExportConfiguration {
  /**
   * The unique ID of the export configuration inside an Application Insights component. It is auto generated when the Continuous Export configuration is created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ExportId?: string;

  /**
   * The instrumentation key of the Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  InstrumentationKey?: string;

  /**
   * This comma separated list of document types that will be exported. The possible values include 'Requests', 'Event', 'Exceptions', 'Metrics', 'PageViews', 'PageViewPerformance', 'Rdd', 'PerformanceCounters', 'Availability', 'Messages'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RecordTypes?: string;

  /**
   * The name of the Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ApplicationName?: string;

  /**
   * The subscription of the Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  SubscriptionId?: string;

  /**
   * The resource group of the Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ResourceGroup?: string;

  /**
   * The destination storage account subscription ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  DestinationStorageSubscriptionId?: string;

  /**
   * The destination account location ID.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  DestinationStorageLocationId?: string;

  /**
   * The name of destination account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  DestinationAccountId?: string;

  /**
   * The destination type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  DestinationType?: string;

  /**
   * This will be 'true' if the Continuous Export configuration is enabled, otherwise it will be 'false'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  IsUserEnabled?: string;

  /**
   * Last time the Continuous Export configuration was updated.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  LastUserUpdate?: string;

  /**
   * Deprecated
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotificationQueueEnabled?: string;

  /**
   * This indicates current Continuous Export configuration status. The possible values are 'Preparing', 'Success', 'Failure'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ExportStatus?: string;

  /**
   * The last time data was successfully delivered to the destination storage container for this Continuous Export configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  LastSuccessTime?: string;

  /**
   * The last time the Continuous Export configuration started failing.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  LastGapTime?: string;

  /**
   * This is the reason the Continuous Export configuration started failing. It can be 'AzureStorageNotFound' or 'AzureStorageAccessDenied'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  PermanentErrorReason?: string;

  /**
   * The name of the destination storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  StorageName?: string;

  /**
   * The name of the destination storage container.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ContainerName?: string;
}

/**
 * An Application Insights component Continuous Export configuration request definition.
 */
model ApplicationInsightsComponentExportRequest {
  /**
   * The document types to be exported, as comma separated values. Allowed values include 'Requests', 'Event', 'Exceptions', 'Metrics', 'PageViews', 'PageViewPerformance', 'Rdd', 'PerformanceCounters', 'Availability', 'Messages'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  RecordTypes?: string;

  /**
   * The Continuous Export destination type. This has to be 'Blob'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DestinationType?: string;

  /**
   * The SAS URL for the destination storage container. It must grant write permission.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DestinationAddress?: string;

  /**
   * Set to 'true' to create a Continuous Export configuration as enabled, otherwise set it to 'false'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsEnabled?: string;

  /**
   * Deprecated
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotificationQueueEnabled?: string;

  /**
   * Deprecated
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  NotificationQueueUri?: string;

  /**
   * The subscription ID of the destination storage container.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DestinationStorageSubscriptionId?: string;

  /**
   * The location ID of the destination storage container.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DestinationStorageLocationId?: string;

  /**
   * The name of destination storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DestinationAccountId?: string;
}

/**
 * An Application Insights component billing features
 */
model ApplicationInsightsComponentBillingFeatures {
  /**
   * An Application Insights component daily data volume cap
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DataVolumeCap?: ApplicationInsightsComponentDataVolumeCap;

  /**
   * Current enabled pricing plan. When the component is in the Enterprise plan, this will list both 'Basic' and 'Application Insights Enterprise'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  CurrentBillingFeatures?: string[];
}

/**
 * An Application Insights component daily data volume cap
 */
model ApplicationInsightsComponentDataVolumeCap {
  /**
   * Daily data volume cap in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Cap?: float32;

  /**
   * Daily data volume cap UTC reset hour.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ResetTime?: int32;

  /**
   * Reserved, not used for now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WarningThreshold?: int32;

  /**
   * Reserved, not used for now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StopSendNotificationWhenHitThreshold?: boolean;

  /**
   * Do not send a notification email when the daily data volume cap is met.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  StopSendNotificationWhenHitCap?: boolean;

  /**
   * Maximum daily data volume cap that the user can set for this component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  MaxHistoryCap?: float32;
}

/**
 * An Application Insights component daily data volume cap status
 */
model ApplicationInsightsComponentQuotaStatus {
  /**
   * The Application ID for the Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  AppId?: string;

  /**
   * The daily data volume cap is met, and data ingestion will be stopped.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ShouldBeThrottled?: boolean;

  /**
   * Date and time when the daily data volume cap will be reset, and data ingestion will resume.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ExpirationTime?: string;
}

/**
 * An Application Insights component feature capabilities
 */
model ApplicationInsightsComponentFeatureCapabilities {
  /**
   * Whether allow to use continuous export feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  SupportExportData?: boolean;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  BurstThrottlePolicy?: string;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  MetadataClass?: string;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  LiveStreamMetrics?: boolean;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ApplicationMap?: boolean;

  /**
   * Whether allow to use work item integration feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  WorkItemIntegration?: boolean;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  PowerBIIntegration?: boolean;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  OpenSchema?: boolean;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ProactiveDetection?: boolean;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  AnalyticsIntegration?: boolean;

  /**
   * Whether allow to use multiple steps web test feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  MultipleStepWebTest?: boolean;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ApiAccessLevel?: string;

  /**
   * The application insights component used tracking type.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  TrackingType?: string;

  /**
   * Daily data volume cap in GB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  DailyCap?: float32;

  /**
   * Daily data volume cap UTC reset hour.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  DailyCapResetTime?: float32;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ThrottleRate?: float32;
}

/**
 * An Application Insights component available features.
 */
model ApplicationInsightsComponentAvailableFeatures {
  /**
   * A list of Application Insights component feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#["FeatureName"])
  Result?: ApplicationInsightsComponentFeature[];
}

/**
 * An Application Insights component daily data volume cap status
 */
model ApplicationInsightsComponentFeature {
  /**
   * The pricing feature name.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  FeatureName?: string;

  /**
   * The meter id used for the feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  MeterId?: string;

  /**
   * The meter rate for the feature's meter.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  MeterRateFrequency?: string;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  ResouceId?: string;

  /**
   * Reserved, not used now.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  IsHidden?: boolean;

  /**
   * A list of Application Insights component feature capability.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#["Name"])
  Capabilities?: ApplicationInsightsComponentFeatureCapability[];

  /**
   * Display name of the feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Title?: string;

  /**
   * Whether can apply addon feature on to it.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  IsMainFeature?: boolean;

  /**
   * The add on features on main feature.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  SupportedAddonFeatures?: string;
}

/**
 * An Application Insights component feature capability
 */
model ApplicationInsightsComponentFeatureCapability {
  /**
   * The name of the capability.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Name?: string;

  /**
   * The description of the capability.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Description?: string;

  /**
   * The value of the capability.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Value?: string;

  /**
   * The unit of the capability.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  Unit?: string;

  /**
   * The meter used for the capability.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  MeterId?: string;

  /**
   * The meter rate of the meter.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  MeterRateFrequency?: string;
}

/**
 * Properties that define a ProactiveDetection configuration.
 */
model ApplicationInsightsComponentProactiveDetectionConfiguration {
  /**
   * The rule name
   */
  name?: string;

  /**
   * A flag that indicates whether this rule is enabled by the user
   */
  enabled?: boolean;

  /**
   * A flag that indicated whether notifications on this rule should be sent to subscription owners
   */
  sendEmailsToSubscriptionOwners?: boolean;

  /**
   * Custom email addresses for this rule notifications
   */
  customEmails?: string[];

  /**
   * The last time this rule was updated
   */
  lastUpdatedTime?: string;

  /**
   * Static definitions of the ProactiveDetection configuration rule (same values for all components).
   */
  ruleDefinitions?: ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions;
}

/**
 * Static definitions of the ProactiveDetection configuration rule (same values for all components).
 */
model ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions {
  /**
   * The rule name
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Name?: string;

  /**
   * The rule name as it is displayed in UI
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DisplayName?: string;

  /**
   * The rule description
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Description?: string;

  /**
   * URL which displays additional info about the proactive detection rule
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HelpUrl?: string;

  /**
   * A flag indicating whether the rule is hidden (from the UI)
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsHidden?: boolean;

  /**
   * A flag indicating whether the rule is enabled by default
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsEnabledByDefault?: boolean;

  /**
   * A flag indicating whether the rule is in preview
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsInPreview?: boolean;

  /**
   * A flag indicating whether email notifications are supported for detections for this rule
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SupportsEmailNotifications?: boolean;
}

/**
 * Work item configuration list result.
 */
model WorkItemConfigurationsListResult {
  /**
   * An array of work item configurations.
   */
  @visibility(Lifecycle.Read)
  @pageItems
  @identifiers(#["Id"])
  value?: WorkItemConfiguration[];

  /** The url to the next page of results. */
  @nextLink
  nextLink?: string;
}

/**
 * Work item configuration associated with an application insights resource.
 */
model WorkItemConfiguration {
  /**
   * Connector identifier where work item is created
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConnectorId?: string;

  /**
   * Configuration friendly name
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfigDisplayName?: string;

  /**
   * Boolean value indicating whether configuration is default
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  IsDefault?: boolean;

  /**
   * Unique Id for work item
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Id?: string;

  /**
   * Serialized JSON object for detailed properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConfigProperties?: string;
}

/**
 * Error associated with trying to get work item configuration or configurations
 */
@error
model WorkItemConfigurationError {
  /**
   * Error detail code and explanation
   */
  code?: string;

  /**
   * Error message
   */
  message?: string;

  /**
   * Inner error
   */
  innererror?: InnerError;
}

/**
 * Work item configuration creation payload
 */
model WorkItemCreateConfiguration {
  /**
   * Unique connector id
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConnectorId?: string;

  /**
   * Serialized JSON object for detailed properties
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ConnectorDataConfiguration?: string;

  /**
   * Boolean indicating validate only
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidateOnly?: boolean;

  /**
   * Custom work item properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WorkItemProperties?: Record<string>;
}
