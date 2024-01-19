import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Type of application being monitored.")
enum ApplicationType {
  web,
  other,
}

@doc("Used by the Application Insights system to determine what kind of flow this component was created by. This is to be set to 'Bluefield' when creating/updating a component via the REST API.")
enum FlowType {
  Bluefield,
}

@doc("Describes what tool created this Application Insights component. Customers using this API should set this to the default 'rest'.")
enum RequestSource {
  rest,
}

@doc("The network access type for operating on the Application Insights Component. By default it is Enabled")
enum PublicNetworkAccessType {
  @doc("Enables connectivity to Application Insights through public DNS.")
  Enabled,
  @doc("Disables public connectivity to Application Insights through public DNS.")
  Disabled,
}

@doc("Indicates the flow of the ingestion.")
enum IngestionMode {
  ApplicationInsights,
  ApplicationInsightsWithDiagnosticSettings,
  LogAnalytics,
}

@doc("Status of the operation represented by the requested Id.")
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

@doc("Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.")
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

@doc("Enum indicating the type of the Analytics item.")
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

@doc("The kind of workbook. Choices are user and shared.")
enum Kind {
  user,
  shared,
}

@doc("The identity type.")
enum MyWorkbookManagedIdentityType {
  UserAssigned,
  None,
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("The kind of workbook. Only valid value is shared.")
enum WorkbookSharedTypeKind {
  shared,
}

@doc("The kind of workbook. Only valid value is shared.")
enum WorkbookUpdateSharedTypeKind {
  shared,
}

enum StorageType {
  ServiceProfiler,
}

@doc("Enum indicating if this favorite definition is owned by a specific user or is shared between all users with access to the Application Insights component.")
@fixed
enum FavoriteType {
  shared,
  user,
}

@doc("The kind of WebTest that this web test watches. Choices are ping, multistep and standard.")
@fixed
enum WebTestKind {
  ping,
  multistep,
  standard,
}

@doc("Properties that define an Application Insights component resource.")
model ApplicationInsightsComponentProperties {
  @doc("The unique ID of your application. This field mirrors the 'Name' field and cannot be changed.")
  @visibility("read")
  @projectedName("json", "ApplicationId")
  applicationId?: string;

  @doc("Application Insights Unique ID for your Application.")
  @visibility("read")
  @projectedName("json", "AppId")
  appId?: string;

  @doc("Application name.")
  @visibility("read")
  @projectedName("json", "Name")
  name?: string;

  @doc("Type of application being monitored.")
  @visibility("read", "create")
  @projectedName("json", "Application_Type")
  applicationType: ApplicationType;

  @doc("Used by the Application Insights system to determine what kind of flow this component was created by. This is to be set to 'Bluefield' when creating/updating a component via the REST API.")
  @projectedName("json", "Flow_Type")
  flowType?: FlowType;

  @doc("Describes what tool created this Application Insights component. Customers using this API should set this to the default 'rest'.")
  @projectedName("json", "Request_Source")
  requestSource?: RequestSource;

  @doc("Application Insights Instrumentation key. A read-only value that applications can use to identify the destination for all telemetry sent to Azure Application Insights. This value will be supplied upon construction of each new Application Insights component.")
  @visibility("read")
  @projectedName("json", "InstrumentationKey")
  instrumentationKey?: string;

  @doc("Creation Date for the Application Insights component, in ISO 8601 format.")
  @visibility("read")
  @projectedName("json", "CreationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  creationDate?: utcDateTime;

  @doc("Azure Tenant Id.")
  @visibility("read")
  @projectedName("json", "TenantId")
  tenantId?: string;

  @doc("The unique application ID created when a new application is added to HockeyApp, used for communications with HockeyApp.")
  @projectedName("json", "HockeyAppId")
  hockeyAppId?: string;

  @doc("Token used to authenticate communications with between Application Insights and HockeyApp.")
  @visibility("read")
  @projectedName("json", "HockeyAppToken")
  hockeyAppToken?: string;

  @doc("Current state of this component: whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.")
  @visibility("read")
  provisioningState?: string;

  @doc("Percentage of the data produced by the application being monitored that is being sampled for Application Insights telemetry.")
  @projectedName("json", "SamplingPercentage")
  samplingPercentage?: float32;

  @doc("Application Insights component connection string.")
  @visibility("read")
  @projectedName("json", "ConnectionString")
  connectionString?: string;

  @doc("Retention period in days.")
  @projectedName("json", "RetentionInDays")
  retentionInDays?: int32;

  @doc("Disable IP masking.")
  @projectedName("json", "DisableIpMasking")
  disableIpMasking?: boolean;

  @doc("Purge data immediately after 30 days.")
  @projectedName("json", "ImmediatePurgeDataOn30Days")
  immediatePurgeDataOn30Days?: boolean;

  @doc("Resource Id of the log analytics workspace which the data will be ingested to. This property is required to create an application with this API version. Applications from older versions will not have this property.")
  @projectedName("json", "WorkspaceResourceId")
  workspaceResourceId?: string;

  @doc("The date which the component got migrated to LA, in ISO 8601 format.")
  @visibility("read")
  @projectedName("json", "LaMigrationDate")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  laMigrationDate?: utcDateTime;

  @doc("List of linked private link scope resources.")
  @visibility("read")
  @projectedName("json", "PrivateLinkScopedResources")
  privateLinkScopedResources?: PrivateLinkScopedResource[];

  @doc("The network access type for accessing Application Insights ingestion.")
  publicNetworkAccessForIngestion?: PublicNetworkAccessType;

  @doc("The network access type for accessing Application Insights query.")
  publicNetworkAccessForQuery?: PublicNetworkAccessType;

  @doc("Indicates the flow of the ingestion.")
  @projectedName("json", "IngestionMode")
  ingestionMode?: IngestionMode;

  @doc("Disable Non-AAD based Auth.")
  @projectedName("json", "DisableLocalAuth")
  disableLocalAuth?: boolean;

  @doc("Force users to create their own storage account for profiler and debugger.")
  @projectedName("json", "ForceCustomerStorageForProfiler")
  forceCustomerStorageForProfiler?: boolean;
}

@doc("The private link scope resource reference.")
model PrivateLinkScopedResource {
  @doc("The full resource Id of the private link scope resource.")
  @projectedName("json", "ResourceId")
  resourceId?: string;

  @doc("The private link scope unique Identifier.")
  @projectedName("json", "ScopeId")
  scopeId?: string;
}

@doc("An azure resource object")
model ComponentsResource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location: string;

  @doc("Resource tags")
  tags?: Record<string>;
}

@error
model ErrorResponseComponents {
  @doc("Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.")
  error?: ErrorResponseComponentsError;
}

@doc("Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.")
model ErrorResponseComponentsError {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;
}

@doc("A container holding only the Tags for a resource, allowing the user to update the tags on a WebTest instance.")
model TagsResource {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Describes the body of a purge request for an App Insights component")
model ComponentPurgeBody {
  @doc("Table from which to purge data.")
  table: string;

  @doc("The set of columns and filters (queries) to run over them to purge the resulting data.")
  filters: ComponentPurgeBodyFilters[];
}

@doc("User-defined filters to return data which will be purged from the table.")
model ComponentPurgeBodyFilters {
  @doc("The column of the table over which the given query should run")
  column?: string;

  @doc("A query operator to evaluate over the provided column and value(s). Supported operators are ==, =~, in, in~, >, >=, <, <=, between, and have the same behavior as they would in a KQL query.")
  operator?: string;

  @doc("the value for the operator to function over. This can be a number (e.g., > 100), a string (timestamp >= '2017-09-01') or array of values.")
  value?: unknown;

  @doc("When filtering over custom dimensions, this key will be used as the name of the custom dimension.")
  key?: string;
}

@doc("Response containing operationId for a specific purge action.")
model ComponentPurgeResponse {
  @doc("Id to use when querying for status for a particular purge operation.")
  operationId: string;
}

@doc("Response containing status for a specific purge operation.")
model ComponentPurgeStatusResponse {
  @doc("Status of the operation represented by the requested Id.")
  status: PurgeState;
}

@doc("Annotations list result.")
@pagedResult
model AnnotationsListResult {
  @doc("An array of annotations.")
  @visibility("read")
  @items
  value?: Annotation[];
}

@doc("Annotation associated with an application insights resource.")
model Annotation {
  @doc("Name of annotation")
  @projectedName("json", "AnnotationName")
  annotationName?: string;

  @doc("Category of annotation, free form")
  @projectedName("json", "Category")
  category?: string;

  @doc("Time when event occurred")
  @projectedName("json", "EventTime")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  eventTime?: utcDateTime;

  @doc("Unique Id for annotation")
  @projectedName("json", "Id")
  id?: string;

  @doc("Serialized JSON object for detailed properties")
  @projectedName("json", "Properties")
  properties?: string;

  @doc("Related parent annotation if any")
  @projectedName("json", "RelatedAnnotation")
  relatedAnnotation?: string;
}

@doc("Error associated with trying to create annotation with Id that already exist")
@error
model AnnotationError {
  @doc("Error detail code and explanation")
  code?: string;

  @doc("Error message")
  message?: string;

  @doc("Inner error")
  innererror?: InnerError;
}

@doc("Inner error")
model InnerError {
  @doc("Provides correlation for request")
  diagnosticcontext?: string;

  @doc("Request time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  time?: utcDateTime;
}

@doc("Describes the list of API Keys of an Application Insights Component.")
@pagedResult
model ApplicationInsightsComponentAPIKeyListResult {
  @doc("List of API Key definitions.")
  @items
  value: ApplicationInsightsComponentAPIKey[];
}

@doc("Properties that define an API key of an Application Insights Component.")
model ApplicationInsightsComponentAPIKey {
  @doc("The unique ID of the API key inside an Application Insights component. It is auto generated when the API key is created.")
  @visibility("read")
  id?: string;

  @doc("The API key value. It will be only return once when the API Key was created.")
  @visibility("read")
  apiKey?: string;

  @doc("The create date of this API key.")
  createdDate?: string;

  @doc("The name of the API key.")
  name?: string;

  @doc("The read access rights of this API Key.")
  linkedReadProperties?: string[];

  @doc("The write access rights of this API Key.")
  linkedWriteProperties?: string[];
}

@doc("An Application Insights component API Key creation request definition.")
model APIKeyRequest {
  @doc("The name of the API Key.")
  name?: string;

  @doc("The read access rights of this API Key.")
  linkedReadProperties?: string[];

  @doc("The write access rights of this API Key.")
  linkedWriteProperties?: string[];
}

@doc("Properties that define a Continuous Export configuration.")
model ApplicationInsightsComponentExportConfiguration {
  @doc("The unique ID of the export configuration inside an Application Insights component. It is auto generated when the Continuous Export configuration is created.")
  @visibility("read")
  @projectedName("json", "ExportId")
  exportId?: string;

  @doc("The instrumentation key of the Application Insights component.")
  @visibility("read")
  @projectedName("json", "InstrumentationKey")
  instrumentationKey?: string;

  @doc("This comma separated list of document types that will be exported. The possible values include 'Requests', 'Event', 'Exceptions', 'Metrics', 'PageViews', 'PageViewPerformance', 'Rdd', 'PerformanceCounters', 'Availability', 'Messages'.")
  @projectedName("json", "RecordTypes")
  recordTypes?: string;

  @doc("The name of the Application Insights component.")
  @visibility("read")
  @projectedName("json", "ApplicationName")
  applicationName?: string;

  @doc("The subscription of the Application Insights component.")
  @visibility("read")
  @projectedName("json", "SubscriptionId")
  subscriptionId?: string;

  @doc("The resource group of the Application Insights component.")
  @visibility("read")
  @projectedName("json", "ResourceGroup")
  resourceGroup?: string;

  @doc("The destination storage account subscription ID.")
  @visibility("read")
  @projectedName("json", "DestinationStorageSubscriptionId")
  destinationStorageSubscriptionId?: string;

  @doc("The destination account location ID.")
  @visibility("read")
  @projectedName("json", "DestinationStorageLocationId")
  destinationStorageLocationId?: string;

  @doc("The name of destination account.")
  @visibility("read")
  @projectedName("json", "DestinationAccountId")
  destinationAccountId?: string;

  @doc("The destination type.")
  @visibility("read")
  @projectedName("json", "DestinationType")
  destinationType?: string;

  @doc("This will be 'true' if the Continuous Export configuration is enabled, otherwise it will be 'false'.")
  @visibility("read")
  IsUserEnabled?: string;

  @doc("Last time the Continuous Export configuration was updated.")
  @visibility("read")
  @projectedName("json", "LastUserUpdate")
  lastUserUpdate?: string;

  @doc("Deprecated")
  @projectedName("json", "NotificationQueueEnabled")
  notificationQueueEnabled?: string;

  @doc("This indicates current Continuous Export configuration status. The possible values are 'Preparing', 'Success', 'Failure'.")
  @visibility("read")
  @projectedName("json", "ExportStatus")
  exportStatus?: string;

  @doc("The last time data was successfully delivered to the destination storage container for this Continuous Export configuration.")
  @visibility("read")
  @projectedName("json", "LastSuccessTime")
  lastSuccessTime?: string;

  @doc("The last time the Continuous Export configuration started failing.")
  @visibility("read")
  @projectedName("json", "LastGapTime")
  lastGapTime?: string;

  @doc("This is the reason the Continuous Export configuration started failing. It can be 'AzureStorageNotFound' or 'AzureStorageAccessDenied'.")
  @visibility("read")
  @projectedName("json", "PermanentErrorReason")
  permanentErrorReason?: string;

  @doc("The name of the destination storage account.")
  @visibility("read")
  @projectedName("json", "StorageName")
  storageName?: string;

  @doc("The name of the destination storage container.")
  @visibility("read")
  @projectedName("json", "ContainerName")
  containerName?: string;
}

@doc("An Application Insights component Continuous Export configuration request definition.")
model ApplicationInsightsComponentExportRequest {
  @doc("The document types to be exported, as comma separated values. Allowed values include 'Requests', 'Event', 'Exceptions', 'Metrics', 'PageViews', 'PageViewPerformance', 'Rdd', 'PerformanceCounters', 'Availability', 'Messages'.")
  @projectedName("json", "RecordTypes")
  recordTypes?: string;

  @doc("The Continuous Export destination type. This has to be 'Blob'.")
  @projectedName("json", "DestinationType")
  destinationType?: string;

  @doc("The SAS URL for the destination storage container. It must grant write permission.")
  @projectedName("json", "DestinationAddress")
  destinationAddress?: string;

  @doc("Set to 'true' to create a Continuous Export configuration as enabled, otherwise set it to 'false'.")
  IsEnabled?: string;

  @doc("Deprecated")
  @projectedName("json", "NotificationQueueEnabled")
  notificationQueueEnabled?: string;

  @doc("Deprecated")
  @projectedName("json", "NotificationQueueUri")
  notificationQueueUri?: string;

  @doc("The subscription ID of the destination storage container.")
  @projectedName("json", "DestinationStorageSubscriptionId")
  destinationStorageSubscriptionId?: string;

  @doc("The location ID of the destination storage container.")
  @projectedName("json", "DestinationStorageLocationId")
  destinationStorageLocationId?: string;

  @doc("The name of destination storage account.")
  @projectedName("json", "DestinationAccountId")
  destinationAccountId?: string;
}

@doc("An Application Insights component billing features")
model ApplicationInsightsComponentBillingFeatures {
  @doc("An Application Insights component daily data volume cap")
  @projectedName("json", "DataVolumeCap")
  dataVolumeCap?: ApplicationInsightsComponentDataVolumeCap;

  @doc("Current enabled pricing plan. When the component is in the Enterprise plan, this will list both 'Basic' and 'Application Insights Enterprise'.")
  @projectedName("json", "CurrentBillingFeatures")
  currentBillingFeatures?: string[];
}

@doc("An Application Insights component daily data volume cap")
model ApplicationInsightsComponentDataVolumeCap {
  @doc("Daily data volume cap in GB.")
  @projectedName("json", "Cap")
  cap?: float32;

  @doc("Daily data volume cap UTC reset hour.")
  @visibility("read")
  @projectedName("json", "ResetTime")
  resetTime?: int32;

  @doc("Reserved, not used for now.")
  @projectedName("json", "WarningThreshold")
  warningThreshold?: int32;

  @doc("Reserved, not used for now.")
  @projectedName("json", "StopSendNotificationWhenHitThreshold")
  stopSendNotificationWhenHitThreshold?: boolean;

  @doc("Do not send a notification email when the daily data volume cap is met.")
  @projectedName("json", "StopSendNotificationWhenHitCap")
  stopSendNotificationWhenHitCap?: boolean;

  @doc("Maximum daily data volume cap that the user can set for this component.")
  @visibility("read")
  @projectedName("json", "MaxHistoryCap")
  maxHistoryCap?: float32;
}

@doc("An Application Insights component daily data volume cap status")
model ApplicationInsightsComponentQuotaStatus {
  @doc("The Application ID for the Application Insights component.")
  @visibility("read")
  @projectedName("json", "AppId")
  appId?: string;

  @doc("The daily data volume cap is met, and data ingestion will be stopped.")
  @visibility("read")
  @projectedName("json", "ShouldBeThrottled")
  shouldBeThrottled?: boolean;

  @doc("Date and time when the daily data volume cap will be reset, and data ingestion will resume.")
  @visibility("read")
  @projectedName("json", "ExpirationTime")
  expirationTime?: string;
}

@doc("An Application Insights component feature capabilities")
model ApplicationInsightsComponentFeatureCapabilities {
  @doc("Whether allow to use continuous export feature.")
  @visibility("read")
  @projectedName("json", "SupportExportData")
  supportExportData?: boolean;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "BurstThrottlePolicy")
  burstThrottlePolicy?: string;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "MetadataClass")
  metadataClass?: string;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "LiveStreamMetrics")
  liveStreamMetrics?: boolean;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "ApplicationMap")
  applicationMap?: boolean;

  @doc("Whether allow to use work item integration feature.")
  @visibility("read")
  @projectedName("json", "WorkItemIntegration")
  workItemIntegration?: boolean;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "PowerBIIntegration")
  powerBIIntegration?: boolean;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "OpenSchema")
  openSchema?: boolean;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "ProactiveDetection")
  proactiveDetection?: boolean;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "AnalyticsIntegration")
  analyticsIntegration?: boolean;

  @doc("Whether allow to use multiple steps web test feature.")
  @visibility("read")
  @projectedName("json", "MultipleStepWebTest")
  multipleStepWebTest?: boolean;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "ApiAccessLevel")
  apiAccessLevel?: string;

  @doc("The application insights component used tracking type.")
  @visibility("read")
  @projectedName("json", "TrackingType")
  trackingType?: string;

  @doc("Daily data volume cap in GB.")
  @visibility("read")
  @projectedName("json", "DailyCap")
  dailyCap?: float32;

  @doc("Daily data volume cap UTC reset hour.")
  @visibility("read")
  @projectedName("json", "DailyCapResetTime")
  dailyCapResetTime?: float32;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "ThrottleRate")
  throttleRate?: float32;
}

@doc("An Application Insights component available features.")
model ApplicationInsightsComponentAvailableFeatures {
  @doc("A list of Application Insights component feature.")
  @visibility("read")
  @projectedName("json", "Result")
  result?: ApplicationInsightsComponentFeature[];
}

@doc("An Application Insights component daily data volume cap status")
model ApplicationInsightsComponentFeature {
  @doc("The pricing feature name.")
  @visibility("read")
  @projectedName("json", "FeatureName")
  featureName?: string;

  @doc("The meter id used for the feature.")
  @visibility("read")
  @projectedName("json", "MeterId")
  meterId?: string;

  @doc("The meter rate for the feature's meter.")
  @visibility("read")
  @projectedName("json", "MeterRateFrequency")
  meterRateFrequency?: string;

  @doc("Reserved, not used now.")
  @visibility("read")
  @projectedName("json", "ResouceId")
  resouceId?: string;

  @doc("Reserved, not used now.")
  @visibility("read")
  IsHidden?: boolean;

  @doc("A list of Application Insights component feature capability.")
  @visibility("read")
  @projectedName("json", "Capabilities")
  capabilities?: ApplicationInsightsComponentFeatureCapability[];

  @doc("Display name of the feature.")
  @visibility("read")
  @projectedName("json", "Title")
  title?: string;

  @doc("Whether can apply addon feature on to it.")
  @visibility("read")
  IsMainFeature?: boolean;

  @doc("The add on features on main feature.")
  @visibility("read")
  @projectedName("json", "SupportedAddonFeatures")
  supportedAddonFeatures?: string;
}

@doc("An Application Insights component feature capability")
model ApplicationInsightsComponentFeatureCapability {
  @doc("The name of the capability.")
  @visibility("read")
  @projectedName("json", "Name")
  name?: string;

  @doc("The description of the capability.")
  @visibility("read")
  @projectedName("json", "Description")
  description?: string;

  @doc("The value of the capability.")
  @visibility("read")
  @projectedName("json", "Value")
  value?: string;

  @doc("The unit of the capability.")
  @visibility("read")
  @projectedName("json", "Unit")
  unit?: string;

  @doc("The meter used for the capability.")
  @visibility("read")
  @projectedName("json", "MeterId")
  meterId?: string;

  @doc("The meter rate of the meter.")
  @visibility("read")
  @projectedName("json", "MeterRateFrequency")
  meterRateFrequency?: string;
}

@doc("Properties that define a ProactiveDetection configuration.")
model ApplicationInsightsComponentProactiveDetectionConfiguration {
  @doc("The rule name")
  @projectedName("json", "Name")
  name?: string;

  @doc("A flag that indicates whether this rule is enabled by the user")
  @projectedName("json", "Enabled")
  enabled?: boolean;

  @doc("A flag that indicated whether notifications on this rule should be sent to subscription owners")
  @projectedName("json", "SendEmailsToSubscriptionOwners")
  sendEmailsToSubscriptionOwners?: boolean;

  @doc("Custom email addresses for this rule notifications")
  @projectedName("json", "CustomEmails")
  customEmails?: string[];

  @doc("The last time this rule was updated")
  @projectedName("json", "LastUpdatedTime")
  lastUpdatedTime?: string;

  @doc("Static definitions of the ProactiveDetection configuration rule (same values for all components).")
  @projectedName("json", "RuleDefinitions")
  ruleDefinitions?: ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions;
}

@doc("Static definitions of the ProactiveDetection configuration rule (same values for all components).")
model ApplicationInsightsComponentProactiveDetectionConfigurationRuleDefinitions {
  @doc("The rule name")
  @projectedName("json", "Name")
  name?: string;

  @doc("The rule name as it is displayed in UI")
  @projectedName("json", "DisplayName")
  displayName?: string;

  @doc("The rule description")
  @projectedName("json", "Description")
  description?: string;

  @doc("URL which displays additional info about the proactive detection rule")
  @projectedName("json", "HelpUrl")
  helpUrl?: string;

  @doc("A flag indicating whether the rule is hidden (from the UI)")
  IsHidden?: boolean;

  @doc("A flag indicating whether the rule is enabled by default")
  IsEnabledByDefault?: boolean;

  @doc("A flag indicating whether the rule is in preview")
  IsInPreview?: boolean;

  @doc("A flag indicating whether email notifications are supported for detections for this rule")
  @projectedName("json", "SupportsEmailNotifications")
  supportsEmailNotifications?: boolean;
}

@doc("Work item configuration list result.")
@pagedResult
model WorkItemConfigurationsListResult {
  @doc("An array of work item configurations.")
  @visibility("read")
  @items
  value?: WorkItemConfiguration[];
}

@doc("Work item configuration associated with an application insights resource.")
model WorkItemConfiguration {
  @doc("Connector identifier where work item is created")
  @projectedName("json", "ConnectorId")
  connectorId?: string;

  @doc("Configuration friendly name")
  @projectedName("json", "ConfigDisplayName")
  configDisplayName?: string;

  @doc("Boolean value indicating whether configuration is default")
  IsDefault?: boolean;

  @doc("Unique Id for work item")
  @projectedName("json", "Id")
  id?: string;

  @doc("Serialized JSON object for detailed properties")
  @projectedName("json", "ConfigProperties")
  configProperties?: string;
}

@doc("Error associated with trying to get work item configuration or configurations")
@error
model WorkItemConfigurationError {
  @doc("Error detail code and explanation")
  code?: string;

  @doc("Error message")
  message?: string;

  @doc("Inner error")
  innererror?: InnerError;
}

@doc("Work item configuration creation payload")
model WorkItemCreateConfiguration {
  @doc("Unique connector id")
  @projectedName("json", "ConnectorId")
  connectorId?: string;

  @doc("Serialized JSON object for detailed properties")
  @projectedName("json", "ConnectorDataConfiguration")
  connectorDataConfiguration?: string;

  @doc("Boolean indicating validate only")
  @projectedName("json", "ValidateOnly")
  validateOnly?: boolean;

  @doc("Custom work item properties")
  @projectedName("json", "WorkItemProperties")
  workItemProperties?: Record<string>;
}

@doc("Properties that define a favorite that is associated to an Application Insights component.")
model ApplicationInsightsComponentFavorite {
  @doc("The user-defined name of the favorite.")
  @projectedName("json", "Name")
  name?: string;

  @doc("Configuration of this particular favorite, which are driven by the Azure portal UX. Configuration data is a string containing valid JSON")
  @projectedName("json", "Config")
  config?: string;

  @doc("This instance's version of the data model. This can change as new features are added that can be marked favorite. Current examples include MetricsExplorer (ME) and Search.")
  @projectedName("json", "Version")
  version?: string;

  @doc("Internally assigned unique id of the favorite definition.")
  @visibility("read")
  @projectedName("json", "FavoriteId")
  favoriteId?: string;

  @doc("Enum indicating if this favorite definition is owned by a specific user or is shared between all users with access to the Application Insights component.")
  @projectedName("json", "FavoriteType")
  favoriteType?: FavoriteType;

  @doc("The source of the favorite definition.")
  @projectedName("json", "SourceType")
  sourceType?: string;

  @doc("Date and time in UTC of the last modification that was made to this favorite definition.")
  @visibility("read")
  @projectedName("json", "TimeModified")
  timeModified?: string;

  @doc("A list of 0 or more tags that are associated with this favorite definition")
  @projectedName("json", "Tags")
  tags?: string[];

  @doc("Favorite category, as defined by the user at creation time.")
  @projectedName("json", "Category")
  category?: string;

  @doc("Flag denoting wether or not this favorite was generated from a template.")
  IsGeneratedFromTemplate?: boolean;

  @doc("Unique user id of the specific user that owns this favorite.")
  @visibility("read")
  @projectedName("json", "UserId")
  userId?: string;
}

@doc("Properties that define a web test location available to an Application Insights Component.")
model ApplicationInsightsComponentWebTestLocation {
  @doc("The display name of the web test location.")
  @visibility("read")
  @projectedName("json", "DisplayName")
  displayName?: string;

  @doc("Internally defined geographic location tag.")
  @visibility("read")
  @projectedName("json", "Tag")
  tag?: string;
}

@doc("Metadata describing a web test for an Azure resource.")
model WebTestProperties {
  @doc("Unique ID of this WebTest. This is typically the same value as the Name field.")
  @projectedName("json", "SyntheticMonitorId")
  syntheticMonitorId: string;

  @doc("User defined name if this WebTest.")
  @projectedName("json", "Name")
  webTestName: string;

  @doc("User defined description for this WebTest.")
  @projectedName("json", "Description")
  description?: string;

  @doc("Is the test actively being monitored.")
  @projectedName("json", "Enabled")
  enabled?: boolean;

  @doc("Interval in seconds between test runs for this WebTest. Default value is 300.")
  @projectedName("json", "Frequency")
  frequency?: int32;

  @doc("Seconds until this WebTest will timeout and fail. Default value is 30.")
  @projectedName("json", "Timeout")
  timeout?: int32;

  @doc("The kind of web test this is, valid choices are ping, multistep and standard.")
  @projectedName("json", "Kind")
  webTestKind: WebTestKind;

  @doc("Allow for retries should this WebTest fail.")
  @projectedName("json", "RetryEnabled")
  retryEnabled?: boolean;

  @doc("A list of where to physically run the tests from to give global coverage for accessibility of your application.")
  @projectedName("json", "Locations")
  locations: WebTestGeolocation[];

  @doc("An XML configuration specification for a WebTest.")
  @projectedName("json", "Configuration")
  configuration?: WebTestPropertiesConfiguration;

  @doc("Current state of this component, whether or not is has been provisioned within the resource group it is defined. Users cannot change this value but are able to read from it. Values will include Succeeded, Deploying, Canceled, and Failed.")
  @visibility("read")
  provisioningState?: string;

  @doc("The collection of request properties")
  @projectedName("json", "Request")
  request?: WebTestPropertiesRequest;

  @doc("The collection of validation rule properties")
  @projectedName("json", "ValidationRules")
  validationRules?: WebTestPropertiesValidationRules;
}

@doc("Geo-physical location to run a WebTest from. You must specify one or more locations for the test to run from.")
model WebTestGeolocation {
  @doc("Location ID for the WebTest to run from.")
  @projectedName("json", "Id")
  location?: string;
}

@doc("An XML configuration specification for a WebTest.")
model WebTestPropertiesConfiguration {
  @doc("The XML specification of a WebTest to run against an application.")
  @projectedName("json", "WebTest")
  webTest?: string;
}

@doc("The collection of request properties")
model WebTestPropertiesRequest {
  @doc("Url location to test.")
  @projectedName("json", "RequestUrl")
  requestUrl?: string;

  @doc("List of headers and their values to add to the WebTest call.")
  @projectedName("json", "Headers")
  headers?: HeaderField[];

  @doc("Http verb to use for this web test.")
  @projectedName("json", "HttpVerb")
  httpVerb?: string;

  @doc("Base64 encoded string body to send with this web test.")
  @projectedName("json", "RequestBody")
  requestBody?: string;

  @doc("Parse Dependent request for this WebTest.")
  @projectedName("json", "ParseDependentRequests")
  parseDependentRequests?: boolean;

  @doc("Follow redirects for this web test.")
  @projectedName("json", "FollowRedirects")
  followRedirects?: boolean;
}

@doc("A header to add to the WebTest.")
model HeaderField {
  @doc("The name of the header.")
  @projectedName("json", "key")
  headerFieldName?: string;

  @doc("The value of the header.")
  @projectedName("json", "value")
  headerFieldValue?: string;
}

@doc("The collection of validation rule properties")
model WebTestPropertiesValidationRules {
  @doc("The collection of content validation properties")
  @projectedName("json", "ContentValidation")
  contentValidation?: WebTestPropertiesValidationRulesContentValidation;

  @doc("Checks to see if the SSL cert is still valid.")
  SSLCheck?: boolean;

  @doc("A number of days to check still remain before the the existing SSL cert expires.  Value must be positive and the SSLCheck must be set to true.")
  SSLCertRemainingLifetimeCheck?: int32;

  @doc("Validate that the WebTest returns the http status code provided.")
  @projectedName("json", "ExpectedHttpStatusCode")
  expectedHttpStatusCode?: int32;

  @doc("When set, validation will ignore the status code.")
  @projectedName("json", "IgnoreHttpStatusCode")
  ignoreHttpStatusCode?: boolean;
}

@doc("The collection of content validation properties")
model WebTestPropertiesValidationRulesContentValidation {
  @doc("Content to look for in the return of the WebTest.  Must not be null or empty.")
  @projectedName("json", "ContentMatch")
  contentMatch?: string;

  @doc("When set, this value makes the ContentMatch validation case insensitive.")
  @projectedName("json", "IgnoreCase")
  ignoreCase?: boolean;

  @doc("When true, validation will pass if there is a match for the ContentMatch string.  If false, validation will fail if there is a match")
  @projectedName("json", "PassIfTextFound")
  passIfTextFound?: boolean;
}

@doc("An azure resource object")
model WebtestsResource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location: string;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Properties that define an Analytics item that is associated to an Application Insights component.")
model ApplicationInsightsComponentAnalyticsItem {
  @doc("Internally assigned unique id of the item definition.")
  @projectedName("json", "Id")
  id?: string;

  @doc("The user-defined name of the item.")
  @projectedName("json", "Name")
  name?: string;

  @doc("The content of this item")
  @projectedName("json", "Content")
  content?: string;

  @doc("This instance's version of the data model. This can change as new features are added.")
  @visibility("read")
  @projectedName("json", "Version")
  version?: string;

  @doc("Enum indicating if this item definition is owned by a specific user or is shared between all users with access to the Application Insights component.")
  @projectedName("json", "Scope")
  scope?: ItemScope;

  @doc("Enum indicating the type of the Analytics item.")
  @projectedName("json", "Type")
  type?: ItemType;

  @doc("Date and time in UTC when this item was created.")
  @visibility("read")
  @projectedName("json", "TimeCreated")
  timeCreated?: string;

  @doc("Date and time in UTC of the last modification that was made to this item.")
  @visibility("read")
  @projectedName("json", "TimeModified")
  timeModified?: string;

  @doc("A set of properties that can be defined in the context of a specific item type. Each type may have its own properties.")
  @projectedName("json", "Properties")
  properties?: ApplicationInsightsComponentAnalyticsItemProperties;
}

@doc("A set of properties that can be defined in the context of a specific item type. Each type may have its own properties.")
model ApplicationInsightsComponentAnalyticsItemProperties {
  @doc("A function alias, used when the type of the item is Function")
  functionAlias?: string;
}

@doc("Error Field contract.")
model ErrorFieldContract {
  @doc("Property level error code.")
  code?: string;

  @doc("Human-readable representation of property-level error.")
  message?: string;

  @doc("Property name.")
  target?: string;
}

@doc("Properties that contain a workbook template.")
model WorkbookTemplateProperties {
  @doc("Priority of the template. Determines which template to open when a workbook gallery is opened in viewer mode.")
  priority?: int32;

  @doc("Information about the author of the workbook template.")
  author?: string;

  @doc("Valid JSON object containing workbook template payload.")
  templateData: Record<unknown>;

  @doc("Workbook galleries supported by the template.")
  galleries: WorkbookTemplateGallery[];

  @doc("Key value pair of localized gallery. Each key is the locale code of languages supported by the Azure portal.")
  localized?: Record<WorkbookTemplateLocalizedGallery[]>;
}

@doc("Gallery information for a workbook template.")
model WorkbookTemplateGallery {
  @doc("Name of the workbook template in the gallery.")
  name?: string;

  @doc("Category for the gallery.")
  category?: string;

  @doc("Type of workbook supported by the workbook template.")
  type?: string;

  @doc("Order of the template within the gallery.")
  order?: int32;

  @doc("Azure resource type supported by the gallery.")
  resourceType?: string;
}

@doc("Localized template data and gallery information.")
model WorkbookTemplateLocalizedGallery {
  @doc("Valid JSON object containing workbook template payload.")
  templateData?: Record<unknown>;

  @doc("Workbook galleries supported by the template.")
  galleries?: WorkbookTemplateGallery[];
}

@doc("An azure resource object")
model WorkbookTemplateResource {
  @doc("Azure resource Id")
  @visibility("read")
  id?: string;

  @doc("Azure resource name.")
  @visibility("read")
  name?: string;

  @doc("Azure resource type")
  @visibility("read")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location: string;

  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("Error message that will indicate why the operation failed.")
@error
model WorkbookTemplateError {
  @doc("Error message object that will indicate why the operation failed.")
  error?: WorkbookTemplateErrorBody;
}

@doc("Error message body that will indicate why the operation failed.")
model WorkbookTemplateErrorBody {
  @doc("Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.")
  code?: string;

  @doc("Human-readable representation of the error.")
  message?: string;

  @doc("The list of invalid fields send in request, in case of validation error.")
  details?: WorkbookTemplateErrorFieldContract[];
}

@doc("Error Field contract.")
model WorkbookTemplateErrorFieldContract {
  @doc("Property level error code.")
  code?: string;

  @doc("Human-readable representation of property-level error.")
  message?: string;

  @doc("Property name.")
  target?: string;
}

@doc("The parameters that can be provided when updating workbook template.")
model WorkbookTemplateUpdateParameters {
  @doc("Resource tags")
  tags?: Record<string>;

  @doc("Metadata describing a workbook for an Azure resource.")
  properties?: WorkbookTemplateProperties;
}

@doc("Properties that contain a private workbook.")
model MyWorkbookProperties {
  @doc("The user-defined name of the private workbook.")
  displayName: string;

  @doc("Configuration of this particular private workbook. Configuration data is a string containing valid JSON")
  serializedData: string;

  @doc("This instance's version of the data model. This can change as new features are added that can be marked private workbook.")
  version?: string;

  @doc("Date and time in UTC of the last modification that was made to this private workbook definition.")
  @visibility("read")
  timeModified?: string;

  @doc("Workbook category, as defined by the user at creation time.")
  category: string;

  @doc("A list of 0 or more tags that are associated with this private workbook definition")
  tags?: string[];

  @doc("Unique user id of the specific user that owns this private workbook.")
  @visibility("read")
  userId?: string;

  @doc("Optional resourceId for a source resource.")
  sourceId?: string;

  @doc("BYOS Storage Account URI")
  storageUri?: string;
}

@doc("An azure resource object")
model MyWorkbookResource {
  @doc("Identity used for BYOS")
  identity?: MyWorkbookManagedIdentity;

  @doc("Azure resource Id")
  @visibility("read", "create")
  id?: string;

  @doc("Azure resource name")
  @visibility("read", "create")
  name?: string;

  @doc("Azure resource type")
  @visibility("read", "create")
  type?: string;

  @doc("Resource location")
  @visibility("read", "create")
  location?: string;

  @doc("Resource tags")
  tags?: Record<string>;

  @doc("Resource etag")
  etag?: Record<string>;
}

@doc("Customer Managed Identity")
model MyWorkbookManagedIdentity {
  @doc("Customer Managed Identity")
  userAssignedIdentities?: MyWorkbookUserAssignedIdentities;

  @doc("The identity type.")
  type?: MyWorkbookManagedIdentityType;
}

@doc("Customer Managed Identity")
model MyWorkbookUserAssignedIdentities {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;
}

@doc("Error response.")
@error
model MyWorkbookError {
  @doc("The error details.")
  error?: ErrorDefinition;
}

@doc("Error definition.")
model ErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("Internal error details.")
  @visibility("read")
  innererror?: unknown;
}

@doc("Properties that contain a workbook.")
model WorkbookProperties {
  @doc("The user-defined name (display name) of the workbook.")
  displayName: string;

  @doc("Configuration of this particular workbook. Configuration data is a string containing valid JSON")
  serializedData: string;

  @doc("Workbook schema version format, like 'Notebook/1.0', which should match the workbook in serializedData")
  version?: string;

  @doc("Date and time in UTC of the last modification that was made to this workbook definition.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  @doc("Workbook category, as defined by the user at creation time.")
  category: string;

  @doc("Being deprecated, please use the other tags field")
  tags?: string[];

  @doc("Unique user id of the specific user that owns this workbook.")
  @visibility("read")
  userId?: string;

  @doc("ResourceId for a source resource.")
  sourceId?: string;

  @doc("The resourceId to the storage account when bring your own storage is used")
  storageUri?: string;

  @doc("The description of the workbook.")
  description?: string;

  @doc("The unique revision id for this workbook definition")
  @visibility("read")
  revision?: string;
}

@doc("An azure resource object")
model WorkbookResource extends TrackedResource {
  @doc("Identity used for BYOS")
  identity?: WorkbookResourceIdentity;

  @doc("The kind of workbook. Only valid value is shared.")
  kind?: WorkbookSharedTypeKind;

  @doc("Resource etag")
  etag?: string;
}

@doc("Identity used for BYOS")
model WorkbookResourceIdentity extends ManagedServiceIdentity {}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Error response.")
@error
model WorkbookError {
  @doc("The error details.")
  error?: WorkbookErrorDefinition;
}

@doc("Error definition.")
model WorkbookErrorDefinition {
  @doc("Service specific error code which serves as the substatus for the HTTP error code.")
  @visibility("read")
  code?: string;

  @doc("Description of the error.")
  @visibility("read")
  message?: string;

  @doc("Internal error details.")
  @visibility("read")
  innererror?: WorkbookInnerErrorTrace;
}

@doc("Error details")
model WorkbookInnerErrorTrace {
  @doc("detailed error trace")
  @visibility("read")
  trace?: string[];
}

@doc("The parameters that can be provided when updating workbook properties properties.")
model WorkbookUpdateParameters {
  @doc("The kind of workbook. Only valid value is shared.")
  kind?: WorkbookUpdateSharedTypeKind;

  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  @doc("Metadata describing a workbook for an Azure resource.")
  properties?: WorkbookPropertiesUpdateParameters;
}

@doc("Properties that contain a workbook for PATCH operation.")
model WorkbookPropertiesUpdateParameters {
  @doc("The user-defined name (display name) of the workbook.")
  displayName?: string;

  @doc("Configuration of this particular workbook. Configuration data is a string containing valid JSON")
  serializedData?: string;

  @doc("Workbook category, as defined by the user at creation time.")
  category?: string;

  @doc("A list of 0 or more tags that are associated with this workbook definition")
  tags?: string[];

  @doc("The description of the workbook.")
  description?: string;

  @doc("The unique revision id for this workbook definition")
  revision?: string;
}

@doc("The response to a live token query.")
model LiveTokenResponse {
  @doc("JWT token for accessing live metrics stream data.")
  @visibility("read")
  liveToken?: string;
}

@error
model ErrorResponseLinkedStorage {
  @doc("Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.")
  error?: ErrorResponseLinkedStorageError;
}

@doc("Error response indicates Insights service is not able to process the incoming request. The reason is provided in the error message.")
model ErrorResponseLinkedStorageError {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;
}

@doc("An Application Insights component linked storage account")
model LinkedStorageAccountsProperties {
  @doc("Linked storage account resource ID")
  linkedStorageAccount?: string;
}

@doc("An Application Insights component linked storage accounts patch")
model ComponentLinkedStorageAccountsPatch {
  @doc("The properties of the linked storage accounts.")
  properties?: LinkedStorageAccountsProperties;
}

@doc("Error details")
model InnerErrorTrace {
  @doc("detailed error trace")
  @visibility("read")
  trace?: string[];
}

@doc("Result of the List Operations operation")
model OperationsListResult {
  @doc("A collection of operations")
  value?: OperationLive[];

  @doc("URL to get the next set of operation list results if there are any.")
  nextLink?: string;
}

@doc("Represents an operation returned by the GetOperations request")
model OperationLive {
  @doc("Name of the operation")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display name of the operation")
  display?: OperationInfo;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Properties of the operation")
  properties?: Record<unknown>;
}

@doc("Information about an operation")
model OperationInfo {
  @doc("Name of the provider")
  provider?: string;

  @doc("Name of the resource type")
  resource?: string;

  @doc("Name of the operation")
  operation?: string;

  @doc("Description of the operation")
  description?: string;
}
