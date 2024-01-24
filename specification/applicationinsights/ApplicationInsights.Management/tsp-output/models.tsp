import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Type of application being monitored.
 */
enum ApplicationType {
  web,
  other,
}

/**
 * Used by the Application Insights system to determine what kind of flow this component was created by. This is to be set to 'Bluefield' when creating/updating a component via the REST API.
 */
enum FlowType {
  Bluefield,
}

/**
 * Describes what tool created this Application Insights component. Customers using this API should set this to the default 'rest'.
 */
enum RequestSource {
  rest,
}

/**
 * The network access type for operating on the Application Insights Component. By default it is Enabled
 */
enum PublicNetworkAccessType {
  /**
   * Enables connectivity to Application Insights through public DNS.
   */
  Enabled,

  /**
   * Disables public connectivity to Application Insights through public DNS.
   */
  Disabled,
}

/**
 * Indicates the flow of the ingestion.
 */
enum IngestionMode {
  ApplicationInsights,
  ApplicationInsightsWithDiagnosticSettings,
  LogAnalytics,
}

/**
 * Status of the operation represented by the requested Id.
 */
enum PurgeState {
  pending,
  completed,
}

enum FavoriteSourceType {
  retention,
  notebook,
  sessions,
  events,
  userflows,
  funnel,
  impact,
  segmentation,
}

enum ItemScopePath {
  analyticsItems,
  myanalyticsItems,
}

/**
 * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
 */
enum ItemScope {
  shared,
  user,
}

enum ItemTypeParameter {
  none,
  query,
  function,
  folder,
  recent,
}

/**
 * Enum indicating the type of the Analytics item.
 */
enum ItemType {
  none,
  query,
  recent,
  function,
}

enum CategoryType {
  workbook,
  TSG,
  performance,
  retention,
}

/**
 * The kind of workbook. Choices are user and shared.
 */
enum Kind {
  user,
  shared,
}

/**
 * The identity type.
 */
enum MyWorkbookManagedIdentityType {
  UserAssigned,
  None,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The kind of workbook. Only valid value is shared.
 */
enum WorkbookSharedTypeKind {
  shared,
}

/**
 * The kind of workbook. Only valid value is shared.
 */
enum WorkbookUpdateSharedTypeKind {
  shared,
}

enum StorageType {
  ServiceProfiler,
}

/**
 * Enum indicating if this favorite definition is owned by a specific user or is shared between all users with access to the Application Insights component.
 */
@fixed
enum FavoriteType {
  shared,
  user,
}

/**
 * The kind of WebTest that this web test watches. Choices are ping, multistep and standard.
 */
@fixed
enum WebTestKind {
  ping,
  multistep,
  standard,
}

/**
 * Properties that define an Application Insights component resource.
 */
model ApplicationInsightsComponentProperties {
  /**
   * The unique ID of your application. This field mirrors the 'Name' field and cannot be changed.
   */
  @visibility("read")
  @projectedName("json", "ApplicationId")
  applicationId?: string;

  /**
   * Application Insights Unique ID for your Application.
   */
  @visibility("read")
  @projectedName("json", "AppId")
  appId?: string;

  /**
   * Application name.
   */
  @visibility("read")
  @projectedName("json", "Name")
  name?: string;

  /**
   * Type of application being monitored.
   */
  @visibility("read", "create")
  @projectedName("json", "Application_Type")
  applicationType: ApplicationType = ApplicationType.web;

  /**
   * Used by the Application Insights system to determine what kind of flow this component was created by. This is to be set to 'Bluefield' when creating/updating a component via the REST API.
   */
  @projectedName("json", "Flow_Type")
  flowType?: FlowType = FlowType.Bluefield;

  /**
   * Describes what tool created this Application Insights component. Customers using this API should set this to the default 'rest'.
   */
  @projectedName("json", "Request_Source")
  requestSource?: RequestSource = RequestSource.rest;

  /**
   * Application Insights Instrumentation key. A read-only value that applications can use to identify the destination for all telemetry sent to Azure Application Insights. This value will be supplied upon construction of each new Application Insights component.
   */
  @visibility("read")
  @projectedName("json", "InstrumentationKey")
  instrumentationKey?: string;

  /**
   * Creation Date for the Application Insights component, in ISO 8601 format.
   */
  @visibility("read")
  @projectedName("json", "CreationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  /**
   * Azure Tenant Id.
   */
  @visibility("read")
  @projectedName("json", "TenantId")
  tenantId?: string;

  /**
   * The unique application ID created when a new application is added to HockeyApp, used for communications with HockeyApp.
   */
  @projectedName("json", "HockeyAppId")
  hockeyAppId?: string;

  /**
   * Token used to authenticate communications with between Application Insights and HockeyApp.
   */
  @visibility("read")
  @projectedName("json", "HockeyAppToken")
  hockeyAppToken?: string;

  /**
   * Current state of this component: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Percentage of the data produced by the application being monitored that is being sampled for Application Insights telemetry.
   */
  @projectedName("json", "SamplingPercentage")
  samplingPercentage?: float64;

  /**
   * Application Insights component connection string.
   */
  @visibility("read")
  @projectedName("json", "ConnectionString")
  connectionString?: string;

  /**
   * Retention period in days.
   */
  @projectedName("json", "RetentionInDays")
  retentionInDays?: int32;

  /**
   * Disable IP masking.
   */
  @projectedName("json", "DisableIpMasking")
  disableIpMasking?: boolean;

  /**
   * Purge data immediately after 30 days.
   */
  @projectedName("json", "ImmediatePurgeDataOn30Days")
  immediatePurgeDataOn30Days?: boolean;

  /**
   * Resource Id of the log analytics workspace which the data will be ingested to. This property is required to create an application with this API version. Applications from older versions will not have this property.
   */
  @projectedName("json", "WorkspaceResourceId")
  workspaceResourceId?: string;

  /**
   * The date which the component got migrated to LA, in ISO 8601 format.
   */
  @visibility("read")
  @projectedName("json", "LaMigrationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  laMigrationDate?: utcDateTime;

  /**
   * List of linked private link scope resources.
   */
  @visibility("read")
  @projectedName("json", "PrivateLinkScopedResources")
  privateLinkScopedResources?: PrivateLinkScopedResource[];

  /**
   * The network access type for accessing Application Insights ingestion.
   */
  publicNetworkAccessForIngestion?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * The network access type for accessing Application Insights query.
   */
  publicNetworkAccessForQuery?: PublicNetworkAccessType = PublicNetworkAccessType.Enabled;

  /**
   * Indicates the flow of the ingestion.
   */
  @projectedName("json", "IngestionMode")
  ingestionMode?: IngestionMode = IngestionMode.LogAnalytics;

  /**
   * Disable Non-AAD based Auth.
   */
  @projectedName("json", "DisableLocalAuth")
  disableLocalAuth?: boolean;

  /**
   * Force users to create their own storage account for profiler and debugger.
   */
  @projectedName("json", "ForceCustomerStorageForProfiler")
  forceCustomerStorageForProfiler?: boolean;
}

/**
 * The private link scope resource reference.
 */
model PrivateLinkScopedResource {
  /**
   * The full resource Id of the private link scope resource.
   */
  @projectedName("json", "ResourceId")
  resourceId?: string;

  /**
   * The private link scope unique Identifier.
   */
  @projectedName("json", "ScopeId")
  scopeId?: string;
}

/**
 * An azure resource object
 */
model ComponentsResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

@error
model ErrorResponseComponents {
  /**
   * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
   */
  error?: ErrorResponseComponentsError;
}

/**
 * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
 */
model ErrorResponseComponentsError {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;
}

/**
 * A container holding only the Tags for a resource, allowing the user to update the tags on a WebTest instance.
 */
model TagsResource {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Describes the body of a purge request for an App Insights component
 */
model ComponentPurgeBody {
  /**
   * Table from which to purge data.
   */
  table: string;

  /**
   * The set of columns and filters (queries) to run over them to purge the resulting data.
   */
  filters: ComponentPurgeBodyFilters[];
}

/**
 * User-defined filters to return data which will be purged from the table.
 */
model ComponentPurgeBodyFilters {
  /**
   * The column of the table over which the given query should run
   */
  column?: string;

  /**
   * A query operator to evaluate over the provided column and value(s). Supported operators are ==, =~, in, in~, >, >=, <, <=, between, and have the same behavior as they would in a KQL query.
   */
  operator?: string;

  /**
   * the value for the operator to function over. This can be a number (e.g., > 100), a string (timestamp >= '2017-09-01') or array of values.
   */
  value?: unknown;

  /**
   * When filtering over custom dimensions, this key will be used as the name of the custom dimension.
   */
  key?: string;
}

/**
 * Response containing operationId for a specific purge action.
 */
model ComponentPurgeResponse {
  /**
   * Id to use when querying for status for a particular purge operation.
   */
  operationId: string;
}

/**
 * Response containing status for a specific purge operation.
 */
model ComponentPurgeStatusResponse {
  /**
   * Status of the operation represented by the requested Id.
   */
  status: PurgeState;
}

/**
 * Annotations list result.
 */
@pagedResult
model AnnotationsListResult {
  /**
   * An array of annotations.
   */
  @visibility("read")
  @items
  value?: Annotation[];
}

/**
 * Annotation associated with an application insights resource.
 */
model Annotation {
  /**
   * Name of annotation
   */
  @projectedName("json", "AnnotationName")
  annotationName?: string;

  /**
   * Category of annotation, free form
   */
  @projectedName("json", "Category")
  category?: string;

  /**
   * Time when event occurred
   */
  @projectedName("json", "EventTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  /**
   * Unique Id for annotation
   */
  @projectedName("json", "Id")
  id?: string;

  /**
   * Serialized JSON object for detailed properties
   */
  @projectedName("json", "Properties")
  properties?: string;

  /**
   * Related parent annotation if any
   */
  @projectedName("json", "RelatedAnnotation")
  relatedAnnotation?: string = "null";
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
@pagedResult
model ApplicationInsightsComponentAPIKeyListResult {
  /**
   * List of API Key definitions.
   */
  @items
  value: ApplicationInsightsComponentAPIKey[];
}

/**
 * Properties that define an API key of an Application Insights Component.
 */
model ApplicationInsightsComponentAPIKey {
  /**
   * The unique ID of the API key inside an Application Insights component. It is auto generated when the API key is created.
   */
  @visibility("read")
  id?: string;

  /**
   * The API key value. It will be only return once when the API Key was created.
   */
  @visibility("read")
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
  @visibility("read")
  @projectedName("json", "ExportId")
  exportId?: string;

  /**
   * The instrumentation key of the Application Insights component.
   */
  @visibility("read")
  @projectedName("json", "InstrumentationKey")
  instrumentationKey?: string;

  /**
   * This comma separated list of document types that will be exported. The possible values include 'Requests', 'Event', 'Exceptions', 'Metrics', 'PageViews', 'PageViewPerformance', 'Rdd', 'PerformanceCounters', 'Availability', 'Messages'.
   */
  @projectedName("json", "RecordTypes")
  recordTypes?: string;

  /**
   * The name of the Application Insights component.
   */
  @visibility("read")
  @projectedName("json", "ApplicationName")
  applicationName?: string;

  /**
   * The subscription of the Application Insights component.
   */
  @visibility("read")
  @projectedName("json", "SubscriptionId")
  subscriptionId?: string;

  /**
   * The resource group of the Application Insights component.
   */
  @visibility("read")
  @projectedName("json", "ResourceGroup")
  resourceGroup?: string;

  /**
   * The destination storage account subscription ID.
   */
  @visibility("read")
  @projectedName("json", "DestinationStorageSubscriptionId")
  destinationStorageSubscriptionId?: string;

  /**
   * The destination account location ID.
   */
  @visibility("read")
  @projectedName("json", "DestinationStorageLocationId")
  destinationStorageLocationId?: string;

  /**
   * The name of destination account.
   */
  @visibility("read")
  @projectedName("json", "DestinationAccountId")
  destinationAccountId?: string;

  /**
   * The destination type.
   */
  @visibility("read")
  @projectedName("json", "DestinationType")
  destinationType?: string;

  /**
   * This will be 'true' if the Continuous Export configuration is enabled, otherwise it will be 'false'.
   */
  @visibility("read")
  IsUserEnabled?: string;

  /**
   * Last time the Continuous Export configuration was updated.
   */
  @visibility("read")
  @projectedName("json", "LastUserUpdate")
  lastUserUpdate?: string;

  /**
   * Deprecated
   */
  @projectedName("json", "NotificationQueueEnabled")
  notificationQueueEnabled?: string;

  /**
   * This indicates current Continuous Export configuration status. The possible values are 'Preparing', 'Success', 'Failure'.
   */
  @visibility("read")
  @projectedName("json", "ExportStatus")
  exportStatus?: string;

  /**
   * The last time data was successfully delivered to the destination storage container for this Continuous Export configuration.
   */
  @visibility("read")
  @projectedName("json", "LastSuccessTime")
  lastSuccessTime?: string;

  /**
   * The last time the Continuous Export configuration started failing.
   */
  @visibility("read")
  @projectedName("json", "LastGapTime")
  lastGapTime?: string;

  /**
   * This is the reason the Continuous Export configuration started failing. It can be 'AzureStorageNotFound' or 'AzureStorageAccessDenied'.
   */
  @visibility("read")
  @projectedName("json", "PermanentErrorReason")
  permanentErrorReason?: string;

  /**
   * The name of the destination storage account.
   */
  @visibility("read")
  @projectedName("json", "StorageName")
  storageName?: string;

  /**
   * The name of the destination storage container.
   */
  @visibility("read")
  @projectedName("json", "ContainerName")
  containerName?: string;
}

/**
 * An Application Insights component Continuous Export configuration request definition.
 */
model ApplicationInsightsComponentExportRequest {
  /**
   * The document types to be exported, as comma separated values. Allowed values include 'Requests', 'Event', 'Exceptions', 'Metrics', 'PageViews', 'PageViewPerformance', 'Rdd', 'PerformanceCounters', 'Availability', 'Messages'.
   */
  @projectedName("json", "RecordTypes")
  recordTypes?: string;

  /**
   * The Continuous Export destination type. This has to be 'Blob'.
   */
  @projectedName("json", "DestinationType")
  destinationType?: string;

  /**
   * The SAS URL for the destination storage container. It must grant write permission.
   */
  @projectedName("json", "DestinationAddress")
  destinationAddress?: string;

  /**
   * Set to 'true' to create a Continuous Export configuration as enabled, otherwise set it to 'false'.
   */
  IsEnabled?: string;

  /**
   * Deprecated
   */
  @projectedName("json", "NotificationQueueEnabled")
  notificationQueueEnabled?: string;

  /**
   * Deprecated
   */
  @projectedName("json", "NotificationQueueUri")
  notificationQueueUri?: string;

  /**
   * The subscription ID of the destination storage container.
   */
  @projectedName("json", "DestinationStorageSubscriptionId")
  destinationStorageSubscriptionId?: string;

  /**
   * The location ID of the destination storage container.
   */
  @projectedName("json", "DestinationStorageLocationId")
  destinationStorageLocationId?: string;

  /**
   * The name of destination storage account.
   */
  @projectedName("json", "DestinationAccountId")
  destinationAccountId?: string;
}

/**
 * An Application Insights component billing features
 */
model ApplicationInsightsComponentBillingFeatures {
  /**
   * An Application Insights component daily data volume cap
   */
  @projectedName("json", "DataVolumeCap")
  dataVolumeCap?: ApplicationInsightsComponentDataVolumeCap;

  /**
   * Current enabled pricing plan. When the component is in the Enterprise plan, this will list both 'Basic' and 'Application Insights Enterprise'.
   */
  @projectedName("json", "CurrentBillingFeatures")
  currentBillingFeatures?: string[];
}

/**
 * An Application Insights component daily data volume cap
 */
model ApplicationInsightsComponentDataVolumeCap {
  /**
   * Daily data volume cap in GB.
   */
  @projectedName("json", "Cap")
  cap?: float32;

  /**
   * Daily data volume cap UTC reset hour.
   */
  @visibility("read")
  @projectedName("json", "ResetTime")
  resetTime?: int32;

  /**
   * Reserved, not used for now.
   */
  @projectedName("json", "WarningThreshold")
  warningThreshold?: int32;

  /**
   * Reserved, not used for now.
   */
  @projectedName("json", "StopSendNotificationWhenHitThreshold")
  stopSendNotificationWhenHitThreshold?: boolean;

  /**
   * Do not send a notification email when the daily data volume cap is met.
   */
  @projectedName("json", "StopSendNotificationWhenHitCap")
  stopSendNotificationWhenHitCap?: boolean;

  /**
   * Maximum daily data volume cap that the user can set for this component.
   */
  @visibility("read")
  @projectedName("json", "MaxHistoryCap")
  maxHistoryCap?: float32;
}

/**
 * An Application Insights component daily data volume cap status
 */
model ApplicationInsightsComponentQuotaStatus {
  /**
   * The Application ID for the Application Insights component.
   */
  @visibility("read")
  @projectedName("json", "AppId")
  appId?: string;

  /**
   * The daily data volume cap is met, and data ingestion will be stopped.
   */
  @visibility("read")
  @projectedName("json", "ShouldBeThrottled")
  shouldBeThrottled?: boolean;

  /**
   * Date and time when the daily data volume cap will be reset, and data ingestion will resume.
   */
  @visibility("read")
  @projectedName("json", "ExpirationTime")
  expirationTime?: string;
}

/**
 * An Application Insights component feature capabilities
 */
model ApplicationInsightsComponentFeatureCapabilities {
  /**
   * Whether allow to use continuous export feature.
   */
  @visibility("read")
  @projectedName("json", "SupportExportData")
  supportExportData?: boolean;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "BurstThrottlePolicy")
  burstThrottlePolicy?: string;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "MetadataClass")
  metadataClass?: string;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "LiveStreamMetrics")
  liveStreamMetrics?: boolean;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "ApplicationMap")
  applicationMap?: boolean;

  /**
   * Whether allow to use work item integration feature.
   */
  @visibility("read")
  @projectedName("json", "WorkItemIntegration")
  workItemIntegration?: boolean;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "PowerBIIntegration")
  powerBIIntegration?: boolean;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "OpenSchema")
  openSchema?: boolean;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "ProactiveDetection")
  proactiveDetection?: boolean;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "AnalyticsIntegration")
  analyticsIntegration?: boolean;

  /**
   * Whether allow to use multiple steps web test feature.
   */
  @visibility("read")
  @projectedName("json", "MultipleStepWebTest")
  multipleStepWebTest?: boolean;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "ApiAccessLevel")
  apiAccessLevel?: string;

  /**
   * The application insights component used tracking type.
   */
  @visibility("read")
  @projectedName("json", "TrackingType")
  trackingType?: string;

  /**
   * Daily data volume cap in GB.
   */
  @visibility("read")
  @projectedName("json", "DailyCap")
  dailyCap?: float32;

  /**
   * Daily data volume cap UTC reset hour.
   */
  @visibility("read")
  @projectedName("json", "DailyCapResetTime")
  dailyCapResetTime?: float32;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "ThrottleRate")
  throttleRate?: float32;
}

/**
 * An Application Insights component available features.
 */
model ApplicationInsightsComponentAvailableFeatures {
  /**
   * A list of Application Insights component feature.
   */
  @visibility("read")
  @projectedName("json", "Result")
  result?: ApplicationInsightsComponentFeature[];
}

/**
 * An Application Insights component daily data volume cap status
 */
model ApplicationInsightsComponentFeature {
  /**
   * The pricing feature name.
   */
  @visibility("read")
  @projectedName("json", "FeatureName")
  featureName?: string;

  /**
   * The meter id used for the feature.
   */
  @visibility("read")
  @projectedName("json", "MeterId")
  meterId?: string;

  /**
   * The meter rate for the feature's meter.
   */
  @visibility("read")
  @projectedName("json", "MeterRateFrequency")
  meterRateFrequency?: string;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  @projectedName("json", "ResouceId")
  resouceId?: string;

  /**
   * Reserved, not used now.
   */
  @visibility("read")
  IsHidden?: boolean;

  /**
   * A list of Application Insights component feature capability.
   */
  @visibility("read")
  @projectedName("json", "Capabilities")
  capabilities?: ApplicationInsightsComponentFeatureCapability[];

  /**
   * Display name of the feature.
   */
  @visibility("read")
  @projectedName("json", "Title")
  title?: string;

  /**
   * Whether can apply addon feature on to it.
   */
  @visibility("read")
  IsMainFeature?: boolean;

  /**
   * The add on features on main feature.
   */
  @visibility("read")
  @projectedName("json", "SupportedAddonFeatures")
  supportedAddonFeatures?: string;
}

/**
 * An Application Insights component feature capability
 */
model ApplicationInsightsComponentFeatureCapability {
  /**
   * The name of the capability.
   */
  @visibility("read")
  @projectedName("json", "Name")
  name?: string;

  /**
   * The description of the capability.
   */
  @visibility("read")
  @projectedName("json", "Description")
  description?: string;

  /**
   * The value of the capability.
   */
  @visibility("read")
  @projectedName("json", "Value")
  value?: string;

  /**
   * The unit of the capability.
   */
  @visibility("read")
  @projectedName("json", "Unit")
  unit?: string;

  /**
   * The meter used for the capability.
   */
  @visibility("read")
  @projectedName("json", "MeterId")
  meterId?: string;

  /**
   * The meter rate of the meter.
   */
  @visibility("read")
  @projectedName("json", "MeterRateFrequency")
  meterRateFrequency?: string;
}

/**
 * Properties that define a ProactiveDetection configuration.
 */
model ApplicationInsightsComponentProactiveDetectionConfiguration {
  /**
   * The rule name
   */
  @projectedName("json", "Name")
  name?: string;

  /**
   * A flag that indicates whether this rule is enabled by the user
   */
  @projectedName("json", "Enabled")
  enabled?: boolean;

  /**
   * A flag that indicated whether notifications on this rule should be sent to subscription owners
   */
  @projectedName("json", "SendEmailsToSubscriptionOwners")
  sendEmailsToSubscriptionOwners?: boolean;

  /**
   * Custom email addresses for this rule notifications
   */
  @projectedName("json", "CustomEmails")
  customEmails?: string[];

  /**
   * The last time this rule was updated
   */
  @projectedName("json", "LastUpdatedTime")
  lastUpdatedTime?: string;

  /**
   * Static definitions of the ProactiveDetection configuration rule (same values for all components).
   */
  @projectedName("json", "RuleDefinitions")
  ruleDefinitions?: ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions;
}

/**
 * Static definitions of the ProactiveDetection configuration rule (same values for all components).
 */
model ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions {
  /**
   * The rule name
   */
  @projectedName("json", "Name")
  name?: string;

  /**
   * The rule name as it is displayed in UI
   */
  @projectedName("json", "DisplayName")
  displayName?: string;

  /**
   * The rule description
   */
  @projectedName("json", "Description")
  description?: string;

  /**
   * URL which displays additional info about the proactive detection rule
   */
  @projectedName("json", "HelpUrl")
  helpUrl?: string;

  /**
   * A flag indicating whether the rule is hidden (from the UI)
   */
  IsHidden?: boolean;

  /**
   * A flag indicating whether the rule is enabled by default
   */
  IsEnabledByDefault?: boolean;

  /**
   * A flag indicating whether the rule is in preview
   */
  IsInPreview?: boolean;

  /**
   * A flag indicating whether email notifications are supported for detections for this rule
   */
  @projectedName("json", "SupportsEmailNotifications")
  supportsEmailNotifications?: boolean;
}

/**
 * Work item configuration list result.
 */
@pagedResult
model WorkItemConfigurationsListResult {
  /**
   * An array of work item configurations.
   */
  @visibility("read")
  @items
  value?: WorkItemConfiguration[];
}

/**
 * Work item configuration associated with an application insights resource.
 */
model WorkItemConfiguration {
  /**
   * Connector identifier where work item is created
   */
  @projectedName("json", "ConnectorId")
  connectorId?: string;

  /**
   * Configuration friendly name
   */
  @projectedName("json", "ConfigDisplayName")
  configDisplayName?: string;

  /**
   * Boolean value indicating whether configuration is default
   */
  IsDefault?: boolean;

  /**
   * Unique Id for work item
   */
  @projectedName("json", "Id")
  id?: string;

  /**
   * Serialized JSON object for detailed properties
   */
  @projectedName("json", "ConfigProperties")
  configProperties?: string;
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
  @projectedName("json", "ConnectorId")
  connectorId?: string;

  /**
   * Serialized JSON object for detailed properties
   */
  @projectedName("json", "ConnectorDataConfiguration")
  connectorDataConfiguration?: string;

  /**
   * Boolean indicating validate only
   */
  @projectedName("json", "ValidateOnly")
  validateOnly?: boolean;

  /**
   * Custom work item properties
   */
  @projectedName("json", "WorkItemProperties")
  workItemProperties?: Record<string>;
}

/**
 * Properties that define a favorite that is associated to an Application Insights component.
 */
model ApplicationInsightsComponentFavorite {
  /**
   * The user-defined name of the favorite.
   */
  @projectedName("json", "Name")
  name?: string;

  /**
   * Configuration of this particular favorite, which are driven by the Azure portal UX. Configuration data is a string containing valid JSON
   */
  @projectedName("json", "Config")
  config?: string;

  /**
   * This instance's version of the data model. This can change as new features are added that can be marked favorite. Current examples include MetricsExplorer (ME) and Search.
   */
  @projectedName("json", "Version")
  version?: string;

  /**
   * Internally assigned unique id of the favorite definition.
   */
  @visibility("read")
  @projectedName("json", "FavoriteId")
  favoriteId?: string;

  /**
   * Enum indicating if this favorite definition is owned by a specific user or is shared between all users with access to the Application Insights component.
   */
  @projectedName("json", "FavoriteType")
  favoriteType?: FavoriteType;

  /**
   * The source of the favorite definition.
   */
  @projectedName("json", "SourceType")
  sourceType?: string;

  /**
   * Date and time in UTC of the last modification that was made to this favorite definition.
   */
  @visibility("read")
  @projectedName("json", "TimeModified")
  timeModified?: string;

  /**
   * A list of 0 or more tags that are associated with this favorite definition
   */
  @projectedName("json", "Tags")
  tags?: string[];

  /**
   * Favorite category, as defined by the user at creation time.
   */
  @projectedName("json", "Category")
  category?: string;

  /**
   * Flag denoting wether or not this favorite was generated from a template.
   */
  IsGeneratedFromTemplate?: boolean;

  /**
   * Unique user id of the specific user that owns this favorite.
   */
  @visibility("read")
  @projectedName("json", "UserId")
  userId?: string;
}

/**
 * Properties that define a web test location available to an Application Insights Component.
 */
model ApplicationInsightsComponentWebTestLocation {
  /**
   * The display name of the web test location.
   */
  @visibility("read")
  @projectedName("json", "DisplayName")
  displayName?: string;

  /**
   * Internally defined geographic location tag.
   */
  @visibility("read")
  @projectedName("json", "Tag")
  tag?: string;
}

/**
 * Metadata describing a web test for an Azure resource.
 */
model WebTestProperties {
  /**
   * Unique ID of this WebTest. This is typically the same value as the Name field.
   */
  @projectedName("json", "SyntheticMonitorId")
  syntheticMonitorId: string;

  /**
   * User defined name if this WebTest.
   */
  @projectedName("json", "Name")
  webTestName: string;

  /**
   * User defined description for this WebTest.
   */
  @projectedName("json", "Description")
  description?: string;

  /**
   * Is the test actively being monitored.
   */
  @projectedName("json", "Enabled")
  enabled?: boolean;

  /**
   * Interval in seconds between test runs for this WebTest. Default value is 300.
   */
  @projectedName("json", "Frequency")
  frequency?: int32 = 300;

  /**
   * Seconds until this WebTest will timeout and fail. Default value is 30.
   */
  @projectedName("json", "Timeout")
  timeout?: int32 = 30;

  /**
   * The kind of web test this is, valid choices are ping, multistep and standard.
   */
  @projectedName("json", "Kind")
  webTestKind: WebTestKind;

  /**
   * Allow for retries should this WebTest fail.
   */
  @projectedName("json", "RetryEnabled")
  retryEnabled?: boolean;

  /**
   * A list of where to physically run the tests from to give global coverage for accessibility of your application.
   */
  @projectedName("json", "Locations")
  locations: WebTestGeolocation[];

  /**
   * An XML configuration specification for a WebTest.
   */
  @projectedName("json", "Configuration")
  configuration?: WebTestPropertiesConfiguration;

  /**
   * Current state of this component, whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * The collection of request properties
   */
  @projectedName("json", "Request")
  request?: WebTestPropertiesRequest;

  /**
   * The collection of validation rule properties
   */
  @projectedName("json", "ValidationRules")
  validationRules?: WebTestPropertiesValidationRules;
}

/**
 * Geo-physical location to run a WebTest from. You must specify one or more locations for the test to run from.
 */
model WebTestGeolocation {
  /**
   * Location ID for the WebTest to run from.
   */
  @projectedName("json", "Id")
  location?: string;
}

/**
 * An XML configuration specification for a WebTest.
 */
model WebTestPropertiesConfiguration {
  /**
   * The XML specification of a WebTest to run against an application.
   */
  @projectedName("json", "WebTest")
  webTest?: string;
}

/**
 * The collection of request properties
 */
model WebTestPropertiesRequest {
  /**
   * Url location to test.
   */
  @projectedName("json", "RequestUrl")
  requestUrl?: string;

  /**
   * List of headers and their values to add to the WebTest call.
   */
  @projectedName("json", "Headers")
  headers?: HeaderField[];

  /**
   * Http verb to use for this web test.
   */
  @projectedName("json", "HttpVerb")
  httpVerb?: string;

  /**
   * Base64 encoded string body to send with this web test.
   */
  @projectedName("json", "RequestBody")
  requestBody?: string;

  /**
   * Parse Dependent request for this WebTest.
   */
  @projectedName("json", "ParseDependentRequests")
  parseDependentRequests?: boolean;

  /**
   * Follow redirects for this web test.
   */
  @projectedName("json", "FollowRedirects")
  followRedirects?: boolean;
}

/**
 * A header to add to the WebTest.
 */
model HeaderField {
  /**
   * The name of the header.
   */
  @projectedName("json", "key")
  headerFieldName?: string;

  /**
   * The value of the header.
   */
  @projectedName("json", "value")
  headerFieldValue?: string;
}

/**
 * The collection of validation rule properties
 */
model WebTestPropertiesValidationRules {
  /**
   * The collection of content validation properties
   */
  @projectedName("json", "ContentValidation")
  contentValidation?: WebTestPropertiesValidationRulesContentValidation;

  /**
   * Checks to see if the SSL cert is still valid.
   */
  SSLCheck?: boolean;

  /**
   * A number of days to check still remain before the the existing SSL cert expires.  Value must be positive and the SSLCheck must be set to true.
   */
  SSLCertRemainingLifetimeCheck?: int32;

  /**
   * Validate that the WebTest returns the http status code provided.
   */
  @projectedName("json", "ExpectedHttpStatusCode")
  expectedHttpStatusCode?: int32;

  /**
   * When set, validation will ignore the status code.
   */
  @projectedName("json", "IgnoreHttpStatusCode")
  ignoreHttpStatusCode?: boolean;
}

/**
 * The collection of content validation properties
 */
model WebTestPropertiesValidationRulesContentValidation {
  /**
   * Content to look for in the return of the WebTest.  Must not be null or empty.
   */
  @projectedName("json", "ContentMatch")
  contentMatch?: string;

  /**
   * When set, this value makes the ContentMatch validation case insensitive.
   */
  @projectedName("json", "IgnoreCase")
  ignoreCase?: boolean;

  /**
   * When true, validation will pass if there is a match for the ContentMatch string.  If false, validation will fail if there is a match
   */
  @projectedName("json", "PassIfTextFound")
  passIfTextFound?: boolean;
}

/**
 * An azure resource object
 */
model WebtestsResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Properties that define an Analytics item that is associated to an Application Insights component.
 */
model ApplicationInsightsComponentAnalyticsItem {
  /**
   * Internally assigned unique id of the item definition.
   */
  @projectedName("json", "Id")
  id?: string;

  /**
   * The user-defined name of the item.
   */
  @projectedName("json", "Name")
  name?: string;

  /**
   * The content of this item
   */
  @projectedName("json", "Content")
  content?: string;

  /**
   * This instance's version of the data model. This can change as new features are added.
   */
  @visibility("read")
  @projectedName("json", "Version")
  version?: string;

  /**
   * Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.
   */
  @projectedName("json", "Scope")
  scope?: ItemScope;

  /**
   * Enum indicating the type of the Analytics item.
   */
  @projectedName("json", "Type")
  type?: ItemType;

  /**
   * Date and time in UTC when this item was created.
   */
  @visibility("read")
  @projectedName("json", "TimeCreated")
  timeCreated?: string;

  /**
   * Date and time in UTC of the last modification that was made to this item.
   */
  @visibility("read")
  @projectedName("json", "TimeModified")
  timeModified?: string;

  /**
   * A set of properties that can be defined in the context of a specific item type. Each type may have its own properties.
   */
  @projectedName("json", "Properties")
  properties?: ApplicationInsightsComponentAnalyticsItemProperties;
}

/**
 * A set of properties that can be defined in the context of a specific item type. Each type may have its own properties.
 */
model ApplicationInsightsComponentAnalyticsItemProperties {
  /**
   * A function alias, used when the type of the item is Function
   */
  functionAlias?: string;
}

/**
 * Error Field contract.
 */
model ErrorFieldContract {
  /**
   * Property level error code.
   */
  code?: string;

  /**
   * Human-readable representation of property-level error.
   */
  message?: string;

  /**
   * Property name.
   */
  target?: string;
}

/**
 * Properties that contain a workbook template.
 */
model WorkbookTemplateProperties {
  /**
   * Priority of the template. Determines which template to open when a workbook gallery is opened in viewer mode.
   */
  priority?: int32;

  /**
   * Information about the author of the workbook template.
   */
  author?: string;

  /**
   * Valid JSON object containing workbook template payload.
   */
  templateData: Record<unknown>;

  /**
   * Workbook galleries supported by the template.
   */
  galleries: WorkbookTemplateGallery[];

  /**
   * Key value pair of localized gallery. Each key is the locale code of languages supported by the Azure portal.
   */
  localized?: Record<WorkbookTemplateLocalizedGallery[]>;
}

/**
 * Gallery information for a workbook template.
 */
model WorkbookTemplateGallery {
  /**
   * Name of the workbook template in the gallery.
   */
  name?: string;

  /**
   * Category for the gallery.
   */
  category?: string;

  /**
   * Type of workbook supported by the workbook template.
   */
  type?: string;

  /**
   * Order of the template within the gallery.
   */
  order?: int32;

  /**
   * Azure resource type supported by the gallery.
   */
  resourceType?: string;
}

/**
 * Localized template data and gallery information.
 */
model WorkbookTemplateLocalizedGallery {
  /**
   * Valid JSON object containing workbook template payload.
   */
  templateData?: Record<unknown>;

  /**
   * Workbook galleries supported by the template.
   */
  galleries?: WorkbookTemplateGallery[];
}

/**
 * An azure resource object
 */
model WorkbookTemplateResource {
  /**
   * Azure resource Id
   */
  @visibility("read")
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility("read")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * Error message that will indicate why the operation failed.
 */
@error
model WorkbookTemplateError {
  /**
   * Error message object that will indicate why the operation failed.
   */
  error?: WorkbookTemplateErrorBody;
}

/**
 * Error message body that will indicate why the operation failed.
 */
model WorkbookTemplateErrorBody {
  /**
   * Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.
   */
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  message?: string;

  /**
   * The list of invalid fields send in request, in case of validation error.
   */
  details?: WorkbookTemplateErrorFieldContract[];
}

/**
 * Error Field contract.
 */
model WorkbookTemplateErrorFieldContract {
  /**
   * Property level error code.
   */
  code?: string;

  /**
   * Human-readable representation of property-level error.
   */
  message?: string;

  /**
   * Property name.
   */
  target?: string;
}

/**
 * The parameters that can be provided when updating workbook template.
 */
model WorkbookTemplateUpdateParameters {
  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Metadata describing a workbook for an Azure resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkbookTemplateProperties;
}

/**
 * Properties that contain a private workbook.
 */
model MyWorkbookProperties {
  /**
   * The user-defined name of the private workbook.
   */
  displayName: string;

  /**
   * Configuration of this particular private workbook. Configuration data is a string containing valid JSON
   */
  serializedData: string;

  /**
   * This instance's version of the data model. This can change as new features are added that can be marked private workbook.
   */
  version?: string;

  /**
   * Date and time in UTC of the last modification that was made to this private workbook definition.
   */
  @visibility("read")
  timeModified?: string;

  /**
   * Workbook category, as defined by the user at creation time.
   */
  category: string;

  /**
   * A list of 0 or more tags that are associated with this private workbook definition
   */
  tags?: string[];

  /**
   * Unique user id of the specific user that owns this private workbook.
   */
  @visibility("read")
  userId?: string;

  /**
   * Optional resourceId for a source resource.
   */
  sourceId?: string;

  /**
   * BYOS Storage Account URI
   */
  storageUri?: string;
}

/**
 * An azure resource object
 */
model MyWorkbookResource {
  /**
   * Identity used for BYOS
   */
  identity?: MyWorkbookManagedIdentity;

  /**
   * Azure resource Id
   */
  @visibility("read", "create")
  id?: string;

  /**
   * Azure resource name
   */
  @visibility("read", "create")
  name?: string;

  /**
   * Azure resource type
   */
  @visibility("read", "create")
  type?: string;

  /**
   * Resource location
   */
  @visibility("read", "create")
  location?: string;

  /**
   * Resource tags
   */
  tags?: Record<string>;

  /**
   * Resource etag
   */
  etag?: Record<string>;
}

/**
 * Customer Managed Identity
 */
model MyWorkbookManagedIdentity {
  /**
   * Customer Managed Identity
   */
  userAssignedIdentities?: MyWorkbookUserAssignedIdentities;

  /**
   * The identity type.
   */
  type?: MyWorkbookManagedIdentityType;
}

/**
 * Customer Managed Identity
 */
model MyWorkbookUserAssignedIdentities {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;
}

/**
 * Error response.
 */
@error
model MyWorkbookError {
  /**
   * The error details.
   */
  error?: ErrorDefinition;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  innererror?: unknown;
}

/**
 * Properties that contain a workbook.
 */
model WorkbookProperties {
  /**
   * The user-defined name (display name) of the workbook.
   */
  displayName: string;

  /**
   * Configuration of this particular workbook. Configuration data is a string containing valid JSON
   */
  serializedData: string;

  /**
   * Workbook schema version format, like 'Notebook/1.0', which should match the workbook in serializedData
   */
  version?: string;

  /**
   * Date and time in UTC of the last modification that was made to this workbook definition.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * Workbook category, as defined by the user at creation time.
   */
  category: string;

  /**
   * Being deprecated, please use the other tags field
   */
  tags?: string[];

  /**
   * Unique user id of the specific user that owns this workbook.
   */
  @visibility("read")
  userId?: string;

  /**
   * ResourceId for a source resource.
   */
  sourceId?: string;

  /**
   * The resourceId to the storage account when bring your own storage is used
   */
  storageUri?: string;

  /**
   * The description of the workbook.
   */
  description?: string;

  /**
   * The unique revision id for this workbook definition
   */
  @visibility("read")
  revision?: string;
}

/**
 * An azure resource object
 */
model WorkbookResource extends TrackedResource {
  /**
   * Identity used for BYOS
   */
  identity?: WorkbookResourceIdentity;

  /**
   * The kind of workbook. Only valid value is shared.
   */
  kind?: WorkbookSharedTypeKind;

  /**
   * Resource etag
   */
  etag?: string;
}

/**
 * Identity used for BYOS
 */
model WorkbookResourceIdentity extends ManagedServiceIdentity {}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;
}

/**
 * Error response.
 */
@error
model WorkbookError {
  /**
   * The error details.
   */
  error?: WorkbookErrorDefinition;
}

/**
 * Error definition.
 */
model WorkbookErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  innererror?: WorkbookInnerErrorTrace;
}

/**
 * Error details
 */
model WorkbookInnerErrorTrace {
  /**
   * detailed error trace
   */
  @visibility("read")
  trace?: string[];
}

/**
 * The parameters that can be provided when updating workbook properties properties.
 */
model WorkbookUpdateParameters {
  /**
   * The kind of workbook. Only valid value is shared.
   */
  kind?: WorkbookUpdateSharedTypeKind;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * Metadata describing a workbook for an Azure resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkbookPropertiesUpdateParameters;
}

/**
 * Properties that contain a workbook for PATCH operation.
 */
model WorkbookPropertiesUpdateParameters {
  /**
   * The user-defined name (display name) of the workbook.
   */
  displayName?: string;

  /**
   * Configuration of this particular workbook. Configuration data is a string containing valid JSON
   */
  serializedData?: string;

  /**
   * Workbook category, as defined by the user at creation time.
   */
  category?: string;

  /**
   * A list of 0 or more tags that are associated with this workbook definition
   */
  tags?: string[];

  /**
   * The description of the workbook.
   */
  description?: string;

  /**
   * The unique revision id for this workbook definition
   */
  revision?: string;
}

/**
 * The response to a live token query.
 */
model LiveTokenResponse {
  /**
   * JWT token for accessing live metrics stream data.
   */
  @visibility("read")
  liveToken?: string;
}

@error
model ErrorResponseLinkedStorage {
  /**
   * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
   */
  error?: ErrorResponseLinkedStorageError;
}

/**
 * Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.
 */
model ErrorResponseLinkedStorageError {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;
}

/**
 * An Application Insights component linked storage account
 */
model LinkedStorageAccountsProperties {
  /**
   * Linked storage account resource ID
   */
  linkedStorageAccount?: string;
}

/**
 * An Application Insights component linked storage accounts patch
 */
model ComponentLinkedStorageAccountsPatch {
  /**
   * The properties of the linked storage accounts.
   */
  @extension("x-ms-client-flatten", true)
  properties?: LinkedStorageAccountsProperties;
}

/**
 * Error details
 */
model InnerErrorTrace {
  /**
   * detailed error trace
   */
  @visibility("read")
  trace?: string[];
}

/**
 * Result of the List Operations operation
 */
model OperationsListResult {
  /**
   * A collection of operations
   */
  value?: OperationLive[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  nextLink?: string;
}

/**
 * Represents an operation returned by the GetOperations request
 */
model OperationLive {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display name of the operation
   */
  display?: OperationInfo;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  @extension("x-ms-client-flatten", true)
  properties?: Record<unknown>;
}

/**
 * Information about an operation
 */
model OperationInfo {
  /**
   * Name of the provider
   */
  provider?: string;

  /**
   * Name of the resource type
   */
  resource?: string;

  /**
   * Name of the operation
   */
  operation?: string;

  /**
   * Description of the operation
   */
  description?: string;
}
